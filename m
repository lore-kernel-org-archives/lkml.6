Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B401AC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D0720657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D0720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeKBH62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:58:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59023 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeKBH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:58:28 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gILqC-0003Iu-Lk; Thu, 01 Nov 2018 22:53:29 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH] lockdown: allow kexec_file of unsigned images when not under lockdown
Date:   Thu,  1 Nov 2018 19:53:16 -0300
Message-Id: <20181101225316.18112-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_KEXEC_VERIFY_SIG is enabled, kexec -s with an unsigned image will
fail requiring an image signed with a trusted key. However, that same
kernel will allow kexec to load and boot a kernel, if kexec_file_load is
not used.

Now, lockdown brings a solution to this inconsistency. However, as it is,
it will still prevent an unsigned image to be loaded with kexec -s when the
system is not under lockdown, while still allowing kexec to work.

At the same time, with lockdown, kexec_file_load would still work when
CONFIG_KEXEC_VERIFY_SIG is disabled.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 kernel/kexec_file.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 35cf0ad29718..b64f32fda9ca 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -211,10 +211,17 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 					   image->kernel_buf_len);
 	if (ret) {
 		pr_debug("kernel signature verification failed.\n");
-		goto out;
+	} else {
+		pr_debug("kernel signature verification successful.\n");
 	}
-	pr_debug("kernel signature verification successful.\n");
+#elif
+	ret = -EPERM;
 #endif
+	if (ret && kernel_is_locked_down("kexec of unsigned images"))
+		goto out;
+	else
+		ret = 0;
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
-- 
2.19.1

