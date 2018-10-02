Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD18C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29707206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29707206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeJBVN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:13:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:13:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B2A63001922
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 14:29:48 +0000 (UTC)
Received: from sansharm.bos.com (dhcp-17-34.bos.redhat.com [10.18.17.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1355D5C21A;
        Tue,  2 Oct 2018 14:29:47 +0000 (UTC)
From:   Sanskriti Sharma <sansharm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 4/5] perf tools: avoid double free in read_event_file()
Date:   Tue,  2 Oct 2018 10:29:13 -0400
Message-Id: <1538490554-8161-5-git-send-email-sansharm@redhat.com>
In-Reply-To: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
References: <1538490554-8161-1-git-send-email-sansharm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 02 Oct 2018 14:29:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temporary 'buf' buffer allocated in read_event_file() may be freed
twice.  Move the free() call to the common function exit point.

Fixes the following coverity complaints:

  Error: USE_AFTER_FREE (CWE-825):
  tools/perf/util/trace-event-read.c:309: double_free: Calling "free"
  frees pointer "buf" which has already been freed.

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
---
 tools/perf/util/trace-event-read.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 3dfc1db..6a0d0f2 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -297,10 +297,8 @@ static int read_event_file(struct tep_handle *pevent, char *sys,
 	}
 
 	ret = do_read(buf, size);
-	if (ret < 0) {
-		free(buf);
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = parse_event_file(pevent, buf, size, sys);
 	if (ret < 0)
-- 
1.8.3.1

