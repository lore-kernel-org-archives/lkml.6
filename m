Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A19C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA971214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="c1XxSt2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA971214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbeHVQrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:47:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44944 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbeHVQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:47:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so1363020lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AZbPCJSbuo+klDBiBLb68ajVcTgBIaGryLAqoz1zbFg=;
        b=c1XxSt2o2MKrhLyRBXaEtIfAcbI419co9oJDsRtm/1ugtcaVk1NmSKqrTq1jUJjn1h
         8miGzVkWXgpsmSKqx7XshYhc/cCao2Qb0Sm6qaG/YjOhJGRHCdp3jKv4Wu/GbwST7OAE
         Ko5WAhrifPAUcuB7fvHb/Rwa6lxNT5BUQyC+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AZbPCJSbuo+klDBiBLb68ajVcTgBIaGryLAqoz1zbFg=;
        b=O9atsYOpJ9FJMEL2BO7prkiuvTNsOobeiJqRBLdDwe/lJk3m89EorGvpH4pV+l8KBy
         AqsBIm0T49jAGklFvtPg3nEYs5XyA+w65+1fVe0CkdudYMR8q0py8T0YsXHw1jXutsQb
         TMjeQUFc/Sy+NLFiAeZ2kLOfnNHDJzGLhLm7bjh4BiU4W5vVdr3zFzCERHr9ndvwih/9
         jkLFwwdlbVLOsTDp9YSm708brG2zQOa5DWBUdAKdCw725fvKMXihqlz6FZMzeMuRe8Jz
         hLidaLMOASvibrl4qkWZZsknuzvg1MFvaCF6SYtsHC2J2iTSaZOYoIKlFnm2AzmD+mMF
         AtwQ==
X-Gm-Message-State: APzg51D85zvYOMCSgGyUqDmezOgxO0RtKImhMlwJJSi8wwuTTeOPpPe4
        p5C0fhlC5mAu5nad2Ft1HL9hAA==
X-Google-Smtp-Source: ANB0VdZ3jPavtSuzCCpfqzFJ8USRyKgm/35Ri6ufCmVAlYn9DU87oCfj5otS4UyDdVAh1YM1XF0P+Q==
X-Received: by 2002:a19:e593:: with SMTP id i19-v6mr654385lfk.18.1534944144439;
        Wed, 22 Aug 2018 06:22:24 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i2-v6sm314600lfa.78.2018.08.22.06.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 06:22:24 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] brcmfmac: fix wrong strnchr usage
Date:   Wed, 22 Aug 2018 15:22:15 +0200
Message-Id: <20180822132215.27669-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strnchr takes arguments in the order of its name: string, max bytes to
read, character to search for. Here we're passing '\n' aka 10 as the
buffer size, and searching for sizeof(buf) aka BRCMF_DCMD_SMLEN aka
256 (aka '\0', since it's implicitly converted to char) within those 10
bytes.

Just interchanging the last two arguments would still leave a bug,
because if we've been successful once, there are not sizeof(buf)
characters left after the new value of p.

Since clmver is immediately afterwards passed as a %s argument, I assume
that it is actually a properly nul-terminated string. For that case, we
have strreplace().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Incidentally, I found this because I was looking at our strnchr
implementation and noticed a corner case: strchr() is specified by C and
POSIX standards to consider the trailing '\0' to be part of the string,
so strchr(foo, '\0') must be equivalent to "foo +
strlen(foo)". strnchr() is not specified by anyone. Our implementation
returns NULL as soon as count is depleted or hitting a '\0' byte, so
since we were here looking for a '\0' byte, the first strnchr() call was
guaranteed to return NULL.

Had strnchr() instead returned a pointer to the '\0' if such was found
within the first count (in this case 10) bytes, we'd be overwriting that
with a ' ', and continue until no '\0' was found within the next 10
bytes.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index cd3651069d0c..94044a7a6021 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -296,9 +296,7 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 		/* Replace all newline/linefeed characters with space
 		 * character
 		 */
-		ptr = clmver;
-		while ((ptr = strnchr(ptr, '\n', sizeof(buf))) != NULL)
-			*ptr = ' ';
+		strreplace(clmver, '\n', ' ');
 
 		brcmf_dbg(INFO, "CLM version = %s\n", clmver);
 	}
-- 
2.16.4

