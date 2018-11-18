Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC935C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5BB20684
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 23:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=correia.cc header.i=@correia.cc header.b="FSDXrwNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5BB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=correia.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeKSKTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 05:19:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43904 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeKSKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 05:19:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so46008617qkr.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 15:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=correia.cc; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3d+/YdYOM8NQJFoDBh5dOeAj1fgfV300IGtwDWFaRk=;
        b=FSDXrwNZb/h15/qaGU95Cq3sTWIwGiPpTz4kx/CnnSMW3n6cCnAJrT8E+3WYUKh4gQ
         4sUbDeIFvz3hvmahD5VD4JhcxVimWYCIFAAGn43aQvatx5X75LSXR++MgLZcZC+bt8VU
         cueeaG1E31IIt1RyQ+wpC190oBeRMTwYexqfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k3d+/YdYOM8NQJFoDBh5dOeAj1fgfV300IGtwDWFaRk=;
        b=Q8dS1D70Y0VWWNM5QZei/p4pEXyld7CrUR6qzSkyrlOm6E0JK6baE4oEFSL0UflxsP
         kh2cwjU0cXg9yqYZSJv2a4Ngr7JSd8umQuV4F0yBgg+NlY9FNabKX0Cr1wFt1RtHFlQr
         efkaZJhOBqpeVNDZNwlYujsk+7uEtCTLQQVpagTd0HTBu+fXYJ2GDIowm2bUJKe72Kwp
         eE5L/M9FWtRODGoasr75dZbTF+3a3fhlx8aJpy+vxDIGfJPAfGWf9GBUbZCpTesZpfqN
         F9Dw8epOmAuiUNkkDB9yM+OQpuGbo9ISb2AB/5lFCC9DxeQfIbSaHDlM1aq5LYJUlJ9a
         CfZg==
X-Gm-Message-State: AGRZ1gKDJVS+MP54EuZOI7QXcLDSvsYqGFvyM6UOWS1/qyLiLlgJ9dU5
        VGn+avylABUmYRFV88oajHEDwQ==
X-Google-Smtp-Source: AJdET5fN0+Kq/FB/pJiYzF2t+GhRngo7rIhieJ1DXqIDXndinjB286pW3KQT/nd8oqggWJHFWLs5TA==
X-Received: by 2002:a0c:f689:: with SMTP id p9mr19741695qvn.52.1542585456862;
        Sun, 18 Nov 2018 15:57:36 -0800 (PST)
Received: from localhost.localdomain ([179.180.126.246])
        by smtp.googlemail.com with ESMTPSA id q72sm9868170qki.24.2018.11.18.15.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 15:57:36 -0800 (PST)
From:   Sergio Correia <sergio@correia.cc>
To:     maarten.lankhorst@linux.intel.com
Cc:     maxime.ripard@bootlin.com, sean@poorly.run, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sergio@correia.cc
Subject: [PATCH] drm: restore is_master upon failure in drm_new_set_master()
Date:   Sun, 18 Nov 2018 20:57:20 -0300
Message-Id: <20181118235720.3150-1-sergio@correia.cc>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When drm_new_set_master() fails, we restore the old master, however we may
have changed the is_master flag to 1, before failing, and it may be the
case it was 0 previously. Restore also this flag to its original state, in
case of failure.

Here is a problematic flow: we check is_master in drm_is_current_master(),
then proceed to call drm_lease_owner() passing master. If we do not restore
is_master status when drm_new_set_master() fails, we may have a situation
in which is_master will be 1 and master itself, NULL, leading to the deref
of a NULL pointer in drm_lease_owner().

This fixes the following OOPS, observed on an ArchLinux running a 4.19.2
kernel:

