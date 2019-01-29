Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B4CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4764C2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfA2WsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:48:23 -0500
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:54655 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727525AbfA2WsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:48:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 13A5B100E86C4;
        Tue, 29 Jan 2019 22:48:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: geese95_ea4c13ea441b
X-Filterd-Recvd-Size: 2428
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Jan 2019 22:48:20 +0000 (UTC)
Message-ID: <a8ae5209f676171a97cae7211411e7ced3ebefbc.camel@perches.com>
Subject: Re: [PATCH] iio:potentiostat:lmp91000: solve codestyle WARNINGs and
 CHECKs
From:   Joe Perches <joe@perches.com>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Date:   Tue, 29 Jan 2019 14:48:19 -0800
In-Reply-To: <20190129183656.15656-1-lucasseikioshiro@gmail.com>
References: <20190129183656.15656-1-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 16:36 -0200, Lucas Oshiro wrote:
> Solve most of the checkpatch.pl WARNINGs and CHECKs on lmp9100.c. They
> are the following:
> 
> lmp91000.c:116: CHECK: Unnecessary parentheses around 'state != channel'
> lmp91000.c:116: CHECK: Unnecessary parentheses around 'channel == LMP91000_REG_MODECN_TEMP'
> lmp91000.c:214: CHECK: braces {} should be used on all arms of this statement
> lmp91000.c:216: CHECK: Unbalanced braces around else statement
> lmp91000.c:258: WARNING: line over 80 characters
> lmp91000.c:279: CHECK: Please don't use multiple blank lines

Some will say this is too many things to do at once.
I think it's mostly fine, but there are a few nits
that also could use fixing.

> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
[]
> @@ -211,9 +211,9 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>  
>  	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
>  	if (ret) {
> -		if (of_property_read_bool(np, "ti,external-tia-resistor"))
> +		if (of_property_read_bool(np, "ti,external-tia-resistor")) {
>  			val = 0;
> -		else {
> +		} else {
>  			dev_err(dev, "no ti,tia-gain-ohm defined");
>  			return ret;
>  		}

This could use inverting the test

	if (ret) {
		if (!of_property_read_bool(...)) {
			dev_err(dev, "no ti,ti-gain-ohm defined\n");
			return ret;
		}
		val = 0;
	}

Also the dev_err is missing a '\n' termination


