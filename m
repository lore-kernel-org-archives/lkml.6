Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498D2C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEEA20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwd5qKD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEEA20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeILGgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:36:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38192 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeILGgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:36:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id u11-v6so144876plq.5;
        Tue, 11 Sep 2018 18:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1+iGQQaC2LkrZ1xdmEQSqnSrhnZyuykv1+AdPUMbPYo=;
        b=Dwd5qKD6SyE4y1va8wixKGqNMVYdV2dzutsGnAmZpa5Km4H7nodmizUF+ho9rKw6qC
         OSKxvojxKvip4eqYScvG1oPeskHkljhIlW+wnKjJaBGhl84DXRkfzEoNYeJUFRlLta28
         EMZxM07EE4+Kp0ApT0aibedavdIUbc8D0L5wSULXrVa8v2jbCOaBFakPOWvKMcSYqeKp
         busxFq+D/qmWDsWSyi9sNc0EVKTjYDwGerKuyyZsgn6QRcKjSj2q8nwEyNo9GeuoxMdN
         WLNdxQ2oojWoN3ZS71gxOZ+RfecF5km/pfb0UUO9djE4QEuhC+62kH8KrhnO8n26MnNC
         AvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1+iGQQaC2LkrZ1xdmEQSqnSrhnZyuykv1+AdPUMbPYo=;
        b=hS1TFsRfhBuDcHexnsoA5FCBjz/7NmflL9P1+oXmDrVKrJdfnj+y91yAwn5UH3y//C
         vzAdmcn5BCFaXNH1DmDT52B5vY7tgaYp0NqduFohFyqHCLogCHYkTBMnx19qNoz9ZX0h
         K9JvVW9hjywdbgyUsr6tU0xpl6T5ClUrxl3jo24vG4ePUx+gVIoinC0hoQTsp+gqxtkz
         ny00vDE4oXzGUgqG3nsC5ot7ICO1nVR83BE5ehmG6qGdWADpptByL4bp5zDUjaW1QHSy
         qzq+lUo/k/7mhDpCvCRJIfiaYuy240aAFOqT2A1aKqrXp4ZZ6GUVyQgFNvunCQxmeANZ
         F2/A==
X-Gm-Message-State: APzg51BaeHSh7WhGR89fn+VgMIaN3vk3NL2/XjiEreoVSCCemuTeHKaN
        lWQDm36LZAkh4YxUdKL8opswEL8X
X-Google-Smtp-Source: ANB0VdYrRpJuGrfk2lfjdEOGj0IeE5/ptIRvM0rfbgGaQbOXRhR1ekHRShive8c4Cq7bcS4wmIJwBg==
X-Received: by 2002:a17:902:7e09:: with SMTP id b9-v6mr29796214plm.221.1536716092430;
        Tue, 11 Sep 2018 18:34:52 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w12-v6sm30860976pfd.110.2018.09.11.18.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 18:34:51 -0700 (PDT)
Date:   Tue, 11 Sep 2018 18:34:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Feist <james.feist@linux.intel.com>
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
Message-ID: <20180912013449.GA12612@roeck-us.net>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
 <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 04:58:44PM -0700, Jae Hyun Yoo wrote:
> On 9/11/2018 4:33 PM, Guenter Roeck wrote:
> >Looking into the patch, clearing the interrupt status at the end of an
> >interrupt handler is always suspicious and tends to result in race
> >conditions (because additional interrupts may have arrived while handling
> >the existing interrupts, or because interrupt handling itself may trigger
> >another interrupt). With that in mind, the following patch fixes the
> >problem for me.
> >
> >Guenter
> >
> >---
> >
> >diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> >index c258c4d9a4c0..c488e6950b7c 100644
> >--- a/drivers/i2c/busses/i2c-aspeed.c
> >+++ b/drivers/i2c/busses/i2c-aspeed.c
> >@@ -552,6 +552,8 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> >  	spin_lock(&bus->lock);
> >  	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> >+	/* Ack all interrupt bits. */
> >+	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
> >  	irq_remaining = irq_received;
> >  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> >@@ -584,8 +586,6 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> >  			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> >  			irq_received, irq_handled);
> >-	/* Ack all interrupt bits. */
> >-	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
> >  	spin_unlock(&bus->lock);
> >  	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
> >  }
> >
> 
> My intention of putting the code at the end of interrupt handler was,
> to reduce possibility of combined irq calls which is explained in this
> patch. But YES, I agree with you. It could make a potential race

Hmm, yes, but that doesn't explain why it would make sense to acknowledge
the interrupt late. The interrupt ack only means "I am going to handle these
interrupts". If additional interrupts arrive while the interrupt handler
is active, those will have to be acknowledged separately.

Sure, there is a risk that an interrupt arrives while the handler is
running, and that it is handled but not acknowledged. That can happen
with pretty much all interrupt handlers, and there are mitigations to
limit the impact (for example, read the interrupt status register in
a loop until no more interrupts are pending). But acknowledging
an interrupt that was possibly not handled is always bad idea.

Thanks,
Guenter
