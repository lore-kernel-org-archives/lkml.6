Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D50DECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F362154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1BdDL/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F362154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbeIVTgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbeIVTgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:36:13 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78178208A3;
        Sat, 22 Sep 2018 13:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537623754;
        bh=BDWoHhL+NDnmGxH+6AYinWut1yIuKevjGbM5rR5QZX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i1BdDL/yJJWKengioXbv0k0RNLWJP7IPutzCzsObkHhdQeYJmyZo4cr35rpgf3mbt
         AvgcBQS54uU/MS4mZycTlHCCPmgSXJlvVLAZRE7v2Cqn1v+bgAzQVxbYGT2OYpvgYR
         IVsj+zyRILt/Eq+CbkDKTTW0fEIulyBCTGbAZSbA=
Date:   Sat, 22 Sep 2018 14:42:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix potential integer overflow
Message-ID: <20180922144230.7d5e6c80@archlinux>
In-Reply-To: <20180918125314.GA12752@embeddedor.com>
References: <20180918125314.GA12752@embeddedor.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 07:53:14 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Cast factor to s64 in order to give the compiler complete information
> about the proper arithmetic to use and avoid a potential integer
> overflow. Notice that such variable is being used in a context
> that expects an expression of type s64 (64 bits, signed).
> 
> Addresses-Coverity-ID: 1324146 ("Unintentional integer overflow")
> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/iio/adc/qcom-vadc-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index dcd7fb5..e360e27 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -282,7 +282,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
>  	voltage = div64_s64(voltage, data->full_scale_code_volt);
>  	if (voltage > 0) {
>  		voltage *= prescale->den;
> -		temp = prescale->num * factor;
> +		temp = prescale->num * (s64)factor;
So factor is an unsigned int so could be 32 bits.  In reality it only
takes a small set of values between 1 and 1000

Maximum numerator is 10 so a maximum of 10,000.

Hence this is a false positive, be it one that would be very hard
for a static checker to identify.

So that moves it from a fix to a warning suppression change.
I have no problem with those, but description needs to reflect that.

Let me know if I've missed something, if not I'm happy to apply
this and will put some text in the message to explain the above
reasoning.

Thanks,

Jonathan

>  		voltage = div64_s64(voltage, temp);
>  	} else {
>  		voltage = 0;

