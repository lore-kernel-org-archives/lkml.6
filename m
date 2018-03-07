Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeCGSBy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:01:54 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54458 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCGSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:01:50 -0500
X-Google-Smtp-Source: AG47ELs5s32IJYhkyVuE6bZSyuSEH+GSscPt8ksqWSNqFtBj68I7KqGmd7sZmRvXV79k8+2kDK77FXLD6zSJVZV7Wis=
MIME-Version: 1.0
In-Reply-To: <33e3a3ff-0318-1a07-3c57-6be638046c87@suse.cz>
References: <20180306224004.25150-1-pasha.tatashin@oracle.com> <33e3a3ff-0318-1a07-3c57-6be638046c87@suse.cz>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 7 Mar 2018 13:01:32 -0500
X-Gmail-Original-Message-ID: <CAOAebxty1EfEvd++BJq3zBOy81+LFV-WF=ERtoqprbsWZpm3HA@mail.gmail.com>
Message-ID: <CAOAebxty1EfEvd++BJq3zBOy81+LFV-WF=ERtoqprbsWZpm3HA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: might_sleep warning
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Steve Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, m.mizuma@jp.fujitsu.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        baiyaowei@cmss.chinamobile.com, Wei Yang <richard.weiyang@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Miles Chen <miles.chen@mediatek.com>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=672
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803070205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> I've noticed that this function first disables the on-demand
> initialization, and then runs the kthreads. Doesn't that leave a window
> where allocations can fail? The chances are probably small, but I think
> it would be better to avoid it completely, rare failures suck.
>
> Fixing that probably means rethinking the whole synchronization more
> dramatically though :/
>
> Vlastimil

Hi Vlastimil,

You are right, there is a window, it is short, and probably not
possible to reproduce, as it happens before user threads are started,
and after init calls done by smp_init() are finished. The only way it
can happen, as far as I can see, is if some device fires an interrupt,
and interrupt handler decides to allocate a large chunk of memory. The
small allocations will succeed, as zone grow function growth more than
strictly requested, and also there are zones without deferred pages.

I will, however, think some more how to solve this problem to be future proof.

Thank you,
Pavel
