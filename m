Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA9ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF01D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQAdoTZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF01D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeJSPZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:25:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40209 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:25:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id z204-v6so2627569wmc.5;
        Fri, 19 Oct 2018 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=sZBmcW7j44HXwd/c/42qLJMcBcDBP80uxLtQjJbhVA8=;
        b=hQAdoTZAIcKnQtaxurzL6xfAw0D9scPACzScUoyCz9SULyxliAovR6QLkRnCKSWobe
         useZPi29HU9b2vUG5GyNuLxvGr4afZ6Pl03tzDlcFQe/W6J9WfNSkwR2Kv0MhUkuReZN
         a9+7TZbKK1zDfguvT0HC3igN2WK2XAd9cjoaclev2oL8Ysv8knvmAZXZpNXAECEgUC/G
         cL1a6JIRclyan/cRSde+m/Xqlc1QyPg7BDwO45hnrybe+xgKinv94WVRrNNGI6d9c4QN
         P6z6XSFC7WyWUE5IZ67PDsBi2PAmsIidONNOkErjhjAk8wkfAW3zz+atAmS+kVeD0Cx9
         Zrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=sZBmcW7j44HXwd/c/42qLJMcBcDBP80uxLtQjJbhVA8=;
        b=F1EdIblZ4fXVdoukIFwFcD5X14MHZtDtsZe4uEKhu9k5O7vsYyL06rllskreZsd0Xh
         P/HimoJO25X5DbZkK9zRRgZuDaRPNzxtOr8CkTRDOa2XWSActA5A460gyRc9xsowp0Js
         vPp+k1dxxgeu188A7mKrw2xQ4xPivsztGAKXXO5Eo4L0iiF1I96oa2VvIpffZHB2rkpK
         AR6EtN2bv6Ls6Gdx1BGF1SSU6odoRoH2kbq61LCgaefWlOWiweWu0Rma/A7v76XJMwiA
         L6QSwTwtbpDRydgXb8rMiBDNN2Ci168GzARFZz2A3PLq88r+DYw7KVapTuly1HWgXpQF
         gkVQ==
X-Gm-Message-State: ABuFfog2QcDEqs49lLv1KA2ErJa0mnBObg0+3zSYb+1yPBis4SLv7O8m
        Koc+GJESZTUBfHVr4SKbrg8=
X-Google-Smtp-Source: ACcGV60jcf6ssY42Au50Ydpd/vy3Z6pUHuM3stjVWw3vjcPFBhxwE2je+Cj8N7dvLcJPfdiZjay9Pw==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr3622560wmf.143.1539933636303;
        Fri, 19 Oct 2018 00:20:36 -0700 (PDT)
Received: from korsan.localdomain ([212.174.243.194])
        by smtp.gmail.com with ESMTPSA id u10-v6sm18668353wrt.59.2018.10.19.00.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 00:20:35 -0700 (PDT)
Date:   Fri, 19 Oct 2018 10:20:31 +0300
From:   Numan =?UTF-8?Q?Demird=C3=B6=C4=9Fen?= <if.gnu.linux@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Fw: PROBLEM: Keyboard not responding after resuming from
 suspend/hibernate
Message-ID: <20181019102031.77015d44@korsan.localdomain>
In-Reply-To: <20180831215121.1b1f66bf@korsan.localdomain>
References: <20180831215121.1b1f66bf@korsan.localdomain>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.i0Hw2JstRd6MPEO7ifPL5U"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.i0Hw2JstRd6MPEO7ifPL5U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Aug 2018 21:53:11 +0300
Numan Demird=C3=B6=C4=9Fen <if.gnu.linux@gmail.com> wrote:

