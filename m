Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F3ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F9E208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCvj46kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F9E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbeKIHgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729930AbeKIHgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:44 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7668420989;
        Thu,  8 Nov 2018 21:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714355;
        bh=LHN/sU4m29CgFCHVu2JFQLjzB4MkSkHqvaMijDtY15U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCvj46kx4GqYvKjIS2gRutxU/BMgqpQY0TPJST+D1cQXBkcjDPK02MxlscEQxLRKy
         ZXyAv0F+kYhVJcYyiSDUIk/0qyh3u9zDDbq53ypbTvgBSR3tUKWCCInaNGs21rQUSK
         6WmDWng9YlmZDMqfpZ+tccGtcuAszzKTxPB04M/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Stringer <joe@ovn.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 030/114] ipv6: orphan skbs in reassembly unit
Date:   Thu,  8 Nov 2018 13:50:45 -0800
Message-Id: <20181108215101.830997103@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 48cac18ecf1de82f76259a54402c3adb7839ad01 ]

Andrey reported a use-after-free in IPv6 stack.

Issue here is that we free the socket while it still has skb
in TX path and in some queues.

It happens here because IPv6 reassembly unit messes skb->truesize,
breaking skb_set_owner_w() badly.

We fixed a similar issue for IPV4 in commit 8282f27449bf ("inet: frag:
Always orphan skbs inside ip_defrag()")
Acked-by: Joe Stringer <joe@ovn.org>

==================================================================
BUG: KASAN: use-after-free in sock_wfree+0x118/0x120
Read of size 8 at addr ffff880062da0060 by task a.out/4140

page:ffffea00018b6800 count:1 mapcount:0 mapping:          (null)
index:0x0 compound_mapcount: 0
flags: 0x100000000008100(slab|head)
raw: 0100000000008100 0000000000000000 0000000000000000 0000000180130013
raw: dead000000000100 dead000000000200 ffff88006741f140 0000000000000000
page dumped because: kasan: bad access detected

CPU: 0 PID: 4140 Comm: a.out Not tainted 4.10.0-rc3+ #59
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:15
 dump_stack+0x292/0x398 lib/dump_stack.c:51
 describe_address mm/kasan/report.c:262
 kasan_report_error+0x121/0x560 mm/kasan/report.c:370
 kasan_report mm/kasan/report.c:392
 __asan_report_load8_noabort+0x3e/0x40 mm/kasan/report.c:413
 sock_flag ./arch/x86/include/asm/bitops.h:324
 sock_wfree+0x118/0x120 net/core/sock.c:1631
 skb_release_head_state+0xfc/0x250 net/core/skbuff.c:655
 skb_release_all+0x15/0x60 net/core/skbuff.c:668
 __kfree_skb+0x15/0x20 net/core/skbuff.c:684
 kfree_skb+0x16e/0x4e0 net/core/skbuff.c:705
 inet_frag_destroy+0x121/0x290 net/ipv4/inet_fragment.c:304
 inet_frag_put ./include/net/inet_frag.h:133
 nf_ct_frag6_gather+0x1125/0x38b0 net/ipv6/netfilter/nf_conntrack_reasm.c:617
 ipv6_defrag+0x21b/0x350 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c:68
 nf_hook_entry_hookfn ./include/linux/netfilter.h:102
 nf_hook_slow+0xc3/0x290 net/netfilter/core.c:310
 nf_hook ./include/linux/netfilter.h:212
 __ip6_local_out+0x52c/0xaf0 net/ipv6/output_core.c:160
 ip6_local_out+0x2d/0x170 net/ipv6/output_core.c:170
 ip6_send_skb+0xa1/0x340 net/ipv6/ip6_output.c:1722
 ip6_push_pending_frames+0xb3/0xe0 net/ipv6/ip6_output.c:1742
 rawv6_push_pending_frames net/ipv6/raw.c:613
 rawv6_sendmsg+0x2cff/0x4130 net/ipv6/raw.c:927
 inet_sendmsg+0x164/0x5b0 net/ipv4/af_inet.c:744
 sock_sendmsg_nosec net/socket.c:635
 sock_sendmsg+0xca/0x110 net/socket.c:645
 sock_write_iter+0x326/0x620 net/socket.c:848
 new_sync_write fs/read_write.c:499
 __vfs_write+0x483/0x760 fs/read_write.c:512
 vfs_write+0x187/0x530 fs/read_write.c:560
 SYSC_write fs/read_write.c:607
 SyS_write+0xfb/0x230 fs/read_write.c:599
 entry_SYSCALL_64_fastpath+0x1f/0xc2 arch/x86/entry/entry_64.S:203
RIP: 0033:0x7ff26e6f5b79
RSP: 002b:00007ff268e0ed98 EFLAGS: 00000206 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ff268e0f9c0 RCX: 00007ff26e6f5b79
RDX: 0000000000000010 RSI: 0000000020f50fe1 RDI: 0000000000000003
RBP: 00007ff26ebc1220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ff268e0f9c0 R14: 00007ff26efec040 R15: 0000000000000003

The buggy address belongs to the object at ffff880062da0000
 which belongs to the cache RAWv6 of size 1504
The buggy address ffff880062da0060 is located 96 bytes inside
 of 1504-byte region [ffff880062da0000, ffff880062da05e0)

Freed by task 4113:
 save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:57
 save_stack+0x43/0xd0 mm/kasan/kasan.c:502
 set_track mm/kasan/kasan.c:514
 kasan_slab_free+0x73/0xc0 mm/kasan/kasan.c:578
 slab_free_hook mm/slub.c:1352
 slab_free_freelist_hook mm/slub.c:1374
 slab_free mm/slub.c:2951
 kmem_cache_free+0xb2/0x2c0 mm/slub.c:2973
 sk_prot_free net/core/sock.c:1377
 __sk_destruct+0x49c/0x6e0 net/core/sock.c:1452
 sk_destruct+0x47/0x80 net/core/sock.c:1460
 __sk_free+0x57/0x230 net/core/sock.c:1468
 sk_free+0x23/0x30 net/core/sock.c:1479
 sock_put ./include/net/sock.h:1638
 sk_common_release+0x31e/0x4e0 net/core/sock.c:2782
 rawv6_close+0x54/0x80 net/ipv6/raw.c:1214
 inet_release+0xed/0x1c0 net/ipv4/af_inet.c:425
 inet6_release+0x50/0x70 net/ipv6/af_inet6.c:431
 sock_release+0x8d/0x1e0 net/socket.c:599
 sock_close+0x16/0x20 net/socket.c:1063
 __fput+0x332/0x7f0 fs/file_table.c:208
 ____fput+0x15/0x20 fs/file_table.c:244
 task_work_run+0x19b/0x270 kernel/task_work.c:116
 exit_task_work ./include/linux/task_work.h:21
 do_exit+0x186b/0x2800 kernel/exit.c:839
 do_group_exit+0x149/0x420 kernel/exit.c:943
 SYSC_exit_group kernel/exit.c:954
 SyS_exit_group+0x1d/0x20 kernel/exit.c:952
 entry_SYSCALL_64_fastpath+0x1f/0xc2 arch/x86/entry/entry_64.S:203

Allocated by task 4115:
 save_stack_trace+0x16/0x20 arch/x86/kernel/stacktrace.c:57
 save_stack+0x43/0xd0 mm/kasan/kasan.c:502
 set_track mm/kasan/kasan.c:514
 kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:605
 kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:544
 slab_post_alloc_hook mm/slab.h:432
 slab_alloc_node mm/slub.c:2708
 slab_alloc mm/slub.c:2716
 kmem_cache_alloc+0x1af/0x250 mm/slub.c:2721
 sk_prot_alloc+0x65/0x2a0 net/core/sock.c:1334
 sk_alloc+0x105/0x1010 net/core/sock.c:1396
 inet6_create+0x44d/0x1150 net/ipv6/af_inet6.c:183
 __sock_create+0x4f6/0x880 net/socket.c:1199
 sock_create net/socket.c:1239
 SYSC_socket net/socket.c:1269
 SyS_socket+0xf9/0x230 net/socket.c:1249
 entry_SYSCALL_64_fastpath+0x1f/0xc2 arch/x86/entry/entry_64.S:203

Memory state around the buggy address:
 ffff880062d9ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff880062d9ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff880062da0000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff880062da0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff880062da0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 838b65a59a73..5a9ae56e7868 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -601,6 +601,7 @@ struct sk_buff *nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 use
 	hdr = ipv6_hdr(clone);
 	fhdr = (struct frag_hdr *)skb_transport_header(clone);
 
+	skb_orphan(skb);
 	fq = fq_find(net, fhdr->identification, user, &hdr->saddr, &hdr->daddr,
 		     skb->dev ? skb->dev->ifindex : 0, ip6_frag_ecn(hdr));
 	if (fq == NULL) {
-- 
2.17.1



