Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC61BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE1820863
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 23:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PmnSnomU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBJXBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 18:01:15 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38886 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBJXBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 18:01:14 -0500
Received: by mail-lf1-f49.google.com with SMTP id n15so2192624lfe.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pf1S9yFWTq6+A4Eys91LqLVLxWr8l50G/mYf5PYwAB8=;
        b=PmnSnomU3ucgWaZUIu6oN7GbyRqqlnsa402XFMNPcuTNQMjKm3XW/UKnV0yUuX6PJK
         hHDQFDTPQPcTJw94E5sZohQAoJgewIjbn4LjmIsmCOhvGaK6KfWEmpX0UCsQMUIJEyl+
         EimUgktyzmfmol8jczPanP9tfD4A6x4T02FYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pf1S9yFWTq6+A4Eys91LqLVLxWr8l50G/mYf5PYwAB8=;
        b=QedX5LYlaFI1qWaw+NbRsiZuh6ulw03wPIGIGdEoI7KBx4Tg21RTWn9Rcq9cVe0ZOj
         lOc9QRm+wObTEv6pz7i8SP7Y/aagoa1uZjab3lYWRlEHbHjxCsixoWlLpXm7+LrRQRe3
         +hCIxchBaEJ3eo3wwu5rkaRuGq8DN/peGz9tozG3eJc4TY6wpry+obbyTmNabw51WAga
         5eoX2hXPoukjAiRiAazKV2bl4dGJ7Xf0l321vEg8jSBBzISe/lsgChOTJ6f5uEW4jL1M
         x4cuWs6s20mA1+ti1sCOSIBcRbv57JF2Z8TDunBnsgte2x1lwtPxSHMNveAi1eKz8NTB
         Jqfw==
X-Gm-Message-State: AHQUAubPWn12ZVloiLXhVwVjGnsmAShvABuvuSaircMOOj2wgleHoed1
        trTQMPn61yUKWv7tTV6VA5hU94C6Udc=
X-Google-Smtp-Source: AHgI3IZ2C5gcr58w8SkEDXJslfAqwKXnJwxGHFS762AJA3YaX+3v2CxkEKQ7xFFw1Ajk2yVvmiGQFA==
X-Received: by 2002:ac2:434f:: with SMTP id o15mr19587841lfl.29.1549839669432;
        Sun, 10 Feb 2019 15:01:09 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id t81sm1897358lfe.84.2019.02.10.15.01.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 15:01:08 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id l10so6289965lfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 15:01:08 -0800 (PST)
X-Received: by 2002:a19:d250:: with SMTP id j77mr81189lfg.21.1549839667874;
 Sun, 10 Feb 2019 15:01:07 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Feb 2019 15:00:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=whuSY_-hAU8ugVR7a=xz3uZeRrAPdhsoMZHmZ_7Qc49YQ@mail.gmail.com>
Message-ID: <CAHk-=whuSY_-hAU8ugVR7a=xz3uZeRrAPdhsoMZHmZ_7Qc49YQ@mail.gmail.com>
Subject: Linux 5.0-rc6
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's Sunday afternoon, which means it's time for the usual release candidat=
e.

Things are fairly normal, although rc6 is a bit bigger than I would
have liked to see. There's no single reason for that, it's just
various changes all over.

Networking (both drivers and core) is perhaps the most noticeable
part, at roughly a quarter of the changes, but there's a little bit of
everything in there outside of that: other drivers (gpu, dma, iio,
sound, usb, misc..), the usual architecture updates (arm, mips, x86,
powerpc), along with a few filesystem and core kernel updates. And
another batch of selftest updates.

So while I would have wished for less at this point, nothing in there
looks all that odd or scary. I think we're still solidly on track for
a normal release.

                   Linus

---

Aaro Koskinen (3):
      ARM: OMAP: dts: N950/N9: fix onenand timings
      MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled
      staging: octeon: fix broken phylib usage

Alex Deucher (2):
      drm/amdgpu: Add missing power attribute to APU check
      drm/radeon: check if device is root before getting pci speed caps

Alexander Usyskin (1):
      mei: free read cb on ctrl_wr list flush

