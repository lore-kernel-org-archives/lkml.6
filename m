Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A67C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BE120850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A9Hsej1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BE120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbeGVWVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:21:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50978 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbeGVWVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:21:54 -0400
Received: by mail-it0-f65.google.com with SMTP id w16-v6so21410141ita.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DoDv2eeKOMRB31mK8diUC7nMShooen8kmdnh5bddowg=;
        b=A9Hsej1ATFOa6iEOOdKYj2NkbGSNHAdjjrPY6uif3gkwgF1/Aov3ZdpjrekYqJydb0
         supmozLuKu8dAL//4ES/fCPW4fWTsFdPZub+LnzXksNWl+Wl5HkG7txXJQDzTIJgumPz
         udWE4XrfNCERdE9VZQUv0jKLOfJffVMY3Pg34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DoDv2eeKOMRB31mK8diUC7nMShooen8kmdnh5bddowg=;
        b=jlWizLClV3UWUxGDG/RC4l9LtSdAjLN3JHcEsT1vWDUbUJH9iAjN7SlR+3dlmQEAIq
         XUmLlP2t5mDOVLcre+CloEgm3cNrGjekwz2WJiw2PjmxIFByJSBsDrdSlEPBNJJP1RHd
         3jEPmJypTE6YIRhkdQJQk9H8QassyNY194PU3Y/PPfurOVoygMkYvrushD6XqRo8322n
         y9URb8N3QGZO8P5Wdx6AaZlanbKSU6qcEs7LpsHPBtd8oV5knzpaFVN3PjtkXaScElur
         nVZP1/r7/ZL7+WU3L8fTJpoHFNestpaO8Xj865Kbn+1L1UDH+KLRpjq82IW0IObTs+y8
         cz9g==
X-Gm-Message-State: AOUpUlGEKa1wuRDBK9knNdkDtBHpY93cbaIsl+U84G8QRHaGbQ8fS9iM
        DBCIU0bqOjfkIlM8AjGSV5YJQBBESF4oK4wbSmOzbA==
X-Google-Smtp-Source: AAOMgpf3mAkmzjoe2N+YDlGXi4Y8dU5b/x5/5ERu0vMN8F7jxD+1G7qbeVA1tZiapPTrl0iP5zLLCe2fpWQS+UnQwj0=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr8155191itm.113.1532294630888;
 Sun, 22 Jul 2018 14:23:50 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Jul 2018 14:23:39 -0700
Message-ID: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
Subject: Linux 4.18-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this was the week when the other shoe dropped ...  The reason the
two previous rc releases were so nice and small was that David hadn't
sent me much networking fixes, and they came in this week.

That said, it's not really a huge rc this week either, so it's all
good. But the networking pull this week does mean that almost exactly
half of the diff is core networking, network drivers, or networking
documentation updates.

The rest is other drivers (mostly gpu, but also scsi, nvma, pci,
pinctrl..), some arch updates (arc, x86, nds32, powerpc), and "misc"
(tooling, header files, some vm and fs noise).

The small but nasty VM bug we had earlier did indeed get fixed last
rc, but there was some 32-bit fallout from the fix, so rc5 still had
issues. But I'm hopeful that rc6 _really_ fixed all the cases.

Shortlog appended for people who want to just get an overview of the detail=
s,

             Linus

---

Al Viro (4):
      drm_mode_create_lease_ioctl(): fix open-coded filp_clone_open()
      cxl_getfile(): fix double-iput() on alloc_file() failures
      ocxlflash_getfile(): fix double-iput() on alloc_file() failures
      alpha: fix osf_wait4() breakage

Alex Deucher (3):
      Revert "drm/amd/display: Don't return ddc result and read_bytes
in same return value"
      drm/amdgpu/pp/smu7: use a local variable for toc indexing
      drm/amdgpu: add another ATPX quirk for TOPAZ

Alexander Couzens (1):
      net: usb: asix: replace mii_nway_restart in resume path

Alexander Duyck (1):
      ixgbe: Be more careful when modifying MAC filters

Alexander Sverdlin (2):
      octeon_mgmt: Fix MIX registers configuration on MTU setup
      net: cavium: Add fine-granular dependencies on PCI

