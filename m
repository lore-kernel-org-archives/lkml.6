Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32932147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32932147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbeHPWHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:07:22 -0400
Received: from gateway20.websitewelcome.com ([192.185.48.38]:31613 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbeHPWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:07:21 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id E482C40103837
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:07:06 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id qNbbfR4kDbXuJqNblfod9P; Thu, 16 Aug 2018 14:07:03 -0500
X-Authority-Reason: nr=8
Received: from [189.250.72.226] (port=55386 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fqNbb-003xyK-3S; Thu, 16 Aug 2018 14:06:47 -0500
Date:   Thu, 16 Aug 2018 14:06:46 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] switchtec: Fix potential Spectre v1
Message-ID: <20180816190646.GA9610@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.72.226
X-Source-L: No
X-Exim-ID: 1fqNbb-003xyK-3S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.72.226]:55386
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p.port can is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/pci/switch/switchtec.c:912 ioctl_port_to_pff() warn: potential
spectre issue 'pcfg->dsp_pff_inst_id' [r]

Fix this by sanitizing p.port before using it to index
pcfg->dsp_pff_inst_id

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/switch/switchtec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 9940cc7..54a8b30 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -14,6 +14,8 @@
 #include <linux/poll.h>
 #include <linux/wait.h>
 
+#include <linux/nospec.h>
+
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
 MODULE_VERSION("0.1");
 MODULE_LICENSE("GPL");
@@ -909,6 +911,8 @@ static int ioctl_port_to_pff(struct switchtec_dev *stdev,
 	default:
 		if (p.port > ARRAY_SIZE(pcfg->dsp_pff_inst_id))
 			return -EINVAL;
+		p.port = array_index_nospec(p.port,
+					ARRAY_SIZE(pcfg->dsp_pff_inst_id) + 1);
 		p.pff = ioread32(&pcfg->dsp_pff_inst_id[p.port - 1]);
 		break;
 	}
-- 
2.7.4

