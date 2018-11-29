Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505A7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F93205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO1zpcuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F93205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbeK3BXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbeK3BXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5641B208E7;
        Thu, 29 Nov 2018 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501060;
        bh=qrJlO7ChsW6N7FuN2u9leXHRO/S/utT869ihTEro1bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cO1zpcukAA0yWaa1EKaJJ3gv7OPi6zMphdHpjgWUVzeOUOqeKxSdDk398Y+ecggCS
         fVV/ckbhVbH2JgsCBJeooEna6GF0/NsftYVmcrs6BJc3IXL2bzsAJSqoOw4HvI0jBy
         AsLixRQqW/y9cQSThLFoeay9OYAOPqoGtIXfpWiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Cuissard <cuissard@marvell.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 26/86] NFC: nfcmrvl_uart: fix OF child-node lookup
Date:   Thu, 29 Nov 2018 15:11:51 +0100
Message-Id: <20181129140112.016477420@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 6c0c301611c4..1b11ded79c4f 100644
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



