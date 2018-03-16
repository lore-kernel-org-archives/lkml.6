Return-Path: <kernel-hardening-return-12678-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELue/rsBNDqdnopLemq7mRMBG/tD0vLy3DmnVjYFoQ0O7/56PnNDKgbAw1VqV9qq3bzcIf9G
ARC-Seal: i=1; a=rsa-sha256; t=1521239924; cv=none;
        d=google.com; s=arc-20160816;
        b=h7EvXtAm3INR5ERz7fNneQzmgEkCR0TwBnSYz7vXYGwOSb4+bm4BL8UtHTDVukCNud
         symXCOjAi+iNw7mVffyUtjZJ7zTYRI50U0LMaiCa+m5To8KsLqijmrkm9PPcgyeQFU5c
         eBHMAYpQ1G9VFPUIUfS4GfOieyuOe2AuBwLYIlcLikCDxcjVVXRIezaCLjRY+0+jb9+5
         IGodLlXJE42J75RjnrgKNxJsIPlzFrAl4K2Cn54VzAdtxNyjcAP3DsVxfm0LT2GhRwxr
         M8UFdq3l442ZtXHgPWdmGORyvtUflpZEa01MhKjjJTfP9TZ45Ze7VYFoF5uHFLYYaDZA
         7GhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=NOM9wjFHDXHGzfI0HGLvJFI1bJo5043weECEbEr9d04=;
        b=dP6CqRq9UpujmK1P2uQq2bXx68JnqV6QULy05OYpIp56b9iuV78abMEhtn/QNuhT1+
         2ttw+v4E6D4S71Kgq5wcPliyt/NyQ/rw8Gsl7qlTDVwf5ZfD9vU9TYDqYAp28hLibOmy
         CCGhTitjE4BEQh4EsnCBFl7HV2fYKO4fq9C246/7+yCeUDac44iMRiVp7uLIzefAB6p1
         F7aJTXJSQsMp1tt5cqAsAlscpwQDjP169mP7Ke/p3RoosCm4q4aklOFl+kxcB7bryQ4w
         uCFcwQKyPlaG7p9t1+ISQWyBjxCt+B/5yxBAaNQVbxn79RHP7PFYbIrWBqBSw9JCGNTg
         57Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12678-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12678-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12678-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12678-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 16 Mar 2018 15:38:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Segher Boessenkool
 <segher@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] rslib: Remove VLAs by setting upper bound on nroots
Message-Id: <20180316153822.e169251b57165a52494aace7@linux-foundation.org>
In-Reply-To: <20180315225919.GA43806@beast>
References: <20180315225919.GA43806@beast>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595046396754035881?=
X-GMAIL-MSGID: =?utf-8?q?1595135675062443519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Mar 2018 15:59:19 -0700 Kees Cook <keescook@chromium.org> wrote:

> Avoid stack VLAs[1] by always allocating the upper bound of stack space
> needed. The existing users of rslib appear to max out at 24 roots[2],
> so use that as the upper bound until we have a reason to change it.
> 
> Alternative considered: make init_rs() a true caller-instance and
> pre-allocate the workspaces. This would possibly need locking and
> a refactoring of the returned structure.
> 
> Using kmalloc in this path doesn't look great, especially since at
> least one caller (pstore) is sensitive to allocations during rslib
> usage (it expects to run it during an Oops, for example).
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> [2] https://lkml.org/lkml/2018/3/9/838

Yeah, email [2] is rather important.  This patch is a bit of a pig to
review!

The restriction to 24 roots might be a significant one, dunno.  Perhaps
we should just kmalloc these things?

Otherwise, RS_MAX_ROOTS becomes part of the rs interface and should be
documented and published in rslib.h?
