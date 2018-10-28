Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F8AECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDA620665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DULrqDVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDA620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeJ1VzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:55:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43267 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1VzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:55:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so2516813plb.10;
        Sun, 28 Oct 2018 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hk0Di9Qb+zs88OQ4I5uk9OIJ44YMozS+eSEHj+aJ9Z0=;
        b=DULrqDVbYreYAt1oKKC5KgMOg6D5NXd/8T9BEROdYj6TkIU2HY30/P/DGiMiC14ufk
         o3AFsrfDOdGoxj/rkJm14rSK6bmINopwt3Hzq/Kg1duxBokx79pObjNY8Y8rME7o9YZ0
         Vr5jeGR7C/fPLJipN6wWiqX17b0VIxAftL54IC2Fu7QrPgeplkHgwzrdXqeCRTTQxYfA
         nmNDD/O4bKqqV7GY4sPM69rZMSwnjT5d5+3+gIniBJD1egbzijp8Wt2s8VxM0dqaoOxr
         oPDKfIBPItQd9HyqT/bFwP168d263K6nG7SYQSkYBkK1krUhpb91xE6HdlAyTvTfe07M
         czZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hk0Di9Qb+zs88OQ4I5uk9OIJ44YMozS+eSEHj+aJ9Z0=;
        b=GJtW9PIrkgqHHqnQVIZbfrdXW7GLGCqT80sddeYgHLlHtnMc77ZRjyUImOAA7hNb/n
         MxmW3CS+du87ttNxVCdw3cUvT7E2EPa85u+rUGaKisVV6/zO6wgMbYB8naZO0P3ENqhQ
         t2qX3jqzwSatqs6nHMJNQqW++q5vGOxLPHiT6rdFoXd2zKVubynSiiBRWEWlDElsiKLh
         M+Obo6T33Kmo+hXQdGPnmQcUwZY71M0jnVAnu3JHtMSwom1Iz/I8CU5L7MCuFDdHUJNw
         +ygjWiADH4Feu0QJq3NVL4ttXLEw18KyEmTE7zgFAlFglWsSsoM3XNBKqBgSoFYylEiq
         JpMA==
X-Gm-Message-State: AGRZ1gJ8Sb/ibjyLjSXifehlM2VAvFXxElrI8be7zxDU/FJyr9/Rhgbs
        QE5rpyq16Aanu4uWGQ613OA=
X-Google-Smtp-Source: AJdET5dlcd9UXIUBLCS603gJym1Rp6+h0wVdPcUWTt9ebbUn43Wir4lzeAXgOyGgOH1LsevXat6yJg==
X-Received: by 2002:a17:902:d806:: with SMTP id a6-v6mr10148394plz.301.1540732228780;
        Sun, 28 Oct 2018 06:10:28 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id e3-v6sm24520585pgc.71.2018.10.28.06.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 06:10:28 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
Date:   Sun, 28 Oct 2018 13:09:42 +0000
Message-Id: <20181028130945.23581-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181028130945.23581-1-changbin.du@gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
So declare check_la57_support() as inline to make sure the code
referring to level4_kernel_pgt is optimized out. This is a preparation
for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 5dc377dc9d7b..5ae682f2aa83 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -98,7 +98,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 	return true;
 }
 #else
-static bool __head check_la57_support(unsigned long physaddr)
+static inline bool __head check_la57_support(unsigned long physaddr)
 {
 	return false;
 }
-- 
2.17.1

