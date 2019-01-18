Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B525EC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA2020883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfARTvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:51:25 -0500
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:53759 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729206AbfARTvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:51:25 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 7E9E8181D341B;
        Fri, 18 Jan 2019 19:51:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ball94_c0277c79591b
X-Filterd-Recvd-Size: 2645
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 18 Jan 2019 19:51:22 +0000 (UTC)
Message-ID: <d76c2a301d324239db09ccc7cd8421821ba93b87.camel@perches.com>
Subject: Re: [PATCH] video/hdmi: Change strncpy() into memcpy() in
 hdmi_spd_infoframe_init
From:   Joe Perches <joe@perches.com>
To:     Mathieu Malaterre <malat@debian.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 18 Jan 2019 11:51:20 -0800
In-Reply-To: <20190118193248.535-1-malat@debian.org>
References: <20190118193248.535-1-malat@debian.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 20:32 +0100, Mathieu Malaterre wrote:
> Using strncpy() is less than perfect since the destination buffers do not
> need to be NUL terminated. Replace strncpy() with memcpy() to address a
> warning triggered by gcc using W=1 and optimize the code a bit.
> 
> This commit removes the following warnings:
> 
>   drivers/video/hdmi.c:234:2: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
>   drivers/video/hdmi.c:235:2: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
[]
> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
[]
> @@ -231,8 +231,8 @@ int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
>  	frame->version = 1;
>  	frame->length = HDMI_SPD_INFOFRAME_SIZE;
>  
> -	strncpy(frame->vendor, vendor, sizeof(frame->vendor));
> -	strncpy(frame->product, product, sizeof(frame->product));
> +	memcpy(frame->vendor, vendor, sizeof(frame->vendor));
> +	memcpy(frame->product, product, sizeof(frame->product));

This is not good.

vendor can be any location and shorter than sizeof(frame->vendor)
so this can copy from invalid memory locations.

You probably want strscpy.

This is called with at least "mediatek" and "broadcom", so perhaps
it's better still to change the struct vendor size to something a
bit larger.  Maybe change vendor[8] to vendor[16];

include/linux/hdmi.h:struct hdmi_spd_infoframe {
include/linux/hdmi.h-   enum hdmi_infoframe_type type;
include/linux/hdmi.h-   unsigned char version;
include/linux/hdmi.h-   unsigned char length;
include/linux/hdmi.h-   char vendor[8];
include/linux/hdmi.h-   char product[16];
include/linux/hdmi.h-   enum hdmi_spd_sdi sdi;
include/linux/hdmi.h-};


