Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE6C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A4A20672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V5gcP6VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A4A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbeLIXoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 18:44:03 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43876 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeLIXoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 18:44:03 -0500
Received: by mail-lj1-f178.google.com with SMTP id 83-v6so7972676ljf.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 15:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SHJCMHiSb6o9AFtNV3BX9wA3ZTgp5amt+Z+oh3rSraY=;
        b=V5gcP6VHJwn/UHdp/t025FMhaoBXWUZ7PYAWev7+2heWqjaIeMDuUn3xoBXlAe7wnU
         yKUUXpMZu9Cs/Mcd4ScI5oIoZ8A1zrhm+1ByinODWUNpkfElfI70+MIvy74mhQHf9gKS
         geeaSBSwd/Fp/ccHkZG3/WeDxsxT8xIRzGu3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SHJCMHiSb6o9AFtNV3BX9wA3ZTgp5amt+Z+oh3rSraY=;
        b=EPaOl4/J7Q9/hF2Hs/Jh7DLR8XVne2Oq8/TNw63+PwuobRKBpuDPBUs/7+VuLiZ8Jm
         L5VD6QOWZF6PaKESGzTVrhOrMXEFMOFEObiKZGgIRY8P4ObDPCaAKLXhSbGLcOcIaRJZ
         TX8IcSwltkS0x4U8Li5wPVnDBRQpj1a0Ho8aDp3V+oldWrzOICI91ycYDEG+zzXi6/hr
         BcPAP+96aHq3i9eV2Janp52h0sRxg8ZADHWJuM0P4hfLMjLtOrO46PZKjlEB+E0BdgsP
         h+dDnCvDpsO1xsxFxBJsaV/glsGAKApYJnaMThX3Z7Pp2CqEIQLlT8o34lW7Jbyvxh1x
         DJoA==
X-Gm-Message-State: AA+aEWYwrsZ5ZxOEZFL0y2Z2Zs/c2Q7QcaUstx8sUd6vrvinme011pKu
        F6HZITHd6ezr3M6rxelBjImCxsiPIiI=
X-Google-Smtp-Source: AFSGD/UfAtSz5//wTQeQL3AZSdOW2zlM6ECMVk2cgugTloJOG/zMOUcROakos1LZWO3ZDTmLIn4Xig==
X-Received: by 2002:a2e:5356:: with SMTP id t22-v6mr5575707ljd.26.1544399038141;
        Sun, 09 Dec 2018 15:43:58 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q30sm1817464lfi.94.2018.12.09.15.43.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 15:43:57 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id 83-v6so7972653ljf.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 15:43:57 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr6385000ljj.6.1544399036742;
 Sun, 09 Dec 2018 15:43:56 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Dec 2018 15:43:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHSX8x6mOB0xZibbg-xc3veqsQEnHZ1+3H2DbO5MU5Rw@mail.gmail.com>
Message-ID: <CAHk-=wgHSX8x6mOB0xZibbg-xc3veqsQEnHZ1+3H2DbO5MU5Rw@mail.gmail.com>
Subject: Linux 4.20-rc6
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. Things look fairly normal. just under half of the patch is to
drivers (gpu, networking, nvdimm, block, media..), with the rest being
tooling (mostly bpf selftests) core networking, documentation and some
arch updates, Some filesystem, core kernel and mm fixes in there too
(we've had some last-minute THP reverts and discussion for how to
re-do it next time).

Most of it looks pretty small and normal. Would I have preferred for
there to be less churn? Yes. But it's certainly smaller than rc5 was,
so we're moving in the right direction, and we have at least one more
rc to go.

I say "at least", not because I'm particularly worried about the
technical details and any outstanding bugs, but because of the whole
holiday season timing. I still suspect that what I'll do is release
4.20 just before xmas (so with the usual "rc7->final" cadence) but
then just leave a dead week for the holiday season. Again encouraging
everybody to send in their pull request for the merge window *before*
the holiday season, but I might just either ignore them for a week, or
take it very slow and easy.

