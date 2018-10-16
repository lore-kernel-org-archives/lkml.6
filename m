Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7FEC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D96920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D96920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJPXBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:01:31 -0400
Received: from www381.your-server.de ([78.46.137.84]:36570 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPXBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:01:31 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1gCQzQ-0003hv-Ka; Tue, 16 Oct 2018 17:10:32 +0200
Received: from eisbaer.ursus-maritimus.org ([78.47.220.141] helo=[127.0.0.1])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1gCQzQ-000Eji-5E; Tue, 16 Oct 2018 17:10:32 +0200
Subject: Re: [PATCH] staging: iio: ad7816: Switch to the gpio descriptor
 interface
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <20181016144623.GA9890@nishad>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <929c42b8-34e7-60bb-5bd4-31faf53d62c2@metafoo.de>
Date:   Tue, 16 Oct 2018 17:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016144623.GA9890@nishad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.1/25042/Tue Oct 16 15:01:23 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 04:46 PM, Nishad Kamdar wrote:
> Use the gpiod interface for rdwr_pin, convert_pin and busy_pin
> instead of the deprecated old non-descriptor interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Hi,

Thanks for the patch, this looks good.

One thing about the error messages though.

> +	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
> +	if (IS_ERR(chip->rdwr_pin)) {
> +		ret = PTR_ERR(chip->rdwr_pin);
>  		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
> -			chip->rdwr_pin);
> +			ret);

This previously showed the pin number which has now been replaced with the
error code. The message doesn't make that much sense semantically anymore.
Maybe replace it with something like

	"Failed to request rdwr GPIO: %d\n", ret

>  		return ret;