Alexey Brodkin (4):
      ARC: Explicitly add -mmedium-calls to CFLAGS
      ARC: Enable machine_desc->init_per_cpu for !CONFIG_SMP
      ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs
      ARC: Fix CONFIG_SWAP

Alexey Kardashevskiy (2):
      vfio/spapr: Use IOMMU pageshift rather than pagesize
      KVM: PPC: Check if IOMMU page is contained in the pinned physical pag=
e

Anders Roxell (1):
      ARC: configs: remove no longer needed CONFIG_DEVPTS_MULTIPLE_INSTANCE=
S

Andrey Grodzovsky (1):
      drm/amdgpu: Verify root PD is mapped into kernel address space (v4)

Andrey Ryabinin (1):
      netfilter: nf_conntrack: Fix possible possible crash on module loadin=
g.

Anson Huang (1):
      soc: imx: gpc: restrict register range for regmap access

Arnd Bergmann (4):
      ieee802154: mcr20a: add missing includes
      net: bridge: fix br_vlan_get_{pvid,info} return values
      drm/sun4i: link in front-end code if needed
      ipv6: ila: select CONFIG_DST_CACHE

Arun Kumar Neelakantam (2):
      net: qrtr: Broadcast messages only from control port
      net: qrtr: Reset the node and port ID of broadcast messages

Ben Skeggs (2):
      drm/nouveau/kms/nv50-: ensure window updates are submitted when
flushing mst disables
      drm/nouveau/fb/gp100-: disable address remapper

Bert Kenward (2):
      sfc: avoid hang from nested use of the filter_sem
      sfc: hold filter_sem consistently during reset

Casey Leedom (1):
      cxgb4: assume flash part size to be 4MB, if it can't be determined

Christian K=C3=B6nig (1):
      drm/amd/display: fix invalid function table override

Christoph Hellwig (1):
      aio: don't expose __aio_sigset in uapi

Chuck Anderson (1):
      scsi: qla2xxx: Fix NULL pointer dereference for fcport search

Colin Ian King (2):
      ipv6: sr: fix useless rol32 call on hash
      ipv6: fix useless rol32 call on hash

Constantine Shulyupin (1):
      scripts/tags.sh: Add BPF_CALL

Corentin Labbe (2):
      net: stmmac: dwmac-sun8i: fix typo descrive =3D> describe
      net: ethernet: stmmac: fix documentation warning

C=C3=A9dric Le Goater (1):
      scsi: cxlflash: fix assignment of the backend operations

Damien Le Moal (1):
      scsi: sd_zbc: Fix variable type and bogus comment

Damien Th=C3=A9bault (1):
      platform/x86: dell-laptop: Fix backlight detection

Dan Carpenter (5):
      qed: off by one in qed_parse_mcp_trace_buf()
      ixgbe: Off by one in ixgbe_ipsec_tx()
      qlogic: check kstrtoul() for errors
      pinctrl: nsp: off by ones in nsp_pinmux_enable()
      drm/nouveau/gem: off by one bugs in nouveau_gem_pushbuf_reloc_apply()

Dan Williams (4):
      lib/iov_iter: Document _copy_to_iter_mcsafe()
      lib/iov_iter: Document _copy_to_iter_flushcache()
      lib/iov_iter: Fix pipe handling in _copy_to_iter_mcsafe()
      x86/asm/memcpy_mcsafe: Fix copy_to_user_mcsafe() exception handling

Daniel Borkmann (3):
      bpf: fix ldx in ld_abs rewrite for large offsets
      bpf: fix panic due to oob in bpf_prog_test_run_skb
      bpf: don't leave partial mangled prog in jit_subprogs error path

Dave Watson (1):
      tls: Stricter error checking in zerocopy sendmsg path

David Ahern (3):
      net/ipv6: Revert attempt to simplify route replace and append
      net/ipv4: Set oif in fib_compute_spec_dst
      net/ipv6: Do not allow device only routes via the multipath API

David Francis (1):
      amd/dc/dce100: On dce100, set clocks to 0 on suspend

David Lechner (1):
      net: usb: rtl8150: demote allmulti message to dev_dbg()

David Sterba (1):
      btrfs: restore uuid_mutex in btrfs_open_devices