Alexei Starovoitov (3):
      bpf: run bpf programs with preemption disabled
      bpf: fix lockdep false positive in percpu_freelist
      bpf: fix potential deadlock in bpf_prog_register

Alexey Khoroshilov (1):
      usb: dwc3: exynos: Fix error handling of clk_prepare_enable

Anders Roxell (1):
      usb: phy: fix link errors

Andreas Ziegler (2):
      tracing: uprobes: Fix typo in pr_fmt string
      tracing/uprobes: Fix output for multiple string arguments

Andrew Lunn (2):
      net: dsa: mv88e6xxx: Fix counting of ATU violations
      MAINTAINERS: Update the ocores i2c bus driver maintainer, etc

Andy Shevchenko (2):
      serial: 8250_pci: Make PCI class test non fatal
      dmaengine: dmatest: Abort test in case of mapping error

Aneesh Kumar K.V (1):
      powerpc/radix: Fix kernel crash with mremap()

Anson Huang (1):
      ARM: dts: imx6sx: correct backward compatible of gpt

Arnaldo Carvalho de Melo (4):
      perf clang: Do not use 'return std::move(something)'
      tools headers uapi: Sync linux/in.h copy from the kernel sources
      perf symbols: Add fallback definitions for GELF_ST_VISIBILITY()
      perf trace: Support multiple "vfs_getname" probes

Arthur Demchenkov (1):
      ARM: dts: n900: fix mmc1 card detect gpio polarity

Arun Parameswaran (1):
      net: dsa: b53: Fix for failure when irq is not defined in dt

Bart Van Assche (1):
      lib/test_rhashtable: Make test_insert_dup() allocate its hash
table dynamically

Bartosz Golaszewski (1):
      ARM: dts: da850: fix interrupt numbers for clocksource

Biju Das (1):
      ARM: dts: r8a7743: Convert to new LVDS DT bindings

Bin Liu (1):
      usb: phy: am335x: fix race condition in _probe

Bjorn Helgaas (1):
      net: Don't default Cavium PTP driver to 'y'

Boris Brezillon (4):
      mtd: spinand: Handle the case where PROGRAM LOAD does not reset the c=
ache
      mtd: spinand: Fix the error/cleanup path in spinand_init()
      mtd: Remove a debug trace in mtdpart.c
      mtd: Make sure mtd->erasesize is valid even if the partition is of si=
ze 0

Brian Foster (2):
      xfs: eof trim writeback mapping as soon as it is cached
      xfs: end sync buffer I/O properly on shutdown error

Brian Norris (1):
      ath10k: correct bus type for WCN3990

Carlo Caione (1):
      arm: dts: meson: Fix IRQ trigger type for macirq

Charles Keepax (1):
      ALSA: compress: Fix stop handling on compressed capture streams

Chen-Yu Tsai (4):
      ARM: dts: sun6i: Add clock-output-names to osc24M clock
      pinctrl: sunxi: Fix and simplify pin bank regulator handling
      pinctrl: sunxi: Consider pin_base when calculating regulator array in=
dex
      pinctrl: sunxi: Correct number of IRQ banks on H6 main pin controller

Chengguang Xu (1):
      m68k: set proper major_num when specifying module param major_num

Chris Brandt (1):
      serial: sh-sci: Do not free irqs that have already been freed

Chris Wilson (1):
      drm/amdgpu: Transfer fences to dmabuf importer

Christian Brauner (4):
      selftests: add binderfs selftests
      binder: fix CONFIG_ANDROID_BINDER_DEVICES
      binderfs: respect limit on binder control creation
      binderfs: remove separate device_initcall()

Christoph Hellwig (4):
      drm/vmwgfx: remove CONFIG_X86 ifdefs
      drm/vmwgfx: remove CONFIG_INTEL_IOMMU ifdefs v2
      drm/vmwgfx: fix the check when to use dma_alloc_coherent
      drm/vmwgfx: unwind spaghetti code in vmw_dma_select_mode

Chuck Lever (1):
      svcrdma: Remove max_sge check at connect time

Codrin Ciubotariu (1):
      dmaengine: at_xdmac: Fix wrongfull report of a channel as in use

