Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309E9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB96217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 00:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AB6XzMgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbeLXAVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 19:21:52 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:42153 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLXAVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 19:21:51 -0500
Received: by mail-lf1-f50.google.com with SMTP id l10so7368610lfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 16:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Exq60r8i9FUHDNIM/ua2dgCYi5bSTGQhV3A7Y1N/bUU=;
        b=AB6XzMgZfODanwoypF0oVQpjM2husHTGNEGB5susuWo4bRj4m06cdpo0AYf5FCr762
         1LT7Dm1nz/pdeM57Fkp3KROssgWUn+6TY8dDhbriKzcD3lsBdJPmm0kFuMG6VMhHetw/
         xH52y63sUd1KPCJfaJQFeE9XHqbIUg3vzI7d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Exq60r8i9FUHDNIM/ua2dgCYi5bSTGQhV3A7Y1N/bUU=;
        b=ZUqjX6cCdzn//MRaw1sjKtF/FLjvv8+6M+47e4v+7YjqTCUpG9CK/Kd7rhvF97sYBe
         KJVCGinM/j7BdxIBgiieHgqVKYby+MOFGtNlqOjISM0tkCR2NRQT8RcSapMcayAjStI/
         NRWe1yNUowC9Yu8NEkP9oUrT0a8eAnhwue2d1IwZzdrzjw1DRIwPPtR+BpYK55KJqIrT
         mih1jNTB3kEJJwKfUT4hpCbGrFleu5TZMnSiaw2lXmflqo4K5GwWEo60/sNzadz6BZGJ
         SIqieDUevluadPIqOxvgers/rrT8YWL315nOoF8AOoIdsukawGiSjz7S0drXHZiB7k81
         JRXg==
X-Gm-Message-State: AA+aEWZV+Epz6ryFQJ9rx1+2Espw4dcnhI6ceb0Oex7VIGyxVmBDr3Nd
        ZZOkPjV478JSMUzH2rvwNbet3EQ+HHE=
X-Google-Smtp-Source: AFSGD/WfYARWSiZ8fVhRlc3n+zHe1ks+5DpNg/xzRgVbC6MWjRtNvlkasXw44pefymRa7ijlCRGVFg==
X-Received: by 2002:a19:ca51:: with SMTP id h17mr5175445lfj.126.1545610907091;
        Sun, 23 Dec 2018 16:21:47 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x24-v6sm6769006ljc.54.2018.12.23.16.21.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 16:21:46 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id x85-v6so9262172ljb.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 16:21:45 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr5994685lja.148.1545610905422;
 Sun, 23 Dec 2018 16:21:45 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Dec 2018 16:21:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0zF4wa87Q5rAhFe2es0t0eExX2UjvKD7-Pghvcbt5Vw@mail.gmail.com>
Message-ID: <CAHk-=wg0zF4wa87Q5rAhFe2es0t0eExX2UjvKD7-Pghvcbt5Vw@mail.gmail.com>
Subject: Linux 4.20 released..
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's face it, last week wasn't quite as quiet as I would have hoped
for, but there really doesn't seem to be any point to delay 4.20
because everybody is already taking a break.

And it's not like there are any known issues, it's just that the
shortlog below is a bit longer than I would have wished for. Nothing
screams "oh, that's scary", though.

And as part of the "everybody is already taking a break", I can
happily report that I already have quite a few early pull requests in
my inbox. I encouraged people to get it over and done with, so that
people can just relax over the year-end holidays.  In fact, I probably
won't start pulling for a couple of days, but otherwise let's just try
to keep to the normal merge window schedule, even if most people
hopefully won't even be back until over the merge window is over.

As to the details of this last week of 4.20 - most of it is networking
(drivers, core networking fixes, bpf). There's a few other non-network
driver updates too, and a revert series of some of the x86 inline asm
changes that were obviated by upcoming compiler support.

Details below.

Have a Merry Christmas or other holiday of your choice.

                  Linus

