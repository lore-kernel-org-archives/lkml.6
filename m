Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B4CECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3B9214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3B9214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbeISOK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:10:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:62677 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbeISOK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:10:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 01:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="258501330"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga005.jf.intel.com with SMTP; 19 Sep 2018 01:33:32 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Sep 2018 11:33:31 +0300
Date:   Wed, 19 Sep 2018 11:33:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 4/5] gpiolib: add support for fetching descriptors
 from static properties
Message-ID: <20180919083331.GP14465@lahna.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-5-dmitry.torokhov@gmail.com>
 <20180918090219.GE14465@lahna.fi.intel.com>
 <20180918170418.GC177805@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918170418.GC177805@dtor-ws>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 10:04:18AM -0700, Dmitry Torokhov wrote:
> I am not sure how that would work, as there are multiple properties in
> that child array, so we can't simply take the first entry or assume that
> all entries describe GPIOs. Here is the fuller example:
> 
> static const struct property_entry simone_key_enter_props[] __initconst = {
> 	PROPERTY_ENTRY_U32("linux,code",	KEY_ENTER),
> 	PROPERTY_ENTRY_STRING("label",		"enter"),
> 	PROPERTY_ENTRY_STRING("gpios",		"enter-gpios"),
> 	{ }
> };
> 
> static const struct property_entry simone_key_up_props[] __initconst = {
> 	PROPERTY_ENTRY_U32("linux,code",	KEY_UP),
> 	PROPERTY_ENTRY_STRING("label",		"up"),
> 	PROPERTY_ENTRY_STRING("gpios",		"up-gpios"),
> 	{ }
> };
> 
> static const struct property_entry simone_key_up_props[] __initconst = {
> 	PROPERTY_ENTRY_U32("linux,code",	KEY_LEFT),
> 	PROPERTY_ENTRY_STRING("label",		"left"),
> 	PROPERTY_ENTRY_STRING("gpios",		"left-gpios"),
> 	{ }
> };
> 
> static const struct property_entry simone_key_props[] __initconst = {
> 	/* There are no properties at device level on this device */
> 	{ }
> };
> 
> static struct gpiod_lookup_table simone_keys_gpiod_table = {
> 	.dev_id = "gpio-keys",
> 	.table = {
> 		/* Use local offsets on gpiochip/port "B" */
> 		GPIO_LOOKUP_IDX("B", 0, "enter-gpios", 0, GPIO_ACTIVE_LOW),
> 		GPIO_LOOKUP_IDX("B", 1, "up-gpios", 1, GPIO_ACTIVE_LOW),
> 		GPIO_LOOKUP_IDX("B", 2, "left-gpios", 2, GPIO_ACTIVE_LOW),
> 	},
> };
> 
> static struct platform_device simone_keys_device = {
> 	.name = "gpio-keys",
> 	.id = -1,
> };
> 
> static void __init simone_init_machine(void)
> {
> 	...
> 	gpiod_add_lookup_table(&simone_keys_gpiod_table);
> 	device_add_properties(&simone_keys_device.dev,
> 			      simone_keys_device_props);
> 	device_add_child_properties(&simone_keys_device.dev,
> 				    dev_fwnode(&simone_keys_device.dev),
> 				    simone_key_enter_props);
> 	device_add_child_properties(&simone_keys_device.dev,
> 				    dev_fwnode(&simone_keys_device.dev),
> 				    simone_key_up_props);
> 	device_add_child_properties(&simone_keys_device.dev,
> 				    dev_fwnode(&simone_keys_device.dev),
> 				    simone_key_left_props);
> 	platform_device_register(&simone_keys_device);
> 	...
> }

Thanks for clarifying. I missed this last part where you feed the
properties to the device.

So looks fine by me :)
