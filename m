Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24ECC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D05920881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697877;
	bh=iDrV69RZp+scdru9X/Sm0wcn2rY7mg2o3e2QRLd+Jyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uhPnd5wxFQNN8EHQE0V9wW7w/i1a9rmpkFxmaWoFwLn0YB5EDCFiHMCUZTzYBI9sQ
	 9exnYsld6+pbt3wC8DUOVIysE0EuOou7T+BuB+ymkdOH920kg4IRPJb5jRdBX4PAYK
	 jUdBOGMZp9aKTMJ9Bb4iStHuOwmfbbk+lxfSoG2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfA1RvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfA1PoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:44:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A4B21741;
        Mon, 28 Jan 2019 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690256;
        bh=iDrV69RZp+scdru9X/Sm0wcn2rY7mg2o3e2QRLd+Jyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CrljzyTFuMDSoUo1vfwLs7XCvlf93ldeSSBvXE/zTRHihMflG5upshP1kXbegcvZ
         wDfYoiQltONOX829+WKXoFj3uYp6SDeSNXkGtULl4L59dp2mv/23puL2UOg++GT+o6
         10U78ZMXpCc116t3M29B9UyP/sK/ZTI0barfxVBA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 020/304] scsi: mpt3sas: Call sas_remove_host before removing the target devices
Date:   Mon, 28 Jan 2019 10:38:57 -0500
Message-Id: <20190128154341.47195-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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
index 03c52847ed07..adac18ba84d4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -9641,6 +9641,7 @@ static void scsih_remove(struct pci_dev *pdev)
 
 	/* release all the volumes */
 	_scsih_ir_shutdown(ioc);
+	sas_remove_host(shost);
 	list_for_each_entry_safe(raid_device, next, &ioc->raid_device_list,
 	    list) {
 		if (raid_device->starget) {
@@ -9682,7 +9683,6 @@ static void scsih_remove(struct pci_dev *pdev)
 		ioc->sas_hba.num_phys = 0;
 	}
 
-	sas_remove_host(shost);
 	mpt3sas_base_detach(ioc);
 	spin_lock(&gioc_lock);
 	list_del(&ioc->list);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 6a8a3c09b4b1..8338b4db0e31 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -821,10 +821,13 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
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

