Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDBC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 15:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5587B206B6
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 15:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS5Vx9yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfAEP3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 10:29:25 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34161 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAEP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 10:29:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so34547831otk.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:cc;
        bh=iPhMv/Y1tQOjeOn02GLJLGZ9bDtjdWM0F6NdGX+RgGw=;
        b=DS5Vx9yCcP0KfZ+1KIbsr/GtUof0505GQJAkHVgsIQCdtgrTYByXSRVp/LjLmHLVVu
         yJkK0zn9bPw+e6nu7M1yXoviVNzsFTPYyaG1OArtIIWsj+tqoVcltoN1oBkfc9/Cs/J8
         /la9XDpK7z/BPFnJWzXcCeN5gdWHqEMiREBFE6HpYiGuYVB5YGuc+bvTga4BHIdK+uXP
         erMyrhkj8DP79Mj0gK/xke7sFFRckf9Qg9XJMqdhivgLleTN27RNXEbIZx1CgFpB6jfp
         c4Zni8tlx629oJRhvKl73F4BcgLcUDR0h7Pdxyk9eJXxopFxjQkrY482bjgqLr6YWZ7W
         Q6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=iPhMv/Y1tQOjeOn02GLJLGZ9bDtjdWM0F6NdGX+RgGw=;
        b=GfKwF7zLonZfEMGFeBZo+n5j78Jg/+rLRCNkFhUMkQv1Ik0kYSuMYmuxghPFDXA6hi
         qsHma/Zr1k1Ub939F6BiKgg6RqdPU5NnCC2pj7W5IPW0C8WxGsT5g2051yvStSEPRL38
         AjhHnIv96Pm2SOvGB9XO8Iya1eOvMo7B2cqZoxYNuvSfx5AupQkE1GzWm0TNYGy+Y82w
         fFqEQ8NUAu8ecSHS6jmYVON4V0cLEse084IZmhv3ZkweZaynrIzqw54qDSXOU+VEgJut
         gOGm7NXBKEKX4q4WA7wpzH/o26edjXTFBtyETFCVvMypaQVZ/z3T1znz9YINqctVSTqv
         jJxg==
X-Gm-Message-State: AJcUukfSyOgeYqGKM1Otjk8mN3QN9dzKX5zLkAGd1gfh+17K4VWugkv/
        J25pipNY1Nw5OmhoLwwjcNx2TP3EpBgd1zc6+Pc=
X-Received: by 2002:a9d:2007:: with SMTP id n7mt37440480ota.157.1546702164113;
 Sat, 05 Jan 2019 07:29:24 -0800 (PST)
MIME-Version: 1.0
From:   Philipp K <philipp97kl@gmail.com>
Date:   Sat, 5 Jan 2019 16:29:13 +0100
Message-ID: <CAGZ+4_+TMdbmy6_x4sondGFgcOc=9XXSMTaixcyKasd3LMDMbQ@mail.gmail.com>
Subject: [RESEND] x86: Refactor __cmpxchg to cmpxchg in lock_cmos
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, x86@kernel.org,
        Philipp Klocke <philipp97kl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unusual to reference __cmpxchg() from other files than cmpxchg.h and
similar.
Instead, cmpxchg() is used, which expands to __cmpxchg() and derives the
'size' parameter automatically with sizeof(*(ptr)).

So clean up the lock_cmos() function by using cmpxchg(), without changing
the generated code.

Signed-off-by: Philipp Klocke <philipp97kl@gmail.com>
---

This patch was acked by Ingo, so I would expect it to be added to pit.

 arch/x86/include/asm/mc146818rtc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mc146818rtc.h
b/arch/x86/include/asm/mc146818rtc.h
index 97198001e567..b72e3bbba0a2 100644
--- a/arch/x86/include/asm/mc146818rtc.h
+++ b/arch/x86/include/asm/mc146818rtc.h
@@ -47,7 +47,7 @@ static inline void lock_cmos(unsigned char reg)
  cpu_relax();
  continue;
  }
- if (__cmpxchg(&cmos_lock, 0, new, sizeof(cmos_lock)) == 0)
+ if (cmpxchg(&cmos_lock, 0, new) == 0)
  return;
  }
 }
-- 
2.19.1
