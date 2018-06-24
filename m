Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C357C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051F024F80
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051F024F80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeFXP0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:26:39 -0400
Received: from smtprelay0031.hostedemail.com ([216.40.44.31]:39681 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751895AbeFXP0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:26:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B5C68180A9C62;
        Sun, 24 Jun 2018 15:26:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crate45_909d8511f660c
X-Filterd-Recvd-Size: 2360
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 Jun 2018 15:26:33 +0000 (UTC)
Message-ID: <36befceb2334197cce5cd44a61f86f38b870d54c.camel@perches.com>
Subject: Re: [PATCH] staging: pi433: replace simple switch statements
From:   Joe Perches <joe@perches.com>
To:     Valentin Vidic <Valentin.Vidic@CARNet.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simon =?ISO-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        Marcus Wolf <linux@Wolf-Entwicklungen.de>,
        Luca =?ISO-8859-1?Q?S=F6the?= <luca@acul.me>,
        Marcin Ciupak <marcin.s.ciupak@gmail.com>,
        Michael Panzlaff <michael.panzlaff@fau.de>,
        Derek Robson <robsonde@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Hugo Lefeuvre <hle@owl.eu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Sun, 24 Jun 2018 08:26:32 -0700
In-Reply-To: <20180624094245.23741-1-Valentin.Vidic@CARNet.hr>
References: <20180624094245.23741-1-Valentin.Vidic@CARNet.hr>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-24 at 11:42 +0200, Valentin Vidic wrote:
> Use const array to map switch cases to resulting values.

I suggest you make the const arrays the same type
as the argument in the function being called.

> diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
[]
> @@ -111,27 +111,22 @@ static inline int rf69_read_mod_write(struct spi_device *spi, u8 reg,
>  
>  int rf69_set_mode(struct spi_device *spi, enum mode mode)
>  {
> -	switch (mode) {
> -	case transmit:
> -		return rf69_read_mod_write(spi, REG_OPMODE, MASK_OPMODE_MODE,
> -					   OPMODE_MODE_TRANSMIT);
[]
> +	static const int mode_map[] = {
> +		[transmit] = OPMODE_MODE_TRANSMIT,
> +		[receive] = OPMODE_MODE_RECEIVE,
> +		[synthesizer] = OPMODE_MODE_SYNTHESIZER,
> +		[standby] = OPMODE_MODE_STANDBY,
> +		[mode_sleep] = OPMODE_MODE_SLEEP,
> +	};
[]
> +	return rf69_read_mod_write(spi, REG_OPMODE, MASK_OPMODE_MODE,
> +				   mode_map[mode]);

drivers/staging/pi433/rf69.c:static inline int rf69_read_mod_write(struct spi_device *spi, u8 reg,
drivers/staging/pi433/rf69.c-                                 u8 mask, u8 value)

so u8 here.

etc...

