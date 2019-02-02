Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D687AC282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A556F2146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtL/btXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfBBJle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:41:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38718 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfBBJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:41:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so7470693ede.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ao+30GUUv3JmbT29dbzmjqtVn+kpmSTNQBPMeuNpw0=;
        b=QtL/btXv+JQejhbxpnCT/+uaHPxfhK9CQdc/bjQyvOIzCvoxLQ7yjdqOPuu5mnWhG/
         TnYWSMZYJv42Lf1xev1Rj0B/OBJ47rUtPxc6KdVrrsk84d2pR8OJ6lbWc5tmL6lbA/dq
         r/0r6OCF/p5JNkmMo/78bFLebXYKu92zd57Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ao+30GUUv3JmbT29dbzmjqtVn+kpmSTNQBPMeuNpw0=;
        b=JXpAQrC9WlSncONVKqykQPZcDM9Qhq7qS2AN4k/Od7k1p2RREjo6SMBTPZNPYAjaP6
         ixjVUoh2jIBm3CedJtGLNzHKiMNj/bs2QoCZ4/ALi6mSzxkrQwzbfrTtUgjk3GaFRuZo
         pwcHk8KjjBZ6s+L0nXRh3MZn3hpG89chHVlg2B1idy1sVFP3BIHM69pc3yAAoozZmaBQ
         Gm+ve0G6H0Hlx1/kz88KfZCCflkW0YStOU7uB0w+6/oYp8NHvKAyM0VbtGm2Df0lLqCz
         85TfFXQCr2nT1H6RvLvUWPDsyVr4pS8gvo0lXOhrotH7QM+wNQP4wp22+9o47mZCS8A3
         uzuw==
X-Gm-Message-State: AJcUukfLLtAhIp4eD1C7d9vicRlp6FXI9P+USNstYeK13HgA/nzL4Bmo
        RRbd6dQlwzTxNaLoLKEd0a3hIY6pibuH9A==
X-Google-Smtp-Source: ALg8bN7b4N3oHkgX6k+TgAZGan2uL6/3WO0EsSKBH/p1btjp5Dsvht2SPk3J3ccBtcS1PNA6DuMXSA==
X-Received: by 2002:a50:c9c3:: with SMTP id c3mr42040854edi.56.1549100488380;
        Sat, 02 Feb 2019 01:41:28 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id l41sm2608824eda.83.2019.02.02.01.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:41:27 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH 01/10] x86/efi: Mark can_free_region() as an __init function
Date:   Sat,  2 Feb 2019 10:41:10 +0100
Message-Id: <20190202094119.13230-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

can_free_region() is called only once during _boot_ by
efi_reserve_boot_services(). Hence, mark it as __init function.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 17456a1d3f04..9ce85e605052 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -304,7 +304,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
  * - Not within any part of the kernel
  * - Not the BIOS reserved area (E820_TYPE_RESERVED, E820_TYPE_NVS, etc)
  */
-static bool can_free_region(u64 start, u64 size)
+static __init bool can_free_region(u64 start, u64 size)
 {
 	if (start + size > __pa_symbol(_text) && start <= __pa_symbol(_end))
 		return false;
-- 
2.17.1

