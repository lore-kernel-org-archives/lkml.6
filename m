Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82ACD20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNDxPbyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfBVIYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:24:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45268 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:24:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id r14so749456pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yToDsQHz3ALMgK9EtUQgb46vvC2ZQAohlXLeU3oKRKI=;
        b=iNDxPbyyWhQMppHJsSCDsV+gjSyBJy0WimqXj0Zezyafuk6tomK/Xpt2ifNex/GF18
         zN2zDgecC0MfI5c8GruuMobJ7jBysUACkeUYWFdaCIusTrt0ucF8l1vVINzPUJpHFBsr
         2FogixqkYPdDK3t9W8RZj9rmOdCqTjYuyPUekjVq+gnNopoRq8U1KEykJxMMgLU5gMj7
         Tm5zVXAykk1ldds6XoIzsBxawpkkhfJjsvyqoFbnpi9ntVN/9GXEHQQ1/eogTqeC8Xfu
         L7E2Abc5Xe0RowZjqh7fpUuPuOWqaqXkbwUJIZ1rRmGHkg8r8aM+pFjhPsx4+F4Roo3k
         1N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yToDsQHz3ALMgK9EtUQgb46vvC2ZQAohlXLeU3oKRKI=;
        b=YFtpwykgjCJEOMFNtN4JNjsk5B97wYf2aLIKF6NVAiTNIDWe5AqaCPMupt/sYNxo2c
         q8pe5SHcB3PsHnWrlVPmJcwlcuUCN4dReFeZiJ2wBcnF/DbDcAcHiAHZ26av+t+qIQjl
         tRMdr7KtsWDldwQMa1kZeuW6Ze4sTuysH24+keDBv4ZJh/41+O17LdaCraN+IGOg1OXm
         IUQz0cINiFBaeggUIJ8i4WOl0kVCpO3BDrPHTZVqrV4UC/OcPEETAFXIPanE1vE+Ms1T
         n18E+3T2IFTEPmpF7B8nruK1iI0NeMrA1rP2vaTNZD8kKTJ72fcbTFKF+Fjg2TYR/708
         5Crw==
X-Gm-Message-State: AHQUAuaF6tUf6l++vqG7WQHsaLAOteDNr8fKFQG06pq19CzbTppRWAhR
        f/QSdRBRRDbYch/XRLJeokXDyQ==
X-Google-Smtp-Source: AHgI3IaV33tJQbsIeXVfmlMvaEdoQdrnhGr4bVSBQNDS2guL74fAKBX27EW4pzq3bzzTzFOEQyF+/Q==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr3026924plp.8.1550823840196;
        Fri, 22 Feb 2019 00:24:00 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com. [45.79.96.158])
        by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 00:23:59 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 4/4] KVM: arm/arm64: Fix comment on create_hyp_mappings()
Date:   Fri, 22 Feb 2019 16:23:26 +0800
Message-Id: <20190222082327.3312-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222082327.3312-1-leo.yan@linaro.org>
References: <20190222082327.3312-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f7bec68d2fae ("arm/arm64: KVM: Prune unused #defines"), the
macro HYP_PAGE_OFFSET has been removed, but it's kept in the comment for
the function create_hyp_mappings().

This patch uses PAGE_OFFSET to replace HYP_PAGE_OFFSET and this is
consistent with what is doing in the function.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 virt/kvm/arm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 5eca48bdb1a6..9634f47c2c8b 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -734,7 +734,7 @@ static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
  * @prot:	The protection to be applied to this range
  *
  * The same virtual address as the kernel virtual address is also used
- * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
+ * in Hyp-mode mapping (modulo PAGE_OFFSET) to the same underlying
  * physical pages.
  */
 int create_hyp_mappings(void *from, void *to, pgprot_t prot)
-- 
2.17.1