Davide Caratti (2):
      net/sched: act_csum: fix NULL dereference when 'goto chain' is used
      net/sched: act_tunnel_key: fix NULL dereference when 'goto chain' is =
used

Davidlohr Bueso (1):
      lib/rhashtable: consider param->min_size when setting initial table s=
ize

Denis Bolotin (1):
      qed: Fix reading stale configuration information

Dewet Thibaut (1):
      x86/MCE: Remove min interval polling limitation

Dexuan Cui (1):
      PCI: hv: Disable/enable IRQs rather than BH in hv_compose_msi_msg()

Dmitry Osipenko (2):
      gpu: host1x: Skip IOMMU initialization if firewall is enabled
      gpu: host1x: Check whether size of unpin isn't 0

Don Brace (1):
      scsi: hpsa: correct enclosure sas address

Doron Roberts-Kedes (1):
      tls: fix skb_to_sgvec returning unhandled error.

Douglas Anderson (1):
      dt-bindings: soc: qcom: Fix default clock-freq for qcom,geni-i2c

Enric Balletbo i Serra (1):
      Documentation: devicetree: tilcdc: fix spelling mistake
"suppors" -> "supports"

Eric Biggers (1):
      KEYS: DNS: fix parsing multiple options

Eric Dumazet (1):
      tcp: cleanup copied_seq and urg_data in tcp_disconnect

Ewan D. Milne (1):
      qed: fix spelling mistake "successffuly" -> "successfully"

Fabio Estevam (1):
      dt-bindings: w1-gpio: Remove unneeded unit address

Filipe Manana (1):
      Btrfs: fix file data corruption after cloning a range and fsync

Florian Fainelli (1):
      net: systemport: Fix CRC forwarding check for SYSTEMPORT Lite

Florian Westphal (3):
      netfilter: x_tables: set module owner for icmp(6) matches
      netfilter: nft_compat: explicitly reject ERROR and standard target
      netfilter: ipv6: nf_defrag: drop skb dst before queueing

Frank Rowand (1):
      of: overlay: update phandle cache on overlay apply and remove

Ganapathi Bhat (2):
      Revert "mwifiex: handle race during mwifiex_usb_disconnect"
      mwifiex: handle race during mwifiex_usb_disconnect

Gautham R. Shenoy (1):
      powerpc/powernv: Fix save/restore of SPRG3 on entry/exit from stop (i=
dle)

Geert Uytterhoeven (1):
      wcn36xx: Remove Unicode Byte Order Mark from testcode

Greentime Hu (4):
      nds32: To implement these icache invalidation APIs since nds32
cores don't snoop data cache. This issue is found by Guo Ren. Based on
the Documentation/core-api/cachetlb.rst and it says:
      nds32: Fix the dts pointer is not passed correctly issue.
      nds32: To simplify the implementation of update_mmu_cache()
      nds32: fix build error "relocation truncated to fit:
R_NDS32_25_PCREL_RELA" when make allyesconfig

Guenter Roeck (1):
      nds32: Fix build error caused by configuration flag rename

Gustavo A. R. Silva (5):
      qtnfmac: fix NULL pointer dereference
      char: amd64-agp: Use 64-bit arithmetic instead of 32-bit
      vfio/pci: Fix potential Spectre v1
      net: cxgb3_main: fix potential Spectre v1
      ptp: fix missing break in switch

Gustavo Pimentel (2):
      ARC: [plat-hsdk] Add PCIe support
      ARC: [plat-hsdk]: Configure APB GPIO controller on ARC HSDK platform

Haiyang Zhang (1):
      hv_netvsc: Fix napi reschedule while receive completion is busy

Hang Yuan (1):
      drm/i915/gvt: update vreg on inhibit context lri command

Hangbin Liu (2):
      ipv4/igmp: init group mode as INCLUDE when join source group
      ipv6/mcast: init as INCLUDE when join SSM INCLUDE group

Harini Katakam (2):
      net: macb: Free RX ring for all queues
      net: macb: Allocate valid memory for TX and RX BD prefetch

Harry Wentland (1):
      drm/amd/display: Convert 10kHz clks from PPLib into kHz for Vega

Heiner Kallweit (2):
      r8169: fix mac address change
      net: phy: fix flag masking in __set_phy_supported

