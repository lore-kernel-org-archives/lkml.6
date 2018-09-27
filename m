Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D64C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B132152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="MrUCPwAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B132152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeI0XO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:14:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45021 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeI0XO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:14:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so3078499ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 09:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=65Hiwf+yG7FM4i05S9P3LUNjj/AxV+zziJA3y9TDGi8=;
        b=MrUCPwATQhVptqIRkyU/E4heJtC1u/6mqA4nolICv4O5x6hwLzI02e7BfxplxTO+lN
         62HYCXjkbxPSiVCGsykjbFdSzSXGwebN0kDWGC+YzA4HwwqUL4qscwoX/gkOskSCUSV5
         F+EfCQyLM29OlFxMyzJyz9RCagwau1cQv7i5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=65Hiwf+yG7FM4i05S9P3LUNjj/AxV+zziJA3y9TDGi8=;
        b=lKjh9RBz33NPbSLOZye2QwftlUZ6kYcpOjMzUCtgawUF6cvpKt87V3a0aKlFG/4pYL
         wGJkmtlrxfKCOr5HMQ2+od9nSjDIhxYe2aAX+LjdFOYIdk3e2a8xjBDgmWw0YQaCf1yE
         8UuZSMuJVYRDzRPr+Wem4C5ZAiOqSU2D/oHbUVWNSq6WPtH4qcV6aiSihbC33NMZdC4+
         JmVZvsswL7i+9VJd7fGmivoiu3yOVoCUY4E+9Xh/HXNfK+8T1z8OoH9zmRKOmJFfcbrY
         qwGOMkDJzVu4n2A/Yiz9/dCq9EUNSuw1YT6OBpdEoWO5kIRj44YOv+zdcXyXv8Ef3aWa
         Qrog==
X-Gm-Message-State: ABuFfohZPffJA83l/Wsgh3Ft6s5Jad09o/NKl3kWZzyJ4An1pydusZY2
        F7R+6tGkSqxzE7cws1WAXuFMpw==
X-Google-Smtp-Source: ACcGV60kiMIPDvN33f36F0+Nb6JAMLVEUkN+PMKZsjXOKwq7n+7JGAiiLiBXzxRW7qF6k29sv/2vwQ==
X-Received: by 2002:a2e:8050:: with SMTP id p16-v6mr1276355ljg.178.1538067345174;
        Thu, 27 Sep 2018 09:55:45 -0700 (PDT)
Received: from kbp1-lhp-f55466.synapse.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id e41-v6sm545997lji.37.2018.09.27.09.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 09:55:44 -0700 (PDT)
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] efi: modify EFI stub code for arm/arm64
Date:   Thu, 27 Sep 2018 19:55:39 +0300
Message-Id: <1538067339-5826-1-git-send-email-maksym.kokhan@globallogic.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original EFI stub code parses command line, using old configs: CMDLINE,
CMDLINE_EXTEND and CMDLINE_FORCE. New generic builtin command line use
new configs: CMDLINE_PREPEND, CMDLINE_APPEND and CMDLINE_OVERRIDE, which
depend on CMDLINE_BOOL.

Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Daniel Walker <danielwa@cisco.com>
Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
---
 drivers/firmware/efi/libstub/arm-stub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 6920033..40396e1 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -146,12 +146,12 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 		goto fail;
 	}
 
-	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
-	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
-	    cmdline_size == 0)
-		efi_parse_options(CONFIG_CMDLINE);
+	#if IS_ENABLED(CONFIG_CMDLINE_BOOL)
+		efi_parse_options(CONFIG_CMDLINE_PREPEND);
+		efi_parse_options(CONFIG_CMDLINE_APPEND);
+	#endif
 
-	if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0)
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) && cmdline_size > 0)
 		efi_parse_options(cmdline_ptr);
 
 	pr_efi(sys_table, "Booting Linux Kernel...\n");
-- 
2.7.4

