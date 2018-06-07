Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2OrLBJBEGVt9FAAAmS7hNA
	; Thu, 07 Jun 2018 14:43:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3D23608BA; Thu,  7 Jun 2018 14:43:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5B150602FC;
	Thu,  7 Jun 2018 14:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B150602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934857AbeFGOnY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:43:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40673 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934069AbeFGOnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:43:21 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbV-0005Zs-T0; Thu, 07 Jun 2018 15:09:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0003Ae-Vt; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hooman Mirhadi" <mirhadih@amazon.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Amit Shah" <aams@amazon.com>,
        "Roger Pau Monne" <roger.pau@citrix.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.731340500@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 312/410] xen/pirq: fix error path cleanup when
 binding MSIs
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Pau Monne <roger.pau@citrix.com>

commit 910f8befdf5bccf25287d9f1743e3e546bcb7ce0 upstream.

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
Reviewed-by: Amit Shah <aams@amazon.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/xen/events/events_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -763,8 +763,8 @@ out:
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