Hersen Wu (1):
      drm/amd/display: Fix DP HBR2 Eye Diagram Pattern on Carrizo

Hugh Dickins (2):
      x86/events/intel/ds: Fix bts_interrupt_threshold alignment
      mm/huge_memory.c: fix data loss when splitting a file pmd

Igor Russkikh (1):
      net: aquantia: vlan unicast address list correct handling

Isaac J. Manjarres (1):
      stop_machine: Disable preemption when waking two stopper threads

Jacob Keller (1):
      sch_fq_codel: zero q->flows_cnt when fq_codel_init fails

James Clarke (1):
      powerpc/Makefile: Assemble with -me500 when building for E500

Janakarajan Natarajan (1):
      x86/kvm/Kconfig: Ensure CRYPTO_DEV_CCP_DD state at minimum matches KV=
M_AMD

Jim Mattson (1):
      kvm: nVMX: Restore exit qual for VM-entry failure due to MSR loading

Jing Xia (1):
      mm: memcg: fix use after free in mem_cgroup_iter()

John Allen (1):
      ibmvnic: Fix error recovery on login failure

John Fastabend (6):
      bpf: sockmap, error path can not release psock in multi-map case
      bpf: sockmap, hash table is RCU so readers do not need locks
      bpf: fix sk_skb programs without skb->dev assigned
      bpf: sockhash, disallow bpf_tcp_close and update in parallel
      bpf: sockmap, consume_skb in close path
      bpf: sockmap, convert bpf_compute_data_pointers to bpf_*_sk_skb

Jon Maloy (4):
      tipc: fix wrong return value from function tipc_node_try_addr()
      tipc: correct discovery message handling during address trial period
      tipc: fix correct setting of message type in second discoverer
      tipc: make function tipc_net_finalize() thread safe

Jonathan Neusch=C3=A4fer (1):
      dt-bindings: Fix unbalanced quotation marks

Juri Lelli (1):
      sched/deadline: Fix switched_from_dl() warning

Karsten Graul (1):
      net/smc: reset recv timeout after clc handshake

Keith Busch (1):
      nvme-pci: fix memory leak on probe failure

Kishon Vijay Abraham I (1):
      PCI: endpoint: Fix NULL pointer dereference error when CONFIGFS
is disabled

Krzysztof Kozlowski (1):
      MAINTAINERS: Drop inactive Vitaly Bordug's email

Lan Tianyu (1):
      KVM/Eventfd: Avoid crash when assign and deassign specific
eventfd in parallel.

Leo Liu (1):
      drm/amdgpu: Make sure IB tests flushed after IP resume

Linus L=C3=BCssing (2):
      batman-adv: Avoid storing non-TT-sync flags on singular entries too
      batman-adv: Fix multicast TT issues with bogus ROAM flags

Linus Torvalds (5):
      Mark HI and TASKLET softirq synchronous
      mm: use helper functions for allocating and freeing vm_area structs
      mm: make vm_area_dup() actually copy the old vma data
      mm: make vm_area_alloc() initialize core fields
      Linux 4.18-rc6

Liran Alon (1):
      KVM: VMX: Mark VMXArea with revision_id of physical CPU even
when eVMCS enabled

Lorenzo Colitti (1):
      net: diag: Don't double-free TCP_NEW_SYN_RECV sockets in tcp_abort

Lu Baolu (1):
      Revert "iommu/vt-d: Clean up pasid quirk for pre-production devices"

Lubomir Rintel (1):
      ieee802154: 6lowpan: set IFLA_LINK

Luc Van Oostenryck (1):
      nds32: define __NDS32_E[BL]__ for sparse

Lyude Paul (5):
      drm/nouveau: Use drm_connector_list_iter_* for iterating connectors
      drm/nouveau: Avoid looping through fake MST connectors
      drm/nouveau/drm/nouveau: Fix runtime PM leak in nv50_disp_atomic_comm=
it()
      drm/nouveau: Remove bogus crtc check in pmops_runtime_idle
      drm/nouveau: Set DRIVER_ATOMIC cap earlier to fix debugfs

Magnus Karlsson (8):
      xsk: fix potential lost completion message in SKB path
      xsk: frame could be completed more than once in SKB path
      samples/bpf: deal with EBUSY return code from sendmsg in xdpsock samp=
