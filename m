Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188CCC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9F520861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548245895;
	bh=NeuDsS0OVy3+Ri+RiplV7k5Lp6RvyBQuzJB+RSICNRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j7JxXvghSdVhEHMK6OEtOIpDaJiMTF8Bs+ZIkfrvjJN/EInOboeXUhplmIQsw/Z9T
	 idKWEOV7beIHZiFVuikL4JoXnPF3fDd/SgL/M+TWhiY1FCPA32xeQQXplU5hFTXI/W
	 0GB8w3+/Ea0L9E3gBZuhCbS6sL2P7sJ7aeK4XSo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfAWMSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:18:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfAWMSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:18:14 -0500
Received: from localhost (unknown [106.200.229.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF31720861;
        Wed, 23 Jan 2019 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548245893;
        bh=NeuDsS0OVy3+Ri+RiplV7k5Lp6RvyBQuzJB+RSICNRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2LLZhpUqgwWX5T3ieq4dqEoHObIm3jwhGgEzxIjATPfClNAAMvmKMFcFTffiX5+ee
         oW/+NuTuMUV/X9qJUCQ0om8QZX9I4wD//zQZIqGU1ttcmInQCJ9I9jmSPJrVGIW/Hr
         7VBK2c1JThgeLyXNP/KXB+PpCWwrQr9lnB0xEyeM=
Date:   Wed, 23 Jan 2019 17:46:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     Ludovic.Desroches@microchip.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Message-ID: <20190123121641.GN4635@vkoul-mobl>
References: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
 <20190120110417.GS4635@vkoul-mobl>
 <450ee975-a603-cf89-0000-13156c1cb5e8@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450ee975-a603-cf89-0000-13156c1cb5e8@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-19, 14:38, Codrin.Ciubotariu@microchip.com wrote:
> On 20.01.2019 13:04, Vinod Koul wrote:
> > Hi Codrin,
> > 
> > On 17-01-19, 16:10, Codrin.Ciubotariu@microchip.com wrote:
> >> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> >>
> >> atchan->status is used for two things:
> >>   - pass channel interrupts status from interrupt handler to tasklet;
> >>   - channel information like whether it is cyclic or paused;
> >>
> >> Since these operations have nothing in common, this patch adds a
> >> different struct member to keep the interrupts status.
> >>
> >> Fixes a bug in which a channel is wrongfully reported as in use when
> >> trying to obtain a new descriptior for a previously used cyclic channel.
> > 
> > This looks reasonable but am unable to see how the bug is fixed. Perhaps
> > would be great to split the bug part (which can go to fixes) and remove
> > the reuse of variable as a subsequent patch..
> 
> Hi Vinod,
> 
> This patch is the fix, since it moves the operations on atchan->status, 
> in which the interrupt status register is saved, to a different member 
> (irq_status). The AT_XDMAC_CHAN_IS_CYCLIC and AT_XDMAC_CHAN_IS_PAUSED 
> bits have nothing in common with the interrupt status register.
> 
> The bug reproduces when a device_terminate_all() is called, 
> (AT_XDMAC_CHAN_IS_CYCLIC cleared on atchan->status) and then a late End 
> of Block interrupt arrives (AT_XDMAC_CIS_BIS), which sets bit 0 of 
> atchan->status. Bit 0 is also used for AT_XDMAC_CHAN_IS_CYCLIC, so when 
> a new descriptor for a cyclic transfer is created, the driver reports 
> the channel as in use:
> 
> if (test_and_set_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status)) {
> 	dev_err(chan2dev(chan), "channel currently used\n");
> 	return NULL;
> }
> 
> I can send v2 if you consider the commit message misleading.

Yes please, that would be better and pls add fixes as suggested by
Ludovic along with his ack

-- 
~Vinod
