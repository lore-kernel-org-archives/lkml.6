Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41316C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1385320861
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfAXRGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:06:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbfAXRGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:06:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 853A080F8D;
        Thu, 24 Jan 2019 17:05:59 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D38317DCC;
        Thu, 24 Jan 2019 17:05:58 +0000 (UTC)
Subject: Re: [PATCH V4] livepatch: non static warnings fix
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1548294496-22719-1-git-send-email-hofrat@osadl.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <8e7e6945-e06e-04e0-2cbf-42e11d906e1f@redhat.com>
Date:   Thu, 24 Jan 2019 12:05:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548294496-22719-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 24 Jan 2019 17:05:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 8:48 PM, Nicholas Mc Guire wrote:
> Sparse reported warnings about non-static symbols. For the variables
> a simple static attribute is fine - for the functions referenced by
> livepatch via klp_func the symbol-names must be unmodified in the
> symbol table and the patchable code has to be emitted. The resolution
> is to attach __used attribute to the shared statically declared functions.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> Link: https://lore.kernel.org/lkml/1544965657-26804-1-git-send-email-hofrat@osadl.org/

Hi Nicholas, thanks for re-posting this fix, the __used attribute change 
was particularly interesting to learn about.

I think Miroslav requested a re-ordering of these tags, perhaps we could 
do the shuffle when we apply the patch to the tree?

   Link:
   Suggested-by:
   Signed-off-by:
   Acked-by:

With that,

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>


> ---
> 
> V2: not all static functions shared need to carry the __noclone
>      attribute only those that need to be resolved at runtime by
>      livepatch - so drop the unnecessary __noclone attributes as
>      well as the Note on __noclone as suggested by Joe Lawrence
>      <joe.lawrence@redhat.com> - thanks !
> 
> V3: fix the wording as proposed by Joe Lawrence
>      <joe.lawrence@redhat.com> to address that this is not only
>      about how to fix sparse warnings but also to ensure
>      traceable/patchable code still being emitted.
> 
> V4: fix up the Link to point to the proper page as suggested
>      by Joe Lawrence <joe.lawrence@redhat.com>.

Credit to Miroslav for these last two change suggestions.

-- Joe

