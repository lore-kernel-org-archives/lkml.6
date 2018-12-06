Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23C0C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80FF2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80FF2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLFPyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:54:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:45417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeLFPyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:54:52 -0500
Received: from ovpn-121-90.rdu2.redhat.com ([71.184.117.43]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MATlG-1gc7mH1uUE-00BdkE; Thu, 06 Dec 2018 16:54:31 +0100
From:   Qian Cai <cai@gmx.us>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        thenzl@redhat.com, hch@lst.de, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@gmx.us>
Subject: [PATCH] megaraid: fix a out-of-bound array access
Date:   Thu,  6 Dec 2018 10:53:51 -0500
Message-Id: <20181206155351.36099-1-cai@gmx.us>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <d2fe9d6a-3716-98d2-e311-74188b259038@gmx.us>
References: <d2fe9d6a-3716-98d2-e311-74188b259038@gmx.us>
X-Provags-ID: V03:K1:tm8mLoXcpH6mLrFe1z1+RD0LqfTph8zeq6YMKanVxUXFlT6hwbe
 jeueZ6rb4ERD6by0+IJX6pEo0OF8ylCLgHA4MSBaqZFYvUfiiUe/qrZRJs8b9haXivAqPVk
 EFWwF507lRq809WTcHOVWaKN+Xhmx7UcIFRA4hstNKcJ+jcWtb+A9lHn2lcTHFC78OwvTVF
 Wua/6gyCXGyV0OzN4YsTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zAUwTYy3VFk=:oCIZGyqgUp31WLGxlWZSQk
 6JKVI3U0v952qsy1ipq1wuDlADDIsQrGyTg/r7H3bHKMq0VnBlWOAmEiRsaScYKI7Z5kVgk1K
 Cau1hV5eVWrRmigr2uXuGdCWF0aRW6yOsJTkTxCw/doZWnoXR1YYdE7fGiBur5vymV+0ekLox
 6CAjAjFeWuvvHXBTlgB+6JyV+uBQ34UPf/+XvNkrE6//3O3HqzErTK/z3+ApRnftK+aibLLON
 Qty2T+uCJdSsG9XqZlgODlubIP7wGPxndug4GgEpkLgQqrOCS61Y0/LS+S05JflpkiXUyK0zq
 2Zs8kBnONvHA+N5RkszUccODvz4ml2CuNK9sXKs5jbqdrZ8AmlgXNrNV6IVY+OdSVkrra1Ymh
 w2RluUZPUpRNCdYe3VtZTHPz/o4xOacbS/Q1B0O20e50Hf54IAeWD2/UJXNjzohIEBNdgymze
 AYR4jdT9JxYE4g5LrOGH6ie0DkQFSiRLndmhscPFU0yY8BF28Q4tXdlKdgFozIWY7g8HbAMvD
 mpPtJMeS+/avJ6Bj3zKMtSxjPoVM65V2QaMSDATipKMUFCZ2BHI0DDNzQ2Ykm2c64cC55gmqQ
 q4x7NpZdYZlyNoWtInpjVS0frQJmXHlc4Xq3GbbA6bGpJG7aSnCAXbVtFeh2mpFo/m7dWAvgp
 s9jQ4U7Nv68iPF1KPUBr3z+D54FoFm9lBg/Sb1mLrogg+ZGALgUQpYeYm26E5beBG1Po5RjVH
 BaDuFf+juBaJM9UOA26IxGBXbJuUEgVS5ckinUGIvrPnceoWUgU9kGM1Rt2UUOfHGfAn56D32
 UxHeTAtWtHg/gxElt2GiXMsatbw6gQN4klLEalFdsmIO0kRNgE8pXTATjcwbSWY9Gd5iz1e3C
 vE7w5iNKbrroHAyBgm1A45w2wy842lfEBYTvzRLiI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
non-existing VDs set their ldTgtIdToLd to 0xff, so it can be skipped
later. However, there are a few places that failed to skip those
non-existing VDs due to off-by-one errors. Then, those 0xff leaked into
MR_LdRaidGet(0xff, map) and triggered the out-of-bound access.

Fixes: 51087a8617fe (megaraid_sas : Extended VD support)
Signed-off-by: Qian Cai <cai@gmx.us>
---
 drivers/scsi/megaraid/megaraid_sas_fp.c     | 2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
index 59ecbb3b53b5..a33628550425 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -1266,7 +1266,7 @@ void mr_update_load_balance_params(struct MR_DRV_RAID_MAP_ALL *drv_map,
 
 	for (ldCount = 0; ldCount < MAX_LOGICAL_DRIVES_EXT; ldCount++) {
 		ld = MR_TargetIdToLdGet(ldCount, drv_map);
-		if (ld >= MAX_LOGICAL_DRIVES_EXT) {
+		if (ld >= MAX_LOGICAL_DRIVES_EXT - 1) {
 			lbInfo[ldCount].loadBalanceFlag = 0;
 			continue;
 		}
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index f74b5ea24f0f..8e0ac206dabc 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2829,7 +2829,7 @@ static void megasas_build_ld_nonrw_fusion(struct megasas_instance *instance,
 	pRAID_Context->reg_lock_length    = 0;
 
 	if (fusion->fast_path_io && (
-		device_id < instance->fw_supported_vd_count)) {
+		device_id < instance->fw_supported_vd_count - 1)) {
 
 		ld = MR_TargetIdToLdGet(device_id, local_map_ptr);
 		if (ld >= instance->fw_supported_vd_count)
-- 
2.17.2 (Apple Git-113)

