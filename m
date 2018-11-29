Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C474AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE17213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUGxhDgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE17213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbeK3BcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:32:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732836AbeK3BcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:32:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6503121479;
        Thu, 29 Nov 2018 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501603;
        bh=mHajNC2THgajAWVPjDtPA3TLv9ZtMzwWzF7jl5yjKUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUGxhDghFW+Z9ZLzy3rSEn38X1xIIdKnbiT6IWzydZ6nDLBJrTsp4tb5MU6XjtMW3
         Qei4KECKhJoc+CMWn0rc+aU30ySWuxboloa67uvHtVWPgr9vbDrDlQJDV8LLT965Uu
         g+7S4oNX+/DmI9t6eo9Hu88nwTN/B3cR4/W0s+BM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Cuissard <cuissard@marvell.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 066/100] NFC: nfcmrvl_uart: fix OF child-node lookup
Date:   Thu, 29 Nov 2018 15:12:36 +0100
Message-Id: <20181129140104.623516816@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5bf59773aaf36dd62117dc83d50e1bbf9ef432da ]

Use the new of_get_compatible_child() helper to lookup the nfc child
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the parent node).

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Fixes: d8e018c0b321 ("NFC: nfcmrvl: update device tree bindings for Marvell NFC")
Cc: stable <stable@vger.kernel.org>     # 4.2
Cc: Vincent Cuissard <cuissard@marvell.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/nfcmrvl/uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 91162f8e0366..9a22056e8d9e 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -73,10 +73,9 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node,
 	struct device_node *matched_node;
 	int ret;
 
-	matched_node = of_find_compatible_node(node, NULL, "marvell,nfc-uart");
+	matched_node = of_get_compatible_child(node, "marvell,nfc-uart");
 	if (!matched_node) {
-		matched_node = of_find_compatible_node(node, NULL,
-						       "mrvl,nfc-uart");
+		matched_node = of_get_compatible_child(node, "mrvl,nfc-uart");
 		if (!matched_node)
 			return -ENODEV;
 	}
-- 
2.17.1