---

Alaa Hleihel (1):
      net/mlx5e: Remove the false indication of software timestamping suppo=
rt

Alexander Aring (1):
      ieee802154: hwsim: fix off-by-one in parse nested

Alistair Strachan (1):
      x86/vdso: Pass --eh-frame-hdr to the linker

Allan W. Nielsen (1):
      mscc: Configured MAC entries should be locked.

Anssi Hannula (3):
      net: macb: fix random memory corruption on RX with 64-bit DMA
      net: macb: fix dropped RX frames due to a race
      net: macb: add missing barriers when reading descriptors

Antoine Tenart (2):
      net: mvpp2: 10G modes aren't supported on all ports
      net: mvpp2: fix the phylink mode validation

Arnd Bergmann (4):
      i2c: nvidia-gpu: mark resume function as __maybe_unused
      ubifs: replay: Fix high stack usage
      ubifs: auth: Add CONFIG_KEYS dependency
      w90p910_ether: remove incorrect __init annotation

Atul Gupta (5):
      net/tls: Init routines in create_ctx
      net/tls: sleeping function from invalid context
      crypto/chelsio/chtls: listen fails with multiadapt
      crypto/chelsio/chtls: macro correction in tx path
      crypto/chelsio/chtls: send/recv window update

Benjamin Poirier (1):
      xfrm: Fix bucket count reported to userspace

Benjamin Tissoires (1):
      Input: elantech - disable elan-i2c for P52 and P72

Brian Norris (1):
      Revert "mwifiex: restructure rx_reorder_tbl_lock usage"

Bryan Whitehead (2):
      lan743x: Expand phy search for LAN7431
      lan743x: Remove MAC Reset from initialization

Cfir Cohen (1):
      KVM: Fix UAF in nested posted interrupt processing

Chang S. Bae (1):
      x86/fsgsbase/64: Fix the base write helper functions

Christian Brauner (1):
      Revert "vfs: Allow userns root to call mknod on owned filesystems."

Christoph Hellwig (1):
      dma-mapping: fix flags in dma_alloc_wc

Christophe Leroy (1):
      gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Claudiu Beznea (1):
      net: macb: restart tx after tx used bit read

Colin Ian King (2):
      x86/mtrr: Don't copy uninitialized gentry fields back to userspace
      vxge: ensure data0 is initialized in when fetching firmware
version information

Cong Wang (6):
      tipc: use lock_sock() in tipc_sk_reinit()
      tipc: fix a double kfree_skb()
      tipc: compare remote and local protocols in tipc_udp_enable()
      tipc: check tsk->group in tipc_wait_for_cond()
      tipc: check group dests after tipc_wait_for_cond()
      ipv6: explicitly initialize udp6_addr in udp_sock_create6()

Corentin Labbe (1):
      sparc: Set "ARCH: sunxx" information on the same line

Dan Carpenter (3):
      scsi: bnx2fc: Fix NULL dereference in error handling
      qed: Fix an error code qed_ll2_start_xmit()
      net: stmmac: Fix an error code in probe()

Dan Williams (1):
      x86/mm: Fix decoy address handling vs 32-bit builds

Daniel Borkmann (1):
      bpf: fix bpf_jit_limit knob for PAGE_SIZE >=3D 64K

Daniele Palmas (1):
      qmi_wwan: Fix qmap header retrieval in qmimux_rx_fixup

Dave Chinner (1):
      iomap: Revert "fs/iomap.c: get/put the page in
iomap_page_create/release()"

Dave Taht (1):
      net: Allow class-e address assignment via ifconfig ioctl

David Ahern (1):
      neighbor: NTF_PROXY is a valid ndm_flag for a dump request

David S. Miller (1):
      rds: Fix warning.

Davide Caratti (1):
      net: Use __kernel_clockid_t in uapi net_stamp.h

Dexuan Cui (1):
      Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened cha=
