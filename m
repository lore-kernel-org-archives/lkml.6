Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeFAUBL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 16:01:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34340 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbeFAUBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 16:01:09 -0400
X-Google-Smtp-Source: ADUXVKJdy8NTufQIFu4NqftOVUYvRBNX0QrbKLyd0yhJ101GS6gn/kelA7T8IcuuB8wdkWrr4ZYW9OeJZmQcduSzYW8=
MIME-Version: 1.0
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <1527672059-6225-2-git-send-email-feng.tang@intel.com> <20180531135542.4j7w7bxsw43ydx3j@pathway.suse.cz>
 <20180531155210.GL12180@hirez.programming.kicks-ass.net>
In-Reply-To: <20180531155210.GL12180@hirez.programming.kicks-ass.net>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 1 Jun 2018 14:05:33 -0400
X-Gmail-Original-Message-ID: <CAGM2rebzatqO20X4SmdH=VmVGmf-8Uo6FAB48p2zsuHFj-0X_w@mail.gmail.com>
Message-ID: <CAGM2rebzatqO20X4SmdH=VmVGmf-8Uo6FAB48p2zsuHFj-0X_w@mail.gmail.com>
Subject: Re: [RFC 2/2] x86, tsc: Enable clock for ealry printk timestamp
To: peterz@infradead.org
Cc: pmladek@suse.com, feng.tang@intel.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, gnomes@lxorguk.ukuu.org.uk,
        LKML <linux-kernel@vger.kernel.org>, alek.du@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8911 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=862
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806010230
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

How about taking patches 1-4 and 7 ? I can work on patches 5 & 6
separetly to provide a better integration for x86, this can be decided
separetly but the other patches will enable early clock functionality
on arches where sched_clock() is available early.

Pavel
On Thu, May 31, 2018 at 11:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 31, 2018 at 03:55:42PM +0200, Petr Mladek wrote:
> > I wonder if we could get some cleaner integration into the timer and
> > printk code.
>
> Yes, these patches are particularly horrific..
>
> There were some earlier patches by Pavel Tatashin, which attempted do
> get things running earlier.
>
>   http://lkml.kernel.org/r/20180209211143.16215-1-pasha.tatashin@oracle.com
>
> I'm not entirely happy with that, but I never did get around to
> reviewing that last version :-( In particuarly, now that you made me
> look, I dislike his patch 6 almost as much as these patches.
>
> The idea was to get regular sched_clock() running earlier, not to botch
> some early_sched_clock() into it.
>
> Basically run calibrate_tsc() earlier (like _waaay_ earlier, it doesn't
> rely on anything other than CPUID) and if you have a recent part (with
> exception of SKX) you'll get a usable tsc rate (and TSC_RELIABLE) and
> things will work.
>
> If you have a dodgy part (sorry SKX), you'll just have to live with
> sched_clock starting late(r).
>
> Do not cobble things on the side, try and get the normal things running
> earlier.
