Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD25C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1407F2064E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvBVFy3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1407F2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeHXV6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:58:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45204 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeHXV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:58:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so1425251pll.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 11:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ahxyfoL4byG71/ecDTBY06OkhZrE2lvcXYCgTZMvKa0=;
        b=hvBVFy3aGTZcL02fCeNzTeDw9/yX+ZzD20JwQ2gKyzmuxpcIo0ExS87B7bIx/k0nKi
         mvosXdcZRiZa9z9wk9bda8cQZ0nRmSZgBLhtVB4xugNuBXnhH1t86ZE6R90EIq+Fz0ch
         RRtuHsRrLAYnLY+mtoY3Mva9WXBMxrkjzIQcRsNxSuv8ieKHP+1/43ONyfCiPAVrPhxn
         1atrGNZnnsEXzuf6UoS20zxfJwT/1+Lrc21nyTjXsI4u3+SGh08iZqpQhPKaqmtNkpiO
         hmf8UIw/X0w1QeMkT7Dn2FD9KHYV6zJjlDDakAbCibwpr9GTWcoQOjg6QpcZ0FSRW1xT
         2Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ahxyfoL4byG71/ecDTBY06OkhZrE2lvcXYCgTZMvKa0=;
        b=qhwFyizxJMp6ajgbUSQ21pdqBGIHEy3cSyWsPOCw8CY3pscyNjNuOe8aYNCy7nyHYF
         Ry9vZW9PrVaDhJUFACfDJtTIW5FiaCheP2RCfKv5PBygMBdS9h7uc50iTlyt8Tl56WxO
         wCdUqsnZGB20JkXTg9NCnMa3ZEDdRZYbBQQOxjAM0Uu6d+8V+nCOMBw7le+IcDpTyLVN
         jN3lOvY/8NVZqZK6yQxkEfRbZlVXym/uYy8CuH8NUDq4fSvVGASiVuQfqzNzTYv6VhTR
         o4cOG8q70njwRta1pXeDp2OuiBmkBsCVpwE9LengfSNnf2T8XChpC1345Tj2RVig8MsR
         dqAQ==
X-Gm-Message-State: APzg51DpxasHGC5vapjiIWCt5IODuVLwFSQmdpghlIJeozFKWgh9es2h
        ucEiMhsF3C+sSRvXZLzaCFo=
X-Google-Smtp-Source: ANB0VdZT5SsnyXl6Do3HldoYEaHOv5PCjgh/R+udVfuPf2PTsw1r7GULAFQ3nnlQh+JtMX5qGYIMbA==
X-Received: by 2002:a17:902:9687:: with SMTP id n7-v6mr260741plp.33.1535134977692;
        Fri, 24 Aug 2018 11:22:57 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e190-v6sm18686531pfc.81.2018.08.24.11.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 11:22:57 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] riscv: tlb: Provide definition of tlb_flush() before including tlb.h
Date:   Fri, 24 Aug 2018 11:22:55 -0700
Message-Id: <1535134975-18594-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

As of commit fd1102f0aade ("mm: mmu_notifier fix for tlb_end_vma"),
asm-generic/tlb.h now calls tlb_flush() from a static inline function,
so we need to make sure that it's declared before #including the
asm-generic header in the arch header.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: fd1102f0aade ("mm: mmu_notifier fix for tlb_end_vma")
Signed-off-by: Will Deacon <will.deacon@arm.com>
[groeck: Use forward declaration instead of moving inline function]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/riscv/include/asm/tlb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index c229509288ea..439dc7072e05 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -14,6 +14,10 @@
 #ifndef _ASM_RISCV_TLB_H
 #define _ASM_RISCV_TLB_H
 
+struct mmu_gather;
+
+static void tlb_flush(struct mmu_gather *tlb);
+
 #include <asm-generic/tlb.h>
 
 static inline void tlb_flush(struct mmu_gather *tlb)
-- 
2.7.4

