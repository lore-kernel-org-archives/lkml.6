Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA11C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FBA218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHqjjMaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbeLTSfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:35:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43625 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLTSfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:35:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so1264356pgk.10;
        Thu, 20 Dec 2018 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GIr5esiJR+g1h0sX0xMo4pBhOVR/GYIdJ3mZ41O/aT8=;
        b=uHqjjMaVO7biYIKfKl35lubmLb805m8MUAIdTgvOmNZm264QJyMYMSIuqASXm5oeex
         jq2FvfdeZ9Gb/+1UQVLifDMRradI+WveEoIW7W/DXI7nQEMQO6oFOhRQALsjK6i1pADm
         ldWzfGX5h0i7PYKS4kc8sLgfg7G/VXoond7lOzkj4rP7SCNPpTsaqHlACo0iCk/ZtWB9
         04wp64H9SEa30dFluo08Y1yQML+8Kv55IDgYDRSCHhHsy3LmkbtdzIvYkQCtixssmRWN
         UN7E7voCA9H4/fVreSi6XBgcoLQlg3RGMfm/sSsG/xy/4d2AaqBalNq5ofSlwEA2Krt3
         TMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIr5esiJR+g1h0sX0xMo4pBhOVR/GYIdJ3mZ41O/aT8=;
        b=o40C3WeWv5MkxEBI0oA/x10y42ojLuUXHq4lMliptd8XM0M6KSp/1YBiqzxm+zdDRe
         LbRZ8j94zDJzbbBWVQ0V43Qp3aGpcrWIy/5yjDS5SrKC4mFsLxG8xN6LBSgGgpuk0kDu
         fVnZNEzhWgZHpjkFRUXa03q2t+/oIth8l6k00EpcU7r5oxO6oApN5dYzUg0T5/FSFsle
         gbPshDAC9WUGYTsbwETz4Gy4CB/Ig4t/tyPwQcngXsm2kgqr8q7WS6hoHGjpNcy8mdg7
         pm6K4D2MIOyFxO2rOulT51quZJ5UKjhG/cY6oic+dVofdP4sF4OhByHuECcfV6hjiF/0
         uSzg==
X-Gm-Message-State: AA+aEWbzIdwegEl52as8cMmaNz1KzFpLbU4SpcTwu3SA53ILY2unf/yQ
        jrqqMbY/uFNk934DomF5orZ30QV5
X-Google-Smtp-Source: AFSGD/VvRsQj15eAC/icZ7c1upmMGaGUIjb6p8RM3X3duWc7GUUhq4rZb2mwXanMw7TscgyXuVUR0w==
X-Received: by 2002:a63:5518:: with SMTP id j24mr23656468pgb.208.1545330918964;
        Thu, 20 Dec 2018 10:35:18 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a195sm13874039pfa.7.2018.12.20.10.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 10:35:18 -0800 (PST)
