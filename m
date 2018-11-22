Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FB0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC1320831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=correia.cc header.i=@correia.cc header.b="ZqmHrwk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC1320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=correia.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbeKVQHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 11:07:30 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39735 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728036AbeKVQHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 11:07:30 -0500
Received: by mail-vs1-f66.google.com with SMTP id h78so4672315vsi.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 21:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=correia.cc; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=RzJUK0M5I3VaJtvADhgnyAhF5FiSHmSIW0mdNAo9k4I=;
        b=ZqmHrwk+UBBu2m0q9X6sNfIdOe2xXfNpezZIB4UjaZnOvgbnUVh3lS/PN1HuJUpu3S
         WrUhie4Qe4BPjJqnjTOQAzMatax9A+9MNMB2G3rLX2tB+F6KF8cZuS7M+FT0BpM9w6CC
         Xbm9NwvJaBAiHPOOJxM4kxQzoxWjhUKIQx5n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=RzJUK0M5I3VaJtvADhgnyAhF5FiSHmSIW0mdNAo9k4I=;
        b=rHqAU19iWvIvjg9jlCipRu9D05Lskz2drUyS2dFRISJtMT2MBnZRYG7+25xqL9Frhi
         k56pRD+UZX1ft1uiZ0ZpwNx+4yjgADNdrXBx+vw+AbrZ9hfCQ/Ru70nhya+O+GgUboqX
         LQbi4yyFy8NPjsvCzppyONXgjVqJqF5MedeK1Mt9sElZ/YuMfqdjEnR40ArVVvCqiF9Y
         aaGuWX8XMr7MuR3b4SE2zqnIIjirWB3afwThVI/ggBK7zEHrMyUvQlTLgOYimCySaOW3
         kcISbqTYOB2EfCd0HGiAK2phr7UocB7FesjbIJ92Rcdo6Otw6+igkMT6NMTHeXTpX6nv
         VtSQ==
X-Gm-Message-State: AGRZ1gLIfZyiHDjaO5ajHUt4Od72aGDXazGbYOrtc5TlH3DNrtaTokiT
        EKRb2cpDCqAQ09x4sdH7sCrhghKo4n+kk1wlRNuec5Zw
X-Google-Smtp-Source: AJdET5eCiNRw892RheRGWvUMLhqmk32OoBFntEqdkIFhe1it+0MyDwg5fHmRqcGGm8SwN+SX1RNTYMFJmrskLoRAkLs=
X-Received: by 2002:a67:ad0b:: with SMTP id t11mr3950849vsl.170.1542864583537;
 Wed, 21 Nov 2018 21:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20181118235720.3150-1-sergio@correia.cc> <20181121095512.GP4266@phenom.ffwll.local>
In-Reply-To: <20181121095512.GP4266@phenom.ffwll.local>
From:   Sergio Correia <sergio@correia.cc>
Date:   Thu, 22 Nov 2018 02:29:31 -0300
Message-ID: <CAE0BZMeaLNsw9Gvz6Az0dDSyymBUWPDvJXn0L3-de37oKtMTAg@mail.gmail.com>
Subject: Re: [PATCH] drm: restore is_master upon failure in drm_new_set_master()
To:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, sean@poorly.run
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 6:55 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Sun, Nov 18, 2018 at 08:57:20PM -0300, Sergio Correia wrote:
> > When drm_new_set_master() fails, we restore the old master, however we =
may
> > have changed the is_master flag to 1, before failing, and it may be the
> > case it was 0 previously. Restore also this flag to its original state,=
 in
> > case of failure.
> >
> > Here is a problematic flow: we check is_master in drm_is_current_master=
(),
> > then proceed to call drm_lease_owner() passing master. If we do not res=
tore
> > is_master status when drm_new_set_master() fails, we may have a situati=
on
> > in which is_master will be 1 and master itself, NULL, leading to the de=
ref
> > of a NULL pointer in drm_lease_owner().
> >
> > This fixes the following OOPS, observed on an ArchLinux running a 4.19.=
2
> > kernel:
> >
> > [   97.804282] BUG: unable to handle kernel NULL pointer dereference at=
 0000000000000080
> > [   97.807224] PGD 0 P4D 0
> > [   97.807224] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [   97.807224] CPU: 0 PID: 1348 Comm: xfwm4 Tainted: P           OE    =
 4.19.2-arch1-1-ARCH #1
