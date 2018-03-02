Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1414047-1519989801-2-14442424499072201411
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989800; b=J4TvlCkWFg0QAjniYgnCwB9Wp15zz2XEpyfOhNX4qY/dFoO
    +jkXf5LDMoEpFVfL6vbKuz3t1cMzDbi1WN0PsH73s+vrZw3zQyYAk9t5e79PaYV2
    9Xrz05H6B2AUi/r2klBJlkAAigPfCTRoxDntgYKjNCU1MwIbiKl8cV2jDwXd70kZ
    V8KVS0Zk7mIPLpVjBk0YZQK+p8mv7fwNJorBpNPz98qA0OVSMlNdYzCGRxjc9J5D
    BtYQHfmkjvSP/YcLfRZoSh1rfsvRAnXtzpwOauF+DxL9AvuWquut2KKD24IyNvtQ
    uQeeq2k21Wu2Q+USpDyfu9LP3Q67lJYwW4rmPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989800; bh=MFNktj7QRNWdHUv57hxeJpZqx/
    TXBUwCRXu/NAFjDSg=; b=n0p6VkBiodYZkk3ss2ty93gf984LloBFCz+jLPI4f/
    smhVb8lz5ZXNndg4kG8kXnckvRm95zpWEFRttApYOkWLlMuxecmElpFpjtU21Qom
    1GbhS4UcR5FJ2+EEV/vwUb/qoDo94qCnuzdYl4a12FMHejgqTHvH33u/naIOsMH2
    b+ZLaeeQp4wdepc5xHfdToL0V6D8KgMq53d27V2EE6G2tyHeZi+zI2ZTDjmHKlla
    gPRmkXrpGvhZ7fYfLM56QeRfK2IVhIL1Pyz2vBy9P6GSy+yDSI0oN5/rtRc5saIP
    2Gc8iLf0c4jrVbzEFx4VehXxzW/wbWnjw2y9BuZKQzbw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423211AbeCBLWt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:22:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49036 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164824AbeCBIvh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:51:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Shahed Shaikh <Shahed.Shaikh@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 11/24] bnx2x: Improve reliability in case of nested PCI errors
Date: Fri,  2 Mar 2018 09:51:08 +0100
Message-Id: <20180302084239.716238623@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084239.157503766@linuxfoundation.org>
References: <20180302084239.157503766@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>


[ Upstream commit f7084059a9cb9e56a186e1677b1dcffd76c2cd24 ]

While in recovery process of PCI error (called EEH on PowerPC arch),
another PCI transaction could be corrupted causing a situation of
nested PCI errors. Also, this scenario could be reproduced with
error injection mechanisms (for debug purposes).

We observe that in case of nested PCI errors, bnx2x might attempt to
initialize its shmem and cause a kernel crash due to bad addresses
read from MCP. Multiple different stack traces were observed depending
on the point the second PCI error happens.

This patch avoids the crashes by:

 * failing PCI recovery in case of nested errors (since multiple
 PCI errors in a row are not expected to lead to a functional
 adapter anyway), and by,

 * preventing access to adapter FW when MCP is failed (we mark it as
 failed when shmem cannot get initialized properly).

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Acked-by: Shahed Shaikh <Shahed.Shaikh@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |    4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |   14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -2994,7 +2994,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, i
 
 	del_timer_sync(&bp->timer);
 
-	if (IS_PF(bp)) {
+	if (IS_PF(bp) && !BP_NOMCP(bp)) {
 		/* Set ALWAYS_ALIVE bit in shmem */
 		bp->fw_drv_pulse_wr_seq |= DRV_PULSE_ALWAYS_ALIVE;
 		bnx2x_drv_pulse(bp);
@@ -3076,7 +3076,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, i
 	bp->cnic_loaded = false;
 
 	/* Clear driver version indication in shmem */
-	if (IS_PF(bp))
+	if (IS_PF(bp) && !BP_NOMCP(bp))
 		bnx2x_update_mng_version(bp);
 
 	/* Check if there are pending parity attentions. If there are - set
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9472,6 +9472,15 @@ static int bnx2x_init_shmem(struct bnx2x
 
 	do {
 		bp->common.shmem_base = REG_RD(bp, MISC_REG_SHARED_MEM_ADDR);
+
+		/* If we read all 0xFFs, means we are in PCI error state and
+		 * should bail out to avoid crashes on adapter's FW reads.
+		 */
+		if (bp->common.shmem_base == 0xFFFFFFFF) {
+			bp->flags |= NO_MCP_FLAG;
+			return -ENODEV;
+		}
+
 		if (bp->common.shmem_base) {
 			val = SHMEM_RD(bp, validity_map[BP_PORT(bp)]);
 			if (val & SHR_MEM_VALIDITY_MB)
@@ -13743,7 +13752,10 @@ static pci_ers_result_t bnx2x_io_slot_re
 		BNX2X_ERR("IO slot reset --> driver unload\n");
 
 		/* MCP should have been reset; Need to wait for validity */
-		bnx2x_init_shmem(bp);
+		if (bnx2x_init_shmem(bp)) {
+			rtnl_unlock();
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
 
 		if (IS_PF(bp) && SHMEM2_HAS(bp, drv_capabilities_flag)) {
 			u32 v;
