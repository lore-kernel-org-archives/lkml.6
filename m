Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeCYXhx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 19:37:53 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35283 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeCYXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 19:37:50 -0400
X-Google-Smtp-Source: AG47ELtdm70yRKf75SE5xCHqJgaYMBbG9egjBHysuohdWr3Pu5KChrn/aDePD6b0bSInK+YMSgClsYhafvAyLeBLCHo=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Mar 2018 13:37:47 -1000
X-Google-Sender-Auth: ZbqZi0GkkedZm8j0r8ElPxf1ni4
Message-ID: <CA+55aFxpxHnWBeTXN+DKqwCMW_=T2cR8UxSBVk_6c8LL7Et5JQ@mail.gmail.com>
Subject: Linux 4.16-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2PNc38p026624

So after a couple of pretty small rc's, rc7 is much too big for my
taste.  By this time in the release, things should have calmed down
more than they apparently have.

That said, I do blame most of it on the timing variation, notably how
rc6 didn't have any networking updates in it, and the rc5 network pull
was right after the rc4 release. As a result, we have 2.5 weeks worth
of networking stuff, and that makes rc7 look artificially bigger.

That's my story, and I'm sticking to it.

Well, I'm sticking to it at least for now.  I'm still not *planning*
on an rc8 this release, because while rc7 is bigger than usual,
nothing in here makes me go "Hmm, maybe we should delay the release".
But let's see what happens this upcoming week - if next Sunday comes
around, and there's lots of new stuff, I'll reconsider then.

Anyway, rc7 may be about 45% networking, but there's certainly other
things in there  too. There's the usual driver updates: while
networking is a bulk of it on that side too, we also have gpu,
pinctrl, rdma, iio, and misc other fixes.

Outside of drivers and networking it's a mix of things -
Documentation, arch updates (mainly x86, but some mips noise too),
some mm fixes, selftests, and misc random things.

It may be larger than I'd like for an rc7, but it's certainly not
huge, and most of the fixes themselves are very small. In fact, one of
the larger patches in there  is just removing support for  the old x86
PPro SMP memory ordering errata workaround that nobody should use
anyway. I guess it's not strictly the right time for random cleanups
like that, but it's not like it can hurt either. Those old
multi-socket PPro systems are some museum quality stuff, you should
probably run a properly ancient kernel on them too, just to have the
authentic experience.

(Ok, the actual _largest_ patch in there is a fix for hyperv network
device detach events, but the Ppro one happened to jump out at me).

Random git trick of the day, in case people are wondering what I tend
to use when summarizing these weekly rc releases:

 (a) scanning through the shortlog that I also append:

        git shortlog --no-merges v4.16-rc6..v4.16-rc7

 (b) just counting commits

        git rev-list --count --no-merges v4.16-rc6..v4.16-rc7

 (c) "dirstat":

        git diff -M --dirstat=2,cumulative v4.16-rc6..v4.16-rc7 --
:^{drivers/net,net}/

     does a dirstat of what happened between rc6 and rc7, in this case
ignoring the networking changes (ie the above was "ok, networking
changes dominate, let's see what the stats look like when you take
them away).

     The "cumulative" means "accumulate stats from deeper
subdirectories in the parent directory", and the "2" just changes the
cut-off for reporting from the default 3% to 2% of the total diff.

     Note that the path-based limiting works for the  commit counting
and shortlog too, and I often use that in addition to the dirstat to
judge how much of the work happened in some particular area.

 (d) "numstat"

        git log -M --oneline --numstat --no-merges v4.16-rc6..v4.16-rc7

     This just shows each (non-merge) commit as a single line with the
dense "numstat" format (like a diffstat, but I find it easier to scan
through when the numbers all line up)

There's nothing magical about any of the above, it's just what I end
up being used to (and I wrote "diffstat" exactly because I find it
useful and used to try to estimate it visually from the more
traditional "diffstat" output). Maybe people thought I actually know
everything that is going on - no, I just use git to tell me.

Now you too can be a top-level maintainer and summarize what is going
on in a project (although honestly, the directory-based summaries tend
to work better on the kernel than they do on most other projects I've
seen - lots of projects tend to have more or a "src/ vs tests/" kind
of directory structure, and the path-based filtering may not be as
useful for those kinds of things).

