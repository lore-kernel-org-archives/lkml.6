Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA094C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9D0208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9D0208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389328AbeGJSek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388380AbeGJSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9CB8CE3D;
        Tue, 10 Jul 2018 18:34:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Best <sbest@redhat.com>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        David Carroll <David.Carroll@microsemi.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 11/56] scsi: aacraid: Fix PD performance regression over incorrect qd being set
Date:   Tue, 10 Jul 2018 20:24:53 +0200
Message-Id: <20180710182504.070527701@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>

commit 59b433c825569ce251371485f0e29fca888b549d upstream.

The driver fails to set the correct queue depth for native devices, due to
failing to set the device type prior to calling aac_set_safw_target_qd().
This results in slave configure setting the queue depth to 1.

This causes around 30% performance degradation. Fixed by setting the dev
type before trying to set queue depth.

Reported-by: Steve Best <sbest@redhat.com>
Fixes: 0bcb45fb20c21 ("scsi: aacraid: Add helper function to set queue depth")
cc: stable@vger.kernel.org
Signed-off-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Reviewed-by: David Carroll <David.Carroll@microsemi.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aacraid/aachba.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -1974,7 +1974,6 @@ static void aac_set_safw_attr_all_target
 	u32 lun_count, nexus;
 	u32 i, bus, target;
 	u8 expose_flag, attribs;
-	u8 devtype;
 
 	lun_count = aac_get_safw_phys_lun_count(dev);
 
@@ -1992,23 +1991,23 @@ static void aac_set_safw_attr_all_target
 			continue;
 
 		if (expose_flag != 0) {
-			devtype = AAC_DEVTYPE_RAID_MEMBER;
-			goto update_devtype;
+			dev->hba_map[bus][target].devtype =
+				AAC_DEVTYPE_RAID_MEMBER;
+			continue;
 		}
 
 		if (nexus != 0 && (attribs & 8)) {
-			devtype = AAC_DEVTYPE_NATIVE_RAW;
+			dev->hba_map[bus][target].devtype =
+				AAC_DEVTYPE_NATIVE_RAW;
 			dev->hba_map[bus][target].rmw_nexus =
 					nexus;
 		} else
-			devtype = AAC_DEVTYPE_ARC_RAW;
+			dev->hba_map[bus][target].devtype =
+				AAC_DEVTYPE_ARC_RAW;
 
 		dev->hba_map[bus][target].scan_counter = dev->scan_counter;
 
 		aac_set_safw_target_qd(dev, bus, target);
-
-update_devtype:
-		dev->hba_map[bus][target].devtype = devtype;
 	}
 }
 


