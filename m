Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC1AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6360D2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6360D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756143AbeFSHP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:15:28 -0400
Received: from muru.com ([72.249.23.125]:48096 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755553AbeFSHP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:15:26 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 32C9E805C;
        Tue, 19 Jun 2018 07:18:08 +0000 (UTC)
Date:   Tue, 19 Jun 2018 00:15:23 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Christ van Willegen <cvwillegen@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in
 pinctrl_groups and deferred probing
Message-ID: <20180619071523.GZ112168@atomide.com>
References: <20180618095428.GQ112168@atomide.com>
 <CA+Ot1OxNj30KgHWJHXgWbnXYkNXTNvd_t-b6+uG3u=z8+pZf2Q@mail.gmail.com>
 <20180618115122.GT26255@atomide.com>
 <CDD8B994-59E9-42DC-A77D-AF4F35EBF101@goldelico.com>
 <20180618181744.GS112168@atomide.com>
 <404C63D9-169E-4051-88E0-2856F3602A72@goldelico.com>
 <20180619043408.GT112168@atomide.com>
 <631A1D2F-093A-498F-8923-FC9CD20E11A8@goldelico.com>
 <20180619061102.GU112168@atomide.com>
 <4435BD7A-AE0D-45A5-9D6A-277175ABE489@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4435BD7A-AE0D-45A5-9D6A-277175ABE489@goldelico.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [180619 06:42]:
> Hi Tony,
> 
> > Am 19.06.2018 um 08:11 schrieb Tony Lindgren <tony@atomide.com>:
> > 
> > * H. Nikolaus Schaller <hns@goldelico.com> [180619 04:54]:
> >>>> I had seen the call sequence
> >>>> 
> >>>> 
> >>>> 
> >>>> w/o any lock inside.
> > 
> > So the sequence above has mutex added around adding the pin
> > controller specific functions and groups by the patch series
> > I posted for both pcs_parse_bits_in_pinctrl_entry() and
> > pcs_parse_one_pinctrl_entry(). So I think the above should
> > be fixed now. But please confirm to make sure I'm not mistaken.
> 
> Ah, now I see.
> 
> My dump_stack() added to pinctrl_generic_add_group() reported
> 
> [    6.155487] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [    6.162048] [<c01106ec>] (unwind_backtrace) from [<c010c058>] (show_stack+0x10/0x14)
> [    6.170166] [<c010c058>] (show_stack) from [<c074bc28>] (dump_stack+0x7c/0x9c)
> [    6.177734] [<c074bc28>] (dump_stack) from [<c042bbec>] (pinctrl_generic_add_group+0x48/0x90)
> [    6.186614] [<c042bbec>] (pinctrl_generic_add_group) from [<c043203c>] (pcs_dt_node_to_map+0x4b0/0x81c)
> [    6.196441] [<c043203c>] (pcs_dt_node_to_map) from [<c042ffd4>] (pinctrl_dt_to_map+0x1ec/0x2b8)
> [    6.205535] [<c042ffd4>] (pinctrl_dt_to_map) from [<c042d028>] (create_pinctrl+0x58/0x2f8)
> [    6.214141] [<c042d028>] (create_pinctrl) from [<c042d388>] (devm_pinctrl_get+0x2c/0x6c)
> [    6.222625] [<c042d388>] (devm_pinctrl_get) from [<c04f2e9c>] (pinctrl_bind_pins+0x3c/0x138)
> [    6.231445] [<c04f2e9c>] (pinctrl_bind_pins) from [<c04d3eb8>] (driver_probe_device+0xe8/0x318)
> [    6.240509] [<c04d3eb8>] (driver_probe_device) from [<c04d4168>] (__driver_attach+0x80/0xa4)
> [    6.249328] [<c04d4168>] (__driver_attach) from [<c04d264c>] (bus_for_each_dev+0x58/0x7c)
> 
> Apparently I didn't notice that pcs_parse_*_pinctrl_entry() are called
> inside pcs_dt_node_to_map() and are part of the call sequence.
> 
> Hence your new mutex locks calls to pinctrl_generic_add_group() as
> needed.
> 
> Obviously, the compiler has optimized away the nested calls to static
> functions and I had no previous experience with how the whole pinctrl code
> works (learning by debugging :).
> 
> So it looks sane and no need for further locks.

OK thanks for checking it.

Regards,

Tony
