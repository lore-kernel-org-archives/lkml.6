Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FD5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA7320859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VVA549ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfAOGpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:45:16 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46469 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfAOGpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:45:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so1812500qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 22:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GAAVkCy5Ll9uSqEoP8javVYK9SCZam9oOWI1j3mWtOo=;
        b=VVA549ds5yUC7ulGWOW8KKqV6s4VhDWc7nLFJW3ipU1vvYgA5b2lYb6U/yDDUx2zxN
         0kBy6EXlKe0FyhT+efsGzqPLOZiV0PNVIy575iTJnXvsa/c2h7xhAbHdIaDVk4A1K08m
         j8i5z50jtHqbk0K4ENT3QqLE9foQyHnfmGkLm3qMdN2CNRTZYqC/ubSYcwLLeUrKArb5
         70J89jt9mT+E1nR0k7X2HGu9LWP8z9qY0AbT1jxzrsMHLSJVqfsjk4wLdSGKCOu6xLa2
         wHSbMzK0FdJR5T+qFn3cthseSPgirNzh26JdgRcFE0+agFlMM1lIOe5uyXq/RbTUoWMg
         sTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GAAVkCy5Ll9uSqEoP8javVYK9SCZam9oOWI1j3mWtOo=;
        b=IEJ/pYTWjKH9d0vgI8ZFuzpjWf1H7NEQ/+uIytaJxVxGerN/z5qXW3vdwyWTnkh9oZ
         QmFXpv+nkdwpAxHix0pQC9FGvqaHtbTUdZmqCxAR/RZbmPq+sHdY4HTZaz2YLZdl7TV2
         swP36HMo3If+vbMwhNGn9n0Q6AyBnambNylRSuqcbajNimd7z1NEJVYKxQUbalEL3R4d
         P8t8EQZL3wDesHq58D65Xz/QmJSl4DSWtIRS4+PA9BUpY1CRDDTsnX9L+4f2/6keuPhB
         qp/lgANF9VMXJAXS9T/TdXNcQsXrBOVRT96pZFCqgC0KDtNLjIAetd6yDvFi3O3xD9E3
         Xw2Q==
X-Gm-Message-State: AJcUukdPoXZybU75W9aHfCkwuhbBPLUaug4ekpSJDI2VhbUDn2nyDDCl
        +jx+K9Ziq+ThVqRfsU7xWYukfQ==
X-Google-Smtp-Source: ALg8bN4OVFilMX+t4yh1NFJzrMPuvxa07JI+silesKEPamsu7v86Y6q/Lr24Z2GfgVvB1wo5SEk43w==
X-Received: by 2002:aed:3f22:: with SMTP id p31mr1772180qtf.185.1547534714953;
        Mon, 14 Jan 2019 22:45:14 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w22sm54961242qtw.71.2019.01.14.22.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 22:45:14 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     sean.j.christopherson@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] kvm: add proper frame pointer logic for vmx
Date:   Tue, 15 Jan 2019 01:44:59 -0500
Message-Id: <20190115064459.70513-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compilation warning since v5.0-rc1,

arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_vcpu_run.part.17()+0x3171:
call without frame pointer save/setup

Fixes: 453eafbe65f (KVM: VMX: Move VM-Enter + VM-Exit handling to
non-inline sub-routines)
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/kvm/vmx/vmenter.S | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index bcef2c7e9bc4..874dd3030dee 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
 #include <asm/asm.h>
+#include <asm/frame.h>
 
 	.text
 
@@ -20,18 +21,22 @@
  */
 ENTRY(vmx_vmenter)
 	/* EFLAGS.ZF is set if VMCS.LAUNCHED == 0 */
+	FRAME_BEGIN
 	je 2f
 
 1:	vmresume
+	FRAME_END
 	ret
 
 2:	vmlaunch
+	FRAME_END
 	ret
 
 3:	cmpb $0, kvm_rebooting
 	jne 4f
 	call kvm_spurious_fault
-4:	ret
+4:	FRAME_END
+	ret
 
 	.pushsection .fixup, "ax"
 5:	jmp 3b
-- 
2.17.2 (Apple Git-113)

