Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270A7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF0F20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF0F20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeIFQSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:18:05 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2875 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeIFQSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:18:05 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75b9112bf546-093f3; Thu, 06 Sep 2018 19:42:55 +0800 (CST)
X-RM-TRANSID: 2ee75b9112bf546-093f3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25b9112be017-ee673;
        Thu, 06 Sep 2018 19:42:55 +0800 (CST)
X-RM-TRANSID: 2ee25b9112be017-ee673
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     dingxiang@cmss.chinamobile.com
Subject: [PATCH v2] perf tools: use PTR_ERR_OR_ZERO inetead of return code
Date:   Thu,  6 Sep 2018 19:42:51 +0800
Message-Id: <1536234171-15970-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use PTR_ERR_OR_ZERO for bpf__setup_stdout return code

v2: add macro PTR_ERR_OR_ZERO to err.h

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 tools/include/linux/err.h    | 7 +++++++
 tools/perf/util/bpf-loader.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 7a8b61a..0946496 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -52,4 +52,11 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
 	return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
 }
 
+static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
 #endif /* _LINUX_ERR_H */
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 47aac41..f9ae1a9 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1615,7 +1615,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
-	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
+	return PTR_ERR_OR_ZERO(evsel);
 }
 
 #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
-- 
1.9.1



