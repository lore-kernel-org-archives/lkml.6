Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24947ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D685720652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D685720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbeGTNb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54556 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731571AbeGTNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:56 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 31C50C75;
        Fri, 20 Jul 2018 12:38:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kubecek <mkubecek@suse.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 056/101] Revert "s390/qeth: use Read device to query hypervisor for MAC"
Date:   Fri, 20 Jul 2018 14:14:02 +0200
Message-Id: <20180720121425.484965877@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 4664610537d398d55be19432f9cd9c29c831e159 ]

This reverts commit b7493e91c11a757cf0f8ab26989642ee4bb2c642.

On its own, querying RDEV for a MAC address works fine. But when upgrading
from a qeth that previously queried DDEV on a z/VM NIC (ie. any kernel with
commit ec61bd2fd2a2), the RDEV query now returns a _different_ MAC address
than the DDEV query.

If the NIC is configured with MACPROTECT, z/VM apparently requires us to
use the MAC that was initially returned (on DDEV) and registered. So after
upgrading to a kernel that uses RDEV, the SETVMAC registration cmd for the
new MAC address fails and we end up with a non-operabel interface.

To avoid regressions on upgrade, switch back to using DDEV for the MAC
address query. The downgrade path (first RDEV, later DDEV) is fine, in this
case both queries return the same MAC address.

Fixes: b7493e91c11a ("s390/qeth: use Read device to query hypervisor for MAC")
Reported-by: Michal Kubecek <mkubecek@suse.com>
Tested-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4845,7 +4845,7 @@ int qeth_vm_request_mac(struct qeth_card
 		goto out;
 	}
 
-	ccw_device_get_id(CARD_RDEV(card), &id);
+	ccw_device_get_id(CARD_DDEV(card), &id);
 	request->resp_buf_len = sizeof(*response);
 	request->resp_version = DIAG26C_VERSION2;
 	request->op_code = DIAG26C_GET_MAC;


