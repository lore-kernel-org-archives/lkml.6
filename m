Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C828EC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9829A218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977531;
	bh=pm3JeSy63KrIYje1en2A7ML/QHGUlpAe4QFSXnLBIgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ePfzxsFwoIyu1HaPNJmaU45AJRQWALlmSXvXFQlMrkVbw8JJ6bVkwnicVSB1T9kKw
	 ZpEuMnXYQsUbOK0Ps0IjwjB4g6wsoDKsRHJWLcq9CrXLS7ZpDTJdHBSTSrgm+4W+Bh
	 NcnmCwRb5qY6qDnWMBRyx5GEOO4zJCeKeCF9rENY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfAHT33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbfAHT3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C543F20827;
        Tue,  8 Jan 2019 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975764;
        bh=pm3JeSy63KrIYje1en2A7ML/QHGUlpAe4QFSXnLBIgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GupwEUhs40T/I5yYLaOtCguR5InP2IwJRhu9Mx+tj622pdxrbojrdSvNc7NNu8wSg
         dpzCh7YR2p0ZLhncqLI3MerbiVU5pzlJqb5ubYRoZNqY38BSEQAjVrXlvmax5h6OqD
         RxehPzEiw0RlB2iUn6MNbXsinPG0KD2pMF3QYrOk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yanjiang Jin <yanjiang.jin@hxt-semitech.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 106/117] scsi: smartpqi: call pqi_free_interrupts() in pqi_shutdown()
Date:   Tue,  8 Jan 2019 14:26:14 -0500
Message-Id: <20190108192628.121270-106-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>

[ Upstream commit e57b2945aa654e48f85a41e8917793c64ecb9de8 ]

We must free all irqs during shutdown, else kexec's 2nd kernel would hang
in pqi_wait_for_completion_io() as below:

Call trace:

 pqi_wait_for_completion_io
 pqi_submit_raid_request_synchronous.constprop.78+0x23c/0x310 [smartpqi]
 pqi_configure_events+0xec/0x1f8 [smartpqi]
 pqi_ctrl_init+0x814/0xca0 [smartpqi]
 pqi_pci_probe+0x400/0x46c [smartpqi]
 local_pci_probe+0x48/0xb0
 pci_device_probe+0x14c/0x1b0
 really_probe+0x218/0x3fc
 driver_probe_device+0x70/0x140
 __driver_attach+0x11c/0x134
 bus_for_each_dev+0x70/0xc8
 driver_attach+0x30/0x38
 bus_add_driver+0x1f0/0x294
 driver_register+0x74/0x12c
 __pci_register_driver+0x64/0x70
 pqi_init+0xd0/0x10000 [smartpqi]
 do_one_initcall+0x60/0x1d8
 do_init_module+0x64/0x1f8
 load_module+0x10ec/0x1350
 __se_sys_finit_module+0xd4/0x100
 __arm64_sys_finit_module+0x28/0x34
 el0_svc_handler+0x104/0x160
 el0_svc+0x8/0xc

This happens only in the following combinations:

1. smartpqi is built as module, not built-in;
2. We have a disk connected to smartpqi card;
3. Both kexec's 1st and 2nd kernels use this disk as Rootfs' mount point.

Signed-off-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
Acked-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index c1efc182f5ea..6f4cb3be97aa 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6673,6 +6673,7 @@ static void pqi_shutdown(struct pci_dev *pci_dev)
 	 * storage.
 	 */
 	rc = pqi_flush_cache(ctrl_info, SHUTDOWN);
+	pqi_free_interrupts(ctrl_info);
 	pqi_reset(ctrl_info);
 	if (rc == 0)
 		return;
-- 
2.19.1

