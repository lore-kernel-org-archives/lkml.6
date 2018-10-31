Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06A4ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571722054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DpT6mIZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571722054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeJaWWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:22:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39407 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbeJaWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:22:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so16491047wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lEqXr7wEAOW839/yy/MKqF6Va7CQZ2BXCDmuyFLxywI=;
        b=DpT6mIZZJ0+NzvD6Nl0BhDZ0KoTsh7kUuB67G+E33fxa3cZsl08mJJW007TzbQqVV+
         GoaNh+X7/7JKQ6u5FCO0AsH13jYz8NnMEoznusb+AD73qrsKK+Eyz22jROPQMIIA44ky
         244l9PktC4JPOhtxHFyCOrOrf1bLWO3DrEFF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lEqXr7wEAOW839/yy/MKqF6Va7CQZ2BXCDmuyFLxywI=;
        b=QeABq1/3ygPVURzCC5rZq2HRNEHKJAx+ZjoKaTX/5ivmpeEecmwqGIiuGU2VNpLEL0
         5CdL2s9b0bHmBj7VOAwiuys96syPESFqm4Sn/Ev9701eXr8RY7iTL3JLQQUZwzh1s3WR
         zUCZxhu6VChYMtkBhHSkXNW6pXMxRrDjc3Wv0J1/NnXcDb7Dv5q/8Sog7f/sWZooUhtd
         mCiw/Q3ZAf+3hGAkvhqZqvHyRdkOeiQ3Offx6BHhI9cJ88eG4cDRcoh/RYGD1nrlhHaL
         SaT56/2VLfvM3KOmy15Ay09RZIR/fZ8ku+GjiwTDM+S0fCVJ9dmoxY5/f4i4/oD8UaGS
         kLcA==
X-Gm-Message-State: AGRZ1gJXguu4tWEHYdFSgusYXhU/Cexq31lvo0Dq7T1YhdrVCckuR2vi
        0kGUM6N9+4Izq8yzN0BvyzjreY+A6jI=
X-Google-Smtp-Source: AJdET5cU/ljDR9qQ8iAVsf08RqaJa+2RENxF6ii9hDeU8t/40xN1ofRd/2VDhoepexBRG0Ehio8SIA==
X-Received: by 2002:a5d:69ce:: with SMTP id s14-v6mr1743754wrw.177.1540992278274;
        Wed, 31 Oct 2018 06:24:38 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r16-v6sm25202614wrv.21.2018.10.31.06.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:24:37 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v7 4/8] mpt3sas: Call sas_remove_host before removing the target devices
Date:   Wed, 31 Oct 2018 18:53:35 +0530
Message-Id: <1540992219-20291-5-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call sas_remove_host() before removing the target devices in the
driver's .remove() callback function(i.e. during driver unload time).
So that driver can provide a way to allow SYNC CACHE, START STOP unit
commands etc. (which are issued from SML) to the target drives during
driver unload time.

Once sas_remove_host() is called before removing the target drives then
driver can just clean up the resources allocated for target devices and
no need to call sas_port_delete_phy(), sas_port_delete() API's as these
API's internally called from sas_remove_host().

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 4d73b5e..12f565c 100644
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
index 9685c87..60ae2d0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -806,10 +806,13 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
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
1.8.3.1

