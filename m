Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE57C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3ADF20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3ADF20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966251AbeFRI0n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:26:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966182AbeFRI0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:26:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E06FC5C;
        Mon, 18 Jun 2018 08:26:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 213/279] qed: Fix l2 initializations over iWARP personality
Date:   Mon, 18 Jun 2018 10:13:18 +0200
Message-Id: <20180618080617.681782500@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kalderon <Michal.Kalderon@cavium.com>

[ Upstream commit af6858ee423a309d93054c361c61099b8eb12bbf ]

If qede driver was loaded on a device configured for iWARP
the l2 mutex wouldn't be allocated, and some l2 related
resources wouldn't be freed.

fixes: c851a9dc4359 ("qed: Introduce iWARP personality")
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -115,8 +115,7 @@ int qed_l2_alloc(struct qed_hwfn *p_hwfn
 
 void qed_l2_setup(struct qed_hwfn *p_hwfn)
 {
-	if (p_hwfn->hw_info.personality != QED_PCI_ETH &&
-	    p_hwfn->hw_info.personality != QED_PCI_ETH_ROCE)
+	if (!QED_IS_L2_PERSONALITY(p_hwfn))
 		return;
 
 	mutex_init(&p_hwfn->p_l2_info->lock);
@@ -126,8 +125,7 @@ void qed_l2_free(struct qed_hwfn *p_hwfn
 {
 	u32 i;
 
-	if (p_hwfn->hw_info.personality != QED_PCI_ETH &&
-	    p_hwfn->hw_info.personality != QED_PCI_ETH_ROCE)
+	if (!QED_IS_L2_PERSONALITY(p_hwfn))
 		return;
 
 	if (!p_hwfn->p_l2_info)