nnels

Dmitry V. Levin (1):
      uapi: linux/blkzoned.h: fix BLKGETZONESZ and BLKGETNRZONES definition=
s

Eduardo Habkost (1):
      kvm: x86: Add AMD's EX_CFG to the list of ignored MSRs

Emmanuel Grumbach (1):
      iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT to old firmwares

Eric Biggers (1):
      KVM: fix unregistering coalesced mmio zone from wrong bus

Eric Dumazet (3):
      net: clear skb->tstamp in forwarding paths
      tcp: fix a race in inet_diag_dump_icsk()
      ipv6: tunnels: fix two use-after-free

Florian Westphal (2):
      netfilter: seqadj: re-load tcp header pointer after possible
head reallocation
      netfilter: nat: can't use dst_hold on noref dst

Gabor Juhos (1):
      ubifs: Fix default compression selection in ubifs

Ganesh Goudar (2):
      net/tls: allocate tls context using GFP_ATOMIC
      MAINTAINERS: update cxgb4 and cxgb3 maintainer

Garry McNulty (1):
      ubifs: Fix memory leak on error condition

Gavi Teitz (1):
      net/mlx5e: Fix default amount of channels for VF representors

Geert Uytterhoeven (2):
      ubifs: CONFIG_UBIFS_FS_AUTHENTICATION should depend on UBIFS_FS
      m68k: Fix memblock-related crashes

Gustavo A. R. Silva (3):
      ipv4: Fix potential Spectre v1 vulnerability
      ip6mr: Fix potential Spectre v1 vulnerability
      drm/ioctl: Fix Spectre v1 vulnerabilities

Hans de Goede (1):
      gpiolib-acpi: Only defer request_irq for GpioInt ACPI event handlers

Heiner Kallweit (1):
      r8169: fix crash if CONFIG_DEBUG_SHIRQ is enabled

Herbert Xu (1):
      ipv6: frags: Fix bogus skb->sk in reassembled packets

Himanshu Madhani (1):
      Revert "scsi: qla2xxx: Fix NVMe Target discovery"

Hui Peng (1):
      USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data

Ido Schimmel (2):
      mlxsw: spectrum: Add trap for decapsulated ARP packets
      mlxsw: spectrum_nve: Fix memory leak upon driver reload

Ingo Molnar (9):
      Revert "x86/jump-labels: Macrofy inline assembly code to work
around GCC inlining bugs"
      Revert "x86/cpufeature: Macrofy inline assembly code to work
around GCC inlining bugs"
      Revert "x86/extable: Macrofy inline assembly code to work around
GCC inlining bugs"
      Revert "x86/paravirt: Work around GCC inlining bugs when
compiling paravirt ops"
      Revert "x86/bug: Macrofy the BUG table section handling, to work
around GCC inlining bugs"
      Revert "x86/alternatives: Macrofy lock prefixes to work around
GCC inlining bugs"
      Revert "x86/refcount: Work around GCC inlining bug"
      Revert "x86/objtool: Use asm macros to work around GCC inlining bugs"
      Revert "kbuild/Makefile: Prepare for using macros in inline
assembly code to work around asm() related GCC inlining bugs"

Ivan Delalande (1):
      proc/sysctl: don't return ENOMEM on lookup when a table is unregister=
ing

Jakub Kicinski (2):
      bpf: verifier: make sure callees don't prune with caller differences
      net: netlink: rename NETLINK_DUMP_STRICT_CHK -> NETLINK_GET_STRICT_CH=
K

Jason Martinsen (1):
      lan78xx: Resolve issue with changing MAC address

Jason Wang (3):
      vhost: make sure used idx is seen before log in vhost_add_used_n()
      vhost_net: switch to use mutex_trylock() in vhost_net_busy_poll()
      Revert "net: vhost: lock the vqs one by one"

Jeff Moyer (1):
      aio: fix spectre gadget in lookup_ioctx

