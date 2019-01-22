Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA3DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A056B217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfAVP5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:57:54 -0500
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:37731 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729311AbfAVP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:57:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 22A82181D340F;
        Tue, 22 Jan 2019 15:57:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wine81_615abde1e5925
X-Filterd-Recvd-Size: 1750
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue, 22 Jan 2019 15:57:48 +0000 (UTC)
Message-ID: <920c0a6fa9db647f17ce94d29397a7ad0bf76e08.camel@perches.com>
Subject: Re: [PATCH 4/4] sisusb: remove useless macros and compact the code
From:   Joe Perches <joe@perches.com>
To:     Jiri Slaby <jslaby@suse.cz>, thomas@winischhofer.net
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Jan 2019 07:57:47 -0800
In-Reply-To: <20190122151202.18152-4-jslaby@suse.cz>
References: <20190122151202.18152-1-jslaby@suse.cz>
         <20190122151202.18152-4-jslaby@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-22 at 16:12 +0100, Jiri Slaby wrote:
> Remove macros which are only wrappers around standard operations. When
> we expand them into code, we see that sisusbcon_memsetw can simply use
> memset16 and sisusbcon_putcs can just call memcpy. So make the code
> compact.
[]
> diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
[]
> @@ -344,13 +337,11 @@ sisusbcon_invert_region(struct vc_data *vc, u16 *p, int count)
>  	 */
>  
>  	while (count--) {
> -		u16 a = sisusbcon_readw(p);
> -
> -		a = ((a) & 0x88ff)        |
> -		    (((a) & 0x7000) >> 4) |
> -		    (((a) & 0x0700) << 4);
> +		u16 a = *p;
>  
> -		sisusbcon_writew(a, p++);
> +		*p++ = ((a) & 0x88ff)        |
> +		       (((a) & 0x7000) >> 4) |
> +		       (((a) & 0x0700) << 4);

You might remove the unnecessary parentheses
around (a) here too


