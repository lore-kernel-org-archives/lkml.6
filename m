Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB172089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnjnI7OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB172089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeKZV6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeKZV6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF90620672;
        Mon, 26 Nov 2018 11:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230260;
        bh=Fzr7sv/NyJj/RGar7BK/Lo3vYtd7hLTiF5OSFsRyqlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnjnI7OYrXJOGcPzzb0nkMklygd0PfgTeW9ptlt7QF72TEk3Kfg6AH93qEmEqA4Tz
         1ReZhMz9J/QJdrIXonlALcwBD0fpAO6hxb3HqrE94anyQRLOaV3e4GU3bVQdBWq7hB
         Ur8FdRcQXpkeOQ1EjWziVDlzL8kPTNbdbsk7eoBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 067/118] drm/amd/amdgpu/dm: Fix dm_dp_create_fake_mst_encoder()
Date:   Mon, 26 Nov 2018 11:51:01 +0100
Message-Id: <20181126105103.609632499@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 63237f8748bdf46dccf79ef8f98f05e9fe799162 ]

[why]
Removing connector reusage from DM to match the rest of the tree ended
up revealing an issue that was surprisingly subtle. The original amdgpu
code for DC that was submitted appears to have left a chunk in
dm_dp_create_fake_mst_encoder() that tries to find a "master encoder",
the likes of which isn't actually used or stored anywhere. It does so at
the wrong time as well by trying to access parts of the drm_connector
from the encoder init before it's actually been initialized. This
results in a NULL pointer deref on MST hotplugs:

[  160.696613] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[  160.697234] PGD 0 P4D 0
[  160.697814] Oops: 0010 [#1] SMP PTI
[  160.698430] CPU: 2 PID: 64 Comm: kworker/2:1 Kdump: loaded Tainted: G           O      4.19.0Lyude-Test+ #2
[  160.699020] Hardware name: HP HP ZBook 15 G4/8275, BIOS P70 Ver. 01.22 05/17/2018
[  160.699672] Workqueue: events_long drm_dp_mst_link_probe_work [drm_kms_helper]
[  160.700322] RIP: 0010:          (null)
[  160.700920] Code: Bad RIP value.
[  160.701541] RSP: 0018:ffffc9000029fc78 EFLAGS: 00010206
[  160.702183] RAX: 0000000000000000 RBX: ffff8804440ed468 RCX: ffff8804440e9158
[  160.702778] RDX: 0000000000000000 RSI: ffff8804556c5700 RDI: ffff8804440ed000
[  160.703408] RBP: ffff880458e21800 R08: 0000000000000002 R09: 000000005fca0a25
[  160.704002] R10: ffff88045a077a3d R11: ffff88045a077a3c R12: ffff8804440ed000
[  160.704614] R13: ffff880458e21800 R14: ffff8804440e9000 R15: ffff8804440e9000
[  160.705260] FS:  0000000000000000(0000) GS:ffff88045f280000(0000) knlGS:0000000000000000
[  160.705854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  160.706478] CR2: ffffffffffffffd6 CR3: 000000000200a001 CR4: 00000000003606e0
[  160.707124] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  160.707724] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  160.708372] Call Trace:
[  160.708998]  ? dm_dp_add_mst_connector+0xed/0x1d0 [amdgpu]
[  160.709625]  ? drm_dp_add_port+0x2fa/0x470 [drm_kms_helper]
[  160.710284]  ? wake_up_q+0x54/0x70
[  160.710877]  ? __mutex_unlock_slowpath.isra.18+0xb3/0x110
[  160.711512]  ? drm_dp_dpcd_access+0xe7/0x110 [drm_kms_helper]
[  160.712161]  ? drm_dp_send_link_address+0x155/0x1e0 [drm_kms_helper]
[  160.712762]  ? drm_dp_check_and_send_link_address+0xa3/0xd0 [drm_kms_helper]
[  160.713408]  ? drm_dp_mst_link_probe_work+0x4b/0x80 [drm_kms_helper]
[  160.714013]  ? process_one_work+0x1a1/0x3a0
[  160.714667]  ? worker_thread+0x30/0x380
[  160.715326]  ? wq_update_unbound_numa+0x10/0x10
[  160.715939]  ? kthread+0x112/0x130
[  160.716591]  ? kthread_create_worker_on_cpu+0x70/0x70
[  160.717262]  ? ret_from_fork+0x35/0x40
[  160.717886] Modules linked in: amdgpu(O) vfat fat snd_hda_codec_generic joydev i915 chash gpu_sched ttm i2c_algo_bit drm_kms_helper snd_hda_codec_hdmi hp_wmi syscopyarea iTCO_wdt sysfillrect sparse_keymap sysimgblt fb_sys_fops snd_hda_intel usbhid wmi_bmof drm snd_hda_codec btusb snd_hda_core intel_rapl btrtl x86_pkg_temp_thermal btbcm btintel coretemp snd_pcm crc32_pclmul bluetooth psmouse snd_timer snd pcspkr i2c_i801 mei_me i2c_core soundcore mei tpm_tis wmi tpm_tis_core hp_accel ecdh_generic lis3lv02d tpm video rfkill acpi_pad input_polldev hp_wireless pcc_cpufreq crc32c_intel serio_raw tg3 xhci_pci xhci_hcd [last unloaded: amdgpu]
[  160.720141] CR2: 0000000000000000

Somehow the connector reusage DM was using for MST connectors managed to
paper over this issue entirely; hence why this was never caught until
now.

[how]
Since this code isn't used anywhere and seems useless anyway, we can
just drop it entirely. This appears to fix the issue on my HP ZBook with
an AMD WX4150.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 4b08359e18bd..4cc45a1d21db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -317,12 +317,7 @@ dm_dp_create_fake_mst_encoder(struct amdgpu_dm_connector *connector)
 	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_encoder *amdgpu_encoder;
 	struct drm_encoder *encoder;
-	const struct drm_connector_helper_funcs *connector_funcs =
-		connector->base.helper_private;
-	struct drm_encoder *enc_master =
-		connector_funcs->best_encoder(&connector->base);
 
-	DRM_DEBUG_KMS("enc master is %p\n", enc_master);
 	amdgpu_encoder = kzalloc(sizeof(*amdgpu_encoder), GFP_KERNEL);
 	if (!amdgpu_encoder)
 		return NULL;
-- 
2.17.1



