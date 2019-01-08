Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82928C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5287720645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976133;
	bh=qZ42c2a7cTdpDt8IXVmHQpc4wmuUgzNnae2D8iGBQcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dHgWumXov5L9wm65RLXp7GbofrSJX4hiJhjcPxgp8xPf1B8ttmEr+ru4yCTEPCRmJ
	 jKV8NJKYBShZyF5ez+kCa2nL+1X7PkxedbZcp3PiM2KDOnkGtpOi7fZypGh0p5VsCz
	 KRr/QwTHO8jt8bwc6WP+NHSySnkABk1zjLV4Dby0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfAHTfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:35:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732261AbfAHTf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:35:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5603020827;
        Tue,  8 Jan 2019 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976125;
        bh=qZ42c2a7cTdpDt8IXVmHQpc4wmuUgzNnae2D8iGBQcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSQ/cJjMnRbbcxQxrevL0uK5lEoc0L39kQOweX0DGzvODC0bi/Jr6uO/XLyMkbyph
         hbjY3mHHM0zeHAo6puf9G00zDA6o7/TOkCModHLmgnfIVeTJcFbjQsbtik3K6j/Mvp
         21Lef4lJQqmaa6gGwQRy5srmbOZOkGsXY9qjMDXA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 25/28] scsi: megaraid: fix out-of-bound array accesses
Date:   Tue,  8 Jan 2019 14:34:42 -0500
Message-Id: <20190108193445.124251-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193445.124251-1-sashal@kernel.org>
References: <20190108193445.124251-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit c7a082e4242fd8cd21a441071e622f87c16bdacc ]

UBSAN reported those with MegaRAID SAS-3 3108,

[   77.467308] UBSAN: Undefined behaviour in drivers/scsi/megaraid/megaraid_sas_fp.c:117:32
[   77.475402] index 255 is out of range for type 'MR_LD_SPAN_MAP [1]'
[   77.481677] CPU: 16 PID: 333 Comm: kworker/16:1 Not tainted 4.20.0-rc5+ #1
[   77.488556] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
[   77.495791] Workqueue: events work_for_cpu_fn
[   77.500154] Call trace:
[   77.502610]  dump_backtrace+0x0/0x2c8
[   77.506279]  show_stack+0x24/0x30
[   77.509604]  dump_stack+0x118/0x19c
[   77.513098]  ubsan_epilogue+0x14/0x60
[   77.516765]  __ubsan_handle_out_of_bounds+0xfc/0x13c
[   77.521767]  mr_update_load_balance_params+0x150/0x158 [megaraid_sas]
[   77.528230]  MR_ValidateMapInfo+0x2cc/0x10d0 [megaraid_sas]
[   77.533825]  megasas_get_map_info+0x244/0x2f0 [megaraid_sas]
[   77.539505]  megasas_init_adapter_fusion+0x9b0/0xf48 [megaraid_sas]
[   77.545794]  megasas_init_fw+0x1ab4/0x3518 [megaraid_sas]
[   77.551212]  megasas_probe_one+0x2c4/0xbe0 [megaraid_sas]
[   77.556614]  local_pci_probe+0x7c/0xf0
[   77.560365]  work_for_cpu_fn+0x34/0x50
[   77.564118]  process_one_work+0x61c/0xf08
[   77.568129]  worker_thread+0x534/0xa70
[   77.571882]  kthread+0x1c8/0x1d0
[   77.575114]  ret_from_fork+0x10/0x1c

