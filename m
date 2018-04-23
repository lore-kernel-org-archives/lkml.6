Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbeDWIT0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:19:26 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46484 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754379AbeDWITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:19:21 -0400
X-Google-Smtp-Source: AIpwx4/3c7chx5K1VeTTqJGAKDczAWikCxZEV0Wika40/7L6Z3BFwohCu/rqNYr3GkdUvCgkK+OdRQ==
MIME-Version: 1.0
From: Angel Shtilianov <kernel@kyup.com>
Date: Mon, 23 Apr 2018 11:19:17 +0300
X-Gmail-Original-Message-ID: <CAJM9R-+gvPpxL-zQQx6h=ArJ1Gc2--RyOoONUi-91NL18yJGfw@mail.gmail.com>
Message-ID: <CAJM9R-+gvPpxL-zQQx6h=ArJ1Gc2--RyOoONUi-91NL18yJGfw@mail.gmail.com>
Subject: linuux-4.15 __do_softirq() crash
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am hitting this issue several times over the past two months on
different machines. I haven't found a way to manually reproduce it.
I've observed it on 4.15.3 too.

Regarding the backtrace in irq_exit() we are calling __do_softirq()
regardless of the fact we are already in IRQ. Any suggestions how to
debug it?

[2399268.392700] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[2399268.393316] BUG: unable to handle kernel paging request at ffffffff81c50370
[2399268.393663] IP: aes_ctr_rfc3686_dec_tv_template+0x3f0/0x11e0
[2399268.393999] PGD 200c067 P4D 200c067 PUD 200d063 PMD 8000000001c000e1
[2399268.394340] Oops: 0011 [#1] SMP PTI
[2399268.394674] Modules linked in:
livepatch_sctp_verify_size_of_a_new_chunk(OK)
livepatch_nf_ebt_dont_trust_userland_offsets(OK) dm_snapshot
netconsole tcp_diag inet_diag nf_conntrack_irc nf_conntrack_pptp
nf_conntrack_proto_gre nf_conntrack_tftp ipt_MASQUERADE
nf_nat_masquerade_ipv4 xt_CHECKSUM ipt_rpfilter xt_DSCP xt_dscp
xt_statistic nf_log_ipv4 nf_log_common xt_LOG xt_time xt_connlimit
xt_realm xt_NFQUEUE xt_tcpmss xt_addrtype xt_TPROXY xt_CLASSIFY
xt_hashlimit xt_length xt_connmark xt_recent xt_iprange xt_policy
xt_nat xt_pkttype ip6t_REJECT nf_reject_ipv6 cls_fw xt_mark
iptable_mangle sch_sfq sch_htb xt_mac xt_physdev br_netfilter
ebtable_filter ebtables arptable_filter arp_tables veth storpool_bd(O)
storpool_rdma(O) loadavg_cont(O) bridge stp llc iptable_nat
nf_nat_ipv4 xt_comment nf_conntrack_ipv4
[2399268.397840]  nf_defrag_ipv4 xt_owner xt_set xt_conntrack
xt_multiport xt_CT iptable_raw nf_conntrack_ipv6 nf_defrag_ipv6
xt_state ip6table_filter ip6_tables ip_set_hash_ip ip_set_hash_ipport
ip_set rdma_ucm ib_ucm ib_uverbs rdma_cm ib_cm iw_cm ext2 dm_thin_pool
dm_bio_prison dm_persistent_data dm_bufio dm_mirror dm_region_hash
dm_log xfrm6_tunnel xfrm6_mode_tunnel udp_tunnel nf_nat_ftp nf_nat
nf_conntrack_ftp nf_conntrack ipip ip_tunnel tunnel4 ip6_tunnel
tunnel6 ib_umad ixgbe mdio ib_qib rdmavt ib_core ipv6 crc_ccitt
i2c_i801 lpc_ich mfd_core shpchp ioatdma ses enclosure ipmi_devintf
ipmi_si ipmi_msghandler tcp_scalable igb dca i2c_algo_bit
[2399268.400450] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G           O
K  4.15.6-clouder2 #28
[2399268.401060] Hardware name: Supermicro X10DRi/X10DRi, BIOS 2.0 12/28/2015
[2399268.401407] RIP: 0010:aes_ctr_rfc3686_dec_tv_template+0x3f0/0x11e0
[2399268.401752] RSP: 0018:ffff881fff743ca0 EFLAGS: 00010216
[2399268.402097] RAX: 000000000000000b RBX: 000000000001f440 RCX:
00000000ffffffff
[2399268.402712] RDX: 0000000000000000 RSI: ffff881ff837ea60 RDI:
00000000ffffffff
[2399268.403321] RBP: ffff881fff755338 R08: ffffffffffffffff R09:
0000008000000800
[2399268.403930] R10: 0000000000000001 R11: 0000000000000000 R12:
ffff881ff837ea40
[2399268.404540] R13: 0000000000000000 R14: ffff881ff837ea60 R15:
ffff881fff743cd8
[2399268.405152] FS:  0000000000000000(0000) GS:ffff881fff740000(0000)
knlGS:0000000000000000
[2399268.405765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2399268.413782] CR2: ffffffff81c50370 CR3: 000000000200a001 CR4:
00000000003606e0
[2399268.414394] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[2399268.415002] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[2399268.415608] Call Trace:
[2399268.415940]  <IRQ>
[2399268.416277]  ? cpumask_next_and+0x2b/0x40
[2399268.416614]  ? find_busiest_group+0xfb/0x9a0
[2399268.416950]  ? load_balance+0x141/0x970
[2399268.417285]  ? run_rebalance_domains+0x21f/0x2a0
[2399268.417627]  ? __do_softirq+0x109/0x337
[2399268.417964]  ? irq_exit+0x86/0x90
[2399268.418298]  ? smp_apic_timer_interrupt+0x60/0x130
[2399268.418635]  ? apic_timer_interrupt+0x84/0x90
[2399268.418971]  </IRQ>
[2399268.419309]  ? cpuidle_enter_state+0xb0/0x2f0
[2399268.419646]  ? cpuidle_enter_state+0xa5/0x2f0
[2399268.419986]  ? do_idle+0xde/0x190
[2399268.420321]  ? cpu_startup_entry+0x19/0x20
[2399268.420659]  ? secondary_startup_64+0xa5/0xb0
[2399268.420996] Code: be ca bf 32 03 ed f0 50 1c 56 39 5b a4 75 18 f7
9b 58 ef 53 fc 2a 38 23 15 75 cd 45 e5 5a 82 55 ba 21 fa d4 bd c6 94
7c c5 80 12 <f7> 4b 32 c4 9a 82 d8 28 8f d9 c2 0f 60 03 be 5e 21 d6 5f
58 bf
[2399268.421920] RIP: aes_ctr_rfc3686_dec_tv_template+0x3f0/0x11e0
RSP: ffff881fff743ca0

Thanks in advance,
Angel Shtilianov
