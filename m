Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88529C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D7D207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="joSUBbym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D7D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeJZNtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:49:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37683 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJZNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:49:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so5327937pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KU6DXIIYUjCMDre4JgDcgc8e7hiA/7vLtU/zXJn/n5E=;
        b=joSUBbymzWhrw4Ir4RK85fifCpmhjJy3C/aL/ReLcVVhQvvy5IGi6CtAqAGQV0IsEY
         pGaLS3CKahKx560UniiLK8i5Fug4ApjXVSlu6io/QvOd+EbMjaO2xlmqGfXj6oJE6ZXN
         FCmutICIRIvx+ZiqRC1W3mCQW8MKm4Pe+pwYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KU6DXIIYUjCMDre4JgDcgc8e7hiA/7vLtU/zXJn/n5E=;
        b=X7C7O1KXYGP9tFRcggCoQpPqkFlPAJXGQS5NZbilsInRPWjum1hG1ehz3UWgwj7mSp
         ANTay/Gfhvur7HFa1LBTcL65KyUZZJdPEZ4NNdWqphXhiUBb6ip7b5GK8nEx7KRBBxJU
         JWkd7Cpz5tWZkxq3PKTJZkT3yJXgw2SHgqNHGGVhVjeDCxGRak31F7dAT0x9au2sbmcM
         Sy1HtFC4rhwDG/tXtfua8iJ+45toOj5/6FgC4qTnmq8WseQfEuO9kWPmhifPvawC2hod
         fuakV5ZilEWPXrxBFuzLgfyFWvXpPp8a+skthOHQ5ZI/y8BaWINtokalXUl81zXUBrgz
         S6mA==
X-Gm-Message-State: AGRZ1gK28bs83gkp7u+cbqsVuD/MNWpA0e2m3UIMiGNsXlRPV4YJsRPk
        LWjZjiOQsfTSlNF9qDc4XkEgBA==
X-Google-Smtp-Source: AJdET5d1A8tfUUrFoYWTaYFzc5eS39pbNLA79NfXtKmeed1g8taZJ5Ji7JZPRR3p7FixJwHJXVBlgQ==
X-Received: by 2002:a62:d046:: with SMTP id p67-v6mr2277940pfg.147.1540530827984;
        Thu, 25 Oct 2018 22:13:47 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id m16-v6sm3329302pff.173.2018.10.25.22.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:13:47 -0700 (PDT)
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
Subject: [PATCH v6 1/5] parisc: move __IGNORE* entries to non uapi header
Date:   Fri, 26 Oct 2018 10:43:07 +0530
Message-Id: <1540530791-3961-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540530791-3961-1-git-send-email-firoz.khan@linaro.org>
References: <1540530791-3961-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the __IGNORE* entries are resides in the uapi header
file move to non uapi header asm/unistd.h as it is not
used by any user space applications.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

One of the patch in this patch series will generate uapi
header file. The information which directly used by the
user space application must be present in uapi file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 6 ++++++
 arch/parisc/include/uapi/asm/unistd.h | 7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 3d507d0..93fd9f6 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -8,6 +8,12 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
+#define __IGNORE_select                /* newselect */
+#define __IGNORE_fadvise64             /* fadvise64_64 */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
 #endif
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index dc77c5a..bb52e12 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -368,13 +368,6 @@
 
 #define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
 
-
-#define __IGNORE_select		/* newselect */
-#define __IGNORE_fadvise64	/* fadvise64_64 */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #define LINUX_GATEWAY_ADDR      0x100
 
 #endif /* _UAPI_ASM_PARISC_UNISTD_H_ */
-- 
1.9.1

