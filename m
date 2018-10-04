Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055A4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985912083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4lV5Zpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985912083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJEAka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:40:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36496 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeJEAka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:40:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so10857177wrw.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OzoRTxYBLACAnCY2+UUdXOVE6XnKNsyyzO6S0yIWaO0=;
        b=K4lV5Zpuh2Ff5Qny4d1dJsfsRS52KnEcQcd2KV6LqazWZXxd4VKKkMFfdxDBur44m2
         9319fqJrzd7oP9aZGCk8da+oyERNrg6YfywjDgY2litJTms2gym6hU9dtFrrp4cABB/L
         L9+M27g7NftV9tttfaFUEsbbup2ohP9SMU6XqjoEwRmoS+5kRneGeM228O/dVLSRDblx
         gnsKCP3bA0J8sg7QXcW6GbgOr/V0204hW+mw6J4v8P/f34WzfqNIqhQaey5U08zR1D3J
         Zy+JEXO1BwQp4y3Z5uEOf0FeI54oGuwMfnTPS/v+zxofPAW40DO8JFF2nKilKp1Ena/f
         kl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OzoRTxYBLACAnCY2+UUdXOVE6XnKNsyyzO6S0yIWaO0=;
        b=IdWdVBukgSJls/Ogv17+VPAhtIi2nDgRGy4hATyQaSXnyCZE2PWiDkEoh1VFyTKFGs
         st0FdfpMhk3Wtu4dui9UFHV/CXlUte6MX4tAPNEl05uZGza/2Gor9uKOLpnd1owqshWx
         11CYtrqFphRFI9X++Y/WmkCGAQ3kGfEFQULlTawtR0oyTC0cP/AiGeCLN131Q7/+FApT
         ohAW65+AspCROIdBsQg9uIxsHc54sIIUFgA1Ajt72/WbEoiK/3Ty6yd6SNWg1rpI4zlJ
         I19/if6qOepvjtX2ah5yzTKNKHEPxbORIRSTqk4nS0XNP3VenPo/QkFwZkXCn3sMyPPp
         ZhPA==
X-Gm-Message-State: ABuFfoiRtio5A5zKZ/ykdMGZ4gycMPeQFLz8ynRJxdf+FnXSngMCmGwu
        WZG5+GpFB94TIjRgzpkSTGNfAqAEj0A=
X-Google-Smtp-Source: ACcGV62vx6DFmTJ4e+nQtF7AQVWrVR0Y9pruVJdFWX0DPx44MyKvubMHJPu5mh6FXzyLdUouGQF7eQ==
X-Received: by 2002:adf:e403:: with SMTP id g3-v6mr5376616wrm.96.1538675169439;
        Thu, 04 Oct 2018 10:46:09 -0700 (PDT)
Received: from minipc.home ([2a00:23c4:911f:4500:a5ab:58b7:ec39:bb8])
        by smtp.gmail.com with ESMTPSA id p8sm5028131wrx.9.2018.10.04.10.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 10:46:08 -0700 (PDT)
Date:   Thu, 4 Oct 2018 18:52:25 +0100
From:   Laurence Rochfort <laurence.rochfort@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gasket: Fix sparse "incorrect type in assignment"
 warnings.
Message-ID: <20181004175225.GA22487@minipc.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence the below sparse warnings by casting betwen u8 __iomem *, and
void *.

warning: incorrect type in assignment (different address spaces)
   expected unsigned char [noderef] [usertype] <asn:2>*virt_base
   got void *[assigned] mem
warning: incorrect type in argument 3 (different address spaces)
   expected void *cpu_addr
   got unsigned char [noderef] [usertype] <asn:2>*virt_base

Signed-off-by: Laurence Rochfort <laurence.rochfort@gmail.com>
---
 drivers/staging/gasket/gasket_page_table.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index d4c5f8a..7f5e5b3 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1278,7 +1278,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 				 dma_addr_t *dma_address, u64 index)
 {
 	dma_addr_t handle;
-	void *mem;
+	u8 __iomem *mem;
 	int j;
 	unsigned int num_pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
 	const struct gasket_driver_desc *driver_desc =
@@ -1290,7 +1290,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	if (num_pages == 0)
 		return -EINVAL;
 
-	mem = dma_alloc_coherent(gasket_get_device(gasket_dev),
+	mem = (u8 __iomem *)dma_alloc_coherent(gasket_get_device(gasket_dev),
 				 num_pages * PAGE_SIZE, &handle, 0);
 	if (!mem)
 		goto nomem;
@@ -1325,7 +1325,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 nomem:
 	if (mem) {
 		dma_free_coherent(gasket_get_device(gasket_dev),
-				  num_pages * PAGE_SIZE, mem, handle);
+				  num_pages * PAGE_SIZE, (void __force *)mem, handle);
 	}
 
 	if (gasket_dev->page_table[index]->coherent_pages) {
@@ -1353,7 +1353,7 @@ int gasket_free_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	if (gasket_dev->coherent_buffer.length_bytes) {
 		dma_free_coherent(gasket_get_device(gasket_dev),
 				  gasket_dev->coherent_buffer.length_bytes,
-				  gasket_dev->coherent_buffer.virt_base,
+				  (void __force *)gasket_dev->coherent_buffer.virt_base,
 				  gasket_dev->coherent_buffer.phys_base);
 		gasket_dev->coherent_buffer.length_bytes = 0;
 		gasket_dev->coherent_buffer.virt_base = NULL;
@@ -1372,7 +1372,7 @@ void gasket_free_coherent_memory_all(
 	if (gasket_dev->coherent_buffer.length_bytes) {
 		dma_free_coherent(gasket_get_device(gasket_dev),
 				  gasket_dev->coherent_buffer.length_bytes,
-				  gasket_dev->coherent_buffer.virt_base,
+				  (void __force *)gasket_dev->coherent_buffer.virt_base,
 				  gasket_dev->coherent_buffer.phys_base);
 		gasket_dev->coherent_buffer.length_bytes = 0;
 		gasket_dev->coherent_buffer.virt_base = NULL;
-- 
2.9.5

