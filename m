Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346E021873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151269;
	bh=LvSvg6ceVOCZ+NGlWBrOWPlNWN78/5FVe4kszi0xMp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NwtMuJoRCvFmgSUHwjesxBso/sfwnAsDqxicSATXbeRetItAVUvsm3ecoJhMT43KC
	 2TdEvGR0OtWadE4FyVkjGSCqoSP8qgHp06HXKd+LreJiQZnjy7WU73jbhcOk6EFFFw
	 XrGytb31laB2dzZahOfildMnJhiDzFz5r11GKFpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeLRQk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeLRQk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BF3218A2;
        Tue, 18 Dec 2018 16:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151255;
        bh=LvSvg6ceVOCZ+NGlWBrOWPlNWN78/5FVe4kszi0xMp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/TFkBQj+Ygi5WCUqBsF4o+32ETtf6IobrNjK+R9luI+uuam4GIqrqg3NsZFi4cJJ
         gbdIPWeYifXVDMc6hZh6gdfyhKTHG87a0sBr6XR0tJxHhNJq+tGGEDirIDKGzuliVU
         rnNFe5tHd4nV3H24bB3omoZubaqNx7Mq6y756S+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.19 13/44] arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing
Date:   Tue, 18 Dec 2018 17:39:25 +0100
Message-Id: <20181218163929.091027618@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

commit 3238c359acee4ab57f15abb5a82b8ab38a661ee7 upstream.

We need to invalidate the caches *before* clearing the buffer via the
non-cacheable alias, else in the worst case __dma_flush_area() may
write back dirty lines over the top of our nice new zeros.

Fixes: dd65a941f6ba ("arm64: dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag")
Cc: <stable@vger.kernel.org> # 4.18.x-
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/dma-mapping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -587,9 +587,9 @@ static void *__iommu_alloc_attrs(struct
 						   prot,
 						   __builtin_return_address(0));
 		if (addr) {
-			memset(addr, 0, size);
 			if (!coherent)
 				__dma_flush_area(page_to_virt(page), iosize);
+			memset(addr, 0, size);
 		} else {
 			iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
 			dma_release_from_contiguous(dev, page,


