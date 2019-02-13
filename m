Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0450FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6C5222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PC0tXF87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404570AbfBMRqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:46:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391128AbfBMRqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BQw99tH11D4Psdp+C10nNaKh7Npv1/BdP3rwuJ1L/lY=; b=PC0tXF87R/V9iw6qGhuVO3esea
        CcjsC7X+SdSz7Bxxf/NyWSDtWTft0xTNQGkdfjtppDQgBofPdXPTYOap+FMX9vsjU/cbU217D7ady
        ZOz0q/nGrV8SFf4ZuOPklMxRIoIj18hbZi7KJk3d4rWFyqeqVWylAERdx7BI40awG35quaiQPEVjt
        H9REOlJWN7zBsyL4mgWwaBhQJnYMD6wizSf1fSQkyEpVe8u4IXhXPlgdq6pC5kQttpVdpz1GZsabE
        t4gSQ6rY2vtmg+eWQVgsuEkw+BsJsjfT7rtTflqYb+sPzJa4EifzT+A3eKVxJBQfrxVLSJg3v6FBO
        GCd2vPhA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtycB-0006gW-B2; Wed, 13 Feb 2019 17:46:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] initramfs: factor out a helper to populate the initrd image
Date:   Wed, 13 Feb 2019 18:46:17 +0100
Message-Id: <20190213174621.29297-5-hch@lst.de>
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

This will allow for cleaner code sharing in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6c2ed1d7276e..c2e9a8845e98 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -595,6 +595,28 @@ static void __init clean_rootfs(void)
 	kfree(buf);
 }
 
+#ifdef CONFIG_BLK_DEV_RAM
+static void populate_initrd_image(char *err)
+{
+	ssize_t written;
+	int fd;
+
+	unpack_to_rootfs(__initramfs_start, __initramfs_size);
+
+	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
+			err);
+	fd = ksys_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
+	if (fd < 0)
+		return;
+
+	written = xwrite(fd, (char *)initrd_start, initrd_end - initrd_start);
+	if (written != initrd_end - initrd_start)
+		pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
+		       written, initrd_end - initrd_start);
+	ksys_close(fd);
+}
+#endif /* CONFIG_BLK_DEV_RAM */
+
 static int __init populate_rootfs(void)
 {
 	/* Load the built in initramfs */
@@ -604,7 +626,6 @@ static int __init populate_rootfs(void)
 	/* If available load the bootloader supplied initrd */
 	if (initrd_start && !IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
 #ifdef CONFIG_BLK_DEV_RAM
-		int fd;
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
 		err = unpack_to_rootfs((char *)initrd_start,
 			initrd_end - initrd_start);
@@ -612,22 +633,7 @@ static int __init populate_rootfs(void)
 			goto done;
 
 		clean_rootfs();
-		unpack_to_rootfs(__initramfs_start, __initramfs_size);
-
-		printk(KERN_INFO "rootfs image is not initramfs (%s)"
-				"; looks like an initrd\n", err);
-		fd = ksys_open("/initrd.image",
-			      O_WRONLY|O_CREAT, 0700);
-		if (fd >= 0) {
-			ssize_t written = xwrite(fd, (char *)initrd_start,
-						initrd_end - initrd_start);
-
-			if (written != initrd_end - initrd_start)
-				pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
-				       written, initrd_end - initrd_start);
-
-			ksys_close(fd);
-		}
+		populate_initrd_image(err);
 	done:
 		/* empty statement */;
 #else
-- 
2.20.1