> > [   97.807224] Hardware name: To Be Filled By O.E.M. To Be Filled By O.=
E.M./AB350 Pro4, BIOS P5.10 10/16/2018
> > [   97.807224] RIP: 0010:drm_lease_owner+0xd/0x20 [drm]
> > [   97.807224] Code: 83 c4 18 5b 5d c3 b8 ea ff ff ff eb e2 b8 ed ff ff=
 ff eb db e8 b4 ca 68 fb 0f 1f 40 00 0f 1f 44 00 00 48 89 f8 eb 03 48 89 d0=
 <48> 8b 90 80 00 00 00 48 85 d2 75 f1 c3 66 0f 1f 44 00 00 0f 1f 44
> > [   97.807224] RSP: 0018:ffffb8cf08e07bb0 EFLAGS: 00010202
> > [   97.807224] RAX: 0000000000000000 RBX: ffff9cf0f2586c00 RCX: ffff9cf=
0f2586c88
> > [   97.807224] RDX: ffff9cf0ddbd8000 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [   97.807224] RBP: ffff9cf1040e9800 R08: 0000000000000000 R09: 0000000=
000000000
> > [   97.807224] R10: ffffdeb30fd5d680 R11: ffffdeb30f5d6808 R12: ffff9cf=
1040e9888
> > [   97.807224] R13: 0000000000000000 R14: dead000000000200 R15: ffff9cf=
0f2586cc8
> > [   97.807224] FS:  00007f4145513180(0000) GS:ffff9cf10ea00000(0000) kn=
lGS:0000000000000000
> > [   97.807224] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   97.807224] CR2: 0000000000000080 CR3: 00000003d7548000 CR4: 0000000=
0003406f0
> > [   97.807224] Call Trace:
> > [   97.807224]  drm_is_current_master+0x1a/0x30 [drm]
> > [   97.807224]  drm_master_release+0x3e/0x130 [drm]
> > [   97.807224]  drm_file_free.part.0+0x2be/0x2d0 [drm]
> > [   97.807224]  drm_open+0x1ba/0x1e0 [drm]
> > [   97.807224]  drm_stub_open+0xaf/0xe0 [drm]
> > [   97.807224]  chrdev_open+0xa3/0x1b0
> > [   97.807224]  ? cdev_put.part.0+0x20/0x20
> > [   97.807224]  do_dentry_open+0x132/0x340
> > [   97.807224]  path_openat+0x2d1/0x14e0
> > [   97.807224]  ? mem_cgroup_commit_charge+0x7a/0x520
> > [   97.807224]  do_filp_open+0x93/0x100
> > [   97.807224]  ? __check_object_size+0x102/0x189
> > [   97.807224]  ? _raw_spin_unlock+0x16/0x30
> > [   97.807224]  do_sys_open+0x186/0x210
> > [   97.807224]  do_syscall_64+0x5b/0x170
> > [   97.807224]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [   97.807224] RIP: 0033:0x7f4147b07976
> > [   97.807224] Code: 89 54 24 08 e8 7b f4 ff ff 8b 74 24 0c 48 8b 3c 24=
 41 89 c0 44 8b 54 24 08 b8 01 01 00 00 89 f2 48 89 fe bf 9c ff ff ff 0f 05=
 <48> 3d 00 f0 ff ff 77 30 44 89 c7 89 44 24 08 e8 a6 f4 ff ff 8b 44
> > [   97.807224] RSP: 002b:00007ffcced96ca0 EFLAGS: 00000293 ORIG_RAX: 00=
00000000000101
> > [   97.807224] RAX: ffffffffffffffda RBX: 00005619d5037f80 RCX: 00007f4=
147b07976
> > [   97.807224] RDX: 0000000000000002 RSI: 00005619d46b969c RDI: 0000000=
0ffffff9c
> > [   98.040039] RBP: 0000000000000024 R08: 0000000000000000 R09: 0000000=
000000000
> > [   98.040039] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000=
000000024
> > [   98.040039] R13: 0000000000000012 R14: 00005619d5035950 R15: 0000000=
000000012
> > [   98.040039] Modules linked in: nct6775 hwmon_vid algif_skcipher af_a=
lg nls_iso8859_1 nls_cp437 vfat fat uvcvideo videobuf2_vmalloc videobuf2_me=
mops videobuf2_v4l2 videobuf2_common arc4 videodev media snd_usb_audio snd_=
hda_codec_hdmi snd_usbmidi_lib snd_rawmidi snd_seq_device mousedev input_le=
ds iwlmvm mac80211 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_inte=
l snd_hda_codec edac_mce_amd kvm_amd snd_hda_core kvm iwlwifi snd_hwdep r81=
69 wmi_bmof cfg80211 snd_pcm irqbypass snd_timer snd libphy soundcore pinct=
rl_amd rfkill pcspkr sp5100_tco evdev gpio_amdpt k10temp mac_hid i2c_piix4 =
wmi pcc_cpufreq acpi_cpufreq vboxnetflt(OE) vboxnetadp(OE) vboxpci(OE) vbox=
drv(OE) msr sg crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbc=
ache jbd2 fscrypto uas usb_storage dm_crypt hid_generic usbhid hid
> > [   98.040039]  dm_mod raid1 md_mod sd_mod crct10dif_pclmul crc32_pclmu=
l crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel aes_x86_64=
 libata crypto_simd cryptd glue_helper ccp xhci_pci rng_core scsi_mod xhci_=
