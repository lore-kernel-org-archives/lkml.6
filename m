Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5626121479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5626121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeHPVrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:47:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeHPVrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:47:02 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5D3F4CE8;
        Thu, 16 Aug 2018 18:46:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.17 11/21] crypto: ccp - Fix command completion detection race
Date:   Thu, 16 Aug 2018 20:45:21 +0200
Message-Id: <20180816171613.101659505@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171612.136242278@linuxfoundation.org>
References: <20180816171612.136242278@linuxfoundation.org>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

commit f426d2b20f1cd63818873593031593e15c3db20b upstream.

The wait_event() function is used to detect command completion.  The
interrupt handler will set the wait condition variable when the interrupt
is triggered.  However, the variable used for wait_event() is initialized
after the command has been submitted, which can create a race condition
with the interrupt handler and result in the wait_event() never returning.
Move the initialization of the wait condition variable to just before
command submission.

Fixes: 200664d5237f ("crypto: ccp: Add Secure Encrypted Virtualization (SEV) command support")
Cc: <stable@vger.kernel.org> # 4.16.x-
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Acked-by: Gary R Hook <gary.hook@amd.com>
Acked-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/psp-dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -78,8 +78,6 @@ done:
 
 static void sev_wait_cmd_ioc(struct psp_device *psp, unsigned int *reg)
 {
-	psp->sev_int_rcvd = 0;
-
 	wait_event(psp->sev_int_queue, psp->sev_int_rcvd);
 	*reg = ioread32(psp->io_regs + PSP_CMDRESP);
 }
@@ -140,6 +138,8 @@ static int __sev_do_cmd_locked(int cmd,
 	iowrite32(phys_lsb, psp->io_regs + PSP_CMDBUFF_ADDR_LO);
 	iowrite32(phys_msb, psp->io_regs + PSP_CMDBUFF_ADDR_HI);
 
+	psp->sev_int_rcvd = 0;
+
 	reg = cmd;
 	reg <<= PSP_CMDRESP_CMD_SHIFT;
 	reg |= PSP_CMDRESP_IOC;


