Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AH8x227fGdyy501x4tTAs4dPTupd9mFJFlRhl7akRmTEQ5LYNdeXnO9T4FK80txCSkF4pGrwjymf
ARC-Seal: i=1; a=rsa-sha256; t=1518028717; cv=none;
        d=google.com; s=arc-20160816;
        b=UOoE2q+bkpEe0/gV6iSnnlXTMOUPrUSSG8xfGC68PhrD/lWsLwwrailUkVizMPzNKQ
         2JmGX2XDYZZGCrwu3vIGStwuIiWexHg0ePAr2J+HWeLsSVgCsdYUSmmlOamIKQX1/WVA
         2TRq6byuLxf+Cm00g54Htxh5zLKBllgBCRgEUzrviGhlD6caS2Hb9zBaMysU6/jA3ikn
         bX87J9o/Ps2DXtdxCsf+Ta08VCMeZ8YomVtX2PrYwode3idsp17ODX3k76QvFy4M63CE
         b4twvyn6aVYLVJfGq+H2dMLYaZKIVrTahrLndzT6RtbwHTBd5xgXpO7l+RDvgoZ3lOXb
         yy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=Rs5Bq33YTyABW8Xs//wcsrsGHBC6xv21iz+XgcivxeM=;
        b=Vd7ublEK6zz5szSLdcFYDSgIqI48a3hTSKh4qX0MTsK7KpGZ/VjpqyFpfhvPS/9c7g
         OJ1RkU+dFEvvl1XFlNKojb+OyNtG/1L8FfnrwPUUQn1/welqX22POP9rW45r4ZqRlBJQ
         d8Vg9zTeAxoZYBkeLuf3Q/0yHqH5Z6IZkb14h2M83oBssLwFgsEdOa2krlhxFI69+kuj
         6HAgMeNacR/7qWClVCRvRDm7UQ6B/Iijd7et4zd6Ax9Zic+zNpEYGHYWk7OAWm0OrTuJ
         33LFKyS2+fkMJoeaPho7E9jHfFvltSKAzvMzlnsVOLlgxeK7SvfGUlIvvUjluttsEw1W
         iyZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="16384888"
Subject: Re: [PATCH RFC] x86: KASAN: Sanitize unauthorized irq stack access
To: Kirill Tkhai <ktkhai@virtuozzo.com>, tglx@linutronix.de,
 mingo@redhat.com, hpa@zytor.com, aryabinin@virtuozzo.com, glider@google.com,
 dvyukov@google.com, luto@kernel.org, bp@alien8.de, jpoimboe@redhat.com,
 jgross@suse.com, kirill.shutemov@linux.intel.com, keescook@chromium.org,
 minipli@googlemail.com, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <151802005995.4570.824586713429099710.stgit@localhost.localdomain>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <6638b09b-30b0-861e-9c00-c294889a3791@linux.intel.com>
Date: Wed, 7 Feb 2018 10:38:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <151802005995.4570.824586713429099710.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591759437440105803?=
X-GMAIL-MSGID: =?utf-8?q?1591768480083777270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/07/2018 08:14 AM, Kirill Tkhai wrote:
> Sometimes it is possible to meet a situation,
> when irq stack is corrupted, while innocent
> callback function is being executed. This may
> happen because of crappy drivers irq handlers,
> when they access wrong memory on the irq stack.

Can you be more clear about the actual issue?  Which drivers do this?
How do they even find an IRQ stack pointer?

> This patch aims to catch such the situations
> and adds checks of unauthorized stack access.

I think I forgot how KASAN did this.  KASAN has metadata that says which
areas of memory are good or bad to access, right?  So, this just tags
IRQ stacks as bad when we are not _in_ an interrupt?

> +#define KASAN_IRQ_STACK_SIZE \
> +	(sizeof(union irq_stack_union) - \
> +		(offsetof(union irq_stack_union, stack_canary) + 8))

Just curious, but why leave out the canary?  It shouldn't be accessed
either.

> +#ifdef CONFIG_KASAN
> +void __visible x86_poison_irq_stack(void)
> +{
> +	if (this_cpu_read(irq_count) == -1)
> +		kasan_poison_irq_stack();
> +}
> +void __visible x86_unpoison_irq_stack(void)
> +{
> +	if (this_cpu_read(irq_count) == -1)
> +		kasan_unpoison_irq_stack();
> +}
> +#endif

It might be handy to point out here that -1 means "not in an interrupt"
and >=0 means "in an interrupt".

Otherwise, this looks pretty straightforward.  Would it be something to
extend to the other stacks like the NMI or double-fault stacks?  Or are
those just not worth it?
