Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3C5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDCA2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyWQdZx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfBGSJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:09:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54114 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfBGSJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:09:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so851892wmb.3;
        Thu, 07 Feb 2019 10:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ccdPGB06nBmBgZEk4NZAD0wHZtXkksIyWmYaHtXuHjk=;
        b=lyWQdZx0SQG/5OiuK+wo5Bz4XAznmmgaWNxNOao1kXJS9ws46zldG7ZhXo9RP3m+Lv
         eJPs2vEszcWyjkLvOdbc9KDOZkBo0UFXmALGyefVzIYLzwcDVeooMbe4ewFTr+qv8NaB
         GFHzqLpYzbfeq3M3WDiWe9Uy+O5HcPgnHiXE2NgF4++5gfWFTyAHSYzqDZzumqMtcCrN
         1ZTGqZjMBpOOBEPR/+43YL3i+UnRTZZOqoOJNW6qV8CKRyuSw0lpirxEBzitQcsEJQnI
         zJwyf8tR63ivzyQhka5S7O6scOsPTpsCoKPauJG0YT3UJjwypqmBkxCm3l/UBZqvgWJc
         Ujtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ccdPGB06nBmBgZEk4NZAD0wHZtXkksIyWmYaHtXuHjk=;
        b=USSfQMZCGloZXo63CpXItQpeX04I78c2IZndcD1eaSDWrWRnc7aUvahByWYF4t2+WS
         rXRILvI3MlkGGygxXVqn2jEEuLEcWlOwEamjuZcA4N9hYCN++u95Bmqe8pvdynXz45Xh
         fdTxE/KANo4CXvL4DsJHqyFCE8jyeIU5hY9G2lPArxwCrVCgagkyTt+jzUSygeBE8Hle
         uI4dWbZzqklYhm7YKVjbOQE8jSezZKGbbwmaxfsy8er7n7Bgp0LJlUFn5ZhDSMi/D9xn
         /F8pbMva823+dfxSYv0+q7jN2DXl2Ofu/dGkEIxSnWyTm5DSD8MAmDAtA4zWaRaBJuG6
         g3Tg==
X-Gm-Message-State: AHQUAuZ72vNJ9j2elNEL6UUiXsnegBQsmoHdekkgoVy37Ddpq8iJijzC
        tBlYB6vFFMMD1h4YT3iaE5zgiZ4T
X-Google-Smtp-Source: AHgI3IYbj7cWzCVC51v2JNOJqvYErYPb7wlrr2uHDxTWpgO4dZLhynKwFQBj4TFgHZHpUApKCM9OFg==
X-Received: by 2002:a1c:c303:: with SMTP id t3mr7927437wmf.94.1549562947834;
        Thu, 07 Feb 2019 10:09:07 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id m4sm7321218wrq.6.2019.02.07.10.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:09:07 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     stable@kernel.org
Subject: [PATCH] KVM: x86: work around leak of uninitialized stack contents (CVE-2019-7222)
Date:   Thu,  7 Feb 2019 19:09:04 +0100
Message-Id: <1549562945-5503-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bugzilla: 1671930

Emulation of certain instructions (VMXON, VMCLEAR, VMPTRLD, VMWRITE with
memory operand, INVEPT, INVVPID) can incorrectly inject a page fault
when passed an operand that points to an MMIO address.  The page fault
will use uninitialized kernel stack memory as the CR2 and error code.

The right behavior would be to abort the VM with a KVM_EXIT_INTERNAL_ERROR
exit to userspace; however, it is not an easy fix, so for now just
ensure that the error code and CR2 are zero.

Embargoed until Feb 7th 2019.

Reported-by: Felix Wilhelm <fwilhelm@google.com>
Cc: stable@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3d27206f6c01..e67ecf25e690 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5116,6 +5116,13 @@ int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 {
 	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
 
+	/*
+	 * FIXME: this should call handle_emulation_failure if X86EMUL_IO_NEEDED
+	 * is returned, but our callers are not ready for that and they blindly
+	 * call kvm_inject_page_fault.  Ensure that they at least do not leak
+	 * uninitialized kernel stack memory into cr2 and error code.
+	 */
+	memset(exception, 0, sizeof(*exception));
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
 					  exception);
 }
-- 
1.8.3.1

