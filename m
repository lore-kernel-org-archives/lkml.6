Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C3E2150E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C3E2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbeIRVEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:04:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:43273 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbeIRVEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:04:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 08:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,390,1531810800"; 
   d="scan'208";a="74236927"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 18 Sep 2018 08:31:24 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 18 Sep 2018 18:31:23 +0300
Date:   Tue, 18 Sep 2018 18:31:23 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        casey.g.bowman@intel.com,
        "Atwood, Matthew S" <matthew.s.atwood@intel.com>
Subject: Re: pinctrl-icelake: driver writes to wrong offsets?
Message-ID: <20180918153123.GK14465@lahna.fi.intel.com>
References: <CACK8Z6ECjwWqDnaXKrmEbEXzmiX41Sbzys=FSCqMwh8eYLPH9A@mail.gmail.com>
 <20180917081249.GM14465@lahna.fi.intel.com>
 <CACK8Z6EpPCCGWRZX_FEewyoySLjBUUKDPzKZof4LvvKatU_NLg@mail.gmail.com>
 <20180918083157.GC14465@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918083157.GC14465@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 11:31:57AM +0300, Mika Westerberg wrote:
> > As you can see in the above example, when I export the pins and change
> > the directions from "in" to "out" PADCFG get updated correctly for pin
> > 18, but when writing the value, it is the PADCFG for pin 42 that gets
> > updated which is incorrect.
> 
> It looks like we are missing translation (call intel_gpio_to_pin()) in
> intel_gpio_set(), intel_gpio_get() and intel_gpio_get_direction(). IIRC
> gpiolib handles the translation but here it seems not. Strange.
> 
> > So this looks like a driver issue to me. Please let me know if I need
> > to file a bug on bugzilla for this.
> 
> I agree, definitely driver issue. Please file bugzilla about this (add
> me and Andy there as well) and we'll investigate.

If you have not yet filed bugzilla about this then I don't think there
is need anymore as I think I have a fix already. It turns out with the
custom GPIO base (Ice Lake, Cannon Lake) the translation is missing
completely in ->get(), ->set() and ->get_direction() operations.

I'll send a proper patch shortly.
