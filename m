Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20A3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB42E20850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB42E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbeGTNPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:15:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbeGTNPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:15:07 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA57F41C;
        Fri, 20 Jul 2018 12:27:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 17/31] qed: Limit msix vectors in kdump kernel to the minimum required count.
Date:   Fri, 20 Jul 2018 14:13:47 +0200
Message-Id: <20180720121340.778732596@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121340.158484922@linuxfoundation.org>
References: <20180720121340.158484922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit bb7858ba1102f82470a917e041fd23e6385c31be ]

Memory size is limited in the kdump kernel environment. Allocation of more
msix-vectors (or queues) consumes few tens of MBs of memory, which might
lead to the kdump kernel failure.
This patch adds changes to limit the number of MSI-X vectors in kdump
kernel to minimum required value (i.e., 2 per engine).

Fixes: fe56b9e6a ("qed: Add module with basic common support")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -22,6 +22,7 @@
 #include <linux/etherdevice.h>
 #include <linux/vmalloc.h>
 #include <linux/qed/qed_if.h>
+#include <linux/crash_dump.h>
 
 #include "qed.h"
 #include "qed_sp.h"
@@ -634,6 +635,14 @@ static int qed_slowpath_setup_int(struct
 	/* We want a minimum of one slowpath and one fastpath vector per hwfn */
 	cdev->int_params.in.min_msix_cnt = cdev->num_hwfns * 2;
 
+	if (is_kdump_kernel()) {
+		DP_INFO(cdev,
+			"Kdump kernel: Limit the max number of requested MSI-X vectors to %hd\n",
+			cdev->int_params.in.min_msix_cnt);
+		cdev->int_params.in.num_vectors =
+			cdev->int_params.in.min_msix_cnt;
+	}
+
 	rc = qed_set_int_mode(cdev, false);
 	if (rc)  {
 		DP_ERR(cdev, "qed_slowpath_setup_int ERR\n");