Anyway. Go out and test. And let's hope next week is nice and calm and
I can release the final 4.16 next Sunday without any extra  rc's.

               Linus

---

Adrian Hunter (2):
      mmc: core: Fix tracepoint print of blk_addr and blksz
      mmc: sdhci-acpi: Fix IRQ 0

Aishwarya Pant (2):
      libata: transport: cleanup documentation of sysfs interface
      libata: update documentation for sysfs interfaces

Alex Williamson (1):
      Revert: "vfio-pci: Mask INTx if a device is not capabable of enabling it"

Alexander Potapenko (1):
      vhost_net: initialize rx_ring in vhost_net_open()

Alexey Kodanev (2):
      sch_netem: fix skb leak in netem_enqueue()
      dccp: check sk for closed state in dccp_sendmsg()

Andrei Otcheretianski (1):
      iwlwifi: mvm: Fix channel switch for count 0 and 1

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix binding documentation for MDIO busses

Andrew Zaborowski (1):
      mac80211_hwsim: Set wmediumd for new radios

Andrey Ryabinin (1):
      mm/vmscan: wake up flushers for legacy cgroups too

Andri Yngvason (3):
      can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
      can: cc770: Fix queue stall & dropped RTR reply
      can: cc770: Fix use after free in cc770_tx_interrupt()

Andy Lutomirski (2):
      selftests/x86/ptrace_syscall: Fix for yet more glibc interference
      x86/entry/64: Don't use IST entry for #BP stack

Arend Van Spriel (2):
      brcmfmac: add possibility to obtain firmware error
      brcmfmac: fix P2P_DEVICE ethernet address generation

Arkadi Sharshevsky (2):
      team: Fix double free in error path
      devlink: Remove redundant free on error path

Arnd Bergmann (4):
      infiniband: qplib_fp: fix pointer cast
      infiniband: bnxt_re: use BIT_ULL() for 64-bit bit masks
      gpu: ipu-v3: prg: avoid possible array underflow
      h8300: remove extraneous __BIG_ENDIAN definition

Arvind Yadav (2):
      workqueue: use put_device() instead of kfree()
      net/iucv: Free memory obtained by kzalloc

Baruch Siach (1):
      ata: libahci: fix comment indentation

Bastian Stender (1):
      mmc: block: fix updating ext_csd caches on ioctl call

Ben Caradoc-Davies (1):
      mac80211: add ieee80211_hw flag for QoS NDP support

Benjamin Poirier (7):
      e1000e: Remove Other from EIAC
      Partial revert "e1000e: Avoid receiver overrun interrupt bursts"
      e1000e: Fix queue interrupt re-raising in Other interrupt
      e1000e: Avoid missed interrupts following ICR read
      e1000e: Fix check_for_link return value with autoneg off
      Revert "e1000e: Separate signaling for link check/link up"
      e1000e: Fix link check race condition

Bich HEMON (1):
      can: m_can: select pinctrl state in each suspend/resume function

Boris Brezillon (2):
      clk: bcm2835: Fix ana->maskX definitions
      clk: bcm2835: Protect sections updating shared registers

Boris Ostrovsky (1):
      x86/vsyscall/64: Use proper accessor to update P4D entry

Boris Pismenny (2):
      IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq
      IB/mlx5: Fix integer overflows in mlx5_ib_create_srq

Brad Mouring (1):
      net: phy: Tell caller result of phy_change()

Camelia Groza (3):
      dpaa_eth: remove duplicate initialization
      dpaa_eth: increment the RX dropped counter when needed
      dpaa_eth: remove duplicate increment of the tx_errors counter

Cathy Zhou (1):
      sunvnet: does not support GSO for sctp

Chen-Yu Tsai (1):
      clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops

Chenbo Feng (1):
      bpf: skip unnecessary capability check

Chris Wilson (1):
      drm/i915: Specify which engines to reset following semaphore/event lockups

Christoph Hellwig (1):
      x86/cpu: Remove the CONFIG_X86_PPRO_FENCE=y quirk

Christophe JAILLET (4):
      drm/sun4i: Fix an error handling path in 'sun4i_drv_bind()'
      drm/sun4i: hdmi: Fix an error handling path in 'sun4i_hdmi_bind()'
      drm/sun4i: hdmi: Fix another error handling path in 'sun4i_hdmi_bind()'
      net: ethernet: arc: Fix a potential memory leak if an optional
