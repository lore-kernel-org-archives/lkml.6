Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA68CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBA2208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBA2208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966528AbeFRI1w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:27:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58340 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966478AbeFRI1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:27:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C297CA8;
        Mon, 18 Jun 2018 08:27:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 265/279] mtd: rawnand: Fix return type of __DIVIDE() when called with 32-bit
Date:   Mon, 18 Jun 2018 10:14:10 +0200
Message-Id: <20180618080619.666252265@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit 9f825e74d761c13b0cfaa5f65344d64ff970e252 ]

The __DIVIDE() macro checks whether it is called with a 32-bit or 64-bit
dividend, to select the appropriate divide-and-round-up routine.
As the check uses the ternary operator, the result will always be
promoted to a type that can hold both results, i.e. unsigned long long.

When using this result in a division on a 32-bit system, this may lead
to link errors like:

    ERROR: "__udivdi3" [drivers/mtd/nand/raw/nand.ko] undefined!

Fix this by casting the result of the division to the type of the
dividend.

Fixes: 8878b126df769831 ("mtd: nand: add ->exec_op() implementation")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mtd/rawnand.h |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -824,12 +824,18 @@ struct nand_op_instr {
  * tBERS (during an erase) which all of them are u64 values that cannot be
  * divided by usual kernel macros and must be handled with the special
  * DIV_ROUND_UP_ULL() macro.
+ *
+ * Cast to type of dividend is needed here to guarantee that the result won't
+ * be an unsigned long long when the dividend is an unsigned long (or smaller),
+ * which is what the compiler does when it sees ternary operator with 2
+ * different return types (picks the largest type to make sure there's no
+ * loss).
  */
-#define __DIVIDE(dividend, divisor) ({					\
-	sizeof(dividend) == sizeof(u32) ?				\
-		DIV_ROUND_UP(dividend, divisor) :			\
-		DIV_ROUND_UP_ULL(dividend, divisor);			\
-		})
+#define __DIVIDE(dividend, divisor) ({						\
+	(__typeof__(dividend))(sizeof(dividend) <= sizeof(unsigned long) ?	\
+			       DIV_ROUND_UP(dividend, divisor) :		\
+			       DIV_ROUND_UP_ULL(dividend, divisor)); 		\
+	})
 #define PSEC_TO_NSEC(x) __DIVIDE(x, 1000)
 #define PSEC_TO_MSEC(x) __DIVIDE(x, 1000000000)
 


