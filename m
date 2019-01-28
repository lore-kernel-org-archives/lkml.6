Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E902DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28482177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691948;
	bh=WxyQF8ao2ZZQP9+yGZb0W04joDBGKyz64zqK5fKbsT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BL02UsNkeum3T4o1x2Bb9N8pJAoAsxSDKkK8lHzrJ88w1GUcve/+7vIgVBn6WULso
	 4dFAgcyR5LxJ5FHNoHf0GjZCfk6OthRmW2sjEH7fiyuh3Wog2Q1yfItrbWWTw6Sbr4
	 pnUUBEX3JmfN4kpeF8Y6h8U10YCNjLs8OfciMJ1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbfA1QM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:12:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733150AbfA1QMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:12:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB2E52175B;
        Mon, 28 Jan 2019 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691943;
        bh=WxyQF8ao2ZZQP9+yGZb0W04joDBGKyz64zqK5fKbsT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+DIySEusSVexVcFPDQrIImPuvdGboDz4Xia6LMP94WVN77+lBae4ZxUNPhVCvrHP
         DiAmkRvuns3lGsaG7kdJ95xWjauzwQtYCL+j67ml0ayR/56z3PYEXT2G5KioZPJ5zc
         StYCpfiQInfAkT9+NiAdly86V3m6Tq7WlT36s5z0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 009/170] scsi: mpt3sas: Call sas_remove_host before removing the target devices
Date:   Mon, 28 Jan 2019 11:09:19 -0500
Message-Id: <20190128161200.55107-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

[ Upstream commit dc730212e8a378763cb182b889f90c8101331332 ]

Call sas_remove_host() before removing the target devices in the driver's
.remove() callback function(i.e. during driver unload time).  So that
driver can provide a way to allow SYNC CACHE, START STOP unit commands
etc. (which are issued from SML) to the target drives during driver unload
time.

Once sas_remove_host() is called before removing the target drives then
driver can just clean up the resources allocated for target devices and no
need to call sas_port_delete_phy(), sas_port_delete() API's as these API's
internally called from sas_remove_host().

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index ae5e579ac473..b28efddab7b1 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -8260,6 +8260,7 @@ static void scsih_remove(struct pci_dev *pdev)
 
 	/* release all the volumes */
 	_scsih_ir_shutdown(ioc);
+	sas_remove_host(shost);
 	list_for_each_entry_safe(raid_device, next, &ioc->raid_device_list,
 	    list) {
 		if (raid_device->starget) {
@@ -8296,7 +8297,6 @@ static void scsih_remove(struct pci_dev *pdev)
 		ioc->sas_hba.num_phys = 0;
 	}
 
-	sas_remove_host(shost);
 	mpt3sas_base_detach(ioc);
 	spin_lock(&gioc_lock);
 	list_del(&ioc->list);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 63dd9bc21ff2..66d9f04c4c0b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -846,10 +846,13 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
 			    mpt3sas_port->remote_identify.sas_address,
 			    mpt3sas_phy->phy_id);
 		mpt3sas_phy->phy_belongs_to_port = 0;
-		sas_port_delete_phy(mpt3sas_port->port, mpt3sas_phy->phy);
+		if (!ioc->remove_host)
+			sas_port_delete_phy(mpt3sas_port->port,
+						mpt3sas_phy->phy);
 		list_del(&mpt3sas_phy->port_siblings);
 	}
-	sas_port_delete(mpt3sas_port->port);
+	if (!ioc->remove_host)
+		sas_port_delete(mpt3sas_port->port);
 	kfree(mpt3sas_port);
 }
 
-- 
2.19.1

