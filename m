Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E385C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E5F20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJByXlLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E5F20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbeKLOBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:01:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37787 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKLOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:01:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id p6-v6so3657581pll.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 20:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ftuYd77dxjW1o+kkM3mk15tl4baMVeCsWEMwA8MCLkE=;
        b=nJByXlLzLLFsN246P+rL3pwhkd1uuRNKjzSvFtFJIUWdPzSKk2ImhjJZN1lGJ+AS6T
         3OZXSmoBIXx/Zrru+tCJAfUd8fF88CV6cbWSJHqBLx4AajgSgxkfaDD4xy1Jblhj2/fR
         FTJ0mWr+AV+mVsFLiWVcyGma60qchtd6Pi4Je4CJQ+RqzMaxJXrBy7l01an2fUidFBh5
         lcwgSF+4PjrHrBD1I4ziODxK5yTP5gKcgTw7EqdFjXH7voEY62zdh09uBlqigqTsLw++
         00ca1wuWfrrUg+6QZVgFsV93hxTYK12Qr+T7TKYz4+AE+Ye4zATa7FeoCLD57SosbHBw
         MLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ftuYd77dxjW1o+kkM3mk15tl4baMVeCsWEMwA8MCLkE=;
        b=E1zrnwYId+Aktzc8YEueusAddYe/tnEbT2V7uNDiPrl4lx6atpJ6bjJBc04kea3t1+
         ZDBPk5TL010DOXo1c9ZhiS88BESV/IJrcpaevF2e3QwfrmDhxA8nu4Hlb4tNiVAvvzfM
         JsRMg0jZGJd54Ply6+J+EiooSmO3q4Hxn3xS+AdGAylbVp2yqyLLcyo2xccLeSu5cAlQ
         LK8VJSxGwZdvI5nQktih6XsB6/BJhyI2UKaKw0X1clpcyjYOZscELjvvWpEE2X4JGrDX
         Zdb+cjO3jTA931RKP9l9ndC9ZvGDxlFsESK0C+tBXMsnEK7JF+jlPVoYBgnGoBZQZYSA
         w4Bg==
X-Gm-Message-State: AGRZ1gJM6Bqdlv1OhZI52uw/ye8Oq59OCBdLtKdtx4HaXqcQc7dDlIgC
        V5hUkHqHNtbGum3fFCFxVf4=
X-Google-Smtp-Source: AJdET5fylLqW/Ack1hU5NK6gOdPMsgF5G0+oGr7FBFTtXFF8N+Z805eHW3Hiwg794KOXbd7Wfq9oUw==
X-Received: by 2002:a17:902:6801:: with SMTP id h1-v6mr18334087plk.177.1541995795799;
        Sun, 11 Nov 2018 20:09:55 -0800 (PST)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id i189-v6sm27536599pfc.16.2018.11.11.20.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 20:09:55 -0800 (PST)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong@andestech.com
Cc:     Zong Li <zongbox@gmail.com>
Subject: [PATCH 1/2] RISC-V: Request stat64 on RV32
Date:   Mon, 12 Nov 2018 12:07:43 +0800
Message-Id: <41e8cb18d321244ab7000f7dc0467b6ebc5cab8f.1541995312.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1541995312.git.zongbox@gmail.com>
References: <cover.1541995312.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stat64 family that is used on 32-bit architectures to replace
newstat.

Since commit 67314ec7b0250290cc85eaa7a2f88a8ddb9e8547 ("RISC-V: Request
newstat syscalls"), the RV32 build fail with undeclared 'sys_fstatat64'

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/include/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index eff7aa9..a4aade9 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -18,5 +18,6 @@
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_STAT64
 #include <uapi/asm/unistd.h>
 #include <uapi/asm/syscalls.h>
-- 
2.7.4