And of course, if we have something worrisome come up, any technical
issues can derail that plan, but I don't think there's anything bad
pending now.

                Linus

---

Abhinav Kumar (1):
      drm/msm/dsi: configure VCO rate for 10nm PLL driver

Adam Wong (1):
      Input: elan_i2c - add support for ELAN0621 touchpad

Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c: axxia: properly handle master timeout

Alan Stern (1):
      USB: Fix invalid-free bug in port_over_current_notify()

Alex Deucher (3):
      drm/amdgpu: add VCN JPEG support amdgpu_ctx_num_entities
      drm/amdgpu/gmc8: update MC firmware for polaris
      drm/amdgpu/gmc8: always load MC firmware in the driver

Alexander Popov (1):
      stackleak: Register the 'stackleak_cleanup' pass before the
'*free_cfg' pass

Alexander Theissen (1):
      usb: appledisplay: Add 27" Apple Cinema Display

Alexei Starovoitov (3):
      bpf: check pending signals while verifying programs
      bpf: improve verifier branch analysis
      bpf: add per-insn complexity limit

Alexey Brodkin (1):
      arc: [devboards] Add support of NFSv3 ACL

Alexey Khoroshilov (1):
      mac80211_hwsim: fix module init error paths for netlink

Anders Roxell (1):
      stackleak: Mark stackleak_track_stack() as notrace

Anderson Luiz Alves (1):
      mv88e6060: disable hardware level MAC learning

Andrea Righi (1):
      kprobes/x86: Blacklist non-attachable interrupt functions

Andy Shevchenko (1):
      dmaengine: dw: Fix FIFO size for Intel Merrifield

Bartlomiej Zolnierkiewicz (1):
      ARC: remove redundant 'default n' from Kconfig

Baruch Siach (4):
      net: phy: sfp: correct store of detected link modes
      net: phy: sfp: correct location of SFP standards
      net: mvpp2: fix detection of 10G SFP modules
      net: mvpp2: fix phylink handling of invalid PHY modes

Ben Greear (1):
      mac80211: Clear beacon_int in ieee80211_do_stop

Benjamin Herrenschmidt (1):
      Revert "net/ibm/emac: wrong bit is used for STA control"

Bin Liu (1):
      dmaengine: cppi41: delete channel from pending list when stop channel

Bjorn Andersson (1):
      arm64: dts: qcom: sdm845-mtp: Mark protected gcc clocks

Bjorn Helgaas (1):
      Revert "PCI/ASPM: Do not initialize link state when aspm_disabled is =
set"

Brian Norris (1):
      Input: cros_ec_keyb - fix button/switch capability reports

Cameron Gutman (1):
      Input: xpad - quirk all PDP Xbox One gamepads

Cathy Avery (1):
      scsi: vmw_pscsi: Rearrange code to avoid multiple calls to
free_irq during unload

Chanho Min (1):
      ALSA: pcm: Fix starvation on down_write_nonblock()

Chanho Park (1):
      tty: do not set TTY_IO_ERROR flag if console port

Chris Chiu (4):
      ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer
Aspire U27-880
      ALSA: hda/realtek - Add support for Acer Aspire C24-860 headset mic
      ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4660G
      ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4860G/Z6860G

Chris Cole (1):
      ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned
address handling

Christian Hoff (1):
      Input: matrix_keypad - check for errors from of_get_named_gpio()

Christian K=C3=B6nig (2):
      drm/ttm: fix LRU handling in ttm_buffer_object_transfer
      drm/amdgpu: wait for IB test on first device open

Christoph Paasch (1):
      net: Prevent invalid access to skb->prev in __qdisc_drop_all

Chuck Lever (1):
      SUNRPC: Fix leak of krb5p encode pages

Colin Ian King (3):
      Input: atkbd - clean up indentation issue
      liquidio: fix spelling mistake "deferal" -> "deferral"
      openvswitch: fix spelling mistake "execeeds" -> "exceeds"

