Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF49C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AF720854
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1GWDuAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AF720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbeKNQhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:37:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32945 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeKNQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:37:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id v68-v6so7400827pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 22:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lGKo+uh9NavZlvOKuaLU75N20J3fUMTxzH93MDaDkDs=;
        b=Y1GWDuAld86OjV9Bjs0COTnY8phRH8oaFJ9w92/IjH71m/JyHrliot6Yw2QKktXHs9
         wus/NzgH6gAD49t4nA6JOVVAmTUH1jhit0f7UA6nQ0QtgkjG4DNNt45Tovw2DPQXtUeP
         OyjB78JKvOeiuK1vNIyCTfwkn6WENetczng4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lGKo+uh9NavZlvOKuaLU75N20J3fUMTxzH93MDaDkDs=;
        b=ahpjbyOoKM2LzVEYmFBbedNLLaNJoo+bRmLrl8pdaqMKUdcaWu87HHlEW6FK/XqFvB
         QX+Oni5lo2O59FjpuDq9xFzd4V1vudNhvjW1HqRG7oJbVjpuFuzVWk1+7PYl6RMy/sa6
         v31BvzYxulfi4QugTaTpQj07pI2KWfqIC3vRVTzCtWXZ4beUuICR8Ge8cLwPbuhULUII
         HvAiImxXNpe9UIMmc3KPGIobUVb6M8q9t5O/8H41+O9G51vfUZ0US/Qix8g4K4/kSi65
         1x/GbGIg98yuxdLnrVj9cB8/qS41SQsUjn92/eN9XaqtaLZHehBVJQoI4ZYTt7GPXQbq
         BC8A==
X-Gm-Message-State: AGRZ1gJhjg2LVAkP8AnuluMppyNuaPzu3hKukjSP+HyYyN19CTURdyfk
        ZfCNDg7qqS/LavPCwl93pE2xAw==
X-Google-Smtp-Source: AJdET5du1hsS3OzC4rVHf0TJe4VmBO2fEKeLObr+Szql1JLN0EItqkWllp0sOn7/cuIkFf4Osoam6A==
X-Received: by 2002:a63:a16:: with SMTP id 22mr636960pgk.318.1542177331360;
        Tue, 13 Nov 2018 22:35:31 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id l26-v6sm39097318pfg.161.2018.11.13.22.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 22:35:30 -0800 (PST)
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
Subject: [PATCH v7 1/5] parisc: move __IGNORE* entries to non uapi header
Date:   Wed, 14 Nov 2018 12:04:57 +0530
Message-Id: <1542177301-25844-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
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
index bc37a49..fd1013f 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -8,6 +8,12 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
+#define __IGNORE_select			/* newselect */
+#define __IGNORE_fadvise64		/* fadvise64_64 */
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

