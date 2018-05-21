Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeEUHac (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 03:30:32 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:29390
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750867AbeEUHaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 03:30:30 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520895600";
   d="scan'208";a="265862140"
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: mini_lock: improve performance
Date: Mon, 21 May 2018 08:58:48 +0200
Message-Id: <1526885928-1712-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace <+... ...+> by ... when any.  <+... ...+> is slow, and in some
obscure cases involving backward jumps it doesn't force the unlock to
actually come after the end of the if.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/locks/mini_lock.cocci |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/locks/mini_lock.cocci b/scripts/coccinelle/locks/mini_lock.cocci
index 47f649b..19c6ee5 100644
--- a/scripts/coccinelle/locks/mini_lock.cocci
+++ b/scripts/coccinelle/locks/mini_lock.cocci
@@ -67,12 +67,14 @@ identifier lock,unlock;
 @@
 
 *lock(E1@p,...);
-<+... when != E1
+... when != E1
+    when any
 if (...) {
   ... when != E1
 *  return@r ...;
 }
-...+>
+... when != E1
+    when any
 *unlock@up(E1,...);
 
 @script:python depends on org@
