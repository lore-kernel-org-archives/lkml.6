Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A7CC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992E42098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992E42098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeJCV7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:59:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:12865 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJCV7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:59:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 08:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="75106581"
Received: from gnu-4.sc.intel.com ([172.25.70.231])
  by fmsmga007.fm.intel.com with ESMTP; 03 Oct 2018 08:10:23 -0700
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] Fix compat_sys_preadv64v2/compat_sys_pwritev64v2
Date:   Wed,  3 Oct 2018 08:10:23 -0700
Message-Id: <20181003151023.26686-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update compat_sys_preadv64v2 and compat_sys_pwritev64v2 to handle the
offset argument == -1, which should use and update the the current file
offset.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 fs/read_write.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 153f8f690490..c1d183862c13 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1241,6 +1241,9 @@ COMPAT_SYSCALL_DEFINE5(preadv64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
+	if (pos == -1)
+		return do_compat_readv(fd, vec, vlen, flags);
+
 	return do_compat_preadv64(fd, vec, vlen, pos, flags);
 }
 #endif
@@ -1347,6 +1350,9 @@ COMPAT_SYSCALL_DEFINE5(pwritev64v2, unsigned long, fd,
 		const struct compat_iovec __user *,vec,
 		unsigned long, vlen, loff_t, pos, rwf_t, flags)
 {
+	if (pos == -1)
+		return do_compat_writev(fd, vec, vlen, flags);
+
 	return do_compat_pwritev64(fd, vec, vlen, pos, flags);
 }
 #endif
-- 
2.17.1