regulator is deferred

Clark Zheng (1):
      drm/amd/display: Refine disable VGA

Colin Ian King (3):
      libnvdimm: remove redundant assignment to pointer 'dev'
      bnx2x: fix spelling mistake: "registeration" -> "registration"
      qede: fix spelling mistake: "registeration" -> "registration"

Dan Carpenter (5):
      iio: adc: meson-saradc: unlock on error in meson_sar_adc_lock()
      qed: Use after free in qed_rdma_free()
      staging: ncpfs: memory corruption in ncp_read_kernel()
      perf/x86/intel: Don't accidentally clear high bits in bdw_limit_period()
      macsec: missing dev_put() on error in macsec_newlink()

Dan Williams (4):
      x86, memremap: fix altmap accounting at free
      acpi, numa: fix pxm to online numa node associations
      libnvdimm, region: hide persistence_domain when unknown
      libnvdimm, nfit: fix persistence domain reporting

Daniel Axtens (3):
      bpf: fix bpf_skb_adjust_net/bpf_skb_proto_xlat to deal with gso sctp skbs
      docs: segmentation-offloads.txt: Correct TCP gso_types
      net: use skb_is_gso_sctp() instead of open-coding

Daniel Borkmann (2):
      bpf, x64: increase number of passes
      kbuild: disable clang's default use of -fmerge-all-constants

Daniel Drake (1):
      Revert "ACPI / battery: Add quirk for Asus GL502VSK and UX305LA"

Daniel Stone (1):
      drm: Reject getfb for multi-plane framebuffers

Daniel Vacek (1):
      Revert "mm: page_alloc: skip over regions of invalid pfns where possible"

David Ahern (2):
      net: Only honor ifindex in IP_PKTINFO if non-0
      net/ipv6: Handle onlink flag with multipath routes

David Lebrun (2):
      ipv6: sr: fix scheduling in RCU when creating seg6 lwtunnel state
      ipv6: sr: fix NULL pointer dereference when setting encap source address

David Rientjes (1):
      mm, thp: do not cause memcg oom for thp

Davide Caratti (12):
      net/sched: fix NULL dereference in the error path of tcf_vlan_init()
      net/sched: fix NULL dereference in the error path of tcf_csum_init()
      net/sched: fix NULL dereference in the error path of tunnel_key_init()
      net/sched: fix NULL dereference in the error path of tcf_sample_init()
      net/sched: fix NULL dereference on the error path of tcf_skbmod_init()
      net/sched: fix idr leak on the error path of tcf_bpf_init()
      net/sched: fix idr leak in the error path of tcf_simp_init()
      net/sched: fix idr leak in the error path of tcf_act_police_init()
      net/sched: fix idr leak in the error path of tcp_pedit_init()
      net/sched: fix idr leak in the error path of __tcf_ipt_init()
      net/sched: fix idr leak in the error path of tcf_vlan_init()
      net/sched: fix idr leak in the error path of tcf_skbmod_init()

Denis Kirjanov (1):
      fsl/fman: avoid sleeping in atomic context while adding an address

Dennis Zhou (3):
      percpu: match chunk allocator declarations with definitions
      percpu: add __GFP_NORETRY semantics to the percpu balancing path
      percpu: allow select gfp to be passed to underlying allocators

Dhinakaran Pandiyan (1):
      drm/i915/dp: Write to SET_POWER dpcd to enable MST hub.

Dirk Behme (1):
      mmc: core: Disable HPI for certain Micron (Numonyx) eMMC cards

Dmitry Osipenko (1):
      drm/tegra: plane: Correct legacy blending

Dong Bo (1):
      libata: Fix compile warning with ATA_DEBUG enabled

Eddie James (2):
      clk: aspeed: Fix is_enabled for certain clocks
      clk: aspeed: Prevent reset if clock is enabled

Eddie Wai (1):
      bnxt_en: Fix vnic accounting in the bnxt_check_rings() path.

Emmanuel Grumbach (1):
      iwlwifi: pcie: don't warn if we use all the transmit pointers

Eric Biggers (3):
      libata: fix length validation of ATAPI-relayed SCSI commands
      libata: remove WARN() for DMA or PIO command without data
      libata: don't try to pass through NCQ commands to non-NCQ devices

