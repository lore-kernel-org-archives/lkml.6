Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B8DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44DA2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEWQxwVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfBZFjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:39:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43482 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZFjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:39:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id m35so9631715ede.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 21:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0MWNfIl7BaIjVKIXDFU2rkRENWt9ONmC8+s19bQ8C0=;
        b=rEWQxwVPUiKduCDMy9WEb26SBN2oYU8ZwoGEfI6TwU/2z/gql80SKGFUFbdAZ38INY
         gS25mIn9yLZ8+Q98vonmSYMIels6+xGCsB5iyRYGNlrJL1OHtZ3Jjc/WGIdLlDw/7Qb9
         tAhaIcyR5pdfHBeCFBz6yIpEknl1P5djHoXI/oGzRQDZOEeX65sgebSrzhlHO9/FN/7l
         lCgnoG25r5GYWEi9BnToMZw8CGDL9XI7zbcg/tVEaIQHt++gqAHh9MaooyKuTu3IjO1A
         9TXZx+t6SidvPis5coOXF0z9HLSyGy7VGDWusIpGw7MlXRmrP7l5aNBsG28guZSXehSB
         3j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0MWNfIl7BaIjVKIXDFU2rkRENWt9ONmC8+s19bQ8C0=;
        b=cjDhUAKUx1j1hsnkUR177kM9mmxbj5/P0j7pm4hGqFfZIuKp/fZYqbeg/2RmX3IWXF
         JYvhpullBECYmvSE7AqGbwam6TBRpjm/0EtrI//k1ZcMRkvH5xMFeJJ/qNl2JWZROcMc
         SDozJHTH1KN1hphJd4pLUnn0esEsbHZvPjSutHatB0TYLm6LOh5n3+mUYYk80Ji7i995
         VIxC4K/dUJ/G/5ZvDm8es+HYlEQHpPl2x56N9rMykstWTYhvgERFOr2v53wfMp3jO+8Y
         jqxSL6+pCrlefz3VZvvRIfWoq3rgCl7voivaMIS9arX32PN+UBhFR1TDnegZHOfjmFWb
         rtXg==
X-Gm-Message-State: AHQUAuYEGU/+QUtSLwHcsMP0xvuED/sYAuecRR65zJ+dsTZrWNfiM+pf
        1jrZyd6+7v/bAEo3zeIG/Eo=
X-Google-Smtp-Source: AHgI3IZeSmeUfqTDQ29rsudSd0aVmdsgFKqoIYp+QIlPysI9QVDM3bM7x9Q9JKvSpvGOfi0w9gXfOw==
X-Received: by 2002:a17:906:9398:: with SMTP id l24mr15644008ejx.128.1551159563625;
        Mon, 25 Feb 2019 21:39:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id l53sm3224194eda.66.2019.02.25.21.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 21:39:22 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc
Date:   Mon, 25 Feb 2019 22:38:55 -0700
Message-Id: <20190226053855.7020-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

arch/powerpc/xmon/ppc-dis.c:157:7: warning: variable 'opcode' is used
uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]
  if (cpu_has_feature(CPU_FTRS_POWER9))
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/xmon/ppc-dis.c:167:7: note: uninitialized use occurs here
  if (opcode == NULL)
      ^~~~~~
arch/powerpc/xmon/ppc-dis.c:157:3: note: remove the 'if' if its
condition is always true
  if (cpu_has_feature(CPU_FTRS_POWER9))
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/xmon/ppc-dis.c:132:38: note: initialize the variable
'opcode' to silence this warning
  const struct powerpc_opcode *opcode;
                                     ^
                                      = NULL
1 warning generated.

This warning seems to make no sense on the surface because opcode is set
to NULL right below this statement. However, there is a comma instead of
semicolon to end the dialect assignment, meaning that the opcode
assignment only happens in the if statement. Properly terminate that
line so that Clang no longer warns.

Fixes: 5b102782c7f4 ("powerpc/xmon: Enable disassembly files (compilation changes)")
Link: https://github.com/ClangBuiltLinux/linux/issues/390
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/powerpc/xmon/ppc-dis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 9deea5ee13f6..27f1e6415036 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -158,7 +158,7 @@ int print_insn_powerpc (unsigned long insn, unsigned long memaddr)
     dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
 		| PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9 | PPC_OPCODE_HTM
 		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
-		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3),
+		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3);
 
   /* Get the major opcode of the insn.  */
   opcode = NULL;
-- 
2.21.0

