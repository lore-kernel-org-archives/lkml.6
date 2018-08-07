Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F46C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4AF20895
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4AF20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbeHGVPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:15:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbeHGVPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:15:23 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A7AD2D54;
        Tue,  7 Aug 2018 18:59:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 35/85] scsi: ufs: fix exception event handling
Date:   Tue,  7 Aug 2018 20:51:37 +0200
Message-Id: <20180807172358.630829162@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maya Erez <merez@codeaurora.org>

[ Upstream commit 2e3611e9546c2ed4def152a51dfd34e8dddae7a5 ]

The device can set the exception event bit in one of the response UPIU,
for example to notify the need for urgent BKOPs operation.  In such a
case, the host driver calls ufshcd_exception_event_handler to handle
this notification.  When trying to check the exception event status (for
finding the cause for the exception event), the device may be busy with
additional SCSI commands handling and may not respond within the 100ms
timeout.

To prevent that, we need to block SCSI commands during handling of
exception events and allow retransmissions of the query requests, in
case of timeout.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3330,6 +3330,7 @@ static void ufshcd_exception_event_handl
 	hba = container_of(work, struct ufs_hba, eeh_work);
 
 	pm_runtime_get_sync(hba->dev);
+	scsi_block_requests(hba->host);
 	err = ufshcd_get_ee_status(hba, &status);
 	if (err) {
 		dev_err(hba->dev, "%s: failed to get exception status %d\n",
@@ -3345,6 +3346,7 @@ static void ufshcd_exception_event_handl
 					__func__, err);
 	}
 out:
+	scsi_unblock_requests(hba->host);
 	pm_runtime_put_sync(hba->dev);
 	return;
 }


