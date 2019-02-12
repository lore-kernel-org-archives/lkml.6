Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84BCC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F59222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dt65tWm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfBLSXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:23:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36639 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfBLSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:23:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so1688880pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=fZynsMqP80440N33/zyWh+nSbTs5Z2QL/QCUJqp1qGU=;
        b=dt65tWm4NckOQG+gXubMg9ozXeAHtWhmTfXZBlkIq/JgJgR7dCF4/eX6nCYSl+f/Nd
         KErOIJOxgjvL2Yx8TXEGmryRehxfy4dKrc6lWuGXlEVOS5mUlRU9o1GJzHHlupNOTELy
         +heAxF/O/uUhSqFZs3en+J/27jIzgtJLkLsvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fZynsMqP80440N33/zyWh+nSbTs5Z2QL/QCUJqp1qGU=;
        b=IzXWuMJoeAm7I3MwrhcDxgrxLmxRWbntKdLlTDbinJ3VKUvJigj/4AgUbaFI57hF4K
         ZQbihzfbZI45f2f0Bk6jyy6mecpKyHy2P6zD+O7Xq6Cuq/XECUvu0KI1c29+1n8265B/
         GE2kx3TOwbi+0Ji/77N/7KFQVQVnK1w3mcDu9wCUR10CZ/ZZZUpgMl/JIXRxTo1Tawua
         Jf2+y+HoMc6lgWsZtVKhMSxL5txIHc2W07E1PJe/ZTLSoZxyqEt7a23w5cfxAp08mA3J
         zLfiCbYWVoGav8ynFln82rmatDRddny+d+Faz/tVNN8jwKSyEGd+k4D9HgZX/m7CNDYF
         2YwQ==
X-Gm-Message-State: AHQUAub8JZXsAjIZyHOzpOTvn+EjFoT3xbVW73eTSBocTUgyqVOP5w+x
        i4Kud4SIPcC24LwzXB2/5AKtVg==
X-Google-Smtp-Source: AHgI3IaHKd4c3P3WktFwJrSwlOOXjOzu6zbSSBJc1+mov5Zi7TjOtRj7AUjOb6FtZ76YuYKczZvIZg==
X-Received: by 2002:a62:b2c3:: with SMTP id z64mr5187699pfl.149.1549995800723;
        Tue, 12 Feb 2019 10:23:20 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y5sm44730501pge.49.2019.02.12.10.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:23:19 -0800 (PST)
Date:   Tue, 12 Feb 2019 10:23:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] LSM: Ignore "security=" when "lsm=" is specified
Message-ID: <20190212182318.GA16669@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
used on the command line, and report that it is happening.

Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
 security/security.c                             |  8 ++++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 93d2c97f28fe..a0abd5f56e00 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2340,7 +2340,7 @@
 
 	lsm=lsm1,...,lsmN
 			[SECURITY] Choose order of LSM initialization. This
-			overrides CONFIG_LSM.
+			overrides CONFIG_LSM, and the "security=" parameter.
 
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
@@ -4129,11 +4129,9 @@
 			Note: increases power consumption, thus should only be
 			enabled if running jitter sensitive (HPC/RT) workloads.
 
-	security=	[SECURITY] Choose a security module to enable at boot.
-			If this boot parameter is not specified, only the first
-			security module asking for security registration will be
-			loaded. An invalid security module name will be treated
-			as if no module has been chosen.
+	security=	[SECURITY] Choose a legacy "major" security module to
+			enable at boot. This has been deprecated by the
+			"lsm=" parameter.
 
 	selinux=	[SELINUX] Disable or enable SELinux at boot time.
 			Format: { "0" | "1" }
diff --git a/security/security.c b/security/security.c
index 3147785e20d7..23cbb1a295a3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -288,9 +288,13 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
-	if (chosen_lsm_order)
+	if (chosen_lsm_order) {
+		if (chosen_major_lsm) {
+			pr_info("security= is ignored because it is superseded by lsm=\n");
+			chosen_major_lsm = NULL;
+		}
 		ordered_lsm_parse(chosen_lsm_order, "cmdline");
-	else
+	} else
 		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
-- 
2.17.1


-- 
Kees Cook