Colin Ian King (1):
      ieee802154: mcr20a: fix indentation, remove tabs

Damien Le Moal (1):
      scsi: sd_zbc: Fix zone information messages

Dan Carpenter (2):
      skge: potential memory corruption in skge_get_regs()
      net: dsa: Fix NULL checking in dsa_slave_set_eee()

Dan Murphy (1):
      iio: ti-ads8688: Update buffer allocation for timestamps

Daniel Borkmann (2):
      bpf, doc: add reviewers to maintainers entry
      ipvlan, l3mdev: fix broken l3s mode wrt local routes

Darren Hart (VMware) (1):
      Documentation/ABI: Correct mlxreg-io KernelVersion for 5.0

Darrick J. Wong (1):
      xfs: set buffer ops when repair probes for btree type

David Disseldorp (1):
      scsi: target: make the pi_prot_format ConfigFS path readable

Davidlohr Bueso (1):
      futex: Fix barrier comment

Deepak Rawat (1):
      drm/vmwgfx: Also check for crtc status while checking for DU active

Dmitry Torokhov (1):
      pinctrl: cherryview: fix Strago DMI workaround

Eli Cooper (1):
      netfilter: ipv6: Don't preserve original oif for loopback address

Eric Dumazet (4):
      rds: fix refcount bug in rds_sock_addref
      dccp: fool proof ccid_hc_[rt]x_parse_options()
      mISDN: fix a race in dev_expire_timer()
      rxrpc: bad unlock balance in rxrpc_recvmsg

Eric W. Biederman (4):
      signal: Make siginmask safe when passed a signal of 0
      signal: Always attempt to allocate siginfo for SIGSTOP
      signal: Always notice exiting tasks
      signal: Better detection of synchronous signals

Erik Schmauss (1):
      ACPI: Set debug output flags independent of ACPICA

Felix Fietkau (2):
      batman-adv: release station info tidstats
      mac80211: ensure that mgmt tx skbs have tailroom for encryption

Florian Fainelli (1):
      net: systemport: Fix WoL with password after deep sleep

Florian Westphal (2):
      selftests: netfilter: add simple masq/redirect test cases
      netfilter: nft_compat: don't use refcount_inc on newly allocated entr=
y

Gao Xiang (1):
      staging: erofs: keep corrupted fs from crashing kernel in erofs_namei=
()

Geert Uytterhoeven (3):
      arm64: dts: renesas: r8a774a1: Enable DMA for SCIF2
      arm64: dts: renesas: r8a7796: Enable DMA for SCIF2
      arm64: dts: renesas: r8a77965: Enable DMA for SCIF2

George Amanakis (1):
      tun: move the call to tun_set_real_num_queues

Govindarajulu Varadarajan (1):
      enic: fix checksum validation for IPv6

Greg Kroah-Hartman (8):
      debugfs: fix debugfs_rename parameter checking
      debugfs: return error values, not NULL
      debugfs: debugfs_lookup() should return NULL if not found
      Revert "staging: erofs: keep corrupted fs from crashing kernel
in erofs_namei()"
      relay: check return of create_buf_file() properly
      blk-mq: protect debugfs_create_files() from failures
      serial: fix race between flush_to_ldisc and tty_open
      sctp: walk the list of asoc safely

Guido G=C3=BCnther (1):
      dt-bindings: imx8mq: Number clocks consecutively

Gustavo A. R. Silva (4):
      usb: gadget: udc: net2272: Fix bitwise and boolean operations
      drm/amd/powerplay: Fix missing break in switch
      tty: serial: 8250_mtk: Fix potential NULL pointer dereference
      perf tests evsel-tp-sched: Fix bitwise operator

Guy Shattah (1):
      net/mlx5e: Use the inner headers to determine tc/pedit offload
limitation on decap flows

Hangbin Liu (2):
      geneve: should not call rt6_lookup() when ipv6 was disabled
      sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach(=
)

Hans Wippel (1):
      net/smc: allow 16 byte pnetids in netlink policy

Hans de Goede (2):
      iio: adc: axp288: Fix TS-pin handling
      libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1 SSD

Heiko Schocher (1):
      ARM: dts: am335x-shc.dts: fix wrong cd pin level