Jens Axboe (1):
      scsi: sd: use mempool for discard special page

Johannes Berg (1):
      nl80211: fix memory leak if validate_pae_over_nl80211() fails

Jorgen Hansen (1):
      VSOCK: Send reset control packet when socket is partially bound

Juergen Gross (1):
      xen/netfront: tolerate frags with no data

J=C3=B6rgen Storvist (7):
      USB: serial: option: add GosunCn ZTE WeLink ME3630
      USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)
      USB: serial: option: add Fibocom NL668 series
      USB: serial: option: add Telit LN940 series
      qmi_wwan: Added support for Fibocom NL668 series
      qmi_wwan: Added support for Telit LN940 series
      qmi_wwan: Add support for Fibocom NL678 series

Kangjie Lu (1):
      net: netxen: fix a missing check and an uninitialized use

Kirill A. Shutemov (2):
      x86/mm: Fix guard hole handling
      x86/dump_pagetables: Fix LDT remap address marker

Krzysztof Adamski (1):
      MAINTAINERS: add entry for i2c-axxia driver

Kunihiko Hayashi (1):
      net: phy: Fix the issue that netif always links up after resuming

Larry Finger (1):
      rtlwifi: Fix leak of skb when processing C2H_BT_INFO

Lendacky, Thomas (1):
      dma-direct: do not include SME mask in the DMA supported check

Lepton Wu (1):
      VSOCK: bind to random port for VMADDR_PORT_ANY

Linus Torvalds (2):
      security: don't use a negative Opt_err token index
      Linux 4.20

Lorenzo Bianconi (3):
      mt76: fix potential NULL pointer dereference in mt76_stop_tx_queues
      mt76: add entry in MAINTAINERS file
      gro_cell: add napi_disable in gro_cells_destroy

Mans Rullgard (1):
      auxdisplay: charlcd: fix x/y command parsing

Mantas Mikul=C4=97nas (1):
      Input: synaptics - enable SMBus for HP EliteBook 840 G4

Marcin Wojtas (1):
      net: mvneta: fix operation for 64K PAGE_SIZE

Mario Limonciello (1):
      r8152: Add support for MAC address pass through on RTL8153-BND

Martin K. Petersen (1):
      scsi: t10-pi: Return correct ref tag when queue has no integrity prof=
ile

Masahiro Yamada (2):
      bpf: promote bpf_perf_event.h to mandatory UAPI header
      kbuild: fix false positive warning/error about missing libelf

Mathias Krause (1):
      xfrm_user: fix freeing of xfrm states on acquire

Mathias Nyman (1):
      xhci: Don't prevent USB2 bus suspend in state check intended for USB3=
 only

Michael Chan (1):
      bnxt_en: Fix ethtool self-test loopback.

Michael S. Tsirkin (1):
      virtio: fix test build after uio.h change

Michal Kubecek (1):
      net: ipv4: do not handle duplicate fragments as overlapping

Micha=C5=82 Miros=C5=82aw (2):
      i40e: fix VLAN.TCI =3D=3D 0 RX HW offload
      i40e: DRY rx_ptype handling code

Mikhael Goikhman (1):
      net/mlx5e: Remove unused UDP GSO remaining counter

Mikhail Zaslonko (1):
      mm, memory_hotplug: initialize struct pages for the full memory secti=
on

Mimi Zohar (1):
      ima: cleanup the match_token policy code

Moshe Shemesh (1):
      net/mlx5e: RX, Verify MPWQE stride size is in range

Myungho Jung (1):
      net/smc: fix TCP fallback socket release

Nathan Chancellor (1):
      drivers: net: xgene: Remove unnecessary forward declarations

Nicolas Saenz Julienne (1):
      USB: xhci: fix 'broken_suspend' placement in struct xchi_hcd

Or Gerlitz (4):
      net/mlx5e: Err if asked to mirror a goto chain tc eswitch rule
      net/mlx5e: Avoid overriding the user provided priority for
