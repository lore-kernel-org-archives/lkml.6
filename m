Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD5CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BE021872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBGKmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:42:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38401 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfBGKmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:42:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so10967794wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RuwMvLMxk1RvCG1TBZMwO3bX37Q/49v90QTd9ykJKOY=;
        b=IfBQ5zG1nd7jhCTVD8vvhzNHf5sZSn8BOofItgwq/jpJRWfBOH9nZEKe0gg5lUHwRm
         p21B7RG2Uj36YqJyFbmYJPOVEC417YxyIv8+FulaIfvMUHiRpi/7e68jkBxGZyg77yvE
         a4h+mV7n0aHamT2LFD7T4MRC9CW+7giPiGqH9BNI/PKHnuDlwOZCNHrmUa/DR4IBr5En
         NQmcQjUl8BYtePrz4YcZVuXrcgFx34HIw5W6f3LPkKWYrCdNsFByo5Xrhc8HG5j2JvGI
         fXchpgHeoaws7rK5fpgxM7/YscgbQGoPBYCu/3VgFp4DD0t+C3kKPcvda8LBMl7CfBbc
         ZtIQ==
X-Gm-Message-State: AHQUAuYFWkPrUPBWtidA+m+HDsYgrgeRX9wS/XyHCv2oOT+YXlRgPkIR
        1bbSixP9+nSk6Y63MEC+icnyvw==
X-Google-Smtp-Source: AHgI3IYNpDf5gAa45waRhD6kN1TGvtmRFSRNi2x9i18Uz6nZ/AcRTzR+m6e8VUzbd+dNwSsoETtzXg==
X-Received: by 2002:adf:91a7:: with SMTP id 36mr5076108wri.77.1549536134944;
        Thu, 07 Feb 2019 02:42:14 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v6sm17752419wro.57.2019.02.07.02.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:42:14 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2 only when it is available
Date:   Thu,  7 Feb 2019 11:42:14 +0100
Message-Id: <20190207104214.8142-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM says MSR_IA32_VMX_PROCBASED_CTLS2 is only available "If
(CPUID.01H:ECX.[5] && IA32_VMX_PROCBASED_CTLS[63])". It was found that
some old cpus (namely "Intel(R) Core(TM)2 CPU 6600 @ 2.40GHz (family: 0x6,
model: 0xf, stepping: 0x6") don't have it. Add the missing check.

Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
Tested-by: Zdenek Kaspar <zkaspar82@gmail.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 653830d0f3da..4bd0902bfd8c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5557,9 +5557,11 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps,
 	 * secondary cpu-based controls.  Do not include those that
 	 * depend on CPUID bits, they are added later by vmx_cpuid_update.
 	 */
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		msrs->secondary_ctls_low,
-		msrs->secondary_ctls_high);
+	if (msrs->procbased_ctls_high & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS)
+		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
+		      msrs->secondary_ctls_low,
+		      msrs->secondary_ctls_high);
+
 	msrs->secondary_ctls_low = 0;
 	msrs->secondary_ctls_high &=
 		SECONDARY_EXEC_DESC |
-- 
2.20.1

