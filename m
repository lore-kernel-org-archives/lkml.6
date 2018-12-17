Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD969C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B542133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbeLQMDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:03:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:57706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726831AbeLQMDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:03:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8ACF1AE88;
        Mon, 17 Dec 2018 12:03:52 +0000 (UTC)
Date:   Mon, 17 Dec 2018 13:03:51 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Nicholas Mc Guire <hofrat@osadl.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] livepatch: fix non-static warnings
In-Reply-To: <1544965657-26804-1-git-send-email-hofrat@osadl.org>
Message-ID: <alpine.LSU.2.21.1812171256390.3087@pobox.suse.cz>
References: <1544965657-26804-1-git-send-email-hofrat@osadl.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry for being late to the party.

On Sun, 16 Dec 2018, Nicholas Mc Guire wrote:

> Sparse reported warnings about non-static symbols. For the variables
> a simple static attribute is fine - for those symbols referenced by
> livepatch via klp_func the symbol-names must be unmodified in the
> symbol table - to resolve this the __noclone attribute is used
> for the shared statically declared functions.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Link: https://lkml.org/lkml/2018/12/13/827

A nit, but I'd reorder the tags. Link, Suggested-by:, Signed-off-by:. Also 
it would be great if you used https://lkml.kernel.org/r/${Msg-ID} 
redirection.

> ---
> 
> V2: not all static functions shared need to carry the __noclone
>     attribute only those that need to be resolved at runtime by
>     livepatch - so drop the unnecessary __noclone attributes as
>     well as the Note on __noclone as suggested by Joe Lawrence
>     <joe.lawrence@redhat.com> - thanks !

I talked to Martin Jambor (GCC) and he suggested __attribute__((used)). It 
should be better than __noclone, which was reportedly implemented only for 
testing purposes (which is why it does not imply noinline, although 
inlining internally uses cloning). Newer gcc also has "noipa" attribute, 
but "used" would definitely be safe.

Sorry for not responding earlier.

Miroslav
 
> Sparse reported the following findings:
> 
> CHECK   samples/livepatch/livepatch-shadow-mod.c
> samples/livepatch/livepatch-shadow-mod.c:99:1: warning: symbol
>  'dummy_list' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-mod.c:100:1: warning: symbol
>  'dummy_list_mutex' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-mod.c:107:23: warning: symbol
>  'dummy_alloc' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-mod.c:128:15: warning: symbol
>  'dummy_free' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-mod.c:136:15: warning: symbol
>  'dummy_check' was not declared. Should it be static?
> 
> CHECK   samples/livepatch/livepatch-shadow-fix1.c
> samples/livepatch/livepatch-shadow-fix1.c:74:14: warning: symbol
>  'livepatch_fix1_dummy_alloc' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-fix1.c:111:6: warning: symbol
>  'livepatch_fix1_dummy_free' was not declared. Should it be static?
> 
> CHECK   samples/livepatch/livepatch-shadow-fix2.c
> samples/livepatch/livepatch-shadow-fix2.c:53:6: warning: symbol
>  'livepatch_fix2_dummy_check' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-fix2.c:81:6: warning: symbol
>  'livepatch_fix2_dummy_free' was not declared. Should it be static?
> 
> Patch was compile tested with: x86_64_defconfig + FTRACE=y
> FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y,
> SAMPLE_LIVEPATCH=y
> 
> Patch was runtested with:
>    insmod samples/livepatch/livepatch-shadow-mod.ko
>    insmod samples/livepatch/livepatch-shadow-fix1.ko
>    insmod samples/livepatch/livepatch-shadow-fix2.ko
>    echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix2/enabled
>    echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix1/enabled
>    rmmod livepatch-shadow-fix2
>    rmmod livepatch-shadow-fix1
>    rmmod livepatch-shadow-mod
> and dmesg output compared with the run before the patch was
> applied.
