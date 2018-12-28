Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76AD20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545994313;
	bh=YMD8Y7qqjN5YLGBGcAL0Ti831VhaFHn4+KG/ablm9gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TODoNH2afuGwyJ5Qm1HvXmpWenZHSuHKovNMmMuTbpmmecpTetA2DxtWaE/bZQprf
	 XrxoUo3bHZJq41mFrNQ++JxGSkMO/SbFuALasPcb07CGJLM8CKCaPxEd1I0dPodijW
	 Il12a/RomhgTc/VaYrWXKe+pCB28IEppmAYkNZhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbeL1Kvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730058AbeL1Kvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:51:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C2120855;
        Fri, 28 Dec 2018 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545994310;
        bh=YMD8Y7qqjN5YLGBGcAL0Ti831VhaFHn4+KG/ablm9gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfQqfC6wDH1rs0tiGXLXjw4PvxxUj4w/Q+sSFlWKXHZDpfQs6uiF6RMESacyFBLjA
         dUxO7QBLsBQ1Z2U4A/PjqCwnodLl4PMqgHUkMdoES8394iTFr4J/jbnG67xNl9TS+A
         kFwj9JkvTGATNX5A5uHq+sTNry1XGd+v35hnRSsM=
Date:   Fri, 28 Dec 2018 11:51:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] usb: devio: update max count of DPs per interval for ISOC
Message-ID: <20181228105148.GA22073@kroah.com>
References: <1545992864-9530-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545992864-9530-1-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 06:27:44PM +0800, Chunfeng Yun wrote:
> The host shall be able to accept and send up to 96 DPs for
> devices operating at Gen 2 speed.

Why?  What is this keeping from working properly today?

I need a much better changelog text here in order to be able to accept
this patch.

> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/core/devio.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index a75bc0b8a50f..82c16210e34c 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -1564,12 +1564,10 @@ static int proc_do_submiturb(struct usb_dev_state *ps, struct usbdevfs_urb *uurb
>  		}
>  		for (totlen = u = 0; u < number_of_packets; u++) {
>  			/*
> -			 * arbitrary limit need for USB 3.0
> -			 * bMaxBurst (0~15 allowed, 1~16 packets)
> -			 * bmAttributes (bit 1:0, mult 0~2, 1~3 packets)
> -			 * sizemax: 1024 * 16 * 3 = 49152
> +			 * arbitrary limit need for USB 3.1 Gen2
> +			 * sizemax: 96 DPs at SSP, 96 * 1024 = 98304
>  			 */
> -			if (isopkt[u].length > 49152) {
> +			if (isopkt[u].length > 98304) {

Are we going to have to keep bumping this up as speeds get faster and
faster?

thanks,

greg k-h
