Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B47C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967A82075C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390798AbfBOHyw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:54:52 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:47990 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfBOHyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:54:52 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 698BA5A326B8D112375F;
        Fri, 15 Feb 2019 15:54:44 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1F7sZnv062434;
        Fri, 15 Feb 2019 15:54:35 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021515543874-67583 ;
          Fri, 15 Feb 2019 15:54:38 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, Markus.Elfring@web.de,
        wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <yellowriver2010@hotmail.com>,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] coccinelle: semantic code search for missing put_device()
Date:   Fri, 15 Feb 2019 15:55:19 +0800
Message-Id: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-15 15:54:38,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-15 15:54:20
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn x1F7sZnv062434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.
The implementation of this semantic code search is:
In a function, for a local variable returned by calling
of_find_device_by_node(),
a, if it is released by a function such as
   put_device()/of_dev_put()/platform_device_put() after the last use,
   it is considered that there is no reference leak;
b, if it is passed back to the caller via
   dev_get_drvdata()/platform_get_drvdata()/get_device(), etc., the
   reference will be released in other functions, and the current function
   also considers that there is no reference leak;
c, for the rest of the situation, the current function should release the
   reference by calling put_device, this code search will report the
   corresponding error message.

By using this semantic code search, we have found some object reference leaks,
such as:
commit 11907e9d3533 ("ASoC: fsl-asoc-card: fix object reference leaks in
fsl_asoc_card_probe")
commit a12085d13997 ("mtd: rawnand: atmel: fix possible object reference leak")
commit 11493f26856a ("mtd: rawnand: jz4780: fix possible object reference leak")

There are still dozens of reference leaks in the current kernel code.

Further, for the case of b, the object returned to other functions may also
have a reference leak, we will continue to develop other cocci scripts to
further check the reference leak.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Markus Elfring <Markus.Elfring@web.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: cheng.shengyu@zte.com.cn
Cc: cocci@systeme.lip6.fr
Cc: linux-kernel@vger.kernel.org
---
v5->v4:
- exchange the word “patch” by “code search”
- add a SPDX identifierfix
- a split string literal can be unwanted.
- Change the content of the reported information. 
v4->v3:
- add Masahiro Yamada
- omit a blank line
- split the long message parameter
- reduce the number of metavariables
- Describe the implementation of the semantic patch, 
  explain the scenarios it can detect, 
  and further software development considerations.  
v3->v2:
- reduction of a bit of redundant C code within SmPL search specifications.
- consider the message construction without using the extra Python variable “msg”
v2->v1:
- put exists after search, and then drop the when exists below.
- should not use the same e as in the when's below.
- Make a new type metavariable and use it to put a cast on the result of 
  platform_get_drvdata.

 scripts/coccinelle/free/put_device.cocci | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 scripts/coccinelle/free/put_device.cocci

diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
new file mode 100644
index 0000000..7395697
--- /dev/null
+++ b/scripts/coccinelle/free/put_device.cocci
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Find missing put_device for every of_find_device_by_node.
+///
+// Confidence: Moderate
+// Copyright: (C) 2018-2019 Wen Yang, ZTE.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@search exists@
+local idexpression id;
+expression x,e,e1;
+position p1,p2;
+type T,T1,T2,T3;
+@@
+
+id = of_find_device_by_node@p1(x)
+... when != e = id
+if (id == NULL || ...) { ... return ...; }
+... when != put_device(&id->dev)
+    when != platform_device_put(id)
+    when != of_dev_put(id)
+    when != if (id) { ... put_device(&id->dev) ... }
+    when != e1 = (T)id
+    when != e1 = &id->dev
+    when != e1 = get_device(&id->dev)
+    when != e1 = (T1)platform_get_drvdata(id)
+(
+  return
+(    id
+|    (T2)dev_get_drvdata(&id->dev)
+|    (T3)platform_get_drvdata(id)
+);
+| return@p2 ...;
+)
+
+@script:python depends on report@
+p1 << search.p1;
+p2 << search.p2;
+@@
+
+coccilib.report.print_report(p2[0], "ERROR: missing put_device; "
+			      + "call of_find_device_by_node on line "
+			      + p1[0].line
+			      + ", but without a corresponding object release "
+			      + "within this function.")
+
+@script:python depends on org@
+p1 << search.p1;
+p2 << search.p2;
+@@
+
+cocci.print_main("of_find_device_by_node", p1)
+cocci.print_secs("needed put_device", p2)
-- 
2.9.5

