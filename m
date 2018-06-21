Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B5C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0682243F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0682243F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934007AbeFUVfm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:35:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933670AbeFUVfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:35:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EE1DFC159
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 21:35:39 +0000 (UTC)
Received: from dhcp145-120.rdu.redhat.com (ovpn-122-47.rdu2.redhat.com [10.10.122.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A92681117650;
        Thu, 21 Jun 2018 21:35:36 +0000 (UTC)
From:   John Pittman <jpittman@redhat.com>
To:     snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        loberman@redhat.com, John Pittman <jpittman@redhat.com>
Subject: [PATCH] dm cache: require io_mode cache feature selection to be mutually exclusive
Date:   Thu, 21 Jun 2018 17:35:33 -0400
Message-Id: <1529616933-11644-1-git-send-email-jpittman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 21 Jun 2018 21:35:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 21 Jun 2018 21:35:39 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpittman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to commit 629d0a8a1a10 ("dm cache metadata: add "metadata2" feature"),
when creating a dm cache device, more than one io_mode can be selected.
As the io_mode selections are incompatible with one another, we should 
force them to be selected exclusively.  Add simple ctr to check for 
more than one io_mode selection.

Signed-off-by: John Pittman <jpittman@redhat.com>
---
 drivers/md/dm-cache-target.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index ce14a3d..45e3bed 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2250,7 +2250,7 @@ static int parse_features(struct cache_args *ca, struct dm_arg_set *as,
 		{0, 2, "Invalid number of cache feature arguments"},
 	};
 
-	int r;
+	int r, mode_ctr = 0;
 	unsigned argc;
 	const char *arg;
 	struct cache_features *cf = &ca->features;
@@ -2264,14 +2264,20 @@ static int parse_features(struct cache_args *ca, struct dm_arg_set *as,
 	while (argc--) {
 		arg = dm_shift_arg(as);
 
-		if (!strcasecmp(arg, "writeback"))
+		if (!strcasecmp(arg, "writeback")) {
 			cf->io_mode = CM_IO_WRITEBACK;
+			mode_ctr++;
+		}
 
-		else if (!strcasecmp(arg, "writethrough"))
+		else if (!strcasecmp(arg, "writethrough")) {
 			cf->io_mode = CM_IO_WRITETHROUGH;
+			mode_ctr++;
+		}
 
-		else if (!strcasecmp(arg, "passthrough"))
+		else if (!strcasecmp(arg, "passthrough")) {
 			cf->io_mode = CM_IO_PASSTHROUGH;
+			mode_ctr++;
+		}
 
 		else if (!strcasecmp(arg, "metadata2"))
 			cf->metadata_version = 2;
@@ -2282,6 +2288,11 @@ static int parse_features(struct cache_args *ca, struct dm_arg_set *as,
 		}
 	}
 
+	if (mode_ctr > 1) {
+		*error = "Invalid number of cache io_mode features requested";
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.7.5

