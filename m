Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0508CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677F3208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OWQxarkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677F3208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeH1Bzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:55:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38194 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1Bzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:55:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so204853plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=4+j93ubzSw8/7uEpxIXksyrwXNuz6dUb6W/WXMpeW9s=;
        b=OWQxarkLdToiTGrMfdF33s/98uvwHY3kaSaGML/g61KRT2C429q/hGf7u2HJnC9X+L
         GYO9AUL86kznW1WArXVQhZ/mRi5KVx+0VlxhzJ7wNTo9QuOqRJvoRkAtUFy2UpXp3KVS
         XpBysb0zJq4FWmy7mnJ9eQVegTJfdq+P/rLDhn4tk7WEXHVfiQMb9tWaIuaeBkHztIhi
         jLdVZByCeDASSvMKPxp4fUGUq7zhW7QJEuVN8mi4PlxqUdebsaKQikY1O0Fejd7U56E+
         z5fGAxuPs+v5ujaufe1Mu3PLWLcGGUw/QMSQFFUqU+pqM+qZ4+4TRjmlUfizB2SFQcYx
         UHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=4+j93ubzSw8/7uEpxIXksyrwXNuz6dUb6W/WXMpeW9s=;
        b=H9CuOZ6DDWucoqBjKW0QvIwvAcdz6TZXz8tSlfZBkepum8mSBd+6QxUQlUsgdNOKEj
         e1fqcMHw9MSRsbn6ehg54ykXcVGzd8Lj9E4Ib5gkvKhecjZfrULztkTeiZvX95ut3eqe
         8z8Dhi2GKg2D20fdQ29HuqMjjkz7r10pvUme5zID5Ol+JfZaNPnppMXl5UIa2EsONlQ0
         a841oJfID3P7mL5aDLagyigxrqOa5KCd+OUWYftyvMNH0aes8ZUUbY1NZ6VPNCc69x0w
         5ozVJsao30BiyYoQohMwPQfmUBHIK0q7ouRbXxWeb9AjF8PD1xaWYL8r/NXcmukkPdgc
         JJFg==
X-Gm-Message-State: APzg51Cn6rruUU+eSDVrr5qKlRcnkdTh1mUsX9Ht97jGUKiq3WKGLx3o
        K+jKpi/mBrXy6sXWljwnhCTOEw==
X-Google-Smtp-Source: ANB0VdYuVkKuexHN7PpBYU7spoeRf0JYxKzZosVh8RDd5UhdP3FGZpBRn/yjeT0uKG73UEk/J71hCw==
X-Received: by 2002:a17:902:704b:: with SMTP id h11-v6mr14544533plt.116.1535407631691;
        Mon, 27 Aug 2018 15:07:11 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r1-v6sm391874pfi.17.2018.08.27.15.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 15:07:10 -0700 (PDT)
Subject: [PATCH] RISC-V: Mask out the F extension on systems without D
Date:   Mon, 27 Aug 2018 15:03:52 -0700
Message-Id: <20180827220352.24301-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alan Kao <alankao@andestech.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V Linux port doesn't support systems that have the F extension
but don't have the D extension -- we actually don't support systems
without D either, but Alan's patch set is rectifying that soon.  For now
I think we can leave this in a semi-broken state and just wait for
Alan's patch set to get merged for proper non-FPU support -- the patch
set is starting to look good, so doing something in-between doesn't seem
like it's worth the work.

I don't think it's worth fretting about support for systems with F but
not D for now: our glibc ABIs are IMAC and IMAFDC so they probably won't
end up being popular.  We can always extend this in the future.

CC: Alan Kao <alankao@andestech.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/cpufeature.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 17011a870044..652d102ffa06 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -57,5 +57,12 @@ void riscv_fill_hwcap(void)
 	for (i = 0; i < strlen(isa); ++i)
 		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
 
+	/* We don't support systems with F but without D, so mask those out
+	 * here. */
+	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
+		pr_info("This kernel does not support systems with F but not D");
+		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
+	}
+
 	pr_info("elf_hwcap is 0x%lx", elf_hwcap);
 }
-- 
2.16.4