Eric Dumazet (6):
      percpu: add a schedule point in pcpu_balance_workfn()
      net: usbnet: fix potential deadlock on 32bit hosts
      l2tp: do not accept arbitrary sockets
      ieee802154: 6lowpan: fix possible NULL deref in lowpan_device_event()
      net: use skb_to_full_sk() in skb_update_prio()
      net: sched: fix uses after free

Eric W. Biederman (1):
      Revert "mqueue: switch to on-demand creation of internal mount"

Evgeniy Didin (2):
      mmc: dw_mmc: Fix the DTO/CTO timeout overflow calculation for
32-bit systems
      mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occurs

Fabio Estevam (3):
      clk: imx51-imx53: Fix UART4/5 registration on i.MX50 and i.MX53
      drm/imx: ipuv3-plane: Make functions static when possible
      drm/imx: ipuv3-plane: Include "imx-drm.h" header file

Fabrice Gasnier (5):
      iio: adc: stm32-dfsdm: fix compatible data use
      iio: adc: stm32-dfsdm: fix call to stop channel
      iio: adc: stm32-dfsdm: fix clock source selection
      iio: adc: stm32-dfsdm: fix multiple channel initialization
      dt-bindings: iio: adc: sd-modulator: fix io-channel-cells

Florian Fainelli (8):
      net: dsa: b53: Use strlcpy() for ethtool::get_strings
      net: phy: marvell: Use strlcpy() for ethtool::get_strings
      net: phy: micrel: Use strlcpy() for ethtool::get_strings
      net: phy: broadcom: Use strlcpy() for ethtool::get_strings
      net: dsa: Fix dsa_is_user_port() test inversion
      net: systemport: Rewrite __bcm_sysport_tx_reclaim()
      net: fec: Fix unbalanced PM runtime calls
      net: dsa: Fix functional dsa-loop dependency on FIXED_PHY

Florian Westphal (4):
      xfrm_user: uncoditionally validate esn replay attribute struct
      netfilter: ebtables: fix erroneous reject of last rule
      netfilter: x_tables: add and use xt_check_proc_name
      netfilter: bridge: ebt_among: add more missing match size checks

Ganesh Goudar (2):
      cxgb4: copy adap index to PF0-3 adapter instances
      cxgb4: do not set needs_free_netdev for mgmt dev's

Geert Uytterhoeven (2):
      ata: sata_rcar: Remove unused variable in sata_rcar_init_controller()
      dt-bindings: net: renesas-ravb: Make stream buffer optional

Greg Hackmann (1):
      net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Greg Kroah-Hartman (1):
      drm: udl: Properly check framebuffer mmap offsets

Grygorii Strashko (2):
      sysfs: symlink: export sysfs_create_link_nowarn()
      net: phy: relax error checking when creating sysfs link netdev->phydev

Guillaume Nault (1):
      ppp: avoid loop in xmit recursion detection code

H.J. Lu (2):
      x86/build/64: Force the linker to use 2MB page size
      x86/boot/64: Verify alignment of the LOAD segment

Haim Dreyfuss (1):
      iwlwifi: Cancel and set MARKER_CMD timer during suspend-resume

Hans Verkuil (1):
      media: tegra-cec: reset rx_buf_cnt when start bit detected

Hans de Goede (9):
      libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
      Bluetooth: btusb: Remove Yoga 920 from the btusb_needs_reset_resume_table
      ahci: Add PCI-id for the Highpoint Rocketraid 644L card
      PCI: Add function 1 DMA alias quirk for Highpoint RocketRAID 644L
      Revert "Bluetooth: hci_bcm: Streamline runtime PM code"
      Bluetooth: hci_bcm: Set pulsed_host_wake flag in sleep parameters
      libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
      libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions
      libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version

Harry Wentland (2):
      drm/amd/display: We shouldn't set format_default on plane as atomic driver
      drm/amd/display: Add one to EDID's audio channel count when passing to DC

Hemanth Puranik (1):
      net: qcom/emac: Use proper free methods during TX

Himanshu Madhani (1):
      scsi: qla2xxx: Remove FC_NO_LOOP_ID for FCP and FC-NVMe Discovery

Ido Schimmel (1):
      mlxsw: spectrum_buffers: Set a minimum quota for CPU port traffic