Heyi Guo (1):
      irqchip/gic-v4: Fix occasional VLPI drop

Huacai Chen (2):
      cacheinfo: Keep the old value if of_property_read_u32 fails
      MIPS: Loongson: Introduce and use loongson_llsc_mb()

Huang Rui (1):
      drm/amdgpu: fix the incorrect external id for raven series

Jacob Wen (2):
      l2tp: fix reading optional fields of L2TPv3
      l2tp: copy 4 more bytes to linear part if necessary

Jakub Kicinski (1):
      tools: bpftool: fix crash with un-owned prog arrays

Jakub Sitnicki (1):
      sk_msg: Always cancel strp work before freeing the psock

James Bottomley (1):
      scsi: aic94xx: fix module loading

Jan Kara (1):
      blktrace: Show requests without sector

Jann Horn (2):
      fuse: call pipe_buf_release() under pipe lock
      kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Jason Kridner (1):
      pinctrl: mcp23s08: spi: Fix regmap allocation for mcp23s18

Jay Cornwall (1):
      drm/amdgpu: Implement doorbell self-ring for NBIO 7.4

Jean-Philippe Brucker (1):
      arm64: kexec_file: handle empty command-line

Jeremy Soller (1):
      ALSA: hda/realtek - Headset microphone support for System76 darp5

Jernej Skrabec (2):
      ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
      arm64: dts: allwinner: a64: Fix USB OTG regulator

Jiri Olsa (2):
      bpftool: Fix prog dump by tag
      perf symbols: Filter out hidden symbols from labels

Johan Hovold (1):
      staging: speakup: fix tty-operation NULL derefs

Johannes Berg (5):
      Revert "socket: fix struct ifreq size in compat ioctl"
      Revert "kill dev_ifsioc()"
      net: socket: fix SIOCGIFNAME in compat
      net: socket: make bond ioctls go through compat_ifreq_ioctl()
      cfg80211: call disconnect_wk when AP stops

Jose Abreu (3):
      net: stmmac: Fallback to Platform Data clock in Watchdog conversion
      net: stmmac: Send TSO packets always from Queue 0
      net: stmmac: Disable EEE mode earlier in XMIT callback

Juergen Gross (1):
      x86/mm: Make set_pmd_at() paravirt aware

Julian Wiedmann (4):
      s390/qeth: release cmd buffer in error paths
      s390/qeth: fix use-after-free in error path
      s390/qeth: cancel close_dev work before removing a card
      s390/qeth: conclude all event processing before offlining a card

Jun-Ru Chang (1):
      MIPS: Remove function size check in get_frame_info()

Kailang Yang (1):
      ALSA: hda/realtek - Fix lose hp_pins for disable auto mute

Kan Liang (1):
      perf/x86/intel/uncore: Add Node ID mask

Karsten Graul (7):
      net/smc: prevent races between smc_lgr_terminate() and smc_conn_free(=
)
      net/smc: don't wait for send buffer space when data was already sent
      net/smc: recvmsg and splice_read should return 0 after shutdown
      net/smc: do not wait under send_lock
      net/smc: call smc_cdc_msg_send() under send_lock
      net/smc: use device link provided in qp_context
      net/smc: fix use of variable in cleared area

Keith Busch (2):
      nvme: lock NS list changes while handling command effects
      nvme-pci: fix rapid add remove sequence

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Do not corrupt EDX on EFER.LME=3D1 setting

Kyle Tso (1):
      usb: typec: tcpm: Correct the PPS out_volt calculation

Leonid Iziumtsev (1):
      dmaengine: imx-dma: fix wrong callback invoke

Linus Torvalds (1):
      Linux 5.0-rc6

Liu Bo (3):
      blk-iolatency: fix IO hang due to negative inflight counter
      Blk-iolatency: warn on negative inflight IO counter
      blk-mq: remove duplicated definition of blk_mq_freeze_queue

Lorenzo Bianconi (3):
      net: ip_gre: always reports o_key to userspace
      net: ip6_gre: always reports o_key to userspace
      mt76x0: eeprom: fix chan_vs_power map in mt76x0_get_power_info