offloaded tc rules
      net/mlx5e: Properly initialize flow attributes for slow path
eswitch rule deletion
      net/mlx5e: Avoid encap flows deletion attempt the 1st time a
neigh is resolved

Oscar Salvador (1):
      mm, page_alloc: fix has_unmovable_pages for HugePages

Pan Bian (3):
      netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel
      ubi: Put MTD device after it is not used
      ubi: Do not drop UBI device reference before using

Paul Burton (1):
      Revert "serial: 8250: Fix clearing FIFOs in RS485 mode again"

Peter Xu (1):
      mm: thp: fix flags for pmd migration when split

Peter Zijlstra (1):
      x86/mm/cpa: Fix cpa_flush_array() TLB invalidation

Petr Machata (4):
      vxlan: Unmark offloaded bit on replaced FDB entries
      vxlan: Fix error path in __vxlan_dev_create()
      vxlan: changelink: Fix handling of default remotes
      selftests: net: Add test_vxlan_fdb_changelink.sh

Pieter Jansen van Vuuren (1):
      nfp: flower: ensure TCP flags can be placed in IPv6 frame

Rakesh Pillai (1):
      ath10k: skip sending quiet mode cmd for WCN3990

Reinette Chatre (1):
      x86/intel_rdt: Ensure a CPU remains online for the region's
pseudo-locking sequence

Richard Weinberger (1):
      ubifs: Handle re-linking of inodes correctly while recovery

Rik van Riel (1):
      fork,memcg: fix crash in free_thread_stack on memcg charge fail

Robert P. J. Day (1):
      mod_devicetable.h: correct kerneldoc typo, "PHYSID2" -> "MII_PHYSID2"

Roi Dayan (1):
      net/sched: cls_flower: Remove old entries from rhashtable

Ronnie Sahlberg (1):
      smb3: Fix rmdir compounding regression to strict servers

Ross Lagerwall (1):
      ixgbe: Fix race when the VF driver does a reset

Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning

Sandipan Das (1):
      bpf: powerpc: fix broken uapi for BPF_PROG_TYPE_PERF_EVENT

Sara Sharon (2):
      mac80211: fix a kernel panic when TXing after TXQ teardown
      mac80211: free skb fraglist before freeing the skb

Sasha Levin (1):
      MAINTAINERS: Patch monkey for the Hyper-V code

Shalom Toledo (1):
      mlxsw: core: Increase timeout during firmware flash process

Sinan Kaya (1):
      x86, hyperv: remove PCI dependency

Sowjanya Komatineni (2):
      mmc: sdhci: Fix sdhci_do_enable_v4_mode
      mmc: tegra: Fix for SDMMC pads autocal parsing from dt

Stanislav Fomichev (4):
      selftests/bpf: use thoff instead of nhoff in BPF flow dissector
      net/flow_dissector: correctly cap nhoff and thoff in case of BPF
      selftests/bpf: add missing pointer dereference for map stacktrace fix=
up
      selftests/bpf: use proper type when passing prog_type

Stefan Assmann (1):
      i40e: fix mac filter delete when setting mac address

Steffen Klassert (1):
      xfrm: Fix NULL pointer dereference in xfrm_input when
skb_dst_force clears the dst_entry.

Stephen Hemminger (1):
      uio_hv_generic: set callbacks on open

Sudarsana Reddy Kalluru (5):
      bnx2x: Clear fip MAC when fcoe offload support is disabled
      bnx2x: Remove configured vlans as part of unload sequence.
      bnx2x: Enable PTP only on the PF that initializes the port
      bnx2x: Send update-svid ramrod with retry/poll flags enabled
      qed: Fix command number mismatch between driver and the mfw

Taehee Yoo (2):
      netfilter: nf_tables: fix suspicious RCU usage in
nft_chain_stats_replace()
      netfilter: nf_conncount: use rb_link_node_rcu() instead of rb_link_no=