Igor Pylypiv (2):
      vmxnet3: remove unused flag "rxcsum" from struct vmxnet3_adapter
      net: gemini: fix memory leak

Igor Russkikh (7):
      net: aquantia: Fix hardware reset when SPI may rarely hangup
      net: aquantia: Fix a regression with reset on old firmware
      net: aquantia: Change inefficient wait loop on fw data reads
      net: aquantia: Add tx clean budget and valid budget handling logic
      net: aquantia: Allow live mac address changes
      net: aquantia: Implement pci shutdown callback
      net: aquantia: driver version bump

Ilan Peer (2):
      iwlwifi: mvm: Direct multicast frames to the correct station
      iwlwifi: mvm: Correctly set the tid for mcast queue

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: fix the suspend/resume issue for exynos5433

Jagdish Gediya (3):
      mtd: nand: fsl_ifc: Fix nand waitfunc return value
      mtd: nand: fsl_ifc: Fix eccstat array overflow for IFC ver >= 2.0.0
      mtd: nand: fsl_ifc: Read ECCSTAT0 and ECCSTAT1 registers for IFC 2.0

Jason Wang (2):
      vhost_net: keep private_data and rx_ring synced
      vhost_net: examine pointer types during un-producing

Jason Yan (2):
      ata: do not schedule hot plug if it is a sas host
      scsi: libsas: defer ata device eh commands to libata

Jeff Layton (1):
      nfsd: remove blocked locks on client teardown

Jeremy Linton (1):
      net: smsc911x: Fix unload crash when link is up

Jerome Brunet (2):
      clk: migrate the count of orphaned clocks at init
      clk: fix determine rate error with pass-through clock

Jiri Benc (1):
      tools: bpftool: fix compilation with older headers

Jiri Pirko (1):
      mlxsw: spectrum: Fix gact_ok offloading

Joe Lawrence (2):
      sched/debug: Fix per-task line continuation for console output
      sched/debug: Adjust newlines for better alignment

Johannes Berg (1):
      ath9k_htc: use non-QoS NDP for AP probing

Jonathan Cameron (1):
      Revert "iio: accel: st_accel: remove redundant pointer pdata"

Jonathan Toppins (1):
      tg3: prevent scheduling while atomic splat

Josh Poimboeuf (1):
      jump_label: Disable jump labels in __exit code

Ju Hyung Park (1):
      libata: Enable queued TRIM for Samsung SSD 860

Julian Wiedmann (4):
      s390/qeth: free netdevice when removing a card
      s390/qeth: when thread completes, wake up all waiters
      s390/qeth: lock read device while queueing next buffer
      s390/qeth: on channel error, reject further cmd requests

Kai-Heng Feng (2):
      libata: disable LPM for Crucial BX100 SSD 500GB drive
      Bluetooth: btusb: Add Dell OptiPlex 3060 to btusb_needs_reset_resume_table

Kailang Yang (2):
      ALSA: hda/realtek - Fix Dell headset Mic can't record
      ALSA: hda/realtek - Fix speaker no sound after system resume

Kan Liang (3):
      perf/x86/intel: Disable userspace RDPMC usage for large PEBS
      perf/x86/intel: Rename confusing 'freerunning PEBS' API and
implementation to 'large PEBS'
      perf/x86/intel/uncore: Fix multi-domain PCI CHA enumeration bug
on Skylake servers

Kevin Hao (3):
      net: phy: Add general dummy stubs for MMD register access
      net: phy: realtek: Use the dummy stubs for MMD register access
for rtl8211b
      net: phy: micrel: Use the general dummy stubs for MMD register access

Khiem Nguyen (1):
      sata_rcar: Reset SATA PHY when Salvator-X board resumes

Kirill A. Shutemov (3):
      mm/khugepaged.c: convert VM_BUG_ON() to collapse fail
      mm/thp: do not wait for lock_page() in deferred_split_scan()
      mm/shmem: do not wait for lock_page() in shmem_unused_huge_shrink()

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit

Kirill Tkhai (2):
      net: Fix hlist corruptions in inet_evict_bucket()
      mm: Allow to kill tasks doing pcpu_alloc() and waiting for
pcpu_balance_workfn()

Krzysztof Kozlowski (1):
      pinctrl: samsung: Validate alias coming from DT

