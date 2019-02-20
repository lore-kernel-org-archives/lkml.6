Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4055521773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PUfbizJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfBTHLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:11:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24860 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBTHLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550646701; x=1582182701;
  h=from:to:cc:subject:date:message-id;
  bh=7JyYpMoDn73bv1c500xLDbTt5+CQle1C649xKM1HwpU=;
  b=PUfbizJdNQuJ5+/2U3BrexJe0K70Z7UCLcTUmmy4TWrZtKtBqzUkoe6e
   UP0bcmrXopTbY8Vp0mKhlzpkwaiAWFau3LDAxhCytdBs9UNCXuG4AMkms
   82xTXwxALtlP6DfDnWiTCvzRLBUuyUUnQbQVu6Xh+Z1gbrWcU1Wu5NK8d
   /72ZdKxfu3zcTWbKxTxThluMKDm5wvIhuhyi5QCsoG9rFRBs70PaKKqI2
   OA3F16LkOBDU3xgZx9pGy5F+c9IivDYk/e66pUXP9VihRoehAgIKJQnvU
   LL62RyvkQx0fZqoIsxaMobv707pJNasu+frqGjo8+4yfJgKgXzgQ+SFH9
   w==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="103461487"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2019 15:11:40 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Feb 2019 22:50:03 -0800
Received: from kfae422988.sdcorp.global.sandisk.com ([10.0.230.227])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Feb 2019 23:11:37 -0800
From:   Avri Altman <avri.altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [REPOST PATCH v4 0/3] scsi: ufs-bsg: Add read descriptor
Date:   Wed, 20 Feb 2019 09:11:11 +0200
Message-Id: <1550646674-15258-1-git-send-email-avri.altman@wdc.com>
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

Repost of v4 and adds tags already received.
While at it, it turns out that quite a few people are waiting for
ufs-utils, e.g. https://www.spinics.net/lists/linux-scsi/msg127807.html.
So I expect that the small, but vibrant community of ufs users, will try
to expand this infrastructure even further.

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

