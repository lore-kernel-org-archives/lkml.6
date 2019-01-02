Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4644C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1664218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QC8VEHME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfABP3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:29:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44785 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbfABP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:29:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so14630072plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=myGiGPFYzEzo3ceYJtj1+5n7XmY861E8tGq+s31tnXA=;
        b=QC8VEHMElJnlDDPtKVmbXwhtKQ8Xxe/7/+6XLmYHwJPcOwskfIZHyggVVl5gURJ5+0
         3gY+0RgpiHio56Z6sYWWsTHq9aDLP9I9aXiBpIdcFzICrFZJ7cnjTtiX0KBEjwfNVdAL
         FIZaheFYrOX6ILzPP4iPpmh7eqtnJkvLFDL6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=myGiGPFYzEzo3ceYJtj1+5n7XmY861E8tGq+s31tnXA=;
        b=StGvtghbxQWKQ8iv0r5WNMyIlkdzSYN8WvYxMua2U7RA+YBodjYAERUDFsndOHVfJR
         ErWwZDyxk3gjB2I5lA7yzp7Y9o5bPjzHc4s2bx/KwbevvGf8PmJSlG3aDJAYMpmd4Rru
         6FE6dh5CFfSTaqkm8ajNsPQucMenLjm8RNQg4Oj/sSuQOnMx+3IfzBdmrrALj2pkOza/
         pdnjzNh8NrXyVz8TrWN5NlayybZoprYjY8GXS8PSXbpWHoO7xBZJUn1Uji3cUz8ax3ZG
         wLXQbwEZMfUM03Es7/lkqPgC7+koc/vklUzNfcHCAFT2A9BKNxeFco0xcR3iEoTF5pV3
         hPaQ==
X-Gm-Message-State: AJcUukf3YaHAqKFiUJs+VaXLPMcHAlhuyLtMxb7DzropBVNs0V48Uhl6
        hYS53sZH+mYkjlDBf4sUd8zZfQ==
X-Google-Smtp-Source: ALg8bN6e0tnuCTkF5fEGOTEKxUkhc3gVU2ZrpqfNuAukFNHINd2bhny+T7DJKx4kPGX8bf0lzsxIKA==
X-Received: by 2002:a17:902:b01:: with SMTP id 1mr44490225plq.331.1546442961658;
        Wed, 02 Jan 2019 07:29:21 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id k191sm63030673pgd.9.2019.01.02.07.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:29:21 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 20:58:31 +0530
Message-Id: <1546442912-20818-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __SYSCALL macro's arguments are system call number,
system call entry name and number of arguments for the
system call.

Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
calculated nor used anywhere. So it would be better to
keep the implementaion as  __SYSCALL(nr, entry). This will
unifies the implementation with some other architetures
too.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/xtensa/kernel/syscall.c              | 2 +-
 arch/xtensa/kernel/syscalls/syscalltbl.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 2c415fc..0665339 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -31,7 +31,7 @@
 syscall_t sys_call_table[__NR_syscalls] /* FIXME __cacheline_aligned */= {
 	[0 ... __NR_syscalls - 1] = (syscall_t)&sys_ni_syscall,
 
-#define __SYSCALL(nr, entry, nargs)[nr] = (syscall_t)entry,
+#define __SYSCALL(nr, entry)[nr] = (syscall_t)entry,
 #include <asm/syscall_table.h>
 #undef __SYSCALL
 };
diff --git a/arch/xtensa/kernel/syscalls/syscalltbl.sh b/arch/xtensa/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/xtensa/kernel/syscalls/syscalltbl.sh
+++ b/arch/xtensa/kernel/syscalls/syscalltbl.sh
@@ -13,10 +13,10 @@ emit() {
 	t_entry="$3"
 
 	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
+		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
 		t_nxt=$((t_nxt+1))
 	done
-	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
+	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
 }
 
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-- 
1.9.1