[   97.804282] BUG: unable to handle kernel NULL pointer dereference at 0000000000000080
[   97.807224] PGD 0 P4D 0
[   97.807224] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   97.807224] CPU: 0 PID: 1348 Comm: xfwm4 Tainted: P           OE     4.19.2-arch1-1-ARCH #1
[   97.807224] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./AB350 Pro4, BIOS P5.10 10/16/2018
[   97.807224] RIP: 0010:drm_lease_owner+0xd/0x20 [drm]
[   97.807224] Code: 83 c4 18 5b 5d c3 b8 ea ff ff ff eb e2 b8 ed ff ff ff eb db e8 b4 ca 68 fb 0f 1f 40 00 0f 1f 44 00 00 48 89 f8 eb 03 48 89 d0 <48> 8b 90 80 00 00 00 48 85 d2 75 f1 c3 66 0f 1f 44 00 00 0f 1f 44
[   97.807224] RSP: 0018:ffffb8cf08e07bb0 EFLAGS: 00010202
[   97.807224] RAX: 0000000000000000 RBX: ffff9cf0f2586c00 RCX: ffff9cf0f2586c88
[   97.807224] RDX: ffff9cf0ddbd8000 RSI: 0000000000000000 RDI: 0000000000000000
[   97.807224] RBP: ffff9cf1040e9800 R08: 0000000000000000 R09: 0000000000000000
[   97.807224] R10: ffffdeb30fd5d680 R11: ffffdeb30f5d6808 R12: ffff9cf1040e9888
[   97.807224] R13: 0000000000000000 R14: dead000000000200 R15: ffff9cf0f2586cc8
[   97.807224] FS:  00007f4145513180(0000) GS:ffff9cf10ea00000(0000) knlGS:0000000000000000
[   97.807224] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.807224] CR2: 0000000000000080 CR3: 00000003d7548000 CR4: 00000000003406f0
[   97.807224] Call Trace:
[   97.807224]  drm_is_current_master+0x1a/0x30 [drm]
[   97.807224]  drm_master_release+0x3e/0x130 [drm]
[   97.807224]  drm_file_free.part.0+0x2be/0x2d0 [drm]
[   97.807224]  drm_open+0x1ba/0x1e0 [drm]
[   97.807224]  drm_stub_open+0xaf/0xe0 [drm]
[   97.807224]  chrdev_open+0xa3/0x1b0
[   97.807224]  ? cdev_put.part.0+0x20/0x20
[   97.807224]  do_dentry_open+0x132/0x340
[   97.807224]  path_openat+0x2d1/0x14e0
[   97.807224]  ? mem_cgroup_commit_charge+0x7a/0x520
[   97.807224]  do_filp_open+0x93/0x100
[   97.807224]  ? __check_object_size+0x102/0x189
[   97.807224]  ? _raw_spin_unlock+0x16/0x30
[   97.807224]  do_sys_open+0x186/0x210
[   97.807224]  do_syscall_64+0x5b/0x170
[   97.807224]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   97.807224] RIP: 0033:0x7f4147b07976
[   97.807224] Code: 89 54 24 08 e8 7b f4 ff ff 8b 74 24 0c 48 8b 3c 24 41 89 c0 44 8b 54 24 08 b8 01 01 00 00 89 f2 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 30 44 89 c7 89 44 24 08 e8 a6 f4 ff ff 8b 44
[   97.807224] RSP: 002b:00007ffcced96ca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[   97.807224] RAX: ffffffffffffffda RBX: 00005619d5037f80 RCX: 00007f4147b07976
[   97.807224] RDX: 0000000000000002 RSI: 00005619d46b969c RDI: 00000000ffffff9c
[   98.040039] RBP: 0000000000000024 R08: 0000000000000000 R09: 0000000000000000
[   98.040039] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000024
[   98.040039] R13: 0000000000000012 R14: 00005619d5035950 R15: 0000000000000012
[   98.040039] Modules linked in: nct6775 hwmon_vid algif_skcipher af_alg nls_iso8859_1 nls_cp437 vfat fat uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common arc4 videodev media snd_usb_audio snd_hda_codec_hdmi snd_usbmidi_lib snd_rawmidi snd_seq_device mousedev input_leds iwlmvm mac80211 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec edac_mce_amd kvm_amd snd_hda_core kvm iwlwifi snd_hwdep r8169 wmi_bmof cfg80211 snd_pcm irqbypass snd_timer snd libphy soundcore pinctrl_amd rfkill pcspkr sp5100_tco evdev gpio_amdpt k10temp mac_hid i2c_piix4 wmi pcc_cpufreq acpi_cpufreq vboxnetflt(OE) vboxnetadp(OE) vboxpci(OE) vboxdrv(OE) msr sg crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 fscrypto uas usb_storage dm_crypt hid_generic usbhid hid
[   98.040039]  dm_mod raid1 md_mod sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel aes_x86_64 libata crypto_simd cryptd glue_helper ccp xhci_pci rng_core scsi_mod xhci_hcd nvidia_drm(POE) drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm agpgart nvidia_uvm(POE) nvidia_modeset(POE) nvidia(POE) ipmi_devintf ipmi_msghandler
[   98.040039] CR2: 0000000000000080
[   98.040039] ---[ end trace 3b65093b6fe62b2f ]---
[   98.040039] RIP: 0010:drm_lease_owner+0xd/0x20 [drm]
[   98.040039] Code: 83 c4 18 5b 5d c3 b8 ea ff ff ff eb e2 b8 ed ff ff ff eb db e8 b4 ca 68 fb 0f 1f 40 00 0f 1f 44 00 00 48 89 f8 eb 03 48 89 d0 <48> 8b 90 80 00 00 00 48 85 d2 75 f1 c3 66 0f 1f 44 00 00 0f 1f 44
[   98.040039] RSP: 0018:ffffb8cf08e07bb0 EFLAGS: 00010202
[   98.040039] RAX: 0000000000000000 RBX: ffff9cf0f2586c00 RCX: ffff9cf0f2586c88
[   98.040039] RDX: ffff9cf0ddbd8000 RSI: 0000000000000000 RDI: 0000000000000000
[   98.040039] RBP: ffff9cf1040e9800 R08: 0000000000000000 R09: 0000000000000000
[   98.040039] R10: ffffdeb30fd5d680 R11: ffffdeb30f5d6808 R12: ffff9cf1040e9888
[   98.040039] R13: 0000000000000000 R14: dead000000000200 R15: ffff9cf0f2586cc8
[   98.040039] FS:  00007f4145513180(0000) GS:ffff9cf10ea00000(0000) knlGS:0000000000000000
[   98.040039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   98.040039] CR2: 0000000000000080 CR3: 00000003d7548000 CR4: 00000000003406f0

Signed-off-by: Sergio Correia <sergio@correia.cc>
---
 drivers/gpu/drm/drm_auth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index d9c0f7573905..959a1ba5a3c6 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -138,11 +138,13 @@ static int drm_set_master(struct drm_device *dev, struct drm_file *fpriv,
 static int drm_new_set_master(struct drm_device *dev, struct drm_file *fpriv)
 {
 	struct drm_master *old_master;
+	int old_master_status;
 	int ret;
 
 	lockdep_assert_held_once(&dev->master_mutex);
 
 	old_master = fpriv->master;
+	old_master_status = fpriv->is_master;
 	fpriv->master = drm_master_create(dev);
 	if (!fpriv->master) {
 		fpriv->master = old_master;
@@ -170,6 +172,7 @@ static int drm_new_set_master(struct drm_device *dev, struct drm_file *fpriv)
 	/* drop references and restore old master on failure */
 	drm_master_put(&fpriv->master);
 	fpriv->master = old_master;
+	fpriv->is_master = old_master_status;
 
 	return ret;
 }
-- 
2.19.1

