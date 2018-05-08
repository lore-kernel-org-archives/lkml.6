Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932164AbeEHMPL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:15:11 -0400
Received: from foss.arm.com ([217.140.101.70]:57530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932124AbeEHMPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:15:08 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] irqdomain: Let irq_find_host default to DOMAIN_BUS_WIRED
Date: Tue,  8 May 2018 13:14:34 +0100
Message-Id: <20180508121438.11301-6-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180508121438.11301-1-marc.zyngier@arm.com>
References: <20180508121438.11301-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the beginning of times, irq_find_host() was simple. Each device node
implemented at most one irq domain, and we were happy. Over time, things
have become more complex, and we now have nodes implementing a plurality
of domains, tagged by "bus_token".

Crutially, users of irq_find_host() all expect the most basic domain
to be returned, and not any other domain such as a bus-specific MSI
domain.

So let's change irq_find_host() to first look for a DOMAIN_BUS_WIRED
domain, and only if this fails fallback to DOMAIN_BUS_ANY. Note that
this is consistent with what irq_create_fwspec_mapping is already
doing, see 530cbe100ef7 ("irqdomain: Allow domain lookup with
DOMAIN_BUS_WIRED token").

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 48c7e86bb556..dccfa65aee96 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -301,7 +301,13 @@ static inline struct irq_domain *irq_find_matching_host(struct device_node *node
 
 static inline struct irq_domain *irq_find_host(struct device_node *node)
 {
-	return irq_find_matching_host(node, DOMAIN_BUS_ANY);
+	struct irq_domain *d;
+
+	d = irq_find_matching_host(node, DOMAIN_BUS_WIRED);
+	if (!d)
+		d = irq_find_matching_host(node, DOMAIN_BUS_ANY);
+
+	return d;
 }
 
 /**
-- 
2.14.2
