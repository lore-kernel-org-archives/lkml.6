Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6ECC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C34120849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C34120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeLLKoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:44:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbeLLKoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:44:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5FD588302;
        Wed, 12 Dec 2018 10:44:23 +0000 (UTC)
Received: from sky.random (ovpn-120-222.rdu2.redhat.com [10.10.120.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F41CA4D9E9;
        Wed, 12 Dec 2018 10:44:19 +0000 (UTC)
Date:   Wed, 12 Dec 2018 05:44:18 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181212104418.GE1130@redhat.com>
References: <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
 <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
 <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com>
 <20181210044916.GC24097@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210044916.GC24097@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 12 Dec 2018 10:44:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I now found a two socket EPYC (is this Naples?) to try to confirm the
THP effect of intra-socket THP.

CPU(s):                128
On-line CPU(s) list:   0-127
Thread(s) per core:    2
Core(s) per socket:    32
Socket(s):             2
NUMA node(s):          8
NUMA node0 CPU(s):     0-7,64-71
NUMA node1 CPU(s):     8-15,72-79
NUMA node2 CPU(s):     16-23,80-87
NUMA node3 CPU(s):     24-31,88-95
NUMA node4 CPU(s):     32-39,96-103
NUMA node5 CPU(s):     40-47,104-111
NUMA node6 CPU(s):     48-55,112-119
NUMA node7 CPU(s):     56-63,120-127

# numactl --hardware
available: 8 nodes (0-7)
node 0 cpus: 0 1 2 3 4 5 6 7 64 65 66 67 68 69 70 71
node 0 size: 32658 MB
node 0 free: 31554 MB
node 1 cpus: 8 9 10 11 12 13 14 15 72 73 74 75 76 77 78 79
node 1 size: 32767 MB
node 1 free: 31854 MB
node 2 cpus: 16 17 18 19 20 21 22 23 80 81 82 83 84 85 86 87
node 2 size: 32767 MB
node 2 free: 31535 MB
node 3 cpus: 24 25 26 27 28 29 30 31 88 89 90 91 92 93 94 95
node 3 size: 32767 MB
node 3 free: 31777 MB
node 4 cpus: 32 33 34 35 36 37 38 39 96 97 98 99 100 101 102 103
node 4 size: 32767 MB
node 4 free: 31949 MB
node 5 cpus: 40 41 42 43 44 45 46 47 104 105 106 107 108 109 110 111
node 5 size: 32767 MB
node 5 free: 31957 MB
node 6 cpus: 48 49 50 51 52 53 54 55 112 113 114 115 116 117 118 119
node 6 size: 32767 MB
node 6 free: 31945 MB
node 7 cpus: 56 57 58 59 60 61 62 63 120 121 122 123 124 125 126 127
node 7 size: 32767 MB
node 7 free: 31958 MB
node distances:
node   0   1   2   3   4   5   6   7 
  0:  10  16  16  16  32  32  32  32 
  1:  16  10  16  16  32  32  32  32 
  2:  16  16  10  16  32  32  32  32 
  3:  16  16  16  10  32  32  32  32 
  4:  32  32  32  32  10  16  16  16 
  5:  32  32  32  32  16  10  16  16 
  6:  32  32  32  32  16  16  10  16 
  7:  32  32  32  32  16  16  16  10 
# for i in 0 8 16 24 32 40 48 56; do numactl -m 0 -C $i /tmp/numa-thp-bench; done
random writes MADV_HUGEPAGE 17622885 usec
random writes MADV_NOHUGEPAGE 25316593 usec
random writes MADV_NOHUGEPAGE 25291927 usec
random writes MADV_HUGEPAGE 17672446 usec
random writes MADV_HUGEPAGE 25698555 usec
random writes MADV_NOHUGEPAGE 36413941 usec
random writes MADV_NOHUGEPAGE 36402155 usec
random writes MADV_HUGEPAGE 25689574 usec
random writes MADV_HUGEPAGE 25136558 usec
random writes MADV_NOHUGEPAGE 35562724 usec
random writes MADV_NOHUGEPAGE 35504708 usec
random writes MADV_HUGEPAGE 25123186 usec
random writes MADV_HUGEPAGE 25137002 usec
random writes MADV_NOHUGEPAGE 35577429 usec
random writes MADV_NOHUGEPAGE 35582865 usec
random writes MADV_HUGEPAGE 25116561 usec
random writes MADV_HUGEPAGE 40281721 usec
random writes MADV_NOHUGEPAGE 56891233 usec
random writes MADV_NOHUGEPAGE 56924134 usec
random writes MADV_HUGEPAGE 40286512 usec
random writes MADV_HUGEPAGE 40377662 usec
random writes MADV_NOHUGEPAGE 56731400 usec
random writes MADV_NOHUGEPAGE 56443959 usec
random writes MADV_HUGEPAGE 40379022 usec
random writes MADV_HUGEPAGE 33907588 usec
random writes MADV_NOHUGEPAGE 47609976 usec
random writes MADV_NOHUGEPAGE 47523481 usec
random writes MADV_HUGEPAGE 33881974 usec
random writes MADV_HUGEPAGE 40809719 usec
random writes MADV_NOHUGEPAGE 57148321 usec
random writes MADV_NOHUGEPAGE 57164499 usec
random writes MADV_HUGEPAGE 40802979 usec
# grep EPYC /proc/cpuinfo |head -1
model name      : AMD EPYC 7601 32-Core Processor

I suppose node 0-1-2-3 are socket 0 and node 4-5-6-7 are socket 1.

With the ram kept in nodeid 0, cpuid 0 is NUMA local, cpuid 8,16,24
are NUMA intrasocket remote and cpuid 32 40 48 56 are NUMA
intersocket remote.

local 4k -> local THP: +43.6% improvement

local 4k -> intersocket remote THP: -1.4%
intersocket remote 4k -> intersocket remote THP: +41.6%

local 4k -> intersocket remote 4k: -30.4%
local THP -> intersocket remote THP: -31.4%

local 4k -> intrasocket remote THP: -37.15% (-25% on node 6?)
intrasocket remote 4k -> intrasocket remote THP: +41.23%

local 4k -> intrasocket remote 4k: -55.5% (-46% on node 6?)
local THP -> intrasocket remote THP: -56.25% (-47% on node 6?)

In short intrasocket is a whole lot more expensive (4k -55% THP -56%)
than intersocket (4k -30% THP -31%)... as expected. The benefits of
THP vs 4k remains the same for intrasocket (+41.23%) and intersocket
(+41.6%) and local (+43.6%), also as expected.

The above was measured on bare metal on guests the impact of THP as
usual will be multiplied (I can try to measure that another time).

So while before I couldn't confirm that THP didn't help intersocket, I
think I can confirm it helps just like intrasocket and local now on
this architecture.

Especially intresocket the slowdown from remote THP compared to local
4k is a tiny -1% so in theory __GFP_THISNODE would at least need to
switch to __GFP_THISSOCKET for this architecture.. (I'm not suggesting
that, I'm talking in theory). Intersocket is even more favorable than
a 2 node 1 socket threadripper and a 2 node (2 sockets?) skylake in
fact even on bare metal.

Losing the +41% THP benefit across all distances makes __GFP_THISNODE
again questionable optimization, it only ever pays off in the
intersocket case (-37% is an increase of compute time of +59% which is
pretty bad and we should definitely have some logic that optimizes for
it). However eliminating the possibility of remote THP doesn't look
good, especially because the 4k allocation may end up being remote too
if the node is full of cache (there is no __GFP_THISNODE set on 4k
allocations...).

__GFP_THISNODE made MADV_HUGEPAGE act a bit like a NUMA node reclaim
hack embedded in MADV_HUGEPAGE: if you didn't set MADV_HUGEPAGE you'd
potentially get more intrasocket remote 4k pages instead of local THPs
thanks to the __GFP_THISNODE reclaim.

I think with the current __GFP_THISNODE and HPAGE_PMD_SIZE hardcoding,
you'll get a lot less local node memory when the local node is full of
clean pagecache, because 4k allocations have no __GFP_THISNODE set, so
you'll get a lot more of intrasocket remote 4k even when there's a ton
of +41% faster intrasocket remote THP memory available. This is
because it the new safe __GFP_THISNODE won't shrink the cache without
mbind anymore.

NUMA balancing must be enabled in a system like above and it should be
able to optimize a lack of convergence as long as the workload can fit
in a node (and if the workload doesn't fit in a node __GFP_THISNODE
will backfire anyway).

We need to keep thinking at how to optimize the case of preferring
local 4k to remote THP in a way that won't backfire the moment the
task in the CPU is moved to a different node, but __GFP_THISNODE set
in the only single attempt of allocating THP memory in a THP fault,
isn't the direction because without a __GFP_THISNODE-reclaim, less
local 4k memory will be allocated once the node is full of cache and
the remote THP will be totally ignored when they would perform better
than remote 4k. Ignoring remote THP isn't the purpose of
MADV_HUGEPAGE, quite the contrary.

Thanks,
Andrea