[   89.240332] UBSAN: Undefined behaviour in drivers/scsi/megaraid/megaraid_sas_fp.c:117:32
[   89.248426] index 255 is out of range for type 'MR_LD_SPAN_MAP [1]'
[   89.254700] CPU: 16 PID: 95 Comm: kworker/u130:0 Not tainted 4.20.0-rc5+ #1
[   89.261665] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
[   89.268903] Workqueue: events_unbound async_run_entry_fn
[   89.274222] Call trace:
[   89.276680]  dump_backtrace+0x0/0x2c8
[   89.280348]  show_stack+0x24/0x30
[   89.283671]  dump_stack+0x118/0x19c
[   89.287167]  ubsan_epilogue+0x14/0x60
[   89.290835]  __ubsan_handle_out_of_bounds+0xfc/0x13c
[   89.295828]  MR_LdRaidGet+0x50/0x58 [megaraid_sas]
[   89.300638]  megasas_build_io_fusion+0xbb8/0xd90 [megaraid_sas]
[   89.306576]  megasas_build_and_issue_cmd_fusion+0x138/0x460 [megaraid_sas]
[   89.313468]  megasas_queue_command+0x398/0x3d0 [megaraid_sas]
[   89.319222]  scsi_dispatch_cmd+0x1dc/0x8a8
[   89.323321]  scsi_request_fn+0x8e8/0xdd0
[   89.327249]  __blk_run_queue+0xc4/0x158
[   89.331090]  blk_execute_rq_nowait+0xf4/0x158
[   89.335449]  blk_execute_rq+0xdc/0x158
[   89.339202]  __scsi_execute+0x130/0x258
[   89.343041]  scsi_probe_and_add_lun+0x2fc/0x1488
[   89.347661]  __scsi_scan_target+0x1cc/0x8c8
[   89.351848]  scsi_scan_channel.part.3+0x8c/0xc0
[   89.356382]  scsi_scan_host_selected+0x130/0x1f0
[   89.361002]  do_scsi_scan_host+0xd8/0xf0
[   89.364927]  do_scan_async+0x9c/0x320
[   89.368594]  async_run_entry_fn+0x138/0x420
[   89.372780]  process_one_work+0x61c/0xf08
[   89.376793]  worker_thread+0x13c/0xa70
[   89.380546]  kthread+0x1c8/0x1d0
[   89.383778]  ret_from_fork+0x10/0x1c

This is because when populating Driver Map using firmware raid map, all
non-existing VDs set their ldTgtIdToLd to 0xff, so it can be skipped later.

From drivers/scsi/megaraid/megaraid_sas_base.c ,
memset(instance->ld_ids, 0xff, MEGASAS_MAX_LD_IDS);

From drivers/scsi/megaraid/megaraid_sas_fp.c ,
/* For non existing VDs, iterate to next VD*/
if (ld >= (MAX_LOGICAL_DRIVES_EXT - 1))
	continue;

However, there are a few places that failed to skip those non-existing VDs
due to off-by-one errors. Then, those 0xff leaked into MR_LdRaidGet(0xff,
map) and triggered the out-of-bound accesses.

Fixes: 51087a8617fe ("megaraid_sas : Extended VD support")
Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_fp.c     | 2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index 741509b35617..14f32c114c55 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -1273,7 +1273,7 @@ void mr_update_load_balance_params(struct MR_DRV_RAID_MAP_ALL *drv_map,
 
 	for (ldCount = 0; ldCount < MAX_LOGICAL_DRIVES_EXT; ldCount++) {
 		ld = MR_TargetIdToLdGet(ldCount, drv_map);
-		if (ld >= MAX_LOGICAL_DRIVES_EXT) {
+		if (ld >= MAX_LOGICAL_DRIVES_EXT - 1) {
 			lbInfo[ldCount].loadBalanceFlag = 0;
 			continue;
 		}
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 213944ed64d9..3d3bfa814093 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1758,7 +1758,7 @@ static void megasas_build_ld_nonrw_fusion(struct megasas_instance *instance,
 		device_id < instance->fw_supported_vd_count)) {
 
 		ld = MR_TargetIdToLdGet(device_id, local_map_ptr);
-		if (ld >= instance->fw_supported_vd_count)
+		if (ld >= instance->fw_supported_vd_count - 1)
 			fp_possible = 0;
 
 		raid = MR_LdRaidGet(ld, local_map_ptr);
-- 
2.19.1

