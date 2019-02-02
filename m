Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35819C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F091620870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acbJxMQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBBJUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:20:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38559 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBBJUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:20:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so4123802pgc.5;
        Sat, 02 Feb 2019 01:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tqQMenOMLOwYzoGnrC6KFJontkJo2Jl2j/JaysjdWQo=;
        b=acbJxMQOcfjXhTT5kKfPk3mwNM5PEvENlHAwhMchS0FAIHOsbLlFeJxMgWyZZeuAUK
         jGATV4NYX/1jQ2uEkESqLrLZTbah5g4e4bQWgRp1mG3L6UfId+07fOpiAmjXGzg59bNF
         ZNAUP0GIBP38B12oTi+Oyo/5jOiSdWDrqeP+K4aS1TRQXj6Va4bzDUGrFYM8Ktubsth8
         9gKVYx5BzrLBMh3kb57LS/M+HldUQMZd/VQwPZO8cpQJGbLa/dm4Ag8qcSHLSVSh5rK7
         /mEjk88vdC1nAkWTJTl1iVuAHoTXxw5ru953C6hNtfr7POWEyuz44Kw9GUUywluvjU/B
         1pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tqQMenOMLOwYzoGnrC6KFJontkJo2Jl2j/JaysjdWQo=;
        b=Kky6te+rrM12G/Ji7lfTFJqmlca1qBSK6Y468CQGPO0YZ04L41mWvsEQAUdRb+u5hn
         dK9dxCJd6Xd/b64Gy7/6EQwOE5cKMT4uzVYj2jByrwBvUAvCKFNGlkFmkYv+NBGyxtq0
         jgZO1xjgOHzN4R/nnZt4QRYG3I564jijN6LNdrEwW8/6t+fnV7Q7rCxZxkA5TVqx/HI0
         r/95fz9UurztxVEyFULwB859Btsp9iFNUzZ2ToZcrkGOHM6swnmz/2v/Jk+wnShdJaKq
         oq4CQchLTPqlrB/ix15w3++YtFt4N5ih4m9t9iUogdGbHro7UV5tNULvODHfq0RATKz6
         3WAQ==
X-Gm-Message-State: AHQUAub4WfOi5WR5wc5Osn7jIyIYpEk4JdAjUDlIKtn36O+k0AblY8Yp
        xJHj1vLZgI/1kdJyKZlhyc5Luro30lc=
X-Google-Smtp-Source: AHgI3IaM4FYgEdvi8LQYV8uR/P+6tcKLu3cPlzsbuNE29O1N0fDUb3Fhy4XZsyUJsM9kiZvT0fvBew==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr5662138pgs.166.1549099239624;
        Sat, 02 Feb 2019 01:20:39 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id c72sm16711329pfb.107.2019.02.02.01.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 01:20:38 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com
Subject: [PATCH] Revert "KVM: Eliminate extra function calls in kvm_get_dirty_log_protect()"
Date:   Sat,  2 Feb 2019 17:20:27 +0800
Message-Id: <20190202092027.54890-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

The value of "dirty_bitmap[i]" is already check before setting its value
to mask. The following check of "mask" is redundant. The check of "mask" was
introduced by commit 58d2930f4ee3(("KVM: Eliminate extra function calls in
kvm_get_dirty_log_protect()"). This patch is to revert the patch.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 virt/kvm/kvm_main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2bdc827b9ee9..ef06cfb9b52b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1200,11 +1200,9 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			mask = xchg(&dirty_bitmap[i], 0);
 			dirty_bitmap_buffer[i] = mask;
 
-			if (mask) {
-				offset = i * BITS_PER_LONG;
-				kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-									offset, mask);
-			}
+			offset = i * BITS_PER_LONG;
+			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
+								offset, mask);
 		}
 		spin_unlock(&kvm->mmu_lock);
 	}
-- 
2.14.4

