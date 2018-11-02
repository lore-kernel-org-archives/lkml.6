Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7A7C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C98F20833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRHzJWom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C98F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeKCDrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeKCDrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:47:31 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73302082E;
        Fri,  2 Nov 2018 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183960;
        bh=f5pfC0kt7Y5cOgYYPOYX5XKbMoOtvFr2qmX4iB/rYfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRHzJWomsQgWbe+smXCea6NwrfZelPTmUXEA4ufBoKqMgLdEIv9Wr38MFzElr3aD7
         rS6Xur6FeaBe9ECcVSzG0CVnVGM7fWKuddP/TX187j8E6YFSLf3j7YC+kfgqBKEf/m
         bICGoECv5Y03gBQjfbveUYc1R2XOuR1ghqeweBMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nilesh Javali <nilesh.javali@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 035/150] scsi: qedi: Initialize the stats mutex lock
Date:   Fri,  2 Nov 2018 19:33:17 +0100
Message-Id: <20181102182905.765343894@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



