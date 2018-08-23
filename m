Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF312083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF312083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbeHWMMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:12:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWMMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:12:08 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E9277F6;
        Thu, 23 Aug 2018 08:43:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 067/324] qed: Do not advertise DCBX_LLD_MANAGED capability.
Date:   Thu, 23 Aug 2018 09:52:13 +0200
Message-Id: <20180823074959.265285133@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit ff54d5cd9ec15546abc870452dd0b66eef4b4606 ]

Do not advertise DCBX_LLD_MANAGED capability i.e., do not allow
external agent to manage the dcbx/lldp negotiation. MFW acts as lldp agent
for qed* devices, and no other lldp agent is allowed to coexist with mfw.

Also updated a debug print, to not to display the redundant info.

Fixes: a1d8d8a51 ("qed: Add dcbnl support.")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -255,9 +255,8 @@ qed_dcbx_get_app_protocol_type(struct qe
 		*type = DCBX_PROTOCOL_ROCE_V2;
 	} else {
 		*type = DCBX_MAX_PROTOCOL_TYPE;
-		DP_ERR(p_hwfn,
-		       "No action required, App TLV id = 0x%x app_prio_bitmap = 0x%x\n",
-		       id, app_prio_bitmap);
+		DP_ERR(p_hwfn, "No action required, App TLV entry = 0x%x\n",
+		       app_prio_bitmap);
 		return false;
 	}
 
@@ -1469,8 +1468,8 @@ static u8 qed_dcbnl_getcap(struct qed_de
 		*cap = 0x80;
 		break;
 	case DCB_CAP_ATTR_DCBX:
-		*cap = (DCB_CAP_DCBX_LLD_MANAGED | DCB_CAP_DCBX_VER_CEE |
-			DCB_CAP_DCBX_VER_IEEE | DCB_CAP_DCBX_STATIC);
+		*cap = (DCB_CAP_DCBX_VER_CEE | DCB_CAP_DCBX_VER_IEEE |
+			DCB_CAP_DCBX_STATIC);
 		break;
 	default:
 		*cap = false;
@@ -1538,8 +1537,6 @@ static u8 qed_dcbnl_getdcbx(struct qed_d
 	if (!dcbx_info)
 		return 0;
 
-	if (dcbx_info->operational.enabled)
-		mode |= DCB_CAP_DCBX_LLD_MANAGED;
 	if (dcbx_info->operational.ieee)
 		mode |= DCB_CAP_DCBX_VER_IEEE;
 	if (dcbx_info->operational.cee)


