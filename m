Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeEUHan (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 03:30:43 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10151 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751039AbeEUHah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 03:30:37 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520895600";
   d="scan'208";a="327694058"
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: deref_null: improve performance
Date: Mon, 21 May 2018 08:58:59 +0200
Message-Id: <1526885939-1741-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rules looking for some special cases of safe dereferences before
the collection of NULL-tested values.  The special cases are fairly
rare, but somewhat costly to find, because isomorphisms create many
variants of the rules.  There is thus no need to search for them over
and over for each NULL tested expression.  Collecting them just once
is sufficient and more efficient.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/null/deref_null.cocci |   40 +++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/scripts/coccinelle/null/deref_null.cocci b/scripts/coccinelle/null/deref_null.cocci
index b16ccb7..cbc6184 100644
--- a/scripts/coccinelle/null/deref_null.cocci
+++ b/scripts/coccinelle/null/deref_null.cocci
@@ -14,18 +14,10 @@ virtual context
 virtual org
 virtual report
 
-@ifm@
-expression *E;
-statement S1,S2;
-position p1;
-@@
-
-if@p1 ((E == NULL && ...) || ...) S1 else S2
-
 // The following two rules are separate, because both can match a single
 // expression in different ways
 @pr1 expression@
-expression *ifm.E;
+expression E;
 identifier f;
 position p1;
 @@
@@ -33,7 +25,7 @@ position p1;
  (E != NULL && ...) ? <+...E->f@p1...+> : ...
 
 @pr2 expression@
-expression *ifm.E;
+expression E;
 identifier f;
 position p2;
 @@
@@ -46,6 +38,14 @@ position p2;
  sizeof(<+...E->f@p2...+>)
 )
 
+@ifm@
+expression *E;
+statement S1,S2;
+position p1;
+@@
+
+if@p1 ((E == NULL && ...) || ...) S1 else S2
+
 // For org and report modes
 
 @r depends on !context && (org || report) exists@
@@ -212,16 +212,8 @@ else S3
 // The following three rules are duplicates of ifm, pr1 and pr2 respectively.
 // It is need because the previous rule as already made a "change".
 
-@ifm1 depends on context && !org && !report@
-expression *E;
-statement S1,S2;
-position p1;
-@@
-
-if@p1 ((E == NULL && ...) || ...) S1 else S2
-
 @pr11 depends on context && !org && !report expression@
-expression *ifm1.E;
+expression E;
 identifier f;
 position p1;
 @@
@@ -229,7 +221,7 @@ position p1;
  (E != NULL && ...) ? <+...E->f@p1...+> : ...
 
 @pr12 depends on context && !org && !report expression@
-expression *ifm1.E;
+expression E;
 identifier f;
 position p2;
 @@
@@ -242,6 +234,14 @@ position p2;
  sizeof(<+...E->f@p2...+>)
 )
 
+@ifm1 depends on context && !org && !report@
+expression *E;
+statement S1,S2;
+position p1;
+@@
+
+if@p1 ((E == NULL && ...) || ...) S1 else S2
+
 @depends on context && !org && !report exists@
 expression subE <= ifm1.E;
 expression *ifm1.E;
