Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327CA2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7/iH/Kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327CA2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeKHCwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:52:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37977 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKHCwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:52:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so18266089wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8+JfBqciwD8GJJaemPhXLLH8tzVj+bkFbbGCffDHJ8=;
        b=C7/iH/KwIWFkISAxgpHdW0bL79VLXTsoWgNLxtXgX1T3GyQuK6ov0kvHJKH6qN/cuk
         Wk5wTi5N4QKr7NkyIVP9tzRIS9qNaxZrU4qHMTGZI4ukr8XpCjHYD2RhYEoxxj0cvmxz
         Gv9cuhDNdI3oTF+4giC4W3iypALUe/4QdRaVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8+JfBqciwD8GJJaemPhXLLH8tzVj+bkFbbGCffDHJ8=;
        b=r3E9mJe5GHCB8PKmQeVDqep4TvTPuI5d+QjF0fcRKBvLxEj72fmbtSHBrWbfE+m9/C
         N08mCquaQ3P5GSdq7Yj8/zqvCzsRKlmzj3Zly8bd77kIoq3ln4zOqrIE0lMrU3aSNN9P
         JAsyREDncZHqioSafE9E4hMEaSovojMzzMNtCxXZG6EGp5m6OlcyGQB9wkstme6Ty+LE
         Bbjc8i/e2c5qMCVKNnUAXI1ZGwp5uIyb2zCiqC9bW2QKmKlmn4ZlykRGFI5e0X8QtHAe
         8s+6YwAWrJhLoqqIT/0d446ulSWMzxiwsOOy9HoL5nqG/UWUMyYphUTsmH1msgfN6O3G
         TYaw==
X-Gm-Message-State: AGRZ1gK/MFhf2iFqGIMA3NWOzaddpPL9QbhZ7dq+otFvkSwpyh595RZ+
        mxmVH3f2hdCZXQyz3IAKlcQDTw==
X-Google-Smtp-Source: AJdET5edausxG4gihMbeYFyds7I/t2o1q5sWWDXUs2P/s0Q5DCKG6DebkYD70WzHCnDBchEuOaQE2w==
X-Received: by 2002:a05:6000:11cb:: with SMTP id i11mr1028706wrx.234.1541611241684;
        Wed, 07 Nov 2018 09:20:41 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id t77-v6sm2590772wme.18.2018.11.07.09.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 09:20:40 -0800 (PST)
Received: from zen.linaroharston (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTP id 583123E02D5;
        Wed,  7 Nov 2018 17:10:37 +0000 (GMT)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, christoffer.dall@linaro.org,
        marc.zyngier@arm.com
Cc:     =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
Date:   Wed,  7 Nov 2018 17:10:31 +0000
Message-Id: <20181107171031.22573-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all faults handled by handle_exit are instruction emulations. For
example a ESR_ELx_EC_IABT will result in the page tables being updated
but the instruction that triggered the fault hasn't actually executed
yet. We use the simple heuristic of checking for a changed PC before
seeing if kvm_arm_handle_step_debug wants to claim we stepped an
instruction.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 arch/arm64/kvm/handle_exit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
index e5e741bfffe1..b8252e72f882 100644
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -214,6 +214,7 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
 static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	int handled;
+        unsigned long old_pc = *vcpu_pc(vcpu);
 
 	/*
 	 * See ARM ARM B1.14.1: "Hyp traps on instructions
@@ -233,7 +234,8 @@ static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	 * kvm_arm_handle_step_debug() sets the exit_reason on the kvm_run
 	 * structure if we need to return to userspace.
 	 */
-	if (handled > 0 && kvm_arm_handle_step_debug(vcpu, run))
+	if (handled > 0 && *vcpu_pc(vcpu) != old_pc &&
+	    kvm_arm_handle_step_debug(vcpu, run))
 		handled = 0;
 
 	return handled;
-- 
2.17.1

