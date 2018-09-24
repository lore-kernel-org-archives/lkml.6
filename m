Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D27ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F5D2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F5D2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbeIXSrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:47:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbeIXSrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:47:40 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 244E0109A;
        Mon, 24 Sep 2018 12:45:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH 4.18 235/235] crypto: ccp - add timeout support in the SEV command
Date:   Mon, 24 Sep 2018 13:53:41 +0200
Message-Id: <20180924113126.164460105@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Brijesh Singh <brijesh.singh@amd.com>

commit 3702a0585e64d70d5bf73bf3e943b8d6005b72c1 upstream.

Currently, the CCP driver assumes that the SEV command issued to the PSP
will always return (i.e. it will never hang).  But recently, firmware bugs
have shown that a command can hang.  Since of the SEV commands are used
in probe routines, this can cause boot hangs and/or loss of virtualization
capabilities.

To protect against firmware bugs, add a timeout in the SEV command
execution flow.  If a command does not complete within the specified
timeout then return -ETIMEOUT and stop the driver from executing any
further commands since the state of the SEV firmware is unknown.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Gary Hook <Gary.Hook@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
[Brijesh: Backported to 4.18..4.19 - offset change in few hunks]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/ccp/psp-dev.c |   46 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -38,6 +38,17 @@ static DEFINE_MUTEX(sev_cmd_mutex);
 static struct sev_misc_dev *misc_dev;
 static struct psp_device *psp_master;
 
+static int psp_cmd_timeout = 100;
+module_param(psp_cmd_timeout, int, 0644);
+MODULE_PARM_DESC(psp_cmd_timeout, " default timeout value, in seconds, for PSP commands");
+
+static int psp_probe_timeout = 5;
+module_param(psp_probe_timeout, int, 0644);
+MODULE_PARM_DESC(psp_probe_timeout, " default timeout value, in seconds, during PSP device probe");
+
+static bool psp_dead;
+static int psp_timeout;
+
 static struct psp_device *psp_alloc_struct(struct sp_device *sp)
 {
 	struct device *dev = sp->dev;
@@ -82,10 +93,19 @@ done:
 	return IRQ_HANDLED;
 }
 
-static void sev_wait_cmd_ioc(struct psp_device *psp, unsigned int *reg)
+static int sev_wait_cmd_ioc(struct psp_device *psp,
+			    unsigned int *reg, unsigned int timeout)
 {
-	wait_event(psp->sev_int_queue, psp->sev_int_rcvd);
+	int ret;
+
+	ret = wait_event_timeout(psp->sev_int_queue,
+			psp->sev_int_rcvd, timeout * HZ);
+	if (!ret)
+		return -ETIMEDOUT;
+
 	*reg = ioread32(psp->io_regs + PSP_CMDRESP);
+
+	return 0;
 }
 
 static int sev_cmd_buffer_len(int cmd)
@@ -133,12 +153,15 @@ static int __sev_do_cmd_locked(int cmd,
 	if (!psp)
 		return -ENODEV;
 
+	if (psp_dead)
+		return -EBUSY;
+
 	/* Get the physical address of the command buffer */
 	phys_lsb = data ? lower_32_bits(__psp_pa(data)) : 0;
 	phys_msb = data ? upper_32_bits(__psp_pa(data)) : 0;
 
-	dev_dbg(psp->dev, "sev command id %#x buffer 0x%08x%08x\n",
-		cmd, phys_msb, phys_lsb);
+	dev_dbg(psp->dev, "sev command id %#x buffer 0x%08x%08x timeout %us\n",
+		cmd, phys_msb, phys_lsb, psp_timeout);
 
 	print_hex_dump_debug("(in):  ", DUMP_PREFIX_OFFSET, 16, 2, data,
 			     sev_cmd_buffer_len(cmd), false);
@@ -154,7 +177,18 @@ static int __sev_do_cmd_locked(int cmd,
 	iowrite32(reg, psp->io_regs + PSP_CMDRESP);
 
 	/* wait for command completion */
-	sev_wait_cmd_ioc(psp, &reg);
+	ret = sev_wait_cmd_ioc(psp, &reg, psp_timeout);
+	if (ret) {
+		if (psp_ret)
+			*psp_ret = 0;
+
+		dev_err(psp->dev, "sev command %#x timed out, disabling PSP \n", cmd);
+		psp_dead = true;
+
+		return ret;
+	}
+
+	psp_timeout = psp_cmd_timeout;
 
 	if (psp_ret)
 		*psp_ret = reg & PSP_CMDRESP_ERR_MASK;
@@ -886,6 +920,8 @@ void psp_pci_init(void)
 
 	psp_master = sp->psp_data;
 
+	psp_timeout = psp_probe_timeout;
+
 	if (sev_get_api_version())
 		goto err;
 


