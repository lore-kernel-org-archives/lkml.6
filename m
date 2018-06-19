Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EA3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C9720874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C9720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755536AbeFSEeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:34:14 -0400
Received: from muru.com ([72.249.23.125]:47964 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbeFSEeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:34:12 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 792F58081;
        Tue, 19 Jun 2018 04:36:53 +0000 (UTC)
Date:   Mon, 18 Jun 2018 21:34:08 -0700
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
Message-ID: <20180619043408.GT112168@atomide.com>
References: <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com>
 <CAHp75Vf7-xcsoSJ--9nJYbxpwSfDv201UwnxJHoFbwtD187SPw@mail.gmail.com>
 <20180618091433.GP112168@atomide.com>
 <BB5DB278-9827-4351-99DF-54C875B1879F@goldelico.com>
 <20180618095428.GQ112168@atomide.com>
 <CA+Ot1OxNj30KgHWJHXgWbnXYkNXTNvd_t-b6+uG3u=z8+pZf2Q@mail.gmail.com>
 <20180618115122.GT26255@atomide.com>
 <CDD8B994-59E9-42DC-A77D-AF4F35EBF101@goldelico.com>
 <20180618181744.GS112168@atomide.com>
 <404C63D9-169E-4051-88E0-2856F3602A72@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404C63D9-169E-4051-88E0-2856F3602A72@goldelico.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [180618 18:33]:
> >> So code just needs group cleanup on failed probing and fixing the mutex around pinctrl_generic_add_group().
> >> 
> >> I think we need the mutex because a race still can happen when create_pinctrl() is calling pcs_dt_node_to_map()
> >> and pinctrl_generic_add_group() w/o being locked on pinctrl_maps_mutex.
> >> 
> >> The race I suspect is that two drivers are trying to insert the same name and may come
> >> both to the conclusion that it does not yet exist. And both insert into the radix tree.
> >> 
> >> The window of risk is small though... It is in pinctrl_generic_add_group() between calling
> >> pinctrl_generic_group_name_to_selector() and radix_tree_insert() so we probably won't
> >> see it in real hardware tests.
> > 
> > Hmm but that race should be already fixed with mutex held
> > by the pin controller drivers with these fixes? Or am I
> > missing something still?
> 
> Hm. Maybe we refer to a different mutex?

Yes I think that's the case, you're talking about a different
mutex here :)

> I had seen the call sequence
> 
> create_pinctrl()-> pinctrl_dt_to_map() -> pcs_dt_node_to_map() -> pinctrl_generic_add_group()
> 
> w/o any lock inside.
> 
> There is a mutex_lock(&pinctrl_maps_mutex); in create_pinctrl(), but locked after that.
> 
> Or is there a lock outside of create_pinctrl()?
> 
> If I look into the stack dumps, call nesting is
> 
> driver_probe_device() -> pinctrl_bind_pins() -> devm_pinctrl_get() -> create_pinctrl()
> 
> They all do no locking.
> 
> Maybe I am missing something.

Can you please post a patch for that as you already have it
debugged? That's easier to understand than reading a verbal
patch :)

Regards,

Tony
