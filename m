Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E88CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD07A20854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dm5oxzfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD07A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeGKHoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:44:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38731 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeGKHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:44:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id x13-v6so7934943pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jdv7JCAGldq0YAFu/ACWfRReGIBSUaIhom0oFCx/M8A=;
        b=Dm5oxzfS/VL+fy39Xpvjev3g4m24EgwtLdK2HE8U1ISXZ4k+MOZO3CAprlZTLbwZiH
         GVJ3ghPMkxTO2RrXqNLJQ8n7e/CIU8mH+X+bRwbpgnhZk1lRlRS8fQn+Z5hUp3tXXBUT
         fR9D8VZKtc23trnO6nlTXLwsO4iXFO+zlek3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jdv7JCAGldq0YAFu/ACWfRReGIBSUaIhom0oFCx/M8A=;
        b=KuMxMzBCQkUpGtQo0hSn5hZVBF/I8UPGZCGiQ/oQEMN0suP+31SpoL6BmjudXhZaHn
         nnZKfCkpNLgPbYNg+xCZjK/uwzpIJWbnJT9gtoIvImTMdHpA8SDNrZU+PYI/sLmlWUIS
         SM+R7RMdcgSJ97VoOtF6mljCsEpAK+iG2TggWFv4UYkdM9Sg1MGPbnVQMofDR2vwyO3P
         7rFc+9ZSKo2bidQAgM18v7QUtbl5kJ0LpJMyI3mpjbQvBLA0unyLUx7X4LCBPJi+bmIE
         VVHxPrJsfA9aILbPa4mUYfKZ1qQx3QeqXgGoi4qimz45UT69XTq0BkL1fPisBU4nog2Q
         knZw==
X-Gm-Message-State: APt69E0iCPK17VZBcJagUlAPRFyJouVpSzC/cVva7yRyduer7GMRp+Wo
        2tpvCTPkUnIvJVELzsQKJ0GQGg==
X-Google-Smtp-Source: AAOMgpextl1B479SnJdBw33d87j9Ut62jsdkTz8PrAWlEAfScn/6ULATauzL7tk7LNurnfy/ao5hsg==
X-Received: by 2002:a62:b0c:: with SMTP id t12-v6mr6185257pfi.36.1531294880962;
        Wed, 11 Jul 2018 00:41:20 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f10-v6sm33866590pgr.30.2018.07.11.00.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:41:20 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v11 01/15] asm-generic: add kexec_file_load system call to unistd.h
Date:   Wed, 11 Jul 2018 16:41:49 +0900
Message-Id: <20180711074203.3019-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
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
index 42990676a55e..c81f4a0df51f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 __SYSCALL(__NR_statx,     sys_statx)
 #define __NR_io_pgetevents 292
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_kexec_file_load 293
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 293
+#define __NR_syscalls 294
 
 /*
  * 32 bit systems traditionally used different
-- 
2.17.0

