Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF7CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F99021582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0Lh7ada"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F99021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbeKOP6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:58:44 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45028 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeKOP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:58:44 -0500
Received: by mail-yw1-f65.google.com with SMTP id k6-v6so8235620ywa.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqOZgrmCseBCFVCglpCnlv6Vd3lKQ1VgNlnEF5YSifw=;
        b=L0Lh7adaB4/NBz1Jq7eWIVyflBdmNbUxt4AY6CAfqdA8EIpze6HPfem5PTfs/DdIuy
         nO0Ux+nFEZV3r0qw6u+AayYXEQULmZ5BENYIXIPtRcyWfd4fEEbwi6jvmcgp3HiFs4E4
         lmSB8Ghz4NgyoOF6cFUUXgOdAf6u3836RA+ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqOZgrmCseBCFVCglpCnlv6Vd3lKQ1VgNlnEF5YSifw=;
        b=Q02gujAENopM4k72X3+CiBD8BMgNCi/HJ6I+L2BMX28z60lIaJOc7/DAaxdqGG6k7Q
         9HDXDecA+z0Ocr8VYhHRKQZ/bGuxJEqLneCBo+hGvfwHHxMV9ch3E0aUEoila6PygiJC
         Zmr32u1/tNIMdP5v5xZlLh35uh6CmDD2lv9V+sy8mNT2sY/cg/Scak1iKRCiv1TYoNEQ
         0E4P2ktyR5BOjhPqj+OXoEGBxNaPY074LBqBdS/JDshUZL0K8wQQxIp99Vuv6QO9H2ml
         XQZ2vqGY2Py+BQTOlvN4S8bgyQ59ZApYFWnmIDgWY2pjrMOTjDcXa/yTA/NpBg6sGJnn
         Lrtw==
X-Gm-Message-State: AGRZ1gIoQ5cwV6lXCh6TMZaVc4ruSnKrh3PzKbblLOQvGL+GALyzIXrX
        YwQZTHjyUS0hF/+Kfu+E69DUdQ==
X-Google-Smtp-Source: AJdET5e9foIDNMtI7yzpRPUxITmnfPNMHjdhpM9Kr8oPLMei4wkjQB5LwSunNm/Dz29XT1XDaeZaYA==
X-Received: by 2002:a81:ad57:: with SMTP id l23-v6mr4569256ywk.260.1542261138359;
        Wed, 14 Nov 2018 21:52:18 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 200-v6sm7892593ywq.97.2018.11.14.21.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:52:17 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v16 01/16] asm-generic: add kexec_file_load system call to unistd.h
Date:   Thu, 15 Nov 2018 14:52:40 +0900
Message-Id: <20181115055254.2812-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial user of this system call number is arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 538546edbfbd..3b7196295fa6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -738,9 +738,11 @@ __SYSCALL(__NR_statx,     sys_statx)
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_kexec_file_load 294
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 294
+#define __NR_syscalls 295
 
 /*
  * 32 bit systems traditionally used different
-- 
2.19.0

