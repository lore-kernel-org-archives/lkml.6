Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82EEC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999E221476
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999E221476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbeJBUOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730696AbeJBUOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:17 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4BC1FC2B;
        Tue,  2 Oct 2018 13:30:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 171/228] bus: ti-sysc: Fix module register ioremap for larger offsets
Date:   Tue,  2 Oct 2018 06:24:28 -0700
Message-Id: <20181002132510.234471935@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 0ef8e3bb974af56346b34393e643d491d9141c66 ]

We can have the interconnect target module control registers pretty
much anywhere within the module range. The current code attempts an
incomplete optimization of the ioremap size but does it wrong and
it only works for registers at the beginning of the module.

Let's just use the largest control register to calculate the ioremap
size. The ioremapped range is for most part cached anyways so there
is no need for size optimization. Let's also update the comments
accordingly.

Fixes: 0eecc636e5a2 ("bus: ti-sysc: Add minimal TI sysc interconnect
target driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/ti-sysc.c |   29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -490,32 +490,29 @@ static int sysc_check_registers(struct s
 
 /**
  * syc_ioremap - ioremap register space for the interconnect target module
- * @ddata: deviec driver data
+ * @ddata: device driver data
  *
  * Note that the interconnect target module registers can be anywhere
- * within the first child device address space. For example, SGX has
- * them at offset 0x1fc00 in the 32MB module address space. We just
- * what we need around the interconnect target module registers.
+ * within the interconnect target module range. For example, SGX has
+ * them at offset 0x1fc00 in the 32MB module address space. And cpsw
+ * has them at offset 0x1200 in the CPSW_WR child. Usually the
+ * the interconnect target module registers are at the beginning of
+ * the module range though.
  */
 static int sysc_ioremap(struct sysc *ddata)
 {
-	u32 size = 0;
+	int size;
 
-	if (ddata->offsets[SYSC_SYSSTATUS] >= 0)
-		size = ddata->offsets[SYSC_SYSSTATUS];
-	else if (ddata->offsets[SYSC_SYSCONFIG] >= 0)
-		size = ddata->offsets[SYSC_SYSCONFIG];
-	else if (ddata->offsets[SYSC_REVISION] >= 0)
-		size = ddata->offsets[SYSC_REVISION];
-	else
-		return -EINVAL;
+	size = max3(ddata->offsets[SYSC_REVISION],
+		    ddata->offsets[SYSC_SYSCONFIG],
+		    ddata->offsets[SYSC_SYSSTATUS]);
 
-	size &= 0xfff00;
-	size += SZ_256;
+	if (size < 0 || (size + sizeof(u32)) > ddata->module_size)
+		return -EINVAL;
 
 	ddata->module_va = devm_ioremap(ddata->dev,
 					ddata->module_pa,
-					size);
+					size + sizeof(u32));
 	if (!ddata->module_va)
 		return -EIO;
 


