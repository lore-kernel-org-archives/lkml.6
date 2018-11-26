Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E0F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jzy/6IZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E0F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeKZSRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:17:54 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:38329 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZSRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:17:54 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id wAQ7N1v2019779;
        Mon, 26 Nov 2018 16:23:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com wAQ7N1v2019779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543216982;
        bh=EVlnJuD564s3iKhkGNA25MnT6jwnG/kSDI2uoW+5WsM=;
        h=From:To:Cc:Subject:Date:From;
        b=jzy/6IZKekAZkco1m0zRyaD4FBymgARBDn01NvHInhugJ6o7Nh0B4T6ABOGqjz13p
         x3GW0hHIGfuoVW9/CL83XrRY19O9dU7crPDyhxwUvx/ABtx5Fn7D2/xCAc+kco1wdU
         36b9PPF8AlAW7x3Dzngg+6exrgIB3evh6smy1SIhPFZ5IQTqPTNH2ICpfLorOQBQrZ
         r0nXl0M28EOETsqb8GRAvnL8OirWjmEfuCjJYTI0HK035w/kSERLUk6NA6j7T/jIps
         RT2nfpp72NL4wXe3V8iZDhrj8E2YfdttOU38EL7yxSjKcOK3TJBn2BTe8gnzHN3ViG
         4Ok35jmCo1MXA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Taehee Yoo <ap420073@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: fix reverse dependency with tristate if-conditional
Date:   Mon, 26 Nov 2018 16:22:48 +0900
Message-Id: <1543216969-2227-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Kconfig property can have an optional if-expression, which describes
its visibility. The property is visible when the if-expression part is
evaluated to 'y' or 'm'.

The 'select' and 'imply' properties are internally converted to reverse
dependencies, but they are wrongly converted if they have a tristate
if-expression.

Example:

  config A
          tristate "a"

  config B
          tristate "b"
          select A if C

  config C
          tristate "c"

Currently, the reverse dependency of 'A' results in 'B && C'.
It is incorrect because the combination of B=y and C=m allows
'A' to become 'm', while its lower limit must be 'y'.

The reverse dependency should be 'B && C != n'.

Randy Dunlap reported that people are trying to fix an individual
Kconfig file [1], and I also found another example in the past,
commit 9d9c98e89ee2 ("pcmcia: fix yenta dependency on PCCARD_NONSTATIC")
but I suspect this is a bug of Kconfig itself.

[1] https://www.spinics.net/lists/netfilter-devel/msg56985.html

Reported-by: Taehee Yoo <ap420073@gmail.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/menu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 4cf15d4..2b18833 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -401,11 +401,13 @@ void menu_finalize(struct menu *parent)
 				if (prop->type == P_SELECT) {
 					struct symbol *es = prop_get_symbol(prop);
 					es->rev_dep.expr = expr_alloc_or(es->rev_dep.expr,
-							expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
+							expr_alloc_and(expr_alloc_symbol(menu->sym),
+									expr_trans_compare(dep, E_UNEQUAL, &symbol_no)));
 				} else if (prop->type == P_IMPLY) {
 					struct symbol *es = prop_get_symbol(prop);
 					es->implied.expr = expr_alloc_or(es->implied.expr,
-							expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
+							expr_alloc_and(expr_alloc_symbol(menu->sym),
+									expr_trans_compare(dep, E_UNEQUAL, &symbol_no)));
 				}
 			}
 		}
-- 
2.7.4

