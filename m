Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B499BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579A8217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 22:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HwRYwbqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfBCWAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 17:00:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36562 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfBCWAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 17:00:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so10095490ljk.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 14:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qnTtavBf+ARV/EzmojQ527VP+d0tECRMzG4uClCR+Ck=;
        b=HwRYwbqd27NY58O/sDpDV7WN6Cos5QnHiv+vnwdhomhhtepw6+lbgv44S2mbgLzeur
         iu5y+HcobsvwulVBS4ubXg5BA473LWts9jTWoEUpdbNaOh1hlWkKPsq3DGKseQi50OEF
         P2zOAbOARqxBb2ixbVHZkYmQ1kiailhajkmPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qnTtavBf+ARV/EzmojQ527VP+d0tECRMzG4uClCR+Ck=;
        b=Gca8fHIy2ofVCQattXyfYVYSRNRDo7pBkfjnCP5Q89oajh48CbJW9aHu08FRO0jZtj
         aM7sigiM3fcmjlo9RLKB9Ha+vH97cA7KBGbU0GFI+dTf6NK9sPFOO/IeC7+CuL3cTpaJ
         QUIGZl3rVajDbiDhSe9xNKcE+EBek/8wt8BQpdHrQlN525Vf7BODeQ6m9Y1jtcIvE4jC
         +dCdE8yQa44/6rQHR8IWRkbIiTZob94n8wLBcqnZlbHDRZnd32aeejWz90RBEdSWyIUs
         Hk5n7G406Nw+EOZgsNsVxGFfMpzJHHvJZKUHJvCzvKyHRpmf1C3qwElOUb3uQhAfrfhK
         1WlQ==
X-Gm-Message-State: AJcUukdtg7gGcn7F2vKgxUbgxY47OnMPdkQIG3Yl/MB/zQUx4lj9pNwq
        +94o7t6Dm5YXBzxlVh1JD2FT1rZ9Jjs=
X-Google-Smtp-Source: ALg8bN64G1QiSHsukJxPhPgm/EOIoAOA+b9VkBPu90DZdAbfGGf/+9iPrF1Nj906PU1EtBg9RPkh0w==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr38986341lje.110.1549231211665;
        Sun, 03 Feb 2019 14:00:11 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t18sm2673577lft.93.2019.02.03.14.00.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 14:00:10 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id n23so3552456lfl.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 14:00:10 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr4182209lfh.117.1549231209608;
 Sun, 03 Feb 2019 14:00:09 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Feb 2019 13:59:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjoGOgYFCbpazT2Fyv=zHaiagU5PhmiAfrZ5DOmE-y0rg@mail.gmail.com>
Message-ID: <CAHk-=wjoGOgYFCbpazT2Fyv=zHaiagU5PhmiAfrZ5DOmE-y0rg@mail.gmail.com>
Subject: Linux 5.0-rc5
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm happy to report that things seem to be calming down nicely, and
rc5 is noticeably smaller than previous rc's. Let's hope the trend
continues.

About a third of the changes are to drivers (networking, rdma, scsi,
block, misc), with the rest being spread out all over (tooling,
networking, filesystems, arch updates, core  kernel..)

Nothing looks particularly worrisome, so assuming the trend holds, we
look to be on track for a fairly normal release cycle despite the
early hiccups due to the holidays.

Go out there and test in between the commercial breaks,

             Linus

---

Abel Vesa (1):
      clk: imx: Fix fractional clock set rate computation

Al Viro (1):
      btrfs: fix potential oops in device_list_add

Alexandre Ghiti (1):
      riscv: Adjust mmap base address at a third of task size

Alexei Naberezhnov (1):
      md/raid5: fix 'out of memory' during raid cache recovery

