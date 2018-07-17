Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCEAECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE982086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE982086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeGQQ3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:29:37 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:60276 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbeGQQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:29:37 -0400
X-IronPort-AV: E=Sophos;i="5.51,366,1526342400"; 
   d="scan'208";a="60430561"
From:   Anoob Soman <anoob.soman@citrix.com>
Subject: GP fault in free_pcppages_bulk() while trying to list_del(&page->lru)
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <pasha.tatashin@oracle.com>,
        <iamjoonsoo.kim@lge.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Message-ID: <1f1b5a3a-9787-a134-992e-b8fbc2a9e86b@citrix.com>
Date:   Tue, 17 Jul 2018 16:55:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

A customer of us have encountered GP fault, when free_pcppages_bulk() 
tries to access list_del(). A snippet of kernel backtrace is pasted below.

CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O    4.4.0+2 #1
Hardware name: IBM System x3650 M3 -[7945K2G]-/69Y5698, BIOS 
-[D6E162AUS-1.20]- 05/07/2014
task: ffff880189dbb580 ti: ffff880189dc4000 task.ti: ffff880189dc4000
RIP: e030:[<ffffffff8115e055>]  [<ffffffff8115e055>] 
free_pcppages_bulk+0xe5/0x520
RSP: e02b:ffff88018a823d70  EFLAGS: 00010093
RAX: ffffea0004150f20 RBX: ffffffff81ac3040 RCX: ffff88018a839058
RDX: dead000000000200 RSI: ffffea00057b4900 RDI: dead000000000100
RBP: ffff88018a823dd0 R08: 0000000000000525 R09: ffffea00057b4940
R10: 0000000000000560 R11: ffff88007ee9f000 R12: 0000000004150f00
R13: 0000000000000001 R14: 0000160000000000 R15: ffffea0004150f00
FS:  00007fa2bc2e9840(0000) GS:ffff88018a820000(0000) 
knlGS:0000000000000000
CS:  e033 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00007ffafd0e3b50 CR3: 0000000149f34000 CR4: 0000000000002660
Stack:
ffff88018a823d98 ffffffff81ac34d0 ffff88018a82ae80 ffff88018a839038
ffff88018a839058 0000000100000052 0000000000000001 ffff88018a839038
ffffffff81ac0040 ffffffff8115e590 0000000000000000 0000000000000000
Call Trace:
<IRQ>
[<ffffffff8115e590>] ? page_alloc_cpu_notify+0x50/0x50
[<ffffffff8115e4cf>] drain_pages_zone+0x3f/0x60
[<ffffffff8115e51f>] drain_pages+0x2f/0x50
[<ffffffff8115e5b5>] drain_local_pages+0x25/0x30
[<ffffffff810e3d58>] flush_smp_call_function_queue+0xc8/0x130
[<ffffffff810e45d3>] generic_smp_call_function_single_interrupt+0x13/0x60
[<ffffffff81014303>] xen_call_function_interrupt+0x13/0x30
[<ffffffff810bff2f>] handle_irq_event_percpu+0x7f/0x1e0
[<ffffffff810c347a>] handle_percpu_irq+0x3a/0x50
[<ffffffff810bf732>] generic_handle_irq+0x22/0x30
[<ffffffff813c646b>] __evtchn_fifo_handle_events+0x14b/0x170
[<ffffffff813c64a0>] evtchn_fifo_handle_events+0x10/0x20
[<ffffffff813c34ba>] __xen_evtchn_do_upcall+0x4a/0x80
[<ffffffff813c5290>] xen_evtchn_do_upcall+0x30/0x50
[<ffffffff815a25ae>] xen_do_hypervisor_callback+0x1e/0x40
<EOI>

I tried decoding as much as I can, but I am confused at the moment 
wondering how this crash could happen.

Some relevant bits of objdump free_pcppages_bulk(), which is mainly 
list_del().
ffffffff8115e034:       48 bf 00 01 00 00 00    movabs 
$0xdead000000000100,%rdi
ffffffff8115e03b:       00 ad de
ffffffff8115e03e:       48 8b 40 08             mov 0x8(%rax),%rax
ffffffff8115e042:       48 8b 50 08             mov 0x8(%rax),%rdx
ffffffff8115e046:       48 8b 08                mov    (%rax),%rcx
ffffffff8115e049:       4c 8d 78 e0             lea -0x20(%rax),%r15
ffffffff8115e04d:       4f 8d 24 37             lea (%r15,%r14,1),%r12
ffffffff8115e051:       48 89 51 08             mov %rdx,0x8(%rcx)
ffffffff8115e055:       48 89 0a                mov    %rcx,(%rdx) 
<------ RIP is here
ffffffff8115e058:       48 ba 00 02 00 00 00    movabs 
$0xdead000000000200,%rdx
ffffffff8115e05f:       00 ad de
ffffffff8115e062:       48 89 38                mov    %rdi,(%rax)
ffffffff8115e065:       48 89 50 08             mov %rdx,0x8(%rax)

RIP points to ffffffff8115e055 and GP fault because RDX contains 
LIST_POISON2. RDI contains LIST_POISON1 (this doesn't matter as it is 
just a temporary register which holds POISON1)

Based on objdump, I can conclude that RDX points to entry->prev and RCX 
points to entry->next.

free_pcppages_bulk() tries to delete an entry, from pcp->list, whose 
"prev" pointer is LIST_POISON2, but "next" pointer is not poisoned. Is 
it safe to assume that this entry was in the middle of being add into a 
list and free_pcppages_bulk() went and deleted it ? One possibility it a 
different CPU is processing another CPU pcp list, but looking to the 
code, I am certain that this can never happen.

Are there any other explanation why this might happen.

As you can see from backtrace, we are running 4.4-24 kernel and we might 
have missed some patches. But looking at the history of commits, I don't 
see anything relevant fixed in this area.

Can someone point me right direction as to how to debug this further.

Thanks,
Anoob.

