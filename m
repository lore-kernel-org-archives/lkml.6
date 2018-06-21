Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB502C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD21820837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD21820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeFUNR3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:17:29 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:43901 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932747AbeFUNR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:17:28 -0400
X-IronPort-AV: E=Sophos;i="5.51,252,1526335200"; 
   d="scan'208";a="332746881"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 15:17:26 +0200
Date:   Thu, 21 Jun 2018 15:17:26 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Guenter Roeck <linux@roeck-us.net>,
        Tomer Maimon <tmaimon77@gmail.com>,
        cocci <cocci@systeme.lip6.fr>, robh+dt@kernel.org,
        mark.rutland@arm.com, jdelvare@suse.com, avifishman70@gmail.com,
        yuenn@google.com, brendanhiggins@google.com, venture@google.com,
        joel@jms.id.au, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] hwmon: npcm750: add NPCM7xx PWM and Fan driver
In-Reply-To: <a6a5a21236c37cfc63329e54248d941bf6d49e3c.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1806211515060.3774@hadrien>
References: <20180619105352.97181-1-tmaimon77@gmail.com>  <20180619105352.97181-3-tmaimon77@gmail.com>  <20180620164853.GA3459@roeck-us.net> <a6a5a21236c37cfc63329e54248d941bf6d49e3c.camel@perches.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Jun 2018, Joe Perches wrote:

> (adding Julia Lawall and cocci mailing list)
>
> On Wed, 2018-06-20 at 09:48 -0700, Guenter Roeck wrote:
> []
> > > +static inline void npcm7xx_fan_start_capture(struct npcm7xx_pwm_fan_data *data,
> > > +						 u8 fan, u8 cmp)
> > > +{
> > > +	u8 fan_id = 0;
> > > +	u8 reg_mode = 0;
> > > +	u8 reg_int = 0;
> > > +	unsigned long flags;
> > > +
> > > +	fan_id = NPCM7XX_FAN_INPUT(fan, cmp);
> > > +
> > > +	/* to check whether any fan tach is enable */
> > > +	if (data->npcm7xx_fan[fan_id].FanStFlag != FAN_DISABLE) {
> > > +		/* reset status */
> > > +		spin_lock_irqsave(&data->npcm7xx_fan_lock[fan], flags);
> > > +
> > > +		data->npcm7xx_fan[fan_id].FanStFlag = FAN_INIT;
> > > +		reg_int = ioread8(NPCM7XX_FAN_REG_TIEN(data->fan_base, fan));
> > > +
> > > +		if (cmp == NPCM7XX_FAN_CMPA) {
> > > +			/* enable interrupt */
> > > +			iowrite8((u8) (reg_int | (NPCM7XX_FAN_TIEN_TAIEN |
> > > +						  NPCM7XX_FAN_TIEN_TEIEN)),
> >
> > Is the (u8) typecast really necessary ? Seems unlikely.
>
> The cast is not really necessary here as there would
> be an implicit cast already.
>
> Some might complain about loss of type safety and
> "make W=123" would probably emit something here.
>
> But casts to the same type are not necessary.
>
> A possible coccinelle script to find casts to the
> same type is below, but there are some false positives
> for things like __force and __user casts
>
> Also, spatch (1.0.4) seems to have a defect for this
> when the type is used in operations that change a
> smaller type to int or unsigned int.
>
> i.e.: (offset is u16, but offset * 2 is int)

Ah.  The rule is that the result type is always the larger one?
Unfortunately, Coccinelle doesn't know the size of any type.  I could add
some special cases, but that may be more confusing than helpful.

julia

>
> While running the cocci script below:
>
> HANDLING: drivers/net/ethernet/intel/igb/e1000_nvm.c
> diff =
> diff -u -p a/drivers/net/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
> --- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
> @@ -335,7 +335,7 @@ s32 igb_read_nvm_spi(struct e1000_hw *hw
>
>  	/* Send the READ command (opcode + addr) */
>  	igb_shift_out_eec_bits(hw, read_opcode, nvm->opcode_bits);
> -	igb_shift_out_eec_bits(hw, (u16)(offset*2), nvm->address_bits);
> +	igb_shift_out_eec_bits(hw, (offset * 2), nvm->address_bits);
>
>  	/* Read the data.  SPI NVMs increment the address with each byte
>  	 * read and will roll over if reading beyond the end.  This allows
>
> ---
>
> Anyway, here's the cocci script:
>
> $ cat same_typecast.cocci
> @@
> type T;
> T foo;
> @@
>
> -	(T *)&foo
> +	&foo
>
> @@
> type T;
> T foo;
> @@
>
> -	(T)foo
> +	foo
>
>
