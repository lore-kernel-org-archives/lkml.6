Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECDFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22E92075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aq1ombfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22E92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeJLRQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:16:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42142 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeJLRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:16:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id c8-v6so5666836plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FAowNU2Le7w5YJvjpIycOrYvvQJDBUjpEbsXPhhb+kM=;
        b=aq1ombfV4olvF+Cz+jnwTCKGT+GNGrX0CQ9i8YZUnBP2sJETHM4SQwG156Dq5UPk8V
         6szJ/410NKS5EHatc7cRE7rZdL6e4ipIWM5sw6LiU+0Tei/IZ8iZnlLHFpWkrzRAbMe2
         B8q8jnYjBgU2g2rrmX73XLYsOT3q3IGoH4mkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FAowNU2Le7w5YJvjpIycOrYvvQJDBUjpEbsXPhhb+kM=;
        b=TY4QeMYjw9g8UwV3vo4fxRA5Aa8sqiO7dyfep67At8IxybByR9VX4yGaVQggZ4VEJv
         q2W+zJ8cs/p2oP0DlUwT0fyPyDblu8ZtKIsECZo2VQcc8P0JQ/sBGv1U+R8v00CTSup+
         Pdv2EP2X4DdxNkhlZ2jPICO5Vbl6MuOtRU/7rt3CeVhuhyC20/Zy8itmzVvrAaIwLbrb
         F2yt/HXO3IMuLIxUMFOw6gwv2zvm9GmM3p116C6zw7aSIMM7ccQ+y0cU+SdCOXVBJuSf
         6MzezkrBYGtmLY8u6OOigJG36hfjkXe7TomXRUXludG5tps7PdBMaKkQysvDCEifhci9
         IF6A==
X-Gm-Message-State: ABuFfojbrmA3sgG4vkwrrMyVemiIdHNAEiDZ+yxAithYBf/XAaYZuMle
        xXWA+TdHQ8bZ277g3KsrfK+FDA==
X-Google-Smtp-Source: ACcGV63wMY3NV4zBnbncFTZoEO3QG4sMGGiqXu25rya6JwgOv8wJoRxRIiPjgiybKERGZg8GeRKZTw==
X-Received: by 2002:a17:902:3fa5:: with SMTP id a34-v6mr5258818pld.244.1539337492885;
        Fri, 12 Oct 2018 02:44:52 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.108.175])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1254191pfi.137.2018.10.12.02.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 02:44:52 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 2/6] parisc: add __NR_Linux_syscalls along with __NR_syscalls
Date:   Fri, 12 Oct 2018 15:13:58 +0530
Message-Id: <1539337442-3676-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call
exist in PARISC architecture. This macro is currently the
part of uapi/asm/unistd.h file. We have to change the value
of __NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file. The
syscall.tbl file contains the number of system call inform-
ation. So we have two option to update __NR_Linux_syscalls
value.

1. Update __NR_Linux_syscalls in uapi/asm/unistd.h manually
   by counting the no.of system calls. No need to update
   __NR_Linux_syscalls until we either add a new system call
   or delete an existing system call.

2. We can keep this feature it above mentioned script, that
   will count the number of syscalls and keep it in a gener-
   ated file. In this case we don't need to explicitly update
   __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved
the __NR_Linux_syscalls macro from uapi/asm/unistd.h to asm/
unistd.h. The macro __NR_syscalls also added for making the
name convention same across all architecture. While __NR_sys-
calls isn't strictly part of the uapi, having it as part of
the generated header to simplifies the implementation. We also
need to enclose this macro with #ifdef __KERNEL__ to avoid
side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 2 ++
 arch/parisc/include/uapi/asm/unistd.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 93fd9f6..d30fdbcb 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -4,6 +4,8 @@
 
 #include <uapi/asm/unistd.h>
 
+#define __NR_Linux_syscalls     __NR_syscalls
+
 #ifndef __ASSEMBLY__
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index bb52e12..f10d065 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -366,7 +366,9 @@
 #define __NR_statx		(__NR_Linux + 349)
 #define __NR_io_pgetevents	(__NR_Linux + 350)
 
-#define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
+#ifdef __KERNEL__
+#define __NR_syscalls           351
+#endif
 
 #define LINUX_GATEWAY_ADDR      0x100
 
-- 
1.9.1