Loys Ollivier (1):
      arm64: dts: meson: Fix mmc cd-gpios polarity

Lu Baolu (1):
      iommu/vt-d: Leave scalable mode default off

Lubomir Rintel (1):
      irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Luca Coelho (1):
      iwlwifi: make IWLWIFI depend on CFG80211

Lucas De Marchi (1):
      drm/i915: always return something on DDI clock selection

Lukas Bulwahn (1):
      MAINTAINERS: unify reference to xen-devel list

Lukas Wunner (2):
      dmaengine: bcm2835: Fix interrupt race on RT
      dmaengine: bcm2835: Fix abort of transactions

Madalin Bucur (1):
      soc: fsl: qbman: avoid race in clearing QMan interrupt

Manish Chopra (2):
      qed: Fix EQ full firmware assert.
      qed*: Advance drivers version to 8.37.0.20

Marc Gonzalez (1):
      ARM: tango: Improve ARCH_MULTIPLATFORM compatibility

Marc Zyngier (3):
      irqchip/gic-v3-its: Plug allocation race for devices sharing a DevID
      irqchip/gic-v3-its: Gracefully fail on LPI exhaustion
      net: dsa: Fix lockdep false positive splat

Mark Rutland (1):
      perf/core: Don't WARN() for impossible ring-buffer sizes

Martin Blumenstingl (3):
      ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO active-l=
ow
      ARM: dts: meson8b: ec100: mark the SD card detection GPIO active-low
      ARM: dts: meson8m2: mxiii-plus: mark the SD card detection GPIO activ=
e-low

Martin KaFai Lau (1):
      bpf: Fix syscall's stackmap lookup potential deadlock

Martin Kelly (1):
      tools: iio: iio_generic_buffer: make num_loops signed

Martin Kepplinger (1):
      mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Martynas Pumputis (2):
      bpf, selftests: fix handling of sparse CPU allocations
      netfilter: nf_nat: skip nat clash resolution for same-origin entries

Mathias Thore (1):
      ucc_geth: Reset BQL queue when stopping device

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsi=
us

Michael Chan (1):
      bnxt_en: Disable interrupts when allocating CP rings or NQs.

Michael S. Tsirkin (1):
      virtio: drop internal struct from UAPI

Mike Marshall (1):
      aio: initialize kiocb private in case any filesystems expect it.

Mike Snitzer (1):
      dm: don't use bio_trim() afterall

Miklos Szeredi (3):
      fuse: handle zero sized retrieve correctly
      cuse: fix ioctl
      fuse: decrement NR_WRITEBACK_TEMP on the right page

Mikulas Patocka (1):
      dm: add memory barrier before waitqueue_active

Naresh Kamboju (1):
      selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET

Nathan Chancellor (1):
      drm/amdkfd: Fix if preprocessor statement above
kfd_fill_iolink_info_for_cpu

Nicholas Kazlauskas (1):
      drm/amd/display: Attach VRR properties for eDP connectors

Nicolas Saenz Julienne (1):
      fpga: stratix10-soc: fix wrong of_node_put() in init function

Oliver O'Halloran (1):
      powerpc/papr_scm: Use the correct bind address

Or Gerlitz (1):
      net/mlx5e: Properly set steering match levels for offloaded TC decap =
rules

Pablo Neira Ayuso (1):
      netfilter: nf_tables: unbind set in rule from commit path

Paolo Abeni (1):
      bpftool: fix percpu maps updating

Paolo Bonzini (1):
      KVM: x86: work around leak of uninitialized stack contents (CVE-2019-=
7222)

Paul Burton (3):
      MIPS: VDSO: Use same -m%-float cflag as the kernel proper
      MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds
      MIPS: Use lower case for addresses in nexys4ddr.dts

Paul Cercueil (1):
      MIPS: DTS: jz4740: Correct interrupt number of DMA core

Paul Elder (1):
      usb: gadget: musb: fix short isoc packets with inventra dma

Paul Kocialkowski (2):
      arm64: dts: allwinner: a64: Fix the video engine compatible
      drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init

Peng Hao (1):
      ARM: pxa: ssp: unneeded to free devm_ allocated data