Alexey Dobriyan (1):
      proc: fix /proc/net/* after setns(2)

Alexey Khoroshilov (1):
      net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()

Alistair Francis (1):
      RISC-V: defconfig: Enable Generic PCIE by default

Anders Roxell (2):
      netfilter: ipt_CLUSTERIP: fix warning unused variable cn
      kasan: mark file common so ftrace doesn't trace it

Andi Kleen (1):
      perf script: Fix crash with printing mixed trace point and other even=
ts

Andrea Arcangeli (1):
      mm/hugetlb.c: teach follow_hugetlb_page() to handle FOLL_NOWAIT

Andreas Gruenbacher (1):
      gfs2: Revert "Fix loop in gfs2_rbm_find"

Andreas Schwab (2):
      RISC-V: fix bad use of of_node_put
      tty/serial: use uart_console_write in the RISC-V SBL early console

Andrei Vagin (1):
      kernel/exit.c: release ptraced tasks before zap_pid_ns_processes

Andrew Lunn (2):
      net: dsa: mv88e6xxx: Fix serdes irq setup going recursive
      gpio: vf610: Mask all GPIO interrupts

Antony Pavlov (2):
      RISC-V: asm/page.h: fix spelling mistake "CONFIG_64BITS" -> "CONFIG_6=
4BIT"
      RISC-V: Kconfig: fix spelling mistake "traget" -> "target"

Ard Biesheuvel (1):
      arm64: kaslr: ensure randomized quantities are clean also when
kaslr is off

Arnaldo Carvalho de Melo (1):
      perf python: Remove -fstack-clash-protection when building with
some clang versions

Artemy Kovalyov (1):
      RDMA/umem: Add missing initialization of owning_mm

Aurelien Aptel (1):
      CIFS: fix use-after-free of the lease keys

Axel Lin (1):
      gpio: altera-a10sr: Set proper output level for direction_output

Aya Levin (1):
      net/mlx5e: Allow MAC invalidation while spoofchk is ON

Bartosz Golaszewski (1):
      gpiolib: fix line event timestamps for nested irqs

Baruch Siach (1):
      Revert "PCI: armada8k: Add support for gpio controlled reset signal"

Benedict Wong (1):
      xfrm: Make set-mark default behavior backward compatible

Bernard Pidoux (1):
      net/rose: fix NULL ax25_cb kernel panic

Bodong Wang (1):
      Revert "net/mlx5e: E-Switch, Initialize eswitch only if eswitch manag=
er"

Borislav Petkov (1):
      MAINTAINERS: Add Andy and Darren as arch/x86/platform/ reviewers

Brian Welty (1):
      IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM

Catalin Marinas (1):
      arm64: Do not issue IPIs for user executable ptes

Chaotian Jing (1):
      mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay

Christoph Hellwig (1):
      iomap: fix a use after free in iomap_dio_rw

Colin Ian King (2):
      selftests: cpu-hotplug: fix case where CPUs offline > CPUs present
      x86/fault: Fix sign-extend unintended sign extension

Cong Wang (1):
      netrom: switch to sock timer API

Corentin Labbe (2):
      xtensa: Fix typo use space=3D>user space
      xtensa: rename BUILTIN_DTB to BUILTIN_DTB_SOURCE

Dan Carpenter (4):
      clk: ti: Fix error handling in ti_clk_parse_divider_data()
      scsi: bnx2fc: Fix error handling in probe()
      scsi: 53c700: pass correct "dev" to dma_alloc_attrs()
      lib/test_kmod.c: potential double free in error handling

Dave Watson (2):
      net: tls: Save iv in tls_rec for async crypto requests
      net: tls: Fix deadlock in free_resources tx

David Hildenbrand (1):
      mm: migrate: don't rely on __PageMovable() of newpage after unlocking=
 it

David Sterba (1):
      btrfs: clean up pending block groups when transaction commit aborts

Derek Basehore (1):
      clk: Remove global clk traversal on fetch parent index

Doug Smythies (1):
      cpuidle: poll_state: Fix default time limit

Douglas Gilbert (1):
      scsi: scsi_debug: fix write_same with virtual_gb problem

Eric W. Biederman (1):
      btrfs: On error always free subvol_name in btrfs_mount

Fathi Boudra (2):
      selftests: net: use LDLIBS instead of LDFLAGS
      selftests: timers: use LDLIBS instead of LDFLAGS

Feras Daoud (1):
      IB/ipoib: Fix for use-after-free in ipoib_cm_tx_start

Fernando Fernandez Mancera (1):
      netfilter: nfnetlink_osf: add missing fmatch check

Filipe Manana (1):
      Btrfs: fix deadlock when allocating tree block during leaf/node split

Florian Westphal (12):
      selftests: xfrm: add block rules with adjacent/overlapping subnets
      xfrm: policy: use hlist rcu variants on inexact insert, part 2
      xfrm: policy: increment xfrm_hash_generation on hash rebuild
      xfrm: policy: delete inexact policies from inexact list on hash rebui=
ld
      xfrm: policy: fix reinsertion on node merge
      selftests: xfrm: alter htresh to trigger move of policies to hash tab=
le
      xfrm: policy: fix infinite loop when merging src-nodes
      xfrm: refine validation of template and selector families
      netfilter: nft_compat: use refcnt_t type for nft_xt reference count
      netfilter: nft_compat: make lists per netns
      netfilter: nft_compat: destroy function must not have side effects
      netfilter: ebtables: compat: un-break 32bit setsockopt when no
rules are present

Gerald Schaefer (1):
      iommu/vt-d: Fix memory leak in intel_iommu_put_resv_regions()

Guo Ren (1):
      riscv: fixup max_low_pfn with PFN_DOWN.

Harini Katakam (1):
      net: macb: Apply RXUBR workaround only to versions with errata

He Kuang (1):
      perf top: Fix wrong hottest instruction highlighted

Ian Kent (1):
      autofs: fix error return in autofs_fill_super()

Jack Morgenstein (1):
      IB/mlx4: Fix using wrong function to destroy sqp AHs under SRIOV

James Morse (3):
      arm64: kprobe: Always blacklist the KVM world-switch code
      arm64: hyp-stub: Forbid kprobing of the hyp-stub
      arm64: hibernate: Clean the __hyp_text to PoC after resume

Jan Kara (2):
      mm: migrate: make buffer_migrate_page_norefs() actually succeed
      fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()

Jason Gunthorpe (2):
      RDMA/device: Expose ib_device_try_get(()
      IB/mlx5: Fix how advise_mr() launches async work

Jason Wang (1):
      vhost: fix OOB in get_rx_bufs()

Jens Axboe (1):
      ide: ensure atapi sense request aren't preempted

Jerry Snitselaar (2):
      iommu/amd: Call free_iova_fast with pfn in map_sg
      iommu/amd: Unmap all mapped pages in error path of map_sg

Jesper Dangaard Brouer (1):
      MAINTAINERS: Add entry for XDP (eXpress Data Path)

Jianchao Wang (1):
      blk-mq: fix a hung issue when fsync

Jiri Olsa (1):
      perf ordered_events: Fix crash in ordered_events__free

Jisheng Zhang (2):
      i3c: fix missing detach if failed to retrieve i3c dev
      i3c: master: dw: fix deadlock

Joerg Roedel (1):
      iommu/mediatek: Use correct fwspec in mtk_iommu_add_device()

Johannes Berg (1):
      decnet: fix DN_IFREQ_SIZE

Johannes Weiner (3):
      psi: fix aggregation idle shut-off
      psi: clarify the Kconfig text for the default-disable option
      x86/resctrl: Avoid confusion over the new X86_RESCTRL config

John Johansen (1):
      apparmor: Fix aa_label_build() error handling for failed merges

Jonathan Neusch=C3=A4fer (1):
      init/Kconfig: fix grammar by moving a closing parenthesis

Josef Bacik (1):
      btrfs: don't end the transaction for delayed refs in throttle

Josh Elsasser (1):
      net: set default network namespace in init_dummy_netdev()

Josh Poimboeuf (1):
      cpu/hotplug: Fix "SMT disabled by BIOS" detection for KVM

Kailang Yang (1):
      ALSA: hda/realtek - Fixed hp_pin no value

Kairui Song (1):
      x86/kexec: Don't setup EFI info if EFI runtime is not enabled

Kan Liang (1):
      x86/cpu: Add Atom Tremont (Jacobsville)

Kees Cook (1):
      selftests/seccomp: Enhance per-arch ptrace syscall skip tests

Koen Vandeputte (2):
      ARM: cns3xxx: Fix writing to wrong PCI config registers after alignme=
nt
      ARM: cns3xxx: Use actual size reads for PCIe

Leonard Crestez (2):
      PCI: imx: Fix probe failure without power domain
      PCI: imx: Fix checking pd_pcie_phy device link addition

Lijun Ou (1):
      RDMA/hns: Update the kernel header file of hns

Linus Torvalds (2):
      x86: explicitly align IO accesses in memcpy_{to,from}io
      Linux 5.0-rc5

Lubomir Rintel (3):
      Revert "Input: olpc_apsp - enable the SP clock"
      Revert "clk: mmp2: add SP clock"
      Revert "dt-bindings: marvell,mmp2: Add clock id for the SP clock"

Lukas Wunner (1):
      mmc: bcm2835: Fix DMA channel leak on probe error

Manish Chopra (5):
      qed: Fix bug in tx promiscuous mode settings
      qed: Fix LACP pdu drops for VFs
      qed: Fix VF probe failure while FLR
      qed: Fix system crash in ll2 xmit
      qed: Fix stack out of bounds bug

Mark Bloch (2):
      RDMA/mlx5: Fix check for supported user flags when creating a QP
      RDMA/mlx5: Fix flow creation on representors

Masahiro Yamada (1):
      arch: unexport asm/shmparam.h for all architectures

Max Filippov (7):
      xtensa: SMP: fix ccount_timer_shutdown
      xtensa: SMP: fix secondary CPU initialization
      xtensa: smp_lx200_defconfig: fix vectors clash
      xtensa: SMP: mark each possible CPU as present
      drivers/irqchip: xtensa: add warning to irq_retrigger
      drivers/irqchip: xtensa-mx: fix mask and unmask
      xtensa: SMP: limit number of possible CPUs by NR_CPUS

Michael J. Ruhl (1):
      IB/hfi1: Remove overly conservative VM_EXEC flag check

Michal Hocko (3):
      Revert "mm, memory_hotplug: initialize struct pages for the full
memory section"
      mm, memory_hotplug: is_mem_section_removable do not pass the end of a=
 zone
      mm, memory_hotplug: __offline_pages fix wrong locking

Mike Marciniszyn (1):
      IB/hfi1: Add limit test for RC/UC send via loopback

Mikhail Zaslonko (1):
      mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone

Ming Lu (1):
      scsi: libfc: free skb when receiving invalid flogi resp

Moni Shoua (1):
      net/mlx5: Take lock with IRQs disabled to avoid deadlock

Nagadheeraj Rottela (1):
      crypto: cavium/nitrox - Invoke callback after DMA unmap

Naoya Horiguchi (1):
      mm: hwpoison: use do_send_sig_info() instead of force_sig()

Neo Hou (2):
      gpio: sprd: Fix the incorrect data register
      gpio: sprd: Fix incorrect irq type setting for the async EIC

Nir Dotan (1):
      ip6mr: Fix notifiers call on mroute_clean_tables()

Olek Poplavsky (1):
      ALSA: usb-audio: Add Opus #3 to quirks for native DSD support

Or Gerlitz (2):
      net/mlx5e: Move to use common phys port names for vport representors
      net/mlx5e: Unblock setting vid 0 for VFs through the uplink rep

Oscar Salvador (2):
      mm, memory_hotplug: don't bail out in do_migrate_range() prematurely
      mm,memory_hotplug: fix scan_movable_pages() for gigantic hugepages

Palmer Dabbelt (2):
      RISC-V: defconfig: Move CONFIG_PCI{,E_XILINX}
      RISC-V: defconfig: Add CRYPTO_DEV_VIRTIO=3Dy

Pan Bian (1):
      autofs: drop dentry reference only when it is never used

Pavel Shilovsky (4):
      CIFS: Fix possible oops and memory leaks in async IO
      CIFS: Fix trace command logging for SMB2 reads and writes
      CIFS: Do not count -ENODATA as failure for query directory
      CIFS: Do not consider -ENODATA as stat failure for reads

Petr Vorel (1):
      apparmor: Fix warning about unused function apparmor_ipv6_postroute

Piotr Jaroszynski (1):
      iomap: get/put the page in iomap_page_create/release()

Qian Cai (3):
      x86_64: increase stack size for KASAN_EXTRA
      mm/hotplug: invalid PFNs from pfn_to_online_page()
      efi/arm64: Fix debugfs crash by adding a terminator for ptdump marker

Rob Herring (1):
      dt-bindings: Fix dt_binding_check target for in tree builds

Roger Quadros (1):
      gpio: pcf857x: Fix interrupts on multiple instances

Ronnie Sahlberg (2):
      cifs: fix computation for MAX_SMB2_HDR_SIZE
      cifs: limit amount of data we request for xattrs to CIFSMaxBufSize

Sean Young (1):
      selftests: Use lirc.h from kernel tree, not from system

Shakeel Butt (1):
      mm, oom: fix use-after-free in oom_kill_process

Shay Agroskin (1):
      net/mlx5e: Fix wrong private flag usage causing checksum disable

Sinan Kaya (3):
      mfd: Fix unmet dependency warning for MFD_TPS68470
      platform/x86: Fix unmet dependency warning for ACPI_CMPC
      platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Steffen Maier (1):
      scsi: zfcp: fix sysfs block queue limit output for max_segment_size

Stephane Eranian (2):
      perf core: Fix perf_proc_update_handler() bug
      perf tools: Handle TOPOLOGY headers with no CPU

Steve French (1):
      cifs: update internal module version number

Su Yanjun (1):
      vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Suravee Suthikulpanit (1):
      iommu/amd: Fix IOMMU page flush when detach device from a domain

Takashi Iwai (1):
      ALSA: pcm: Fix tight loop of OSS capture stream

Taniya Das (1):
      clk: qcom: gcc: Use active only source for CPUSS clocks

Tetsuo Handa (2):
      block: pass no-op callback to INIT_WORK().
      oom, oom_reaper: do not enqueue same task twice

Thomas Lendacky (1):
      x86/microcode/amd: Don't falsely trick the late loading mechanism

Tomonori Sakita (1):
      net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case

Tony Jones (1):
      perf script: Fix crash when processing recorded stat data

Trond Myklebust (1):
      NFS: Fix up return value on fatal errors in nfs_page_async_flush()

Vincent Chen (1):
      RISC-V: Add _TIF_NEED_RESCHED check for kernel thread when
CONFIG_PREEMPT=3Dy

Vincent Guittot (1):
      PM-runtime: Fix deadlock with ktime_get()

Waiman Long (3):
      fs/dcache: Fix incorrect nr_dentry_unused accounting in shrink_dcache=
_sb()
      fs: Don't need to put list_lru into its own cacheline
      fs/dcache: Track & report number of negative dentries

Wei Huang (1):
      x86/boot/compressed/64: Set EFER.LME=3D1 in 32-bit trampoline
before returning to long mode

Yang Wei (8):
      net: i825xx: replace dev_kfree_skb_irq by dev_consume_skb_irq
for drop profiles
      net: alteon: replace dev_kfree_skb_irq by dev_consume_skb_irq
      net: amd8111e: replace dev_kfree_skb_irq by dev_consume_skb_irq
      net: apple: replace dev_kfree_skb_irq by dev_consume_skb_irq for
drop profiles
      net: ti: replace dev_kfree_skb_irq by dev_consume_skb_irq for
drop profiles
      net: 8139cp: replace dev_kfree_skb_irq by dev_consume_skb_irq
for drop profiles
      net: caif: call dev_consume_skb_any when skb xmit done
      net: b44: replace dev_kfree_skb_xxx by dev_consume_skb_xxx for
drop profiles

Yao Liu (1):
      nfs: Fix NULL pointer dereference of dev_name

Yishai Hadas (3):
      IB/uverbs: Fix OOPs upon device disassociation
      IB/uverbs: Fix ioctl query port to consider device disassociation
      IB/uverbs: Fix OOPs in uverbs_user_mmap_disassociate

Yonglong Liu (3):
      net: hns: Fix for missing of_node_put() after of_parse_phandle()
      net: hns: Restart autoneg need return failed when autoneg off
      net: hns: Fix wrong read accesses via Clause 45 MDIO protocol

ZhangXiaoxu (1):
      ipvs: Fix signed integer overflow when setsockopt timeout

Zhenzhong Duan (1):
      x86/speculation: Remove redundant arch_smt_update() invocation
