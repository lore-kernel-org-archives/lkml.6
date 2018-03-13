Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932663AbeCMUMA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:12:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932303AbeCMUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:11:58 -0400
Date: Tue, 13 Mar 2018 13:11:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        m.mizuma@jp.fujitsu.com, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [v5 1/2] mm: disable interrupts while initializing deferred
 pages
Message-Id: <20180313131156.f156abe1822a79ec01c4800a@linux-foundation.org>
In-Reply-To: <20180313194546.k62tni4g4gnds2nx@xakep.localdomain>
References: <20180309220807.24961-1-pasha.tatashin@oracle.com>
        <20180309220807.24961-2-pasha.tatashin@oracle.com>
        <20180312130410.e2fce8e5e38bc2086c7fd924@linux-foundation.org>
        <20180313160430.hbjnyiazadt3jwa6@xakep.localdomain>
        <20180313115549.7badec1c6b85eb5a1cf21eb6@linux-foundation.org>
        <20180313194546.k62tni4g4gnds2nx@xakep.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 15:45:46 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> > > 
> > > We must remove cond_resched() because we can't sleep anymore. They were
> > > added to fight NMI timeouts, so I will replace them with
> > > touch_nmi_watchdog() in a follow-up fix.
> > 
> > This makes no sense.  Any code section where we can add cond_resched()
> > was never subject to NMI timeouts because that code cannot be running with
> > disabled interrupts.
> > 
> 
> Hi Andrew,
> 
> I was talking about this patch:
> 
> 9b6e63cbf85b89b2dbffa4955dbf2df8250e5375
> mm, page_alloc: add scheduling point to memmap_init_zone
> 
> Which adds cond_resched() to memmap_init_zone() to avoid NMI timeouts.
> 
> memmap_init_zone() is used both, early in boot, when non-deferred struct
> pages are initialized, but also may be used later, during memory hotplug.
> 
> As I understand, the later case could cause the timeout on non-preemptible
> kernels.
> 
> My understanding, is that the same logic was used here when cond_resched()s
> were added.
> 
> Please correct me if I am wrong.

Yes, the message is a bit confusing and the terminology is perhaps
vague.  And it's been a while since I played with this stuff, so from
(dated) memory:

Soft lockup: kernel has run for too long without rescheduling
Hard lockup: kernel has run for too long with interrupts disabled

Both of these are detected by the NMI watchdog handler.

9b6e63cbf85b89b2d fixes a soft lockup by adding a manual rescheduling
point.  Replacing that with touch_nmi_watchdog() won't work (I think). 
Presumably calling touch_softlockup_watchdog() will "work", in that it
suppresses the warning.  But it won't fix the thing which the warning
is actually warning about: starvation of the CPU scheduler.  That's
what the cond_resched() does.

I'm not sure what to suggest, really.  Your changelog isn't the best:
"Vlastimil Babka reported about a window issue during which when
deferred pages are initialized, and the current version of on-demand
initialization is finished, allocations may fail".  Well...  where is
ths mysterious window?  Without such detail it's hard for others to
suggest alternative approaches.
