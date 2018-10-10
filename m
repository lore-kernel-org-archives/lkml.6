Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F9FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFD821479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="s2C55WD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFD821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJJUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:19:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53880 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:19:20 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 58D186F;
        Wed, 10 Oct 2018 14:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539176234;
        bh=pmL6XteOp5TSXZrDx0tQJzlbmvJlIufybbRNtvZiBAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2C55WD9nv1CuWeAJOytNISTlPplrIY1XrN+PzQuK0PTldQrfKQNLsQu4Y/My1B4F
         5wsTb8Wt5svmvDHM6ItBU1f5csuY9RFAXZ9ce1apGbprBebfWIiOdgeGjUmgIk3mFM
         Yh2F9jSSlzi07GPV2ov2crHfDYQDLuGWI6Zzq4ac=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     kieran.bingham@ideasonboard.com, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        stern@rowland.harvard.edu, rogerq@ti.com
Subject: Re: [PATCH 0/6] usb: gadget: add mechanism to asynchronously validate data stage of ctrl out request
Date:   Wed, 10 Oct 2018 15:57:15 +0300
Message-ID: <64135795.5y2tiWKxvC@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181010024903.1633-1-paul.elder@ideasonboard.com>
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patches.

On Wednesday, 10 October 2018 05:48:57 EEST Paul Elder wrote:
> This patch series adds a mechanism to allow asynchronously validating
> the data stage of a control out request, and for stalling or suceeding
> the request accordingly. This mechanism is implemented for MUSB, and is
> used by UVC. At the same time, UVC packages the setup stage and data
> stage data together to send to userspace to save on a pair of context
> switches per control out request.
> 
> This patch series does change the userspace API. We however believe that
> it is justified because the current API is broken, and because it isn't
> being used (because it's broken).

I'd like to point out for the reviewers that it changes the API of the UVC 
gadget driver only, not any other USB gadget userspace API.

> The current API is broken such that it is subject to race conditions
> that cause fatal errors with a high frequency. This is actually what
> motivated this patch series in the first place. In the current API, not
> only is there no way to asynchronously validate the data stage of a
> control OUT request, but an empty buffer is expected to be provided to
> hold the data stage data -- which is more likely than not to be late.
> There is even a warning in musb_g_ep0_queue:
> 
> /* else for sequence #2 (OUT), caller provides a buffer
>  * before the next packet arrives.  deferred responses
>  * (after SETUP is acked) are racey.
>  */
> 
> This problem has never been reported in years, which is a sign that the
> API isn't used. Furthermore, the vendor kernels that we have seen using
> the UVC gadget driver (such as QC and Huawei) are heavily patched with
> local changes to the API. This corroborates the suspicion that the
> current mainline API is not being used.
> 
> Additionally, this API isn't meant to be used by generic applications,
> but by a dedicated userspace helper. uvc-gadget is one such example, but
> it has bitrotten and isn't compatible with the current kernel API. The
> fact that nobody has submitted patches nor complained for a long time
> again shows that it isn't being used.
> 
> The conclusion is that since the API hasn't been used for a long time,
> it is safe to fix it.
> 
> Paul Elder (6):
>   usb: uvc: include videodev2.h in g_uvc.h
>   usb: gadget: uvc: enqueue usb request in setup handler for control OUT
>   usb: gadget: uvc: package setup and data for control OUT requests
>   usb: gadget: add functions to signal udc driver to delay status stage
>   usb: musb: gadget: implement send_response
>   usb: gadget: uvc: allow ioctl to send response in status stage
> 
>  drivers/usb/gadget/function/f_uvc.c    | 33 ++++++++++++++++-----
>  drivers/usb/gadget/function/uvc.h      |  1 +
>  drivers/usb/gadget/function/uvc_v4l2.c | 21 +++++++++++++
>  drivers/usb/gadget/udc/core.c          | 40 +++++++++++++++++++++++++
>  drivers/usb/musb/musb_gadget_ep0.c     | 41 ++++++++++++++++++++++++++
>  include/linux/usb/gadget.h             | 11 +++++++
>  include/uapi/linux/usb/g_uvc.h         |  4 ++-
>  7 files changed, 142 insertions(+), 9 deletions(-)

-- 
Regards,

Laurent Pinchart