>If I put laptop to suspend or hibernate by closing lid, power
>manager or any other method and then I resume/wake up laptop, keyboard
>is not responding. My laptop is a Sony Vaio VPCEH2F1E.=20
>
>Steps to produce bug:
>1. Boot
>2. Put laptop to sleep
>3. Resume
>
>What I expect to happen: Keyboard responds to key press.
>What happens: Keyboard does not respond but mouse and trackball are
>working.
>
>git bisect point 9d659ae14b545c4296e812c70493bfdc999b5c1c as the first
>bad commit.
>
>Bad commit link:
>https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3D9=
d659ae14b545c4296e812c70493bfdc999b5c1c
>
> Link to actual bug report:
>https://bugzilla.kernel.org/show_bug.cgi?id=3D195471
>
>awk -f ver_linux
>Linux korsan 4.18.5-arch1-1-ARCH #1 SMP PREEMPT Fri Aug 24 12:48:58
>UTC 2018 x86_64 GNU/Linux GNU C               	8.2.0
>GNU Make            	4.2.1
>Binutils            	2.31.1
>Util-linux          	2.32.1
>Mount               	2.32.1
>Module-init-tools   	25
>E2fsprogs           	1.44.4
>Jfsutils            	1.1.15
>Reiserfsprogs       	3.6.27
>Xfsprogs            	4.17.0
>Pcmciautils         	018
>Linux C Library     	2.28
>Dynamic linker (ldd)	2.28
>Linux C++ Library   	6.0.25
>Procps              	3.3.15
>Kbd                 	2.0.4
>Console-tools       	2.0.4
>Sh-utils            	8.29
>Udev                	239
>Wireless-tools      	30
>Modules Loaded      	ac agpgart ahci arc4 ath ath3k ath9k
>ath9k_common ath9k_hw atkbd battery bluetooth bpfilter ccm cdrom
>cfg80211 coretemp crc16 crc32c_generic crc32c_intel crc32_pclmul
>crct10dif_pclmul cryptd drm drm_kms_helper ecdh_generic ehci_hcd
>ehci_pci evdev ext4 fb_sys_fops fscrypto fuse ghash_clmulni_intel
>gpio_ich hid hid_generic i2c_algo_bit i2c_i801 i8042 i915 input_leds
>intel_cstate intel_gtt intel_powerclamp intel_rapl intel_rapl_perf
>intel_uncore iptable_filter iptable_mangle iptable_nat ip_tables
>irqbypass iTCO_vendor_support iTCO_wdt jbd2 kvm kvm_intel led_class
>libahci libata libcrc32c libps2 lpc_ich mac80211 mac_hid mbcache mei
>mei_me mousedev msr nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4
>nf_nat nf_nat_ipv4 pcc_cpufreq psmouse rfkill rtc_cmos scsi_mod sd_mod
>serio serio_raw snd snd_hda_codec snd_hda_codec_conexant
>snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_core snd_hda_intel
>snd_hwdep snd_pcm snd_timer sony_laptop soundcore sr_mod syscopyarea
>sysfillrect sysimgblt usb_common usbcore usbhid x86_pkg_temp_thermal
>x_tables
>
>dmesg | grep i8042
>[    0.574078] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M]
>at 0x60,0x64 irq 1,12 [    0.575936] serio: i8042 KBD port at
>0x60,0x64 irq 1 [    0.576143] serio: i8042 AUX port at 0x60,0x64 irq
>12 [    0.618880] input: AT Translated Set 2 keyboard
>as /devices/platform/i8042/serio0/input/input3 [   11.248435] input:
>AlpsPS/2 ALPS GlidePoint as /devices/platform/i8042/serio1/input/input5
>
>cat /proc/interrupts=20
>           CPU0       CPU1       CPU2       CPU3      =20
>  0:          8          0          0          0   IO-APIC
> 2-edge      timer 1:          0          0          0      10286
> IO-APIC   1-edge      i8042 8:          0          0
> 0          1   IO-APIC   8-edge      rtc0 9:          0
> 9479          0          0   IO-APIC   9-fasteoi   acpi 12:
> 0          0     370114          0   IO-APIC  12-edge      i8042
> 16:     197457          0          0          0   IO-APIC
> 16-fasteoi   ehci_hcd:usb1, ath9k 19:          0          0
> 0          0   IO-APIC  19-fasteoi   i801_smbus 23:
> 0          0      71055          0   IO-APIC  23-fasteoi
> ehci_hcd:usb2 24:          0      74549          0          0
> PCI-MSI 512000-edge      ahci[0000:00:1f.2] 25:          0
> 14          0          0   PCI-MSI 360448-edge      mei_me
> 26:          0          0     138870          0   PCI-MSI
> 32768-edge      i915 27:          0          0          0
> 330   PCI-MSI 442368-edge      snd_hda_intel:card0
>NMI:         24         22         25         21   Non-maskable
>interrupts LOC:     534734     446934     603337     440320   Local
>timer interrupts SPU:          0          0          0          0
>Spurious interrupts PMI:         24         22         25         21
>Performance monitoring interrupts IWI:         26         12
>43115         22   IRQ work interrupts RTR:          0
>0          0          0   APIC ICR read retries RES:      95282
>76970      60242      46409   Rescheduling interrupts CAL:
>66746      75300      70554      69119   Function call interrupts
>TLB:      50929      54528      51413      48017   TLB shootdowns
>TRM:          0          0          0          0   Thermal event
>interrupts THR:          0          0          0          0
>Threshold APIC interrupts DFR:          0          0
>0          0   Deferred Error APIC interrupts MCE:          0
>0          0          0   Machine check exceptions MCP:
>18         19         19         19   Machine check polls
>HYP:          0          0          0          0   Hypervisor callback
>interrupts HRE:          0          0          0          0   Hyper-V
>reenlightenment interrupts HVS:          0          0
>0          0   Hyper-V stimer0 interrupts ERR:          0
>MIS:          0 PIN:          0          0          0          0
>Posted-interrupt notification event NPI:          0
>0          0          0   Nested posted-interrupt event PIW:
>0          0          0          0   Posted-interrupt wakeup event
>
>P.S: My native language is not English.
>

Hi,

I am forwarding this e-mail which describes a problem related to
suspend/hibernate at the advise of Pavel Machek.

--=20
Numan Demird=C3=B6=C4=9Fen

--Sig_/.i0Hw2JstRd6MPEO7ifPL5U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEKU9fayrDgTGfA1OV4Dh9jqVujDIFAlvJhb8ACgkQ4Dh9jqVu
jDKABAf/YPAHB3DIk33uE8MSsiturpYSpy8nvAGST2cT2hjSQyjh79LQAP1nxKdu
tNmBdEAryPfXZG2qTPOpaaBBvaH2S7xcBInY7exE6xrLtncbF629S2QPn6i1dRg1
LtGT/wjy0IvJgATu8X2nn/THv7ZWLjByxO6EprCObfwhSu2d79yzEiaoR1dDxE9O
iiTyMQLtTWEC0rhWyFSXgn6G5AVSlIb/OzdxrotiFEsFYK7EgzctDwV/H7AQe5T6
pHxd6LBH2u8giGZbXSNYvN01blx3CTyEQyiKdKelknK6N32ub/ix5TGcsEhs7ZLd
Nbga5LatagV3QdR7uixTYoOihzDU8g==
=/aip
-----END PGP SIGNATURE-----

--Sig_/.i0Hw2JstRd6MPEO7ifPL5U--
