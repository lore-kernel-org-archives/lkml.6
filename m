Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41862064E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41862064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeHWLgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:36:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbeHWLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:36:31 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AEDA0BB6;
        Thu, 23 Aug 2018 08:08:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ajay Gupta <ajaykuee@gmail.com>,
        Nagaraj Annaiah <naga.annaiah@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 045/130] usb: xhci: increase CRS timeout value
Date:   Thu, 23 Aug 2018 09:52:41 +0200
Message-Id: <20180823074930.149826992@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ajay Gupta <ajaykuee@gmail.com>

[ Upstream commit 305886ca87be480ae159908c2affd135c04215cf ]

Some controllers take almost 55ms to complete controller
restore state (CRS).
There is no timeout limit mentioned in xhci specification so
fixing the issue by increasing the timeout limit to 100ms

[reformat code comment -Mathias]
Signed-off-by: Ajay Gupta <ajaykuee@gmail.com>
Signed-off-by: Nagaraj Annaiah <naga.annaiah@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1056,8 +1056,13 @@ int xhci_resume(struct xhci_hcd *xhci, b
 		command = readl(&xhci->op_regs->command);
 		command |= CMD_CRS;
 		writel(command, &xhci->op_regs->command);
+		/*
+		 * Some controllers take up to 55+ ms to complete the controller
+		 * restore so setting the timeout to 100ms. Xhci specification
+		 * doesn't mention any timeout value.
+		 */
 		if (xhci_handshake(&xhci->op_regs->status,
-			      STS_RESTORE, 0, 10 * 1000)) {
+			      STS_RESTORE, 0, 100 * 1000)) {
 			xhci_warn(xhci, "WARN: xHC restore state timeout\n");
 			spin_unlock_irq(&xhci->lock);
 			return -ETIMEDOUT;