Peter Shier (1):
      KVM: nVMX: unconditionally cancel preemption timer in
free_nested (CVE-2019-7221)

Peter Zijlstra (2):
      perf/x86/intel: Delay memory deallocation until x86_pmu_dead_cpu()
      x86/mm/cpa: Fix set_mce_nospec()

Petr Machata (1):
      net: cls_flower: Remove filter from mask before freeing it

Philip Yang (1):
      drm/amdgpu: use spin_lock_irqsave to protect vm_manager.pasid_idr

Raed Salem (1):
      net/mlx5e: FPGA, fix Innova IPsec TX offload data path performance

Rahul Verma (1):
      qed: Change verbosity for coalescing message.

Randy Dunlap (1):
      mtd: rawnand: fix kernel-doc warnings

Ravi Bangoria (1):
      perf mem/c2c: Fix perf_mem_events to support powerpc

Roman Li (1):
      drm/amd/display: Fix fclk idle state

Ross Lagerwall (1):
      Revert "scsi: libfc: Add WARN_ON() when deleting rports"

Rundong Ge (1):
      net: dsa: slave: Don't propagate flag changes on down slave interface=
s

Russell King (3):
      ARM: iop32x/n2100: fix PCI IRQ mapping
      Revert "net: phy: marvell: avoid pause mode on SGMII-to-Copper
for 88e151x"
      MAINTAINERS: add maintainer for SFF/SFP/SFP+ support

Ryder Lee (1):
      pinctrl: mediatek: fix Kconfig build errors for moore core

Sandy Huang (1):
      drm/rockchip: rgb: update SPDX license identifier

Sebastian Andrzej Siewior (1):
      net: dp83640: expire old TX-skb

Shawn Guo (1):
      ARM: dts: vf610-bk4: fix incorrect #address-cells for dspi3

Siva Rebbagondla (1):
      MAINTAINERS: add entry for redpine wireless driver

Souptick Joarder (1):
      arch/arm/xen: Remove duplicate header

Srinivas Kandagatla (1):
      arm64: dts: add msm8996 compatible to gicv3

Stefano Garzarella (2):
      vsock/virtio: fix kernel panic after device hot-unplug
      vsock/virtio: reset connected sockets on device removal

Sudarsana Reddy Kalluru (3):
      qed: Assign UFP TC value to vlan priority in UFP mode.
      qed: Consider TX tcs while deriving the max num_queues for PF.
      qede: Fix system crash on configuring channels.

Sudeep Holla (2):
      ARM: dts: imx: replace gpio-key,wakeup with wakeup-source property
      firmware: arm_scmi: provide the mandatory device release callback

Sven Eckelmann (2):
      batman-adv: Avoid WARN on net_device without parent in netns
      batman-adv: Force mac header to start of data on xmit

Takashi Iwai (3):
      ALSA: hda/realtek - Use a common helper for hp pin reference
      ALSA: hda - Serialize codec registrations
      ALSA: hda/ca0132 - Fix build error without CONFIG_PCI

Tejas Joglekar (1):
      usb: dwc3: gadget: Handle 0 xfer length for OUT EP

Tetsuo Handa (1):
      fs: ratelimit __find_get_block_slow() failure message.

Thinh Nguyen (1):
      PCI: Work around Synopsys duplicate Device ID (HAPS USB3, NXP i.MX)

Thomas Gleixner (1):
      futex: Handle early deadlock return correctly

Thomas Hellstrom (4):
      drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user
      drm/vmwgfx: Fix an uninitialized fence handle value
      drm/vmwgfx: Fix setting of dma masks
      drm/vmwgfx: Improve on IOMMU detection

Tina Zhang (1):
      drm/modes: Prevent division by zero htotal

Tiwei Bie (1):
      virtio: support VIRTIO_F_ORDER_PLATFORM

Tomas Winkler (2):
      mei: me: add ice lake point device id.
      samples: mei: use /dev/mei0 instead of /dev/mei

Tomi Valkeinen (3):
      drm/omap: dsi: Fix crash in DSI debug dumps
      drm/omap: dsi: Fix OF platform depopulate
      drm/omap: dsi: Hack-fix DSI bus flags

