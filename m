Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E76C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F93214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F93214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbeHGN7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:59:32 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50632 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeHGN7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:59:31 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fn0QY-00060H-NA; Tue, 07 Aug 2018 13:45:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 2/2] iommu/rockchip: Move irq request past pm_runtime_enable
Date:   Tue, 07 Aug 2018 13:45:26 +0200
Message-ID: <2114757.JfhfUCyzvi@phil>
In-Reply-To: <20180807085406.3863-3-marc.zyngier@arm.com>
References: <20180807085406.3863-1-marc.zyngier@arm.com> <20180807085406.3863-3-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. August 2018, 10:54:06 CEST schrieb Marc Zyngier:
> Enabling the interrupt early, before power has been applied to the
> device, can result in an interrupt being delivered too early if:
> 
> - the IOMMU shares an interrupt with a VOP
> - the VOP has a pending interrupt (after a kexec, for example)
> 
> In these conditions, we end-up taking the interrupt without
> the IOMMU being ready to handle the interrupt (not powered on).
> 
> Moving the interrupt request past the pm_runtime_enable() call
> makes sure we can at least access the IOMMU registers. Note that
> this is only a partial fix, and that the VOP interrupt will still
> be screaming until the VOP driver kicks in, which advocates for
> a more synchronized interrupt enabling/disabling approach.
> 
> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


