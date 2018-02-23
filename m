Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935776AbeBWTAj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:00:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42034 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932816AbeBWTAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:00:37 -0500
Subject: Re: Kernel panic with 4.16-rc1 (and 4.16-rc2) running selftest
To: Khalid Aziz <khalid.aziz@oracle.com>, linux-kernel@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7995f335-ccac-bfdc-bb37-46d0f887c647@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b926a569-c05e-dd49-a25d-555e88e9ff8e@infradead.org>
Date: Fri, 23 Feb 2018 11:00:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7995f335-ccac-bfdc-bb37-46d0f887c647@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding netdev]

On 02/23/2018 08:05 AM, Khalid Aziz wrote:
> I am seeing a kernel panic with 4.16-rc1 and 4.16-rc2 kernels when running selftests
> from tools/testing/selftests. Last messages from selftest before kernel panic are:
> 
> --------------------
> running psock_tpacket test
> --------------------
> test: TPACKET_V1 with PACKET_RX_RING test: skip TPACKET_V1 PACKET_RX_RING since user and kernel space have different bit width
> test: TPACKET_V1 with PACKET_TX_RING test: skip TPACKET_V1 PACKET_TX_RING since user and kernel space have different bit width
> test: TPACKET_V2 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
> test: TPACKET_V2 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
> test: TPACKET_V3 with PACKET_RX_RING .................... 100 pkts (14200 bytes)
> test: TPACKET_V3 with PACKET_TX_RING .................... 100 pkts (14200 bytes)
> OK. All tests passed
> [PASS]
> ok 1..7 selftests: run_afpackettests [PASS]
> selftests: test_bpf.sh
> ========================================
> test_bpf: [FAIL]
> not ok 1..8 selftests:  test_bpf.sh [FAIL]
> selftests: netdevice.sh
> ========================================
> ok 1..9 selftests: netdevice.sh [PASS]
> selftests: rtnetlink.sh
> ========================================
> PASS: policy routing
> PASS: route get
> 
> 
> Kernel panic message is below:
> 
> [  572.486722] BUG: unable to handle kernel paging request at 0000000006000000
> [  572.494498] IP: tcf_exts_dump_stats+0x10/0x30
> [  572.499360] PGD 800000be413cb067 P4D 800000be413cb067 PUD bead15c067 PMD 0 [  572.507126] Oops: 0000 [#1] SMP PTI
> [  572.511010] Modules linked in: cls_u32 sch_htb dummy vfat fat ext4 mbcache jb
> d2 intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel crypto_simd glue_helper cryptd sg iTCO_wdt iTCO_vendor_support ioatdma ipmi_ssif pcspkr wmi i2c_i801 lpc_ich shpchp mfd_core ipmi_si ipmi_devintf ipmi_msghandler nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm igb ahci crc32c_intel nvme libahci dca drm megaraid_sas nvme_core i2c_algo_bit libata bnxt_en i2c_core dm_mirror dm_region_hash dm_log dm_mod
> [  572.574377] CPU: 81 PID: 17886 Comm: tc Not tainted 4.16.0-rc2 #112
> [  572.581371] Hardware name: Oracle Corporation ORACLE SERVER X7-2/ASM, MB, X7-2, BIOS 41017600 10/06/2017
> [  572.591957] RIP: 0010:tcf_exts_dump_stats+0x10/0x30
> [  572.597402] RSP: 0018:ffffc900313b7928 EFLAGS: 00010206
> [  572.603226] RAX: 0000000006000000 RBX: ffff88bea9117db0 RCX: 0000000000001ca4
> [  572.611191] RDX: 0000000000001ca3 RSI: ffff88bea90cf018 RDI: ffff88be4fb6c000
> [  572.619157] RBP: ffff88be4fb6c000 R08: 0000000000024800 R09: ffffffffa05697fb
> [  572.627121] R10: ffff88bebe064800 R11: ffffea02faa445c0 R12: ffff88bea90ce034
> [  572.635087] R13: ffff88bea90cf000 R14: ffff88be9fe33300 R15: ffff88bea90ce000
> [  572.643053] FS:  00007f98ae464740(0000) GS:ffff88bebe040000(0000) knlGS:0000000000000000
> [  572.652084] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  572.658497] CR2: 0000000006000000 CR3: 000000be41a94005 CR4: 00000000007606e0
> [  572.666462] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  572.674428] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  572.682393] PKRU: 55555554
> [  572.685413] Call Trace:
> [  572.688145]  u32_dump+0x2be/0x3c0 [cls_u32]
> [  572.692816]  tcf_fill_node.isra.29+0x15b/0x1f0
> [  572.697777]  tfilter_notify+0xc1/0x150
> [  572.701952]  tc_ctl_tfilter+0x87d/0xbd0
> [  572.706238]  rtnetlink_rcv_msg+0x29c/0x310
> [  572.710813]  ? _cond_resched+0x15/0x30
> [  572.714999]  ? __kmalloc_node_track_caller+0x1b9/0x270
> [  572.720737]  ? rtnl_calcit.isra.28+0x100/0x100
> [  572.725697]  netlink_rcv_skb+0xd2/0x110
> [  572.729969]  netlink_unicast+0x17c/0x230
> [  572.734348]  netlink_sendmsg+0x2cd/0x3c0
> [  572.738719]  sock_sendmsg+0x30/0x40
> [  572.742612]  ___sys_sendmsg+0x27a/0x290
> [  572.746896]  ? do_wp_page+0x89/0x4c0
> [  572.750886]  ? page_add_new_anon_rmap+0x72/0xc0
> [  572.755944]  ? __handle_mm_fault+0x74b/0x1280
> [  572.760807]  __sys_sendmsg+0x51/0x90
> [  572.764800]  do_syscall_64+0x6e/0x1a0
> [  572.768888]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [  572.774526] RIP: 0033:0x7f98ada843b0
> [  572.778515] RSP: 002b:00007fff833a4f38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> [  572.786963] RAX: ffffffffffffffda RBX: 000000005a8deb31 RCX: 00007f98ada843b0
> [  572.794929] RDX: 0000000000000000 RSI: 00007fff833a4f80 RDI: 0000000000000003
> [  572.802892] RBP: 00007fff833a4f80 R08: 0000000000000000 R09: 0000000000000001
> [  572.810856] R10: 00007fff833a4320 R11: 0000000000000246 R12: 0000000000000000
> [  572.818823] R13: 0000000000650ba0 R14: 00007fff833b11e8 R15: 0000000000000000
> [  572.826779] Code: ff ff ff 31 c9 eb f4 0f 1f 40 00 e8 2b 0d a0 ff 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 46 04 85 c0 74 1c 48 8b 46 08 <48> 8b 30 48 85 f6 74 0e ba 01 00 00 00 e8 ae 40 00 00 c1 f8 1f [  572.847854] RIP: tcf_exts_dump_stats+0x10/0x30 RSP: ffffc900313b7928
> [  572.854936] CR2: 0000000006000000
> [  572.858670] ---[ end trace 2c7ba9c84208074a ]---
> [  572.867859] Kernel panic - not syncing: Fatal exception
> [  572.873821] Kernel Offset: disabled
> [  572.881602] ---[ end Kernel panic - not syncing: Fatal exception
> 
> Same selftest does not cause panic on 4.15. git bisect pointed to commit 6ce711f2750031d12cec91384ac5cfa0a485b60a ("idr: Make 1-based IDRs more efficient").
> Kernel config is attached.
> 
> -- 
> Khalid


-- 
~Randy
