Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeCMUoe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:44:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43768 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeCMUoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:44:32 -0400
Subject: Re: [v5 1/2] mm: disable interrupts while initializing deferred pages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        m.mizuma@jp.fujitsu.com, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20180309220807.24961-1-pasha.tatashin@oracle.com>
 <20180309220807.24961-2-pasha.tatashin@oracle.com>
 <20180312130410.e2fce8e5e38bc2086c7fd924@linux-foundation.org>
 <20180313160430.hbjnyiazadt3jwa6@xakep.localdomain>
 <20180313115549.7badec1c6b85eb5a1cf21eb6@linux-foundation.org>
 <20180313194546.k62tni4g4gnds2nx@xakep.localdomain>
 <20180313131156.f156abe1822a79ec01c4800a@linux-foundation.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <ff16234e-eb45-ca99-bfec-6d33967e9c8f@oracle.com>
Date: Tue, 13 Mar 2018 16:43:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313131156.f156abe1822a79ec01c4800a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130231
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Soft lockup: kernel has run for too long without rescheduling
> Hard lockup: kernel has run for too long with interrupts disabled
> 
> Both of these are detected by the NMI watchdog handler.
> 
> 9b6e63cbf85b89b2d fixes a soft lockup by adding a manual rescheduling
> point.  Replacing that with touch_nmi_watchdog() won't work (I think). 
> Presumably calling touch_softlockup_watchdog() will "work", in that it
> suppresses the warning.  But it won't fix the thing which the warning
> is actually warning about: starvation of the CPU scheduler.  That's
> what the cond_resched() does.

But, unlike memmap_init_zone(), which can be used after boot, here we do
not worry about kernel running for too long.  This is because we are
booting, and no user programs are running.

So, it is acceptable to have a long uninterruptible span, as long
as we making a useful progress. BTW, the boot CPU still has
interrupts enabled during this span.

Comment in: include/linux/nmi.h, states:

 * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
 * may be used to reset the timeout - for code which intentionally
 * disables interrupts for a long time. This call is stateless.

Which is exactly what we are trying to do here, now that these threads
run with interrupts disabled.

Before, where they were running with interrupts enabled, and
cond_resched() was enough to satisfy soft lockups.

> 
> I'm not sure what to suggest, really.  Your changelog isn't the best:
> "Vlastimil Babka reported about a window issue during which when
> deferred pages are initialized, and the current version of on-demand
> initialization is finished, allocations may fail".  Well...  where is
> ths mysterious window?  Without such detail it's hard for others to
> suggest alternative approaches.

Here is hopefully a better description of the problem:

Currently, during boot we preinitialize some number of struct pages to satisfy all boot allocations. Even if these allocations happen when we initialize the reset of deferred pages in page_alloc_init_late(). The problem is that we do not know how much kernel will need, and it also depends on various options.

So, with this work, we are changing this behavior to initialize struct pages on-demand, only when allocations happen.

During boot, when we try to allocate memory, the on-demand struct page initialization code takes care of it. But, once the deferred pages are initializing in:

page_alloc_init_late()
   for_each_node_state(nid, N_MEMORY)
      kthread_run(deferred_init_memmap())

We cannot use on-demand initialization, as these threads resize pgdat.

This whole thing is to take care of this time.

My first version of on-demand deferred page initialization would simply fail to allocate memory during this period of time. But, this new version waits for threads to finish initializing deferred memory, and successfully perform the allocation.

Because interrupt handler would wait for pgdat resize lock.

Thank you,
Pavel
