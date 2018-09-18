Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32017ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E99206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E99206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeIROeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:34:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:55139 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeIROeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:34:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 02:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,389,1531810800"; 
   d="scan'208";a="87062629"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga002.fm.intel.com with SMTP; 18 Sep 2018 02:02:19 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 18 Sep 2018 12:02:19 +0300
Date:   Tue, 18 Sep 2018 12:02:19 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 4/5] gpiolib: add support for fetching descriptors
 from static properties
Message-ID: <20180918090219.GE14465@lahna.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-5-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917181603.125492-5-dmitry.torokhov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 17, 2018 at 11:16:02AM -0700, Dmitry Torokhov wrote:
> Now that static device properties understand notion of child nodes, let's
> teach gpiolib to tie such children and machine GPIO descriptor tables.
> We will continue using a single table for entire device, but instead of
> using connection ID as a lookup key in the GPIO descriptor table directly,
> we will perform additional translation: fwnode_get_named_gpiod() when
> dealing with property_set-backed fwnodes will try parsing string property
> with name matching connection ID and use result of the lookup as the key in
> the table:
> 
> static const struct property_entry dev_child1_props[] __initconst = {
> 	...
> 	PROPERTY_ENTRY_STRING("gpios",		"child-1-gpios"),
> 	{ }
> };
> 
> static struct gpiod_lookup_table dev_gpiod_table = {
> 	.dev_id = "some-device",
> 	.table = {
> 		...
> 		GPIO_LOOKUP_IDX("B", 1, "child-1-gpios", 1, GPIO_ACTIVE_LOW),
> 		...
> 	},
> };

I wonder if instead of passing and parsing strings (and hoping there are
no typos) we could get the compiler to help us bit more?

Something like below:

static const struct property_entry dev_child1_props[] __initconst = {
 	...
 	PROPERTY_ENTRY_STRING("gpios","child-1-gpios"),
 	{ }
};
 
static struct gpiod_lookup_table dev_gpiod_table = {
 	.dev_id = "some-device",
 	.table = {
 		...
 		GPIO_LOOKUP_IDX("B", 1, dev_child1_props, SIZEOF(dev_child1_props),
				1, GPIO_ACTIVE_LOW),
 		...
 	},
};
