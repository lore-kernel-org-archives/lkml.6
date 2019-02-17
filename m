Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5116C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 06:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640C021A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 06:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WSsSrzBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfBQGbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 01:31:10 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8816 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfBQGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 01:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550385069; x=1581921069;
  h=from:to:cc:subject:date:message-id;
  bh=JlBezc6VJE54/kAaxIEKF4AAqszBKCXftftZoQ/ZPQg=;
  b=WSsSrzBUdmwr93oxcWNWrv3D3J1y/tocEydn/UG1OG5IDRvRepTlGvUo
   weOu4Jc/pz1q2uhqIyXlgGz0MDjCBSr/+pmFrUCBtOPZ4EGUcPC6am62P
   XbdnBYHEyEiiFLi60c7+eYkivm6gNnoQD30YIBHiZquYC9Cm+zy0+IYJt
   RC42zQhisrtAkkKsZZ7lYFEiq+9tSmLSpwsIDBh2+tNbO3L/OS24742oz
   CfXJJt0ERipXJS3OYnRV0gdJ2zy8aiHP/nDRS9p6C1YCTVu41ruLWzV4t
   k6VAYbIpwbgB72DxAppj/9BmB5YneknOlGOEQwYMHrpbm1ufXV7bTx+RD
   g==;
X-IronPort-AV: E=Sophos;i="5.58,379,1544457600"; 
   d="scan'208";a="206654174"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2019 14:30:50 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 16 Feb 2019 22:11:19 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2019 22:30:48 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] scsi: clean obsolete return values of eh_timed_out
Date:   Sun, 17 Feb 2019 08:30:27 +0200
Message-Id: <1550385027-6217-1-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are no longer in use since commit 242f9dcb8ba6
("block: unify request timeout handling").

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 include/scsi/scsi_host.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 4047d68..dbbdfbd 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -300,11 +300,7 @@ struct scsi_host_template {
 	/*
 	 * This is an optional routine that allows the transport to become
 	 * involved when a scsi io timer fires. The return value tells the
-	 * timer routine how to finish the io timeout handling:
-	 * EH_HANDLED:		I fixed the error, please complete the command
-	 * EH_RESET_TIMER:	I need more time, reset the timer and
-	 *			begin counting again
-	 * EH_DONE:		Begin normal error recovery
+	 * timer routine how to finish the io timeout handling.
 	 *
 	 * Status: OPTIONAL
 	 */
-- 
1.9.1

