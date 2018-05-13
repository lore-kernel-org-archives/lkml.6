Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeEMOGF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:06:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeEMOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:06:04 -0400
Date: Sun, 13 May 2018 07:05:52 -0700
From: tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-6461934371bfc1bfe6b424b197a546b4effd0a32@git.kernel.org>
Cc: ard.biesheuvel@linaro.org, hpa@zytor.com, miquel.raynal@bootlin.com,
        tglx@linutronix.de, jason@lakedaemon.net,
        srinivas.kandagatla@linaro.org, marc.zyngier@arm.com, mingo@kernel.org,
        robh@kernel.org, thomas.petazzoni@bootlin.com,
        linux-kernel@vger.kernel.org
Reply-To: miquel.raynal@bootlin.com, hpa@zytor.com,
        srinivas.kandagatla@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        thomas.petazzoni@bootlin.com, robh@kernel.org, mingo@kernel.org
In-Reply-To: <20180508121438.11301-6-marc.zyngier@arm.com>
References: <20180508121438.11301-6-marc.zyngier@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irqdomain: Let irq_find_host default to
 DOMAIN_BUS_WIRED
Git-Commit-ID: 6461934371bfc1bfe6b424b197a546b4effd0a32
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6461934371bfc1bfe6b424b197a546b4effd0a32
Gitweb:     https://git.kernel.org/tip/6461934371bfc1bfe6b424b197a546b4effd0a32
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Tue, 8 May 2018 13:14:34 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:59:00 +0200

irqdomain: Let irq_find_host default to DOMAIN_BUS_WIRED

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lkml.kernel.org/r/20180508121438.11301-6-marc.zyngier@arm.com

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
