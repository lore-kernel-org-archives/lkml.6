Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21074C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBFB20665
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957477;
	bh=vCIfUY+gVTa50hS5GtMeDdQ3M2h6KIeV+IHjBiN4M+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s6SkWL7zqasAzxOg5PtL0t85+beNiz04gk3plL0n+vh0WuiOwoL9bm3lo2Q/kazTl
	 QMlcUaAQ34+ZCBavnAH8677JiL0SkDrbN/a8ibK38Z3wwWbAuTMTbCtSs7w6OcLmir
	 Co8iI5Z/xYalVK1B20Bw72fqxWXVYb4suS1/iOOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfBWVbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfBWVFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E8C206B6;
        Sat, 23 Feb 2019 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955937;
        bh=vCIfUY+gVTa50hS5GtMeDdQ3M2h6KIeV+IHjBiN4M+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXHri2n3Uz4yaSMUqSxiVJXvLTM9xi7C3rOV4XWFk3eT5vYmAP8evZESsomqeVdlT
         PAXXDG/71szv/lFWLoJcuhWVThUa9UD6pFSat4mmRqa+LCG8YuPA2y9/Kd0ffeOOCy
         q/e6/BrUs/nFyuSKcq1JS1xlNR5sglQh5PvKICu0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 45/72] qed: Fix VF probe failure while FLR
Date:   Sat, 23 Feb 2019 16:03:55 -0500
Message-Id: <20190223210422.199966-45-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit 327852ec64205bb651be391a069784872098a3b2 ]

VFs may hit VF-PF channel timeout while probing, as in some
cases it was observed that VF FLR and VF "acquire" message
transaction (i.e first message from VF to PF in VF's probe flow)
could occur simultaneously which could lead VF to fail sending
"acquire" message to PF as VF is marked disabled from HW perspective
due to FLR, which will result into channel timeout and VF probe failure.

In such cases, try retrying VF "acquire" message so that in later
attempts it could be successful to pass message to PF after the VF
FLR is completed and can be probed successfully.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index b6cccf44bf409..5dda547772c13 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -261,6 +261,7 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 	struct pfvf_acquire_resp_tlv *resp = &p_iov->pf2vf_reply->acquire_resp;
 	struct pf_vf_pfdev_info *pfdev_info = &resp->pfdev_info;
 	struct vf_pf_resc_request *p_resc;
+	u8 retry_cnt = VF_ACQUIRE_THRESH;
 	bool resources_acquired = false;
 	struct vfpf_acquire_tlv *req;
 	int rc = 0, attempts = 0;
@@ -314,6 +315,15 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 
 		/* send acquire request */
 		rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+
+		/* Re-try acquire in case of vf-pf hw channel timeout */
+		if (retry_cnt && rc == -EBUSY) {
+			DP_VERBOSE(p_hwfn, QED_MSG_IOV,
+				   "VF retrying to acquire due to VPC timeout\n");
+			retry_cnt--;
+			continue;
+		}
+
 		if (rc)
 			goto exit;
 
-- 
2.19.1

