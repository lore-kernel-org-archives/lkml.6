Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70316C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A215218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfBHJYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:24:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:41934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbfBHJYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:24:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1FE69AC70;
        Fri,  8 Feb 2019 09:24:23 +0000 (UTC)
Date:   Fri, 8 Feb 2019 10:24:21 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc:     Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alice Ferrazzi <alicef@alicef.me>, jeyu@kernel.org,
        jikos@kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH v2] livepatch: core: Return EOPNOTSUPP instead of
 ENOSYS
In-Reply-To: <20190208062005.GA21436@JAVRIS.in.ibm.com>
Message-ID: <alpine.LSU.2.21.1902081013100.24868@pobox.suse.cz>
References: <20190204183324.30775-1-alicef@alicef.me> <20190205155933.r6ey474lq4m5nlmp@treble> <20190206102832.apa7sekkwljo4ejg@pathway.suse.cz> <20190208062005.GA21436@JAVRIS.in.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamalesh,

On Fri, 8 Feb 2019, Kamalesh Babulal wrote:

> On Wed, Feb 06, 2019 at 11:28:32AM +0100, Petr Mladek wrote:
> > On Tue 2019-02-05 09:59:33, Josh Poimboeuf wrote:
> > > On Tue, Feb 05, 2019 at 03:33:28AM +0900, Alice Ferrazzi wrote:
> > > > From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > > > 
> > > > As a result of an unsupported operation is better to use EOPNOTSUPP
> > > > as error code.
> > > > ENOSYS is only used for 'invalid syscall nr' and nothing else.
> > > > 
> > > > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > > 
> > > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > I have applied the patch into for-5.1/atomic-replace branch.
> 
> Sorry to jump into the discussion so late. Thinking a little more about
> the check itself, previously with immediate flag an architecture can do
> livepatching with limitations and without the reliable stack trace
> implemented yet.
> 
> After removal of the immediate flag by
> commit d0807da78e11 ("livepatch: Remove immediate feature"), every
> architecture enabling livepatching is required to have implemented
> reliable stack trace.  Is it a better idea to make
> HAVE_RELIABLE_STACKTRACE a config dependency, which will disable
> livepatching support for architectures without reliable stack trace
> function during kernel build?

if I am not mistaken, s390x is currently the only one which is supported 
(the redirection works) but has no reliable stacktraces (so far, it is my 
plan to take a look soon).

Theoretically, it could still work. We have the fake signal and we can 
force the remaining tasks (kthreads). It is not something to be used in 
production but it could make sense for a limited testing.
 
> The idea is to remove klp_have_reliable_stack() by moving
> CONFIG_HAVE_RELIABLE_STACKTRACE as a config dependency to Kconfig file
> and adding the other CONFIG_STACKTRACE as a config dependency is not
> required, as it's selected via CONFIG_DYNAMIC_FTRACE_WITH_REGS
> dependency chain. With the patch on architecture without
> HAVE_RELIABLE_STACKTRACE, the user should see:
> 
> # insmod ./livepatch-sample.ko 
> insmod: ERROR: could not insert module ./livepatch-sample.ko: Invalid module format
> 
> # dmesg
> ...
> [  286.453463] livepatch_sample: module is marked as livepatch module, but livepatch support is disabled
> 
> I have done limited testing on PowerPC and to test the unsupported case,
> the config dependency HAVE_RELIABLE_STACKTRACE was misspelled in Kconfig
> file. If the idea sounds ok I will send a formal patch.
> 
> -------8<----------------------------
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 53551f470722..7848c7bbffbb 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -214,12 +214,6 @@ static inline bool klp_patch_pending(struct task_struct *task)
>         return test_tsk_thread_flag(task, TIF_PATCH_PENDING);
>  }
>  
> -static inline bool klp_have_reliable_stack(void)
> -{
> -       return IS_ENABLED(CONFIG_STACKTRACE) &&
> -              IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
> -}
> -
>  typedef int (*klp_shadow_ctor_t)(void *obj,
>                                  void *shadow_data,
>                                  void *ctor_data);
> diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
> index ec4565122e65..16b3692ddf9f 100644
> --- a/kernel/livepatch/Kconfig
> +++ b/kernel/livepatch/Kconfig
> @@ -9,6 +9,7 @@ config LIVEPATCH
>         depends on MODULES
>         depends on SYSFS
>         depends on KALLSYMS_ALL
> +       depends on HAVE_RELIABLE_STACKTRACE
>         depends on HAVE_LIVEPATCH
>         depends on !TRIM_UNUSED_KSYMS
>         help
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index fe1993399823..9a80f7574d75 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -1002,12 +1002,6 @@ int klp_enable_patch(struct klp_patch *patch)
>         if (!klp_initialized())
>                 return -ENODEV;
>  
> -       if (!klp_have_reliable_stack()) {
> -               pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
> -               return -ENOSYS;
> -       }
> -
> -
>         mutex_lock(&klp_mutex);
>  
>         ret = klp_init_patch_early(patch);

On the other hand, I like this change. So we have two options, I think. 
We can apply this and wait if someone complains (because of s390x 
testing), or we can wait for the full support of s390x and then enforce 
it.

Thanks,
Miroslav
