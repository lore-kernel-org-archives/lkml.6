Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B03C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BE321726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359630;
	bh=vqL0QJUNtICeW0YEg+E1s1bFFDXi0N8fX0S5jCNZce4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KDubaP2tQULkxnCRCIhXn2Fl/Qt0jsUfzAF+R1YSn17O5qZOqksMg0tq1FchrB6QI
	 LADymEXyJ69ozW0KYfycOugrqfy3b57Z2i69JHlp5atdkNgRszUysEMTupX89/JE+r
	 DuTdsHlzbV49kSTEjnzDSWFrZzPyB4p3NYzvhytU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbfAXTxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:53:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732742AbfAXTh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C723121906;
        Thu, 24 Jan 2019 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358678;
        bh=vqL0QJUNtICeW0YEg+E1s1bFFDXi0N8fX0S5jCNZce4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9yq4f7ExzKWuzBtym/2p1OPm12MY8OLI7EP1B6BbaUDSSVE98bZvSWSsS1tl17P/
         VMU/7GRA2TS8BZouWgcXsD2l+Zpfg1pPkUtHmitsYPhew1TaKvlHP8JtTVtM1wEQzy
         ysxL9NTWijnXGz1Ug5ByMPS9+jkxb6R2xh+v+06k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yanjiang Jin <yanjiang.jin@hxt-semitech.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/106] scsi: smartpqi: call pqi_free_interrupts() in pqi_shutdown()
Date:   Thu, 24 Jan 2019 20:20:49 +0100
Message-Id: <20190124190211.873591255@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index c62df3eefd5a..8c1a232ac6bf 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6689,6 +6689,7 @@ static void pqi_shutdown(struct pci_dev *pci_dev)
 	 * storage.
 	 */
 	rc = pqi_flush_cache(ctrl_info, SHUTDOWN);
+	pqi_free_interrupts(ctrl_info);
 	pqi_reset(ctrl_info);
 	if (rc == 0)
 		return;
-- 
2.19.1



