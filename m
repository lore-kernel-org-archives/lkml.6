Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4054FC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108D8222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025618;
	bh=vVS6lAQzDXAktnPEMGAfPEIjQ1VcVA7sI9x3R6YY47I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BngtyPx3uFx9/jSuBeOirfQuBMrSbWG++L6QjSUQbbUKS+EiBjHoUnHMryZHxX7Th
	 KQbtt+qig0RQnHsFJ6z6keGa+KA2zf6GOGNeTiaR3vX4NylRWTd4U7kzl3eQXO2iYt
	 W1eI28WMUCMeKAQM/mU1j9TwYuvXs4XvVca9N5s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbfBMCkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:40:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388926AbfBMCkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8021222C2;
        Wed, 13 Feb 2019 02:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025611;
        bh=vVS6lAQzDXAktnPEMGAfPEIjQ1VcVA7sI9x3R6YY47I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqrIuqPVf3iclP0KiWvcOJ1gBjgNp+nTqALGHrbBObFy48v6wegxFkv/hcopLBjaN
         PSSZLDm7ilsO4kPGrnj6T5tuXfyJ7+P/QDBASmHeSxX4IVH4R1amIabpma2voM3AUh
         uRsFYzxrfUAZDVydLGrKG2sOmh4KA00EXSFo1b2E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/34] net: hns: Fix use after free identified by SLUB debug
Date:   Tue, 12 Feb 2019 21:39:33 -0500
Message-Id: <20190213023952.21311-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit bb989501abcafa0de5f18b0ec0ec459b5b817908 ]

When enable SLUB debug, than remove hns_enet_drv module, SLUB debug will
identify a use after free bug:

[134.189505] Unable to handle kernel paging request at virtual address
		006b6b6b6b6b6b6b
[134.197553] Mem abort info:
[134.200381]   ESR = 0x96000004
[134.203487]   Exception class = DABT (current EL), IL = 32 bits
[134.209497]   SET = 0, FnV = 0
[134.212596]   EA = 0, S1PTW = 0
[134.215777] Data abort info:
[134.218701]   ISV = 0, ISS = 0x00000004
[134.222596]   CM = 0, WnR = 0
[134.225606] [006b6b6b6b6b6b6b] address between user and kernel address ranges
[134.232851] Internal error: Oops: 96000004 [#1] SMP
[134.237798] CPU: 21 PID: 27834 Comm: rmmod Kdump: loaded Tainted: G
		OE     4.19.5-1.2.34.aarch64 #1
[134.247856] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.58 10/24/2018
[134.255181] pstate: 20000005 (nzCv daif -PAN -UAO)
[134.260044] pc : hns_ae_put_handle+0x38/0x60
[134.264372] lr : hns_ae_put_handle+0x24/0x60
[134.268700] sp : ffff00001be93c50
[134.272054] x29: ffff00001be93c50 x28: ffff802faaec8040
[134.277442] x27: 0000000000000000 x26: 0000000000000000
[134.282830] x25: 0000000056000000 x24: 0000000000000015
[134.288284] x23: ffff0000096fe098 x22: ffff000001050070
[134.293671] x21: ffff801fb3c044a0 x20: ffff80afb75ec098
[134.303287] x19: ffff80afb75ec098 x18: 0000000000000000
[134.312945] x17: 0000000000000000 x16: 0000000000000000
[134.322517] x15: 0000000000000002 x14: 0000000000000000
[134.332030] x13: dead000000000100 x12: ffff7e02bea3c988
[134.341487] x11: ffff80affbee9e68 x10: 0000000000000000
[134.351033] x9 : 6fffff8000008101 x8 : 0000000000000000
[134.360569] x7 : dead000000000100 x6 : ffff000009579748
[134.370059] x5 : 0000000000210d00 x4 : 0000000000000000
[134.379550] x3 : 0000000000000001 x2 : 0000000000000000
[134.388813] x1 : 6b6b6b6b6b6b6b6b x0 : 0000000000000000
[134.397993] Process rmmod (pid: 27834, stack limit = 0x00000000d474b7fd)
[134.408498] Call trace:
[134.414611]  hns_ae_put_handle+0x38/0x60
[134.422208]  hnae_put_handle+0xd4/0x108
[134.429563]  hns_nic_dev_remove+0x60/0xc0 [hns_enet_drv]
[134.438342]  platform_drv_remove+0x2c/0x70
[134.445958]  device_release_driver_internal+0x174/0x208
[134.454810]  driver_detach+0x70/0xd8
[134.461913]  bus_remove_driver+0x64/0xe8
[134.469396]  driver_unregister+0x34/0x60
[134.476822]  platform_driver_unregister+0x20/0x30
[134.485130]  hns_nic_dev_driver_exit+0x14/0x6e4 [hns_enet_drv]
[134.494634]  __arm64_sys_delete_module+0x238/0x290

struct hnae_handle is a member of struct hnae_vf_cb, so when vf_cb is
freed, than use hnae_handle will cause use after free panic.

This patch frees vf_cb after hnae_handle used.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
index a185a8be7999..53904f257b19 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -147,12 +147,10 @@ static void hns_ae_put_handle(struct hnae_handle *handle)
 	struct hnae_vf_cb *vf_cb = hns_ae_get_vf_cb(handle);
 	int i;
 
-	vf_cb->mac_cb	 = NULL;
-
-	kfree(vf_cb);
-
 	for (i = 0; i < handle->q_num; i++)
 		hns_ae_get_ring_pair(handle->qs[i])->used_by_vf = 0;
+
+	kfree(vf_cb);
 }
 
 static int hns_ae_wait_flow_down(struct hnae_handle *handle)
-- 
2.19.1

