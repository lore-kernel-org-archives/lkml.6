Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52804C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CC5222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j+GlGmMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404638AbfBMRrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:47:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404554AbfBMRql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q/GsTlT+ECFpftqfq5k/mQtxX2EW5CCRqGhMzVEtitc=; b=j+GlGmMrZEMKKkxVGVeWrOeCNf
        OpvdrArdcf4v2LZLSf8deFfFDjNklkFFvoMrGpyc6bh0ARkbv9TC+LEpMnFI7zyTEVyR+jJXBdWEO
        WjebbfBh/vKLmC+YhE4I8h8MDF1llpL4RWEDnfZwipht7XoE+dQs2ffjzZG34cnAbssJTfldObG+D
        yAJ1JnHattAnJAB3xPtzpm6CmdyI60v8334Cn3z8QQi+Ykgh5PLV2TR0Kn1d3Pj1WyZvMLARh3FSA
        BYGLda+8yUMBdyuJ4+JmotBhqZDG5uyVi2R6iUU0mkH8nTotRR0mvr/fcBbHawpNMWaV5OLjeUV2l
        Hs+Op+pg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyc8-0006cs-PL; Wed, 13 Feb 2019 17:46:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] initramfs: cleanup initrd freeing
Date:   Wed, 13 Feb 2019 18:46:16 +0100
Message-Id: <20190213174621.29297-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor the kexec logic into a separate helper, and then inline the
rest of free_initrd into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 53 +++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 1cba6bbeeb75..6c2ed1d7276e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -518,37 +518,35 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
-static void __init free_initrd(void)
-{
 #ifdef CONFIG_KEXEC_CORE
+static bool kexec_free_initrd(void)
+{
 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
-#endif
-	if (do_retain_initrd)
-		goto skip;
 
-#ifdef CONFIG_KEXEC_CORE
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (initrd_start < crashk_end && initrd_end > crashk_start) {
-		/*
-		 * Initialize initrd memory region since the kexec boot does
-		 * not do.
-		 */
-		memset((void *)initrd_start, 0, initrd_end - initrd_start);
-		if (initrd_start < crashk_start)
-			free_initrd_mem(initrd_start, crashk_start);
-		if (initrd_end > crashk_end)
-			free_initrd_mem(crashk_end, initrd_end);
-	} else
-#endif
-		free_initrd_mem(initrd_start, initrd_end);
-skip:
-	initrd_start = 0;
-	initrd_end = 0;
+	if (initrd_start >= crashk_end || initrd_end <= crashk_start)
+		return false;
+
+	/*
+	 * Initialize initrd memory region since the kexec boot does not do.
+	 */
+	memset((void *)initrd_start, 0, initrd_end - initrd_start);
+	if (initrd_start < crashk_start)
+		free_initrd_mem(initrd_start, crashk_start);
+	if (initrd_end > crashk_end)
+		free_initrd_mem(crashk_end, initrd_end);
+	return true;
 }
+#else
+static inline bool kexec_free_initrd(void)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_CORE */
 
 #define BUF_SIZE 1024
 static void __init clean_rootfs(void)
@@ -642,7 +640,16 @@ static int __init populate_rootfs(void)
 		}
 #endif
 	}
-	free_initrd();
+
+	/*
+	 * If the initrd region is overlapped with crashkernel reserved region,
+	 * free only memory that is not part of crashkernel region.
+	 */
+	if (!do_retain_initrd && !kexec_free_initrd())
+		free_initrd_mem(initrd_start, initrd_end);
+	initrd_start = 0;
+	initrd_end = 0;
+
 	flush_delayed_fput();
 	return 0;
 }
-- 
2.20.1

