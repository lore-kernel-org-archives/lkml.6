Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A66C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAD62148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548757745;
	bh=jCk174k72s4u89RaBdPMxBrLDHXsTfGYs1hhgIGsdC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TI14KZXSN8yQNDJmPmtjYSDAkLGV6hcohqi9U8YS9zvN+/i4NboS26YOOs6pvG49B
	 WwR+8soUm7AGXC9Lxz48jcrtVdNBn+6uZyQAd73rgsLuWU96Ls1MqoZt4TIVH1tFiU
	 rKvXHXDgrxonHv/qcdIbp6EJ1ZoTLM9d8vL9Ad7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfA2K3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:29:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfA2K3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:29:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7AA720857;
        Tue, 29 Jan 2019 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548757741;
        bh=jCk174k72s4u89RaBdPMxBrLDHXsTfGYs1hhgIGsdC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nV1wOyJ8vOiWbSR+eaISFFqAE52mygFIJZP9RoNu/i9s+j0vlY+nFp5aU3X8HQpw1
         tjxgW1+BCA3RhZYEZ4NL/3my2C8gXEZ5wdQhy2oXfI/ptrHEln0VfmKs4xIVmTHaVd
         hx+1A6hUtt27lbV7q4rIiY6a14oKIG2cLO6E6oXQ=
Date:   Tue, 29 Jan 2019 11:28:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, minyard@acm.org,
        Ignat Korchagin <ignat@cloudflare.com>
