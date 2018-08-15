Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FC8C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5521581
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE5521581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeHONRB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:17:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:10504 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeHONRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:17:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 03:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,242,1531810800"; 
   d="scan'208";a="81529880"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2018 03:25:22 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Paul Wise <pabs3@bonedaddy.net>
Cc:     Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: linux: REGRESSION: drm: cmdline EDID override mechanisms broken since 4.15
In-Reply-To: <4eea367179f91d3e60d1405c54befec7958e5c0f.camel@bonedaddy.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <4eea367179f91d3e60d1405c54befec7958e5c0f.camel@bonedaddy.net>
Date:   Wed, 15 Aug 2018 13:25:15 +0300
Message-ID: <87h8jw7wqc.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2018, Paul Wise <pabs3@bonedaddy.net> wrote:
> Hi all,
>
> I noticed that the drm cmdline EDID override mechanisms no longer work
> since Linux version 4.15.

Please file a bug over at [1], describe the symptomps of how it doesn't
work (black screen, wrong mode, what?), add drm.debug=14 module
parameter, attach dmesg for before/after the bisected commit.

Does adding video=VGA-1:e parameter make a difference?

Thanks,
Jani.

[1] https://bugs.freedesktop.org/enter_bug.cgi?product=DRI&component=DRM/Intel

