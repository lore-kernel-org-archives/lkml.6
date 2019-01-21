Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B36C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C54920861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfAUL6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:58:34 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:46173 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728195AbfAUL6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:58:34 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id C3C4C13F892;
        Mon, 21 Jan 2019 12:57:53 +0100 (CET)
Subject: Re: kmemleak panic
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <20190119132832.GA29881@MBP.local>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
Date:   Mon, 21 Jan 2019 12:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190119132832.GA29881@MBP.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2019 14:28, Catalin Marinas wrote:

> As per Robin's remark, this address seems to be pretty easy to
> reproduce. It also happens via scan_gray_list() which indicates an
> object kmemleak was informed about via kmemleak_alloc() (so this
> excludes the pfn that Qian noticed).
> 
> Can you configure the kernel with CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN off
> just to avoid the bug being triggered early and run:
> 
>   mount -t debugfs nodev /sys/kernel/debug/
>   echo dump=0xffffffc021e00000 > /sys/kernel/debug/kmemleak
> 
> Then run another scan to make sure this is the address that triggered
> the page fault:
> 
>   echo scan > /sys/kernel/debug/kmemleak
> 
> The above should tell us where the object that kmemleak is trying to
> scan came from.

Here are the remap requests on my system:

REMAP: PA=17a00000 VA=ffffff8010040000 SIZE=10000
REMAP: PA=17b00000 VA=ffffff8010c00000 SIZE=100000
REMAP: PA=17920000 VA=ffffff8010005000 SIZE=1000
REMAP: PA=17921000 VA=ffffff801000d000 SIZE=1000
REMAP: PA=17921000 VA=ffffff8010015000 SIZE=1000
REMAP: PA=01f40000 VA=ffffff8010fa0000 SIZE=20000
REMAP: PA=86000000 VA=ffffff8011000000 SIZE=200000
REMAP: PA=00100000 VA=ffffff8011300000 SIZE=b0000
REMAP: PA=17911000 VA=ffffff8010025000 SIZE=1000
REMAP: PA=00778000 VA=ffffff80115d0000 SIZE=7000
REMAP: PA=0c1b0000 VA=ffffff801002d000 SIZE=1000


# echo dump=0xffffffc021e00000 > /sys/kernel/debug/kmemleak
kmemleak: Object 0xffffffc021e00000 (size 2097152):
kmemleak:   comm "swapper/0", pid 0, jiffies 4294892296
kmemleak:   min_count = 0
kmemleak:   count = 0
kmemleak:   flags = 0x1
kmemleak:   checksum = 0
kmemleak:   backtrace:
     kmemleak_alloc_phys+0x48/0x60
     memblock_alloc_range_nid+0x8c/0xa4
     memblock_alloc_base_nid+0x4c/0x60
     __memblock_alloc_base+0x3c/0x4c
     early_init_dt_alloc_reserved_memory_arch+0x54/0xa4
     fdt_init_reserved_mem+0x308/0x3ec
     early_init_fdt_scan_reserved_mem+0x88/0xb0
     arm64_memblock_init+0x1dc/0x254
     setup_arch+0x1c8/0x4ec
     start_kernel+0x84/0x44c
     0xffffffffffffffff

# echo scan > /sys/kernel/debug/kmemleak
Unable to handle kernel paging request at virtual address ffffffc021e00000
Mem abort info:
  ESR = 0x96000006
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
[ffffffc021e00000] pgd=000000017e3ba803, pud=000000017e3ba803, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
CPU: 4 PID: 508 Comm: sh Tainted: G S                5.0.0-rc1 #11
Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
pstate: 80000085 (Nzcv daIf -PAN -UAO)
pc : scan_block+0x70/0x180
lr : scan_block+0x6c/0x180
sp : ffffff8011a2bb40
x29: ffffff8011a2bb40 x28: ffffffc0f8375e80 
x27: ffffff8010b8a000 x26: 0000000000000080 
x25: ffffff8010b8a668 x24: ffffffc0f8cc0000 
x23: ffffff8010b8a000 x22: ffffff8010a4b8c8 
x21: ffffffc021e00ff9 x20: ffffffc021e01000 
x19: ffffffc021e00000 x18: 0000000000000000 
x17: 0000000000000200 x16: 0000000000000000 
x15: ffffffffffffffff x14: ffffffff00000000 
x13: ffffffffffffffff x12: 0000000000000020 
x11: 0101010101010101 x10: 00000000004bfd20 
x9 : 7f7f7f7f7f7f7f7f x8 : fefeff096d606272 
x7 : 00000000dc3c0000 x6 : 0000000000000018 
x5 : ffffffbf03f8efc8 x4 : ffffffbf03f8efc7 
x3 : 5b36396f4e7d4000 x2 : ffffffc0f8cc0000 
x1 : ffffffc0f6689880 x0 : 0000000000000000 
Process sh (pid: 508, stack limit = 0x(____ptrval____))
Call trace:
 scan_block+0x70/0x180
 scan_gray_list+0xe0/0x190
 kmemleak_scan+0x2bc/0x540
 kmemleak_write+0x328/0x3d0
 full_proxy_write+0x68/0xa0
 __vfs_write+0x60/0x190
 vfs_write+0xac/0x1a0
 ksys_write+0x6c/0xe0
 __arm64_sys_write+0x24/0x30
 el0_svc_handler+0xb8/0x140
 el0_svc+0x8/0xc
Code: f9000fb4 d503201f 97ffffd2 35000540 (f9400260) 
---[ end trace 754cbd2624bb2b91 ]---
note: sh[508] exited with preempt_count 2


__reserved_mem_alloc_size() printed:
OF: reserved mem: allocated memory for 'rmtfs' node: base 0x00000000a1e00000, size 2 MiB

See git show c7833949564ec

The corresponding node is:

	reserved-memory {
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;

		memory@85800000 {
			reg = <0x0 0x85800000 0x0 0x800000>;
			no-map;
		};

		smem_mem: smem-mem@86000000 {
			reg = <0x0 0x86000000 0x0 0x200000>;
			no-map;
		};

		memory@86200000 {
			reg = <0x0 0x86200000 0x0 0x2600000>;
			no-map;
		};

		rmtfs {
			compatible = "qcom,rmtfs-mem";

			size = <0x0 0x200000>;
			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
			no-map;

			qcom,client-id = <1>;
			qcom,vmid = <15>;
		};
	};
