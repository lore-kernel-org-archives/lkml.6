Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91278ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4145921508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDFt2BqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4145921508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbeIRWhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:37:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38565 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbeIRWhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:37:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id t84-v6so1340681pgb.5;
        Tue, 18 Sep 2018 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HTRStyjlS6UiEtbKbs+O87aZYAQ41TwTWneBvtQaZ6I=;
        b=VDFt2BqSEqaCOaLZlEO3BxRsi06SbB1XgKMC0y0/V+TZKX9FeVl1P67h4ZPc3FZo/3
         hiy5S4Bv2NWgvwHiJYBUWgu7m2HZYgziF83ksV7aJ5v69R6vzwqWUd9pxrOBOPebYtR6
         T2QCoiCyZKx510gy9d+5rd1xBc/OUB00gSjLrbgn5vEerwoMgL5OALrnTu2cyI7J1cIX
         LgwuG+COcqLF051uoY+7Up5i2PjVkxhfSj3e5bjsBL4udz4sF1RqGeMUzOlOfR5zDoFA
         L6mFbVgiOUcu6gX5FFRNe/0gEtEGfQh26nts2hjAwJtFM4y4YEwNfi9jfyLkEVCxuihW
         /OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HTRStyjlS6UiEtbKbs+O87aZYAQ41TwTWneBvtQaZ6I=;
        b=VRuk0ju9rFMsB4aep7Kn63dx+ZUz3+WI/qUeuon0AAU9/SAQt+IbaWGos62TNyUVlK
         FCceAdUuF3zQ96nDB6J5bhaYh1yi399oAXOP9liwSLnE2XR87jSMXqbyfCMd+ZEx9hzc
         1qyv0M1OcrZQFfF98IMkxxFTU5DI08SaRk8itXfCelJ86/eXewf7GhkHtKdL+PU0/wQm
         cDgYlNQlErzv0xBj0HUQurwjVXmxmiE6kFA234eR0RE8Cm+x5ZK4dvfbPq+uOrccZNh+
         SXHDVW1OLpMDS/Oympy3vg5po2fTV2eH9e1a2oxtCfsfG/Y8bl+OHAsRPFG95ImII72Q
         sKyw==
X-Gm-Message-State: APzg51BsdxTl/bN6L60Dq18MynvMIOXQ+ACJkOg6XhTp0fIc9J96gnTv
        ItOTNAZR5OTeL0mWQjhHX5U=
X-Google-Smtp-Source: ANB0VdZFR2k6NRrxtlQg64zmby6XCvisHSRR0ICj4d6HfZCAtQ6002+V9OASoAm0zBR7160Ak5qJwg==
X-Received: by 2002:a63:8b44:: with SMTP id j65-v6mr29138545pge.325.1537290261477;
        Tue, 18 Sep 2018 10:04:21 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r17-v6sm29221197pff.50.2018.09.18.10.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 10:04:20 -0700 (PDT)
Date:   Tue, 18 Sep 2018 10:04:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 4/5] gpiolib: add support for fetching descriptors
 from static properties
Message-ID: <20180918170418.GC177805@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-5-dmitry.torokhov@gmail.com>
 <20180918090219.GE14465@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918090219.GE14465@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

On Tue, Sep 18, 2018 at 12:02:19PM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Sep 17, 2018 at 11:16:02AM -0700, Dmitry Torokhov wrote:
> > Now that static device properties understand notion of child nodes, let's
> > teach gpiolib to tie such children and machine GPIO descriptor tables.
> > We will continue using a single table for entire device, but instead of
> > using connection ID as a lookup key in the GPIO descriptor table directly,
> > we will perform additional translation: fwnode_get_named_gpiod() when
> > dealing with property_set-backed fwnodes will try parsing string property
> > with name matching connection ID and use result of the lookup as the key in
> > the table:
> > 
> > static const struct property_entry dev_child1_props[] __initconst = {
> > 	...
> > 	PROPERTY_ENTRY_STRING("gpios",		"child-1-gpios"),
> > 	{ }
> > };
> > 
> > static struct gpiod_lookup_table dev_gpiod_table = {
> > 	.dev_id = "some-device",
> > 	.table = {
> > 		...
> > 		GPIO_LOOKUP_IDX("B", 1, "child-1-gpios", 1, GPIO_ACTIVE_LOW),
> > 		...
> > 	},
> > };
> 
> I wonder if instead of passing and parsing strings (and hoping there are
> no typos) we could get the compiler to help us bit more?
> 
> Something like below:
> 
> static const struct property_entry dev_child1_props[] __initconst = {
>  	...
>  	PROPERTY_ENTRY_STRING("gpios","child-1-gpios"),
>  	{ }
> };
>  
> static struct gpiod_lookup_table dev_gpiod_table = {
>  	.dev_id = "some-device",
>  	.table = {
>  		...
>  		GPIO_LOOKUP_IDX("B", 1, dev_child1_props, SIZEOF(dev_child1_props),
> 				1, GPIO_ACTIVE_LOW),
>  		...
>  	},
> };

I am not sure how that would work, as there are multiple properties in
that child array, so we can't simply take the first entry or assume that
all entries describe GPIOs. Here is the fuller example:

static const struct property_entry simone_key_enter_props[] __initconst = {
	PROPERTY_ENTRY_U32("linux,code",	KEY_ENTER),
	PROPERTY_ENTRY_STRING("label",		"enter"),
	PROPERTY_ENTRY_STRING("gpios",		"enter-gpios"),
	{ }
};

static const struct property_entry simone_key_up_props[] __initconst = {
	PROPERTY_ENTRY_U32("linux,code",	KEY_UP),
	PROPERTY_ENTRY_STRING("label",		"up"),
	PROPERTY_ENTRY_STRING("gpios",		"up-gpios"),
	{ }
};

static const struct property_entry simone_key_up_props[] __initconst = {
	PROPERTY_ENTRY_U32("linux,code",	KEY_LEFT),
	PROPERTY_ENTRY_STRING("label",		"left"),
	PROPERTY_ENTRY_STRING("gpios",		"left-gpios"),
	{ }
};

static const struct property_entry simone_key_props[] __initconst = {
	/* There are no properties at device level on this device */
	{ }
};

static struct gpiod_lookup_table simone_keys_gpiod_table = {
	.dev_id = "gpio-keys",
	.table = {
		/* Use local offsets on gpiochip/port "B" */
		GPIO_LOOKUP_IDX("B", 0, "enter-gpios", 0, GPIO_ACTIVE_LOW),
		GPIO_LOOKUP_IDX("B", 1, "up-gpios", 1, GPIO_ACTIVE_LOW),
		GPIO_LOOKUP_IDX("B", 2, "left-gpios", 2, GPIO_ACTIVE_LOW),
	},
};

static struct platform_device simone_keys_device = {
	.name = "gpio-keys",
	.id = -1,
};

static void __init simone_init_machine(void)
{
	...
	gpiod_add_lookup_table(&simone_keys_gpiod_table);
	device_add_properties(&simone_keys_device.dev,
			      simone_keys_device_props);
	device_add_child_properties(&simone_keys_device.dev,
				    dev_fwnode(&simone_keys_device.dev),
				    simone_key_enter_props);
	device_add_child_properties(&simone_keys_device.dev,
				    dev_fwnode(&simone_keys_device.dev),
				    simone_key_up_props);
	device_add_child_properties(&simone_keys_device.dev,
				    dev_fwnode(&simone_keys_device.dev),
				    simone_key_left_props);
	platform_device_register(&simone_keys_device);
	...
}

Thanks.

-- 
Dmitry
