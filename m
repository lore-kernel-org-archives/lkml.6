Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE672190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbeLUPz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:55:27 -0500
Received: from mail1.windriver.com ([147.11.146.13]:65529 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLUPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:55:26 -0500
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wBLFtHbh012544
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 21 Dec 2018 07:55:18 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Fri, 21 Dec 2018 07:55:17 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 0F4072E07C2; Fri, 21 Dec 2018 10:55:16 -0500 (EST)
Date:   Fri, 21 Dec 2018 10:55:16 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        <patches@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 18/18] mfd: wm8400-core: Make it explicitly non-modular
Message-ID: <20181221155516.GP4292@windriver.com>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
 <1545078688-21217-19-git-send-email-paul.gortmaker@windriver.com>
 <20181219091742.GA16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181219091742.GA16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 18/18] mfd: wm8400-core: Make it explicitly non-modular] On 19/12/2018 (Wed 09:17) Charles Keepax wrote:

> On Mon, Dec 17, 2018 at 03:31:28PM -0500, Paul Gortmaker wrote:
> > The Kconfig currently controlling compilation of this code is:
> > 
> > drivers/mfd/Kconfig:config MFD_WM8400
> > drivers/mfd/Kconfig:    bool "Wolfson Microelectronics WM8400"
> > 
> > ...meaning that it currently is not being built as a module by anyone.
> > 
> > Lets remove the modular code that is essentially orphaned, so that
> > when reading the driver there is no doubt it is builtin-only.
> > 
> > Since module_init was not in use by this code, the init ordering
> > remains unchanged with this commit.
> > 
> > A trivial function rename from wm8400_module_init to the name
> > wm8400_driver_init is also done to reduce possible confusion.
> > 
> > Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> > 
> > We also delete the MODULE_LICENSE tag etc. since all that information
> > is already contained at the top of the file in the comments.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: patches@opensource.cirrus.com
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > -MODULE_DEVICE_TABLE(i2c, wm8400_i2c_id);
> >  
> >  static struct i2c_driver wm8400_i2c_driver = {
> >  	.driver = {
> > @@ -161,7 +160,7 @@ static struct i2c_driver wm8400_i2c_driver = {
> >  };
> >  #endif
> 
> Do we not want to add suppress_bind_attrs into the i2c_driver
> struct here?

We can add one if you/maintainers want one, but if you look at the
original patch, this driver was using the more classic/legacy case of
subsys_init() vs. platform_driver_register() used in other drivers.

Not adding a suppress_bind_attrs here was intentional, since I'd decided
to put in the unbind entries for code that used platform_driver_register()
where the author had created the .remove code, on the assumption that they
had put some thought into the process of unbind/remove - to make it
explicit that unbind is now disabled.

To be clear, using the subsys_init() doesn't implicitly disable unbind.
However, there are lots of non-modular drivers out there; ones I've not
even touched, and to start a project to add an unbind disable to them
all is beyond the scope of the goals I've listed in the 00/18 preamble.

I'd hope maybe we can revisit the global default setting for non-modular
code someday - to make non-modules opt-in instead of opt-out, and
achieve better consistency from one driver to the next, without having
to add a new .driver sub-struct to each file for the suppress entry.

I think LinusW hinted at in an earlier email in this ongoing review,
that the default setting didn't quite make sense to him either.  But in
any case, that is a separate discussion for another time and place.

Let me know if you explicitly want one added, otherwise I'll just leave
the .remove + .suppress_bind_attrs pairing as described above.

Thanks,
Paul.
--

> 
> Thanks, Charles
