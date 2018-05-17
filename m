Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeEQSJk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeEQSJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:09:39 -0400
Date: Thu, 17 May 2018 15:09:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V2 03/20] x86: Add entry trampolines to kcore
Message-ID: <20180517180934.GC18538@kernel.org>
References: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
 <1526548928-20790-4-git-send-email-adrian.hunter@intel.com>
 <9fb55ad9-a69f-bcc3-9e57-d90df5257726@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb55ad9-a69f-bcc3-9e57-d90df5257726@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 17, 2018 at 10:52:30AM -0700, Dave Hansen escreveu:
> On 05/17/2018 02:21 AM, Adrian Hunter wrote:
> > From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > 
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> For the benefit of the poor souls looking at this code in the decades to
> come, could you please take a few minutes to write a couple of sentences
> about why this is being done?

Hey, for the poor souls reading in _this_ decade as well! ;-)

- Arnaldo
 
> > diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> > index d1da5cf4b2de..fb1fbc8538fa 100644
> > --- a/arch/x86/mm/cpu_entry_area.c
> > +++ b/arch/x86/mm/cpu_entry_area.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/percpu.h>
> >  #include <linux/kallsyms.h>
> > +#include <linux/kcore.h>
> >  
> >  #include <asm/cpu_entry_area.h>
> >  #include <asm/pgtable.h>
> > @@ -14,6 +15,7 @@
> >  #ifdef CONFIG_X86_64
> >  static DEFINE_PER_CPU_PAGE_ALIGNED(char, exception_stacks
> >  	[(N_EXCEPTION_STACKS - 1) * EXCEPTION_STKSZ + DEBUG_STKSZ]);
> > +static DEFINE_PER_CPU(struct kcore_list, kcore_entry_trampoline);
> >  #endif
> >  
> >  struct cpu_entry_area *get_cpu_entry_area(int cpu)
> > @@ -147,6 +149,9 @@ static void __init setup_cpu_entry_area(int cpu)
> >  
> >  	cea_set_pte(&get_cpu_entry_area(cpu)->entry_trampoline,
> >  		     __pa_symbol(_entry_trampoline), PAGE_KERNEL_RX);
> > +	kclist_add(&per_cpu(kcore_entry_trampoline, cpu),
> > +		   &get_cpu_entry_area(cpu)->entry_trampoline, PAGE_SIZE,
> > +		   KCORE_TEXT);
> >  #endif
> 
> Any reason not to add a comment like:
> 
> /*
>  * The cpu_entry_area alias addresses are not in the kernel binary
>  * so they do not show up in /proc/kcore normally.  This adds entries
>  * for them manually.
>  */
