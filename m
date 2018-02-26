Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeBZRgz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:36:55 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:3746 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBZRgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:36:50 -0500
X-IronPort-AV: E=Sophos;i="5.47,397,1515456000";
   d="scan'208";a="333500580"
From: Amit Shah <aams@amazon.com>
To: <xen-devel@lists.xenproject.org>
CC: <linux-kernel@vger.kernel.org>, Amit Shah <aams@amazon.com>,
        <stable@vger.kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        David Vrabel <david.vrabel@citrix.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Eduardo Valentin <eduval@amazon.com>, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Liu Shuo <shuo.a.liu@intel.com>, Anoob Soman <anoob.soman@citrix.com>
Subject: [PATCH 2/2] xen: events: free irqs in error condition
Date: Mon, 26 Feb 2018 17:36:35 +0000
Message-ID: <1519666595-41362-3-git-send-email-aams@amazon.com>
X-Mailer: git-send-email 2.7.3.AMZN
In-Reply-To: <1519666595-41362-1-git-send-email-aams@amazon.com>
References: <1519666595-41362-1-git-send-email-aams@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1QHbFs3003091

In case of errors in irq setup for MSI, free up the allocated irqs.

Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message groups")
Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
CC: <stable@vger.kernel.org>
CC: Roger Pau Monné <roger.pau@citrix.com>
CC: David Vrabel <david.vrabel@citrix.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Eduardo Valentin <eduval@amazon.com>
CC: Juergen Gross <jgross@suse.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Liu Shuo <shuo.a.liu@intel.com>
CC: Anoob Soman <anoob.soman@citrix.com>
Signed-off-by: Amit Shah <aams@amazon.com>
---
 drivers/xen/events/events_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index b6b8b29..96aa575 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -758,6 +758,7 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 error_irq:
 	for (; i >= 0; i--)
 		__unbind_from_irq(irq + i);
+	xen_free_irq(irq);
 	mutex_unlock(&irq_mapping_update_lock);
 	return ret;
 }
-- 
2.7.3.AMZN

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
