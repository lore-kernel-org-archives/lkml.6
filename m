Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D8C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FFA205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="w2GOc9q1";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="BLNcOzNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FFA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeKASUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:20:17 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:60092 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbeKASUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:20:16 -0400
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Nov 2018 14:20:14 EDT
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 3ECE120271;
        Thu,  1 Nov 2018 12:12:43 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 0ovQYsmgt8-Cg7KexSO;
        Thu, 01 Nov 2018 12:12:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541063563; bh=ebsY4n0Va9JfIEsPKsOymWZKqAdGjQF8/fUOf9wJf90=;
        h=Subject:From:To:Date:Message-ID;
        b=w2GOc9q1k/z0HpLfjtjHU5SfTc+KH8xi3VSXpsSzM7QwUKRrtrEqk17qzkizyQmRp
         IN2gZNPc7r4VcfBrmeCl8nG6SipPIAjwkxsj2XtEMXcm3TDacDtnJgPZbeza3r9lY8
         r5edwATDMNqETCbwj0WWObjlX4Mw2yTyxSff2U04=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:2501:1cc0:44e4:e39a])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id NZIj356Zha-CgJ8xo9C;
        Thu, 01 Nov 2018 12:12:42 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1541063562; bh=ebsY4n0Va9JfIEsPKsOymWZKqAdGjQF8/fUOf9wJf90=;
        h=Subject:From:To:Date:Message-ID;
        b=BLNcOzNusMsnao0wP5X0oBUU5y/MPiD/Hd4vH99Z7KTInvGDeWJtDifJpvCi/vhWd
         RYGdEavPjQseSG/D8YhG2k25Mb6BL6r8bp4cK+an3QL5Zb3UCiHezlCCtv9VwgJM9X
         JzwnFC48uAdG2gKExEjwTStuLMVhq4VDmORjz2XA=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] mm/kvmalloc: do not confuse kmalloc with page order over
 MAX_ORDER
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Date:   Thu, 01 Nov 2018 12:12:40 +0300
Message-ID: <154106356066.887821.4649178319705436373.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocations over PAGE_SIZE << MAX_ORDER could be served only by vmalloc.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

---

