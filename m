Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F2CECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6CA214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6CA214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbeISOQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:16:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:39493 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbeISOQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:16:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 01:39:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="75530286"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga006.jf.intel.com with SMTP; 19 Sep 2018 01:36:13 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Sep 2018 11:36:12 +0300
Date:   Wed, 19 Sep 2018 11:36:12 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        casey.g.bowman@intel.com,
        "Atwood, Matthew S" <matthew.s.atwood@intel.com>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: intel: Do pin translation in other GPIO
 operations as well
Message-ID: <20180919083612.GQ14465@lahna.fi.intel.com>
References: <20180918153621.71984-1-mika.westerberg@linux.intel.com>
 <CACK8Z6F4+N1paQTSWcomnwLpLEHoospSOT3M9bqFQZHHfWmahA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6F4+N1paQTSWcomnwLpLEHoospSOT3M9bqFQZHHfWmahA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 03:04:23PM -0700, Rajat Jain wrote:
> On Tue, Sep 18, 2018 at 8:36 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > For some reason I thought GPIOLIB handles translation from GPIO ranges
> > to pinctrl pins but it turns out not to be the case. This means that
> > when GPIOs operations are performed for a pin controller having a custom
> > GPIO base such as Cannon Lake and Ice Lake incorrect pin number gets
> > used internally.
> >
> > Fix this in the same way we did for lock/unlock IRQ operations and
> > translate the GPIO number to pin before using it.
> >
> > Fixes: a60eac3239f0 ("pinctrl: intel: Allow custom GPIO base for pad groups")
> > Reported-by: Rajat Jain <rajatja@google.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Tested-by: Rajat Jain <rajatja@google.com>
> 
> This has fixed the issue for me.

Thanks for testing!

> One question, may not be related: I see this line in my logs everytime
> I export a pin (GPIO40 = pin 16 in this case). Is that an indication
> of a problem?
> 
> "gpio gpiochip0: Persistence not supported for GPIO 40"

It seems to be debug print if the underlying GPIO chip does not support
PIN_CONFIG_PERSIST_STATE (pinctrl-intel.c does not). I would not worry
about it.