le
      xsk: fix potential race in SKB TX completion code
      xsk: do not return ENXIO from TX copy mode
      xsk: do not return EAGAIN from sendmsg when completion queue is full
      xsk: always return ENOBUFS from sendmsg if there is no TX queue
      xsk: do not return EMSGSIZE in copy mode for packets larger than MTU

Manish Rangankar (1):
      scsi: qedi: Send driver state to MFW

Masanari Iida (1):
      bonding: Fix a typo in bonding.txt

Matevz Vucnik (1):
      qmi_wwan: add support for Quectel EG91

Mathieu Malaterre (1):
      mm/memblock: add missing include <linux/bootmem.h>

Mathieu Xhonneux (1):
      bpf: fix availability probing for seg6 helpers

Mauricio Vasquez B (1):
      bpf: hash map: decrement counter on error

Mauro Carvalho Chehab (2):
      networking: e100.rst: Get rid of Sphinx warnings
      networking: e1000.rst: Get rid of Sphinx warnings

Michael Chan (4):
      bnxt_en: Fix inconsistent BNXT_FLAG_AGG_RINGS logic.
      bnxt_en: Always set output parameters in bnxt_get_max_rings().
      bnxt_en: Support clearing of the IFF_BROADCAST flag.
      bnxt_en: Do not modify max IRQ count after RDMA driver
requests/frees IRQs.

Michael Ellerman (1):
      powerpc/xmon: Fix disassembly since printf changes

Michael Heimpold (1):
      net: ethtool: fix spelling mistake: "tubale" -> "tunable"

Michael Hennerich (2):
      net: ieee802154: adf7242: Fix erroneous RX enable
      net: ieee802154: adf7242: Fix OCL calibration runs

Michael Trimarchi (1):
      brcmfmac: stop watchdog before detach and free everything

Michel D=C3=A4nzer (1):
      drm/amdgpu: Reserve VM root shared fence slot for command submission =
(v3)

Mikko Perttunen (1):
      drm/tegra: Fix comparison operator for buffer size

Mikulas Patocka (1):
      dm writecache: support optional offset for start of device

M=C3=A1t=C3=A9 Eckl (1):
      netfilter: nf_tproxy: fix possible non-linear access to transport hea=
der

Naohiro Aota (1):
      btrfs: fix use-after-free of cmp workspace pages

Nicholas Mc Guire (1):
      liquidio: make timeout HZ independent and readable

Niklas S=C3=B6derlund (1):
      pinctrl: sh-pfc: r8a77970: remove SH_PFC_PIN_CFG_DRIVE_STRENGTH flag

OGAWA Hirofumi (1):
      fat: fix memory allocation failure handling of match_strdup()

Okash Khawaja (1):
      bpf: btf: Fix bitfield extraction for big endian

Pablo Neira Ayuso (1):
      netfilter: nf_tables: place all set backends in one single module

Paolo Abeni (1):
      ipfrag: really prevent allocation on netns exit

Paolo Bonzini (2):
      KVM: VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR
      KVM: irqfd: fix race between EPOLLHUP and irq_bypass_register_consume=
r

Paul Cercueil (1):
      pinctrl: ingenic: Fix inverted direction for < JZ4770

Paul Moore (1):
      ipv6: make ipv6_renew_options() interrupt/kernel safe

Pavel Machek (1):
      ARM: dts: omap4-droid4: fix dts w.r.t. pwm

Pavel Tatashin (1):
      mm: don't do zero_resv_unavail if memmap is not allocated

Peng Hao (1):
      kvmclock: fix TSC calibration for nested guests

Peter Senna Tschudin (1):
      MAINTAINERS: Peter has moved

Peter Zijlstra (1):
      ARC: Improve cmpxchg syscall implementation

Ping-Ke Shih (2):
      rtlwifi: Fix kernel Oops "Fw download fail!!"
      rtlwifi: rtl8821ae: fix firmware is not ready to run

Po-Hsu Lin (1):
      ALSA: hda: add mute led support for HP ProBook 455 G5

Prashant Bhole (1):
      net: ip6_gre: get ipv6hdr after skb_cow_head()

Qu Wenruo (1):
      btrfs: scrub: Don't use inode page cache in scrub_handle_errored_bloc=