Date:   Thu, 20 Dec 2018 10:35:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 20
Message-ID: <20181220183517.GA13028@roeck-us.net>
References: <20181220194245.05f9a749@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220194245.05f9a749@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 07:42:45PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181219:
> 
> The rdma tree lost its build failure.
> 
> The net-next tree gained conflicts against the net tree and a build
> failure for which I applied a merge fix patch.
> 
> The tip tree gained a conflict against the kbuild tree.
> 
> The char-misc tree gained a conflict against the net-next tree.
> 
> The akpm-current tree gained a conflict against the asm-generic tree.
> 
> Non-merge commits (relative to Linus' tree): 10141
>  10302 files changed, 483215 insertions(+), 268840 deletions(-)
> 

I won't even try a detailed analysis. Those interested may check
https://kerneltests.org/builders/.

Guenter

---
Build results:
	total: 158 pass: 140 fail: 18
Failed builds: 
	alpha:allmodconfig 
	arm:allmodconfig 
	csky:defconfig 
	csky:allnoconfig 
	csky:tinyconfig 
	ia64:defconfig 
	ia64:allnoconfig 
	ia64:tinyconfig 
	mips:allmodconfig 
	mips:cavium_octeon_defconfig 
	nds32:allmodconfig 
	parisc:defconfig 
	parisc:allnoconfig 
	parisc:tinyconfig 
	parisc:allmodconfig 
	parisc:generic-32bit_defconfig 
	sparc64:allmodconfig 
	xtensa:allmodconfig 
Qemu test results:
	total: 328 pass: 239 fail: 89
Failed tests: 
	arm:vexpress-a9:multi_v7_defconfig:vexpress-v2p-ca9:rootfs 
	arm:vexpress-a15:multi_v7_defconfig:vexpress-v2p-ca15-tc1:rootfs 
	arm:vexpress-a15-a7:multi_v7_defconfig:vexpress-v2p-ca15_a7:rootfs 
	arm:beagle:multi_v7_defconfig:omap3-beagle:rootfs 
	arm:beaglexm:multi_v7_defconfig:omap3-beagle-xm:rootfs 
	arm:overo:multi_v7_defconfig:omap3-overo-tobi:rootfs 
	arm:midway:multi_v7_defconfig:ecx-2000:initrd 
	arm:sabrelite:multi_v7_defconfig:imx6dl-sabrelite:initrd 
	arm:xilinx-zynq-a9:multi_v7_defconfig:zynq-zc702:rootfs 
	arm:xilinx-zynq-a9:multi_v7_defconfig:zynq-zc706:rootfs 
	arm:xilinx-zynq-a9:multi_v7_defconfig:zynq-zed:rootfs 
	arm:cubieboard:multi_v7_defconfig:sun4i-a10-cubieboard:initrd 
	arm:raspi2:multi_v7_defconfig:bcm2836-rpi-2-b:rootfs 
	arm:virt:multi_v7_defconfig:rootfs 
	arm:smdkc210:exynos_defconfig:exynos4210-smdkv310:initrd 
	arm64:virt:defconfig:smp:mem512:initrd 
	arm64:virt:defconfig:smp2:mem512:usb-xhci:rootfs 
	arm64:virt:defconfig:smp4:mem512:usb-uas-xhci:rootfs 
	arm64:virt:defconfig:smp6:mem512:virtio:rootfs 
	arm64:virt:defconfig:smp8:mem512:virtio-pci:rootfs 
	arm64:virt:defconfig:smp:mem512:virtio-blk:rootfs 
	arm64:virt:defconfig:smp2:mem512:nvme:rootfs 
	arm64:virt:defconfig:smp4:mem512:mmc:rootfs 
	arm64:virt:defconfig:smp6:mem512:scsi[DC395]:rootfs 
	arm64:virt:defconfig:smp8:mem512:scsi[AM53C974]:rootfs 
	arm64:virt:defconfig:smp2:mem512:scsi[MEGASAS]:rootfs 
	arm64:virt:defconfig:smp4:mem512:scsi[MEGASAS2]:rootfs 
	arm64:virt:defconfig:smp6:mem512:scsi[53C810]:rootfs 
	arm64:virt:defconfig:smp8:mem512:scsi[53C895A]:rootfs 
	arm64:virt:defconfig:smp:mem512:scsi[FUSION]:rootfs 
	arm64:virt:defconfig:smp2:mem512:scsi[virtio]:rootfs 
	arm64:xlnx-zcu102:defconfig:smp:mem2G:initrd:xilinx/zynqmp-zcu102-rev1.0 
	arm64:xlnx-zcu102:defconfig:smp2:mem2G:sd1:rootfs:xilinx/zynqmp-zcu102-rev1.0 
	arm64:xlnx-zcu102:defconfig:smp4:mem2G:sata:rootfs:xilinx/zynqmp-zcu102-rev1.0 
	arm64:raspi3:defconfig:smp:mem1G:initrd:broadcom/bcm2837-rpi-3-b 
	arm64:raspi3:defconfig:smp4:mem1G:sd:rootfs:broadcom/bcm2837-rpi-3-b 
	arm64:virt:defconfig:nosmp:mem512:initrd 
	arm64:xlnx-zcu102:defconfig:nosmp:mem2G:initrd:xilinx/zynqmp-zcu102-rev1.0 
	arm64:xlnx-zcu102:defconfig:nosmp:mem2G:sd1:rootfs:xilinx/zynqmp-zcu102-rev1.0 
	parisc:defconfig:smp:initrd 
	parisc:defconfig:smp:mmc:rootfs 
	parisc:defconfig:smp:nvme:rootfs 
	parisc:defconfig:smp:sata-cmd646:rootfs 
	parisc:defconfig:smp:scsi:rootfs 
	parisc:defconfig:smp:scsi[53C895A]:rootfs 
	parisc:defconfig:smp:scsi[DC395]:rootfs 
	parisc:defconfig:smp:scsi[AM53C974]:rootfs 
	parisc:defconfig:nosmp:usb-ohci:rootfs 
	parisc:defconfig:nosmp:usb-ehci:rootfs 
	parisc:defconfig:nosmp:usb-xhci:rootfs 
	parisc:defconfig:nosmp:usb-uas-ehci:rootfs 
	parisc:defconfig:nosmp:usb-uas-xhci:rootfs 
	parisc:defconfig:nosmp:initrd 
	parisc:defconfig:nosmp:mmc:rootfs 
	parisc:defconfig:nosmp:nvme:rootfs 
	ppc:mpc8544ds:mpc85xx_defconfig:initrd 
	ppc:mpc8544ds:mpc85xx_defconfig:scsi[53C895A]:rootfs 
	ppc:mpc8544ds:mpc85xx_defconfig:sata-sii3112:rootfs 
	ppc:mpc8544ds:mpc85xx_defconfig:mmc:rootfs 
	ppc:mpc8544ds:mpc85xx_smp_defconfig:initrd 
	ppc:mpc8544ds:mpc85xx_smp_defconfig:scsi[DC395]:rootfs 
	ppc:mpc8544ds:mpc85xx_smp_defconfig:scsi[53C895A]:rootfs 
	ppc:mpc8544ds:mpc85xx_smp_defconfig:sata-sii3112:rootfs 
	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd 
	ppc64:mpc8544ds:ppc64_e5500_defconfig:smp:initrd 
	ppc64:ppce500:corenet64_smp_defconfig:e5500:initrd 
	ppc64:ppce500:corenet64_smp_defconfig:e5500:nvme:rootfs 
	ppc64:ppce500:corenet64_smp_defconfig:e5500:mmc:rootfs 
	ppc64:ppce500:corenet64_smp_defconfig:e5500:scsi[53C895A]:rootfs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112:rootfs 
	ppc64:powernv:powernv_defconfig:initrd 
	riscv:virt:defconfig:initrd 
	riscv:virt:defconfig:virtio-blk:rootfs 
	riscv:virt:defconfig:virtio:rootfs 
	riscv:virt:defconfig:virtio-pci:rootfs 
	riscv:virt:defconfig:mmc:rootfs 
	riscv:virt:defconfig:nvme:rootfs 
	riscv:virt:defconfig:usb-ehci:rootfs 
	riscv:virt:defconfig:usb-xhci:rootfs 
	riscv:virt:defconfig:usb-uas-ehci:rootfs 
	riscv:virt:defconfig:usb-uas-xhci:rootfs 
	riscv:virt:defconfig:scsi[53C810]:rootfs 
	riscv:virt:defconfig:scsi[53C895A]:rootfs 
	riscv:virt:defconfig:scsi[MEGASAS]:rootfs 
	riscv:virt:defconfig:scsi[MEGASAS2]:rootfs 
	riscv:virt:defconfig:scsi[FUSION]:rootfs 
	riscv:virt:defconfig:scsi[virtio]:rootfs 
	riscv:virt:defconfig:scsi[virtio-pci]:rootfs 
	i386:pc:Westmere:defconfig:pae:smp:efi32:usb:rootfs
