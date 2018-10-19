Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA4FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF04E20843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XfOv3XpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF04E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJSWos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:44:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45650 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJSWos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:44:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id v22-v6so13615481lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJkYDfKI+hRmcdAYcK1zYNt8SPi9mDiFnX3Yi8ktbYE=;
        b=XfOv3XpV6BE6r6qKiYRMFWa2xW04I//Iw4fgEmkO3Q6em8VomgXgIJSmZoiIWsXk6v
         A9FPWir7l6mj7acuOci3tPjME3Ptft5aYAxP4nlbx9so7mrBba16k7TEG/7BX/WZRajp
         oaudA+isdBUbqVUdpFPxPTa68HNt5pcwAJqEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJkYDfKI+hRmcdAYcK1zYNt8SPi9mDiFnX3Yi8ktbYE=;
        b=cfy45fCIhQ3/m9rndyzp6/vnbx241wOBT97B+6MT8caFzV7CbAH6r0kUbWVqyDvbcr
         1dALl1UxR3O+0pSNhAYaCeuawZFqXURMjAAD8IATKv42+BOd4GGi/MDJunYg6ugA9xEe
         gdFgjrptMFP+XXTbHTUqgEpeG8Odg92jdDL7+T8xdZxRY5/TX4dEeQWzs72iv4guhjmF
         9Y+njfrQ8mGJ1jk7I+LqZahyTRRL4lIHfLJUE2rnMIlvtswnt1Rx+4uJkvsuYTy811os
         DkRMjue/FIMZeSpXgTyYlZrRyfA193Rc3OnvE9C3gaAiMu3px5wIZs3Fu5kvM4h9tS4p
         N6dw==
X-Gm-Message-State: ABuFfojGH8zAyIFq9a5WXU1Fr8gzgGpsE7c3gZPv+FbCrAJ4GXOjgBAK
        IXmtnyuoZWoo6LjR9NDppJTh0Q==
X-Google-Smtp-Source: ACcGV601kwvYSMka868Nfwi+BZxzSyZ/wnbhDueGK91+6IUOLSFbo6hDyd8JBNZOm2d0vitzSFkP5w==
X-Received: by 2002:a19:f813:: with SMTP id a19mr3144861lff.67.1539959902767;
        Fri, 19 Oct 2018 07:38:22 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id l3-v6sm5343547lji.60.2018.10.19.07.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 07:38:22 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/kvm: add missing executables to .gitignore
Date:   Fri, 19 Oct 2018 16:38:16 +0200
Message-Id: <20181019143816.4509-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 18178ff86217 ("KVM: selftests: add Enlightened VMCS test")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/kvm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 552b0d9a49f4..6210ba41c29e 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -1,4 +1,5 @@
 /x86_64/cr4_cpuid_sync_test
+/x86_64/evmcs_test
 /x86_64/platform_info_test
 /x86_64/set_sregs_test
 /x86_64/sync_regs_test
-- 
2.19.1

