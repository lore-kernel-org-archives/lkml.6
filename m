Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EE1C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DEE21BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKDvpCFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DEE21BC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeHIHvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:51:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41790 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeHIHvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:51:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id w19-v6so2043469ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FHqCLue9XzCOR6pbpdt115BPmv/OxCI742eSxueSHpI=;
        b=ZKDvpCFio4MfzXYERlJIqyPMcghY70JyZAekRKnjAXEGituJ5vt5LZRsqd6qcf0WyC
         fEmbEDCn3QdhbT76VBbCCYjLVxWZ6DVcyR/3qPz+p5VH0JmVkEnBOMrhk5e1IsTvSgMB
         fa6kzXUV6ay07JCTkjcBlehVXN/NffOU9gL/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FHqCLue9XzCOR6pbpdt115BPmv/OxCI742eSxueSHpI=;
        b=VbqnlAZfDBQdLpOG+BvqStv6COvero9Os8gipg1ascZxq3QJAV4K/WLvelM9h68v7Q
         jCKZaduYg/k6k7dC0DiMIuTJcyZSz0x1dcX1pPaMDMUYajgGXqjNxZJmopF6YzK75JOD
         y+Gcr0n8uz9DSoeGxuHR+tRaiDoGmbAybFthQ9QSU2IV+pfSTWCbvXeIB4ERMygGuu/e
         johmDCdgeOgwZ6Z4H5GSrMOabEBYOlkKb5MYWWiiaTollclEFWomsyUwVHlf6cSlPQjA
         X9a7k1I3Peyv06v9OROC1QLZQPjsBROOHqS7ieCbTQ41NNEKw+XUkEbtCkGYN3h/LiGz
         FH/A==
X-Gm-Message-State: AOUpUlGN86ihpOty6SqBqGMy94eXdtDMgbbBAorpRqZfZ8QZuueFzA+P
        xCVtE/DuK1hPs1c3ceAaMthvzg==
X-Google-Smtp-Source: AA+uWPyi5g1VMPyoxNZ9+vYZQMAe1mt7KEgP0nX3qOBBHNfiuLu5+iYIb02xRIb31OrcMGKaNciaeA==
X-Received: by 2002:a17:902:28a4:: with SMTP id f33-v6mr643240plb.297.1533792500809;
        Wed, 08 Aug 2018 22:28:20 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id q65-v6sm12318676pfj.127.2018.08.08.22.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 22:28:20 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/3] microblaze: Replace NR_syscalls macro from asm/unistd.h
Date:   Thu,  9 Aug 2018 10:57:44 +0530
Message-Id: <1533792466-4227-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_syscalls macro holds the number of system call exist in this
architecture. This macro is currently the part of asm/unistd.h file.
We have change the value of __NR_syscalls, if we add or delete a
system call.

One of the patch in this patch series has a script which will
generate a uapi header based on syscall.tbl file. The syscall.tbl
file contains the number of system call information. So we have
two option to update __NR_syscalls value.

1. Update __NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update __NR_syscalls untill
   we either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update __NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
name also changed form NR_syscalls to __NR_syscalls for making the
name convention same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/microblaze/include/asm/unistd.h      | 2 --
 arch/microblaze/include/uapi/asm/unistd.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index a62d094..e19550f 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -38,6 +38,4 @@
 
 #endif /* __ASSEMBLY__ */
 
-#define __NR_syscalls         401
-
 #endif /* _ASM_MICROBLAZE_UNISTD_H */
diff --git a/arch/microblaze/include/uapi/asm/unistd.h b/arch/microblaze/include/uapi/asm/unistd.h
index 7a9f16a..bde6b38 100644
--- a/arch/microblaze/include/uapi/asm/unistd.h
+++ b/arch/microblaze/include/uapi/asm/unistd.h
@@ -418,4 +418,6 @@
 #define __NR_io_pgetevents	399
 #define __NR_rseq		400
 
+#define __NR_syscalls         401
+
 #endif /* _UAPI_ASM_MICROBLAZE_UNISTD_H */
-- 
1.9.1

