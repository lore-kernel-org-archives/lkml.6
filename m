Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9BAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF6D20645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF6D20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeK1G1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:27:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeK1G1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:27:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DAA237EEF;
        Tue, 27 Nov 2018 19:28:56 +0000 (UTC)
Received: from dhcp-17-98.bos.redhat.com (dhcp-17-179.bos.redhat.com [10.18.17.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32B31608C1;
        Tue, 27 Nov 2018 19:28:54 +0000 (UTC)
From:   Cathy Avery <cavery@redhat.com>
To:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hch@lst.de,
        jgill@vmware.com
Cc:     emilne@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload
Date:   Tue, 27 Nov 2018 14:28:53 -0500
Message-Id: <1543346933-440-1-git-send-email-cavery@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 27 Nov 2018 19:28:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently pvscsi_remove calls free_irq more than once as
pvscsi_release_resources and __pvscsi_shutdown both call
pvscsi_shutdown_intr. This results in a 'Trying to free
already-free IRQ' warning and stack trace. To solve the problem
pvscsi_shutdown_intr has been moved out of pvscsi_release_resources.

Signed-off-by: Cathy Avery <cavery@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/scsi/vmw_pvscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 6e49102..0d6b2a8 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1202,8 +1202,6 @@ static void pvscsi_shutdown_intr(struct pvscsi_adapter *adapter)
 
 static void pvscsi_release_resources(struct pvscsi_adapter *adapter)
 {
-	pvscsi_shutdown_intr(adapter);
-
 	if (adapter->workqueue)
 		destroy_workqueue(adapter->workqueue);
 
@@ -1534,6 +1532,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_reset_adapter:
 	ll_adapter_reset(adapter);
 out_release_resources:
+	pvscsi_shutdown_intr(adapter);
 	pvscsi_release_resources(adapter);
 	scsi_host_put(host);
 out_disable_device:
@@ -1542,6 +1541,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return error;
 
 out_release_resources_and_disable:
+	pvscsi_shutdown_intr(adapter);
 	pvscsi_release_resources(adapter);
 	goto out_disable_device;
 }
-- 
2.5.5

