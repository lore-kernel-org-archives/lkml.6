Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC8C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E6D2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549292940;
	bh=0yapeJxB3zPoX9F9sw8eJAasbtbnYRu1nEgcp1Mmtk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MbYgW9eygnPvE7UMOvXTQdK3GgXb9wjAeYWrNWQQMhP5IgKFcMeX3as+KvTHIrddy
	 Sud8kTCOHiXYwMyw5d1n2w+fAv6afGd2D0TGYRPF7kE8S3TZ2Pi/XhX9qxGd+RsbWE
	 NRb8FtXhCiBmxvEf7ls9S0+yfw93/jmLU+oorwME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfBDPI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbfBDPI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:08:58 -0500
Received: from linux-8ccs (ip5f5ade5c.dynamic.kabel-deutschland.de [95.90.222.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0185B2082E;
        Mon,  4 Feb 2019 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549292937;
        bh=0yapeJxB3zPoX9F9sw8eJAasbtbnYRu1nEgcp1Mmtk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ol6S9TElF+PXdN8WoIqWO/9EbUzj6y6z5CLijzWon+ZFz7zqIECAmO08KwtInsPGe
         QlGdDY3emntKRdEf7jaQ8VDGiJ2YRQuNIPH6kmA3oPxDILLpQRQXQfcCWN5WdN5Cpk
         NuRv+JPOJJrRGkLEJCkeCJX6eNs3PHjhrE2e2NRE=
Date:   Mon, 4 Feb 2019 16:08:52 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/module.h: mark init/cleanup_module aliases
 as __cold
Message-ID: <20190204150852.GA24444@linux-8ccs>
References: <20190123173707.GA16603@gmail.com>
 <20190131142221.GA26303@linux-8ccs>
 <CANiq72m8VuD_dsA+=0q88FRJgVnnSS1pt1SAFf9upGS7RFjT_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANiq72m8VuD_dsA+=0q88FRJgVnnSS1pt1SAFf9upGS7RFjT_g@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miguel Ojeda [31/01/19 17:48 +0100]:
>Hi Jessica,
>
>On Thu, Jan 31, 2019 at 3:22 PM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> Hi Miguel, sorry for the delay!
>
>No worries! :)
>
>> The module init functions are only called once from do_init_module().
>> Does the __cold attribute just assume it is unlikely to be executed,
>> or just that it is infrequently called (which would be true for the
>> module init functions since they're just called once)?
>
>That was exactly my concern :-) Martin can provide way better details
>than me, but as far as I understand it, it is the paths that end up
>calling __cold functions that are treated as unlikely to happen. For
>instance, if f() has a few branches and calls a cold g() in one of
>them, that branch is understood to be rarely executed and f() will be
>laid out assuming the other branches are more likely.
>
>Then there is the other aspect of __cold, in the definition of the
>function. There, it affects how it is compiled and where it is placed,
>etc.
>
>Therefore, I assume the current situation is the correct one: we want
>to callers to *not* see __cold, but we want the init function to be
>compiled as __cold.
>
>Now, the alias is not seen by other TUs (i.e. they only see the extern
>declaration), so it does not matter whether the alias is cold or not
>(except for the warning), as far as I understand.
>
>> In any case, module init functions are normally annotated with __init,
>> so they get the __cold attribute anyway. I'm wondering why not just
>> annotate the alias with __init instead, instead of cherry picking
>> attributes to silence the warnings? That way the alias and the actual
>> module init function would always have the same declaration/attributes.
>> Would this work to silence the warnings or am I missing something?
>
>We could do indeed do that too (Martin actually proposed a solution
>with the new copy attribute, which would do something like that).
>
>I chose to only add __cold to avoid any problems derived from the rest
>of the attributes, since I don't know how they behave or what are the
>implications (if any) of putting them into the alias (and not into the
>extern declaration).

IMHO I think annotating with __init is more straightforward, instead
of cherry-picking attributes (we wouldn't know at first glance why the
aliases are specifically annotated with __cold without looking at git
history). Plus the actual module init function and alias declarations
would be consistent. Just looking at the __init attributes:

    #define __init		__section(.init.text) __cold  __latent_entropy __noinitretpoline

__section(.init.text) - alias already has same section ndx as the
target symbol so this doesn't have any effect.

__latent_entropy - according to commit 0766f788eb7, if this attribute
is used on a function then the plugin will utilize it for gathering
entropy (apparently a local variable is created in every marked
function, the value of which is modified randomly, and before function
return it will write into the latent_entropy global variable). Module
init functions are already annotated with this since they are
annotated with __init, I don't think marking the alias would do any
harm.

__noinitretpoline - compiled away if the function is in a module and
not built-in. The alias is not utilized if the module is built-in. So
this wouldn't apply to the alias.

Unfortunately I don't have gcc9 set up on my machine so I can't
actually test if it gets rid of all the warnings, so testing this
would be appreciated :)

Thanks,

Jessica
