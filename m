Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D617CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F5026B83
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F5026B83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965440AbeFZNhE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:37:04 -0400
Received: from ozlabs.org ([203.11.71.1]:51539 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934583AbeFZNhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:37:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41FRsl6NtMz9ryk;
        Tue, 26 Jun 2018 23:36:59 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        sim <sim@linux.vnet.ibm.com>,
        manvanth <manvanth@linux.vnet.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [next-20180601][nvme][ppc] Kernel Oops is triggered when creating lvm snapshots on nvme disks
In-Reply-To: <1530003645.24245.7.camel@abdul.in.ibm.com>
References: <1530003645.24245.7.camel@abdul.in.ibm.com>
Date:   Tue, 26 Jun 2018 23:36:58 +1000
Message-ID: <87d0wd7jph.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:

> Greeting's
>
> Kernel Oops is seen on 4.17.0-rc7-next-20180601 kernel on a bare-metal
> machine when running lvm snapshot tests on nvme disks.
>
> Machine Type: Power 8 bare-metal
> kernel : 4.17.0-rc7-next-20180601
> test:  
> $ pvcreate -y /dev/nvme0n1
> $ vgcreate avocado_vg /dev/nvme0n1
> $ lvcreate --size 1.4T --name avocado_lv avocado_vg -y
> $ mkfs.ext2 /dev/avocado_vg/avocado_lv
> $ lvcreate --size 1G --snapshot --name avocado_sn /dev/avocado_vg/avocado_lv -y
> $ lvconvert --merge /dev/avocado_vg/avocado_sn

> the last command results in Oops:
>
> Unable to handle kernel paging request for data at address 0x000000d0
> Faulting instruction address: 0xc0000000002dced4
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE SMP NR_CPUS=2048 NUMA PowerNV
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in: dm_snapshot dm_bufio nvme bnx2x iptable_mangle
> ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4
> nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4
> xt_tcpudp tun bridge stp llc iptable_filter dm_mirror dm_region_hash
> dm_log dm_service_time vmx_crypto powernv_rng rng_core dm_multipath
> kvm_hv binfmt_misc kvm nfsd ip_tables x_tables autofs4 xfs lpfc
> crc_t10dif crct10dif_generic mdio nvme_fc libcrc32c nvme_fabrics
> nvme_core crct10dif_common [last unloaded: nvme]
> CPU: 70 PID: 157763 Comm: lvconvert Not tainted 4.17.0-rc7-next-20180601-autotest-autotest #1
> NIP:  c0000000002dced4 LR: c000000000244d14 CTR: c000000000244cf0
> REGS: c000001f81d6b5a0 TRAP: 0300   Not tainted  (4.17.0-rc7-next-20180601-autotest-autotest)
> MSR:  900000010280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 22442444  XER: 20000000
> CFAR: c000000000008934 DAR: 00000000000000d0 DSISR: 40000000 SOFTE: 0
> GPR00: c000000000244d14 c000001f81d6b820 c00000000109c400 c000003c9d080180
> GPR04: 0000000000000001 c000001fad510000 c000001fad510000 0000000000000001
> GPR08: 0000000000000000 f000000000000000 f000000000000008 0000000000000000
> GPR12: c000000000244cf0 c000001ffffc4f80 00007fffa0e31090 00007fffd9d9b470
> GPR16: 0000000000000000 000000000000005c 00007fffa0e3a5b0 00007fffa0e62040
> GPR20: 0000010014ad7d50 0000010014ad7d20 00007fffa0e64210 0000000000000001
> GPR24: 0000000000000000 c00000000081bae0 c000001ed2461b00 d00000000f859d08
> GPR28: c000003c9d080180 c000000000244d14 0000000000000001 0000000000000000
> NIP [c0000000002dced4] kmem_cache_free+0x1a4/0x2b0
> LR [c000000000244d14] mempool_free_slab+0x24/0x40

Are you running with slub debugging enabled?
Try booting with slub_debug=FZP

cheers
