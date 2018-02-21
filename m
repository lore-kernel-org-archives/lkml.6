Return-Path: <kernel-hardening-return-11845-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224RweS5WPnrE8abTuvMkxGvLjKgxEXeG7T/zOCDYBUPW7CUMpwslNZojHcUE6U3sDvYxySU
ARC-Seal: i=1; a=rsa-sha256; t=1519178233; cv=none;
        d=google.com; s=arc-20160816;
        b=UJoadOpxg9qRkpP1std5YkgX5vxVeMxZkpJmA9hjPYrfb7auYn+0VI3dsF2I4cCeOg
         MQId5wMldubO8nIKjURpmzQ3sBQNmvtKeBUqEIm7V5biK2b1Lw9ULJbWHmA1q5RTP280
         S+lxmS8FTL+0oBPhMeIiPxyw3x1NODBnK1rrZIs8QNaOcOmImtRI4gA3claDLAnA7rly
         TD2uoBhZ57ue4s+bmJx0/esKv+9UduAMLKvic5uszrZtgGSaW5Qq47NP/17Wv6vLd2Un
         H+bQHJtua41I5Qd6Ri6QRHUgznM7wGnb7kMkco0NpdTfj+Xh+1rKDb07DX1NqxDfGexT
         pCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=A6YwefsHKJAmA4RC1dPZwY26dUCVM4O6+De3kfNUiOQ=;
        b=t/UTCQdpBV0tn664Z8IAeFT2n5xV1q4nffr0Rm142qTXwZwC2YNsIcaorKi79xmqey
         N+jckxzIeiPfGNrAVRZ/pb6uPnU3vOqsmdvn9b7SFSid+Y0JcD6fhldkF3+8RkCE8bL1
         CmCPqPod1tFUa36Z/M6h8rASMamK0sVt8c1pBYRnpdzJkHXwR52JKlv2spHHy0dBIl8o
         6E9fYJPl0BfT138fol/gbNkHwEeY0Iqq1CAbBShpbpQGawZ5iBGm3tThbOeWl7Dar1nS
         ViU0qSpp6vyKdzhIx4T9B65HPM7CaZYNbgOl5tL/Lf+gpwU1MZQGDwWadIRkKquZmDC0
         LRNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11845-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11845-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11845-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11845-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7F9217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180220163142.15366a82a7bece715b997597@linux-foundation.org>
References: <20180117055015.GA15256@beast> <20180220163142.15366a82a7bece715b997597@linux-foundation.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 21 Feb 2018 01:56:33 +0000
X-Gmail-Original-Message-ID: <CALCETrVNBAWPAyrKKaiasehxDXKku3GSjc0+mQrvc4RC4+jUGw@mail.gmail.com>
Message-ID: <CALCETrVNBAWPAyrKKaiasehxDXKku3GSjc0+mQrvc4RC4+jUGw@mail.gmail.com>
Subject: Re: [PATCH] fork: Allow stack to be wiped on fork
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
	Ingo Molnar <mingo@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Sahara <keun-o.park@darkmatter.ae>,
	"Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>, Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589817624643319879?=
X-GMAIL-MSGID: =?utf-8?q?1592973835517787742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 12:31 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 16 Jan 2018 21:50:15 -0800 Kees Cook <keescook@chromium.org> wrote:
>
>> One of the classes of kernel stack content leaks is exposing the contents
>> of prior heap or stack contents when a new process stack is allocated.
>> Normally, those stacks are not zeroed, and the old contents remain in
>> place. With some types of stack content exposure flaws, those contents
>> can leak to userspace. Kernels built with CONFIG_CLEAR_STACK_FORK will
>> no longer be vulnerable to this, as the stack will be wiped each time
>> a stack is assigned to a new process. There's not a meaningful change
>> in runtime performance; it almost looks like it provides a benefit.
>>
>> Performing back-to-back kernel builds before:
>>       Run times: 157.86 157.09 158.90 160.94 160.80
>>       Mean: 159.12
>>       Std Dev: 1.54
>>
>> With CONFIG_CLEAR_STACK_FORK=y:
>>       Run times: 159.31 157.34 156.71 158.15 160.81
>>       Mean: 158.46
>>       Std Dev: 1.46
>>
>> ...
>>
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -904,6 +904,14 @@ config VMAP_STACK
>>         the stack to map directly to the KASAN shadow map using a formula
>>         that is incorrect if the stack is in vmalloc space.
>>
>> +config CLEAR_STACK_FORK
>> +     bool "Clear the kernel stack at each fork"
>> +     help
>> +       To resist stack content leak flaws, this clears newly allocated
>> +       kernel stacks to keep previously freed heap or stack contents
>> +       from being present in the new stack. This has almost no
>> +       measurable performance impact.
>> +
>
> It would be much nicer to be able to control this at runtime rather
> than compile-time.  Why not a /proc tunable?  We could always use more
> of those ;)

/proc/sys/kernel/hardening_features_that_cost_essentially_nothing?

Seriously, though, why don't we just enable it unconditionally?  It
wouldn't surprise me if it really is a speedup on more workloads than
it slows down -- it'll fill the kernel stack into the CPU cache with
exclusive ownership very quickly (streamily and without actually
reading from memory, I imagine, at least on new enough CPUs) rather
than grabbing each cache line one by one as they get used.
