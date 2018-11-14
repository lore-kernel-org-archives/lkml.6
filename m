Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D925C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BA82243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiNygtLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BA82243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbeKOInL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:43:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeKOI3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:23 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7E02252A;
        Wed, 14 Nov 2018 22:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234258;
        bh=QpBF6l4Q6IjavuhRTwsIQOr8odQLNFZAAoSfNK7cMrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiNygtLbDQjKlSJt2f+tU5h86GzaGCD0aysJ3ffLgqi7SGvm35sdB9nZ9b4iE2f4z
         +S3PJu5xJkgqJcFZIphNn6/z8gs0wW5P5A5CgAyRwYGkq6XTkclwnxLKgtBSIbULNU
         gcrpmM5SYOGRoj6JKKZpqPqO2CKJjcRiHKE9i6uM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 20/59] net: hns3: Fix for out-of-bounds access when setting pfc back pressure
Date:   Wed, 14 Nov 2018 17:22:52 -0500
Message-Id: <20181114222335.99339-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit e8ccbb7d2f53c62e14b889faaa3f6f809b657278 ]

The vport should be initialized to hdev->vport for each bp group,
otherwise it will cause out-of-bounds access and bp setting not
correct problem.

[   35.254124] BUG: KASAN: slab-out-of-bounds in hclge_pause_setup_hw+0x2a0/0x3f8 [hclge]
[   35.254126] Read of size 2 at addr ffff803b6651581a by task kworker/0:1/14

[   35.254132] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.19.0-rc7-hulk+ #85
[   35.254133] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 - B052 (V0.52) 09/14/2018
[   35.254141] Workqueue: events work_for_cpu_fn
[   35.254144] Call trace:
[   35.254147]  dump_backtrace+0x0/0x2f0
[   35.254149]  show_stack+0x24/0x30
[   35.254154]  dump_stack+0x110/0x184
[   35.254157]  print_address_description+0x168/0x2b0
[   35.254160]  kasan_report+0x184/0x310
[   35.254162]  __asan_load2+0x7c/0xa0
[   35.254170]  hclge_pause_setup_hw+0x2a0/0x3f8 [hclge]
[   35.254177]  hclge_tm_init_hw+0x794/0x9f0 [hclge]
[   35.254184]  hclge_tm_schd_init+0x48/0x58 [hclge]
[   35.254191]  hclge_init_ae_dev+0x778/0x1168 [hclge]
[   35.254196]  hnae3_register_ae_dev+0x14c/0x298 [hnae3]
[   35.254206]  hns3_probe+0x88/0xa8 [hns3]
[   35.254210]  local_pci_probe+0x7c/0xf0
[   35.254212]  work_for_cpu_fn+0x34/0x50
[   35.254214]  process_one_work+0x4d4/0xa38
[   35.254216]  worker_thread+0x55c/0x8d8
[   35.254219]  kthread+0x1b0/0x1b8
[   35.254222]  ret_from_fork+0x10/0x1c

[   35.254224] The buggy address belongs to the page:
[   35.254228] page:ffff7e00ed994400 count:1 mapcount:0 mapping:0000000000000000 index:0x0 compound_mapcount: 0
[   35.273835] flags: 0xfffff8000008000(head)
[   35.282007] raw: 0fffff8000008000 dead000000000100 dead000000000200 0000000000000000
[   35.282010] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[   35.282012] page dumped because: kasan: bad access detected

[   35.282014] Memory state around the buggy address:
[   35.282017]  ffff803b66515700: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[   35.282019]  ffff803b66515780: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[   35.282021] >ffff803b66515800: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[   35.282022]                             ^
[   35.282024]  ffff803b66515880: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[   35.282026]  ffff803b66515900: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[   35.282028] ==================================================================
[   35.282029] Disabling lock debugging due to kernel taint
[   35.282747] hclge driver initialization finished.

Fixes: 67bf2541f4b9 ("net: hns3: Fixes the back pressure setting when sriov is enabled")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index f027fceea548..b9a59bcbcc3c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1173,14 +1173,14 @@ static int hclge_pfc_setup_hw(struct hclge_dev *hdev)
  */
 static int hclge_bp_setup_hw(struct hclge_dev *hdev, u8 tc)
 {
-	struct hclge_vport *vport = hdev->vport;
-	u32 i, k, qs_bitmap;
-	int ret;
+	int i;
 
 	for (i = 0; i < HCLGE_BP_GRP_NUM; i++) {
-		qs_bitmap = 0;
+		u32 qs_bitmap = 0;
+		int k, ret;
 
 		for (k = 0; k < hdev->num_alloc_vport; k++) {
+			struct hclge_vport *vport = &hdev->vport[k];
 			u16 qs_id = vport->qs_offset + tc;
 			u8 grp, sub_grp;
 
@@ -1190,8 +1190,6 @@ static int hclge_bp_setup_hw(struct hclge_dev *hdev, u8 tc)
 						 HCLGE_BP_SUB_GRP_ID_S);
 			if (i == grp)
 				qs_bitmap |= (1 << sub_grp);
-
-			vport++;
 		}
 
 		ret = hclge_tm_qs_bp_cfg(hdev, tc, i, qs_bitmap);
-- 
2.17.1

