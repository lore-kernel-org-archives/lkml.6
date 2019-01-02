Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB15C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AE421901
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="axAiRYUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfABPh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:37:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40870 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfABPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:37:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so15327201pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Ij7bAJQ/5U9CidgRZ/FZU6EPo0eyUndCePkw9f7Oic=;
        b=axAiRYUaWlFs9Ldz2bFMrPP4FLLjPrRmq4si8No7x9W/9eEy2oEV/e2Pi5Lh/sZwGu
         GRL3G+leSm3ZUW/6Bnl9AaD6N0UjU4DRWcO6aQFDWgtO2Cqfetjuv7QMw/SlTqrCCn2W
         QcCZujtCXMQ+4pvjrLP0NkgUmDWMi3ZjFpXMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Ij7bAJQ/5U9CidgRZ/FZU6EPo0eyUndCePkw9f7Oic=;
        b=Pgu4ntEX0fvXxLFZDt6Nb+J6DC19YcmhznCfG6dLuVzZbOvnDTgy0VGpJpRNMR+Y+N
         dHAb6+47ACLu0a8DRxElp2J7UbDZfKA10cvmBtFmz6uP7WU+S8gYxFTF3K3+DvqF91sC
         vKtY7+ea7+tZ+g0Ns9xYtnWs32uq+7bkwyWDyeDjEwbdTL6CEBMgyYtB2aqFKmOmJkfH
         AQb9OvygBnUGnw/SnYRRvkg2Pgbg67fLM5/A2p2K+p15ErBeeEzSDka8+0aOLkFqOtfw
         krEmSBmEfyC0hvoLy77mO0+TCmOvS0SJ8wCGhZ1L9r54HQySDgyasxxEY0xcR782oV9n
         BZjQ==
X-Gm-Message-State: AA+aEWbBfd+sLBunIlkMghKxP+D7KFDL/1TTAIfpdonLfsDzXh82G0AC
        rJr9CVz3MlmCmJtq6T0VDbt8LjzHNiI=
X-Google-Smtp-Source: ALg8bN5crYtwoacCfkVnDCFm+N2hYXb0eKM30jk5QM9/Arbg/HmLV/c7g6xwI6gk4BjbMnPV7u+nuA==
X-Received: by 2002:a62:6385:: with SMTP id x127mr45464796pfb.15.1546443472677;
        Wed, 02 Jan 2019 07:37:52 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id c4sm108500721pfm.151.2019.01.02.07.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:37:52 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/2] sh: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 21:07:24 +0530
Message-Id: <1546443445-21075-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
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
 arch/sh/kernel/syscalls/syscalltbl.sh | 4 ++--
 arch/sh/kernel/syscalls_32.S          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/syscalls/syscalltbl.sh b/arch/sh/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/sh/kernel/syscalls/syscalltbl.sh
+++ b/arch/sh/kernel/syscalls/syscalltbl.sh
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
diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
index 96e9c54..bd1a9c5 100644
--- a/arch/sh/kernel/syscalls_32.S
+++ b/arch/sh/kernel/syscalls_32.S
@@ -10,7 +10,7 @@
 #include <linux/sys.h>
 #include <linux/linkage.h>
 
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL(nr, entry)	.long entry
 	.data
 ENTRY(sys_call_table)
 #include <asm/syscall_table.h>
-- 
1.9.1

