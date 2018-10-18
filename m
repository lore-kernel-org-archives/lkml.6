Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B80C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03BD21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0CgNw1DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03BD21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeJSB7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbeJSB7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:59:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A90621476;
        Thu, 18 Oct 2018 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885450;
        bh=yDwjVsuhXfO5A2tuWOC2voeTPLNpru5jO4u4OZmCVoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CgNw1DGNLQMyG2lrO96UTDdDoBa21QSuoUfhmW1r3JREzKmfvuvc5L5yL+OF3Fnk
         t5C5nleGol3jmRZWPOHPepbudKFpvhnptUFDMnU6B6t0i+HznXuZPWVENup/27uJiI
         YzsBdsOR+u7vwhDb4DF4bj7X3UiLXBO1vDOZpz0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 29/53] qed: Do not add VLAN 0 tag to untagged frames in multi-function mode.
Date:   Thu, 18 Oct 2018 19:54:22 +0200
Message-Id: <20181018175421.947023228@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit 0216da9413afa546627a1b0d319dfd17fef34050 ]

In certain multi-function switch dependent modes, firmware adds vlan tag 0
to the untagged frames. This leads to double tagging for the traffic
if the dcbx is enabled, which is not the desired behavior. To avoid this,
driver needs to set "dcb_dont_add_vlan0" flag.

Fixes: cac6f691 ("qed: Add support for Unified Fabric Port")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c |    9 ++++++++-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h |    1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -190,6 +190,7 @@ qed_dcbx_dp_protocol(struct qed_hwfn *p_
 
 static void
 qed_dcbx_set_params(struct qed_dcbx_results *p_data,
+		    struct qed_hwfn *p_hwfn,
 		    struct qed_hw_info *p_info,
 		    bool enable,
 		    u8 prio,
@@ -206,6 +207,11 @@ qed_dcbx_set_params(struct qed_dcbx_resu
 	else
 		p_data->arr[type].update = DONT_UPDATE_DCB_DSCP;
 
+	/* Do not add vlan tag 0 when DCB is enabled and port in UFP/OV mode */
+	if ((test_bit(QED_MF_8021Q_TAGGING, &p_hwfn->cdev->mf_bits) ||
+	     test_bit(QED_MF_8021AD_TAGGING, &p_hwfn->cdev->mf_bits)))
+		p_data->arr[type].dont_add_vlan0 = true;
+
 	/* QM reconf data */
 	if (p_info->personality == personality)
 		p_info->offload_tc = tc;
@@ -233,7 +239,7 @@ qed_dcbx_update_app_info(struct qed_dcbx
 		personality = qed_dcbx_app_update[i].personality;
 		name = qed_dcbx_app_update[i].name;
 
-		qed_dcbx_set_params(p_data, p_info, enable,
+		qed_dcbx_set_params(p_data, p_hwfn, p_info, enable,
 				    prio, tc, type, personality);
 	}
 }
@@ -956,6 +962,7 @@ static void qed_dcbx_update_protocol_dat
 	p_data->dcb_enable_flag = p_src->arr[type].enable;
 	p_data->dcb_priority = p_src->arr[type].priority;
 	p_data->dcb_tc = p_src->arr[type].tc;
+	p_data->dcb_dont_add_vlan0 = p_src->arr[type].dont_add_vlan0;
 }
 
 /* Set pf update ramrod command params */
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.h
@@ -55,6 +55,7 @@ struct qed_dcbx_app_data {
 	u8 update;		/* Update indication */
 	u8 priority;		/* Priority */
 	u8 tc;			/* Traffic Class */
+	bool dont_add_vlan0;	/* Do not insert a vlan tag with id 0 */
 };
 
 #define QED_DCBX_VERSION_DISABLED       0