Cong Wang (1):
      mlx5: fix get_ip_proto()

Dan Carpenter (4):
      drm/msm/gpu: Fix a couple memory leaks in debugfs
      clk: mvebu: Off by one bugs in cp110_of_clk_get()
      clk: mmp: Off by one in mmp_clk_add()
      clk: zynqmp: Off by one in zynqmp_is_valid_clock()

Dan Williams (3):
      tools/testing/nvdimm: Align test resources to 128M
      libnvdimm, pfn: Pad pfn namespaces relative to other regions
      acpi/nfit: Fix user-initiated ARS to be "ARS-long" rather than "ARS-s=
hort"

Daniel Borkmann (1):
      bpf: fix pointer offsets in context for 32 bit

Daniel Vetter (1):
      drm/lease: Send a distinct uevent

Darrick J. Wong (4):
      xfs: fix PAGE_MASK usage in xfs_free_file_space
      vfs: allow some remap flags to be passed to vfs_clone_file_range
      splice: don't read more than available pipe space
      iomap: partially revert 4721a601099 (simulated directio short
read on EFAULT)

Dave Kleikamp (1):
      nfs: don't dirty kernel pages read by direct-io

David Miller (1):
      bpf: Fix verifier log string check for bad alignment.

David Rientjes (2):
      mm, thp: restore node-local hugepage allocations
      Revert "mm, thp: consolidate THP gfp handling into
alloc_hugepage_direct_gfpmask"

David S. Miller (1):
      phy: Revert toggling reset changes.

Davide Caratti (1):
      net/sched: act_police: fix memory leak in case of invalid control act=
ion

Dexuan Cui (2):
      scsi: storvsc: Fix a race in sub-channel creation that can cause pani=
c
      Drivers: hv: vmbus: Offload the handling of channels to two workqueue=
s

Ding Tao (1):
      Input: dt-bindings - fix a typo in file input-reset.txt

Dmitry Bogdanov (1):
      net: aquantia: fix rx checksum offload bits

Edward Cree (1):
      net: use skb_list_del_init() to remove from RX sublists

Emmanuel Grumbach (1):
      mac80211: ignore NullFunc frames in the duplicate detection

Enric Balletbo i Serra (1):
      Revert "mfd: cros_ec: Use devm_kzalloc for private data"

Eran Ben Elisha (1):
      net/mlx4_en: Change min MTU size to ETH_MIN_MTU

Eric Dumazet (3):
      rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices
      tcp: Do not underestimate rwnd_limited
      tcp: lack of available data can also cause TSO defer

Eric Sandeen (1):
      xfs: fix inverted return from xfs_btree_sblock_verify_crc

Eric Snowberg (1):
      x86/efi: Allocate e820 buffer before calling efi_exit_boot_service

Eugeniy Paltsev (3):
      ARC: IOC: panic if kernel was started with previously enabled IOC
      ARC: [plat-hsdk] Enable DW APB GPIO support
      ARC: mm: fix uninitialised signal code in do_page_fault

Evan Quan (3):
      drm/amd/powerplay: support new pptable upload on Vega20
      drm/amd/powerplay: issue pre-display settings for display change even=
t
      drm/amd/powerplay: support SoftMin/Max setting for some specific DPM

Ezequiel Garcia (1):
      media: Revert "media: dt-bindings: Document the Rockchip VPU bindings=
"

Felix Fietkau (2):
      mac80211: ignore tx status for PS stations in ieee80211_tx_status_ext
      mac80211: fix reordering of buffered broadcast packets

Florian Fainelli (1):
      net: dsa: Fix tagging attribute location

Fred Herard (1):
      scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_rese=
t

Guo Ren (3):
      MAINTAINERS: add maintainer for C-SKY drivers
      csky: bugfix tlb_get_pgd error.
      asm-generic: unistd.h: fixup broken macro include.

Halil Pasic (2):
      virtio/s390: avoid race on vcdev->config
      virtio/s390: fix race in ccw_io_helper()

