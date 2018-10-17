Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328F1ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9860214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OjT5spgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9860214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeJQP5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:57:17 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54158 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJQP5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:57:02 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5013B1277;
        Wed, 17 Oct 2018 10:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539763351;
        bh=i8tQelRIexuQA8qiqi7BaH93AXnrPtlzelfeQfbOi/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjT5spgC5+uo8Krs/CjO1PErFDFvNgeDileHmOmr9biC4EFfGsQttBWaEzTZ+Ubfq
         CQmUlwqxYBZbV/+5ktbO02wMqGa0QWj+w3CGyKH0VTElRvWtZNOeofOMBrKIQw8P13
         4Z8Zv7b2cX76PllUl12AAs2zRmQ/mxIwcN4ED2xA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Heng-Ruey Hsu <henryhsu@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        jcliang@chromium.org, tfiga@chromium.org
Subject: Re: [PATCH] media: uvcvideo: Add boottime clock support
Date:   Wed, 17 Oct 2018 11:02:40 +0300
Message-ID: <13883852.6N9L7C0n48@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181017075242.21790-1-henryhsu@chromium.org>
References: <20181017075242.21790-1-henryhsu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heng-Ruey,

Thank you for the patch.

On Wednesday, 17 October 2018 10:52:42 EEST Heng-Ruey Hsu wrote:
> Android requires camera timestamps to be reported with
> CLOCK_BOOTTIME to sync timestamp with other sensor sources.

What's the rationale behind this, why can't CLOCK_MONOTONIC work ? If the 
monotonic clock has shortcomings that make its use impossible for proper 
synchronization, then we should consider switching to CLOCK_BOOTTIME globally 
in V4L2, not in selected drivers only.

> Signed-off-by: Heng-Ruey Hsu <henryhsu@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 4 ++++
>  drivers/media/usb/uvc/uvc_video.c  | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c
> b/drivers/media/usb/uvc/uvc_driver.c index d46dc432456c..a9658f38c586
> 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2287,6 +2287,8 @@ static int uvc_clock_param_get(char *buffer, const
> struct kernel_param *kp) {
>  	if (uvc_clock_param == CLOCK_MONOTONIC)
>  		return sprintf(buffer, "CLOCK_MONOTONIC");
> +	else if (uvc_clock_param == CLOCK_BOOTTIME)
> +		return sprintf(buffer, "CLOCK_BOOTTIME");
>  	else
>  		return sprintf(buffer, "CLOCK_REALTIME");
>  }
> @@ -2298,6 +2300,8 @@ static int uvc_clock_param_set(const char *val, const
> struct kernel_param *kp)
> 
>  	if (strcasecmp(val, "monotonic") == 0)
>  		uvc_clock_param = CLOCK_MONOTONIC;
> +	else if (strcasecmp(val, "boottime") == 0)
> +		uvc_clock_param = CLOCK_BOOTTIME;
>  	else if (strcasecmp(val, "realtime") == 0)
>  		uvc_clock_param = CLOCK_REALTIME;
>  	else
> diff --git a/drivers/media/usb/uvc/uvc_video.c
> b/drivers/media/usb/uvc/uvc_video.c index 86a99f461fd8..d4248d5cd9cd 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -425,6 +425,8 @@ static inline ktime_t uvc_video_get_time(void)
>  {
>  	if (uvc_clock_param == CLOCK_MONOTONIC)
>  		return ktime_get();
> +	else if (uvc_clock_param == CLOCK_BOOTTIME)
> +		return ktime_get_boottime();
>  	else
>  		return ktime_get_real();
>  }

-- 
Regards,

Laurent Pinchart



