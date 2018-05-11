Return-Path: <kernel-hardening-return-13283-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqDFmTxvUJYIZ8MM5TlkyVBIKoXr8XHoFUj5qM03zQoisXwSprTduB52Tb7QrvCMkSRVh/o
ARC-Seal: i=1; a=rsa-sha256; t=1526054977; cv=none;
        d=google.com; s=arc-20160816;
        b=F9AuuzzfLGgIozgUBJUrqBUFLLxYdn6LvdgzJm6vT79Mr+T5Gl0WAU37SpETmmgpuR
         TtWgR7YFR81AFQ648tsJ1dYefPI52HuOezCPRRUTfTLxCKfwOpRfodtfGpMfCM99lSjD
         65oFaGmHtMV7QZuClt0PfchOVi0AaT1kk7IvlRUjdbUWfzX3U7yhMosdYRQm/131u+av
         6yo3AhLY2PSbHAtPeaRHj3X2FvOpcWvHqvK1rUqjOdtaPqmTZKEHvRim9z9hEIhM3irD
         8/By4f9PvB15fubWWHssreeV0U5Dm8wiA+04MtyivV4BHAlCZ8bsAPY9+o3FNPtspqdr
         q2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=u0roL1AYuIrA84f7PfbcurharhvJnLawyPtqvEvc2wY=;
        b=Nwhi63tw7ACHYzPliuQmfEsAkrTswfpgBGk24zfkz+EH4seTXLORRluP5tdBD4bfYA
         6EKJe2rEtwdIRaTBrSlKvLwW+sV5iNKaRFESpPYAC5SkSkdakYBBJe8f6xokiKt2kEyV
         Fj5mUFuUDW3rEKU1jKqI6twBkUcRTb/VtbC9GUolGFwjtLpcxKypIIoonLL9rCw5iZ6F
         LBb6ckTgkcAO6p18yIxFkoR7aJPQOqYUeXFrstH5nNC6Ex+edF02TWjD+hNOKi5Zrh5c
         vG1bf0B4qUAi+4EkvOPbKJesgCpQVvVL0yG0DlP/WT+AURv2sA6hhMh91p408g5NIUaA
         mmxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=merlin.20170209 header.b=uPkWOCGL;
       spf=pass (google.com: domain of kernel-hardening-return-13283-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13283-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=merlin.20170209 header.b=uPkWOCGL;
       spf=pass (google.com: domain of kernel-hardening-return-13283-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13283-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v5 5/7] proc: instantiate only pids that we can ptrace on
 'limit_pids=1' mount option
To: Alexey Gladkov <gladkov.alexey@gmail.com>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
 linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Akinobu Mita <akinobu.mita@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Jeff Layton <jlayton@poochiereds.net>, Ingo Molnar <mingo@kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 aniel Micay <danielmicay@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 bfields@fieldses.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 solar@openwall.com, "Dmitry V. Levin" <ldv@altlinux.org>,
 Djalal Harouni <tixxdz@gmail.com>
References: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7c638a92-8c40-fa15-8c63-777232588137@infradead.org>
Date: Fri, 11 May 2018 09:09:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600160501137363008?=
X-GMAIL-MSGID: =?utf-8?q?1600184623883850460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/11/2018 02:36 AM, Alexey Gladkov wrote:
> From: Djalal Harouni <tixxdz@gmail.com>
> 
> If "limit_pids=1" mount option is set then do not instantiate pids that
> we can not ptrace. "limit_pids=1" means that procfs should only contain
> pids that the caller can ptrace.

Where can I find documentation on these mount options (pidonly, limit_pids)?

Thanks.

> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
> ---
>  fs/proc/base.c | 9 +++++++++
>  1 file changed, 9 insertions(+)


-- 
~Randy
