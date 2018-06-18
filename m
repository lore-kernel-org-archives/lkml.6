Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3586C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D58208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D58208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755041AbeFRGq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:46:56 -0400
Received: from muru.com ([72.249.23.125]:47582 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754886AbeFRGqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:46:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E7F578081;
        Mon, 18 Jun 2018 06:49:34 +0000 (UTC)
Date:   Sun, 17 Jun 2018 23:46:51 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] BUG: drivers/pinctrl/core: races in
 pinctrl_groups and deferred probing
Message-ID: <20180618064651.GL112168@atomide.com>
References: <F20BD6B3-D4D7-4D5D-B464-64402650BDE5@goldelico.com>
 <20180614120157.GE112168@atomide.com>
 <FC373DE9-6D6B-40C5-ACED-C07B1B524469@goldelico.com>
 <20180615065810.GI112168@atomide.com>
 <20180615111318.GJ112168@atomide.com>
 <029F115C-480E-485A-B547-9D5873925CEF@goldelico.com>
 <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE2E482-B0D3-4799-9E2D-74E2180B305B@goldelico.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [180616 11:10]:
> There is also good news: the selectors are now assigned in strict sequence.
> This is a big improvement:

OK thanks for testing.

> If slots 17 and 18 do not really exist (or are deleted after failed probing), there is
> a NULL return. Which triggers the strcmp(NULL), because the strcmp is not guarded against
> non-existing slots in the radix tree.
> 
> So a simple workaround could be:
> 
> 		if (gname && !strcmp(gname, pin_group)) {
> 
> But I think the fundamental problem is that the same driver assigns multiple slots if
> probing is deferred.
> 
> Therefore, I tried to find out more why this happens. Here are some more observations by
> studying the code and adding a dump_stack() inside pinctrl_generic_add_group():
> 
> 1.  the records stored in the radix tree are allocated through devm_kzalloc() within
>     pinctrl_generic_add_group().
> 2.  I have not found a mechanism that removes them from the radix tree if they are
>     devm freed which IMHO happens if the probe fails (and all devm objects are
>     rewound).
> 3.  I could not observe calls to pinctrl_generic_remove_group()
> 4.  this means a stale pointer to the group_desc is still stored in the radix tree
>     if driver probing fails
> 5.  scanning through the radix tree for a matching gname in pinctrl_get_group_selector()
>     accesses this stale radix tree entry.
>     It has either been overwritten by something else - or contains a dangling pointer for
>     group->name. This explains the randomness of the problem but that it is also repeatable
>     to some extent. For a pure race of some 100 instructions it happens IMHO too often.
> 6.  the pinctrl_generic_add_group() is called from create_pinctrl() through 
>     pinctrl_dt_to_map() and pcs_dt_node_to_map(), i.e. before the pinctrl_maps_mutex
>     is locked in create_pinctrl(). This means that pinctrl_generic_add_group() is
>     not locked in this case.
> 
> I hope this helps to pinpoint and solve the remaining bugs.

Yes sounds like that's where things still go wrong. I'll take a look
if it makes sense to assign the selector from the pin controller
driver instead or just ignoring the holes.

I'll try to debug the devm issue too.

Regards,

Tony
