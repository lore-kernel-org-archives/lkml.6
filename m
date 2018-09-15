Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49FEECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAE9208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1k4Cuvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAE9208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeIOLYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 07:24:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeIOLYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 07:24:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id y139-v6so4006411wmc.2;
        Fri, 14 Sep 2018 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xNJrut3JcfSdkFz3lBAfJ7K7ZTu5ttYDxyp9mH99k9g=;
        b=M1k4CuvoANQQCAuQ/g4FguloISo4RVA1ng1793R+yzrB9KcXO4fykxWRr/v54wPdsq
         rLOAP9loY3F8wTcleRBnmdTEiOuEnBNZl5MyFGmWZDF3ikyYGzbw9RyH8tAY3S0t/7AH
         YqqJDA3ymKJDVUTbyFzvdwXL7rMZlrQ3CzsaG6NuTOkuQMBWYpJHxcq+kTyHsrt1yE5u
         fUhy7Pf6d4ZolA2c4orkHyXEIkggCjk8nX0TfqaQiHLZggNYKhovMdnWTftIw3VKfnV/
         Em+QtPn+AfSeF8VaZgR8VGSeN5j6LwxAQZi6zL5BeAfPi+M9gtZIkoHvA5AwW1Z7wELk
         LYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xNJrut3JcfSdkFz3lBAfJ7K7ZTu5ttYDxyp9mH99k9g=;
        b=PbZf2Q2+YADiAQ/AWq4TgiG6znJ2tve/kcq1+d9WOMqYiAK/kJliJUy/X0uW2BFscT
         yDGfbLt8vztTjIBr2tE02x4N1+qXvtWyKSI9JoL1GYxpHIezIgyzSbhnJixItH23/vxA
         uf+ewDRWTkQBd6ubxxFPgIw2sxKJIVe9GZsi0rpbQmmkwPZ/lYCaS4AfNiDLLBmN1lsr
         w4trTUXpshNUzzIaDfIJeEcvwVXkxmLKZbuAHgjG2GrsbH1cWJ0L2zBjf8UbIFpoyWoS
         sOn/v0mtqCBkrdecoDh/tLhK0lz/cSX+3Ap7OVu3cmNororarD1xzJuUO/IkJxsEa5Es
         /+3w==
X-Gm-Message-State: APzg51A/r0aH9xlU12oxdx9uTPsqFGXGYXMfqCxELI+J/EWEsv4Bv2nG
        uIn9gv2RkvZ7IfElixkdkws=
X-Google-Smtp-Source: ANB0VdYGwsANHDedR0VwGeMmw1suwuQTqnhkiSBvpRY/EMaP9s8wDEwtwhVyTEP1+/OoeSOcsSyz/w==
X-Received: by 2002:a1c:b5d3:: with SMTP id e202-v6mr4694260wmf.23.1536991595507;
        Fri, 14 Sep 2018 23:06:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm17161420wrc.21.2018.09.14.23.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 23:06:35 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] [media] bt8xx: Remove unnecessary self-assignment
Date:   Fri, 14 Sep 2018 23:06:13 -0700
Message-Id: <20180915060612.21812-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when a variable is assigned to itself.

drivers/media/pci/bt8xx/bttv-driver.c:2043:13: warning: explicitly
assigning value of variable of type '__s32' (aka 'int') to itself
[-Wself-assign]
        min_height = min_height;
        ~~~~~~~~~~ ^ ~~~~~~~~~~
1 warning generated.

There doesn't appear to be any good reason for this and this statement
was added in commit e5bd0260e7d3 ("V4L/DVB (5077): Bttv cropping
support") back in 2007. Just remove it.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I'm not sure if the comment should have been removed as well. If it
does, I can easily send a v2.

Thanks!

 drivers/media/pci/bt8xx/bttv-driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 413bf287547c..b2cfcbb0008e 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -2040,7 +2040,6 @@ limit_scaled_size_lock       (struct bttv_fh *               fh,
 	max_width = max_width & width_mask;
 
 	/* Max. scale factor is 16:1 for frames, 8:1 for fields. */
-	min_height = min_height;
 	/* Min. scale factor is 1:1. */
 	max_height >>= !V4L2_FIELD_HAS_BOTH(field);
 
-- 
2.18.0

