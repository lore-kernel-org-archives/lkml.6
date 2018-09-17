Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10C6ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F37C2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F37C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbeIRE3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:29:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeIRE3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:29:23 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E81B8C03;
        Mon, 17 Sep 2018 22:59:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.14 002/126] i2c: i801: fix DNVs SMBCTRL register offset
Date:   Tue, 18 Sep 2018 00:40:50 +0200
Message-Id: <20180917211703.629485173@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
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

From: Felipe Balbi <felipe.balbi@linux.intel.com>

commit 851a15114895c5bce163a6f2d57e0aa4658a1be4 upstream.

DNV's iTCO is slightly different with SMBCTRL sitting at a different
offset when compared to all other devices. Let's fix so that we can
properly use iTCO watchdog.

Fixes: 84d7f2ebd70d ("i2c: i801: Add support for Intel DNV")
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-i801.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -138,6 +138,7 @@
 
 #define SBREG_BAR		0x10
 #define SBREG_SMBCTRL		0xc6000c
+#define SBREG_SMBCTRL_DNV	0xcf000c
 
 /* Host status bits for SMBPCISTS */
 #define SMBPCISTS_INTS		BIT(3)
@@ -1395,7 +1396,11 @@ static void i801_add_tco(struct i801_pri
 	spin_unlock(&p2sb_spinlock);
 
 	res = &tco_res[ICH_RES_MEM_OFF];
-	res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL;
+	if (pci_dev->device == PCI_DEVICE_ID_INTEL_DNV_SMBUS)
+		res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL_DNV;
+	else
+		res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL;
+
 	res->end = res->start + 3;
 	res->flags = IORESOURCE_MEM;
 


