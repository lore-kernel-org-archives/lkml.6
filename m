Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76F3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEED2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEED2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeGIMfX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:35:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58486 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932601AbeGIMfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:35:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9E96ED1;
        Mon,  9 Jul 2018 05:35:20 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1D2A3F5AD;
        Mon,  9 Jul 2018 05:35:19 -0700 (PDT)
Date:   Mon, 9 Jul 2018 13:35:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: v4.18-rc4: slab-out-of-bounds in ___bpf_prog_run
Message-ID: <20180709123517.daw7bx3gvhnu5jqm@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While fuzzing v4.18-rc4 with Syzkaller, I hit a KASAN slab-out-of-bounds
warning at ___bpf_prog_run+0x1f20 (splat at the end of this mail), which
faddr2line tells me is kernel/bpf/core.c:1303.

I can reliably trigger this with the below C program, which I minimized from
Syzkaller's auto-generated C reproducer.

Thanks,
Mark.

----
#include <stddef.h>

#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>

#include <linux/filter.h>

#define BUF_SIZE 0x30000

int sv[2] = {-1, -1};

struct sock_filter code[] = {
	{
		.code = BPF_LD | BPF_ABS,
		.k = 0x8001,
	},
	{
		.code = BPF_RET,
	}
};

struct sock_fprog fprog = { 2, code };

static char buf[BUF_SIZE];

int main(int argc, char *argv)
{
	socketpair(AF_UNIX, SOCK_SEQPACKET, 0, sv);
	setsockopt(sv[0], SOL_SOCKET, SO_ATTACH_FILTER, &fprog, sizeof(fprog));
	send(sv[1], buf, BUF_SIZE, 0);

	return 0;
}

----

----
[   25.753052] ==================================================================
[   25.756573] BUG: KASAN: slab-out-of-bounds in ___bpf_prog_run+0x1f20/0x26d0
[   25.760372] Read of size 4 at addr ffff80000bb18001 by task repro/1516
[   25.764033] 
[   25.764891] CPU: 0 PID: 1516 Comm: repro Not tainted 4.18.0-rc4 #30
[   25.768216] Hardware name: linux,dummy-virt (DT)
[   25.770727] Call trace:
[   25.772182]  dump_backtrace+0x0/0x238
[   25.774484]  show_stack+0x14/0x20
[   25.776285]  dump_stack+0xa0/0xc4
[   25.778219]  print_address_description+0x60/0x270
[   25.780176]  kasan_report+0x248/0x348
[   25.781726]  __asan_load4+0x84/0xa8
[   25.783656]  ___bpf_prog_run+0x1f20/0x26d0
[   25.785662]  __bpf_prog_run32+0x88/0xb0
[   25.787551]  sk_filter_trim_cap+0xf0/0x310
[   25.789560]  unix_dgram_sendmsg+0x3a4/0x858
[   25.791339]  unix_seqpacket_sendmsg+0x70/0xb8
[   25.793457]  sock_sendmsg+0x4c/0x68
[   25.795213]  __sys_sendto+0x1c4/0x208
[   25.796804]  sys_sendto+0xc/0x18
[   25.798262]  el0_svc_naked+0x30/0x34
[   25.799906] 
[   25.800583] Allocated by task 1:
[   25.801990]  kasan_kmalloc+0xd0/0x180
[   25.803185]  kasan_slab_alloc+0x14/0x20
[   25.804518]  __kmalloc_track_caller+0x174/0x260
[   25.805834]  kstrdup+0x3c/0x88
[   25.806814]  kstrdup_const+0x38/0x48
[   25.807913]  kvasprintf_const+0xe0/0xf8
[   25.808985]  kobject_set_name_vargs+0x58/0xe0
[   25.810219]  dev_set_name+0xac/0xd8
[   25.811185]  tty_register_device_attr+0x1f8/0x368
[   25.812629]  tty_register_driver+0x1c0/0x358
[   25.814341]  pty_init+0x26c/0x5cc
[   25.815818]  do_one_initcall+0xb4/0x218
[   25.817661]  kernel_init_freeable+0x230/0x2e0
[   25.819784]  kernel_init+0x10/0x120
[   25.821132]  ret_from_fork+0x10/0x18
[   25.822269] 
[   25.822778] Freed by task 0:
[   25.823865] (stack is not available)
[   25.825145] 
[   25.825766] The buggy address belongs to the object at ffff80000bb18080
[   25.825766]  which belongs to the cache kmalloc-128 of size 128
[   25.829823] The buggy address is located 127 bytes to the left of
[   25.829823]  128-byte region [ffff80000bb18080, ffff80000bb18100)
[   25.833461] The buggy address belongs to the page:
[   25.835264] page:ffff7e00002ec600 count:1 mapcount:0 mapping:ffff80000c40c400 index:0xffff80000bb1ad80 compound_mapcount: 0
[   25.839164] flags: 0xfffc00000008100(slab|head)
[   25.841096] raw: 0fffc00000008100 ffff7e00002ef308 ffff7e00002ec708 ffff80000c40c400
[   25.845046] raw: ffff80000bb1ad80 0000000000190017 00000001ffffffff 0000000000000000
[   25.848789] page dumped because: kasan: bad access detected
[   25.851242] 
[   25.852023] Memory state around the buggy address:
[   25.853853]  ffff80000bb17f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   25.857089]  ffff80000bb17f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   25.860771] >ffff80000bb18000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   25.863457]                    ^
[   25.864527]  ffff80000bb18080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   25.866623]  ffff80000bb18100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   25.870453] ==================================================================
[   25.874417] Disabling lock debugging due to kernel taint
[   25.877652] Kernel panic - not syncing: panic_on_warn set ...
[   25.877652] 
[   25.881311] CPU: 0 PID: 1516 Comm: repro Tainted: G    B             4.18.0-rc4 #30
[   25.884659] Hardware name: linux,dummy-virt (DT)
[   25.886917] Call trace:
[   25.888229]  dump_backtrace+0x0/0x238
[   25.890160]  show_stack+0x14/0x20
[   25.891838]  dump_stack+0xa0/0xc4
[   25.893734]  panic+0x184/0x2f8
[   25.895180]  kasan_save_enable_multi_shot+0x0/0x30
[   25.897465]  kasan_report+0x110/0x348
[   25.899327]  __asan_load4+0x84/0xa8
[   25.901243]  ___bpf_prog_run+0x1f20/0x26d0
[   25.903234]  __bpf_prog_run32+0x88/0xb0
[   25.904636]  sk_filter_trim_cap+0xf0/0x310
[   25.906491]  unix_dgram_sendmsg+0x3a4/0x858
[   25.907810]  unix_seqpacket_sendmsg+0x70/0xb8
[   25.909628]  sock_sendmsg+0x4c/0x68
[   25.911349]  __sys_sendto+0x1c4/0x208
[   25.912254]  sys_sendto+0xc/0x18
[   25.912981]  el0_svc_naked+0x30/0x34
[   25.913858] SMP: stopping secondary CPUs
[   25.914913] Kernel Offset: disabled
[   25.915821] CPU features: 0x23000438
[   25.916722] Memory Limit: none
[   25.917400] Rebooting in 86400 seconds..
