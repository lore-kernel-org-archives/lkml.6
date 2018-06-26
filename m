Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54727C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1936A26D00
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1936A26D00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeFZRrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:47:10 -0400
Received: from foss.arm.com ([217.140.101.70]:50256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbeFZRrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:47:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 606847A9;
        Tue, 26 Jun 2018 10:47:09 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 30A323F5AD;
        Tue, 26 Jun 2018 10:47:09 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C93481AE3638; Tue, 26 Jun 2018 18:47:46 +0100 (BST)
Date:   Tue, 26 Jun 2018 18:47:46 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     James Morse <james.morse@arm.com>, mark.rutland@arm.com,
        catalin.marinas@arm.com, Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>, suzuki.poulose@arm.com,
        marc.zyngier@arm.com,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dave.martin@arm.com,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        libeijian@hisilicon.com
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
Message-ID: <20180626174746.GO23375@arm.com>
References: <5B2A6218.3030201@hisilicon.com>
 <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com>
 <5B3274FC.7000206@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B3274FC.7000206@hisilicon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Wed, Jun 27, 2018 at 01:16:44AM +0800, Wei Xu wrote:
> Today I tried the kernel 4.18-rc2(defconfig, no change on top) with qemu
> 2.12.0.
> The guest sometimes still failed to boot. But the crash reason is different.
> Could you please share any hint?
> Thanks!
> 
> The guest boot log is as below:
> ===========================
> 
>     estuary:/$ ./qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-v
>     ersion=3 -cpu host -enable-kvm -smp 1 -m 1024 -kernel ./Image-4.18-joyx
> -initrd
>     ../mini-rootfs-arm64.cpio.gz -nographic -append "rdinit=init
> console=ttyAMA0 ear
>     lycon=pl011,0x9000000"
> 
>     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
>     [    0.000000] Linux version 4.18.0-rc2-58583-g7daf201-dirty

I'm still suspicious that this is 4.18-rc2 with "no change on top" ^^^ !

>     [    0.048119] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000288
>     [    0.048991] Mem abort info:
>     [    0.049267]   ESR = 0x96000004
>     [    0.049567]   Exception class = DABT (current EL), IL = 32 bits
>     [    0.050146]   SET = 0, FnV = 0
>     [    0.050446]   EA = 0, S1PTW = 0
>     [    0.050754] Data abort info:
>     [    0.051038]   ISV = 0, ISS = 0x00000004
>     [    0.051921]   CM = 0, WnR = 0
>     [    0.054936] [0000000000000288] user address but active_mm is swapper
>     [    0.061427] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>     [    0.067080] Modules linked in:
>     [    0.070206] CPU: 0 PID: 13 Comm: migration/0 Not tainted
> 4.18.0-rc2-58583-g7daf201-dirty #20
>     [    0.078745] Hardware name: linux,dummy-virt (DT)
>     [    0.083433] pstate: 60400085 (nZCv daIf +PAN -UAO)
>     [    0.088258] pc : kpti_install_ng_mappings+0x154/0x214
>     [    0.093319] lr : kpti_install_ng_mappings+0x120/0x214
>     [    0.098483] sp : ffff0000093fbce0
>     [    0.101854] x29: ffff0000093fbce0 x28: ffff000008ee5000
>     [    0.107263] x27: ffff000008ee5000 x26: ffff00000923b000
>     [    0.112568] x25: ffff0000090ac000 x24: ffff0000091d9000
>     [    0.117983] x23: ffff000008ee5000 x22: 00000000411d8000
>     [    0.123392] x21: ffff00000923b000 x20: 0000000000000000
>     [    0.128801] x19: ffff0000091d8000 x18: 000000003455d99d
>     [    0.134209] x17: 0000000000000001 x16: 00f8000040ffff13
>     [    0.139513] x15: 000000007dff5000 x14: 000000007dff5000
>     [    0.144920] x13: 00f800007fe00f11 x12: 000000007dff7000
>     [    0.150329] x11: 000000007dff7000 x10: 0000000000000000
>     [    0.155633] x9 : 000000007dff8000 x8 : 000000007dff8000
>     [    0.161042] x7 : 0000000000000000 x6 : 000000004123c000
>     [    0.166451] x5 : 000000004123c000 x4 : 0000000040a5f3d4
>     [    0.171860] x3 : 0000000000000000 x2 : 000000004123b000
>     [    0.177163] x1 : ffff0000090acd88 x0 : ffff80003ca627c0

So looking at the disassembly, we access idmap_t0sz as part of
cpu_install_idmap() and it looks like we push its page address to the
stack:

>        0xffff000008091ffc <+128>:   adrp    x3, 0xffff000009096000 <early_node_cpu_hwid+1440>

[...]

>        0xffff000008092044 <+200>:   str     x3, [x29,#96]

Then after we've come back from the asm call, we want to access idmap_t0sz
again as part of cpu_uninstall_idmap() so we pop it back off:

>        0xffff0000080920cc <+336>:   ldr     x3, [x29,#96]
>        0xffff0000080920d0 <+340>:   ldr     x0, [x3,#648]

And this access is the one that faults, because we popped off NULL.

So actually, rather than faulting on the stack access, we're managing to
load zeroes from somewhere, so it could still be indicative of page table
corruption for the stack mapping.

If you look at the __idmap_kpti_put_pgtable_ent_ng asm macro, can you try
replacing:

	dc      civac, cur_\()\type\()p

with:

	dc      ivac, cur_\()\type\()p

please? Only do this for the guest kernel, not the host. KVM will upgrade
the clean to a clean+invalidate, so it's interesting to see if this has
an effect on the behaviour.

Will
