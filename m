Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB170ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6621476
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wXAKJMIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA6621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIPPQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 11:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbeIPPQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 11:16:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD242087E;
        Sun, 16 Sep 2018 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537091630;
        bh=zYXRem1npSdrQhO+lkWFzin44XSfvZoET9Le8r8yw90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wXAKJMIHW/6teaVjGvCJAga2JmkHx8phiGXUnmo0kcl0H5e88DqYDjoISIgrERKn+
         gKbI/gRO4Z1eIevmBMBTbpAq/2qd8uILuq+wB/Nw9X065+mc9TKNLXVi6nu2KnwrnM
         QjYa8b+hujelVCx8SNI89wwJaNXihXqIVhIihRi4=
Date:   Sun, 16 Sep 2018 10:53:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] iio: adc: max9611: Avoid implicit enum conversion
 warning
Message-ID: <20180916105351.1bf859ee@archlinux>
In-Reply-To: <20180915052511.2243-1-natechancellor@gmail.com>
References: <20180915052511.2243-1-natechancellor@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018 22:25:11 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> Clang warns when an enumerated type is implicitly converted to another.
> 
> drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
> enumeration type 'enum max9611_conf_ids' to different enumeration type
> 'enum max9611_csa_gain' [-Wenum-conversion]
>                         *csa_gain = gain_selectors[i];
>                                   ~ ^~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> Change the type of the variable 'gain_selectors' to int so that Clang
> understands this is expected behavior.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
How does this interact with the patch that Stefan Agner sent for
the same issue last week?

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=b1ec0802503820ccbc894aadfd2a44da20232f5e

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max9611.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index 0538ff8c4ac1..3c358b16a8fa 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
>  				    u16 *adc_raw,
>  				    enum max9611_csa_gain *csa_gain)
>  {
> -	enum max9611_conf_ids gain_selectors[] = {
> +	int gain_selectors[] = {
>  		CONF_SENSE_1x,
>  		CONF_SENSE_4x,
>  		CONF_SENSE_8x

