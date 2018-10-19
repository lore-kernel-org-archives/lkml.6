Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D43CECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030EB2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQgh/Fae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030EB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeJTBm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:42:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34218 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeJTBm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:42:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id j17-v6so31562606lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0s5yOPh4Mlsyt9VV3PFAs4VMzv03pq3QaEofv8xerFo=;
        b=EQgh/Faeg8j6gquq40g2Iyx5ycXuoSGENaYBgSy0bvNy4jpf7eYh8pLOVoe7lAjKbn
         XViWrmFvfDf9wri4lNpreQXgh4IRxzzWS5xVsWw3lb/xU0LWkuwUndFFZm/xObB1KBcF
         Dqhoet1fPlxM7/ZqDlscVddejg2Jzpcx1OkCBQAT5/d5M1y9SjtXP8XaCT+OXVpKMn+7
         zsn082VstlsGrrJbIx0I+k+mHYf/jPRjpU5U5AWaEhjl8rMrCqQO2G4mv88YJUwooLIU
         YgOXnb5f+/Cifn8NC+Aj+rL1CfI6xwQS6fkJfFRq9YZ/UNfH+fE0kxthXMhPh9WseBMi
         tQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0s5yOPh4Mlsyt9VV3PFAs4VMzv03pq3QaEofv8xerFo=;
        b=k0IHd0n7QBY9s3/Ed/uBt+mtHx65T51sznz6C+Y0g0PydqpMt0SmXawwfrJcJ30+a3
         GfB6eGJKSx8hwcgyvm9ne76/HD/YuijJ7Q6qqWDb03DHhNb3vIeb/dP5UwCbvuLw7Y4/
         /La34o9TLjrLGxOQfjvdoMSgFATRVo4fQTy/4Nvj3pboXg+lg/7dotZ9K+kJ9izGpAXw
         RoeC1Uhyumbi0c5PjzTxryAh9R6y3Kx/K4mBFG/Lb9ZNDkrMMVebKRIMgnL/wiRL5eCH
         geqhUyF8kYUPAS8SS7eUDkYJ0e0FGhA56GO4BU8/47R+tePmy3tflN4VI9H/EqubOSQI
         0XHA==
X-Gm-Message-State: ABuFfog+B1EdBfiiguPh7llfAiswNyOkG+WX6WELVkB9JlnrflCALI4N
        u4qQ//dDiZEqk7gFJGGQDGA=
X-Google-Smtp-Source: ACcGV60pMTulJbgqSYizCTFKGwTQmit898kHjdtbkLgQk9aO8G0NUuLr+7kl8A4kt/c2tGoFbKc3RA==
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr25775894ljj.6.1539970550863;
        Fri, 19 Oct 2018 10:35:50 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id k9-v6sm5531530lje.51.2018.10.19.10.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 10:35:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC PATCH 0/2] improve vmalloc allocation
Date:   Fri, 19 Oct 2018 19:35:36 +0200
Message-Id: <20181019173538.590-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objective
---------
Initiative of improving vmalloc allocator comes from getting many issues
related to allocation time, i.e. sometimes it is terribly slow. As a result
many workloads which are sensitive for long (more than 1 millisecond) preemption
off scenario are affected by that slowness(test cases like UI or audio, etc.).

The problem is that, currently an allocation of the new VA area is done over
busy list iteration until a suitable hole is found between two busy areas.
Therefore each new allocation causes the list being grown. Due to long list
and different permissive parameters an allocation can take a long time on
embedded devices(milliseconds).

Description
-----------
This approach keeps track of free blocks and allocation is done over free list
iteration instead. During initialization phase the vmalloc memory layout is
organized into one free area(can be more) building free double linked list
within VMALLOC_START-VMALLOC_END range.

Proposed algorithm uses red-black tree that keeps blocks sorted by their offsets
in pair with linked list keeping the free space in order of increasing addresses.

Allocation. It uses a first-fit policy. To allocate a new block a search is done
over free list areas until a first suitable block is large enough to encompass
the requested size. If the block is bigger than requested size - it is split.

A free block can be split by three different ways. Their names are FL_FIT_TYPE,
LE_FIT_TYPE/RE_FIT_TYPE and NE_FIT_TYPE, i.e. they correspond to how requested
size and alignment fit to a free block.

FL_FIT_TYPE - in this case a free block is just removed from the free list/tree
because it fully fits. Comparing with current design there is an extra work with
rb-tree updating.

LE_FIT_TYPE/RE_FIT_TYPE - left/right edges fit. In this case what we do is
just cutting a free block. It is as fast as a current design. Most of the vmalloc
allocations just end up with this case, because the edge is always aligned to 1.

NE_FIT_TYPE - Is much less common case. Basically it happens when requested size
and alignment does not fit left nor right edges, i.e. it is between them. In this
case during splitting we have to build a remaining left free area and place it
back to the free list/tree.

Comparing with current design there are two extra steps. First one is we have to
allocate a new vmap_area structure. Second one we have to insert that remaining 
free block to the address sorted list/tree.

In order to optimize a first case there is a cache with free_vmap objects. Instead
of allocating from slab we just take an object from the cache and reuse it.

Second one is pretty optimized. Since we know a start point in the tree we do not
do a search from the top. Instead a traversal begins from a rb-tree node we split.

De-allocation. Red-black tree allows efficiently find a spot in the tree whereas
a linked list allows fast access to neighbors, thus a fast merge of de-allocated
memory chunks with existing free blocks creating large coalesced areas. It means
comparing with current design there is an extra step we have to done when a block
is freed.

In order to optimize a merge logic a free vmap area is not inserted straight
away into free structures. Instead we find a place in the rbtree where a free
block potentially can be inserted. Its parent node and left or right direction.
Knowing that, we can identify future next/prev list nodes, thus at this point
it becomes possible to check if a block can be merged. If not, just link it.

