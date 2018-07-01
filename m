Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8853DC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432802487F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432802487F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031724AbeGAQjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:39:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031202AbeGAQjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:39:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14945AA6;
        Sun,  1 Jul 2018 16:39:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Alastair DSilva <alastair@d-silva.org>,
        Christophe Lombard <clombard@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.17 059/220] cxl: Configure PSL to not use APC virtual machines
Date:   Sun,  1 Jul 2018 18:21:23 +0200
Message-Id: <20180701160910.838449918@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

commit 9a6d2022bacd8fca0be6297459a02dfd28dad6ba upstream.

APC virtual machines arent used on POWER-9 chips and are already
disabled in on-chip CAPP. They also need to be disabled on the PSL via
'PSL Data Send Control Register' by setting bit(47). This forces the
PSL to send commands to CAPP with queue.id == 0.

Fixes: 5632874311db ("cxl: Add support for POWER9 DD2")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/cxl/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -514,9 +514,9 @@ static int init_implementation_adapter_r
 	cxl_p1_write(adapter, CXL_PSL9_FIR_CNTL, psl_fircntl);
 
 	/* Setup the PSL to transmit packets on the PCIe before the
-	 * CAPP is enabled
+	 * CAPP is enabled. Make sure that CAPP virtual machines are disabled
 	 */
-	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000002A10ULL);
+	cxl_p1_write(adapter, CXL_PSL9_DSNDCTL, 0x0001001000012A10ULL);
 
 	/*
 	 * A response to an ASB_Notify request is returned by the