Tonghao Zhang (2):
      net/mlx5e: Update hw flows when encap source mac changed
      net/mlx5e: Don't overwrite pedit action when multiple pedit used

Tony Jones (1):
      perf script python: Add Python3 support to tests/attr.py

Tony Lindgren (4):
      ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
      ARM: dts: Remove unnecessary idle flags for omap5 uart3
      ARM: dts: omap3-gta04: Fix graph_port warning
      i2c: omap: Use noirq system sleep pm ops to idle device for suspend

Tony Luck (1):
      x86/MCE: Initialize mce.bank in the case of a fatal error in
mce_no_way_out()

Toshiaki Makita (8):
      virtio_net: Don't enable NAPI when interface is down
      virtio_net: Don't call free_old_xmit_skbs for xdp_frames
      virtio_net: Fix not restoring real_num_rx_queues
      virtio_net: Fix out of bounds access of sq
      virtio_net: Don't process redirected XDP frames when XDP is disabled
      virtio_net: Use xdp_return_frame to free xdp_frames on destroying vqs
      virtio_net: Differentiate sk_buff and xdp_frame on freeing
      virtio_net: Account for tx bytes and packets on sending xdp_frames

Trond Myklebust (1):
      nfsd: Fix error return values for nfsd4_clone_file_range()

Udo Eberhardt (1):
      ALSA: usb-audio: Add support for new T+A USB DAC

Ulf Hansson (1):
      wlcore: sdio: Fixup power on/off sequence

Ursula Braun (5):
      net/smc: fix another sizeof to int comparison
      net/smc: preallocated memory for rdma work requests
      net/smc: fix sender_free computation
      net/smc: delete rkey first before switching to unused
      net/smc: correct state change for peer closing

Vaibhav Jain (1):
      scsi: cxlflash: Prevent deadlock when adapter probe fails

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Fix skl srckey mask bits
      drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BI=
OSen

Vincent Whitchurch (3):
      mic: vop: Fix broken virtqueues
      mic: vop: Fix use-after-free on remove
      mic: vop: Fix crash on remove

Vladimir Kondratiev (1):
      mips: cm: reprime error cause

Vladis Dronov (1):
      HID: debug: fix the ring buffer implementation

Will Deacon (1):
      arm64: ptdump: Don't iterate kernel page tables using PTRS_PER_PXX

Xin Long (1):
      sctp: check and update stream->out_curr when allocating stream_out

Yafang Shao (1):
      bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()

Yang Wei (10):
      net: defxx: replace dev_kfree_skb_irq by dev_consume_skb_irq for
drop profiles
      net: tulip: de2104x: replace dev_kfree_skb_irq by
dev_consume_skb_irq for drop profiles
      net: dscc4: replace dev_kfree_skb_irq by dev_consume_skb_irq for
drop profiles
      net: smsc: epic100: replace dev_kfree_skb_irq by
dev_consume_skb_irq for drop profiles
      net: fec_mpc52xx: replace dev_kfree_skb_irq by
dev_consume_skb_irq for drop profiles
      net: fsl_ucc_hdlc: replace dev_kfree_skb_irq by
dev_consume_skb_irq for drop profiles
      net: sun: replace dev_kfree_skb_irq by dev_consume_skb_irq for
drop profiles
      net: tehuti: replace dev_kfree_skb_irq by dev_consume_skb_irq
for drop profiles
      net: via-velocity: replace dev_kfree_skb_irq by
dev_consume_skb_irq for drop profiles
      net: broadcom: replace dev_kfree_skb_irq by dev_consume_skb_irq
for drop profiles

Yifeng Li (1):
      mips: loongson64: remove unreachable(), fix loongson_poweroff().

Yohei Kanemaru (1):
      ipv6: sr: clear IP6CB(skb) on SRH ip4ip6 encapsulation

Yonghong Song (2):
      bpf: btf: allow typedef func_proto
      tools/bpf: fix test_btf for typedef func_proto case

Zenghui Yu (1):
      irqchip/gic-v3-its: Fix ITT_entry_size accessor

Zhou Yanjie (1):
      DTS: CI20: Fix bugs in ci20's device tree.
