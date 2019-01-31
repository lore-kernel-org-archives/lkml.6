Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE82C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11E4218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548944550;
	bh=JQkKzclM+sDWcsXZfLak0nDPgvbp5qU0Sm3OeqeYdMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lc47tHEhljXDUHAx9tZmUQ6nAlFZ7FDzfbQNiTkzj6CockMUT9kqk7A8swemeSOU7
	 3KDsYDAlp+vjoyb4PLUTuFzxnzAzrBUwNYt0lRd9oPXt8gfgWdIJiHUJbvRh7Y5ZYY
	 EjRdBqHKP8Bf3znughhoCr4FfnI4OIffJ2XSiAEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbfAaOW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfAaOW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:22:28 -0500
Received: from linux-8ccs (ip5f5ade58.dynamic.kabel-deutschland.de [95.90.222.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8E1218AC;
        Thu, 31 Jan 2019 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548944546;
        bh=JQkKzclM+sDWcsXZfLak0nDPgvbp5qU0Sm3OeqeYdMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjvWIbqETAC9hwNSzvFox9hCRP0ILbbs6sB/WQefA0FVIRVVchVX88WdWa9ME4sHQ
         t5ARKyQH06TbdMoK/284+1aVtJmTIK58wrP1MVSAQc+yKgCldtdOKMOekQv5HdZKrz
         ZTjn2IbQien+HmUfnUrwGuDP71ZY/pDTiwxFrUw8=
Date:   Thu, 31 Jan 2019 15:22:22 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/module.h: mark init/cleanup_module aliases
 as __cold
Message-ID: <20190131142221.GA26303@linux-8ccs>
References: <20190123173707.GA16603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190123173707.GA16603@gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miguel Ojeda [23/01/19 18:37 +0100]:
>The upcoming GCC 9 release adds the -Wmissing-attributes warnings
>(enabled by -Wall), which trigger for all the init/cleanup_module
>aliases in the kernel (defined by the module_init/exit macros),
>ending up being very noisy.
>
>These aliases point to the __init/__exit functions of a module,
>which are defined as __cold (among other attributes). However,
>the aliases themselves do not have the __cold attribute.
>
>Since the compiler behaves differently when compiling a __cold
>function as well as when compiling paths leading to calls
>to __cold functions, the warning is trying to point out
>the possibly-forgotten attribute in the alias.
>
>In order to keep the warning enabled, we choose to silence
>the warning by marking the aliases as __cold. This is possible
>marking either the extern declaration, the definition, or both.
>In order to avoid changing the behavior of callers, we do it
>only in the definition of the aliases (since those are not
>seen by any other TU).
>
>Suggested-by: Martin Sebor <msebor@gcc.gnu.org>
>Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>---
>Note that an alternative is using the new copy attribute
>introduced by GCC 9 (Martin told me about it, as well as the
>new warning).
>
>What I am concerned about using __copy is that I am not sure
>we should be copying all the attributes (even if some are
>blacklisted by the copy itself), since:
>  - We have unknown-to-GCC attributes (e.g. from plugins).
>  - We wouldn't enjoy the fix for older compilers
>    (e.g. if the fix had an actual impact).
>
>So here I took the conservative approach for the moment,
>and we can discuss/apply whether another solution is best.
>
>Jessica: please review what I explain in the commit message.
>Do we actually want the __cold attribute in the declaration
>as well? If yes, AFAIK, GCC would assume paths that end up
>calling the __init/__exit functions are not meant to be taken
>(but when we are asked to load modules, that is the expected
>path, no?).

Hi Miguel, sorry for the delay!

The module init functions are only called once from do_init_module().
Does the __cold attribute just assume it is unlikely to be executed,
or just that it is infrequently called (which would be true for the
module init functions since they're just called once)?

In any case, module init functions are normally annotated with __init,
so they get the __cold attribute anyway. I'm wondering why not just
annotate the alias with __init instead, instead of cherry picking
attributes to silence the warnings? That way the alias and the actual
module init function would always have the same declaration/attributes.
Would this work to silence the warnings or am I missing something?

Thanks,

Jessica

>I will put this in the compiler-attributes tree and get
>some time in linux-next, unless you want to pick it up!
>
> include/linux/module.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index 8fa38d3e7538..c4e805e87628 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -129,13 +129,13 @@ extern void cleanup_module(void);
> #define module_init(initfn)					\
> 	static inline initcall_t __maybe_unused __inittest(void)		\
> 	{ return initfn; }					\
>-	int init_module(void) __attribute__((alias(#initfn)));
>+	int init_module(void) __cold __attribute__((alias(#initfn)));
>
> /* This is only required if you want to be unloadable. */
> #define module_exit(exitfn)					\
> 	static inline exitcall_t __maybe_unused __exittest(void)		\
> 	{ return exitfn; }					\
>-	void cleanup_module(void) __attribute__((alias(#exitfn)));
>+	void cleanup_module(void) __cold __attribute__((alias(#exitfn)));
>
> #endif
>
>-- 
>2.17.1
>
