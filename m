Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AF8C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B182081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Cn0e+4wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B182081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeKBULj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:11:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39148 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeKBULi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:11:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id n18so1041511lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhSjwNHBReTxgjhb9toe+yAvJ/7Ca7xGfbc0fBL21HQ=;
        b=Cn0e+4wAZmdOwpCqlSLwBO75MnZqnfMzHH/Sqbeqf/qghFZHOGzONJ04dNHUmL0l8+
         z74MEPpG3q0LizFFJ7UHc/tB12l6Wkh4EeiHXU1PIjjdKyJDEw+wGHmc+Glfpon5yLhk
         D0G8sHu8VB8cm2YKZawlRIwiS3+8ZuEoulBcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhSjwNHBReTxgjhb9toe+yAvJ/7Ca7xGfbc0fBL21HQ=;
        b=Axr6t/bLbrSaWUY/HmhGYkX8y7wXYZQNZykIB9uLC+n1p4UVGobAxgWXtPTzQbtKsW
         WksfwIs/hXJAF+dzuCMovZn9vwTW9LDNKdH5//K+e3qe/BP39b5cpyrX4JHr0Po8Fp+L
         4KGJY26SdLYTdS83pQdP/ec7D5c7yRMOTFlSWfjVDP3kxQFTzaveroBp61hHsg66fWEC
         95t6j2nHMSyoG4ZsWgxFPCvwLCYwobT8b8R6zWLdJxW9hBq7tlhTDJFNssmiZImH1SQ/
         YXzisqNbvBuT98CaaQuOaDRkS1pn3euI5flXInD5kAPAImpJ4O8mx9OY3UA8+s66ooQe
         E96w==
X-Gm-Message-State: AGRZ1gK1mpgpUYUvyMZb6IZM7ucu3UD7xDkQsCYmhAIFWb26eOkR8PlV
        IFYNDlAOgM8XEbpItG7lFciAtI/IwxsFzQ==
X-Google-Smtp-Source: AJdET5fsiO4vkNlb59KQCh5Ipun3rVM/Pfpoi8X2Unh0eejxxIC5sHxKvAIhoH0qpfweeQyRttcQ5Q==
X-Received: by 2002:a19:ca51:: with SMTP id h17mr6269614lfj.126.1541156691769;
        Fri, 02 Nov 2018 04:04:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r22-v6sm1952896ljg.82.2018.11.02.04.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 04:04:51 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drivers/char/random.c: remove unused stuct poolinfo::poolbits
Date:   Fri,  2 Nov 2018 12:04:46 +0100
Message-Id: <20181102110447.23121-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181102110447.23121-1-linux@rasmusvillemoes.dk>
References: <20181102110447.23121-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field is never used, might as well remove it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/char/random.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 320108df04c1..1b2e1580b4b5 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -295,7 +295,7 @@
  * To allow fractional bits to be tracked, the entropy_count field is
  * denominated in units of 1/8th bits.
  *
- * 2*(ENTROPY_SHIFT + log2(poolbits)) must <= 31, or the multiply in
+ * 2*(ENTROPY_SHIFT + poolbitshift) must <= 31, or the multiply in
  * credit_entropy_bits() needs to be 64 bits wide.
  */
 #define ENTROPY_SHIFT 3
@@ -360,8 +360,8 @@ static int random_write_wakeup_bits = 28 * OUTPUT_POOL_WORDS;
  * irreducible, which we have made here.
  */
 static const struct poolinfo {
-	int poolbitshift, poolwords, poolbytes, poolbits, poolfracbits;
-#define S(x) ilog2(x)+5, (x), (x)*4, (x)*32, (x) << (ENTROPY_SHIFT+5)
+	int poolbitshift, poolwords, poolbytes, poolfracbits;
+#define S(x) ilog2(x)+5, (x), (x)*4, (x) << (ENTROPY_SHIFT+5)
 	int tap1, tap2, tap3, tap4, tap5;
 } poolinfo_table[] = {
 	/* was: x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 */
-- 
2.19.1.6.gbde171bbf5

