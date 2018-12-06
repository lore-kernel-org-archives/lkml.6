Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2ACC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB0D214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4ObU8n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB0D214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeLFP7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:59:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52395 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:59:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so1490301wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsOLDUWwS8wWEQ+PD9JmGHJK/WLq/vNZaVg+lNHLzj4=;
        b=O4ObU8n11TBr2ObnmJrGLcsQN3HvgIP5sU1+BuOrpY7vMygSWU3d6W9+76PAeBS/fY
         ENBpFShrhNiSOWQ1xsLuuDgFMAB982FPJ+EIWj3+eZvWrkC/CbKKQG3f1JKtreMG4UWH
         Wn9aP5/upm/BeA++LtzUvDtozSI7nFkzXZPnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsOLDUWwS8wWEQ+PD9JmGHJK/WLq/vNZaVg+lNHLzj4=;
        b=pHzGPdLtPfa1MLdfdDTJzM2vDNPnLTdCW5kzPm80aurAhJKrwCzRrSki0nZcvbnnCu
         cBWMNe/tdYH/K5yB8iEXHMd06/7EReP+8euKpcTFuNB9iR57nrePWjzQHrx4LvZ2xqbY
         7KCzdJajerS0x5kLjejQ3pSCQwCxIbb43vo8GC2NhT3AG5bi4gXdXGF18j7I6m5Sebnv
         ef+wE8znm8HSdsBcZTolR89BQaLF+KU6S9/ymouBcBOtHnGOWS/O+sWJ+5Y/tLlo7NwR
         QJFXY+gMHe/AtndKV+xxeykBwFLeLogo2+ts24LjbZ0/BbaAgRLW6NYylBOErRkVUY+L
         bRAg==
X-Gm-Message-State: AA+aEWa8GPkXOpzzEvnqna6BV77NnakOc7iAWgP9qJjNa2OqOiYD+T39
        Gzu8voMziBCG6+yDWoy8StCXzgBdg3Udog==
X-Google-Smtp-Source: AFSGD/UslGuIVtLy5O4X2xEgkigRmH0XwoOq8dX9DZs4zGkT8FRe3OjgscFlOotup9DUk/krCQFIow==
X-Received: by 2002:a1c:128b:: with SMTP id 133mr21076331wms.22.1544111981435;
        Thu, 06 Dec 2018 07:59:41 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id y34sm1525233wrd.68.2018.12.06.07.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 07:59:40 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 0/5] arm64: assorted fixes for dcache_by_line_op
Date:   Thu,  6 Dec 2018 16:57:34 +0100
Message-Id: <20181206155739.20229-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes two issues in dcache_by_line_op: patch #4 fixes the logic
that is applied when patching DC CVAP instructions, and patch #5 gets
rid of some unintended undefined symbols resulting from incorrect use
of conditional GAS directives.

Patches #1 to #3 are groundwork for #4.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>

Ard Biesheuvel (5):
  arm64/alternative_cb: move callback reference into replacements
    section
  arm64/alternative_cb: add nr_alts parameter to callback handlers
  arm64/alternative_cb: add support for alternative sequences
  arm64/assembler: use callback to 3-way alt-patch DC CVAP instructions
  arm64/mm: use string comparisons in dcache_by_line_op

 arch/arm64/include/asm/alternative.h | 54 +++++++++++---------
 arch/arm64/include/asm/assembler.h   | 17 +++---
 arch/arm64/include/asm/kvm_mmu.h     |  4 +-
 arch/arm64/kernel/alternative.c      | 22 +++++---
 arch/arm64/kernel/cpu_errata.c       | 24 ++++++---
 arch/arm64/kvm/va_layout.c           |  8 +--
 6 files changed, 79 insertions(+), 50 deletions(-)

-- 
2.19.2

