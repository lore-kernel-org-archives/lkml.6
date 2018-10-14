Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCDDC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DF8204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DF8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeJNXSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:18:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36717 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728591AbeJNXSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:18:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM9-0004cA-Dr; Sun, 14 Oct 2018 16:31:01 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000Ha-SN; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.548146316@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 104/366] media: v4l2-compat-ioctl32: don't oops on
 overlay
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

commit 85ea29f19eab56ec16ec6b92bc67305998706afa upstream.

At put_v4l2_window32(), it tries to access kp->clips. However,
kp points to an userspace pointer. So, it should be obtained
via get_user(), otherwise it can OOPS:

 vivid-000: ==================  END STATUS  ==================
 BUG: unable to handle kernel paging request at 00000000fffb18e0
 IP: [<ffffffffc05468d9>] __put_v4l2_format32+0x169/0x220 [videodev]
 PGD 3f5776067 PUD 3f576f067 PMD 3f5769067 PTE 800000042548f067
 Oops: 0001 [#1] SMP
 Modules linked in: vivid videobuf2_vmalloc videobuf2_memops v4l2_dv_timings videobuf2_core v4l2_common videodev media xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables bluetooth rfkill binfmt_misc snd_hda_codec_hdmi i915 snd_hda_intel snd_hda_controller snd_hda_codec intel_rapl x86_pkg_temp_thermal snd_hwdep intel_powerclamp snd_pcm coretemp snd_seq_midi kvm_intel kvm snd_seq_midi_event snd_rawmidi i2c_algo_bit drm_kms_helper snd_seq drm crct10dif_pclmul e1000e snd_seq_device crc32_pclmul snd_timer ghash_clmulni_intel snd mei_me mei ptp pps_core soundcore lpc_ich video crc32c_intel [last unloaded: media]
 CPU: 2 PID: 28332 Comm: v4l2-compliance Not tainted 3.18.102+ #107
 Hardware name:                  /NUC5i7RYB, BIOS RYBDWi35.86A.0364.2017.0511.0949 05/11/2017
 task: ffff8804293f8000 ti: ffff8803f5640000 task.ti: ffff8803f5640000
 RIP: 0010:[<ffffffffc05468d9>]  [<ffffffffc05468d9>] __put_v4l2_format32+0x169/0x220 [videodev]
 RSP: 0018:ffff8803f5643e28  EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000fffb1ab4
 RDX: 00000000fffb1a68 RSI: 00000000fffb18d8 RDI: 00000000fffb1aa8
 RBP: ffff8803f5643e48 R08: 0000000000000001 R09: ffff8803f54b0378
 R10: 0000000000000000 R11: 0000000000000168 R12: 00000000fffb18c0
 R13: 00000000fffb1a94 R14: 00000000fffb18c8 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff880456d00000(0063) knlGS:00000000f7100980
 CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
 CR2: 00000000fffb18e0 CR3: 00000003f552b000 CR4: 00000000003407e0
 Stack:
  00000000fffb1a94 00000000c0cc5640 0000000000000056 ffff8804274f3600
  ffff8803f5643ed0 ffffffffc0547e16 0000000000000003 ffff8803f5643eb0
  ffffffff81301460 ffff88009db44b01 ffff880441942520 ffff8800c0d05640
 Call Trace:
  [<ffffffffc0547e16>] v4l2_compat_ioctl32+0x12d6/0x1b1d [videodev]
  [<ffffffff81301460>] ? file_has_perm+0x70/0xc0
  [<ffffffff81252a2c>] compat_SyS_ioctl+0xec/0x1200
  [<ffffffff8173241a>] sysenter_dispatch+0x7/0x21
 Code: 00 00 48 8b 80 48 c0 ff ff 48 83 e8 38 49 39 c6 0f 87 2b ff ff ff 49 8d 45 1c e8 a3 ce e3 c0 85 c0 0f 85 1a ff ff ff 41 8d 40 ff <4d> 8b 64 24 20 41 89 d5 48 8d 44 40 03 4d 8d 34 c4 eb 15 0f 1f
 RIP  [<ffffffffc05468d9>] __put_v4l2_format32+0x169/0x220 [videodev]
 RSP <ffff8803f5643e28>
 CR2: 00000000fffb18e0

Tested with vivid driver on Kernel v3.18.102.

Same bug happens upstream too:

 BUG: KASAN: user-memory-access in __put_v4l2_format32+0x98/0x4d0 [videodev]
 Read of size 8 at addr 00000000ffe48400 by task v4l2-compliance/8713

 CPU: 0 PID: 8713 Comm: v4l2-compliance Not tainted 4.16.0-rc4+ #108
 Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0364.2017.0511.0949 05/11/2017
 Call Trace:
  dump_stack+0x5c/0x7c
  kasan_report+0x164/0x380
  ? __put_v4l2_format32+0x98/0x4d0 [videodev]
  __put_v4l2_format32+0x98/0x4d0 [videodev]
  v4l2_compat_ioctl32+0x1aec/0x27a0 [videodev]
  ? __fsnotify_inode_delete+0x20/0x20
  ? __put_v4l2_format32+0x4d0/0x4d0 [videodev]
  compat_SyS_ioctl+0x646/0x14d0
  ? do_ioctl+0x30/0x30
  do_fast_syscall_32+0x191/0x3f4
  entry_SYSENTER_compat+0x6b/0x7a
 ==================================================================
 Disabling lock debugging due to kernel taint
 BUG: unable to handle kernel paging request at 00000000ffe48400
 IP: __put_v4l2_format32+0x98/0x4d0 [videodev]
 PGD 3a22fb067 P4D 3a22fb067 PUD 39b6f0067 PMD 39b6f1067 PTE 80000003256af067
 Oops: 0001 [#1] SMP KASAN
 Modules linked in: vivid videobuf2_vmalloc videobuf2_dma_contig videobuf2_memops v4l2_tpg v4l2_dv_timings videobuf2_v4l2 videobuf2_common v4l2_common videodev xt_CHECKSUM iptable_mangle ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack libcrc32c tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables bluetooth rfkill ecdh_generic binfmt_misc snd_hda_codec_hdmi intel_rapl x86_pkg_temp_thermal intel_powerclamp i915 coretemp snd_hda_intel snd_hda_codec kvm_intel snd_hwdep snd_hda_core kvm snd_pcm irqbypass crct10dif_pclmul crc32_pclmul snd_seq_midi ghash_clmulni_intel snd_seq_midi_event i2c_algo_bit intel_cstate snd_rawmidi intel_uncore snd_seq drm_kms_helper e1000e snd_seq_device snd_timer intel_rapl_perf
  drm ptp snd mei_me mei lpc_ich pps_core soundcore video crc32c_intel
 CPU: 0 PID: 8713 Comm: v4l2-compliance Tainted: G    B            4.16.0-rc4+ #108
 Hardware name:  /NUC5i7RYB, BIOS RYBDWi35.86A.0364.2017.0511.0949 05/11/2017
 RIP: 0010:__put_v4l2_format32+0x98/0x4d0 [videodev]
 RSP: 0018:ffff8803b9be7d30 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: ffff8803ac983e80 RCX: ffffffff8cd929f2
 RDX: 1ffffffff1d0a149 RSI: 0000000000000297 RDI: 0000000000000297
 RBP: 00000000ffe485c0 R08: fffffbfff1cf5123 R09: ffffffff8e7a8948
 R10: 0000000000000001 R11: fffffbfff1cf5122 R12: 00000000ffe483e0
 R13: 00000000ffe485c4 R14: ffff8803ac985918 R15: 00000000ffe483e8
 FS:  0000000000000000(0000) GS:ffff880407400000(0063) knlGS:00000000f7a46980
 CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
 CR2: 00000000ffe48400 CR3: 00000003a83f2003 CR4: 00000000003606f0
 Call Trace:
  v4l2_compat_ioctl32+0x1aec/0x27a0 [videodev]
  ? __fsnotify_inode_delete+0x20/0x20
  ? __put_v4l2_format32+0x4d0/0x4d0 [videodev]
  compat_SyS_ioctl+0x646/0x14d0
  ? do_ioctl+0x30/0x30
  do_fast_syscall_32+0x191/0x3f4
  entry_SYSENTER_compat+0x6b/0x7a
 Code: 4c 89 f7 4d 8d 7c 24 08 e8 e6 a4 69 cb 48 8b 83 98 1a 00 00 48 83 e8 10 49 39 c7 0f 87 9d 01 00 00 49 8d 7c 24 20 e8 c8 a4 69 cb <4d> 8b 74 24 20 4c 89 ef 4c 89 fe ba 10 00 00 00 e8 23 d9 08 cc
 RIP: __put_v4l2_format32+0x98/0x4d0 [videodev] RSP: ffff8803b9be7d30
 CR2: 00000000ffe48400

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -101,7 +101,7 @@ static int get_v4l2_window32(struct v4l2
 static int put_v4l2_window32(struct v4l2_window __user *kp,
 			     struct v4l2_window32 __user *up)
 {
-	struct v4l2_clip __user *kclips = kp->clips;
+	struct v4l2_clip __user *kclips;
 	struct v4l2_clip32 __user *uclips;
 	compat_caddr_t p;
 	u32 clipcount;
@@ -116,6 +116,8 @@ static int put_v4l2_window32(struct v4l2
 	if (!clipcount)
 		return 0;
 
+	if (get_user(kclips, &kp->clips))
+		return -EFAULT;
 	if (get_user(p, &up->clips))
 		return -EFAULT;
 	uclips = compat_ptr(p);

