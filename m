Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA07C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E313E20893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E313E20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeH1UDh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:03:37 -0400
Received: from vrout30.yaziba.net ([185.56.204.33]:45989 "EHLO
        vrout30.yaziba.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeH1UDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:03:36 -0400
X-Greylist: delayed 1022 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2018 16:03:35 EDT
Received: from mtaout20.int.yaziba.net (mtaout20.int.yaziba.net [10.4.20.37])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by vrout30.yaziba.net (mx10.yaziba.net) with ESMTPS id BB284520F6;
        Tue, 28 Aug 2018 17:54:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaout20.int.yaziba.net (Postfix) with ESMTP id B0F6216043D;
        Tue, 28 Aug 2018 17:54:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mtaout20.int.yaziba.net
Received: from mtaout20.int.yaziba.net ([127.0.0.1])
        by localhost (mtaout20.int.yaziba.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xqaux8cbxp4W; Tue, 28 Aug 2018 17:54:14 +0200 (CEST)
Received: from sahnlpt0333.softathome.com (unknown [149.6.166.170])
        by mtaout20.int.yaziba.net (Postfix) with ESMTPSA id 9112A1603C0;
        Tue, 28 Aug 2018 17:54:14 +0200 (CEST)
From:   Philippe Reynes <philippe.reynes@softathome.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH] MIPS: Fix computation on entry point
Date:   Tue, 28 Aug 2018 17:52:50 +0200
Message-Id: <1535471570-19033-1-git-send-email-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-DRWEB-SCAN: ok
X-VRSPAM-SCORE: 0
X-VRSPAM-STATE: legit
X-VRSPAM-CAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrgeeggdelhecutefuodetggdotefrucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtqhertdertdejnecuhfhrohhmpefrhhhilhhiphhpvgcutfgvhihnvghsuceophhhihhlihhpphgvrdhrvgihnhgvshesshhofhhtrghthhhomhgvrdgtohhmqeenucfkphepudegledriedrudeiiedrudejtdenucfrrghrrghmpehmohguvgepshhmthhpohhuth
X-VRSPAM-EXTCAUSE: mhhouggvpehsmhhtphhouhht
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 27c524d17430 ("MIPS: Use the entry point from the ELF
file header"), the kernel entry point is computed with a grep on
"start address" on the output of objdump. It works fine when the
default language is english but it may fail on other language (for
example in French, the grep should be done on "adresse de départ").
To fix this computation on most machine, I propose to force the
language to english with "LC_ALL=C".

Fixes: 27c524d17430 ("MIPS: Use the entry point from the ELF file header")

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d74b374..835aa8f 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -258,7 +258,7 @@ load-y					= $(CONFIG_PHYSICAL_START)
 endif
 
 # Sign-extend the entry point to 64 bits if retrieved as a 32-bit number.
-entry-y		= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
+entry-y		= $(shell LC_ALL=C $(OBJDUMP) -f vmlinux 2>/dev/null \
 			| sed -n '/^start address / { \
 				s/^.* //; \
 				s/0x\([0-7].......\)$$/0x00000000\1/; \
-- 
2.7.4

