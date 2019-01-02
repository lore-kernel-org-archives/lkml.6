Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C852C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F30218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3xilImm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfABPHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:07:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33267 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbfABPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:07:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so15304760pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 07:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5pdMpbxZGK+s8fSlT5tV/nT+dUGixWoP67cof2b1tuA=;
        b=C3xilImm3AZ9AldnGA33ikZkxfXMu8bfiTh78/5/A+86KBaSCSmkP9IvH/CjkDEdRr
         H7dVCnSpjZW8RuvXWkhHed07eCXvQNuhpj3Om3yufMQ4S8T3Zd4ovIWKXi4hljPHSluR
         ZBH1jI0rBCyBN5J57iz/tSey9Mb+JoiMqN2Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5pdMpbxZGK+s8fSlT5tV/nT+dUGixWoP67cof2b1tuA=;
        b=TXrPXE/r1piek6sa2/fig5xlsuoWhKCb5vVqUKeZdCXuw35CtGrv5RwJ0qu9AyreZ/
         5wnpRnntyLhACt/tQs6zBKnXCrK4rva6rkd2TNagmChG5cVLFmvJeGbkQY/WTiXBi3Pv
         b7pxRpZXE2ReT6aEO7fkf1IDGFdSsVv16Gzq8hIRATExabVeno3G9Z253GFxXIEDfAHG
         luVOe6HSx60MUGPCK0yaG+W0Lh2BcjBDq4Lh/WTdq4nyp82ZW1sdw/nxxjMxVC4T/gWx
         Pm9Z6XrvlaMkx4JUmQoOnGMoAHB2lnpGPPqmUAhkXw1416xDKLtoRj8+oQjKqeUAnS4K
         OJ9A==
X-Gm-Message-State: AJcUukdyAmbQtlWQIikrAA3R2OmS05mAn/+LN3oNb92h7GQ7YBmx+oLf
        06D0cCp+xJKHCb5y2BGNC0WbNQ==
X-Google-Smtp-Source: AFSGD/XHqrQ3EjozRca+egcGdFZSAxmHX2SFYF24UFotxAX0rUrMRha1rzLrDrRcH6XvNkkb/bE+5Q==
X-Received: by 2002:a62:824c:: with SMTP id w73mr44529975pfd.150.1546441651935;
        Wed, 02 Jan 2019 07:07:31 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id k24sm78458985pfj.13.2019.01.02.07.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jan 2019 07:07:31 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/2] alpha: remove nargs from __SYSCALL
Date:   Wed,  2 Jan 2019 20:36:58 +0530
Message-Id: <1546441619-19977-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546441619-19977-1-git-send-email-firoz.khan@linaro.org>
References: <1546441619-19977-1-git-send-email-firoz.khan@linaro.org>
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
 arch/alpha/kernel/syscalls/syscalltbl.sh | 4 ++--
 arch/alpha/kernel/systbls.S              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscalltbl.sh b/arch/alpha/kernel/syscalls/syscalltbl.sh
index 85d78d9..904b8e6 100644
--- a/arch/alpha/kernel/syscalls/syscalltbl.sh
+++ b/arch/alpha/kernel/syscalls/syscalltbl.sh
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
diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
index 9704f22..36c94c8 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -7,7 +7,7 @@
 
 #include <asm/unistd.h>
 
-#define __SYSCALL(nr, entry, nargs) .quad entry
+#define __SYSCALL(nr, entry)	.quad entry
 	.data
 	.align 3
 	.globl sys_call_table
-- 
1.9.1

