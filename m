Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91750C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 00:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D0C20873
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 00:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeL2X6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 18:58:52 -0500
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:33990 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbeL2X6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 18:58:51 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 186211802749D;
        Sat, 29 Dec 2018 23:58:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: earth72_873383838f442
X-Filterd-Recvd-Size: 1887
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Dec 2018 23:58:48 +0000 (UTC)
Message-ID: <117f5de40dabc48457f8725ece6c5b659caff043.camel@perches.com>
Subject: Re: [PATCH] Staging: vt6655: Fix camel case of variable
From:   Joe Perches <joe@perches.com>
To:     Petr =?ISO-8859-1?Q?Sedl=E1k?= <hugosedlak@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 29 Dec 2018 15:58:47 -0800
In-Reply-To: <20181229225952.GA8447@PhilosophyOfMe>
References: <20181229225952.GA8447@PhilosophyOfMe>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-29 at 23:59 +0100, Petr Sedlák wrote:
> Replace variable uDelayUnit with u_delay_unit. Issue found by
> checkpatch.

probably better as a static inline too.

> diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
[]
> @@ -42,15 +42,15 @@
>  #define VNSvOutPortD(dwIOAddress, dwData) \
>  	iowrite32((u32)(dwData), dwIOAddress)
>  
> -#define PCAvDelayByIO(uDelayUnit)				\
> +#define PCAvDelayByIO(u_delay_unit)				\
>  do {								\
>  	unsigned char byData;					\
>  	unsigned long ii;					\
>  								\
> -	if (uDelayUnit <= 50) {					\
> -		udelay(uDelayUnit);				\
> +	if (u_delay_unit <= 50) {					\
> +		udelay(u_delay_unit);				\
>  	} else {						\
> -		for (ii = 0; ii < (uDelayUnit); ii++)		\
> +		for (ii = 0; ii < (u_delay_unit); ii++)		\
>  			byData = inb(0x61);			\
>  	}							\
>  } while (0)

And as the thing is used only once with a #define
with a value less than 50, maybe just
	udelay(CB_DELAY_LOOP_WAIT);
in that one place.


