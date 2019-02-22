Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ADBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2C72086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="spQDfxPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfBVIKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:10:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44773 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBVIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:10:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id j3so756418pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0454jgmqadKslS6AXiSTPhnxq89hNMaMPVBArz7LJTA=;
        b=spQDfxPwxJ5BmPJmXZs7ysS4KIf5umW36JKTQlSRLxtVsrp7xtULyvKqCkeTBI/rsN
         sY6SCMGvCLCHVYebTEVvopungAuSDEZgCQCTVHHt3Ez3Czi3LpJKMPBYJL15TKO8MF4M
         ogoyg9OhuX0MEzfcMwuqwTWbKyjBYJ+p4sKu+kYLIbVZqfA/3OgzMcQvqcRgUV/bMWi1
         HdGwNfDU7zbPFIK4JoZh3NwOD+ROtMLhq7UWv/S0iN02fJAgnsUJbtjrchfHNqx74F28
         Vzj5BDehXe8WANOnDN0JAt8F4y30BTINSBofdTAvUlRa03GXVd/nkfybM2ui4EH4Z5J8
         HBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0454jgmqadKslS6AXiSTPhnxq89hNMaMPVBArz7LJTA=;
        b=JydeVMsbN/85rd4P3Y/Ql/y5W0qVAE/qqIg/5o16PmtruDSIyb5FTjqLP/zt7UdhSc
         kNnDRCxWq0v3Ewc8FXTJPlSChV82yD8aOJkVuzRvtsu7x7tdf28+1NtnqzgY4f0xwtiD
         5AVhFtAlRzx81rmSNHZF+8wZYplXAmX0IDdhk4LWj7II2CQc4al/RvxdzvCLQeE58dI0
         PUf6r7oMiOEhXO8Cd7JIpwQzf0dB3nqtapvx1EngM+Got7PWGcFMooAjeHwTpc/vSK/2
         hUSGysAys0dgz1p/MD6gwalFgYHNpNsn+q7XT0qpmVd4z65FV1E9WaWB3nqgbD+5Q/rb
         nWBQ==
X-Gm-Message-State: AHQUAuZaKLUbYvcj7JS/A7QJwKo32Wxhtrzw/4fhuZttjnmRn6Q78J8G
        JTmOTcUEPc3v3zNZvhK5D63DZw==
X-Google-Smtp-Source: AHgI3IZB87IofKx0ZDqJQQkz/AZqvtfwKr3vfaP6hWKJASMkc8e+PaunqvCKaLZj6a8l43iysk2g6w==
X-Received: by 2002:a63:1204:: with SMTP id h4mr2782827pgl.51.1550823024091;
        Fri, 22 Feb 2019 00:10:24 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com. [45.79.96.158])
        by smtp.gmail.com with ESMTPSA id b80sm1341927pfc.20.2019.02.22.00.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 00:10:23 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] KVM: Minor cleanups for kvm_main.c
Date:   Fri, 22 Feb 2019 16:10:09 +0800
Message-Id: <20190222081009.540-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains two minor cleanups: firstly it puts exported symbol
for kvm_io_bus_write() by following the function definition; secondly it
removes a redundant blank line.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 virt/kvm/kvm_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2679e476b6c3..735e42896dda 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3496,6 +3496,7 @@ int kvm_io_bus_write(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
 	r = __kvm_io_bus_write(vcpu, bus, &range, val);
 	return r < 0 ? r : 0;
 }
+EXPORT_SYMBOL_GPL(kvm_io_bus_write);
 
 /* kvm_io_bus_write_cookie - called under kvm->slots_lock */
 int kvm_io_bus_write_cookie(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx,
@@ -3546,7 +3547,6 @@ static int __kvm_io_bus_read(struct kvm_vcpu *vcpu, struct kvm_io_bus *bus,
 
 	return -EOPNOTSUPP;
 }
-EXPORT_SYMBOL_GPL(kvm_io_bus_write);
 
 /* kvm_io_bus_read - called under kvm->slots_lock */
 int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
@@ -3568,7 +3568,6 @@ int kvm_io_bus_read(struct kvm_vcpu *vcpu, enum kvm_bus bus_idx, gpa_t addr,
 	return r < 0 ? r : 0;
 }
 
-
 /* Caller must hold slots_lock. */
 int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 			    int len, struct kvm_io_device *dev)
-- 
2.17.1

