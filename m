Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E2AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EE82085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCbXLv0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EE82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbeKGDhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:37:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37568 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbeKGDhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:37:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id p6-v6so6572094pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fz3kunU5ZVhqs/5pZsL/70JG8neMn8vZHcTgAU3UaoA=;
        b=LCbXLv0e98wW/rQK/pK+mYoWLLpFF0sYEmhQW+qcxJKnzYnerNV7uOIhErlCbFJvqC
         NvGKd4dO55scZX5uD+h2Kmrh36oetYz7IDKG4oi48KCQOKZnPbmn1+fckQ3DcrWOuG40
         Q/Fb+IpfUQ8mojuOy4oN/Y7ZrG0vWp9ZTTDMCe4AkqpngFHfCh5FI/h2vlFpjihhtZ1U
         MEui33IBdw5L2b8bVrTFqi0Kpim60WBnSYAhFXrBsRMmZ2W2SWamXRP3aEyFe8NPMyrp
         QxvF75LNl9wwfCYIR3j9Xid0AGXCwjKalRxXtZxEeyLKrpEWB7hiqi91R0v+/0Nh3Gk1
         AQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fz3kunU5ZVhqs/5pZsL/70JG8neMn8vZHcTgAU3UaoA=;
        b=omMaPhXkcxFUm5k3XGywreixNEzgsUO8XGxQj0Q7yoGxqZyNOV3/vSLmuOlpabCGus
         RTbFUHgupc4g3Y/6fPdC5VXdbHD4NqL7njT0ejXcSRbbQ7K7ayu3CMwlJVmgY2sH2xsa
         +SkUtThADkx7GYJWNi62oxcio1gDZ0mNuPLr5B/wS814N+BsM9y12fI/HXXHVYBAlpn+
         ZNsh66fk/eWvUyD497MO2v2UnxcOcGY3xDgabYrX8c3kyyGXEiAQrg/pLcVSh7dyrIlZ
         m15ICNOvPglzLF0m9R+8e7T5C/yGCOTlY4wi9GOehhHx5GSNH1dlXdaXB9rFLh+rdVrf
         RFIg==
X-Gm-Message-State: AGRZ1gL0WZ5P22ZH1Rtf8ql7xDUEuOGYF9UOTMJf559ITW5Y/iX9zGt/
        QRdFBAPORmRjJAqgc6UtV7n2y/Qp
X-Google-Smtp-Source: AJdET5cWKxfdb3d3tPHI88d4qTENUrByAer9/F6mSYW04EMyUaHeCLBaw4mbCS6TtgP7uBLrUOt7Qw==
X-Received: by 2002:a17:902:b592:: with SMTP id a18-v6mr26607611pls.248.1541527847969;
        Tue, 06 Nov 2018 10:10:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g27-v6sm21363552pfj.162.2018.11.06.10.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 10:10:46 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Genki Sky <sky@genki.is>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check more robust"
Date:   Tue,  6 Nov 2018 10:10:38 -0800
Message-Id: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6147b1cf19651c7de297e69108b141fb30aa2349.

The reverted patch results in attempted write access to the source
repository, even if that repository is mounted read-only.

Output from "strace git status -uno --porcelain":

getcwd("/tmp/linux-test", 129)          = 16
open("/tmp/linux-test/.git/index.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) =
	-1 EROFS (Read-only file system)

While git appears to be able to handle this situation, a monitored build
environment (such as the one used for Chrome OS kernel builds) may detect
it and bail out with an access violation error. On top of that, the attempted
write access suggests that git _will_ write to the file even if a build output
directory is specified. Users may have the reasonable expectation that the
source repository remains untouched in that situation.

Fixes: 6147b1cf19651 ("scripts/setlocalversion: git: Make -dirty check more robust"
Cc: Genki Sky <sky@genki.is>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 scripts/setlocalversion | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 79f7dd57d571..71f39410691b 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -74,7 +74,7 @@ scm_version()
 		fi
 
 		# Check for uncommitted changes
-		if git status -uno --porcelain | grep -qv '^.. scripts/package'; then
+		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
 			printf '%s' -dirty
 		fi
 
-- 
2.7.4

