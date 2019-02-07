Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E8C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2082173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rn0EMh94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfBGSJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:09:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46974 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:09:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so802313wrt.13;
        Thu, 07 Feb 2019 10:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=DSqhTADpCAWHCMnF7eTexuBlSvn8u+Zp6Of1PTjZGCk=;
        b=Rn0EMh94Plge2BAvC6qFZStikkW5HLWtPsspGC0vFtoFs+eRlJna4RtfesnvvXXXGT
         3iqG4lUtwuZdDMv+eXdJfbsBVpCYqfJldETm1E7I6trMLxw6fLkXDTy/+JwETb2Bfuc0
         2qR7r314a71xsM04zMUAxcgs0QhYUF8Vn0pHXo15AjZHOKDasDx+8TXD+XGwVSXZwyCy
         knDAwWU4eeyAPSJIu9GUjBootgesa1J8R0jpqWmxRIwV0Zyjm9WYp2szGDOe7Bg1rHke
         QcT3vrgL8nClNf1Nk/s85NI90x1lvJroL/M/Hx743TCxi7uoxdUmoz4wp/mwjKtLRQKx
         YWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=DSqhTADpCAWHCMnF7eTexuBlSvn8u+Zp6Of1PTjZGCk=;
        b=ME5uW4gESBsDOM5+5LaptIDdqr5WXQZPPZSsh6dHvtI3g9pbMgIgouP31j0ip2QnxW
         OTmLxWF9+TKxN7dUXvpjC9hl3jUtOIK89u/Uxymd03GztEv9OQ004bgnCsvHMd2+u/I/
         cHHQPJzJ+gqcQgsgH2qjyeH2M1eyEsAgQLg23jTkJWJQ+jbswD9oWtwnOCsO21GNfoDc
         l4LuFAiBKX9a9kpAPEYc+2R80whzIAHSz+ce5sIy8YCQAmSRzKM3XzRzM+s6X6Wd/tjn
         +5TtmvfUw82gfdyH7Gwzz1dMGPs1ywK5GD9cZtW8URp8tIroqUbPvLVpXKrYojy33rm7
         qttg==
X-Gm-Message-State: AHQUAuba0QQlXTlX2SZYWKNEQtdoIVbN+XAWMVZutPAFmstey8eAhawn
        JR/KAAFDcxh6qR+Jup+/RDI/bPhZ
X-Google-Smtp-Source: AHgI3Ia4oEyX2s+2l8RiOso1VxeullkB7rRG60oShVRSwPFz8obIgkYzeWsqIxGZ7qGhPPxsIbbijA==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr13596675wru.28.1549562948892;
        Thu, 07 Feb 2019 10:09:08 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id m4sm7321218wrq.6.2019.02.07.10.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:09:08 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Peter Shier <pshier@google.com>, stable@kernel.org
Subject: [PATCH] KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)
Date:   Thu,  7 Feb 2019 19:09:05 +0100
Message-Id: <1549562945-5503-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Shier <pshier@google.com>

Bugzilla: 1671904

There are multiple code paths where an hrtimer may have been started to
emulate an L1 VMX preemption timer that can result in a call to free_nested
without an intervening L2 exit where the hrtimer is normally
cancelled. Unconditionally cancel in free_nested to cover all cases.

Embargoed until Feb 7th 2019.

Signed-off-by: Peter Shier <pshier@google.com>
Reported-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reported-by: Felix Wilhelm <fwilhelm@google.com>
Cc: stable@kernel.org
Message-Id: <20181011184646.154065-1-pshier@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8ff20523661b..d8ea4ebd79e7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -211,6 +211,7 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
 
+	hrtimer_cancel(&vmx->nested.preemption_timer);
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
 	free_vpid(vmx->nested.vpid02);
-- 
1.8.3.1