k()

Quinn Tran (1):
      scsi: qla2xxx: Fix inconsistent DMA mem alloc/free

Radim Kr=C4=8Dm=C3=A1=C5=99 (1):
      x86/kvmclock: set pvti_cpu0_va after enabling kvmclock

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Register when ACPI PCCH is present

Randy Dunlap (2):
      net/ethernet/freescale/fman: fix cross-build error
      tcp: identify cryptic messages as TCP seq # bugs

Rishabh Bhatnagar (1):
      lib: rhashtable: Correct self-assignment in rhashtable.c

Robin H. Johnson (1):
      ACPI / EC: Use ec_no_wakeup on more Thinkpad X1 Carbon 6th systems

Roland Dreier (1):
      nvme: fix handling of metadata_len for NVME_IOCTL_IO_CMD

Roman Gushchin (1):
      bpf: include errno.h from bpf-cgroup.h

Russell King (4):
      drm/armada: fix colorkey mode property
      drm/armada: fix irq handling
      sfp: ensure we clean up properly on bus registration failure
      sfp: fix module initialisation with netdev already up

Ryan Hsu (1):
      ath10k: update the phymode along with bandwidth change request

Sabrina Dubroca (1):
      ipv6: make DAD fail with enhanced DAD when nonce length differs

Saeed Mahameed (1):
      net/mlx4_en: Don't reuse RX page when XDP is set

Sanjeev Bansal (1):
      tg3: Add higher cpu clock for 5762.

Saurav Kashyap (1):
      scsi: qedf: Send the driver state to MFW

Scott Bauer (1):
      nvme: ensure forward progress during Admin passthru

Sean Wang (5):
      pinctrl: mt7622: fix error path on failing at groups building
      pinctrl: mt7622: fix initialization sequence between eint and gpiochi=
p
      pinctrl: mt7622: fix that pinctrl_claim_hogs cannot work
      pinctrl: mt7622: stop using the deprecated pinctrl_add_gpio_range
      pinctrl: mt7622: fix a kernel panic when gpio-hog is being applied

Sergei Shtylyov (8):
      PCI: OF: Fix I/O space page leak
      PCI: xgene: Fix I/O space page leak
      PCI: versatile: Fix I/O space page leak
      PCI: designware: Fix I/O space page leak
      PCI: aardvark: Fix I/O space page leak
      PCI: faraday: Fix I/O space page leak
      PCI: mediatek: Fix I/O space page leak
      PCI: v3-semi: Fix I/O space page leak

Simon Ser (1):
      objtool: Use '.strtab' if '.shstrtab' doesn't exist, to support
ORC tables on Clang

Siva Reddy Kallam (1):
      tg3: Update copyright

Souptick Joarder (1):
      char: agp: Change return type to vm_fault_t

Stanislaw Gruszka (1):
      mt7601u: remove warning when avg_rssi is zero

Stefan Baranoff (3):
      tcp: fix sequence numbers for repaired sockets re-using TIME-WAIT soc=
kets
      tcp: allow user to create repair socket without window probes
      tcp: Fix broken repair socket window probe patch

Stefan Schmidt (4):
      MAINTAINERS: update my email address
      ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem
      ieee802154: at86rf230: use __func__ macro for debug messages
      ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem

Stefan Wahren (4):
      net: lan78xx: Fix race in tx pending skb size calculation
      net: qca_spi: Avoid packet drop during initial sync
      net: qca_spi: Make sure the QCA7000 reset is triggered
      net: qca_spi: Fix log level if probe fails

Stefano Brivio (2):
      net: Don't copy pfmemalloc flag in __copy_skb_header()
      skbuff: Unconditionally copy pfmemalloc in __skb_clone()

Stephan Mueller (1):
      crypto: af_alg - Initialize sg_num_bytes in error code path

Stephen Hemminger (1):
      hv/netvsc: fix handling of fallback to single queue mode

Sven Eckelmann (4):
      batman-adv: Fix bat_ogm_iv best gw refcnt after netlink dump
      batman-adv: Fix bat_v best gw refcnt after netlink dump
      batman-adv: Fix debugfs path for renamed hardif
      batman-adv: Fix debugfs path for renamed softif