Kunihiko Hayashi (1):
      net: ethernet: ave: enable Rx drop interrupt

Larry Finger (1):
      rtlwifi: rtl8723be: Fix loss of signal

Leon Romanovsky (7):
      RDMA/mlx5: Fix crash while accessing garbage pointer and freed memory
      RDMA/ucma: Fix access to non-initialized CM_ID object
      RDMA/ucma: Don't allow join attempts for unsupported AF family
      RDMA/ucma: Check AF family prior resolving address
      RDMA/ucma: Fix use-after-free access in ucma_close
      RDMA/verbs: Remove restrack entry from XRCD structure
      RDMA/ucma: Ensure that CM_ID exists prior to access it

Leon Yu (1):
      module: propagate error in modules_open()

Linus Lüssing (1):
      batman-adv: Fix multicast packet loss with a single WANT_ALL_IPV4/6 flag

Linus Torvalds (3):
      kvm/x86: fix icebp instruction handling
      tty: vt: fix up tabstops properly
      Linux 4.16-rc7

Lorenzo Bianconi (1):
      ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_option()

Lucas Stach (1):
      drm/imx: move arming of the vblank event to atomic_flush

Madalin Bucur (2):
      soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
      dpaa_eth: fix error in dpaa_remove()

Marek Vasut (2):
      can: ifi: Check core revision upon probe
      can: ifi: Repair the error handling

Mark Bloch (1):
      IB/mlx5: Fix cleanup order on unload

Mark Fasheh (1):
      MAINTAINERS: update Mark Fasheh's e-mail

Masami Hiramatsu (5):
      error-injection: Fix to prohibit jump optimization
      tracing: probeevent: Fix to support minus offset from symbol
      selftests: ftrace: Add probe event argument syntax testcase
      selftests: ftrace: Add a testcase for string type with kprobe_event
      selftests: ftrace: Add a testcase for probepoint

Mathias Kresin (3):
      MIPS: lantiq: Fix Danube USB clock
      MIPS: lantiq: Enable AHB Bus for USB
      MIPS: lantiq: ase: Enable MFD_SYSCON

Matthew Wilcox (1):
      locking/mutex: Improve documentation

Matthias Brugger (1):
      net: hns: Fix ethtool private flags

Matthias Schiffer (2):
      batman-adv: update data pointers after skb_cow()
      batman-adv: fix header size check in batadv_dbg_arp()

Michael Chan (4):
      bnxt_en: Refactor the functions to reserve hardware rings.
      bnxt_en: Pass complete VLAN TCI to the stack.
      bnxt_en: Fix regressions when setting up MQPRIO TX rings.
      bnxt_en: Check valid VNIC ID in bnxt_hwrm_vnic_set_tpa().

Michael Ira Krufky (1):
      media: dvb: fix a Kconfig typo

Michael Kelley (1):
      Drivers: hv: vmbus: Fix ring buffer signaling

Michael Nosthoff (1):
      iio: st_pressure: st_accel: pass correct platform data to init

Michal Kalderon (4):
      qed: Free RoCE ILT Memory on rmmod qedr
      qed: Fix MPA unalign flow in case header is split across two packets.
      qed: Fix non TCP packets should be dropped on iWARP ll2 connection
      qede: Fix qedr link update

Michel Dänzer (1):
      drm/radeon: Don't turn off DP sink when disconnected

Mike Kravetz (1):
      hugetlbfs: check for pgoff value overflow

Mikita Lipski (3):
      drm/amdgpu: Use atomic function to disable crtcs with dc enabled
      drm/amd/display: Allow truncation to 10 bits
      drm/amd/display: Fix FMT truncation programming

Naftali Goldstein (1):
      iwlwifi: mvm: always init rs with 20mhz bandwidth rates

NeilBrown (2):
      MIPS: ralink: Remove ralink_halt()
      MIPS: ralink: Fix booting on MT7621

Nicolas Dichtel (1):
      netlink: avoid a double skb free in genlmsg_mcast()

Niklas Söderlund (1):
      pinctrl: sh-pfc: r8a7795: remove duplicate of CLKOUT pin in pinmux_pins[]

Oliver O'Halloran (1):
      kernel/memremap: Remove stale devres_free() call

Ondrej Jirman (1):
      drm/sun4i: Fix exclusivity of the TCON clocks

