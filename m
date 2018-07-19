Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF54ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2A72084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2A72084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lab.ntt.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeGSFQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:16:38 -0400
Received: from tama500.ecl.ntt.co.jp ([129.60.39.148]:55649 "EHLO
        tama500.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeGSFQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:16:37 -0400
Received: from vc2.ecl.ntt.co.jp (vc2.ecl.ntt.co.jp [129.60.86.154])
        by tama500.ecl.ntt.co.jp (8.13.8/8.13.8) with ESMTP id w6J4Z11Q013511;
        Thu, 19 Jul 2018 13:35:01 +0900
Received: from vc2.ecl.ntt.co.jp (localhost [127.0.0.1])
        by vc2.ecl.ntt.co.jp (Postfix) with ESMTP id 0B012638859;
        Thu, 19 Jul 2018 13:35:01 +0900 (JST)
Received: from jcms-pop21.ecl.ntt.co.jp (jcms-pop21.ecl.ntt.co.jp [129.60.87.134])
        by vc2.ecl.ntt.co.jp (Postfix) with ESMTP id F1409638807;
        Thu, 19 Jul 2018 13:35:00 +0900 (JST)
Received: from [IPv6:::1] (unknown [129.60.241.220])
        by jcms-pop21.ecl.ntt.co.jp (Postfix) with ESMTPSA id DBDEE400864;
        Thu, 19 Jul 2018 13:35:00 +0900 (JST)
From:   Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Subject: BUG: KASAN: stack-out-of-bounds in unwind_next_frame
Message-ID: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
Date:   Thu, 19 Jul 2018 13:33:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CC-Mail-RelayStamp: 1
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Josh,

Found following bug. This bug can not be seen with this fix: 
https://lkml.org/lkml/2018/5/10/280.

Here unwind_next_frame+0x463 is pointing at: "*ip = regs->ip;" in 
deref_stack_iret_regs().


[ 2505.084076] BUG: KASAN: stack-out-of-bounds in 
unwind_next_frame+0x463/0x850
[ 2505.084079] Read of size 8 at addr ffff8803d3d87970 by task 
vhost-2815/2848

[ 2505.084083] CPU: 3 PID: 2848 Comm: vhost-2815 Not tainted 4.18.0-rc3+ #13
[ 2505.084084] Hardware name: Hewlett-Packard HP Z440 Workstation/212B, 
BIOS M60 v02.34 05/18/2017
[ 2505.084085] Call Trace:
[ 2505.084087]  <NMI>
[ 2505.084091]  dump_stack+0x71/0xac
[ 2505.084096]  print_address_description+0x65/0x22e
[ 2505.084099]  ? unwind_next_frame+0x463/0x850
[ 2505.084101]  kasan_report.cold.6+0x241/0x2fd
[ 2505.084104]  unwind_next_frame+0x463/0x850
[ 2505.084109]  ? native_iret+0x7/0x7
[ 2505.084111]  ? deref_stack_reg+0xd0/0xd0
[ 2505.084115]  __unwind_start+0x1c0/0x3c0
[ 2505.084117]  ? unwind_next_frame+0x850/0x850
[ 2505.084121]  ? perf_output_begin_forward+0x2df/0x460
[ 2505.084124]  ? native_iret+0x7/0x7
[ 2505.084128]  perf_callchain_kernel+0x19b/0x280
[ 2505.084131]  ? arch_perf_update_userpage+0x1a0/0x1a0
[ 2505.084134]  ? native_iret+0x7/0x7
[ 2505.084137]  get_perf_callchain+0x1f7/0x3d0
[ 2505.084140]  ? put_callchain_buffers+0x50/0x50
[ 2505.084143]  perf_prepare_sample+0x805/0x990
[ 2505.084146]  ? perf_output_sample+0xb90/0xb90
[ 2505.084151]  ? cyc2ns_read_begin.part.2+0x67/0x90
[ 2505.084154]  perf_event_output_forward+0x80/0x100
[ 2505.084157]  ? perf_prepare_sample+0x990/0x990
[ 2505.084159]  ? sched_clock+0x5/0x10
[ 2505.084161]  ? perf_adjust_period+0x117/0x270
[ 2505.084163]  ? __perf_event_account_interrupt+0x132/0x190
[ 2505.084166]  __perf_event_overflow+0xaa/0x190
[ 2505.084169]  __intel_pmu_pebs_event+0x349/0x3e0
[ 2505.084172]  ? setup_pebs_sample_data+0x890/0x890
[ 2505.084175]  ? stack_access_ok+0x35/0x80
[ 2505.084178]  ? native_iret+0x7/0x7
[ 2505.084181]  ? native_iret+0x7/0x7
[ 2505.084186]  intel_pmu_drain_pebs_nhm+0x3c4/0x590
[ 2505.084189]  ? __intel_pmu_pebs_event+0x3e0/0x3e0
[ 2505.084192]  ? ktime_get_mono_fast_ns+0xdb/0x120
[ 2505.084194]  ? intel_pmu_lbr_read+0x2e/0x7a0
[ 2505.084198]  ? watchdog_overflow_callback+0x83/0xb0
[ 2505.084201]  ? intel_bts_interrupt+0x7d/0x1a0
[ 2505.084203]  intel_pmu_handle_irq+0x200/0x670
[ 2505.084206]  ? intel_pmu_save_and_restart+0x80/0x80
[ 2505.084212]  ? cyc2ns_read_begin.part.2+0x67/0x90
[ 2505.084214]  ? native_sched_clock+0x75/0xf0
[ 2505.084217]  ? cyc2ns_read_begin.part.2+0x90/0x90
[ 2505.084220]  ? cyc2ns_read_begin.part.2+0x90/0x90
[ 2505.084223]  perf_event_nmi_handler+0x40/0x60
[ 2505.084225]  nmi_handle+0x73/0x150
[ 2505.084228]  default_do_nmi+0x57/0x110
[ 2505.084231]  do_nmi+0x141/0x1a0
[ 2505.084233]  end_repeat_nmi+0x16/0x50
[ 2505.084236] RIP: 0010:deref_stack_reg+0x76/0xd0
[ 2505.084237] Code: c7 40 04 00 f2 f2 f2 65 48 8b 04 25 28 00 00 00 48 
89 44 24 58 31 c0 e8 48 fe ff ff 31 d2 84 c0 74 23 48 89 ef 48 8d 74 24 
20 <e8> 75 ff ff ff 48 8b 6c 24 20 4c 89 e7 e8 18 d3 32 00 ba 01 00 00
[ 2505.084263] RSP: 0018:ffff8803d3d87970 EFLAGS: 00000202
[ 2505.084266] RAX: 0000000000000001 RBX: 1ffff1007a7b0f2e RCX: 
ffffffffa8075985
[ 2505.084267] RDX: 0000000000000000 RSI: ffff8803d3d87990 RDI: 
ffff8803d3d87e20
[ 2505.084268] RBP: ffff8803d3d87e20 R08: fffffbfff54f23db R09: 
fffffbfff54f23da
[ 2505.084270] R10: fffffbfff54f23da R11: ffffffffaa791ed1 R12: 
ffff8803d3d87b10
[ 2505.084271] R13: 0000000000000002 R14: ffff8803d3d87b18 R15: 
ffff8803d3d87b00
[ 2505.084274]  ? stack_access_ok+0x35/0x80
[ 2505.084277]  ? deref_stack_reg+0x76/0xd0
[ 2505.084279]  ? deref_stack_reg+0x76/0xd0
[ 2505.084280]  </NMI>
[ 2505.084281]  <IRQ>
[ 2505.084284]  ? __read_once_size_nocheck.constprop.7+0x10/0x10
[ 2505.084286]  ? deref_stack_reg+0xd0/0xd0
[ 2505.084288]  ? __orc_find+0x6f/0xc0
[ 2505.084291]  unwind_next_frame+0x514/0x850
[ 2505.084295]  ? __kfree_skb_flush+0x3c/0x50
[ 2505.084296]  ? __kfree_skb_flush+0x3c/0x50
[ 2505.084299]  ? deref_stack_reg+0xd0/0xd0
[ 2505.084305]  ? vhost_worker+0x147/0x1e0 [vhost]
[ 2505.084309]  ? is_module_text_address+0xa/0x11
[ 2505.084312]  ? kernel_text_address+0x4c/0x110
[ 2505.084316]  __save_stack_trace+0x82/0x100
[ 2505.084318]  ? __kfree_skb_flush+0x3c/0x50
[ 2505.084320]  save_stack+0x32/0xb0
[ 2505.084323]  ? __kasan_slab_free+0x125/0x170
[ 2505.084326]  ? kmem_cache_free_bulk+0x1af/0x3c0
[ 2505.084328]  ? __kfree_skb_flush+0x3c/0x50
[ 2505.084331]  ? net_rx_action+0x44b/0x630
[ 2505.084333]  ? __do_softirq+0x114/0x383
[ 2505.084335]  ? irq_exit+0x138/0x140
[ 2505.084337]  ? do_IRQ+0x9a/0xe0
[ 2505.084339]  ? common_interrupt+0xf/0xf
[ 2505.084345]  ? iotlb_access_ok+0x260/0x260 [vhost]
[ 2505.084348]  ? handle_rx+0x14a/0xe30 [vhost_net]
[ 2505.084353]  ? vhost_worker+0x147/0x1e0 [vhost]
[ 2505.084357]  ? kthread+0x1a0/0x1c0
[ 2505.084359]  ? ret_from_fork+0x35/0x40
[ 2505.084362]  ? skb_release_data+0x1fe/0x2d0
[ 2505.084381]  ? ixgbe_update_itr.isra.63+0x170/0x2a0 [ixgbe]
[ 2505.084396]  ? ixgbe_write_eitr+0x78/0xb0 [ixgbe]
[ 2505.084411]  ? ixgbe_poll+0x26c4/0x2850 [ixgbe]
[ 2505.084414]  __kasan_slab_free+0x125/0x170
[ 2505.084417]  kmem_cache_free_bulk+0x1af/0x3c0
[ 2505.084419]  ? __kfree_skb_flush+0x3c/0x50
[ 2505.084421]  __kfree_skb_flush+0x3c/0x50
[ 2505.084424]  net_rx_action+0x44b/0x630
[ 2505.084427]  ? napi_complete_done+0x190/0x190
[ 2505.084430]  __do_softirq+0x114/0x383
[ 2505.084432]  irq_exit+0x138/0x140
[ 2505.084435]  do_IRQ+0x9a/0xe0
[ 2505.084437]  common_interrupt+0xf/0xf
[ 2505.084438]  </IRQ>
[ 2505.084444] RIP: 0010:vq_iotlb_prefetch+0x0/0xe0 [vhost]
[ 2505.084444] Code: ff 48 89 dd e9 38 ff ff ff 48 8b 6c 24 10 e9 2e ff 
ff ff 48 83 c4 30 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 66 0f 1f 44 00 
00 <0f> 1f 44 00 00 41 54 55 31 ed 53 48 89 fb 48 81 c7 30 45 00 00 e8
[ 2505.084470] RSP: 0018:ffff880355137b08 EFLAGS: 00000282 ORIG_RAX: 
ffffffffffffffdb
[ 2505.084473] RAX: ffff88034fe24f58 RBX: ffff880373b845c8 RCX: 
ffffffffc11b8fcd
[ 2505.084474] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 
ffff880373b800a0
[ 2505.084475] RBP: 0000000000000000 R08: ffffed006aa26f57 R09: 
ffffed006aa26f56
[ 2505.084477] R10: ffffed006aa26f56 R11: ffff880355137ab7 R12: 
ffff880373b80000
[ 2505.084478] R13: 0000000000000000 R14: ffff880373b80000 R15: 
ffff880373b800a0
[ 2505.084482]  ? handle_rx+0x12d/0xe30 [vhost_net]
[ 2505.084486]  handle_rx+0x14a/0xe30 [vhost_net]
[ 2505.084490]  ? __update_load_avg_cfs_rq.isra.36+0x28/0x2a0
[ 2505.084492]  ? update_load_avg+0x921/0xa30
[ 2505.084496]  ? rb_erase_cached+0x83c/0x8a0
[ 2505.084499]  ? peek_head_len+0x390/0x390 [vhost_net]
[ 2505.084502]  ? speculative_store_bypass_update+0x210/0x210
[ 2505.084504]  ? pick_next_entity+0xf2/0x1e0
[ 2505.084507]  ? __list_add_valid+0x2d/0x70
[ 2505.084510]  ? __switch_to+0x58f/0x600
[ 2505.084513]  ? compat_start_thread+0x60/0x60
[ 2505.084516]  ? finish_task_switch+0x101/0x3e0
[ 2505.084520]  ? switch_mm_irqs_off+0x2c0/0x6d0
[ 2505.084522]  ? __schedule+0x432/0xdf0
[ 2505.084529]  vhost_worker+0x147/0x1e0 [vhost]
[ 2505.084534]  ? vhost_dev_init+0x4e0/0x4e0 [vhost]
[ 2505.084537]  ? __kthread_parkme+0xcc/0x100
[ 2505.084539]  ? parse_args.cold.14+0xc4/0xc4
[ 2505.084545]  ? vhost_dev_init+0x4e0/0x4e0 [vhost]
[ 2505.084547]  kthread+0x1a0/0x1c0
[ 2505.084550]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[ 2505.084552]  ret_from_fork+0x35/0x40

[ 2505.084555] The buggy address belongs to the page:
[ 2505.084557] page:ffffea000f4f61c0 count:1 mapcount:0 
mapping:0000000000000000 index:0x0
[ 2505.084559] flags: 0x17ffffc0000800(reserved)
[ 2505.084563] raw: 0017ffffc0000800 ffffea000f4f61c8 ffffea000f4f61c8 
0000000000000000
[ 2505.084565] raw: 0000000000000000 0000000000000000 00000001ffffffff 
0000000000000000
[ 2505.084566] page dumped because: kasan: bad access detected

[ 2505.084567] Memory state around the buggy address:
[ 2505.084569]  ffff8803d3d87800: 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00
[ 2505.084570]  ffff8803d3d87880: 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00
[ 2505.084572] >ffff8803d3d87900: 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 f1 f1
[ 2505.084573] 
    ^
[ 2505.084575]  ffff8803d3d87980: f1 f1 00 f2 f2 f2 00 00 00 00 00 00 00 
00 00 00
[ 2505.084576]  ffff8803d3d87a00: 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 
f2 00 00
[ 2505.084577] 
==================================================================
[ 2505.084578] Disabling lock debugging due to kernel taint
[ 2508.883975] WARNING: stack going in the wrong direction? 
ip=pktgen_xmit+0x4a9/0x1e30 [pktgen]


-Prashant