de()

Tal Gilboa (1):
      net/mlx5e: Cancel DIM work on close SQ

Tariq Toukan (1):
      net/mlx5e: RX, Fix wrong early return in receive queue poll

Thomas Falcon (2):
      ibmvnic: Convert reset work item mutex to spin lock
      ibmvnic: Fix non-atomic memory allocation in IRQ context

Thomas Gleixner (2):
      posix-timers: Fix division by zero bug
      futex: Cure exit race

Tony Lindgren (2):
      Input: omap-keypad - fix idle configuration to not block SoC idle sta=
tes
      gpio: gpio-omap: Revert deferred wakeup quirk handling for regression=
s

Tore Anderson (1):
      USB: serial: option: add HP lt4132

Trond Myklebust (3):
      SUNRPC: Fix disconnection races
      SUNRPC: Fix a race with XPRT_CONNECTING
      SUNRPC: Remove xprt_connect_status()

Ulf Hansson (3):
      mmc: core: Reset HPI enabled state during re-init and in case of erro=
rs
      mmc: core: Allow BKOPS and CACHE ctrl even if no HPI support
      mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl

Uwe Kleine-K=C3=B6nig (1):
      gpio: mvebu: only fail on missing clk if pwm is actually to be used

Vakul Garg (2):
      Prevent overflow of sk_msg in sk_msg_clone()
      tls: Do not call sk_memcopy_from_iter with zero length

Varun Prakash (2):
      scsi: target: iscsi: cxgbit: fix csk leak
      scsi: target: iscsi: cxgbit: add missing spin_lock_init()

Vitaly Kuznetsov (1):
      KVM: x86: nSVM: fix switch to guest mmu

Vivien Didelot (2):
      MAINTAINERS: change my email address
      net: dsa: mv88e6xxx: set ethtool regs version

Vu Pham (1):
      net/mlx5: E-Switch, Fix fdb cap bits swap

Wanpeng Li (1):
      KVM: X86: Fix NULL deref in vcpu_scan_ioapic

Wei Yongjun (1):
      xfrm: Fix error return code in xfrm_output_one()

Willem de Bruijn (3):
      ipv6: add missing tx timestamping on IPPROTO_RAW
      net: add missing SOF_TIMESTAMPING_OPT_ID support
      packet: validate address length

Xiaozhou Liu (1):
      include/linux/compiler_types.h: don't pollute userspace with
macro definitions

Xin Long (1):
      sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Yangtao Li (1):
      serial/sunsu: fix refcount leak

Yanjiang Jin (1):
      PCI/AER: Queue one GHES event, not several uninitialized ones

Yonglong Liu (10):
      net: hns: Incorrect offset address used for some registers.
      net: hns: All ports can not work when insmod hns ko after rmmod.
      net: hns: Some registers use wrong address according to the datasheet=
.
      net: hns: Fixed bug that netdev was opened twice
      net: hns: Clean rx fbd when ae stopped.
      net: hns: Free irq when exit from abnormal branch
      net: hns: Avoid net reset caused by pause frames storm
      net: hns: Fix ntuple-filters status error.
      net: hns: Add mac pcs config when enable|disable mac
      net: hns: Fix ping failed when use net bridge and send multicast

YueHaibing (1):
      ieee802154: ca8210: fix possible u8 overflow in ca8210_rx_done

Yussuf Khalil (1):
      Input: synaptics - enable RMI on ThinkPad T560

Yuval Avnery (1):
      net/mlx5: Typo fix in del_sw_hw_rule

ndesaulniers@google.com (1):
      sparc: vdso: Drop implicit common-page-size linker flag

shamir rabinovitch (2):
      net/rds: fix warn in rds_message_alloc_sgs
      net/rds: remove user triggered WARN_ON in rds_sendmsg

wenxu (1):
      iptunnel: make TUNNEL_FLAGS available in uapi
