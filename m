Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3266C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E74C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="K8Ia9qsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E74C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbeG0JCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:02:31 -0400
Received: from 8bytes.org ([81.169.241.247]:32836 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729445AbeG0JCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:02:31 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1B36B25A; Fri, 27 Jul 2018 09:41:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532677313; bh=5fNy9WJLM20ClCpqC8t1dGhy/jtYxpMBE27+rfeeXA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8Ia9qsrTMjnvy/tAJLj9zAIiRS9FP8KTNZ5H/qTt+LlJqQ18v3+VABoLDfDO+2pD
         Q6+FxF7+aZeSi0aamLHCh0/8GpLYomNNQ5ofoamIH2zoX2HOUtEecICln9jxFz2dSG
         qpTj37kR4aJyisHQYTqQH64aTpoTzUos677K9ElIQoYOnWTt+CPv5fzBRXPf8pJ/nX
         CRBcpEXWEpgQcgu3zvAYsUmX99gZtEOsjP0yyxqsIxNgcXQl/uHU0B0s8wIKCoWnBm
         8+rJC+N05hyk0lV/LP6Hg4Sj/RzpNEB9knuCoZrdYZaMZnbMEGGknft3g8zuCjX0ke
         JBrX98deQbu0w==
Date:   Fri, 27 Jul 2018 09:41:52 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix allocation in atomic context
Message-ID: <20180727074152.bmso3y4lr53ixo2f@8bytes.org>
References: <20180720161659.29800-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720161659.29800-1-geert+renesas@glider.be>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 06:16:59PM +0200, Geert Uytterhoeven wrote:
> When attaching a device to an IOMMU group with
> CONFIG_DEBUG_ATOMIC_SLEEP=y:
> 
>     BUG: sleeping function called from invalid context at mm/slab.h:421
>     in_atomic(): 1, irqs_disabled(): 128, pid: 61, name: kworker/1:1
>     ...
>     Call trace:
>      ...
>      arm_lpae_alloc_pgtable+0x114/0x184
>      arm_64_lpae_alloc_pgtable_s1+0x2c/0x128
>      arm_32_lpae_alloc_pgtable_s1+0x40/0x6c
>      alloc_io_pgtable_ops+0x60/0x88
>      ipmmu_attach_device+0x140/0x334
> 
> ipmmu_attach_device() takes a spinlock, while arm_lpae_alloc_pgtable()
> allocates memory using GFP_KERNEL.  Originally, the ipmmu-vmsa driver
> had its own custom page table allocation implementation using
> GFP_ATOMIC, hence the spinlock was fine.
> 
> Fix this by replacing the spinlock by a mutex, like the arm-smmu driver
> does.
> 
> Fixes: f20ed39f53145e45 ("iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied, thanks.

