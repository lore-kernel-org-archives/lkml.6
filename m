Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E0FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0503620989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298239;
	bh=ixqLGgo4k9p2B1Ivn8vaq8wMAfL2FGf9goGHf7k5jjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLO+Z7meCc/qy5NI+Z+FhqBJOGJbGLcLo6kjbZ/2c9MtLHbe2Fhc2lAXJgDl7viyd
	 2TCKVHNkgCiIkL0ai8cP3MH7+i1p7CKoSQoQrBegYHkzdu8dzrh04v7I4XkPh7y5Xa
	 aJJQ52v7X9gLh8QCMaPyVuK6fRBCMfeYIj2ORr0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbeLTJah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732954AbeLTJae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D837520989;
        Thu, 20 Dec 2018 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298234;
        bh=ixqLGgo4k9p2B1Ivn8vaq8wMAfL2FGf9goGHf7k5jjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7LkjNLWAA6Q6Px1u+U5PbmpwcVMy1Ap0HOudothnhglu9x9SkoT14nypnOSIDPWW
         wamEpvnL0OCa31j83SJXFnMTfClTQXdAznV+6yYnAHltlquOipnoU+vwMJH5L8y9wk
         bAJCevemqnQH2Bmo+Achh3zOJ5jbqbfBVBNPEEoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Jones <nathanj439@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 49/67] ARM: 8816/1: dma-mapping: fix potential uninitialized return
Date:   Thu, 20 Dec 2018 10:19:01 +0100
Message-Id: <20181220085905.489226502@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit c2a3831df6dc164af66d8d86cf356a90c021b86f ]

While trying to use the dma_mmap_*() interface, it was noticed that this
interface returns strange values when passed an incorrect length.

If neither of the if() statements fire then the return value is
uninitialized. In the worst case it returns 0 which means the caller
will think the function succeeded.

Fixes: 1655cf8829d8 ("ARM: dma-mapping: Remove traces of NOMMU code")
Signed-off-by: Nathan Jones <nathanj439@gmail.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 66566472c153..1cb9c0f9b5d6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -830,7 +830,7 @@ static int __arm_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
-	int ret;
+	int ret = -ENXIO;
 	unsigned long nr_vma_pages = vma_pages(vma);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = dma_to_pfn(dev, dma_addr);
-- 
2.19.1