Taehee Yoo (1):
      rhashtable: add restart routine in rhashtable_free_and_destroy()

Taeung Song (5):
      samples/bpf: add missing <linux/if_vlan.h>
      samples/bpf: Check the result of system()
      samples/bpf: Check the error of write() and read()
      samples/bpf: add .gitignore file
      samples/bpf: Fix tc and ip paths in xdp2skb_meta.sh

Takashi Iwai (2):
      ALSA: rawmidi: Change resized buffers atomically
      ALSA: hda/realtek - Yet another Clevo P950 quirk entry

Tetsuo Handa (1):
      net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Thomas Falcon (1):
      ibmvnic: Revise RX/TX queue error messages

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      gen_stats: Fix netlink stats dumping in the presence of padding

Toshiaki Makita (2):
      xdp: XDP_REDIRECT should check IFF_UP and MTU
      tun: Fix use-after-free on XDP_TX

Tyler Hicks (1):
      ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user =
ns

Ursula Braun (4):
      net/smc: reduce sock_put() for fallback sockets
      net/smc: take sock lock in smc_ioctl()
      net/smc: optimize consumer cursor updates
      net/smc: add error handling for get_user()

Uwe Kleine-K=C3=B6nig (1):
      ARM: dts: imx6: RDU2: fix irq type for mv88e6xxx switch

Venkat Duvvuru (1):
      bnxt_en: Fix the vlan_tci exact match check.

Vijendar Mukunda (1):
      drm/amd/amdgpu: creating two I2S instances for stoney/cz (v2)

Vikas Gupta (1):
      bnxt_en: Fix for system hang if request_irq fails

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Fix hotplug irq ack on i965/g4x
      x86/apm: Don't access __preempt_count with zeroed fs

Vineet Gupta (3):
      ARC: [arcompact] entry.S: minor code movement
      ARC: mm: allow mprotect to make stack mappings executable
      ARCv2: [plat-hsdk]: Save accl reg pair by default

Vitaly Kuznetsov (1):
      x86/kvm/vmx: don't read current->thread.{fs,gs}base of legacy tasks

Vladimir Zapolskiy (14):
      sh_eth: fix invalid context bug while calling auto-negotiation by eth=
tool
      sh_eth: fix invalid context bug while changing link options by ethtoo=
l
      sh_eth: simplify link auto-negotiation by ethtool
      sh_eth: remove custom .nway_reset from ethtool ops
      sh_eth: remove useless serialization in sh_eth_get_link_ksettings()
      sh_eth: remove custom .get_link_ksettings from ethtool ops
      sh_eth: remove custom .set_link_ksettings from ethtool ops
      ravb: fix invalid context bug while calling auto-negotiation by ethto=
ol
      ravb: fix invalid context bug while changing link options by ethtool
      ravb: simplify link auto-negotiation by ethtool
      ravb: remove custom .nway_reset from ethtool ops
      ravb: remove useless serialization in ravb_get_link_ksettings()
      ravb: remove custom .get_link_ksettings from ethtool ops
      ravb: remove custom .set_link_ksettings from ethtool ops

Wang Dongsheng (1):
      net: phy: marvell: change default m88e1510 LED configuration

Wei Yongjun (1):
      pinctrl: nsp: Fix potential NULL dereference

Weiping Zhang (1):
      nvme: don't enable AEN if not supported

Willem de Bruijn (3):
      nsh: set mac len based on inner packet
      packet: reset network header if packet shorter than ll reserved space
      selftests: in udpgso_bench do not test udp zerocopy

Xin Long (1):
      sctp: fix the issue that pathmtu may be set lower than MINSEGMENT

Xinming Hu (1):
      MAINTAINERS: update Xinming's email address

YOKOTA Hiroshi (1):
      ALSA: hda/realtek - Add Panasonic CF-SZ6 headset jack quirk

Yuchung Cheng (2):
      tcp: fix dctcp delayed ACK schedule
      tcp: remove DELAYED ACK events in DCTCP

YueHaibing (1):
      net: sched: Using NULL instead of plain integer

Yuiko Oshino (1):
      smsc75xx: Add workaround for gigabit link up hardware errata.

himanshu.madhani@cavium.com (1):
      scsi: qla2xxx: Fix kernel crash due to late workqueue allocation
