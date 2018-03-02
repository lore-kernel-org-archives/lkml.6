Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988998-2-1876142000573298573
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
    t=1519988997; b=F/RqWnqK6llZvTc+q9HHbep5moZLFw0odC3VVTLGxIoOLYQ
    zw0vL7/Axw6Tnl9VIxunqTvjK780OLig27TAzoDmFJIIM18EwgQJ8bT1lYmZP+qR
    Bj711LL5x6OW4rXgXukzA0X6DaLqLzMGdXt1X1oH31wAwn1Z5l0Z5KE8Aopu/Cwb
    8/AX9+5XTgmoa826riNKenptPWMG0ziK/N0NvMTMzwykDCdLu57tR6EMVyx0NKtS
    ZAfWgLby4QsKMqWwBsec+FxbETDdFDoBTpYBzEyq2azAa4RwInqQ4t2ichAoOwxf
    xkcL8fvwV7EGxSEqXQ2x0LckOqpsiP/gF5hV9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519988997; bh=HLqR+L2LEacFA1xtKwZUKU12JR
    lbWN+5DYcIINNjk98=; b=GCD/hubtilVqM370kU1Jfu6WgfPu0Vy31ASu8FDbDo
    BLLn72Sq50lkdYNzUsYkeoGcukUzr1jTI0g7DfNIZQOSipUGsw8EJ59zCadZvTrS
    4TIrJ5zvuCRFJDhTaZsvaBPSQvTmlId83pPHCAVIB+GbpK+FWCz0sWw2kwKbhr/n
    qFeoI+6mt/MNvZU0nG+hA7kAWxlkb9SjnnTt08uMHji8sczvav6xzr0p9kTR47sa
    A13h8K7VBpcxbn5RVaZdkGgavxKMNlCtOoQJ5q3XCbZgZ6HoLpgjFfJQ3VR+tR67
    CNTjQTC+WGtyQOBgLWR4ZYvFVZh1O3MxBjpylq+Qkpzw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423500AbeCBIy1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:54:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423495AbeCBIyY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Shahed Shaikh <Shahed.Shaikh@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 15/34] bnx2x: Improve reliability in case of nested PCI errors
Date: Fri,  2 Mar 2018 09:51:11 +0100
Message-Id: <20180302084436.942538303@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3052,7 +3052,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, i
 
 	del_timer_sync(&bp->timer);
 
-	if (IS_PF(bp)) {
+	if (IS_PF(bp) && !BP_NOMCP(bp)) {
 		/* Set ALWAYS_ALIVE bit in shmem */
 		bp->fw_drv_pulse_wr_seq |= DRV_PULSE_ALWAYS_ALIVE;
 		bnx2x_drv_pulse(bp);
@@ -3134,7 +3134,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, i
 	bp->cnic_loaded = false;
 
 	/* Clear driver version indication in shmem */
-	if (IS_PF(bp))
+	if (IS_PF(bp) && !BP_NOMCP(bp))
 		bnx2x_update_mng_version(bp);
 
 	/* Check if there are pending parity attentions. If there are - set
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9570,6 +9570,15 @@ static int bnx2x_init_shmem(struct bnx2x
 
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
@@ -14214,7 +14223,10 @@ static pci_ers_result_t bnx2x_io_slot_re
 		BNX2X_ERR("IO slot reset --> driver unload\n");
 
 		/* MCP should have been reset; Need to wait for validity */
-		bnx2x_init_shmem(bp);
+		if (bnx2x_init_shmem(bp)) {
+			rtnl_unlock();
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
 
 		if (IS_PF(bp) && SHMEM2_HAS(bp, drv_capabilities_flag)) {
 			u32 v;
