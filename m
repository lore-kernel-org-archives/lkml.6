Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeCMTq0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:46:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53360 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbeCMTqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:46:25 -0400
Date: Tue, 13 Mar 2018 15:45:46 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        m.mizuma@jp.fujitsu.com, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [v5 1/2] mm: disable interrupts while initializing deferred pages
Message-ID: <20180313194546.k62tni4g4gnds2nx@xakep.localdomain>
References: <20180309220807.24961-1-pasha.tatashin@oracle.com>
 <20180309220807.24961-2-pasha.tatashin@oracle.com>
 <20180312130410.e2fce8e5e38bc2086c7fd924@linux-foundation.org>
 <20180313160430.hbjnyiazadt3jwa6@xakep.localdomain>
 <20180313115549.7badec1c6b85eb5a1cf21eb6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313115549.7badec1c6b85eb5a1cf21eb6@linux-foundation.org>
User-Agent: NeoMutt/20180223
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803130220
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > We must remove cond_resched() because we can't sleep anymore. They were
> > added to fight NMI timeouts, so I will replace them with
> > touch_nmi_watchdog() in a follow-up fix.
> 
> This makes no sense.  Any code section where we can add cond_resched()
> was never subject to NMI timeouts because that code cannot be running with
> disabled interrupts.
> 

Hi Andrew,

I was talking about this patch:

9b6e63cbf85b89b2dbffa4955dbf2df8250e5375
mm, page_alloc: add scheduling point to memmap_init_zone

Which adds cond_resched() to memmap_init_zone() to avoid NMI timeouts.

memmap_init_zone() is used both, early in boot, when non-deferred struct
pages are initialized, but also may be used later, during memory hotplug.

As I understand, the later case could cause the timeout on non-preemptible
kernels.

My understanding, is that the same logic was used here when cond_resched()s
were added.

Please correct me if I am wrong.

Thank you,
Pavel
