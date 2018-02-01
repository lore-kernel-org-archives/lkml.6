Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeBAR7Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:59:25 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46996 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeBAR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:59:24 -0500
X-Google-Smtp-Source: AH8x226OSskaorIpLu0eQef7tXx1wHBhFI0lR051GkLnySJNfg94XuAA84t5AbO27X6JKkCGIkPRSw==
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2] powerpc: pseries: use of_irq_get helper in request_event_sources_irqs
Date: Thu,  1 Feb 2018 11:59:22 -0600
Message-Id: <20180201175922.18930-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling both of_irq_parse_one and irq_create_of_mapping, call
of_irq_get instead which does essentially the same thing. of_irq_get
also calls irq_find_host for deferred probe support, but this should be
fine as irq_create_of_mapping also calls that internally. This gets us
closer to making the former 2 functions static.

In the process of simplifying request_event_sources_irqs, combine the
the pr_err and WARN_ON calls to just a WARN().

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Fix infinite loop
- Use of_irq_get instead to irq_of_parse_and_map to preserve handling of 
  errors
- Combine pr_err and WARN_ON calls to single WARN

 arch/powerpc/platforms/pseries/event_sources.c | 40 +++++++++-----------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/event_sources.c b/arch/powerpc/platforms/pseries/event_sources.c
index 6eeb0d4bab61..446ef104fb3a 100644
--- a/arch/powerpc/platforms/pseries/event_sources.c
+++ b/arch/powerpc/platforms/pseries/event_sources.c
@@ -16,7 +16,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#include <asm/prom.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
 
 #include "pseries.h"
 
@@ -24,34 +25,19 @@ void request_event_sources_irqs(struct device_node *np,
 				irq_handler_t handler,
 				const char *name)
 {
-	int i, index, count = 0;
-	struct of_phandle_args oirq;
-	unsigned int virqs[16];
+	int i, virq, rc;
 
-	/* First try to do a proper OF tree parsing */
-	for (index = 0; of_irq_parse_one(np, index, &oirq) == 0;
-	     index++) {
-		if (count > 15)
-			break;
-		virqs[count] = irq_create_of_mapping(&oirq);
-		if (!virqs[count]) {
-			pr_err("event-sources: Unable to allocate "
-			       "interrupt number for %pOF\n",
-			       np);
-			WARN_ON(1);
-		} else {
-			count++;
-		}
-	}
+	for (i = 0; i < 16; i++) {
+		virq = of_irq_get(np, i);
+		if (virq < 0)
+			return;
+		if (WARN(!virq, "event-sources: Unable to allocate "
+			        "interrupt number for %pOF\n", np))
+			continue;
 
-	/* Now request them */
-	for (i = 0; i < count; i++) {
-		if (request_irq(virqs[i], handler, 0, name, NULL)) {
-			pr_err("event-sources: Unable to request interrupt "
-			       "%d for %pOF\n", virqs[i], np);
-			WARN_ON(1);
+		rc = request_irq(virq, handler, 0, name, NULL);
+		if (WARN(rc, "event-sources: Unable to request interrupt %d for %pOF\n",
+		    virq, np))
 			return;
-		}
 	}
 }
-
-- 
2.14.1
