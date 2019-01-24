Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D11FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE7D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCrbD/Q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfAXVsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:48:50 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:54109 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfAXVsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:48:50 -0500
Received: by mail-vk1-f201.google.com with SMTP id e10so2113536vke.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CBf9ANq0HVSY89uYI9yBKKXPTmqHyAr/xQJ28QhdWOw=;
        b=wCrbD/Q9SM+PU9QD/lfuzAvsKHk0arQeIRyu6S0w8BsaA1aQI9DwUScalkSDCgtL/F
         lJ3YboP4r+PbiSySndGdomzYi2J3qtqgt1hD8r4q0RMuHDCohhBdDv1OegcZR2OORMJ4
         Mh3ZF4O3AiiiHADCaxv37eKOgg8szCYW2+eehVTFoX/jB1OH3xHYeqHw4w9jDBBYgc7+
         TGy5dK++K1IvnbSGT1W8MsF2LMtt/m0HRqK81tQWhlDGiRrOKriw9f+3qQXemAG2+69Q
         fnNKU35md0VBL5KRpkqKRXO5zkDHevKGz6ibF6WLJR3p8p7j9gUiaccZBrLIoU9QgLi6
         SF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CBf9ANq0HVSY89uYI9yBKKXPTmqHyAr/xQJ28QhdWOw=;
        b=onXDPaHmRipWrC6Axfm54r+95dEQ19KQI4F/GBxnGKft8tNYpV8BYgN2r7kdt28uXT
         trZE7h76L+GdkVB/o2Ff2VZOGxXnozr3NmT4p/FoOS2G2RXcVHian2wKAEqm3+c2eX29
         RzJwvbie2zpeF4UrIS9V7pB1D3FiROxDrLviECZjQjjcEz4IYGlWpKdog7T/rKoQHYsY
         MHkNLxkwds2lE29UTePX09vxp8p1EUgBfVpwY8BLqb8WEY0V+GeqfuuTOmx4sHvA6Qjp
         j4k1ouQBe1xzzUW/zIq6An8Y3ec/nVKRfvHqSB39Ebu/ZQwtdLdLzTYOZfJoq6wgBtLH
         7UXQ==
X-Gm-Message-State: AJcUukeS0KfJCTG9mSESoLqe7FYs6G2oggUizMcWavll+5T3CXXvzY2A
        XeaZVhXX02Hm5FS2mWwfCuiD3EztePxPGw==
X-Google-Smtp-Source: ALg8bN7ZKDGlE+pO5krSzh+5JCL9nxdHr4Znx8d3RINtEvOHhCP1TPgj3T65RMo++32YQAdp9Ac2rYbOOIEqyQ==
X-Received: by 2002:a67:4b50:: with SMTP id y77mr6815156vsa.13.1548366528777;
 Thu, 24 Jan 2019 13:48:48 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:48:20 -0800
Message-Id: <20190124214820.187794-1-tmroeder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v2] kvm: x86/vmx: Use kzalloc for cached_vmcs12
From:   Tom Roeder <tmroeder@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jim Mattson <jmattson@google.com>,
        "=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Roeder <tmroeder@google.com>,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the allocation of cached_vmcs12 to use kzalloc instead of
kmalloc. This removes the information leak found by Syzkaller (see
Reported-by) in this case and prevents similar leaks from happening
based on cached_vmcs12.

It also changes vmx_get_nested_state to copy out the full 4k VMCS12_SIZE
in copy_to_user rather than only the size of the struct.

Tested: rebuilt against head, booted, and ran the syszkaller repro
  https://syzkaller.appspot.com/text?tag=ReproC&x=174efca3400000 without
  observing any problems.

Reported-by: syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Signed-off-by: Tom Roeder <tmroeder@google.com>
---
Changelog since v1:
- Changed the copy_to_user calls in vmx_get_nested_state to copy the
  full 4k buffer.

 arch/x86/kvm/vmx/nested.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2616bd2c7f2c7..ce81539238547 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4140,11 +4140,11 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	if (r < 0)
 		goto out_vmcs02;
 
-	vmx->nested.cached_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
+	vmx->nested.cached_vmcs12 = kzalloc(VMCS12_SIZE, GFP_KERNEL);
 	if (!vmx->nested.cached_vmcs12)
 		goto out_cached_vmcs12;
 
-	vmx->nested.cached_shadow_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
+	vmx->nested.cached_shadow_vmcs12 = kzalloc(VMCS12_SIZE, GFP_KERNEL);
 	if (!vmx->nested.cached_shadow_vmcs12)
 		goto out_cached_shadow_vmcs12;
 
@@ -5263,13 +5263,17 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 			copy_shadow_to_vmcs12(vmx);
 	}
 
-	if (copy_to_user(user_kvm_nested_state->data, vmcs12, sizeof(*vmcs12)))
+	/*
+	 * Copy over the full allocated size of vmcs12 rather than just the size
+	 * of the struct.
+	 */
+	if (copy_to_user(user_kvm_nested_state->data, vmcs12, VMCS12_SIZE))
 		return -EFAULT;
 
 	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
 	    vmcs12->vmcs_link_pointer != -1ull) {
 		if (copy_to_user(user_kvm_nested_state->data + VMCS12_SIZE,
-				 get_shadow_vmcs12(vcpu), sizeof(*vmcs12)))
+				 get_shadow_vmcs12(vcpu), VMCS12_SIZE))
 			return -EFAULT;
 	}
 
-- 
2.20.1.321.g9e740568ce-goog

