Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51712C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1053C2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Gd/DkpO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1053C2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeKBUMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:12:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33114 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeKBULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:11:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id i26so1068126lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmbRIMxxWBNqGpDys+S4GVrs4vIud3NouT+koKYdwPg=;
        b=Gd/DkpO5NDzyDTK7C0ovPS9rdvN8SOjjugcihPwrtOAPSk6K36aVOMXG0S922QDUSi
         UQRBdx0nQSxv6lyz1Big3IYi3l3MscuFxoFhPw2DQMo0tWVKqAad8K8iMLW/YbNSgRJ8
         PNvWHbpuIXrEcwOoBLxVoNZCqGXyuRire0R/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmbRIMxxWBNqGpDys+S4GVrs4vIud3NouT+koKYdwPg=;
        b=EBk1xYk+91gXJHMTK642ofl4XoRRaH3vNOh3asHI47a79Qu8vAGW3TsFd+e1VTPc1O
         RwHZZ/rjWCgiDZR0PG/JdXCGuVnftjpR5osSXAKB4025/f8OVNCEp7asKcUJjDUHif+/
         xHZyyeXVgqiTRIFXAjY6U2VCsOrVLn6aCVFlXOg9jCY0VIOqlPdhhcumaslD7HSJ9K2P
         u61PIEgMBxKPpNvMi3MMaGDRlzlZwnDXpbJu5qbQwYEaUb7iJbW57uI07PbPnUWSqNgX
         GSMSGr0FpeDl/V1HJzk9Hfuq7O7VdASDqRqdxX2zY+7/a5dVXYQerWT9wZP3jLrcLHfE
         MRkw==
X-Gm-Message-State: AGRZ1gJUxylOlpbWWN7+If0DSJIbUvrbSTeG/pSLoc0kCbi1/W1z3f0q
        1FzfvlS9Jr1i3yv3dqcCoGhrXQ==
X-Google-Smtp-Source: AJdET5c44Pb7BOFwpin468nK/LUCOV/YxU3hBKqUli9kAwLj+sU5wq9t4hwCOgvCGQ7I8aImM0lT6g==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr6407608lfj.12.1541156690153;
        Fri, 02 Nov 2018 04:04:50 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r22-v6sm1952896ljg.82.2018.11.02.04.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 04:04:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drivers/char/random.c: constify poolinfo_table
Date:   Fri,  2 Nov 2018 12:04:45 +0100
Message-Id: <20181102110447.23121-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never modified, might as well be put in .rodata.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2eb70e76ed35..320108df04c1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -359,7 +359,7 @@ static int random_write_wakeup_bits = 28 * OUTPUT_POOL_WORDS;
  * polynomial which improves the resulting TGFSR polynomial to be
  * irreducible, which we have made here.
  */
-static struct poolinfo {
+static const struct poolinfo {
 	int poolbitshift, poolwords, poolbytes, poolbits, poolfracbits;
 #define S(x) ilog2(x)+5, (x), (x)*4, (x)*32, (x) << (ENTROPY_SHIFT+5)
 	int tap1, tap2, tap3, tap4, tap5;
-- 
2.19.1.6.gbde171bbf5

