Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665BFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B5B2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xy/xJNfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B5B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeISSjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:39:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38814 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731176AbeISSjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1nD8i3nnOMkewlCtFhy3yeeCX7gNeouRs3/PgCgrdJU=;
        b=Xy/xJNfGEOMnp8RL5Z6rL8MJsew0mbV0LTMXuVbLRWAg8moEQkw6+oDQMb622g00ZjDTZCkS53oCVDRkkpnfw3j3zXT44LcRc/u7MXUFlAIl8HY2Wv7jDcuf7Oztym3895JpRZrccZ5KaNwzDiFmq3ME3aRr3aQZZ3V4FJv9jG0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g2c6K-0007g4-Q7; Wed, 19 Sep 2018 15:01:04 +0200
Date:   Wed, 19 Sep 2018 15:01:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Aditya Prayoga <aditya@kobol.io>
Cc:     linux-ide@vger.kernel.org, linux-leds@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH 1/2] libata: add ledtrig support
Message-ID: <20180919130104.GD26940@lunn.ch>
References: <1537328730-9156-1-git-send-email-aditya@kobol.io>
 <1537328730-9156-2-git-send-email-aditya@kobol.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537328730-9156-2-git-send-email-aditya@kobol.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:45:29AM +0800, Aditya Prayoga wrote:
> From: Daniel Golle <daniel@makrotopia.org>
> 
> This adds a LED trigger for each ATA port indicating disk activity.
> 
> As this is needed only on specific platforms (NAS SoCs and such),
> these platforms should define ARCH_WANTS_LIBATA_LEDS if there
> are boards with LED(s) intended to indicate ATA disk activity and
> need the OS to take care of that.
> In that way, if not selected, LED trigger support not will be
> included in libata-core and both, codepaths and structures remain
> untouched.
> 
> I'm currently deploying this for the oxnas target in OpenWrt
> https://dev.openwrt.org/changeset/43675/
> 
> v2: rebased to kernel/git/tj/libata.git
>     plus small corrections and comments added
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> URL: https://patchwork.ozlabs.org/patch/420733/
> [Aditya Prayoga:
> * Port forward
> * Change ATA_LEDS default to no
> * Reduce performance impact by moving ata_led_act() call from
>     ata_qc_new() to ata_qc_complete()]
> Signed-off-by: Aditya Prayoga <aditya@kobol.io>
> 
> ---
> 
> If there is anything fundamentally wrong with that approach, I'd be
> glad for some advise on how to do it better.
> I conciously choose an #ifdev approach to make sure performance will
> not be affected for non-users of that code.

Hi Aditya

I remember something like this being discussed a long time ago, and it
was rejected because of the overheads. So it is good you have some
performance numbers. I will let others decide if the approach is
acceptable.

>  /**
> + *	ata_led_act - Trigger port activity LED
> + *	@ap: indicating port
> + *
> + *	Blinks any LEDs registered to the trigger.
> + *	Commonly used with leds-gpio on NAS systems with disk activity
> + *	indicator LEDs.
> + *
> + *	LOCKING:
> + *	None.
> + */
> +static inline void ata_led_act(struct ata_port *ap)

inline should not be used in C code, just header files. A function
this small the compiler is likely to inline anyway.

> +{
> +#ifdef CONFIG_ATA_LEDS

It is better to use if (IS_ENABLED(CONFIG_ATA_LEDS) {}.  That gets
turned into if(0) {}, so the code still gets compiled to find any
errors, but then optimised out. This is important if the code is going
to be disabled by default.

> +#define LIBATA_BLINK_DELAY 20 /* ms */
> +	unsigned long led_delay = LIBATA_BLINK_DELAY;
> +
> +	if (unlikely(!ap->ledtrig))
> +		return;
> +
> +	led_trigger_blink_oneshot(ap->ledtrig, &led_delay, &led_delay, 0);
> +#endif /* CONFIG_ATA_LEDS */
> +}
> +
> +/**
>   *	ata_qc_new_init - Request an available ATA command, and initialize it
>   *	@dev: Device from whom we request an available command structure
>   *	@tag: tag
> @@ -5249,6 +5273,10 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>  	/* Trigger the LED (if available) */
>  	ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));
>  
> +#ifdef CONFIG_ATA_LEDS
> +	ata_led_act(ap);
> +#endif

No need for this #ifdef'ery.

> +
>  	/* XXX: New EH and old EH use different mechanisms to
>  	 * synchronize EH with regular execution path.
>  	 *
> @@ -6028,6 +6056,9 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  	ap->stats.unhandled_irq = 1;
>  	ap->stats.idle_irq = 1;
>  #endif
> +#ifdef CONFIG_ATA_LEDS
> +	ap->ledtrig = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);

Maybe use devm_kzalloc() and devm_led_trigger_register()?

      Andrew
