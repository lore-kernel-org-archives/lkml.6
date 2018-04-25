Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753670AbeDYWKq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 18:10:46 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40474 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbeDYWKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 18:10:44 -0400
X-Google-Smtp-Source: AIpwx4+kw369VQBcCa23huQ8t+JNy4v4X4lxaybVnmVSN9JfyabNIWWyDvt4uqgk3P5EF5RjIoZG1oFJD9e5R1j8QL0=
MIME-Version: 1.0
In-Reply-To: <20180326172727.025EBF16@viggo.jf.intel.com>
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com> <20180326172727.025EBF16@viggo.jf.intel.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 25 Apr 2018 22:10:42 +0000
Message-ID: <CALvZod5NTauM6MHW7D=h0mTDNYFd-1QyWrOxnhiixCgtHP=Taw@mail.gmail.com>
Subject: Re: [PATCH 4/9] x86, pkeys: override pkey when moving away from PROT_EXEC
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        stable@kernel.org, linuxram@us.ibm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, mpe@ellerman.id.au,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 5:27 PM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> I got a bug report that the following code (roughly) was
> causing a SIGSEGV:
>
>         mprotect(ptr, size, PROT_EXEC);
>         mprotect(ptr, size, PROT_NONE);
>         mprotect(ptr, size, PROT_READ);
>         *ptr = 100;
>
> The problem is hit when the mprotect(PROT_EXEC)
> is implicitly assigned a protection key to the VMA, and made
> that key ACCESS_DENY|WRITE_DENY.  The PROT_NONE mprotect()
> failed to remove the protection key, and the PROT_NONE->
> PROT_READ left the PTE usable, but the pkey still in place
> and left the memory inaccessible.
>
> To fix this, we ensure that we always "override" the pkee
> at mprotect() if the VMA does not have execute-only
> permissions, but the VMA has the execute-only pkey.
>
> We had a check for PROT_READ/WRITE, but it did not work
> for PROT_NONE.  This entirely removes the PROT_* checks,
> which ensures that PROT_NONE now works.
>
> Reported-by: Shakeel Butt <shakeelb@google.com>
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: 62b5f7d013f ("mm/core, x86/mm/pkeys: Add execute-only protection keys support")

Hi Dave, are you planning to send the next version of this patch or
going with this one?
