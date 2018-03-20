Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeCTPFN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTPFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:05:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5A321835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx49eO5ARBoU4pHuscrfjhyKf0iKvvqr58nQl1SZWwFxTXQDp3IyBBeX9pR5g5lrg6lf0jBclWvtnsWWjLXTw4cA=
MIME-Version: 1.0
In-Reply-To: <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com> <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 20 Mar 2018 15:04:49 +0000
X-Gmail-Original-Message-ID: <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
Message-ID: <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
Subject: Re: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when FS/GS
 updated by ptracer
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: X86 ML <x86@kernel.org>, Andrew Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 5:49 PM, Chang S. Bae <chang.seok.bae@intel.com> wrote:
> When FSGSBASE enabled, ptracer's FS/GS selector update
> fetches FS/GS base from GDT/LDT. This emulation of FS/GS
> segment loading provides backward compatibility for the
> legacy ptracers.
>
> When ptracer sets FS/GS selector, its base is going to be
> (accordingly) reloaded as the tracee resumes. This is without
> FSGSBASE. With FSGSBASE, FS/GS base is preserved regardless
> of its selector. Thus, emulating FS/GS load in ptrace is
> requested to keep compatible with what has been with FS/GS
> setting.
>
> Additionally, whenever a new base value is written, the
> FSGSBASE-enabled kernel allows the tracee effectively carry
> on. This also means that when both selector and base are
> changed, the base is not fetched from GDT/LDT, but
> preserved as given.
>

>
> Suggested-by: Markus T. Metzger <markus.t.metzger@intel.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>

I've also suggested something like this myself, but this approach is
far more complicated than the older approach.  Was there something
that the old approach would break?  If so, what?

> +               /*
> +                * %fs setting goes to reload its base, when tracee
> +                * resumes without FSGSBASE (legacy). Here with FSGSBASE
> +                * FS base is (manually) fetched from GDT/LDT when needed.
> +                */
> +               else if (static_cpu_has(X86_FEATURE_FSGSBASE) &&
> +                        (value != 0) && (task->thread.fsindex != value))
> +                       task->thread.fsbase = task_seg_base(task, value);

The comment above should explain why you're checking this particular
condition.  I find the fsindex != value check to be *very* surprising.
On a real CPU, writing some nonzero value to %fs does the same thing
regardless of what the old value of %fs was.

> +               case USER_REGS_OFFSET(fs):
> +                       if (fs_fully_covered &&

This is_fully_covered thing is IMO overcomplicated.  Why not just make
a separate helper set_fsgs_index_and_base() and have putregs() call it
when both are set at once?

> +                           static_cpu_has(X86_FEATURE_FSGSBASE)) {
> +                               if (invalid_selector(*v))
> +                                       return -EIO;
> +                               /*
> +                                * Set the flag to fetch fsbase from GDT/LDT
> +                                * with FSGSBASE
> +                                */
> +                               fs_updated = (*v != 0) &&
> +                                       (child->thread.fsindex != *v);

Same here.  Why do you care if fs was changed?
