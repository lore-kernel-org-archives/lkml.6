Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0392083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0392083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404321AbeHATDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46152 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404159AbeHATDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 64E6D105D;
        Wed,  1 Aug 2018 17:01:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 152/336] scsi: ufs: ufshcd: fix possible unclocked register access
Date:   Wed,  1 Aug 2018 18:48:07 +0200
Message-Id: <20180801165034.948723683@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Subhash Jadavani <subhashj@codeaurora.org>

[ Upstream commit b334456ec2021b1addc19806990115e69ec4ac32 ]

Vendor specific setup_clocks ops may depend on clocks managed by ufshcd
driver so if the vendor specific setup_clocks callback is called when
the required clocks are turned off, it results into unclocked register
access.

This change make sure that required clocks are enabled before vendor
specific setup_clocks callback is called.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6799,9 +6799,16 @@ static int __ufshcd_setup_clocks(struct
 	if (list_empty(head))
 		goto out;
 
-	ret = ufshcd_vops_setup_clocks(hba, on, PRE_CHANGE);
-	if (ret)
-		return ret;
+	/*
+	 * vendor specific setup_clocks ops may depend on clocks managed by
+	 * this standard driver hence call the vendor specific setup_clocks
+	 * before disabling the clocks managed here.
+	 */
+	if (!on) {
+		ret = ufshcd_vops_setup_clocks(hba, on, PRE_CHANGE);
+		if (ret)
+			return ret;
+	}
 
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk)) {
@@ -6825,9 +6832,16 @@ static int __ufshcd_setup_clocks(struct
 		}
 	}
 
-	ret = ufshcd_vops_setup_clocks(hba, on, POST_CHANGE);
-	if (ret)
-		return ret;
+	/*
+	 * vendor specific setup_clocks ops may depend on clocks managed by
+	 * this standard driver hence call the vendor specific setup_clocks
+	 * after enabling the clocks managed here.
+	 */
+	if (on) {
+		ret = ufshcd_vops_setup_clocks(hba, on, POST_CHANGE);
+		if (ret)
+			return ret;
+	}
 
 out:
 	if (ret) {


