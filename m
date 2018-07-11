Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF539C38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8371820C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KOsg1Kch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8371820C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390371AbeGKUmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:42:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35201 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390345AbeGKUml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id q7-v6so18037252pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z0UiKUkbaIJ74sZlGjVbsXVX3NSh4Durhbkhjh0YhvQ=;
        b=KOsg1KchypdBz+ZkFX+knHTEQifNztOQH/N2DO/TnuOQLO1D+ZBfB8A5AnsqXzdWpq
         4KaQmCiAnRJhbHOzRIU8c67ZEA4fttVXwvD4rA4BfuwflWx4VZieO5OLoIdzP7eVmtHV
         etEy4qU2eIsQ1WIRLwEBWPTa01HaAhZ1C+Jf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z0UiKUkbaIJ74sZlGjVbsXVX3NSh4Durhbkhjh0YhvQ=;
        b=P9VIxXKKw22WcA4wNcO6Jn1znbCtssfst5ZsxZA3k2dMCtt3doF3ezgx9zFqYnCgH3
         vDQeDJBt8lh0D/FFs/l+5amMsfOKoLmMughNbzfuyiVthb4xrKlJId1KrmfgJ/3z4LUo
         AZY5uA9uSlSsXOq/vJmX2oC8CzljTyuml1/wJkw5JUL9c6JlTAwX60Wvy9Vj99upuQcl
         DKn8qYyQEqvy0CO3zhtP3gP8vFMJJJQpu3FRA4JReES4XKDTgEz6o+MjUh17cc1xc8I+
         pOqTkdghEGFe/McHXoIHdLlNAbENmhNf6Pm8b/wDwJTyWpswrhM96Hpu4UvPvwsaM6Iy
         3WUg==
X-Gm-Message-State: AOUpUlHy6oeiBiL9vbvA6Fch1rxmGT6qpnu2/fEABdzyKImHDAIYQd2s
        6WmitYK0lpbkZ7EVJ4VNN9XY8A==
X-Google-Smtp-Source: AAOMgpd57X0B++JahNWQOiTavlKY07Yiu3g+Z5C+koVVmGeqtWibcBg6uX3DUmJJT0LgwKpcpOJBHA==
X-Received: by 2002:a63:1063:: with SMTP id 35-v6mr122477pgq.249.1531341398414;
        Wed, 11 Jul 2018 13:36:38 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n9-v6sm25574832pfg.21.2018.07.11.13.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/14] rxrpc: Prepare to remove VLA usage for SKCIPHER_REQUEST_ON_STACK
Date:   Wed, 11 Jul 2018 13:36:18 -0700
Message-Id: <20180711203619.1020-14-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two uses of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
(when less than 2048) once the VLA is no longer hidden from the check:

net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]

This bumps the affected objects by 20% to silence the warnings while
still providing coverage is anything grows even more.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/rxrpc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/Makefile b/net/rxrpc/Makefile
index 6ffb7e9887ce..53e1177129e6 100644
--- a/net/rxrpc/Makefile
+++ b/net/rxrpc/Makefile
@@ -32,4 +32,5 @@ rxrpc-y := \
 
 rxrpc-$(CONFIG_PROC_FS) += proc.o
 rxrpc-$(CONFIG_RXKAD) += rxkad.o
+CFLAGS_rxkad.o += $(FRAME_WARN_BUMP_FLAG)
 rxrpc-$(CONFIG_SYSCTL) += sysctl.o
-- 
2.17.1