hcd nvidia_drm(POE) drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys=
_fops drm agpgart nvidia_uvm(POE) nvidia_modeset(POE) nvidia(POE) ipmi_devi=
ntf ipmi_msghandler
> > [   98.040039] CR2: 0000000000000080
> > [   98.040039] ---[ end trace 3b65093b6fe62b2f ]---
> > [   98.040039] RIP: 0010:drm_lease_owner+0xd/0x20 [drm]
> > [   98.040039] Code: 83 c4 18 5b 5d c3 b8 ea ff ff ff eb e2 b8 ed ff ff=
 ff eb db e8 b4 ca 68 fb 0f 1f 40 00 0f 1f 44 00 00 48 89 f8 eb 03 48 89 d0=
 <48> 8b 90 80 00 00 00 48 85 d2 75 f1 c3 66 0f 1f 44 00 00 0f 1f 44
> > [   98.040039] RSP: 0018:ffffb8cf08e07bb0 EFLAGS: 00010202
> > [   98.040039] RAX: 0000000000000000 RBX: ffff9cf0f2586c00 RCX: ffff9cf=
0f2586c88
> > [   98.040039] RDX: ffff9cf0ddbd8000 RSI: 0000000000000000 RDI: 0000000=
000000000
> > [   98.040039] RBP: ffff9cf1040e9800 R08: 0000000000000000 R09: 0000000=
000000000
> > [   98.040039] R10: ffffdeb30fd5d680 R11: ffffdeb30f5d6808 R12: ffff9cf=
1040e9888
> > [   98.040039] R13: 0000000000000000 R14: dead000000000200 R15: ffff9cf=
0f2586cc8
> > [   98.040039] FS:  00007f4145513180(0000) GS:ffff9cf10ea00000(0000) kn=
lGS:0000000000000000
> > [   98.040039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   98.040039] CR2: 0000000000000080 CR3: 00000003d7548000 CR4: 0000000=
0003406f0
> >
> > Signed-off-by: Sergio Correia <sergio@correia.cc>
>
> Nice catch! I guess this is with the vmwgfx driver running? Only that has
> a master_set function, and I don't see anything else that could fail.
>

I was under the impression it would be related to nvidia drm, but I
didn't investigate it further.

>
> > ---
> >  drivers/gpu/drm/drm_auth.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> > index d9c0f7573905..959a1ba5a3c6 100644
> > --- a/drivers/gpu/drm/drm_auth.c
> > +++ b/drivers/gpu/drm/drm_auth.c
> > @@ -138,11 +138,13 @@ static int drm_set_master(struct drm_device *dev,=
 struct drm_file *fpriv,
> >  static int drm_new_set_master(struct drm_device *dev, struct drm_file =
*fpriv)
> >  {
> >       struct drm_master *old_master;
> > +     int old_master_status;
> >       int ret;
> >
> >       lockdep_assert_held_once(&dev->master_mutex);
> >
> >       old_master =3D fpriv->master;
> > +     old_master_status =3D fpriv->is_master;
>
> We have the invariant here that fpriv->is_master =3D=3D 0, so no need to
> restore anything, you can just unconditionally set it to 0 at the end. If
> you want, put a WARN_ON(fpriv->is_master) here.
>

Ah, I see. I will add the WARN_ON, then.

>
> Can you pls respin? I'll apply it right away then.


Sure, I will do it shortly.

Thanks,
Sergio

>
>
> Thanks, Daniel
>
> >       fpriv->master =3D drm_master_create(dev);
> >       if (!fpriv->master) {
> >               fpriv->master =3D old_master;
> > @@ -170,6 +172,7 @@ static int drm_new_set_master(struct drm_device *de=
v, struct drm_file *fpriv)
> >       /* drop references and restore old master on failure */
> >       drm_master_put(&fpriv->master);
> >       fpriv->master =3D old_master;
> > +     fpriv->is_master =3D old_master_status;
> >
> >       return ret;
> >  }
> > --
> > 2.19.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
