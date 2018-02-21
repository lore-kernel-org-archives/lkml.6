Return-Path: <kernel-hardening-return-11840-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x22521ZG+tPZKw6yBiyZs9uZNNJuMVV2BYzpg62iDVOr2xMvMTzVEViERNnItdr1ZxYDhfBjs
ARC-Seal: i=1; a=rsa-sha256; t=1519173125; cv=none;
        d=google.com; s=arc-20160816;
        b=O3xAXAybR9+BuabFfUuQdZwRvXWyc+EmK6ngnPlHuQPGJksOuO0g9qaQFVzmpKECsl
         MEKdvKsDI3RKZskWpFh7hDlLf8T0/PmNkSgLF5VZSIVo0eXIfXukI5jOwiX4udzM50Us
         I6MOmeZYH5na6fn9LEHOyuLv/unGW6sTssHC03YA1QKR8+/l17T4sa7btZriirnQAW2S
         1WP1bx1VM6MIJF4UM1pdrKMUoxtKqxWnbv0W2X3lmdu5EaNH8DOrjaNY2jZ5qumypFYi
         TfR8Yn/IlsPrQxHw1FGYoP5dtPJj2/LkQWOnqUrQhMpYYIB3RSYhIlewJW0wjfm8H9Ov
         AiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=2OUc4j5QxbOZ6wtgZN8LtehOt7rOSQB5nmRQ3nfVg5k=;
        b=bHuVAGE0wvvaa5M8tclRbSGoxgmgi9hmNx+XHAsnQgBou/IRGAXbwFTEGWAFoj5tuB
         91OuEp41YlNdINGQwPrJ/1Ij5XcfmoErgsLR9tzehq93fSQshQ1PdZ/rRXOdIK/l6A+q
         yRKRnUJ/rK8KYaJ8aeTR/8K5tvW/q0uLKHYc1M+AYE0nTbgSUatltTeceE9JrMDz1e4X
         WPpF6BjjK/21/s7DE6+7op7uqNq2nKa5cpR7YwYG8BRYfOuZTyUk3yzYtAbqBvZziG42
         vguQ7u1bgm6Fs/YoEAlsdi6uKKBqBuHBe2KkPK8mfPKu3/N6XUq0QZO8cThVHnNWHV+m
         jAdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11840-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11840-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11840-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11840-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 20 Feb 2018 16:31:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>, Ingo
 Molnar <mingo@kernel.org>, Laura Abbott <labbott@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, Sahara
 <keun-o.park@darkmatter.ae>, "Levin, Alexander (Sasha Levin)"
 <alexander.levin@verizon.com>, Michal Hocko <mhocko@suse.com>, Andrea
 Arcangeli <aarcange@redhat.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] fork: Allow stack to be wiped on fork
Message-Id: <20180220163142.15366a82a7bece715b997597@linux-foundation.org>
In-Reply-To: <20180117055015.GA15256@beast>
References: <20180117055015.GA15256@beast>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589817624643319879?=
X-GMAIL-MSGID: =?utf-8?q?1592968479239998312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 16 Jan 2018 21:50:15 -0800 Kees Cook <keescook@chromium.org> wrote:

> One of the classes of kernel stack content leaks is exposing the contents
> of prior heap or stack contents when a new process stack is allocated.
> Normally, those stacks are not zeroed, and the old contents remain in
> place. With some types of stack content exposure flaws, those contents
> can leak to userspace. Kernels built with CONFIG_CLEAR_STACK_FORK will
> no longer be vulnerable to this, as the stack will be wiped each time
> a stack is assigned to a new process. There's not a meaningful change
> in runtime performance; it almost looks like it provides a benefit.
> 
> Performing back-to-back kernel builds before:
> 	Run times: 157.86 157.09 158.90 160.94 160.80
> 	Mean: 159.12
> 	Std Dev: 1.54
> 
> With CONFIG_CLEAR_STACK_FORK=y:
> 	Run times: 159.31 157.34 156.71 158.15 160.81
> 	Mean: 158.46
> 	Std Dev: 1.46
> 
> ...
>
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -904,6 +904,14 @@ config VMAP_STACK
>  	  the stack to map directly to the KASAN shadow map using a formula
>  	  that is incorrect if the stack is in vmalloc space.
>  
> +config CLEAR_STACK_FORK
> +	bool "Clear the kernel stack at each fork"
> +	help
> +	  To resist stack content leak flaws, this clears newly allocated
> +	  kernel stacks to keep previously freed heap or stack contents
> +	  from being present in the new stack. This has almost no
> +	  measurable performance impact.
> +

It would be much nicer to be able to control this at runtime rather
than compile-time.  Why not a /proc tunable?  We could always use more
of those ;)
