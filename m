Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988969-2-5684590609713760406
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
    t=1519988969; b=oNRMcLKTiY7oByvsDzKkN1RMP5wG7cqhL+y9mGi63aOb2KS
    PIwgyzI4+ICLH1so4/K+MVtw2N0eq6wjNjObRuLcJKAQ0fDU6fqR+y6YnOl3k3r+
    K0tq8XLLNbEjCtvPqeL9lQpbbJspE14I2pNPgBLnE2qpfgXyoR9aygxmc5TiKSmP
    Ws9If0vqVqPnVPpiDYZSeB8kQ65IUEjSutok8YIJcz9OWB8dVyY8QVsCyyDZtS92
    DKea8Rt9kkvud8lTPC/hm/n1AE/6n1JXPYeuclZAI/Ecyo4dYoffGXIU0g73hSXo
    a5OAC4aDk2ziQ1SgfjMSnLgiMMEk6ENu8UKfI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519988969; bh=taxBOlE6N42GLhh41EVotVU+//
    93O1+i8U0IIMtHNa4=; b=MfYEebXV8ma0hJ7nmI4DqGELzKlm4lb4hlg6n6NLaJ
    Zd/s6Puor99BzaX/VQMrEkV7GWP4N09BpwUQsux+8CZoQmjNGSnBYfO647vFQoBm
    oplxx4YHBN7v38A8vo+Jo6oSThnPfJQkL4GxU1ocGkMZSP9lydvlvgySYDoU69BU
    X27cs8eFrMSEiPJWFfPB3jIc8MI2v+EPnGw50lA52szrg4mNTTGbOtablxeQbDoh
    1Fv6XRfEuruTkNzpE+xvjTci6Bdn3wE1iRz0RB4PVU72frKuk3Nz+oHkGkZxYdD9
    aD3uxIsnOHRBuUKymo38uja61y9ul0UOCEjuoY/2psMQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423517AbeCBIyf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:54:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423495AbeCBIya (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 17/34] s390/dasd: fix wrongly assigned configuration data
Date: Fri,  2 Mar 2018 09:51:13 +0100
Message-Id: <20180302084437.073338066@linuxfoundation.org>
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

From: Stefan Haberland <sth@linux.vnet.ibm.com>


[ Upstream commit 8a9bd4f8ebc6800bfc0596e28631ff6809a2f615 ]

We store per path and per device configuration data to identify the
path or device correctly. The per path configuration data might get
mixed up if the original request gets into error recovery and is
started with a random path mask.

This would lead to a wrong identification of a path in case of a CUIR
event for example.

Fix by copying the path mask from the original request to the error
recovery request in case it is a path verification request.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd_3990_erp.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2743,6 +2743,16 @@ dasd_3990_erp_action(struct dasd_ccw_req
 		erp = dasd_3990_erp_handle_match_erp(cqr, erp);
 	}
 
+
+	/*
+	 * For path verification work we need to stick with the path that was
+	 * originally chosen so that the per path configuration data is
+	 * assigned correctly.
+	 */
+	if (test_bit(DASD_CQR_VERIFY_PATH, &erp->flags) && cqr->lpm) {
+		erp->lpm = cqr->lpm;
+	}
+
 	if (device->features & DASD_FEATURE_ERPLOG) {
 		/* print current erp_chain */
 		dev_err(&device->cdev->dev,
