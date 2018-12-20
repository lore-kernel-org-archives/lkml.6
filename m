Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35789C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EA521773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297719;
	bh=dXNePdVtdrmK1MR6zA5Cq+V/0KhEj6E5zO/v8hx8t2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YfaF3dLe6AvSLD2jK6jozlg+BilZ6AntNWXJB1bJ+HP2nuCbOoE2GCN7AWSb4cxhr
	 ngV+bHaCV1GKPFpoIljPrxODKHgfrhdwGKHhLFhXEoeF3NpFVW5FhA6MW9Mv8sVF/f
	 FHbJIVXadpRaCq/j5dEpqjCU1UfJ1CtLSVmVblJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbeLTJV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbeLTJVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A7021720;
        Thu, 20 Dec 2018 09:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297712;
        bh=dXNePdVtdrmK1MR6zA5Cq+V/0KhEj6E5zO/v8hx8t2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1r2NDqTPpypI1nTV2fGreQerE33sK0LJSrh2+uMFu1SCd05uigOTaTKwfqinaMXVZ
         pdPL26OxY2xXbrhI+lL1rpxeyrdMJDwi0Fc40swTHXwVdgBk2EAcLUV2JWx43K3trX
         D/OVx1FGBTEeuDfPoV1onVGQDOFh0Nr5roMA8uP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 29/40] ide: pmac: add of_node_put()
Date:   Thu, 20 Dec 2018 10:18:41 +0100
Message-Id: <20181220085827.629350936@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a51921c0db3fd26c4ed83dc0ec5d32988fa02aa5 ]

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ide/pmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 96a345248224..0add5bb3cee8 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -920,6 +920,7 @@ static u8 pmac_ide_cable_detect(ide_hwif_t *hwif)
 	struct device_node *root = of_find_node_by_path("/");
 	const char *model = of_get_property(root, "model", NULL);
 
+	of_node_put(root);
 	/* Get cable type from device-tree. */
 	if (cable && !strncmp(cable, "80-", 3)) {
 		/* Some drives fail to detect 80c cable in PowerBook */
-- 
2.19.1