OuYang ZhiZhong (1):
      mtdchar: fix usage of mtd_ooblayout_ecc()

Pablo Neira Ayuso (2):
      netfilter: nft_set_hash: skip fixed hash if timeout is specified
      netfilter: nf_tables: release flowtable hooks

Paolo Abeni (2):
      net: ipv6: keep sk status consistent after datagram connect failure
      l2tp: fix races with ipv4-mapped ipv6 addresses

Paul Blakey (2):
      rhashtable: Fix rhlist duplicates insertion
      test_rhashtable: add test case for rhltable with duplicate objects

Paul Moore (1):
      net: don't unnecessarily load kernel modules in dev_ioctl()

Petr Machata (1):
      mlxsw: spectrum: Prevent duplicate mirrors

Pierre-Yves Kerbrat (1):
      e1000e: allocate ring descriptors with dma_zalloc_coherent

Pierre-Yves MORDRET (1):
      dmaengine: stm32-dmamux: fix a potential buffer overflow

Randy Dunlap (1):
      ethernet: natsemi: correct spelling

Richard Lai (1):
      iio: chemical: ccs811: Corrected firmware boot/application mode transition

Roman Mashak (1):
      net sched actions: return explicit error when tunnel_key mode is
not specified

Ronak Doshi (2):
      vmxnet3: avoid xmit reset due to a race in vmxnet3
      vmxnet3: use correct flag to indicate LRO feature

SZ Lin (林上智) (1):
      net: ethernet: ti: cpsw: add check for in-band mode setting with
RGMII PHY interface

Sabrina Dubroca (1):
      ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu

Sara Sharon (5):
      iwlwifi: mvm: fix security bug in PN checking
      iwlwifi: mvm: fix IBSS for devices that support station type API
      iwlwifi: mvm: fix TX of CCMP 256
      iwlwifi: mvm: fix assert 0x2B00 on older FWs
      iwlwifi: mvm: fix "failed to remove key" message

Sean Young (1):
      media: rc: lirc does not use LIRC_CAN_SEND_SCANCODE feature

Shannon Nelson (1):
      macvlan: filter out unsupported feature flags

Shaul Triebitz (2):
      iwlwifi: align timestamp cancel with timestamp start
      iwlwifi: avoid collecting firmware dump if not loaded

Shawn Lin (1):
      clk: update cached phase to respect the fact when setting phase

Shirish S (1):
      drm/amd/display: fix dereferencing possible ERR_PTR()

Soheil Hassas Yeganeh (1):
      tcp: purge write queue upon aborting the connection

Song Liu (1):
      perf/cgroup: Fix child event counting bug

Sriharsha Basavapatna (1):
      bnxt_en: Remove unwanted ovs-offload messages in some conditions

Stefan Roese (1):
      ahci: Add check for device presence (PCIe hot unplug) in
ahci_stop_engine()

Stefano Brivio (2):
      ipv6: Reflect MTU changes on PMTU of exceptions for MTU-less routes
      ipv6: old_dport should be a __be16 in __ip6_datagram_connect()

Steffen Klassert (4):
      xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems
      xfrm: Fix policy hold queue after flowcache removal.
      xfrm: Fix infinite loop in xfrm_get_dst_nexthop with transport mode.
      xfrm: Fix ESN sequence number handling for IPsec GSO packets.

Stephane Eranian (1):
      perf/x86/intel/uncore: Add missing filter constraint for SKX CHA event

Stephane Grosjean (2):
      can: peak/pcie_fd: fix echo_skb is occupied! bug
      can: peak/pcie_fd: remove useless code when interface starts

Stephen Hemminger (9):
      hv_netvsc: fix filter flags
      hv_netvsc: avoid repeated updates of packet filter
      hv_netvsc: fix locking for rx_mode
      hv_netvsc: fix locking during VF setup
      workqueue: remove unused cancel_work()
      hv_netvsc: disable NAPI before channel close
      hv_netvsc: use RCU to fix concurrent rx and queue changes
      hv_netvsc: change GPAD teardown order on older versions
      hv_netvsc: common detach logic

Sven Eckelmann (2):
      batman-adv: Add missing include for EPOLL* constants
      batman-adv: Fix skbuff rcsum on packet reroute

Sylwester Nawrocki (1):
      dt-bindings: exynos: Document #sound-dai-cells property of the HDMI node