> Sparse reported the following findings in 5.0-rc3:
> 
>    CHECK   samples/livepatch/livepatch-shadow-mod.c
> samples/livepatch/livepatch-shadow-mod.c:99:1: warning: symbol 'dummy_list' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-mod.c:100:1: warning: symbol 'dummy_list_mutex' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-mod.c:107:23: warning: symbol 'dummy_alloc' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-mod.c:132:15: warning: symbol 'dummy_free' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-mod.c:140:15: warning: symbol 'dummy_check' was not declared. Should it be static?
> 
>    CHECK   samples/livepatch/livepatch-shadow-fix1.c
> samples/livepatch/livepatch-shadow-fix1.c:74:14: warning: symbol 'livepatch_fix1_dummy_alloc' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-fix1.c:116:6: warning: symbol 'livepatch_fix1_dummy_free' was not declared. Should it be static?
> 
>    CHECK   samples/livepatch/livepatch-shadow-fix2.c
> samples/livepatch/livepatch-shadow-fix2.c:53:6: warning: symbol 'livepatch_fix2_dummy_check' was not declared. Should it be static?
> samples/livepatch/livepatch-shadow-fix2.c:81:6: warning: symbol 'livepatch_fix2_dummy_free' was not declared. Should it be static?
> 
> Patch was compile tested with: x86_64_defconfig + FTRACE=y
> FUNCTION_TRACER=y, SAMPLES=y, LIVEPATCH=y SAMPLE_LIVEPATCH=m
> (looks sparse, smatch claan, one coccichek warning left - fix later today)
> 
> Patch was runtested with:
>     insmod samples/livepatch/livepatch-shadow-mod.ko
>     insmod samples/livepatch/livepatch-shadow-fix1.ko
>     insmod samples/livepatch/livepatch-shadow-fix2.ko
>     echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix2/enabled
>     echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix1/enabled
>     rmmod livepatch-shadow-fix2
>     rmmod livepatch-shadow-fix1
>     rmmod livepatch-shadow-mod
> and dmesg output compared to previous run.
> 
> Patch is against 5.0-rc3 (localversion-next is next-20190123)
> 
>   samples/livepatch/livepatch-shadow-fix1.c |  4 ++--
>   samples/livepatch/livepatch-shadow-fix2.c |  4 ++--
>   samples/livepatch/livepatch-shadow-mod.c  | 11 ++++++-----
>   3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
> index a5a5cac..67a73e5 100644
> --- a/samples/livepatch/livepatch-shadow-fix1.c
> +++ b/samples/livepatch/livepatch-shadow-fix1.c
> @@ -71,7 +71,7 @@ static int shadow_leak_ctor(void *obj, void *shadow_data, void *ctor_data)
>   	return 0;
>   }
>   
> -struct dummy *livepatch_fix1_dummy_alloc(void)
> +static struct dummy *livepatch_fix1_dummy_alloc(void)
>   {
>   	struct dummy *d;
>   	void *leak;
> @@ -113,7 +113,7 @@ static void livepatch_fix1_dummy_leak_dtor(void *obj, void *shadow_data)
>   			 __func__, d, *shadow_leak);
>   }
>   
> -void livepatch_fix1_dummy_free(struct dummy *d)
> +static void livepatch_fix1_dummy_free(struct dummy *d)
>   {
>   	void **shadow_leak;
>   
> diff --git a/samples/livepatch/livepatch-shadow-fix2.c b/samples/livepatch/livepatch-shadow-fix2.c
> index 52de947..91c21d5 100644
> --- a/samples/livepatch/livepatch-shadow-fix2.c
> +++ b/samples/livepatch/livepatch-shadow-fix2.c
> @@ -50,7 +50,7 @@ struct dummy {
>   	unsigned long jiffies_expire;
>   };
>   
> -bool livepatch_fix2_dummy_check(struct dummy *d, unsigned long jiffies)
> +static bool livepatch_fix2_dummy_check(struct dummy *d, unsigned long jiffies)
>   {
>   	int *shadow_count;
>   
> @@ -78,7 +78,7 @@ static void livepatch_fix2_dummy_leak_dtor(void *obj, void *shadow_data)
>   			 __func__, d, *shadow_leak);
>   }
>   
> -void livepatch_fix2_dummy_free(struct dummy *d)
> +static void livepatch_fix2_dummy_free(struct dummy *d)
>   {
>   	void **shadow_leak;
>   	int *shadow_count;
> diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
> index 4aa8a88..4d79c6dc 100644
> --- a/samples/livepatch/livepatch-shadow-mod.c
> +++ b/samples/livepatch/livepatch-shadow-mod.c
> @@ -96,15 +96,15 @@ MODULE_DESCRIPTION("Buggy module for shadow variable demo");
>    * Keep a list of all the dummies so we can clean up any residual ones
>    * on module exit
>    */
> -LIST_HEAD(dummy_list);
> -DEFINE_MUTEX(dummy_list_mutex);
> +static LIST_HEAD(dummy_list);
> +static DEFINE_MUTEX(dummy_list_mutex);
>   
>   struct dummy {
>   	struct list_head list;
>   	unsigned long jiffies_expire;
>   };
>   
> -noinline struct dummy *dummy_alloc(void)
> +static __used noinline struct dummy *dummy_alloc(void)
>   {
>   	struct dummy *d;
>   	void *leak;
> @@ -129,7 +129,7 @@ noinline struct dummy *dummy_alloc(void)
>   	return d;
>   }
>   
> -noinline void dummy_free(struct dummy *d)
> +static __used noinline void dummy_free(struct dummy *d)
>   {
>   	pr_info("%s: dummy @ %p, expired = %lx\n",
>   		__func__, d, d->jiffies_expire);
> @@ -137,7 +137,8 @@ noinline void dummy_free(struct dummy *d)
>   	kfree(d);
>   }
>   
> -noinline bool dummy_check(struct dummy *d, unsigned long jiffies)
> +static __used noinline bool dummy_check(struct dummy *d,
> +					   unsigned long jiffies)
>   {
>   	return time_after(jiffies, d->jiffies_expire);
>   }
>
