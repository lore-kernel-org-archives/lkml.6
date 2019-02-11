Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4A7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E7620869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898733;
	bh=3mCx52JXCu+l7XQ29W7eDYIKFca993Orui2FU4GYNzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jA7xmJYjzSSwlhYhCzKY9QlU3NLMwUqUS6v5vaRQjR01p6MuZjyfyOOPgxBwjV2eb
	 eiCwrvusz5GITbNQNVudSJBVQ/dw/JoPjyhOeYfsPvTTqz2dUJz4vmNvy6FuTZ3EsI
	 6cBOCkKBoIi3R+KcOG8WfWzfAuacn4CZmjwiGUOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390206AbfBKPZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390147AbfBKPBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:01:15 -0500
Received: from linux-8ccs (ip5f5ade6b.dynamic.kabel-deutschland.de [95.90.222.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA3421773;
        Mon, 11 Feb 2019 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897274;
        bh=3mCx52JXCu+l7XQ29W7eDYIKFca993Orui2FU4GYNzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/f0nnUXNOpKTlr3CJ1EOT4Z8K9F34SNrqPUkCP8vnRwuG+nazPiisjUy8fa/R/QS
         bAmOjU928sx6DhKEcWlEIdUtjFfkXcgqYk70CBAkvx/RFvcfRBUTol5XLQu2m7nx+6
         i2OFVPjTFcOey6ckCfi3G/Mt+EUaW2B5uaI+i+Mo=
Date:   Mon, 11 Feb 2019 16:01:09 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] include/linux/module.h: copy __init/__exit attrs to
 init/cleanup_module
Message-ID: <20190211150108.GB20732@linux-8ccs>
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
 <20190209000840.11018-4-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190209000840.11018-4-miguel.ojeda.sandonis@gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miguel Ojeda [09/02/19 01:08 +0100]:
>The upcoming GCC 9 release extends the -Wmissing-attributes warnings
>(enabled by -Wall) to C and aliases: it warns when particular function
>attributes are missing in the aliases but not in their target.
>
>In particular, it triggers for all the init/cleanup_module
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
>In order to keep the warning enabled, we decided to silence
>this case. Ideally, we would mark the aliases directly
>as __init/__exit. However, there are currently around 132 modules
>in the kernel which are missing __init/__exit in their init/cleanup
>functions (either because they are missing, or for other reasons,
>e.g. the functions being called from somewhere else); and
>a section mismatch is a hard error.
>
>A conservative alternative was to mark the aliases as __cold only.
>However, since we would like to eventually enforce __init/__exit
>to be always marked,  we chose to use the new __copy function
>attribute (introduced by GCC 9 as well to deal with this).
>With it, we copy the attributes used by the target functions
>into the aliases. This way, functions that were not marked
>as __init/__exit won't have their aliases marked either,
>and therefore there won't be a section mismatch.
>
>Note that the warning would go away marking either the extern
>declaration, the definition, or both. However, we only mark
>the definition of the alias, since we do not want callers
>(which only see the declaration) to be compiled as if the function
>was __cold (and therefore the paths leading to those calls
>would be assumed to be unlikely).
>
>Link: https://lore.kernel.org/lkml/20190123173707.GA16603@gmail.com/
>Link: https://lore.kernel.org/lkml/20190206175627.GA20399@gmail.com/
>Suggested-by: Martin Sebor <msebor@gcc.gnu.org>
>Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks!

>---
> include/linux/module.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index 8fa38d3e7538..f5bc4c046461 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -129,13 +129,13 @@ extern void cleanup_module(void);
> #define module_init(initfn)					\
> 	static inline initcall_t __maybe_unused __inittest(void)		\
> 	{ return initfn; }					\
>-	int init_module(void) __attribute__((alias(#initfn)));
>+	int init_module(void) __copy(initfn) __attribute__((alias(#initfn)));
>
> /* This is only required if you want to be unloadable. */
> #define module_exit(exitfn)					\
> 	static inline exitcall_t __maybe_unused __exittest(void)		\
> 	{ return exitfn; }					\
>-	void cleanup_module(void) __attribute__((alias(#exitfn)));
>+	void cleanup_module(void) __copy(exitfn) __attribute__((alias(#exitfn)));
>
> #endif
>
>-- 
>2.17.1
>