Test environment
----------------
I have used two systems to test. One is i5-3320M CPU @ 2.60GHz and another
is HiKey960(arm64) board. i5-3320M runs on 4.18 kernel, whereas Hikey960
uses 4.15 linaro kernel.

i5-3320M:
set performance governor
echo 0 > /proc/sys/kernel/nmi_watchdog
echo -1 > /proc/sys/kernel/perf_event_paranoid
echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo

Stability and stress tests
--------------------------
As for stress testing of the new approach, i wrote a small patch with
different test cases and allocations methods to make a pressure on
vmalloc subsystem. In short, it runs different kind of allocation
tests simultaneously on each online CPU with different run-time(few days).

A test-suite patch you can find here, it is based on 4.18 kernel.
ftp://vps418301.ovh.net/incoming/0001-mm-vmalloc-stress-test-suite-v4.18.patch

Below are some issues i run into during stability check phase(default kernel).

1) This Kernel BUG can be triggered by align_shift_alloc_test() stress test.
See it in test-suite patch:

<snip>
[66970.279289] kernel BUG at mm/vmalloc.c:512!
[66970.279363] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[66970.279411] CPU: 1 PID: 652 Comm: insmod Tainted: G           O      4.18.0+ #741
[66970.279463] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[66970.279525] RIP: 0010:alloc_vmap_area+0x358/0x370
<snip>

Patched version does not suffer from that BUG().

2) This one has been introduced by commit 763b218ddfaf. Which introduced some
preemption points into __purge_vmap_area_lazy(). Under heavy simultaneous
allocations/releases number of lazy pages can easily go beyond millions
hitting out_of_memory -> panic or making operations like: allocation, lookup,
unmap, remove, etc. much slower.

It is fixed by second commit in this series. Please see more description in
the commit message of the patch.

3) This one is related to PCPU allocator(see pcpu_alloc_test()). In that
stress test case i see that SUnreclaim(/proc/meminfo) parameter gets increased,
i.e. there is a memory leek somewhere in percpu allocator. It sounds like
a memory that is allocated by pcpu_get_vm_areas() sometimes is not freed.
Resulting in memory leaking or "Kernel panic":

---[ end Kernel panic - not syncing: Out of memory and no killable processes...

There is no fix for that.

Performance test results
------------------------
I run 5 different tests to compare the performance between the new approach
and current one. Since there are three different type of allocations i wanted
to compare them with default version, apart of those there are two extra.
One allocates in long busy list condition. Another one does random number
of pages allocation(will not post here to keep it short).

- reboot the system;
- do three iteration of full run. One run is 5 tests;
- calculate average of three run(microseconds).

i5-3320M:
le_fit_alloc_test                b_fit_alloc_test
1218459 vs 1146597 diff 5%       972322 vs 1008655 diff -3.74%
1219721 vs 1145212 diff 6%      1013817 vs  994195 diff  1.94%
1226255 vs 1142134 diff 6%      1002057 vs  993364 diff  0.87%
1239828 vs 1144809 diff 7%       985092 vs  977549 diff  0.77%
1232131 vs 1144775 diff 7%      1031320 vs  999952 diff  3.04%

ne_fit_alloc_test                long_busy_list_alloc_test
2056336 vs 2043121 diff 0.64%    55866315 vs 15037680 diff 73%
2043136 vs 2041888 diff 0.06%    57601435 vs 14809454 diff 74%
2042384 vs 2040181 diff 0.11%    52612371 vs 14550292 diff 72%
2041287 vs 2038905 diff 0.12%    48894648 vs 14769538 diff 69%
2039014 vs 2038632 diff 0.02%    55718063 vs 14727350 diff 73%

Hikey960:
le_fit_alloc_test                b_fit_alloc_test
2382168 vs 2115617 diff 11.19%   2864080 vs 2081309 diff 27.33%
2772909 vs 2114988 diff 23.73%   2968612 vs 2062716 diff 30.52%
2772579 vs 2113069 diff 23.79%   2748495 vs 2106658 diff 23.35%
2770596 vs 2111823 diff 23.78%   2966023 vs 2071139 diff 30.17%
2759768 vs 2111868 diff 23.48%   2765568 vs 2125216 diff 23.15%

ne_fit_alloc_test                long_busy_list_alloc_test
4353846 vs 4241838 diff  2.57    239789754 vs 33364305 diff 86%
4133506 vs 4241615 diff -2.62    778283461 vs 34551548 diff 95%
4134769 vs 4240714 diff -2.56    210244212 vs 33467529 diff 84%
4132224 vs 4242281 diff -2.66    429232377 vs 33307173 diff 92%
4410969 vs 4240864 diff  3.86    527560967 vs 33661115 diff 93%

Almost all results are better. Full data and the test module you can find here:

ftp://vps418301.ovh.net/incoming/vmalloc_test_module.tar.bz2
ftp://vps418301.ovh.net/incoming/HiKey960_test_result.txt
ftp://vps418301.ovh.net/incoming/i5-3320M_test_result.txt

Conclusion
----------
According to provided results and my subjective opinion, it is worth to organize
and maintain a free list and do an allocation based on it.

Appreciate for any valuable comments and sorry for the long description :)

Best Regards,
Uladzislau Rezki

Uladzislau Rezki (Sony) (2):
  mm/vmalloc: keep track of free blocks for allocation
  mm: add priority threshold to __purge_vmap_area_lazy()

 include/linux/vmalloc.h |   2 +-
 mm/vmalloc.c            | 850 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 676 insertions(+), 176 deletions(-)

-- 
2.11.0

