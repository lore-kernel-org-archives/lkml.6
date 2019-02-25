Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C512087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 01:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JYL0I2jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfBYBDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 20:03:15 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:38448 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfBYBDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 20:03:15 -0500
Received: by mail-lf1-f44.google.com with SMTP id n15so5573975lfe.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 17:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=S162447SbvVBaA8HqkUbqyDqg+UKQB694ppnM31nmCU=;
        b=JYL0I2jFKmufSg37U3UbQeqSHQJfzjNh1TTtzDSk99BMXnvwNzfYhkv07W4cNNCQQ4
         nw8J/jxzCIQoBgOkgiOrWAQm12/iSidvXr04ultpsqHmWwX7RKMZfrgWCVjdR7jesR/e
         QZK+krUTeA8HGlxZ+5MBqhATGOeG8LrQFn6j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=S162447SbvVBaA8HqkUbqyDqg+UKQB694ppnM31nmCU=;
        b=tbamNCnYbEhSJQ5mpfozv+nDNCb9S5oH5Xd5wtKJ7w7h02h4M55oHOGQizn8/173Q9
         psL1FHfLgJVvksbnSqlUphKN3S47+GSe2WHca1bUxEaWmrwyEZmJtfPzpQRRNz8FNlg+
         p3m7fPf4Fa6Gf4mjQzXS3fVjdJuFSzlKErWJyIERyyhfou4h6CRYSk0Px1S2bKaF8EPo
         I4XBtrNf4ScGmF9g4ycFbUCt5cZYaXCKQ8Mghvjoeid62VkvwsOh3ZRN1DvosFgPz2eu
         zoAheV+kst4BVA9vdm2sN4BzSbNy0lvC2Q5qEDRK2CcX61PSzPDozWrsYd69dxubo+hX
         a8MA==
X-Gm-Message-State: AHQUAuYNI1ABSOURSxtSwO7cnpmlfzttrgySGVtn67xwj4mBWTB4f1ap
        QWBN9EKzRRKbYZTs8oP5j46SadrE5Dk=
X-Google-Smtp-Source: AHgI3IYut8AT1g9ACqCMKkhqZZVvPrTzyYHYzO9Xhg1oxMi8ryIucf3274+e037HNMAnd9hGiMWydQ==
X-Received: by 2002:a19:6a18:: with SMTP id u24mr9638744lfu.146.1551056591138;
        Sun, 24 Feb 2019 17:03:11 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q2sm2629639lfa.63.2019.02.24.17.03.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 17:03:10 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id z196so4881302lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 17:03:10 -0800 (PST)
X-Received: by 2002:a19:4ac4:: with SMTP id x187mr5223630lfa.166.1551056589675;
 Sun, 24 Feb 2019 17:03:09 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Feb 2019 17:02:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtNhecfn_nOi0Yuy7XQSswfozz0CvRMn0WsQhk0YZfyw@mail.gmail.com>
Message-ID: <CAHk-=wgtNhecfn_nOi0Yuy7XQSswfozz0CvRMn0WsQhk0YZfyw@mail.gmail.com>
Subject: Linux 5.0-rc8
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This may be totally unnecessary, but we actually had more patches come
in this last week than we had for rc7, which just didn't make me feel
the warm and fuzzies. And while none of the patches looked all that
scary, some of them were to pretty core files, so it wasn't all just
random rare drivers (although those kinds also existed).

So I agonized about it a bit, and then decided to just say "no hurry"
and make an rc8. And after I had tagged the rc, I noticed a patch in
my inbox that I had missed that was a regression from one of the very
patches this last week, so that made me feel like rc8 was the right
decision.

