Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeFDSGx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:06:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47774 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDSGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:06:52 -0400
Date: Mon, 4 Jun 2018 11:06:42 -0700
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm -V3 00/21] mm, THP, swap: Swapout/swapin THP in one
 piece
Message-ID: <20180604180642.qexvwe5dqvkgraij@ca-dmjordan1.us.oracle.com>
References: <20180523082625.6897-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180523082625.6897-1-ying.huang@intel.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8914 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040208
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 04:26:04PM +0800, Huang, Ying wrote:
> And for all, Any comment is welcome!
> 
> This patchset is based on the 2018-05-18 head of mmotm/master.

Trying to review this and it doesn't apply to mmotm-2018-05-18-16-44.  git
fails on patch 10:

Applying: mm, THP, swap: Support to count THP swapin and its fallback
error: Documentation/vm/transhuge.rst: does not exist in index
Patch failed at 0010 mm, THP, swap: Support to count THP swapin and its fallback

Sure enough, this tag has Documentation/vm/transhuge.txt but not the .rst
version.  Was this the tag you meant?  If so did you pull in some of Mike
Rapoport's doc changes on top?

>             base                  optimized
> ---------------- -------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    1417897 ±  2%    +992.8%   15494673        vm-scalability.throughput
>    1020489 ±  4%   +1091.2%   12156349        vmstat.swap.si
>    1255093 ±  3%    +940.3%   13056114        vmstat.swap.so
>    1259769 ±  7%   +1818.3%   24166779        meminfo.AnonHugePages
>   28021761           -10.7%   25018848 ±  2%  meminfo.AnonPages
>   64080064 ±  4%     -95.6%    2787565 ± 33%  interrupts.CAL:Function_call_interrupts
>      13.91 ±  5%     -13.8        0.10 ± 27%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
> 
...snip...
> test, while in optimized kernel, that is 96.6%.  The TLB flushing IPI
> (represented as interrupts.CAL:Function_call_interrupts) reduced
> 95.6%, while cycles for spinlock reduced from 13.9% to 0.1%.  These
> are performance benefit of THP swapout/swapin too.

Which spinlocks are we spending less time on?