Szymon Janc (1):
      Bluetooth: Fix missing encryption refresh on Security Request

Takashi Iwai (6):
      Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174
      ALSA: hda/realtek - Always immediately update mute LED with pin VREF
      ACPI / watchdog: Fix off-by-one error at resource assignment
      ALSA: hda - Force polling mode on CFL for fixing codec communication
      ALSA: aloop: Sync stale timer before release
      ALSA: aloop: Fix access to not-yet-ready substream via cable

Tatyana Nikolova (1):
      RDMA/core: Do not use invalid destination in determining port reuse

Tejun Heo (5):
      sched, cgroup: Don't reject lower cpu.max on ancestors
      percpu: add Dennis Zhou as a percpu co-maintainer
      cgroup: fix rule checking for threaded mode switching
      percpu: include linux/sched.h for cond_resched()
      percpu_ref: Update doc to dissuade users from depending on
internal RCU grace periods

Tero Kristo (3):
      clk: ti: clkctrl: add support for CLK_SET_RATE_PARENT flag
      clk: ti: am33xx: add set-rate-parent support for display clkctrl clock
      clk: ti: am43xx: add set-rate-parent support for display clkctrl clock

Tetsuo Handa (1):
      lockdep: fix fs_reclaim warning

Thadeu Lima de Souza Cascardo (1):
      test_bpf: Fix testing with CONFIG_BPF_JIT_ALWAYS_ON=y on other arches

Thierry Reding (4):
      drm/tegra: plane: Fix RGB565 format on older Tegra
      drm/tegra: dc: Detach IOMMU group from domain only once
      drm/tegra: dsi: Don't disable regulator on ->exit()
      drm/tegra: Shutdown on driver unbind

Thomas Gleixner (1):
      posix-timers: Protect posix clock array access against speculation

Thomas Hellstrom (2):
      drm/vmwgfx: Fix black screen and device errors when running without fbdev
      drm/vmwgfx: Fix a destoy-while-held mutex problem.

Tom Herbert (1):
      kcm: lock lower socket in kcm_attach

Toshi Kani (2):
      mm/vmalloc: add interfaces to free unmapped page table
      x86/mm: implement free pmd/pte page interfaces

Toshiaki Makita (2):
      net: Fix vlan untag for bridge and vlan_dev with reorder_hdr off
      vlan: Fix out of order vlan headers with reorder header off

Ulf Magnusson (1):
      iwlwifi: fix malformed CONFIG_IWLWIFI_PCIE_RTPM default

Ursula Braun (1):
      net/smc: simplify wait when closing listen socket

Venkat Duvvuru (2):
      bnxt_en: Return standard Linux error codes for hwrm flow cmds.
      bnxt_en: close & open NIC, only when the interface is in running state.

Vinicius Costa Gomes (1):
      skbuff: Fix not waking applications when errors are enqueued

Vishal Verma (1):
      libnvdimm, {btt, blk}: do integrity setup before add_disk()

Waiman Long (1):
      x86/efi: Free efi_pgd with free_pages()

Wei Yongjun (2):
      clk: hisilicon: hi3660：Fix potential NULL dereference in
hi3660_stub_clk_probe()
      clk: qcom: msm8916: Fix return value check in
qcom_apcs_msm8916_clk_probe()

William Tu (3):
      ip6gre: add erspan v2 to tunnel lookup
      ip6erspan: improve error handling for erspan version number.
      ip6erspan: make sure enough headroom at xmit.

Wolfram Sang (1):
      can: m_can: change comparison to bitshift when dealing with a mask

Xin Long (3):
      xfrm: reuse uncached_list to track xdsts
      xfrm: do not call rcu_read_unlock when afinfo is NULL in xfrm_get_tos
      sock_diag: request _diag module only when the family or proto
has been registered

Y.C. Chen (1):
      drm/ast: Fixed 1280x800 Display Issue

Yisheng Xie (1):
      mm/mempolicy.c: avoid use uninitialized preferred_node

Yonghong Song (1):
      trace/bpf: remove helper bpf_perf_prog_read_value from
tracepoint type programs

Yossi Kuperman (1):
      xfrm: Verify MAC header exists before overwriting eth_hdr(skb)->h_proto

zhangliping (1):
      openvswitch: meter: fix the incorrect calculation of max delta_t