Hans Verkuil (3):
      media: cedrus: add action item to the TODO
      media: vicodec: fix memchr() kernel oops
      media: gspca: fix frame overflow error

Hans de Goede (1):
      i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI
device node

Harry Pan (1):
      usb: quirk: add no-LPM quirk on SanDisk Ultra Flair device

Heiner Kallweit (1):
      net: phy: don't allow __set_phy_supported to add unsupported modes

Helge Deller (1):
      parisc: Enable -ffunction-sections for modules on 32-bit kernel

Herbert Xu (1):
      crypto: user - Disable statistics interface

Hui Peng (1):
      ALSA: usb-audio: Fix UAF decrement if card has no live
interfaces in card.c

Ido Schimmel (3):
      mlxsw: spectrum_nve: Remove easily triggerable warnings
      mlxsw: spectrum_switchdev: Avoid leaking FID's reference count
      mlxsw: spectrum_switchdev: Fix VLAN device deletion via ioctl

Israel Rukshin (1):
      nvmet-rdma: fix response use after free

Jakub Audykowicz (1):
      sctp: frag_point sanity check

James Smart (1):
      nvme: validate controller state before rescheduling keep alive

James Zhu (1):
      drm/amdgpu/vcn: Update vcn.cur_state during suspend

Jasmin Jessich (1):
      media: Use wait_queue_head_t for media_request

Jason Wang (1):
      virtio-net: keep vnet header zeroed after processing XDP

Jayant Shekhar (1):
      drm/msm/dpu: Ignore alpha for XBGR8888 format

Jean-Philippe Brucker (1):
      vhost: fix IOTLB locking

Jens Axboe (2):
      blk-mq: fix corruption with direct issue
      blk-mq: punt failed direct issue to dispatch list

Jernej Skrabec (1):
      media: media-request: Add compat ioctl

Jeykumar Sankaran (1):
      drm/msm: validate display and event threads

Jiri Wiesner (1):
      ipv4: ipv6: netfilter: Adjust the frag mem limit when truesize change=
s

Joe Stringer (2):
      bpf: Support sk lookup in netns with id 0
      bpf: Improve socket lookup reuseport documentation

Johan Hovold (4):
      USB: serial: console: fix reported terminal settings
      gnss: sirf: fix activation retry handling
      MAINTAINERS: add gnss scm tree
      MAINTAINERS: exclude gnss from SIRFPRIMA2 regex matching

Johannes Berg (2):
      cfg80211/mac80211: fix FTM settings across CSA
      mac80211: fix CSA beacon allocation size

John Hurley (2):
      nfp: flower: release metadata on offload failure
      nfp: flower: prevent offload if rhashtable insert fails

Jordan Crouse (1):
      drm/msm/gpu: Don't map command buffers with nr_relocs equal to 0

Jose Abreu (1):
      ARC: io.h: Implement reads{x}()/writes{x}()

Jouni Malinen (1):
      cfg80211: Fix busy loop regression in ieee80211_ie_split_ric()

Juergen Gross (1):
      x86/boot: Clear RSDP address in boot_params for broken loaders

Juha-Matti Tilli (1):
      libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Julia Lawall (2):
      thermal: armada: constify thermal_zone_of_device_ops structure
      thermal: broadcom: constify thermal_zone_of_device_ops structure

Junwei Zhang (1):
      drm/amdgpu: update mc firmware image for polaris12 variants

Kai-Heng Feng (1):
      ALSA: hda: Add support for AMD Stoney Ridge

Kees Cook (1):
      ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE

Kevin Hilman (1):
      ARC: change defconfig defaults to ARCv2

Kunihiko Hayashi (3):
      net: ethernet: ave: Increase descriptors to improve performance
      net: ethernet: ave: Replace NET_IP_ALIGN with AVE_FRAME_HEADROOM
      net: ethernet: ave: Add MODULE_AUTHOR and MAINTAINERS entry

Kuninori Morimoto (2):
      Input: migor_ts - convert to SPDX identifiers
      Input: st1232 - convert to SPDX identifiers

