Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B43EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E19222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WNJwYLVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404593AbfBMRqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:46:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404561AbfBMRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fTdHUPsgYRu4VneoajaxB1/e1nadjQ3WHuZL105MHUY=; b=WNJwYLVhSQl1R0/3jqf/I4YZNY
        hOjgUb5Fd0oKnOtL6U2GbrsZrqM+RLTi+gkXwZTbHuD6rPN1DtGjkl0FxIamC0O++xHvh3FAqXTxn
        LkHfHYNxmpgwmRlok7rtvWs31VllCpAFPsVPCDOhiwmeYugfSXaGBNUM3mEeRysJag3eb58o7DXlN
        nxcWjHweOwduHENFmeadafi5Gjql10SaL2euZZsZ0SQbJvVZyR/NmXq4F86h2CVoSs6iNwkfhxJCv
        WAdGAiI4nraWBAF749N3f/+NHlnupVRcz5Z2G78dPjoYqHmphoc6xj0D4ixjunMox31yfbCIUH7ya
        WENCLhxw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtycD-0006kA-Ph; Wed, 13 Feb 2019 17:46:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] initramfs: cleanup populate_rootfs
Date:   Wed, 13 Feb 2019 18:46:18 +0100
Message-Id: <20190213174621.29297-6-hch@lst.de>
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

The code for kernels that support ramdisks or not is mostly the
same.  Unify it by using an IS_ENABLED for the info message, and
moving the error message into a stub for populate_initrd_image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index c2e9a8845e98..c55e08f72fad 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -615,6 +615,11 @@ static void populate_initrd_image(char *err)
 		       written, initrd_end - initrd_start);
 	ksys_close(fd);
 }
+#else
+static void populate_initrd_image(char *err)
+{
+	printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
+}
 #endif /* CONFIG_BLK_DEV_RAM */
 
 static int __init populate_rootfs(void)
@@ -623,30 +628,22 @@ static int __init populate_rootfs(void)
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
 		panic("%s", err); /* Failed to decompress INTERNAL initramfs */
-	/* If available load the bootloader supplied initrd */
-	if (initrd_start && !IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
-#ifdef CONFIG_BLK_DEV_RAM
+
+	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
+		goto done;
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
-		err = unpack_to_rootfs((char *)initrd_start,
-			initrd_end - initrd_start);
-		if (!err)
-			goto done;
+	else
+		printk(KERN_INFO "Unpacking initramfs...\n");
 
+	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
+	if (err) {
 		clean_rootfs();
 		populate_initrd_image(err);
-	done:
-		/* empty statement */;
-#else
-		printk(KERN_INFO "Unpacking initramfs...\n");
-		err = unpack_to_rootfs((char *)initrd_start,
-			initrd_end - initrd_start);
-		if (err) {
-			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
-			clean_rootfs();
-		}
-#endif
 	}
 
+done:
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
-- 
2.20.1

