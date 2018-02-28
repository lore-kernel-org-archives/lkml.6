Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3911302-1519809558-2-2165333814911797822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519809557; b=r4CBGmSOYxQtXalZE3WYLzEr6JZL1dV++XaVze3pcd3GMlg
    I971Bv2xOit0VgEVOg3Fd4dZBZwfiY6ws1edvA8qGs4G0Sh2aqi59XWM7qvBtRJV
    Ai6WA3NzIinQl853SrX6kvpnv3BHsJwJjLSIRGT5zZwJIFy6OZW7Z8QOz2qtb4LC
    6bcIo8e44eNZSv97W07dp1abzM0FQ0MC4/1KQlY6z/KFSLBu7t99rrmLcYyOfsF9
    EH8ZjhoEROO3/aXxHA0evTJbuAxGFTxdmI2jL8WS70EHse4YQtQyf5I5SFjQvfYU
    2QVNLc+wwtUTUSXvAx4RdOKPIpB3oIiC6qDPMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519809557; bh=L60KcYH03nTWGJ6nXz8Knb22/2
    JVyB4L+hf68fTAS+U=; b=XM96Wyh8RHm1Tf2S7vV3ykTlDVhBPxn0sthDJqKiSc
    S2Y9PmKdjBK7mMNZhHg5/ava+c9UMmCvzOrhG1XpkpBIFTQCbiLweyfYlrwSTCDS
    sMJd/KDIkjvVMqm0D7QOQll2U2uUwhuBRCtmY8XZSwXkU6LhwCEqGWocxB9r26vx
    pRHwxPR3ZXOczfezyrB0GnnLGPgG4sbuaRl5WpnSh3nFSUX2Y48C3xT7Bc7ltcoP
    7EhE8ak0kvgMNVkmAVfjXpMq1Zr1qyVmWjeQlxRasSUpBTkrhGDZGM9EtZ1cgPEA
    Q4VFo4tsq646qs4TfD0s5ohtbvURuwc49McU7UCm/qfg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeB1JTP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 04:19:15 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:49306 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeB1JTO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 04:19:14 -0500
X-IronPort-AV: E=Sophos;i="5.47,405,1515456000";
   d="scan'208";a="68761293"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <linux-kernel@vger.kernel.org>
CC: Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Amit Shah <aams@amazon.com>,
        <stable@vger.kernel.org>, <xen-devel@lists.xenproject.org>
Subject: [PATCH] xen/pirq: fix error path cleanup when binding MSIs
Date: Wed, 28 Feb 2018 09:19:03 +0000
Message-ID: <20180228091903.99889-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Current cleanup in the error path of xen_bind_pirq_msi_to_irq is
wrong. First of all there's an off-by-one in the cleanup loop, which
can lead to unbinding wrong IRQs.

Secondly IRQs not bound won't be freed, thus leaking IRQ numbers.

Note that there's no need to differentiate between bound and unbound
IRQs when freeing them, __unbind_from_irq will deal with both of them
correctly.

Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message groups")
Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Amit Shah <aams@amazon.com>
CC: stable@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/events/events_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index b241bfa529ce..159faf1269fb 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -763,8 +763,8 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 	mutex_unlock(&irq_mapping_update_lock);
 	return irq;
 error_irq:
-	for (; i >= 0; i--)
-		__unbind_from_irq(irq + i);
+	while (nvec--)
+		__unbind_from_irq(irq + nvec);
 	mutex_unlock(&irq_mapping_update_lock);
 	return ret;
 }
-- 
2.16.1
