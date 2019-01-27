Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B78FC282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 07:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D378C214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 07:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eEByc9js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfA0HID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 02:08:03 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16359 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfA0HIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 02:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548572899; x=1580108899;
  h=from:to:cc:subject:date:message-id;
  bh=lP9cRze2DgvFbxqrm+VgPZIWiTRvEuPIbbzJrIMYERs=;
  b=eEByc9jsId6kSdYRJc9/QFFTo7aqxAjIUoin8cm4hAJwdDDCZAianMrK
   hWSNduwYh++kDraZV5RT0wbOnWgVUF1wNU9uWs1XJi4Tnl4rR9v4nf2Zb
   2ny5VpVQWlLhnNybrg4vGGiXVWmLmKqfAgsNNR3tgzJODqgFt6Bei6myI
   GohDVCw4biw1usENpLuamg80A3drv+hXzz+Q4bm/5dY1aR4WqdwI98j2/
   SDOh/69NbRT8cJcSR9hdkQOxgw0Trzd4pfMjtwQoZmjVD15k4rrlvzbCz
   R+aNhknJ2N1ezUHbzT5IJuhNXm4+TELOmT9rtKPqfZwU0qNT3rpv7mcpK
   g==;
X-IronPort-AV: E=Sophos;i="5.56,529,1539619200"; 
   d="scan'208";a="197974351"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2019 15:08:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 26 Jan 2019 22:49:05 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2019 23:08:00 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v4 0/3] scsi: ufs-bsg: Add read descriptor 
Date:   Sun, 27 Jan 2019 09:07:45 +0200
Message-Id: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS Protocol Information Units (UPIU) are UFS packets that travel
between the host and the device on the UniPro bus. Our previous series
added the capability to send UPIUs to the ufs driver. It does not cover
all the possible UPIU types - we are mainly focused on device management,
provisioning, testing and validation, so it covers UPIUs that falls in
that box.

Our intension is to publish ufs-utils soon - an open source user space
utility that relies on that infrastructure to perform those tasks.
This short series is adding one last functionality needed by ufs-utils
that was somehow left behind - allowing reading descriptors as well.

V3->v4:
Improve code readability in ufs-bsg: Allow reading descriptors
Update Reviewed-by tag.

V2->v3:
Add a prep patch with write descriptor calling convention changes.
Elaborate the commit log of ufs-bsg: Allow reading descriptors
Add Reviewed-by tag.

v1->v2:
Withdraw from the attempt to change the reply buffer, instead place the
descriptor being read in the actual data buffer in the bio.

Avri Altman (3):
  scsi: ufs-bsg: Change the calling convention for write descriptor
  scsi: ufs: Allow reading descriptor via raw upiu
  scsi: ufs-bsg: Allow reading descriptors

 Documentation/scsi/ufs.txt | 11 ++++++++
 drivers/scsi/ufs/ufs_bsg.c | 63 ++++++++++++++++++++++++++--------------------
 drivers/scsi/ufs/ufshcd.c  | 20 ++++++++++-----
 3 files changed, 61 insertions(+), 33 deletions(-)

-- 
1.9.1

