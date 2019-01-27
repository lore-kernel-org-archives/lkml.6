Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D68C4151A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32AC2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548622958;
	bh=c3hW+dPqgaoN9a/2oD0euyB0uanoQ1Yp/JlCxiNgVWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nGZVxIKb2RkVlB3U1Cm7cos7/n0Xp97A1i1zngqRIfT2jN/VNLjvMwvUDXjKZUqbd
	 MzpfOrUbX9MLmBiHdjbyGwV1LJTDel4SYfVDgGHoE5rrMv6At1mlv6+MautsNpnIF4
	 /IY4B5R4ceMtLTyEr9k00Vd7wlpS/J+P3aj/ppoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfA0VCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:02:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfA0VCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:02:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7392087F;
        Sun, 27 Jan 2019 21:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548622956;
        bh=c3hW+dPqgaoN9a/2oD0euyB0uanoQ1Yp/JlCxiNgVWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Db329RJYn9glo09um96uMa8bzsXar+geHkgfHcCMmjMJ4GSvqv3pO2bVNDCk+8Mnn
         LvhwGXp3jVLpb0HEw/FeLiWR4CjzFT8IUTSP8ohIpmvDi0J28gan9Bakq2Uy7ZCDuw
         Wdv+e6HKy/c6DN7EN4RuIsHq1am7B33ChLe/FBK0=
Date:   Sun, 27 Jan 2019 22:02:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioan-Adrian Ratiu <adi@adirat.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RFC][PATCH] Revert "ARM: dts: bcm2837: Fix polarity of wifi
 reset GPIOs"
Message-ID: <20190127210233.GA31748@kroah.com>
References: <20190127202813.29493-1-adi@adirat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127202813.29493-1-adi@adirat.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 10:28:13PM +0200, Ioan-Adrian Ratiu wrote:
> This reverts commit bea8a160c621d19f7f78b13e14e03f4b8e44cd4b.
> 
> Contrary to what the commit message says, on my rpi 3 b v1.2 changing
> the polarity causes the exact behaviour this commit intends to fix, as
> described at the referenced link below (wlan0 disapears).
> 
> With reset-gpios = ... GPIO_ACTIVE_HIGH, brcmfmac errors in dmesg:
> 
> [    7.977512] brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
> [    7.977623] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.978007] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.978377] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.978724] brcmfmac: brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
> [    7.978734] brcmfmac: brcmf_proto_bcdc_query_dcmd: brcmf_proto_bcdc_msg failed w/status -110
> [    7.978747] brcmfmac: brcmf_cfg80211_get_channel: chanspec failed (-110)
> [    7.982817] brcmfmac: brcmf_sdio_bus_sleep: error while changing bus sleep state -110
> [    7.982880] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> [    7.983255] brcmfmac: brcmf_sdio_txfail: sdio error, abort command and terminate frame
> 
> The only solution I currently have is to revert and everything works
> as expected and as before changing the polarity.
> 
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=911443
> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
> ---
>  arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 +-
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
