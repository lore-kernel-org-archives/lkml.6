Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24C7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F9821A3B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="P0QppyQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F9821A3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbeHFXvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:51:12 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45382 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeHFXvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:51:12 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C43257;
        Mon,  6 Aug 2018 23:40:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1533591609;
        bh=wTgZmjIkEESRO1pRrhjgTKArOz4ueugGiH2JKoRENeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0QppyQYHUaTJjP3Sf0wxIB57quIaIkt5A2cH905hOajTo9+wlLcadsp3yn8DK6Ef
         3TBUeBMizhlgdSiBTw2J8P+ynlYXSYrBOBs68TTOcQ6hReVETRbL4YClA5fUDalhRx
         X12H/gMp+dXXHNTIvnDwSKi0X1iDC1OkHAcgDick=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        alan@linux.intel.com, kernel-hardening@lists.openwall.com,
        tglx@linutronix.de, Mauro Carvalho Chehab <mchehab@kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 14/19] [media] uvcvideo: prevent bounds-check bypass via speculative execution
Date:   Tue, 07 Aug 2018 00:40:52 +0300
Message-ID: <1624792.F9dcxCXkCx@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <151571806069.27429.6683179525235570687.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151571798296.27429.7166552848688034184.stgit@dwillia2-desk3.amr.corp.intel.com> <151571806069.27429.6683179525235570687.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch.

On Friday, 12 January 2018 02:47:40 EEST Dan Williams wrote:
> Static analysis reports that 'index' may be a user controlled value that
> is used as a data dependency to read 'pin' from the
> 'selector->baSourceID' array. In order to avoid potential leaks of
> kernel memory values, block speculative execution of the instruction
> stream that could issue reads based on an invalid value of 'pin'.
> 
> Based on an original patch by Elena Reshetova.
> 
> Laurent notes:
> 
>     "...as this is nowhere close to being a fast path, I think we can close
>     this potential hole as proposed in the patch"
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

What's the status of this series (and of this patch in particular) ?

> ---
>  drivers/media/usb/uvc/uvc_v4l2.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c
> b/drivers/media/usb/uvc/uvc_v4l2.c index 3e7e283a44a8..30ee200206ee 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -22,6 +22,7 @@
>  #include <linux/mm.h>
>  #include <linux/wait.h>
>  #include <linux/atomic.h>
> +#include <linux/nospec.h>
> 
>  #include <media/v4l2-common.h>
>  #include <media/v4l2-ctrls.h>
> @@ -809,8 +810,12 @@ static int uvc_ioctl_enum_input(struct file *file, void
> *fh, const struct uvc_entity *selector = chain->selector;
>  	struct uvc_entity *iterm = NULL;
>  	u32 index = input->index;
> +	__u8 *elem = NULL;
>  	int pin = 0;
> 
> +	if (selector)
> +		elem = array_ptr(selector->baSourceID, index,
> +				selector->bNrInPins);
>  	if (selector == NULL ||
>  	    (chain->dev->quirks & UVC_QUIRK_IGNORE_SELECTOR_UNIT)) {
>  		if (index != 0)
> @@ -820,8 +825,8 @@ static int uvc_ioctl_enum_input(struct file *file, void
> *fh, break;
>  		}
>  		pin = iterm->id;
> -	} else if (index < selector->bNrInPins) {
> -		pin = selector->baSourceID[index];
> +	} else if (elem) {
> +		pin = *elem;
>  		list_for_each_entry(iterm, &chain->entities, chain) {
>  			if (!UVC_ENTITY_IS_ITERM(iterm))
>  				continue;

-- 
Regards,

Laurent Pinchart



