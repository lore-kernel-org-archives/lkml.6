Return-Path: <kernel-hardening-return-11653-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224oQ3x2QbrUR/fxegmlV2Q06HpxL16VqiWl+8LQf3medl7XuDrUmJQc7r5O4LuhWtpRoXlW
ARC-Seal: i=1; a=rsa-sha256; t=1518058625; cv=none;
        d=google.com; s=arc-20160816;
        b=KFcAweQGXTrNAdBfPY7qD0b4fUfB16rZmtEoeSCmf6WvgC4WEl9DZ1S+rTzUpydXLS
         CGsHXrSZMNo4BfbdIOfosr25rg5YxaCRQuckdpdGDcnLjO9zxaAkZW/Sykzafte131jV
         oLYdfsx2eU7HSOSQLmVv3QKUSuxkpK/bOVMqVGJ7DyCv2lozqJ5mJilQa+Ei/7DLSTUx
         Ry38XRy1Bnh3QUrUt7v1QjGKZKr6PftKz6rl+nxFCmMhN+18/KTqZOuhFXA2aOAg7dIg
         vw0AQfw1+TBlUSffZOKWy6p/Qwfj5XVIXHJagGYbKfopzbKwnPdwPEPiRALfDjd6udBA
         mHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=6c2rQEJFCoLaIES6eYxOEpFofJg5C2VycJjlycPKFMk=;
        b=xlchU/5/iBWKW8TiK0/qUytnwpPwUMTr8rHi707DAfiUY99bpNYfUCa62buLhfjFPS
         2mvTtlnLrelqZDesdIVUfkJTo2Nm85kVnDR23qAIg5ytQmHC7b+4ewdqKfPUKlgxKeMd
         S7hK126AZzow5HIKcZrhrucvheCgEadmYdAc1Z2Jl6lCLXkhlEPBWfG1jmQDWfZ2FQvR
         tOJEFY5K/1MS8OA3hWhGdufnlkHfLWjXUdvm2e0poXERoIz5nW4tQstRKCSdIM+K8u65
         9a0hvr9K+IfWrtLMLEgBTKRYLJXA2udLjzR9s4FSkGJYe07GYrZ9e8Ck9Ef0qFkYFPjY
         JIYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BpOgVJDS;
       spf=pass (google.com: domain of kernel-hardening-return-11653-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11653-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BpOgVJDS;
       spf=pass (google.com: domain of kernel-hardening-return-11653-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11653-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180208021112.GB14918@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 8 Feb 2018 03:56:26 +0100
Message-ID: <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591799841057126051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 3:11 AM, Matthew Wilcox <willy@infradead.org> wrote:
> Kirill and I were talking about trying to overflow page->_mapcount
> the other day and realised that the default settings of pid_max and
> max_map_count prevent it [1].  But there isn't even documentation to
> warn a sysadmin that they've just opened themselves up to the possibility
> that they've opened their system up to a sufficiently-determined attacker.
>
> I'm not sufficiently wise in the ways of the MM to understand exactly
> what goes wrong if we do wrap mapcount.  Kirill says:
>
>   rmap depends on mapcount to decide when the page is not longer mapped.
>   If it sees page_mapcount() == 0 due to 32-bit wrap we are screwed;
>   data corruption, etc.

How much memory would you need to trigger this? You need one
vm_area_struct per increment, and those are 200 bytes? So at least
800GiB of memory for the vm_area_structs, and maybe more for other
data structures?

I wouldn't be too surprised if there are more 32-bit overflows that
start being realistic once you put something on the order of terabytes
of memory into one machine, given that refcount_t is 32 bits wide -
for example, the i_count. See
https://bugs.chromium.org/p/project-zero/issues/detail?id=809 for an
example where, given a sufficiently high RLIMIT_MEMLOCK, it was
possible to overflow a 32-bit refcounter on a system with just ~32GiB
of free memory (minimum required to store 2^32 64-bit pointers).

On systems with RAM on the order of terabytes, it's probably a good
idea to turn on refcount hardening to make issues like that
non-exploitable for now.

> That seems pretty bad.  So here's a patch which adds documentation to the
> two sysctls that a sysadmin could use to shoot themselves in the foot,
> and adds a warning if they change either of them to a dangerous value.

I have negative feelings about this patch, mostly because AFAICS:

 - It documents an issue instead of fixing it.
 - It likely only addresses a small part of the actual problem.

> It's possible to get into a dangerous situation without triggering this
> warning (already have the file mapped a lot of times, then lower pid_max,
> then raise max_map_count, then map the file a lot more times), but it's
> unlikely to happen.
>
> Comments?
>
> [1] map_count counts the number of times that a page is mapped to
> userspace; max_map_count restricts the number of times a process can
> map a page and pid_max restricts the number of processes that can exist.
> So map_count can never be larger than pid_max * max_map_count.
[...]
> +int sysctl_pid_max(struct ctl_table *table, int write,
> +                  void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +       struct ctl_table t;
> +       int ret;
> +
> +       t = *table;
> +       t.data = &pid_max;
> +       t.extra1 = &pid_max_min;
> +       t.extra2 = &pid_max_max;
> +
> +       ret = proc_douintvec_minmax(&t, write, buffer, lenp, ppos);
> +       if (ret || !write)
> +               return ret;
> +
> +       if ((INT_MAX / max_map_count) > pid_max)
> +               pr_warn("pid_max is dangerously large\n");

This in reordered is "if (pid_max * max_map_count < INT_MAX)
pr_warn(...);", no? That doesn't make sense to me. Same thing again
further down.

[...]
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4d3c922ea1a1..5b66a4a48192 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -147,7 +147,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
>         *prev = vma;
>
>         if (start != vma->vm_start) {
> -               if (unlikely(mm->map_count >= sysctl_max_map_count)) {
> +               if (unlikely(mm->map_count >= max_map_count)) {

Why the renaming?
