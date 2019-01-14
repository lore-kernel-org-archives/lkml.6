Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB11DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784D420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPN6TSnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfANU2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:28:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50878 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANU2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:28:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so1036058wmd.0;
        Mon, 14 Jan 2019 12:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUpeuBEePI61woIFDLau8xwrTZMnkUOa1PKwQJXoxUk=;
        b=pPN6TSnmvHqU6ff5J/UBBIV/mT7hFNQ1OvWEDIHKRNjdfN7x7WNgVUsdUIEqnKizvI
         1akoKqYsGPQJxE/hRrtlxO/DEMnl9n1SBkp+36tq56AsO13phgE55pjkQ27b3VCof1DV
         9x2iANu5iYuu4d6GlUtXZmtiOOMbEYcT8iuPTjk9lh0rxZEaAeYbq1LioZFPGH9Y8OYp
         rLS4SABr4A8AkJOJGJYG2U3sJDNvJkaNme9g2dWJ2XkD0YleMXVKpiBXvJ6bfBT8WEUG
         psMJ55S7XESS3xUdjDOPBTQ61RWsQRJwZ5Qa1xsMWFiQesuCQ7QUHWj+JmZSOzjyRjiT
         u7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=YUpeuBEePI61woIFDLau8xwrTZMnkUOa1PKwQJXoxUk=;
        b=OK/4ksv29SaO7gVCwrVjvcQtxS0dZzomSx6fpBLR2zBFxQlnA1kUZR46aqm9tTjx3f
         +xG0QTOWXouo65FiOomdKd4ToD5YHdgWKZEn/v5AWxhzzI6EbgLfhG7TIrx64svdvMak
         XtpCQtsJidKbKfuFrSUI6zeM7Nq5/9DoF560OpMPFRO5JlIRZDogkp1oEaQsIr850e0G
         HUUtTbh+oZKeKrpRv66rh5/GP6lHkoLJVKmGVbAw87DKXZ69EbJ9Jym891JG06IJ3bsi
         g81Uq6nqqjM/TrMs165nJqE+3Fsr2OpIaXZOixkr90UI0pkaJUwuzZ1yZW7K9x1hXmkX
         Xx7w==
X-Gm-Message-State: AJcUukdabXL3cy17U0JaurBvO+MFUsMSJVKos9FmQhujJkNpN/cEFoUl
        UncJJElSI3KxTdjYzYVOqmxrmIkj
X-Google-Smtp-Source: ALg8bN7z1wNl7vRY+k90xQLvkaYOdcGqnNC8b64qoKhtK7q5XbRWi+pAh/tFmA0sDJ67vAPfKCaP5w==
X-Received: by 2002:a1c:e715:: with SMTP id e21mr633378wmh.101.1547497723207;
        Mon, 14 Jan 2019 12:28:43 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id x20sm42001681wme.6.2019.01.14.12.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:28:42 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 9A23E11422AD; Mon, 14 Jan 2019 21:28:41 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Serge Hallyn <serge@hallyn.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] capabilities:: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:28:35 +0100
Message-Id: <20190114202835.15878-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case change put the fall through comment on a single
line so as to match the regular expression expected by GCC.

This commit remove the following warning:

  kernel/capability.c:95:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/capability.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/capability.c b/kernel/capability.c
index 1e1c0236f55b..e60be18b98e2 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -93,9 +93,7 @@ static int cap_validate_magic(cap_user_header_t header, unsigned *tocopy)
 		break;
 	case _LINUX_CAPABILITY_VERSION_2:
 		warn_deprecated_v2();
-		/*
-		 * fall through - v3 is otherwise equivalent to v2.
-		 */
+		/* fall through - v3 is otherwise equivalent to v2. */
 	case _LINUX_CAPABILITY_VERSION_3:
 		*tocopy = _LINUX_CAPABILITY_U32S_3;
 		break;
-- 
2.19.2

