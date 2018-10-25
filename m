Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9F5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3F420838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3F420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeJYQUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:20:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55691 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:20:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8673580842; Thu, 25 Oct 2018 09:49:02 +0200 (CEST)
Date:   Thu, 25 Oct 2018 09:49:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Numan =?utf-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>,
        jason.low2@hpe.com, Waiman.Long@hpe.com,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de
Cc:     dmitry.torokhov@gmail.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [regression, bisected] Keyboard not responding after resuming from
 suspend/hibernate
Message-ID: <20181025074903.GA9323@amd>
References: <20180831215121.1b1f66bf@korsan.localdomain>
 <20181019102031.77015d44@korsan.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20181019102031.77015d44@korsan.localdomain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Here's problem bisected down to:

commit 9d659ae14b545c4296e812c70493bfdc999b5c1c
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Aug 23 14:40:16 2016 +0200

    locking/mutex: Add lock handoff to avoid starvation

    Implement lock handoff to avoid lock starvation.

Numan, I assume revert of that patch on the 4.18 kernel still makes it
work?

Peter, any ideas?

								Pavel

On Fri 2018-10-19 10:20:31, Numan Demird=C3=B6=C4=9Fen wrote:
> On Fri, 31 Aug 2018 21:53:11 +0300
> Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> wrote:
>=20
> >If I put laptop to suspend or hibernate by closing lid, power
> >manager or any other method and then I resume/wake up laptop, keyboard
> >is not responding. My laptop is a Sony Vaio VPCEH2F1E.=20
> >
> >Steps to produce bug:
> >1. Boot
> >2. Put laptop to sleep
> >3. Resume
> >
> >What I expect to happen: Keyboard responds to key press.
> >What happens: Keyboard does not respond but mouse and trackball are
> >working.
> >
> >git bisect point 9d659ae14b545c4296e812c70493bfdc999b5c1c as the first
> >bad commit.
> >
> >Bad commit link:
> >https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=
=3D9d659ae14b545c4296e812c70493bfdc999b5c1c
> >
> > Link to actual bug report:
> >https://bugzilla.kernel.org/show_bug.cgi?id=3D195471
> >
> >awk -f ver_linux
> >Linux korsan 4.18.5-arch1-1-ARCH #1 SMP PREEMPT Fri Aug 24 12:48:58
> >UTC 2018 x86_64 GNU/Linux GNU C               	8.2.0
> >GNU Make            	4.2.1
> >Binutils            	2.31.1
> >Util-linux          	2.32.1
> >Mount               	2.32.1
> >Module-init-tools   	25
> >E2fsprogs           	1.44.4
> >Jfsutils            	1.1.15
> >Reiserfsprogs       	3.6.27
> >Xfsprogs            	4.17.0
> >Pcmciautils         	018
> >Linux C Library     	2.28
> >Dynamic linker (ldd)	2.28
> >Linux C++ Library   	6.0.25
> >Procps              	3.3.15
> >Kbd                 	2.0.4
> >Console-tools       	2.0.4
> >Sh-utils            	8.29
> >Udev                	239
> >Wireless-tools      	30
> >Modules Loaded      	ac agpgart ahci arc4 ath ath3k ath9k
> >ath9k_common ath9k_hw atkbd battery bluetooth bpfilter ccm cdrom
> >cfg80211 coretemp crc16 crc32c_generic crc32c_intel crc32_pclmul
> >crct10dif_pclmul cryptd drm drm_kms_helper ecdh_generic ehci_hcd
> >ehci_pci evdev ext4 fb_sys_fops fscrypto fuse ghash_clmulni_intel
> >gpio_ich hid hid_generic i2c_algo_bit i2c_i801 i8042 i915 input_leds
> >intel_cstate intel_gtt intel_powerclamp intel_rapl intel_rapl_perf
> >intel_uncore iptable_filter iptable_mangle iptable_nat ip_tables
> >irqbypass iTCO_vendor_support iTCO_wdt jbd2 kvm kvm_intel led_class
> >libahci libata libcrc32c libps2 lpc_ich mac80211 mac_hid mbcache mei
> >mei_me mousedev msr nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4
> >nf_nat nf_nat_ipv4 pcc_cpufreq psmouse rfkill rtc_cmos scsi_mod sd_mod
> >serio serio_raw snd snd_hda_codec snd_hda_codec_conexant
> >snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_core snd_hda_intel
> >snd_hwdep snd_pcm snd_timer sony_laptop soundcore sr_mod syscopyarea
> >sysfillrect sysimgblt usb_common usbcore usbhid x86_pkg_temp_thermal
> >x_tables
> >
> >dmesg | grep i8042
> >[    0.574078] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
> >at 0x60,0x64 irq 1,12 [    0.575936] serio: i8042 KBD port at
> >0x60,0x64 irq 1 [    0.576143] serio: i8042 AUX port at 0x60,0x64 irq
> >12 [    0.618880] input: AT Translated Set 2 keyboard
> >as /devices/platform/i8042/serio0/input/input3 [   11.248435] input:
> >AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/serio1/input/input5
> >
> >cat /proc/interrupts=20
> >           CPU0       CPU1       CPU2       CPU3      =20
> >  0:          8          0          0          0   IO-APIC
> > 2-edge      timer 1:          0          0          0      10286
> > IO-APIC   1-edge      i8042 8:          0          0
> > 0          1   IO-APIC   8-edge      rtc0 9:          0
> > 9479          0          0   IO-APIC   9-fasteoi   acpi 12:
> > 0          0     370114          0   IO-APIC  12-edge      i8042
> > 16:     197457          0          0          0   IO-APIC
> > 16-fasteoi   ehci_hcd:usb1, ath9k 19:          0          0
> > 0          0   IO-APIC  19-fasteoi   i801_smbus 23:
> > 0          0      71055          0   IO-APIC  23-fasteoi
> > ehci_hcd:usb2 24:          0      74549          0          0
> > PCI-MSI 512000-edge      ahci[0000:00:1f.2] 25:          0
> > 14          0          0   PCI-MSI 360448-edge      mei_me
> > 26:          0          0     138870          0   PCI-MSI
> > 32768-edge      i915 27:          0          0          0
> > 330   PCI-MSI 442368-edge      snd_hda_intel:card0
> >NMI:         24         22         25         21   Non-maskable
> >interrupts LOC:     534734     446934     603337     440320   Local
> >timer interrupts SPU:          0          0          0          0
> >Spurious interrupts PMI:         24         22         25         21
> >Performance monitoring interrupts IWI:         26         12
> >43115         22   IRQ work interrupts RTR:          0
> >0          0          0   APIC ICR read retries RES:      95282
> >76970      60242      46409   Rescheduling interrupts CAL:
> >66746      75300      70554      69119   Function call interrupts
> >TLB:      50929      54528      51413      48017   TLB shootdowns
> >TRM:          0          0          0          0   Thermal event
> >interrupts THR:          0          0          0          0
> >Threshold APIC interrupts DFR:          0          0
> >0          0   Deferred Error APIC interrupts MCE:          0
> >0          0          0   Machine check exceptions MCP:
> >18         19         19         19   Machine check polls
> >HYP:          0          0          0          0   Hypervisor callback
> >interrupts HRE:          0          0          0          0   Hyper-V
> >reenlightenment interrupts HVS:          0          0
> >0          0   Hyper-V stimer0 interrupts ERR:          0
> >MIS:          0 PIN:          0          0          0          0
> >Posted-interrupt notification event NPI:          0
> >0          0          0   Nested posted-interrupt event PIW:
> >0          0          0          0   Posted-interrupt wakeup event
> >
> >P.S: My native language is not English.
> >
>=20
> Hi,
>=20
> I am forwarding this e-mail which describes a problem related to
> suspend/hibernate at the advise of Pavel Machek.
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvRdW8ACgkQMOfwapXb+vKYEwCfaKmY/h5+vzipfGKsBty1Ft1S
oXQAoJ8fvknx5o/2ziUvsZHHG9m/KNzZ
=2uUx
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
