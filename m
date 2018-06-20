Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AD6C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1BF204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1BF204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeFTSZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:25:17 -0400
Received: from smtprelay0008.hostedemail.com ([216.40.44.8]:60020 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751767AbeFTSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:25:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id DDAAD182CED34;
        Wed, 20 Jun 2018 18:25:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wrist12_1008fc6f71b63
X-Filterd-Recvd-Size: 3674
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Jun 2018 18:25:10 +0000 (UTC)
Message-ID: <a6a5a21236c37cfc63329e54248d941bf6d49e3c.camel@perches.com>
Subject: Re: [PATCH v2 2/2] hwmon: npcm750: add NPCM7xx PWM and Fan driver
From:   Joe Perches <joe@perches.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        cocci <cocci@systeme.lip6.fr>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com,
        avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org
Date:   Wed, 20 Jun 2018 11:25:08 -0700
In-Reply-To: <20180620164853.GA3459@roeck-us.net>
References: <20180619105352.97181-1-tmaimon77@gmail.com>
         <20180619105352.97181-3-tmaimon77@gmail.com>
         <20180620164853.GA3459@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Julia Lawall and cocci mailing list)

On Wed, 2018-06-20 at 09:48 -0700, Guenter Roeck wrote:
[]
> > +static inline void npcm7xx_fan_start_capture(struct npcm7xx_pwm_fan_data *data,
> > +						 u8 fan, u8 cmp)
> > +{
> > +	u8 fan_id = 0;
> > +	u8 reg_mode = 0;
> > +	u8 reg_int = 0;
> > +	unsigned long flags;
> > +
> > +	fan_id = NPCM7XX_FAN_INPUT(fan, cmp);
> > +
> > +	/* to check whether any fan tach is enable */
> > +	if (data->npcm7xx_fan[fan_id].FanStFlag != FAN_DISABLE) {
> > +		/* reset status */
> > +		spin_lock_irqsave(&data->npcm7xx_fan_lock[fan], flags);
> > +
> > +		data->npcm7xx_fan[fan_id].FanStFlag = FAN_INIT;
> > +		reg_int = ioread8(NPCM7XX_FAN_REG_TIEN(data->fan_base, fan));
> > +
> > +		if (cmp == NPCM7XX_FAN_CMPA) {
> > +			/* enable interrupt */
> > +			iowrite8((u8) (reg_int | (NPCM7XX_FAN_TIEN_TAIEN |
> > +						  NPCM7XX_FAN_TIEN_TEIEN)),
> 
> Is the (u8) typecast really necessary ? Seems unlikely.

The cast is not really necessary here as there would
be an implicit cast already.

Some might complain about loss of type safety and
"make W=123" would probably emit something here.

But casts to the same type are not necessary.

A possible coccinelle script to find casts to the
same type is below, but there are some false positives
for things like __force and __user casts

Also, spatch (1.0.4) seems to have a defect for this
when the type is used in operations that change a
smaller type to int or unsigned int.

i.e.: (offset is u16, but offset * 2 is int)

While running the cocci script below:

HANDLING: drivers/net/ethernet/intel/igb/e1000_nvm.c
diff = 
diff -u -p a/drivers/net/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -335,7 +335,7 @@ s32 igb_read_nvm_spi(struct e1000_hw *hw
 
 	/* Send the READ command (opcode + addr) */
 	igb_shift_out_eec_bits(hw, read_opcode, nvm->opcode_bits);
-	igb_shift_out_eec_bits(hw, (u16)(offset*2), nvm->address_bits);
+	igb_shift_out_eec_bits(hw, (offset * 2), nvm->address_bits);
 
 	/* Read the data.  SPI NVMs increment the address with each byte
 	 * read and will roll over if reading beyond the end.  This allows

---

Anyway, here's the cocci script:

$ cat same_typecast.cocci
@@
type T;
T foo;
@@

-	(T *)&foo
+	&foo

@@
type T;
T foo;
@@

-	(T)foo
+	foo