Anyway, maybe I should have just checked my email more carefully, and
maybe I'm just being unnecessarily worried. I could have just untagged
the rc release (it hadn't actually gone public when I noticed),
applied the missing patch, and called it good. But instead I took it
as confirmation that we should bake this thing one more week.

Confirmation bias? Maybe.  Because while rc8 is bigger than rc7, it's
not *hugely* so, and none of the changes look all that controversial.
About 30% drivers (gpu, net, rdma, sound, scsi..), 20% networking, and
the rest is arch updates, some mm fixes, some key handling fixes,
filesystem, include files..

But on the whole I just felt happier with an extra rc than worrying
about things.

Shortlog appended for some flavor of the details.

                 Linus

---

Al Viro (1):
      missing barriers in some of unix_sock ->addr and ->path accesses

Alban Crequy (1):
      bpf, lpm: fix lookup bug in map_delete_elem

Alex Deucher (1):
      drm/amdgpu: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Alexander Duyck (2):
      mm: Use fixed constant in page_frag_alloc instead of size + 1
      net: Do not allocate page fragments that are not skb aligned

Alexandre Belloni (2):
      clk: at91: fix at91sam9x5 peripheral clock number
      clk: at91: fix masterck name

Alexandre Torgue (1):
      net: stmmac: handle endianness in dwmac4_get_timestamp

Alexei Starovoitov (1):
      bpf: fix lockdep false positive in stackmap

Alexey Brodkin (1):
      ARC: define ARCH_SLAB_MINALIGN =3D 8

Alexey Kardashevskiy (1):
      powerpc/powernv/sriov: Register IOMMU groups for VFs

Alexey Khoroshilov (1):
      net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_pro=
be()

Andre Przywara (1):
      clk: sunxi: A31: Fix wrong AHB gate number

Andrea Claudi (1):
      ipvs: fix warning on unused variable

Andrew Morton (1):
      revert "initramfs: cleanup incomplete rootfs"

Andrey Konovalov (11):
      kasan: fix assigning tags twice
      kasan, kmemleak: pass tagged pointers to kmemleak
      kmemleak: account for tagged pointers when calculating pointer range
      kasan, slub: move kasan_poison_slab hook before page_address
      kasan, slub: fix conflicts with CONFIG_SLAB_FREELIST_HARDENED
      kasan, slub: fix more conflicts with CONFIG_SLAB_FREELIST_HARDENED
      kasan: fix random seed generation for tag-based mode
      kasan: prevent tracing of tags.c
      kasan, slab: fix conflicts with CONFIG_HARDENED_USERCOPY
      kasan, slab: make freelist stored without tags
      kasan, slab: remove redundant kasan_slab_alloc hooks

Aneesh Kumar K.V (2):
      mtd: Use mtd->name when registering nvmem device
      mtd: powernv_flash: Fix device registration error

Anoob Soman (1):
      scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_t=
ask

Arnd Bergmann (2):
      Documentation: change linux-4.x references to 5.x
      phonet: fix building with clang

Bard liao (1):
      ASoC: topology: free created components in tplg load error

Bart Van Assche (1):
      RDMA/srp: Rework SCSI device reset handling

Baruch Siach (1):
      arm64: dts: clearfog-gt-8k: fix SGMII PHY reset signal

Beniamino Galvani (1):
      qmi_wwan: apply SET_DTR quirk to Sierra WP7607

Bhawanpreet Lakha (2):
      drm/amd/display: fix optimize_bandwidth func pointer for dce80
      drm/amd/display: set clocks to 0 on suspend on dce80

Bjorn Andersson (1):
      pinctrl: qcom: qcs404: Correct SDC tile

Bj=C3=B6rn T=C3=B6pel (3):
      xsk: do not remove umem from netdevice on fall-back to copy-mode
      Revert "xsk: simplify AF_XDP socket teardown"
      i40e: fix XDP_REDIRECT/XDP xmit ring cleanup race

Changbin Du (1):
      kprobe: Do not use uaccess functions to access kernel memory
that can fault

Chris Wilson (1):
      drm/i915/fbdev: Actually configure untiled displays

Christian K=C3=B6nig (1):
      drm/amdgpu: disable bulk moves for now

Colin Ian King (1):
      net/mlx4_en: fix spelling mistake: "quiting" -> "quitting"

Cong Wang (1):
      xfrm: destroy xfrm_state synchronously on net exit path

Daniel Borkmann (2):
      ipvlan: disallow userns cap_net_admin to change global mode/flags
      bpf, doc: add bpf list as secondary entry to maintainers file

Daniel Vetter (1):
      mm: don't let userspace spam allocations warnings

Darrick J. Wong (1):
      tmpfs: fix link accounting when a tmpfile is linked in

David Chen (2):
      r8152: Add support for MAC address pass through on RTL8153-BD
      r8152: Fix an error on RTL8153-BD MAC Address Passthrough support

David Howells (3):
      assoc_array: Fix shortcut creation
      keys: Fix dependency loop between construction record and auth key
      keys: Timestamp new keys

David S. Miller (1):
      net: Add header for usage of fls64()

Davidlohr Bueso (1):
      xsk: share the mmap_sem for page pinning

Dietmar Eggemann (1):
      ARM: 8824/1: fix a migrating irq bug when hotplug cpu

Dmitry V. Levin (1):
      parisc: Fix ptrace syscall number modification

Eric Biggers (3):
      KEYS: allow reaching the keys quotas exactly
      KEYS: user: Align the payload buffer
      KEYS: always initialize keyring_index_key::desc_len

Eric Dumazet (4):
      tcp: clear icsk_backoff in tcp_write_queue_purge()
      tcp: tcp_v4_err() should be more careful
      net/x25: fix a race in x25_bind()
      tcp: repaired skbs must init their tso_segs

Eugene Loh (1):
      kallsyms: Handle too long symbols in kallsyms.c

Eugeniy Paltsev (5):
      ARCv2: Enable unaligned access in early ASM code
      ARCv2: lib: memcpy: fix doing prefetchw outside of buffer
      ARC: fix actionpoints configuration detection
      ARC: U-boot: check arguments paranoidly
      ARC: enable uboot support unconditionally

Felix Fietkau (1):
      mac80211: allocate tailroom for forwarded mesh packets

Florian Fainelli (6):
      net: dsa: b53: Fix default VLAN ID
      net: dsa: b53: Properly account for VLAN filtering
      net: systemport: Fix reception of BPDUs
      net: dsa: bcm_sf2: Do not assume DSA master supports WoL
      net: dsa: b53: Do not program CPU port's PVID
      Documentation: networking: switchdev: Update port parent ID section

George Wilkie (1):
      team: use operstate consistently for linkup

Hangbin Liu (2):
      net: vrf: remove MTU limits for vrf device
      Revert "bridge: do not add port to router list when receives
query with source 0.0.0.0"

Hauke Mehrtens (2):
      net: Fix for_each_netdev_feature on Big endian
      net: dsa: Remove documentation for port_fdb_prepare

Helge Deller (1):
      CREDITS/MAINTAINERS: Retire parisc-linux.org email domain

Herbert Xu (2):
      mac80211: Use linked list instead of rhashtable walk for mesh tables
      mac80211: Free mpath object when rhashtable insertion fails

Hui Wang (1):
      ALSA: hda/realtek: Disable PC beep in passthrough on alc285

Ilya Dryomov (1):
      libceph: handle an empty authorize reply

Jan Sokolowski (1):
      ixgbe: don't do any AF_XDP zero-copy transmit if netif is not OK

Jann Horn (2):
      MAINTAINERS: mark CAIF as orphan
      net: socket: add check for negative optlen in compat setsockopt

Jason Wang (1):
      vhost: correctly check the return value of translate_desc() in log_us=
ed()

Jeff Kirsher (1):
      ixgbe: fix older devices that do not support IXGBE_MRQC_L3L4TXSWEN

Jeremy Soller (1):
      ALSA: hda/realtek - Headset microphone and internal speaker
support for System76 oryp5

Jiong Wang (2):
      nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K
      nfp: bpf: fix ALU32 high bits clearance bug

Johannes Weiner (1):
      psi: avoid divide-by-zero crash inside virtual machines

John Garry (1):
      scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attac=
hed

Jose Abreu (1):
      net: stmmac: Fix a race in EEE enable callback

Kai-Heng Feng (1):
      sky2: Increase D3 delay again

Kalash Nainwal (1):
      net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255

Kees Cook (1):
      exec: load_script: Do not exec truncated interpreter path

Kuninori Morimoto (1):
      ASoC: simple-card: fixup refcount_t underflow

Leo (Hanghong) Ma (1):
      drm/amd/display: Fix MST reboot/poweroff sequence

Li RongQing (1):
      mac80211_hwsim: propagate genlmsg_reply return code

Linus Torvalds (1):
      Linux 5.0-rc8

Linus Walleij (1):
      net: phy: realtek: Dummy IRQ calls for RTL8366RB

Lorenzo Bianconi (4):
      net: ip6_gre: initialize erspan_ver just for erspan tunnels
      net: ip_gre: do not report erspan_ver for gre or gretap
      net: ip6_gre: do not report erspan_ver for ip6gre or ip6gretap
      net: ip6_gre: fix possible NULL pointer dereference in
ip6erspan_set_version

Lubomir Rintel (1):
      gpio: pxa: avoid attempting to set pin direction via pinctrl on MMP2

Maciej Kwiecien (1):
      sctp: don't compare hb_timer expire date before starting it

Magnus Karlsson (3):
      xsk: add missing smp_rmb() in xsk_mmap
      i40e: fix potential RX buffer starvation for AF_XDP
      ixgbe: fix potential RX buffer starvation for AF_XDP

Mao Wenan (2):
      net: crypto set sk to NULL when af_alg_release.
      net: set static variable an initial value in atl2_probe()

Mark Rutland (1):
      arm64: fix SSBS sanitization

Martin Blumenstingl (1):
      pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins

Martin KaFai Lau (1):
      bpf: Fix narrow load on a bpf_sock returned from sk_lookup()

Martin Wilck (1):
      scsi: core: reset host byte in DID_NEXUS_FAILURE case

Martin Willi (1):
      esp: Skip TX bytes accounting when sending from a request socket

Masahiro Yamada (1):
      sh: fix build error for invisible CONFIG_BUILTIN_DTB_SOURCE

Masato Suzuki (1):
      scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation

Mathieu Desnoyers (1):
      ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction

Maxime Chevallier (1):
      net: phy: marvell10g: Fix Multi-G advertisement to only advertise 10G

Mel Gorman (1):
      mm, page_alloc: fix a division by zero error when boosting watermarks=
 v2

Michael Chan (2):
      bnxt_en: Fix typo in firmware message timeout logic.
      bnxt_en: Wait longer for the firmware message response to complete.

Michal Hocko (3):
      proc, oom: do not report alien mms when setting oom_score_adj
      mm: handle lru_add_drain_all for UP properly
      mm, memory_hotplug: fix off-by-one in is_pageblock_removable

Michal Kalderon (2):
      qed: Fix iWARP buffer size provided for syn packet processing.
      qed: Fix iWARP syn packet mac address validation.

Michal Soltys (1):
      bonding: fix PACKET_ORIGDEV regression

Murali Karicheri (1):
      net: netcp: Fix ethss driver probe issue

Nathan Chancellor (1):
      arm64/neon: Disable -Wincompatible-pointer-types when building with C=
lang

Nicholas Kazlauskas (1):
      drm/amd/display: Fix negative cursor pos programming

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fix flush after rule deletion in the same batch

Paolo Abeni (7):
      ipv6: route: enforce RCU protection in rt6_update_exception_stamp_rt(=
)
      ipv6: route: enforce RCU protection in ip6_route_check_nh_onlink()
      ipv6: route: purge exception on removal
      udpv6: add the required annotation to mib type
      fou6: fix proto error handler argument type
      udpv6: fix possible user after free in error handler
      udp: fix possible user after free in error handler

Paul Burton (2):
      MIPS: eBPF: Always return sign extended 32b values
      MIPS: eBPF: Remove REG_32BIT_ZERO_EX

Paul Kocialkowski (2):
      clk: sunxi-ng: v3s: Fix TCON reset de-assert bit
      net: phy: xgmiitorgmii: Support generic PHY status read

Peter Ujfalusi (2):
      ARM: dts: am335x-evmsk: Fix PHY mode for ethernet
      ARM: dts: am335x-evm: Fix PHY mode for ethernet

Petr Machata (1):
      mlxsw: __mlxsw_sp_port_headroom_set(): Fix a use of local variable

Petr Vorel (1):
      doc: Mention MSG_ZEROCOPY implementation for UDP

Pierre Morel (1):
      s390: vsie: Use effective CRYCBD.31 to check CRYCBD validity

Qian Cai (2):
      slub: fix SLAB_CONSISTENCY_CHECKS + KASAN_SW_TAGS
      slub: fix a crash with SLUB_DEBUG + KASAN_SW_TAGS

Quentin Perret (1):
      tracing: Fix number of entries in trace header

Rafael J. Wysocki (1):
      gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Raju Rangoju (2):
      cxgb4: Export sge_host_page_size to ulds
      iw_cxgb4: cq/qp mask depends on bar2 pages in a host page

Rakesh Pillai (1):
      mac80211: Restore vif beacon interval if start ap fails

Ralph Campbell (1):
      numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNOD=
ES

Rayagonda Kokatanur (1):
      mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue

Ren=C3=A9 van Dorst (1):
      gpio: MT7621: use a per instance irq_chip structure

Robin Murphy (2):
      ARM: 8835/1: dma-mapping: Clear DMA ops on teardown
      mm/debug.c: fix __dump_page() for poisoned pages

Roman Li (1):
      drm/amd/display: Raise dispclk value for dce11

Russell King (2):
      net: dsa: fix unintended change of bridge interface STP state
      net: marvell: mvneta: fix DMA debug warning

Salil Mehta (1):
      net: hns: Fixes the missing put_device in positive leg for roce reset

Sean Tranchetti (1):
      af_key: unconditionally clone on broadcast

Stanislav Fomichev (1):
      bpf/test_run: fix unkillable BPF_PROG_TEST_RUN

Stanislaw Gruszka (1):
      mt76x0u: fix suspend/resume

Sylwester Nawrocki (1):
      ASoC: samsung: i2s: Fix prescaler setting for the secondary DAI

Thadeu Lima de Souza Cascardo (1):
      selftests: fib_tests: sleep after changing carrier. again.

Thierry Reding (2):
      mailbox: Export mbox_flush()
      ARM: tegra: Restore DT ABI on Tegra124 Chromebooks

Thomas Petazzoni (1):
      ARM: dts: armada-xp: fix Armada XP boards NAND description

Tobias Brunner (1):
      xfrm: Fix inbound traffic via XFRM interfaces across network namespac=
es

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      mac80211: Change default tx_sk_pacing_shift to 7

Tung Nguyen (2):
      tipc: improve function tipc_wait_for_cond()
      tipc: improve function tipc_wait_for_rcvmsg()

Ursula Braun (1):
      net/smc: fix smc_poll in SMC_INIT state

Vadim Lomovtsev (8):
      net: thunderx: correct typo in macro name
      net: thunderx: replace global nicvf_rx_mode_wq work queue for
all VFs to private for each of them.
      net: thunderx: make CFG_DONE message to run through generic
send-ack sequence
      net: thunderx: add nicvf_send_msg_to_pf result check for set_rx_mode_=
task
      net: thunderx: rework xcast message structure to make it fit into 64 =
bit
      net: thunderx: add mutex to protect mailbox from concurrent
calls for same VF
      net: thunderx: move link state polling function to VF
      net: thunderx: remove link change polling code and info from nicpf

Vincent Guittot (1):
      PM-runtime: Fix deadlock when canceling hrtimer

Vineet Gupta (3):
      ARC: uacces: remove lp_start, lp_end from clobber list
      ARCv2: support manual regfile save on interrupts
      ARCv2: don't assume core 0x54 has dual issue

Vitaly Kuznetsov (1):
      x86/kvm/mmu: fix switch between root and guest MMUs

Vladimir Murzin (1):
      arm64: Relax GIC version check during early boot

Wei Yongjun (1):
      mac80211: mesh: fix missing unlock on error in table_path_del()

Willem de Bruijn (3):
      bpf: only adjust gso_size on bytestream protocols
      net: validate untrusted gso packets without csum offload
      net: avoid false positives in untrusted gso validation

Yan, Zheng (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

Yangtao Li (1):
      cpufreq: scmi: Fix use-after-free in scmi_cpufreq_exit()

Yu Zhang (2):
      kvm: x86: Return LA57 feature based on hardware capability
      KVM: MMU: record maximum physical address width in kvm_mmu_extended_r=
ole

YueHaibing (1):
      mdio_bus: Fix use-after-free on device_register fails

shaoyunl (1):
      drm/amdgpu: Update sdma golden setting for vega20
