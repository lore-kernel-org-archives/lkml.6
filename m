Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA01C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC8F222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gQxXEPxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404546AbfBMRqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:46:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfBMRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F4/kzC3jhV0MG/GU79iUnwgEUzLi55LAygewrfHKenM=; b=gQxXEPxPM3+F0T3U4GrV1QDT1/
        G8JSf7aTTJH0Wm8ThrbxnywTU+9gC3SCujimS7i+k4jV+0kYzkR9T5bE6J6qMz8R69EvvquZ+BYkC
        giznrEBe2MPuigbD81fsRbVr20J+tnbTCD2ElwFoZQRaBsSxAgXctZfP/N8afNaMWbw7KUg7rSgRw
        imGWvaU6BoLgo2suacMCl1aoWRUjEc3wL+ynJkG2OzcA1/4w/ENho5QWA85w7bGk3MwMH5GpzyUgv
        ndP++oI6sc5Np/qaIrkyzz5nJyTdWXsYisJPrpGx0Hv4i1uHeXZ3/u64uiafHU1uWuyMbE4k6j6Kx
        1YSxWilA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtyc6-0006aL-C8; Wed, 13 Feb 2019 17:46:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] initramfs: free initrd memory if opening /initrd.image fails
Date:   Wed, 13 Feb 2019 18:46:15 +0100
Message-Id: <20190213174621.29297-3-hch@lst.de>
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

We free the initrd memory for all successful or error cases except
for the case where opening /initrd.image fails, which looks like an
oversight.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7cea802d00ef..1cba6bbeeb75 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -610,13 +610,12 @@ static int __init populate_rootfs(void)
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
 		err = unpack_to_rootfs((char *)initrd_start,
 			initrd_end - initrd_start);
-		if (!err) {
-			free_initrd();
+		if (!err)
 			goto done;
-		} else {
-			clean_rootfs();
-			unpack_to_rootfs(__initramfs_start, __initramfs_size);
-		}
+
+		clean_rootfs();
+		unpack_to_rootfs(__initramfs_start, __initramfs_size);
+
 		printk(KERN_INFO "rootfs image is not initramfs (%s)"
 				"; looks like an initrd\n", err);
 		fd = ksys_open("/initrd.image",
@@ -630,7 +629,6 @@ static int __init populate_rootfs(void)
 				       written, initrd_end - initrd_start);
 
 			ksys_close(fd);
-			free_initrd();
 		}
 	done:
 		/* empty statement */;
@@ -642,9 +640,9 @@ static int __init populate_rootfs(void)
 			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 			clean_rootfs();
 		}
-		free_initrd();
 #endif
 	}
+	free_initrd();
 	flush_delayed_fput();
 	return 0;
 }
-- 
2.20.1

