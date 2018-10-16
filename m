Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD928C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E253208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTk0dMzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E253208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeJPMBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeJPMBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD1F12098A;
        Tue, 16 Oct 2018 04:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663179;
        bh=KNgnDeGvd28vGaktu3TDP1YrEZaumm0in6S8OnlgiwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MTk0dMzTeak0HhlcuoIqyR6o0zsjaP65MfddWw/uvaq9y0WrS9h+zhdyCN/8lKFXP
         QbxsgU46qJSl6vlL+KRkIxhcEgzMn4C+BFZ51/v0eaAVUp9VBNdj88VBFHMD7ZXIu/
         R8oZw4foO8JaOlAoKDJgSh+y5J5rliPbPbqBvaOk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nilesh Javali <nilesh.javali@cavium.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 039/100] scsi: qedi: Initialize the stats mutex lock
Date:   Tue, 16 Oct 2018 00:11:20 -0400
Message-Id: <20181016041221.135528-39-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nilesh Javali <nilesh.javali@cavium.com>

[ Upstream commit 3cc5746e5ad7688e274e193fa71278d98aa52759 ]

Fix kernel NULL pointer dereference,

Call Trace:
  [<ffffffff9b7658e6>] __mutex_lock_slowpath+0xa6/0x1d0
  [<ffffffff9b764cef>] mutex_lock+0x1f/0x2f
  [<ffffffffc061b5e1>] qedi_get_protocol_tlv_data+0x61/0x450 [qedi]
  [<ffffffff9b1f9d8e>] ? map_vm_area+0x2e/0x40
  [<ffffffff9b1fc370>] ? __vmalloc_node_range+0x170/0x280
  [<ffffffffc0b81c3d>] ? qed_mfw_process_tlv_req+0x27d/0xbd0 [qed]
  [<ffffffffc0b6461b>] qed_mfw_fill_tlv_data+0x4b/0xb0 [qed]
  [<ffffffffc0b81c59>] qed_mfw_process_tlv_req+0x299/0xbd0 [qed]
  [<ffffffff9b02a59e>] ? __switch_to+0xce/0x580
  [<ffffffffc0b61e5b>] qed_slowpath_task+0x5b/0x80 [qed]

Signed-off-by: Nilesh Javali <nilesh.javali@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 3e18a68c2b03..054e66d93ed6 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2472,6 +2472,7 @@ static int __qedi_probe(struct pci_dev *pdev, int mode)
 		/* start qedi context */
 		spin_lock_init(&qedi->hba_lock);
 		spin_lock_init(&qedi->task_idx_lock);
+		mutex_init(&qedi->stats_lock);
 	}
 	qedi_ops->ll2->register_cb_ops(qedi->cdev, &qedi_ll2_cb_ops, qedi);
 	qedi_ops->ll2->start(qedi->cdev, &params);
-- 
2.17.1

