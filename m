Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F9C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C12075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J59vzM2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7C12075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeJLRQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:16:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45069 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeJLRQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:16:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id u12-v6so5907276pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=J59vzM2Qn9/WdOgb/6gkFAK/h0amsxCFQ285V7KFWZcelSCh4nrsKoR1skc07r7gsF
         e0vzav7jik47f/sU2fxxeUbq1/qqt5mnfdmiCG/2cj899BLA09IH/JSR17QVpHe+wLNo
         RM+Po9FNb4LoAnG457qrPUMRtYDrbD82cqgyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=lVcguBEP2rw8de7LO+bn+c0fn5pdoCPje7nvn4y5mm4k3IFkIAKEhAHASBvlNm7ZU4
         GaeWr6w4l24O7JNyDPmcEmQsyu3a+/51fNJnJ+tek5cBNhZEz6WEu5HXGrC64Oix5mFf
         xXaZgp6w1wUGK2WWf6ke/ZYK9XR3d2n/uJrPzvk4yjQTtbtTxE7EFPRgfNilMeP0ctTB
         ADomIfLwnzX7eUJq7WKyGpzqKwacc2R9b56xOUEbzQE6fCnqHpvRLfxfWR/ub/TBRk6N
         9ipZQCQwO59ML5Csi4nIS47u/JVpx1jM9pPe3IffVAu2+tFcUT1wMVcHa1VmP7Pyk11A
         SIVw==
X-Gm-Message-State: ABuFfoipm9j4dTKWoqr7osH7463lJuOiZ1+HcRfm5PAyg7UYM3RLZsI1
        GsRZg7OJr10NUnWgO3osJkhHCQ==
X-Google-Smtp-Source: ACcGV62ymPK6IHYuedcEiA7pSoU+sn/c6kyG54BoosJZSKdzkzgsibk1yfZJoXRCo6PZWePHAm9hcA==
X-Received: by 2002:a62:34c5:: with SMTP id b188-v6mr2171721pfa.65.1539337511810;
        Fri, 12 Oct 2018 02:45:11 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.108.175])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1254191pfi.137.2018.10.12.02.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 02:45:11 -0700 (PDT)
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
Subject: [PATCH v4 6/6] parisc: syscalls: Ignore nfsservctl for other architectures
Date:   Fri, 12 Oct 2018 15:14:02 +0530
Message-Id: <1539337442-3676-7-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an exception to the syscall table checking script.

nfsservctl entry is only provided on x86, and there is no
reason to add it elsewhere. However, including it on the
syscall table caused a warning for most configurations on
non-x86.

<stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 scripts/checksyscalls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ee3dfb5..cf93100 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -150,6 +150,7 @@ cat << EOF
 #define __IGNORE_uselib
 #define __IGNORE__sysctl
 #define __IGNORE_arch_prctl
+#define __IGNORE_nfsservctl
 
 /* ... including the "new" 32-bit uid syscalls */
 #define __IGNORE_lchown32
-- 
1.9.1

