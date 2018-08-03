Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B13C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE3D2177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE3D2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeHCTCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:02:41 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:1577 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbeHCTCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:02:41 -0400
X-IronPort-AV: E=Sophos;i="5.51,439,1526335200"; 
   d="scan'208";a="341340983"
Received: from palace.lip6.fr (HELO localhost.localdomain) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 03 Aug 2018 19:05:30 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        zhong jiang <zhongjiang@huawei.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: [PATCH] Coccinelle: doubletest: reduce side effect false positives
Date:   Fri,  3 Aug 2018 18:32:11 +0200
Message-Id: <1533313931-3639-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the cited expression is not a function call or an
assignment to reduce the chance of false positives.

Slightly modify the warning message to indicate another source
of false positves.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/tests/doubletest.cocci |   34 ++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/scripts/coccinelle/tests/doubletest.cocci b/scripts/coccinelle/tests/doubletest.cocci
index 78d74c2..7af2ce7 100644
--- a/scripts/coccinelle/tests/doubletest.cocci
+++ b/scripts/coccinelle/tests/doubletest.cocci
@@ -1,6 +1,7 @@
 /// Find &&/|| operations that include the same argument more than once
-//# A common source of false positives is when the argument performs a side
-//# effect.
+//# A common source of false positives is when the expression, or
+//# another expresssion in the same && or || operation, performs a
+//# side effect.
 ///
 // Confidence: Moderate
 // Copyright: (C) 2010 Nicolas Palix, DIKU.  GPLv2.
@@ -20,20 +21,37 @@ position p;
 @@
 
 (
-* E@p
-  || ... || E
+ E@p || ... || E
 |
-* E@p
-  && ... && E
+ E@p && ... && E
 )
 
-@script:python depends on org@
+@bad@
+expression r.E,e1,e2,fn;
+position r.p;
+assignment operator op;
+@@
+
+(
+E@p
+&
+ <+... \(fn(...)\|e1 op e2\|e1++\|e1--\|++e1\|--e1\) ...+>
+)
+
+@depends on context && !bad@
+expression r.E;
+position r.p;
+@@
+
+*E@p
+
+@script:python depends on org && !bad@
 p << r.p;
 @@
 
 cocci.print_main("duplicated argument to && or ||",p)
 
-@script:python depends on report@
+@script:python depends on report && !bad@
 p << r.p;
 @@
 

