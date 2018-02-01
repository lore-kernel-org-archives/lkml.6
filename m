Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeBAKSK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:18:10 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:47600 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752098AbeBAKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:18:09 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511823600";
   d="scan'208";a="311588504"
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: reduce false positives
Date: Thu,  1 Feb 2018 10:48:52 +0100
Message-Id: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some files use both a non-devm allocation and a devm_allocation.  Don't
complain about a free when the same function contains a non-devm
allocation.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/free/devm_free.cocci |   55 +++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
index c990d2c..b2a2cf8b 100644
--- a/scripts/coccinelle/free/devm_free.cocci
+++ b/scripts/coccinelle/free/devm_free.cocci
@@ -56,9 +56,62 @@ expression x;
  x = devm_ioport_map(...)
 )
 
+@safe depends on context || org || report exists@
+expression x;
+position p;
+@@
+
+(
+ x = kmalloc(...)
+|
+ x = kvasprintf(...)
+|
+ x = kasprintf(...)
+|
+ x = kzalloc(...)
+|
+ x = kmalloc_array(...)
+|
+ x = kcalloc(...)
+|
+ x = kstrdup(...)
+|
+ x = kmemdup(...)
+|
+ x = get_free_pages(...)
+|
+ x = request_irq(...)
+|
+ x = ioremap(...)
+|
+ x = ioremap_nocache(...)
+|
+ x = ioport_map(...)
+)
+...
+(
+ kfree@p(x)
+|
+ kzfree@p(x)
+|
+ __krealloc@p(x, ...)
+|
+ krealloc@p(x, ...)
+|
+ free_pages@p(x, ...)
+|
+ free_page@p(x)
+|
+ free_irq@p(x)
+|
+ iounmap@p(x)
+|
+ ioport_unmap@p(x)
+)
+
 @pb@
 expression r.x;
-position p;
+position p != safe.p;
 @@
 
 (