Linus Torvalds (1):
      Linux 4.20-rc6

Long Li (1):
      CIFS: Avoid returning EBUSY to upper layer VFS

Lucas Stach (4):
      Revert "dmaengine: imx-sdma: Use GFP_NOWAIT for dma allocations"
      Revert "dmaengine: imx-sdma: alloclate bd memory from dma pool"
      dmaengine: imx-sdma: implement channel termination via worker
      dmaengine: imx-sdma: use GFP_NOWAIT for dma descriptor allocations

Lyude Paul (1):
      Input: synaptics - add PNP ID for ThinkPad P50 to SMBus

Macpaul Lin (1):
      kgdboc: fix KASAN global-out-of-bounds bug in param_set_kgdboc_var()

Martin KaFai Lau (1):
      tools/bpf: fix two test_btf unit test cases

Martin Schiller (3):
      net/x25: fix called/calling length calculation in x25_parse_address_b=
lock
      net/x25: fix null_x25_address handling
      net/x25: handle call collisions

Martin Wilck (1):
      scsi: lpfc: fix block guard enablement on SLI3 adapters

Masahiro Yamada (5):
      x86/build: Fix compiler support check for CONFIG_RETPOLINE
      i2c: uniphier-f: fix timeout error after reading 8 bytes
      i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
      i2c: uniphier: fix violation of tLOW requirement for Fast-mode
      i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

Masami Hiramatsu (1):
      kprobes/x86: Fix instruction patching corruption when copying
more than one RIP-relative instruction

Mathias Nyman (1):
      xhci: Prevent U1/U2 link pm states if exit latency is too long

Mathias Payer (1):
      USB: check usb_get_extra_descriptor for proper size

Matteo Croce (1):
      macvlan: return correct error value

Matthew Wilcox (3):
      dax: Check page->mapping isn't NULL
      dax: Don't access a freed inode
      dax: Fix unlock mismatch with updated API

Mauro Carvalho Chehab (3):
      media: dvb-pll: fix tuner frequency ranges
      media: dvb-pll: don't re-validate tuner frequencies
      media: mediactl docs: Fix licensing message

Michael Chan (4):
      bnxt_en: Fix CNP CoS queue regression.
      bnxt_en: Keep track of reserved IRQs.
      bnxt_en: Fix NQ/CP rings accounting on the new 57500 chips.
      bnxt_en: Fix _bnxt_get_max_rings() for 57500 chips.

Nathan Jones (1):
      ARM: 8816/1: dma-mapping: fix potential uninitialized return

Nicholas Kazlauskas (2):
      drm/amd/display: Fix unintialized max_bpc state values
      drm/amd/display: Fix overflow/truncation from strncpy.

Nick Desaulniers (1):
      x86/vdso: Drop implicit common-page-size linker flag

Nicolas Dichtel (1):
      tun: forbid iface creation with rtnl ops

Nicolas Saenz Julienne (1):
      ethernet: fman: fix wrong of_node_put() in probe function

Nir Dotan (1):
      mlxsw: spectrum_router: Relax GRE decap matching check

