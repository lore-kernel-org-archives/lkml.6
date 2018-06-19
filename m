Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E68C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C199C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C199C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756205AbeFSGLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:11:07 -0400
Received: from muru.com ([72.249.23.125]:47996 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755560AbeFSGLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:11:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CC3EB8081;
        Tue, 19 Jun 2018 06:13:46 +0000 (UTC)
Date:   Mon, 18 Jun 2018 23:11:02 -0700
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
Message-ID: <20180619061102.GU112168@atomide.com>
References: <20180618091433.GP112168@atomide.com>
 <BB5DB278-9827-4351-99DF-54C875B1879F@goldelico.com>
 <20180618095428.GQ112168@atomide.com>
 <CA+Ot1OxNj30KgHWJHXgWbnXYkNXTNvd_t-b6+uG3u=z8+pZf2Q@mail.gmail.com>
 <20180618115122.GT26255@atomide.com>
 <CDD8B994-59E9-42DC-A77D-AF4F35EBF101@goldelico.com>
 <20180618181744.GS112168@atomide.com>
 <404C63D9-169E-4051-88E0-2856F3602A72@goldelico.com>
 <20180619043408.GT112168@atomide.com>
 <631A1D2F-093A-498F-8923-FC9CD20E11A8@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <631A1D2F-093A-498F-8923-FC9CD20E11A8@goldelico.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [180619 04:54]:
> >> I had seen the call sequence
> >> 
> >> create_pinctrl()-> pinctrl_dt_to_map() -> pcs_dt_node_to_map() -> pinctrl_generic_add_group()
> >> 
> >> w/o any lock inside.

So the sequence above has mutex added around adding the pin
controller specific functions and groups by the patch series
I posted for both pcs_parse_bits_in_pinctrl_entry() and
pcs_parse_one_pinctrl_entry(). So I think the above should
be fixed now. But please confirm to make sure I'm not mistaken.

> >> There is a mutex_lock(&pinctrl_maps_mutex); in create_pinctrl(), but locked after that.
> >> 
> >> Or is there a lock outside of create_pinctrl()?
> >> 
> >> If I look into the stack dumps, call nesting is
> >> 
> >> driver_probe_device() -> pinctrl_bind_pins() -> devm_pinctrl_get() -> create_pinctrl()
> >> 
> >> They all do no locking.
> >> 
> >> Maybe I am missing something.
> > 
> > Can you please post a patch for that as you already have it
> > debugged? That's easier to understand than reading a verbal
> > patch :)
> 
> I have no patch for it and all tests were without, but I can suggest a change which IMHO
> could solve it:
> 
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> index eb2b217f5e1e..7d125f9a7804 100644
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -1037,15 +1037,16 @@ static struct pinctrl *create_pinctrl(struct device *dev,
>         INIT_LIST_HEAD(&p->states);
>         INIT_LIST_HEAD(&p->dt_maps);
>  
> +       mutex_lock(&pinctrl_maps_mutex);
>         ret = pinctrl_dt_to_map(p, pctldev);
>         if (ret < 0) {
>                 kfree(p);
> +               mutex_unlock(&pinctrl_maps_mutex);
>                 return ERR_PTR(ret);
>         }
>  
>         devname = dev_name(dev);
>  
> -       mutex_lock(&pinctrl_maps_mutex);
>         /* Iterate over the pin control maps to locate the right ones */
>         for_each_maps(maps_node, i, map) {
>                 /* Map must be for this device */
> 
> Description: we should also protect pinctrl_dt_to_map(), which calls pinctrl_generic_add_group()
> and the calls inside pinctrl_generic_add_group() to pinctrl_generic_group_name_to_selector()
> and radix_tree_insert() with a mutex.
> 
> But I haven't tested this case (because it is unlikely to happen and be testable).

Hmm not sure about this one. The groups and functions are
specific to the pin controller driver and must be locked
by the pin controller driver like this series does. So for
pinctrl_generic_add_group() moving the pinctrl_maps_mutex
earlier should not help. We already do the locking for
generic functions and groups like I described above.

For pinctrl maps moving the mutex earlier might make sense
though :) But aren't we doing that already where the list
gets modified in pinctrl_register_map() and when searching
through the list with for_each_maps? Linus got any comments
on this one?

Regards,

Tony
