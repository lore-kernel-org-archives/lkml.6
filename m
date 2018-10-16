Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AC7C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F0720866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH2eIUQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F0720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbeJQBRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:17:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869552089E;
        Tue, 16 Oct 2018 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710737;
        bh=xcszTDTc8SxSKO9Ws0zw0zpZmjy+tJ3NoIJxnQZxi00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YH2eIUQMqyU3YUShQxuRbCI0PhVFK+X5HanTQ5DBakCMajepL6f/bhq34wLZSuloj
         gDrfUUpD9vilhNr9N3t3Zmg2OBWuvZDyy5b7obcl8us73SqrT5dgwVen8ieRH46ZKx
         0+mIfdyoDsG9ClcTGBFmn6XQUDIQga5GCRGQ+8f4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 70/71] ip: frags: fix crash in ip_do_fragment()
Date:   Tue, 16 Oct 2018 19:10:07 +0200
Message-Id: <20181016170542.905205656@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taehee Yoo <ap420073@gmail.com>

commit 5d407b071dc369c26a38398326ee2be53651cfe4 upstream

A kernel crash occurrs when defragmented packet is fragmented
in ip_do_fragment().
In defragment routine, skb_orphan() is called and
skb->ip_defrag_offset is set. but skb->sk and
skb->ip_defrag_offset are same union member. so that
frag->sk is not NULL.
Hence crash occurrs in skb->sk check routine in ip_do_fragment() when
defragmented packet is fragmented.

test commands:
   %iptables -t nat -I POSTROUTING -j MASQUERADE
   %hping3 192.168.4.2 -s 1000 -p 2000 -d 60000

splat looks like:
[  261.069429] kernel BUG at net/ipv4/ip_output.c:636!
[  261.075753] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[  261.083854] CPU: 1 PID: 1349 Comm: hping3 Not tainted 4.19.0-rc2+ #3
[  261.100977] RIP: 0010:ip_do_fragment+0x1613/0x2600
[  261.106945] Code: e8 e2 38 e3 fe 4c 8b 44 24 18 48 8b 74 24 08 e9 92 f6 ff ff 80 3c 02 00 0f 85 da 07 00 00 48 8b b5 d0 00 00 00 e9 25 f6 ff ff <0f> 0b 0f 0b 44 8b 54 24 58 4c 8b 4c 24 18 4c 8b 5c 24 60 4c 8b 6c
[  261.127015] RSP: 0018:ffff8801031cf2c0 EFLAGS: 00010202
[  261.134156] RAX: 1ffff1002297537b RBX: ffffed0020639e6e RCX: 0000000000000004
[  261.142156] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff880114ba9bd8
[  261.150157] RBP: ffff880114ba8a40 R08: ffffed0022975395 R09: ffffed0022975395
[  261.158157] R10: 0000000000000001 R11: ffffed0022975394 R12: ffff880114ba9ca4
[  261.166159] R13: 0000000000000010 R14: ffff880114ba9bc0 R15: dffffc0000000000
[  261.174169] FS:  00007fbae2199700(0000) GS:ffff88011b400000(0000) knlGS:0000000000000000
[  261.183012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  261.189013] CR2: 00005579244fe000 CR3: 0000000119bf4000 CR4: 00000000001006e0
[  261.198158] Call Trace:
[  261.199018]  ? dst_output+0x180/0x180
[  261.205011]  ? save_trace+0x300/0x300
[  261.209018]  ? ip_copy_metadata+0xb00/0xb00
[  261.213034]  ? sched_clock_local+0xd4/0x140
[  261.218158]  ? kill_l4proto+0x120/0x120 [nf_conntrack]
[  261.223014]  ? rt_cpu_seq_stop+0x10/0x10
[  261.227014]  ? find_held_lock+0x39/0x1c0
[  261.233008]  ip_finish_output+0x51d/0xb50
[  261.237006]  ? ip_fragment.constprop.56+0x220/0x220
[  261.243011]  ? nf_ct_l4proto_register_one+0x5b0/0x5b0 [nf_conntrack]
[  261.250152]  ? rcu_is_watching+0x77/0x120
[  261.255010]  ? nf_nat_ipv4_out+0x1e/0x2b0 [nf_nat_ipv4]
[  261.261033]  ? nf_hook_slow+0xb1/0x160
[  261.265007]  ip_output+0x1c7/0x710
[  261.269005]  ? ip_mc_output+0x13f0/0x13f0
[  261.273002]  ? __local_bh_enable_ip+0xe9/0x1b0
[  261.278152]  ? ip_fragment.constprop.56+0x220/0x220
[  261.282996]  ? nf_hook_slow+0xb1/0x160
[  261.287007]  raw_sendmsg+0x21f9/0x4420
[  261.291008]  ? dst_output+0x180/0x180
[  261.297003]  ? sched_clock_cpu+0x126/0x170
[  261.301003]  ? find_held_lock+0x39/0x1c0
[  261.306155]  ? stop_critical_timings+0x420/0x420
[  261.311004]  ? check_flags.part.36+0x450/0x450
[  261.315005]  ? _raw_spin_unlock_irq+0x29/0x40
[  261.320995]  ? _raw_spin_unlock_irq+0x29/0x40
[  261.326142]  ? cyc2ns_read_end+0x10/0x10
[  261.330139]  ? raw_bind+0x280/0x280
[  261.334138]  ? sched_clock_cpu+0x126/0x170
[  261.338995]  ? check_flags.part.36+0x450/0x450
[  261.342991]  ? __lock_acquire+0x4500/0x4500
[  261.348994]  ? inet_sendmsg+0x11c/0x500
[  261.352989]  ? dst_output+0x180/0x180
[  261.357012]  inet_sendmsg+0x11c/0x500
[ ... ]

v2:
 - clear skb->sk at reassembly routine.(Eric Dumarzet)

Fixes: fa0f527358bd ("ip: use rb trees for IP frag queue.")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c                  |    1 +
 net/ipv6/netfilter/nf_conntrack_reasm.c |    1 +
 2 files changed, 2 insertions(+)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -597,6 +597,7 @@ static int ip_frag_reasm(struct ipq *qp,
 			nextp = &fp->next;
 			fp->prev = NULL;
 			memset(&fp->rbnode, 0, sizeof(fp->rbnode));
+			fp->sk = NULL;
 			head->data_len += fp->len;
 			head->len += fp->len;
 			if (head->ip_summed != fp->ip_summed)
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -452,6 +452,7 @@ nf_ct_frag6_reasm(struct frag_queue *fq,
 		else if (head->ip_summed == CHECKSUM_COMPLETE)
 			head->csum = csum_add(head->csum, fp->csum);
 		head->truesize += fp->truesize;
+		fp->sk = NULL;
 	}
 	sub_frag_mem_limit(fq->q.net, head->truesize);
 


