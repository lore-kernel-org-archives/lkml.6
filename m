Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217B2ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF71F214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF71F214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbeIREkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:40:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50368 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeIREkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:40:12 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8E48CAD;
        Mon, 17 Sep 2018 23:10:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH 4.18 041/158] switchtec: Fix Spectre v1 vulnerability
Date:   Tue, 18 Sep 2018 00:41:11 +0200
Message-Id: <20180917211713.077768468@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 46feb6b495f7628a6dbf36c4e6d80faf378372d4 upstream.

p.port can is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

  drivers/pci/switch/switchtec.c:912 ioctl_port_to_pff() warn: potential spectre issue 'pcfg->dsp_pff_inst_id' [r]

Fix this by sanitizing p.port before using it to index
pcfg->dsp_pff_inst_id

Notice that given that speculation windows are large, the policy is to kill
the speculation on the first load and not worry if it can be completed with
a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Logan Gunthorpe <logang@deltatee.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/switch/switchtec.c |    4 ++++
 1 file changed, 4 insertions(+)

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
@@ -909,6 +911,8 @@ static int ioctl_port_to_pff(struct swit
 	default:
 		if (p.port > ARRAY_SIZE(pcfg->dsp_pff_inst_id))
 			return -EINVAL;
+		p.port = array_index_nospec(p.port,
+					ARRAY_SIZE(pcfg->dsp_pff_inst_id) + 1);
 		p.pff = ioread32(&pcfg->dsp_pff_inst_id[p.port - 1]);
 		break;
 	}