>
> My monitor lost its VGA EDID a long time ago, so I retrieved a copy of
> it from backups of Xorg logs and I have to use the Linux kernel's EDID
> override mechanisms. In order to get the right mode early in boot,
> I use the Linux kernel cmdline option for this and put the required
> firmware file into the initramfs so my cryptsetup prompt is right:
>
> drm_kms_helper.edid_firmware=VGA-1:edid/VGA-1
>
> Linux 4.15 deprecates this option:
>
> kernel: [drm] drm_kms_firmware.edid_firmware is deprecated, please use drm.edid_firmware intead.
>
> So I switched to the new option:
>
> drm.edid_firmware=VGA-1:edid/VGA-1
>
> This did not produce any warnings or errors in dmesg but also did not
> result in the EDID override file being applied.
>
> I added both the override options to the Linux kernel command-line in
> grub and this did not work in the newer versions of Linux.
>
> I also tried this without the VGA-1: connector specifier and this did
> not improve the situation but did prevent the LVDS screen from working:
>
> drm.edid_firmware=edid/VGA-1 drm_kms_helper.edid_firmware=edid/VGA-1
>
> I tested the Debian Linux kernel builds on snapshot.debian.org and
> version 4.15~rc5-1~exp1 came up as the first broken one.
>
> I confirmed that overrides do not work with the latest Linux kernel
> version in Debian buster (4.17.8-1).
>
> I then git bisected the issue and came up with 53fd40a90f3c as bad.
> I also checked that the following commit ac6c35a4d8c7 was also bad.
>
> https://wiki.debian.org/DebianKernel/GitBisect
>
> 53fd40a90f3c0bdad86ec266ee5df833f54ace39 is the first bad commit
> commit 53fd40a90f3c0bdad86ec266ee5df833f54ace39
> Author: Jani Nikula <jani.nikula@intel.com>
> Date:   Tue Sep 12 11:19:26 2017 +0300
>
>     drm: handle override and firmware EDID at drm_do_get_edid() level
>     
>     Handle debugfs override edid and firmware edid at the low level to
>     transparently and completely replace the real edid. Previously, we
>     practically only used the modes from the override EDID, and none of the
>     other data, such as audio parameters.
>     
>     This change also prevents actual EDID reads when the EDID is to be
>     overridden, but retains the DDC probe. This is useful if the reason for
>     preferring override EDID are problems with reading the data, or
>     corruption of the data.
>     
>     Move firmware EDID loading from helper to core, as the functionality
>     moves to lower level as well. This will result in a change of module
>     parameter from drm_kms_helper.edid_firmware to drm.edid_firmware, which
>     arguably makes more sense anyway.
>     
>     Some future work remains related to override and firmware EDID
>     validation. Like before, no validation is done for override EDID. The
>     firmware EDID is validated separately in the loader. Some unification
>     and deduplication would be in order, to validate all of them at the
>     drm_do_get_edid() level, like "real" EDIDs.
>     
>     v2: move firmware loading to core
>     
>     v3: rebase, commit message refresh
>     
>     Cc: Abdiel Janulgue <abdiel.janulgue@linux.intel.com>
>     Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>     Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
>     Tested-by: Abdiel Janulgue <abdiel.janulgue@linux.intel.com>
>     Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>     Acked-by: Dave Airlie <airlied@gmail.com>
>     Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/1e8a710bcac46e5136c1a7b430074893c81f364a.1505203831.git.jani.nikula@intel.com
>
> :040000 040000 2c9c6a97a18f6993af1097c69b9e36b1f98add40 60822020c6c58e6f46d659d321e082a62a530639 M	Documentation
> :040000 040000 f75d443482650cd4359868e1e453087f92543dab d737bdb8758b3cdfc5e8ca2b3808328b63939ea8 M	drivers
>
> commit ac6c35a4d8c77083525044a192cb1a8711381e94 (HEAD)
> Author: Jani Nikula <jani.nikula@intel.com>
> Date:   Mon Sep 18 21:20:03 2017 +0300
>
>     drm: add backwards compatibility support for drm_kms_helper.edid_firmware
>     
>     Add drm_kms_helper.edid_firmware module parameter with param ops hooks
>     to set drm.edid_firmware instead, for backwards compatibility.
>     
>     Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>     Cc: Abdiel Janulgue <abdiel.janulgue@linux.intel.com>
>     Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>     Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
>     Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>     Acked-by: Dave Airlie <airlied@gmail.com>
>     Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20170918182003.22238-2-jani.nikula@intel.com
>
> -- Package-specific info:
> ** Version:
> Linux version 4.15.0-1-amd64 (debian-kernel@lists.debian.org) (gcc
> version 7.3.0 (Debian 7.3.0-3)) #1 SMP Debian 4.15.4-1 (2018-02-18)
>
> ** Command line:
> BOOT_IMAGE=/vmlinuz-4.15.0-1-amd64 root=/dev/mapper/chianamo-root ro
> drm_kms_helper.edid_firmware=VGA-1:edid/VGA-1 drm.edid_firmware=VGA-
> 1:edid/VGA-1 quiet
>
> ** Tainted: O (4096)
>  * Out-of-tree module has been loaded.
>
> ** Model information
> sys_vendor: LENOVO
> product_name: 0831CTO
> product_version: ThinkPad X201 Tablet
> chassis_vendor: LENOVO
> chassis_version: Not Available
> bios_vendor: LENOVO
> bios_version: 6QET62WW (1.32 )
> board_vendor: LENOVO
> board_name: 0831CTO
> board_version: Not Available
>
> ** Loaded modules:
> fuse
> ctr
> ccm
> ebtable_filter
> ebtables
> ip6table_filter
> ip6_tables
> iptable_filter
> devlink
> toshiba_acpi
> industrialio
> sparse_keymap
> toshiba_haps
> hp_accel
> lis3lv02d
> input_polldev
> hdaps
> wacom_w8001
> serport
> binfmt_misc
> btusb
> btrtl
> btbcm
> btintel
> bluetooth
> drbg
> ansi_cprng
> ecdh_generic
> snd_hda_codec_hdmi
> snd_hda_codec_conexant
> snd_hda_codec_generic
> uvcvideo
> snd_hda_intel
> intel_powerclamp
> videobuf2_vmalloc
> snd_hda_codec
> kvm_intel
> snd_hda_core
> videobuf2_memops
> snd_hwdep
> videobuf2_v4l2
> arc4
> iwldvm
> mac80211
> snd_pcm_oss
> snd_mixer_oss
> videobuf2_core
> kvm
> iTCO_wdt
> videodev
> iTCO_vendor_support
> snd_pcm
> thinkpad_acpi
> nvram
> media
> snd_seq_midi
> snd_seq_midi_event
> irqbypass
> snd_rawmidi
> iwlwifi
> intel_cstate
> joydev
> intel_uncore
> snd_seq
> snd_seq_device
> snd_timer
> serio_raw
> cfg80211
> sg
> snd
> rfkill
> mei_me
> mei
> wmi_bmof
> intel_ips
> shpchp
> battery
> ac
> evdev
> soundcore
> lpc_ich
> mfd_core
> acpi_cpufreq
> i2c_dev
> coretemp
> cdc_ether
> usbnet
> mii
> tp_smapi
> thinkpad_ec
> loop
> parport_pc
> ppdev
> lp
> parport
> ip_tables
> x_tables
> autofs4
> ext4
> crc16
> mbcache
> jbd2
> fscrypto
> ecb
> btrfs
> zstd_decompress
> zstd_compress
> xxhash
> algif_skcipher
> af_alg
> dm_crypt
> dm_mod
> raid10
> raid456
> async_raid6_recov
> async_memcpy
> async_pq
> async_xor
> async_tx
> xor
> raid6_pq
> libcrc32c
> crc32c_generic
> raid1
> raid0
> multipath
> linear
> md_mod
> sd_mod
> uas
> usb_storage
> hid_generic
> hid_microsoft
> usbhid
> hid
> crct10dif_pclmul
> crc32_pclmul
> crc32c_intel
> ghash_clmulni_intel
> pcbc
> i915
> aesni_intel
> ahci
> aes_x86_64
> libahci
> crypto_simd
> glue_helper
> cryptd
> i2c_algo_bit
> libata
> drm_kms_helper
> psmouse
> ehci_pci
> i2c_i801
> ehci_hcd
> scsi_mod
> drm
> e1000e
> usbcore
> ptp
> usb_common
> pps_core
> thermal
> wmi
> video
> button
>
> ** PCI devices:
> 00:00.0 Host bridge [0600]: Intel Corporation Core Processor DRAM
> Controller [8086:0044] (rev 02)
> 	Subsystem: Lenovo Core Processor DRAM Controller [17aa:2193]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
> 	Latency: 0
> 	Capabilities: <access denied>
>
> 00:02.0 VGA compatible controller [0300]: Intel Corporation Core
> Processor Integrated Graphics Controller [8086:0046] (rev 02) (prog-if
> 00 [VGA controller])
> 	Subsystem: Lenovo Core Processor Integrated Graphics Controller
> [17aa:215a]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 26
> 	Region 0: Memory at f2000000 (64-bit, non-prefetchable)
> [size=4M]
> 	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
> 	Region 4: I/O ports at 1800 [size=8]
> 	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: i915
> 	Kernel modules: i915
>
> 00:16.0 Communication controller [0780]: Intel Corporation 5
> Series/3400 Series Chipset HECI Controller [8086:3b64] (rev 06)
> 	Subsystem: Lenovo 5 Series/3400 Series Chipset HECI Controller
> [17aa:215f]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 27
> 	Region 0: Memory at f2727800 (64-bit, non-prefetchable)
> [size=16]
> 	Capabilities: <access denied>
> 	Kernel driver in use: mei_me
> 	Kernel modules: mei_me
>
> 00:19.0 Ethernet controller [0200]: Intel Corporation 82577LM Gigabit
> Network Connection [8086:10ea] (rev 06)
> 	Subsystem: Lenovo 82577LM Gigabit Network Connection
> [17aa:2153]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 24
> 	Region 0: Memory at f2500000 (32-bit, non-prefetchable)
> [size=128K]
> 	Region 1: Memory at f2525000 (32-bit, non-prefetchable)
> [size=4K]
> 	Region 2: I/O ports at 1820 [size=32]
> 	Capabilities: <access denied>
> 	Kernel driver in use: e1000e
> 	Kernel modules: e1000e
>
> 00:1a.0 USB controller [0c03]: Intel Corporation 5 Series/3400 Series
> Chipset USB2 Enhanced Host Controller [8086:3b3c] (rev 06) (prog-if 20
> [EHCI])
> 	Subsystem: Lenovo 5 Series/3400 Series Chipset USB2 Enhanced
> Host Controller [17aa:2163]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin D routed to IRQ 23
> 	Region 0: Memory at f2728000 (32-bit, non-prefetchable)
> [size=1K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: ehci-pci
> 	Kernel modules: ehci_pci
>
> 00:1b.0 Audio device [0403]: Intel Corporation 5 Series/3400 Series
> Chipset High Definition Audio [8086:3b56] (rev 06)
> 	Subsystem: Lenovo 5 Series/3400 Series Chipset High Definition
> Audio [17aa:215e]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin B routed to IRQ 29
> 	Region 0: Memory at f2520000 (64-bit, non-prefetchable)
> [size=16K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: snd_hda_intel
> 	Kernel modules: snd_hda_intel
>
> 00:1c.0 PCI bridge [0604]: Intel Corporation 5 Series/3400 Series
> Chipset PCI Express Root Port 1 [8086:3b42] (rev 06) (prog-if 00
> [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 20
> 	Bus: primary=00, secondary=0d, subordinate=0d, sec-latency=0
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
>
> 00:1c.4 PCI bridge [0604]: Intel Corporation 5 Series/3400 Series
> Chipset PCI Express Root Port 5 [8086:3b4a] (rev 06) (prog-if 00
> [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 20
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	Memory behind bridge: f2400000-f24fffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 	Kernel modules: shpchp
>
> 00:1d.0 USB controller [0c03]: Intel Corporation 5 Series/3400 Series
> Chipset USB2 Enhanced Host Controller [8086:3b34] (rev 06) (prog-if 20
> [EHCI])
> 	Subsystem: Lenovo 5 Series/3400 Series Chipset USB2 Enhanced
> Host Controller [17aa:2163]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin D routed to IRQ 19
> 	Region 0: Memory at f2728400 (32-bit, non-prefetchable)
> [size=1K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: ehci-pci
> 	Kernel modules: ehci_pci
>
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
> [8086:2448] (rev a6) (prog-if 01 [Subtractive decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Bus: primary=00, secondary=0e, subordinate=0e, sec-latency=0
> 	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: <access denied>
>
> 00:1f.0 ISA bridge [0601]: Intel Corporation QM57 Chipset LPC Interface
> Controller [8086:3b07] (rev 06)
> 	Subsystem: Lenovo QM57 Chipset LPC Interface Controller
> [17aa:2166]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Capabilities: <access denied>
> 	Kernel driver in use: lpc_ich
> 	Kernel modules: lpc_ich
>
> 00:1f.2 SATA controller [0106]: Intel Corporation 5 Series/3400 Series
> Chipset 6 port SATA AHCI Controller [8086:3b2f] (rev 06) (prog-if 01
> [AHCI 1.0])
> 	Subsystem: Lenovo 5 Series/3400 Series Chipset 6 port SATA AHCI
> Controller [17aa:2168]
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 25
> 	Region 0: I/O ports at 1860 [size=8]
> 	Region 1: I/O ports at 1814 [size=4]
> 	Region 2: I/O ports at 1818 [size=8]
> 	Region 3: I/O ports at 1810 [size=4]
> 	Region 4: I/O ports at 1840 [size=32]
> 	Region 5: Memory at f2727000 (32-bit, non-prefetchable)
> [size=2K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: ahci
> 	Kernel modules: ahci
>
> 00:1f.3 SMBus [0c05]: Intel Corporation 5 Series/3400 Series Chipset
> SMBus Controller [8086:3b30] (rev 06)
> 	Subsystem: Lenovo 5 Series/3400 Series Chipset SMBus Controller
> [17aa:2167]
> 	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin A routed to IRQ 23
> 	Region 0: Memory at f2728800 (64-bit, non-prefetchable)
> [size=256]
> 	Region 4: I/O ports at 1880 [size=32]
> 	Kernel driver in use: i801_smbus
> 	Kernel modules: i2c_i801
>
> 00:1f.6 Signal processing controller [1180]: Intel Corporation 5
> Series/3400 Series Chipset Thermal Subsystem [8086:3b32] (rev 06)
> 	Subsystem: Lenovo 5 Series/3400 Series Chipset Thermal
> Subsystem [17aa:2190]
> 	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Interrupt: pin D routed to IRQ 19
> 	Region 0: Memory at f2526000 (64-bit, non-prefetchable)
> [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: intel ips
> 	Kernel modules: intel_ips
>
> 02:00.0 Network controller [0280]: Intel Corporation Centrino Ultimate-
> N 6300 [8086:4238] (rev 35)
> 	Subsystem: Intel Corporation Centrino Ultimate-N 6300 3x3 AGN
> [8086:1111]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 28
> 	Region 0: Memory at f2400000 (64-bit, non-prefetchable)
> [size=8K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: iwlwifi
> 	Kernel modules: iwlwifi
>
> ff:00.0 Host bridge [0600]: Intel Corporation Core Processor QuickPath
> Architecture Generic Non-core Registers [8086:2c62] (rev 02)
> 	Subsystem: Lenovo Core Processor QuickPath Architecture Generic
> Non-core Registers [17aa:2196]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
>
> ff:00.1 Host bridge [0600]: Intel Corporation Core Processor QuickPath
> Architecture System Address Decoder [8086:2d01] (rev 02)
> 	Subsystem: Lenovo Core Processor QuickPath Architecture System
> Address Decoder [17aa:2196]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
>
> ff:02.0 Host bridge [0600]: Intel Corporation Core Processor QPI Link 0
> [8086:2d10] (rev 02)
> 	Subsystem: Lenovo Core Processor QPI Link 0 [17aa:2196]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
>
> ff:02.1 Host bridge [0600]: Intel Corporation 1st Generation Core
> i3/5/7 Processor QPI Physical 0 [8086:2d11] (rev 02)
> 	Subsystem: Lenovo 1st Generation Core i3/5/7 Processor QPI
> Physical 0 [17aa:2196]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
>
> ff:02.2 Host bridge [0600]: Intel Corporation 1st Generation Core
> i3/5/7 Processor Reserved [8086:2d12] (rev 02)
> 	Subsystem: Lenovo 1st Generation Core i3/5/7 Processor Reserved
> [17aa:2196]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
>
> ff:02.3 Host bridge [0600]: Intel Corporation 1st Generation Core
> i3/5/7 Processor Reserved [8086:2d13] (rev 02)
> 	Subsystem: Lenovo 1st Generation Core i3/5/7 Processor Reserved
> [17aa:2196]
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
>
>
> ** USB devices:
> Bus 002 Device 003: ID 045e:0040 Microsoft Corp. Wheel Mouse Optical
> Bus 002 Device 002: ID 8087:0020 Intel Corp. Integrated Rate Matching
> Hub
> Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 001 Device 005: ID 17ef:4816 Lenovo Integrated Webcam
> Bus 001 Device 003: ID 045e:0750 Microsoft Corp. Wired Keyboard 600
> Bus 001 Device 002: ID 8087:0020 Intel Corp. Integrated Rate Matching
> Hub
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>
> -- System Information:
> Debian Release: buster/sid
>   APT prefers testing-debug
>   APT policy: (900, 'testing-debug'), (900, 'testing'), (800,
> 'unstable-debug'), (800, 'unstable'), (790, 'buildd-unstable'), (700,
> 'experimental-debug'), (700, 'experimental'), (690, 'buildd-
> experimental')
> Architecture: amd64 (x86_64)
>
> Kernel: Linux 4.15.0-1-amd64 (SMP w/4 CPU cores)
> Locale: LANG=en_AU.utf8, LC_CTYPE=en_AU.utf8 (charmap=UTF-8),
> LANGUAGE=en_AU.utf8 (charmap=UTF-8)
> Shell: /bin/sh linked to /bin/dash
> Init: systemd (via /run/systemd/system)
>
> Versions of packages linux-image-4.15.0-1-amd64 depends on:
> ii  initramfs-tools [linux-initramfs-tool]  0.130
> ii  kmod                                    25-1
> ii  linux-base                              4.5
>
> Versions of packages linux-image-4.15.0-1-amd64 recommends:
> pn  apparmor             <none>
> ii  firmware-linux-free  3.4
> ii  irqbalance           1.3.0-0.1
>
> Versions of packages linux-image-4.15.0-1-amd64 suggests:
> pn  debian-kernel-handbook  <none>
> ii  extlinux                3:6.03+dfsg1-2
> ii  grub-pc                 2.02+dfsg1-1
> pn  linux-doc-4.15          <none>
>
> Versions of packages linux-image-4.15.0-1-amd64 is related to:
> pn  firmware-amd-graphics     <none>
> pn  firmware-atheros          <none>
> pn  firmware-bnx2             <none>
> pn  firmware-bnx2x            <none>
> pn  firmware-brcm80211        <none>
> pn  firmware-cavium           <none>
> pn  firmware-intel-sound      <none>
> pn  firmware-intelwimax       <none>
> pn  firmware-ipw2x00          <none>
> pn  firmware-ivtv             <none>
> ii  firmware-iwlwifi          20170823-1
> pn  firmware-libertas         <none>
> pn  firmware-linux-nonfree    <none>
> ii  firmware-misc-nonfree     20170823-1
> pn  firmware-myricom          <none>
> pn  firmware-netxen           <none>
> pn  firmware-qlogic           <none>
> ii  firmware-realtek          20170823-1
> pn  firmware-samsung          <none>
> pn  firmware-siano            <none>
> pn  firmware-ti-connectivity  <none>
> pn  xen-hypervisor            <none>

-- 
Jani Nikula, Intel Open Source Graphics Center
