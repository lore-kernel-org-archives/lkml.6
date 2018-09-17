Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D84FECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A31F214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A31F214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbeIREnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:43:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeIREnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:43:18 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F032C707;
        Mon, 17 Sep 2018 23:13:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Pittman <jpittman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 129/158] dm cache: only allow a single io_mode cache feature to be requested
Date:   Tue, 18 Sep 2018 00:42:39 +0200
Message-Id: <20180917211717.143081266@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Pittman <jpittman@redhat.com>

[ Upstream commit af9313c32c0fa2a0ac3b113669273833d60cc9de ]

More than one io_mode feature can be requested when creating a dm cache
device (as is: last one wins).  The io_mode selections are incompatible
with one another, we should force them to be selected exclusively.  Add
a counter to check for more than one io_mode selection.

Fixes: 629d0a8a1a10 ("dm cache metadata: add "metadata2" feature")
Signed-off-by: John Pittman <jpittman@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-cache-target.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2250,7 +2250,7 @@ static int parse_features(struct cache_a
 		{0, 2, "Invalid number of cache feature arguments"},
 	};
 
-	int r;
+	int r, mode_ctr = 0;
 	unsigned argc;
 	const char *arg;
 	struct cache_features *cf = &ca->features;
@@ -2264,14 +2264,20 @@ static int parse_features(struct cache_a
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
@@ -2282,6 +2288,11 @@ static int parse_features(struct cache_a
 		}
 	}
 
+	if (mode_ctr > 1) {
+		*error = "Duplicate cache io_mode features requested";
+		return -EINVAL;
+	}
+
 	return 0;
 }
 