[Thu Nov  1 08:43:56 2018] ------------[ cut here ]------------
[Thu Nov  1 08:43:56 2018] WARNING: CPU: 0 PID: 6676 at mm/vmstat.c:986 __fragmentation_index+0x54/0x60
[Thu Nov  1 08:43:56 2018] Modules linked in: ipmi_devintf ipmi_ssif ipmi_si ipmi_msghandler netconsole configfs ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 xt_u32 ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_filter ip6_tables ipt_REJECT nf_reject_ipv4 nf_log_ipv4 nf_log_common xt_LOG xt_tcpudp xt_mark xt_owner xt_conntrack xt_multiport iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_filter ip_tables x_tables nfsd auth_rpcgss nfs_acl nfs lockd grace sunrpc cls_u32 sch_fq sch_prio intel_rapl sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp 8021q kvm_intel garp mrp stp i2c_algo_bit llc drm_kms_helper kvm syscopyarea sysfillrect sysimgblt irqbypass fb_sys_fops ghash_clmulni_intel ttm wdat_wdt drm mei_me lpc_ich mei shpchp mfd_core acpi_power_meter acpi_pad
[Thu Nov  1 08:43:56 2018]  ip6_tunnel tunnel6 ipip tunnel4 ip_tunnel tcp_nv mlx4_en ptp pps_core xfs btrfs zstd_decompress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid10 mlx4_core nvme nvme_core devlink raid6_pq libcrc32c raid1 raid0 multipath linear [last unloaded: ipmi_msghandler]
[Thu Nov  1 08:43:56 2018] CPU: 0 PID: 6676 Comm: ip6tables Not tainted 4.14.78-31 #1
[Thu Nov  1 08:43:56 2018] Hardware name: AIC Inc. 21S-B312-B8/MB-DPHW1R AIDOS-M, BIOS AIDOS052 03/09/2017
[Thu Nov  1 08:43:56 2018] task: ffff881e909b8e40 task.stack: ffffc90023034000
[Thu Nov  1 08:43:56 2018] RIP: 0010:__fragmentation_index+0x54/0x60
[Thu Nov  1 08:43:56 2018] RSP: 0018:ffffc90023037b30 EFLAGS: 00010206
[Thu Nov  1 08:43:56 2018] RAX: 000000000000000b RBX: 0000000000064800 RCX: 000000000000000a
[Thu Nov  1 08:43:56 2018] RDX: 0000000000000192 RSI: ffffc90023037b38 RDI: 000000000000000d
[Thu Nov  1 08:43:56 2018] RBP: 000000000000000d R08: 0000000000065850 R09: 00000000000001c7
[Thu Nov  1 08:43:56 2018] R10: 000000000000000d R11: 0000000000000000 R12: ffff88207fffb5c0
[Thu Nov  1 08:43:56 2018] R13: 0000000000000004 R14: 0000000000000000 R15: ffffc90023037c10
[Thu Nov  1 08:43:56 2018] FS:  00007f6cf6ec9740(0000) GS:ffff881fffa00000(0000) knlGS:0000000000000000
[Thu Nov  1 08:43:56 2018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Thu Nov  1 08:43:56 2018] CR2: 00007f6cf6e4f000 CR3: 0000001e91762002 CR4: 00000000003606f0
[Thu Nov  1 08:43:56 2018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[Thu Nov  1 08:43:56 2018] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[Thu Nov  1 08:43:56 2018] Call Trace:
[Thu Nov  1 08:43:56 2018]  fragmentation_index+0x76/0x90
[Thu Nov  1 08:43:56 2018]  compaction_suitable+0x4f/0xf0
[Thu Nov  1 08:43:56 2018]  shrink_node+0x295/0x310
[Thu Nov  1 08:43:56 2018]  node_reclaim+0x205/0x250
[Thu Nov  1 08:43:56 2018]  get_page_from_freelist+0x649/0xad0
[Thu Nov  1 08:43:56 2018]  ? get_page_from_freelist+0x2d4/0xad0
[Thu Nov  1 08:43:56 2018]  ? release_sock+0x19/0x90
[Thu Nov  1 08:43:56 2018]  ? do_ipv6_setsockopt.isra.5+0x10da/0x1290
[Thu Nov  1 08:43:56 2018]  __alloc_pages_nodemask+0x12a/0x2a0
[Thu Nov  1 08:43:56 2018]  kmalloc_large_node+0x47/0x90
[Thu Nov  1 08:43:56 2018]  __kmalloc_node+0x22b/0x2e0
[Thu Nov  1 08:43:56 2018]  kvmalloc_node+0x3e/0x70
[Thu Nov  1 08:43:56 2018]  xt_alloc_table_info+0x3a/0x80 [x_tables]
[Thu Nov  1 08:43:56 2018]  do_ip6t_set_ctl+0xcd/0x1c0 [ip6_tables]
[Thu Nov  1 08:43:56 2018]  nf_setsockopt+0x44/0x60
[Thu Nov  1 08:43:56 2018]  SyS_setsockopt+0x6f/0xc0
[Thu Nov  1 08:43:56 2018]  do_syscall_64+0x67/0x120
[Thu Nov  1 08:43:56 2018]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[Thu Nov  1 08:43:56 2018] RIP: 0033:0x7f6cf63d121a
[Thu Nov  1 08:43:56 2018] RSP: 002b:00007ffe2b3568e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000036
[Thu Nov  1 08:43:56 2018] RAX: ffffffffffffffda RBX: 0000000000000028 RCX: 00007f6cf63d121a
[Thu Nov  1 08:43:56 2018] RDX: 0000000000000040 RSI: 0000000000000029 RDI: 0000000000000008
[Thu Nov  1 08:43:56 2018] RBP: 00007f6cf4074070 R08: 000000000102c208 R09: ffff80930d5a91b0
[Thu Nov  1 08:43:56 2018] R10: 00007f6cf4074010 R11: 0000000000000206 R12: 00000000015e5018
[Thu Nov  1 08:43:56 2018] R13: 00000000015e5018 R14: 0000000000000000 R15: 00000000015e5010
[Thu Nov  1 08:43:56 2018] Code: 89 c0 48 89 c1 48 69 06 e8 03 00 00 48 f7 f1 31 d2 48 05 e8 03 00 00 49 f7 f0 ba e8 03 00 00 29 c2 89 d0 c3 b8 18 fc ff ff f3 c3 <0f> 0b 31 c0 c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 57 41 56
[Thu Nov  1 08:43:56 2018] ---[ end trace 344fe97463e06220 ]---
---
 mm/util.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/util.c b/mm/util.c
index 8bf08b5b5760..9b15f846c281 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -392,6 +392,9 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	gfp_t kmalloc_flags = flags;
 	void *ret;
 
+	if (size > (PAGE_SIZE << MAX_ORDER))
+		goto fallback;
+
 	/*
 	 * vmalloc uses GFP_KERNEL for some internal allocations (e.g page tables)
 	 * so the given set of flags has to be compatible.
@@ -422,6 +425,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
+fallback:
 	return __vmalloc_node_flags_caller(size, node, flags,
 			__builtin_return_address(0));
 }