Noah Westervelt (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Or Gerlitz (1):
      net/sched: cls_flower: Reject duplicated rules also under skip_sw

Pan Bian (2):
      crypto: do not free algorithm before using
      liquidio: read sc->iq_no before release sc

Paolo Valente (1):
      block, bfq: fix decrement of num_active_groups

Patrick Gaskin (1):
      Input: elan_i2c - add ELAN0620 to the ACPI table

Paulo Alcantara (1):
      cifs: Fix separator when building path from dentry

Peter Shih (1):
      tty: serial: 8250_mtk: always resume the device in probe.

Prashant Bhole (1):
      tun: remove skb access after netif_receive_skb

Qian Cai (1):
      net/core: tidy up an error message

Qu Wenruo (1):
      btrfs: tree-checker: Don't check max block group size as current
max chunk size limit is unreliable

Rafael J. Wysocki (1):
      Revert "exec: make de_thread() freezable"

Rajan Vaja (1):
      clk: zynqmp: handle fixed factor param query error

Ravi Bangoria (1):
      Uprobes: Fix kernel oops with delayed_uprobe_remove()

Rob Clark (1):
      drm/msm: fix handling of cmdstream offset

Robert Foss (1):
      drm/msm: Move fence put to where failure occurs

Roman Gushchin (1):
      bpf: refactor bpf_test_run() to separate own failures and test
program result

Roman Li (1):
      drm/amd/display: Fix 6x4K displays light-up on Vega20 (v2)

Russell King (3):
      thermal: armada: fix legacy validity test sense
      thermal: armada: fix legacy resource fixup
      ARM: ensure that processor vtables is not lost after boot

Sabrina Dubroca (2):
      net: restore call to netdev_queue_numa_node_write when resetting XPS
      net: fix XPS static_key accounting

Sabyasachi Gupta (1):
      arch/sparc: Use kzalloc_node

Saeed Mahameed (1):
      net/mlx4_en: Fix build break when CONFIG_INET is off

Sam Bobroff (1):
      drm/ast: Fix connector leak during driver unload

Sandeep Panda (1):
      drm/bridge: fix AUX_CMD_SEND bit value for ti, sn65dsi86 bridge

Sandeep Singh (1):
      xhci: workaround CSS timeout on AMD SNPS 3.0 xHC

Sandipan Das (1):
      bpf: powerpc64: optimize JIT passes for bpf function calls

Sean Paul (2):
      drm/msm: Grab a vblank reference when waiting for commit_done
      drm/msm: dpu: Don't set legacy plane->crtc pointer

Sebastian Reichel (2):
      drm/omap: populate DSI platform bus earlier
      drm/omap: fix incorrect union usage

Sergey Matyukevich (1):
      cfg80211: add missing constraint for user-supplied VHT mask

Sharat Masetty (2):
      drm/msm: Check if target supports crash dump capture
      drm/msm: Fix task dump in gpu recovery

Shmulik Ladkani (1):
      ipv6: sr: properly initialize flowi6 prior passing to ip6_route_outpu=
t

Sriram R (1):
      cfg80211: Prevent regulatory restore during STA disconnect in
concurrent interfaces

Stefan Hajnoczi (2):
      vhost/vsock: fix reset orphans race with close timeout
      vhost/vsock: fix use-after-free in network stack callers

Stefan Wahren (1):
      thermal: bcm2835: Switch to SPDX identifier

Stefano Brivio (2):
      ipv6: Check available headroom in ip6_xmit() even without options
      neighbour: Avoid writing before skb->head in neigh_hh_output()

Stephen Boyd (2):
      dt-bindings: clk: Introduce 'protected-clocks' property
      clk: qcom: Support 'protected-clocks' property

Stephen Rothwell (3):
      sparc: suppress the implicit-fallthrough warning
      sparc32: suppress an implicit-fallthrough warning
      sparc32: supress another implicit-fallthrough warning

Steve French (1):
      cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure =
cifs)

Su Yanjun (1):
      net: 8139cp: fix a BUG triggered by changing mtu with network traffic

Takashi Iwai (3):
      ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
      ALSA: pcm: Fix interval evaluation with openmin/max
      ALSA: hda/realtek - Fix speaker output regression on Thinkpad T570

Tarick Bedeir (1):
      net/mlx4_core: Correctly set PFC param if global pause is turned off.

Teika Kazura (1):
      Input: synaptics - enable SMBus for HP 15-ay000

Thierry Reding (1):
      net: stmmac: Move debugfs init/exit to ->probe()/->remove()

Thomas Falcon (1):
      net/ibmvnic: Fix RTNL deadlock during device reset

Tigran Mkrtchyan (1):
      flexfiles: enforce per-mirror stateid only for v4 DSes

Todor Tomov (1):
      drm/msm/hdmi: Enable HPD after HDMI IRQ is set up

