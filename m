Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E5C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC3021570
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXg0OHQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC3021570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeHOApO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:45:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34292 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeHOApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:45:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so9717981pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Gt89gxBRleU5N1Gy8NSLk+0iXKAURoBA3uaj9e+ChDM=;
        b=AXg0OHQuVWgyUoyIfeKP4z1WE3pbjqQusNYg7NFE/cAxLeglvOB7mQWaHDUdmuxYR6
         04Wig2JfjG893UvOClV7Zve8w3D3HoJMBAaDBzc5dWW/OGCadtYJdZCcfuABhYbj/uZD
         fJN6518BwgEJ6eAFAB5YubJqT/29tHxQ9kOiQJCqbdCydP1q5KM6feFM705OUw+0LLdg
         23Q2xRH5tFnyG+iIYngpADk4aXqEBYE23ataJrZFWlVJNEhbFzdNEajh0IWiYIlDmUcM
         8ZfPOCOEIRud3wEtIjo8yKKpEiuJ6yp1LvQ6BNHKG/zjnKCwY5IMm/MvF42iiQzgXyyW
         PCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Gt89gxBRleU5N1Gy8NSLk+0iXKAURoBA3uaj9e+ChDM=;
        b=FRp9wKgENPqNY5OJzeVEUq4Aa0I299Bj+BBpX+SloyXrJ6XVsYaXu92Zdon1hcEXTK
         OG07P9ybRtvYAFeBqI5oyKyLStX5gl3bQ5C1YxiNZkymAKI6FCwC7SHyyo6dqZesOiX1
         8Bh3bY/v5VMqho4dN9I4IdpR0sDbjgFSCLkxF0Io1CMT98NIholRsTBDtIyTeiouXXnw
         b63VCK4QxztTvOSo4ou814+CPNaZnsMJOaWpNfxlmnRtP1kS11Cb8GG4A8Ot821v+nHz
         RKWlXKoI0o45fz3arke14SUr+u9SCMgWVInc/W+YhYzk0TWyo1H1EbsNdM19lpnzX/vB
         z0Mg==
X-Gm-Message-State: AOUpUlEqbT81+8YhhIs4SZjXApyuhUDtDZzAc7cBGNo38EeG4GF/wlbM
        kDNNPctMOtKzut04E5IKNCE=
X-Google-Smtp-Source: AA+uWPw29vFabDmUHlam0oK7SvdmA0zxG+FVvkS/srmZVc5cUt868guNlSZBixo3i7lf+8jhvPKH+Q==
X-Received: by 2002:a63:951e:: with SMTP id p30-v6mr22619454pgd.318.1534283763464;
        Tue, 14 Aug 2018 14:56:03 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r198-v6sm51367961pgr.8.2018.08.14.14.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 14:56:02 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Meelis Roos <mroos@linux.ee>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] x86/l1tf: Fix build error seen if CONFIG_KVM_INTEL is disabled
Date:   Tue, 14 Aug 2018 14:55:58 -0700
Message-Id: <1534283758-15612-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig+CONFIG_INTEL_KVM=n results in the following build error.

ERROR: "l1tf_vmx_mitigation" [arch/x86/kvm/kvm.ko] undefined!

Fixes: 5b76a3cff011 ("KVM: VMX: Tell the nested hypervisor to skip L1D flush on vmentry")
Reported-by: Meelis Roos <mroos@linux.ee>
Cc: Meelis Roos <mroos@linux.ee>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/x86/kernel/cpu/bugs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 27830880e7a7..cb4a16292aa7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -664,10 +664,9 @@ void x86_spec_ctrl_setup_ap(void)
 enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
-
+#endif
 enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
-#endif
 
 static void __init l1tf_select_mitigation(void)
 {
-- 
2.7.4