Subject: Re: ipmi_msghandler crashes in 4.19
Message-ID: <20190129102859.GD12232@kroah.com>
References: <CABWYdi3oWnOWL8sDfjWX7YC6M5ASuhCZNz8tsCGgjvO5yJJRLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi3oWnOWL8sDfjWX7YC6M5ASuhCZNz8tsCGgjvO5yJJRLg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:36:42AM -0800, Ivan Babrou wrote:
> Hey,
> 
> We've upgraded some machines from 4.14 to 4.19 and started seeing rare
> crashes like these:
> 
> [75855.909507] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000d00
> [75855.925667] PGD 0 P4D 0
> [75855.936359] Oops: 0000 [#1] SMP PTI
> [75855.947951] CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G           O
>      4.19.13-cloudflare-2019.1.4 #2019.1.4
> [75855.966028] Hardware name: Quanta Cloud Technology Inc. QuantaPlex
> T42S-2U(LBG-4) -/T42S-2U MB (Lewisburg-4), BIOS 3A11.Q10 06/29/2018
> [75855.994246] RIP: 0010:__srcu_read_unlock+0xe/0x20
> [75856.006851] Code: 01 48 63 c8 65 48 ff 04 ca f0 83 44 24 fc 00 c3
> 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 83 44 24 fc 00
> 48 63 f6 <48> 8b 87 e8 0c 00 00 65 48 ff 44 f0 10 c3 0f 1f 40 00 0f 1f
> 44 00
> [75856.041551] RSP: 0018:ffffba00cc66fd48 EFLAGS: 00010286
> [75856.054564] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [75856.069449] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000018
> [75856.084168] RBP: ffffa28276abb200 R08: ffffa29119772540 R09: 0000000000000000
> [75856.098756] R10: 00000000000c1425 R11: ffffa29120a201c8 R12: ffffa29118d57e08
> [75856.113422] R13: dead000000000200 R14: dead000000000100 R15: ffffa27dcbafa400
> [75856.127798] FS:  0000000000000000(0000) GS:ffffa29120a00000(0000)
> knlGS:0000000000000000
> [75856.138973] perf: interrupt took too long (7735 > 7677), lowering
> kernel.perf_event_max_sample_rate to 25000
> [75856.143083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [75856.172956] CR2: 0000000000000d00 CR3: 000000187ca0a005 CR4: 00000000007606f0
> [75856.187116] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [75856.201312] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [75856.215274] PKRU: 55555554
> [75856.224621] Call Trace:
> [75856.230942] perf: interrupt took too long (9748 > 9668), lowering
> kernel.perf_event_max_sample_rate to 20000
> [75856.233560]  deliver_response+0x88/0xd0 [ipmi_msghandler]
> [75856.261744]  deliver_local_response+0xe/0x30 [ipmi_msghandler]
> [75856.273937]  handle_one_recv_msg+0x164/0xbf0 [ipmi_msghandler]
> [75856.285962]  ? __switch_to_asm+0x34/0x70
> [75856.295957]  ? __switch_to_asm+0x40/0x70
> [75856.306011]  ? __switch_to_asm+0x34/0x70
> [75856.315872]  ? __switch_to_asm+0x40/0x70
> [75856.325562]  ? __switch_to_asm+0x34/0x70
> [75856.325565]  ? __switch_to_asm+0x40/0x70
> [75856.325567]  ? __switch_to_asm+0x34/0x70
> [75856.325569]  ? __switch_to_asm+0x40/0x70
> [75856.325578]  handle_new_recv_msgs+0x16d/0x1e0 [ipmi_msghandler]
> [75856.325583]  ? __switch_to_asm+0x34/0x70
> [75856.381815]  tasklet_action_common.isra.21+0x4e/0xf0
> [75856.381823]  __do_softirq+0xd8/0x2d2
> [75856.399498]  ? sort_range+0x20/0x20
> [75856.399506]  run_ksoftirqd+0x1a/0x20
> [75856.415184]  smpboot_thread_fn+0xc5/0x160
> [75856.415190]  kthread+0x113/0x130
> [75856.430502]  ? kthread_create_worker_on_cpu+0x70/0x70
> [75856.430512]  ret_from_fork+0x35/0x40
> [75856.446793] Modules linked in: xt_connlimit nf_conncount xt_bpf
> xt_hashlimit cls_flow cls_u32 sch_htb sch_fq md_mod dm_crypt
> algif_skcipher af_alg dm_mod dax ip6table_nat nf_nat_ipv6
> ip6table_mangle ip6table_security ip6table_raw ip6table_filter
> ip6_tables xt_nat iptable_nat nf_nat_ipv4 nf_nat xt_TPROXY
> nf_tproxy_ipv6 nf_tproxy_ipv4 xt_connmark iptable_mangle xt_owner
> xt_CT xt_socket nf_socket_ipv4 nf_socket_ipv6 iptable_raw
> nfnetlink_log xt_NFLOG xt_tcpudp xt_comment xt_conntrack nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 xt_mark xt_multiport xt_set
> iptable_filter bpfilter ip_set_hash_netport ip_set_hash_net
> ip_set_hash_ip ip_set nfnetlink 8021q garp mrp stp llc skx_edac
> x86_pkg_temp_thermal kvm_intel kvm irqbypass crc32_pclmul crc32c_intel
> ipmi_ssif pcbc aesni_intel aes_x86_64 crypto_simd sfc(O)
> [75856.446862]  cryptd glue_helper mdio ipmi_si xhci_pci i40e tpm_crb
> ioatdma ipmi_devintf xhci_hcd dca ipmi_msghandler tpm_tis tpm_tis_core
> tpm efivarfs ip_tables x_tables
> [75856.569103] CR2: 0000000000000d00
> [75856.569124] ---[ end trace 604e13a0789ee766 ]---
> 
> [117620.868720] general protection fault: 0000 [#1] SMP PTI
> [117620.911871] CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G
> O      4.19.0-cloudflare-2018.10.3 #1
> [117620.937885] Hardware name: Quanta Computer Inc QuantaPlex
> T41S-2U/S2S-MB, BIOS S2S_3B10.03 06/21/2018
> [117620.963750] RIP: 0010:__srcu_read_unlock+0xe/0x20
> [117620.984950] Code: 01 48 63 c8 65 48 ff 04 ca f0 83 44 24 fc 00 c3
> 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 83 44 24 fc 00
> 48 63 f6 <48> 8b 87 e8 0c 00 00 65 48 ff 44 f0 10 c3 0f 1f 40
>  00 0f 1f 44 00
> [117621.020240] perf: interrupt took too long (10250 > 10230),
> lowering kernel.perf_event_max_sample_rate to 19000
> [117621.036578] RSP: 0018:ffff89007f603e38 EFLAGS: 00010286
> [117621.073528] perf: interrupt took too long (12979 > 12812),
> lowering kernel.perf_event_max_sample_rate to 15000
> [117621.084232] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [117621.133897] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
> 403a080083ad0878
> [117621.156877] RBP: ffff890d90a78e00 R08: 0000000000000002 R09:
> 0000000000020900
> [117621.179507] R10: 0000eb0270fbf3f0 R11: ffff89007f603ca4 R12:
> ffff89107b411e08
> [117621.179509] R13: dead000000000200 R14: dead000000000100 R15:
> ffff890a9b3e6800
> [117621.179511] FS:  0000000000000000(0000) GS:ffff89007f600000(0000)
> knlGS:0000000000000000
> [117621.179513] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [117621.179514] CR2: 00007f193f3095e0 CR3: 0000001f79e0a001 CR4:
> 00000000003606f0
> [117621.179526] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [117621.179527] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [117621.179529] Call Trace:
> [117621.179532]  <IRQ>
> [117621.179552]  deliver_response+0x88/0xd0 [ipmi_msghandler]
> [117621.179557]  deliver_local_response+0xe/0x30 [ipmi_msghandler]
> [117621.179561]  handle_one_recv_msg+0x164/0xbf0 [ipmi_msghandler]
> [117621.179568]  ? try_to_wake_up+0x54/0x470
> [117621.179575]  ? ipmi_si_platform_shutdown+0x20/0x20 [ipmi_si]
> [117621.236448] perf: interrupt took too long (16285 > 16223),
> lowering kernel.perf_event_max_sample_rate to 12000
> [117621.247534]  ? kcs_event+0x17d/0x730 [ipmi_si]
> [117621.426069] perf: interrupt took too long (20619 > 20356),
> lowering kernel.perf_event_max_sample_rate to 9000
> [117621.437773]  handle_new_recv_msgs+0x16d/0x1e0 [ipmi_msghandler]
> [117621.535276]  tasklet_action_common.isra.21+0x4e/0xf0
> [117621.535284]  __do_softirq+0xd8/0x2d2
> [117621.567383]  irq_exit+0xb4/0xc0
> [117621.567387]  smp_apic_timer_interrupt+0x74/0x140
> [117621.567390]  apic_timer_interrupt+0xf/0x20
> [117621.567392]  </IRQ>
> [117621.567397] RIP: 0010:finish_task_switch+0x78/0x260
> [117621.567399] Code: 65 48 8b 1c 25 00 4d 01 00 0f 1f 44 00 00 0f 1f
> 44 00 00 41 c7 46 38 00 00 00 00 41 c6 04 24 00 fb 65 48 8b 04 25 00
> 4d 01 00 <0f> 1f 44 00 00 4d 85 ed 74 1a 41 8b 85 80 03 00 00

This should all be fixed in the latest 4.19.y release, right?

thanks,

greg k-h
