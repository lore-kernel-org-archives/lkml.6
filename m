Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA88AECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7224721480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0PpcEo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7224721480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeIYCBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeIYCBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:01:02 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 696D220C0A;
        Mon, 24 Sep 2018 19:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537819031;
        bh=TnRYYz06fcJ6BgqqXYVpCDjHv+zVr2wUi0MTOLltIRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z0PpcEo/NBdNT3f3zGQ7ydMvm4WUQRdisRP4mP9p92eWs65j+7ZLZ6r6D46JA+xw6
         QiLxzGPSs79sfDMufv/p/pZjXoYTJK0/xNaTzD0Ifk+rBnP97CYhzdiEoHVV8SS0wc
         TbGyf9Vo+sZchexrEek62gY9drqEE3cHhVuoBoGw=
Date:   Mon, 24 Sep 2018 20:57:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix potential integer overflow
Message-ID: <20180924205709.41a5f567@archlinux>
In-Reply-To: <01297ad3-34a9-994a-f6f4-874dfeb9242b@metafoo.de>
References: <20180918125314.GA12752@embeddedor.com>
        <20180922144230.7d5e6c80@archlinux>
        <b16657d2-250e-2cef-5aca-2c32b3fac8a4@metafoo.de>
        <01297ad3-34a9-994a-f6f4-874dfeb9242b@metafoo.de>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 19:19:34 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 09/24/2018 07:18 PM, Lars-Peter Clausen wrote:
> > On 09/22/2018 03:42 PM, Jonathan Cameron wrote:  
> >> On Tue, 18 Sep 2018 07:53:14 -0500
> >> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> >>  
> >>> Cast factor to s64 in order to give the compiler complete information
> >>> about the proper arithmetic to use and avoid a potential integer
> >>> overflow. Notice that such variable is being used in a context
> >>> that expects an expression of type s64 (64 bits, signed).
> >>>
> >>> Addresses-Coverity-ID: 1324146 ("Unintentional integer overflow")
> >>> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
> >>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>> ---
> >>>  drivers/iio/adc/qcom-vadc-common.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> >>> index dcd7fb5..e360e27 100644
> >>> --- a/drivers/iio/adc/qcom-vadc-common.c
> >>> +++ b/drivers/iio/adc/qcom-vadc-common.c
> >>> @@ -282,7 +282,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
> >>>  	voltage = div64_s64(voltage, data->full_scale_code_volt);
> >>>  	if (voltage > 0) {
> >>>  		voltage *= prescale->den;
> >>> -		temp = prescale->num * factor;
> >>> +		temp = prescale->num * (s64)factor;  
> >> So factor is an unsigned int so could be 32 bits.  In reality it only
> >> takes a small set of values between 1 and 1000
> >>
> >> Maximum numerator is 10 so a maximum of 10,000.
> >>
> >> Hence this is a false positive, be it one that would be very hard
> >> for a static checker to identify.  
> > 
> > I think the reason why it complains is because temp is s64. So it infers
> > that the idea was that the result of the multiplication can be larger
> > than 64 bit. For 32bit * 32bit -> 32bit it should not complain.  
> 
> "lager than 32 bit"
> 
> >   
> >>
> >> So that moves it from a fix to a warning suppression change.
> >> I have no problem with those, but description needs to reflect that.  
> > 
> > Maybe just change the type of temp to u32. There is also
> > mul_u64_u32_div() which could be used here to further simplify things.
> >   
That would be a nice improvement to this patch.  Gustavo,
if you don't mind doing an updated version that would be great.
If not I'll get to it sooner or later.

Thanks,

Jonathan

> 