Tomi Valkeinen (1):
      drm/omap: fix bus_flags for panel-dpi

Toni Peltonen (1):
      bonding: fix 802.3ad state sent to partner when unbinding slave

Tony Das (1):
      ALSA: usb-audio: Add SMSL D1 to quirks for native DSD support

Tony Lindgren (1):
      Input: omap-keypad - fix keyboard debounce configuration

Trond Myklebust (9):
      SUNRPC: call_connect_status() must handle tasks that got transmitted
      SUNRPC: Fix a memory leak in call_encode()
      SUNRPC: Fix a potential race in xprt_connect()
      SUNRPC: Fix RPC receive hangs
      SUNRPC: Fix up handling of the XDRBUF_SPARSE_PAGES flag
      SUNRPC: Treat EFAULT as a truncated message in xs_read_stream_request=
()
      SUNRPC: Use the discard iterator rather than MSG_TRUNC
      SUNRPC: Fix up socket polling
      SUNRPC: Don't force a redundant disconnection in xs_read_stream()

Vasyl Vavrychuk (1):
      mac80211_hwsim: Timer should be initialized before device registered

Vineet Gupta (1):
      ARCv2: boot log unaligned access in use

Vitaly Kuznetsov (1):
      Input: hyper-v - fix wakeup from suspend-to-idle

Vladimir Murzin (1):
      ARM: 8815/1: V7M: align v7m_dma_inv_range() with v7 counterpart

Wei Yongjun (2):
      mac80211: fix missing unlock on error in ieee80211_mark_sta_auth()
      drm/fb-helper: Fix typo in parameter description

Wen Yang (1):
      drm/msm: Fix error return checking

Will Deacon (1):
      arm64: hibernate: Avoid sending cross-calling with interrupts disable=
d

Wolfram Sang (3):
      i2c: nvidia-gpu: adhere to I2C fault codes
      i2c: nvidia-gpu: limit reads also for combined messages
      i2c: rcar: check bus state before reinitializing

Xin Long (2):
      sctp: update frag_point when stream_interleave is set
      sctp: kfree_rcu asoc

Yan-Hsuan Chuang (1):
      mac80211: fix GFP_KERNEL under tasklet context

Yangtao Li (5):
      sbus: char: add of_node_put()
      drivers/sbus/char: add of_node_put()
      drivers/tty: add missing of_node_put()
      ide: pmac: add of_node_put()
      ide: Change to use DEFINE_SHOW_ATTRIBUTE macro

Ye Yin (1):
      fs/xfs: fix f_ffree value for statfs when project quota is set

YiFei Zhu (1):
      x86/earlyprintk/efi: Fix infinite loop on some screen widths

Yonghong Song (4):
      bpf: btf: implement btf_name_valid_identifier()
      bpf: btf: check name validity for various types
      tools/bpf: add addition type tests to test_btf
      tools: bpftool: fix a bitfield pretty print issue

Yoshihiro Shimoda (2):
      net: phy: Fix not to call phy_resume() if PHY is not attached
      net: phy: micrel: add toggling phy reset if PHY is not attached

Young Xiao (2):
      staging: rtl8712: Fix possible buffer overrun
      Revert commit ef9209b642f "staging: rtl8723bs: Fix indenting
errors and an off-by-one mistake in core/rtw_mlme_ext.c"

Yuchung Cheng (4):
      tcp: fix off-by-one bug on aborting window-probing socket
      tcp: fix SNMP under-estimation on failed retransmission
      tcp: fix SNMP TCP timeout under-estimation
      tcp: fix NULL ref in tail loss probe

YueHaibing (2):
      drm/msm/hdmi: Drop pointless static qualifier in msm_hdmi_bind()
      drm/msm: dpu: Fix "WARNING: invalid free of devm_ allocated data"

tianci yin (1):
      drm/amd/powerplay: improve OD code robustness

wentalou (1):
      drm/amdgpu: enlarge maximum waiting time of KIQ
