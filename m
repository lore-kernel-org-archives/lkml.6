Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977A3218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HywkS7Rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbfAaJ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:56:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43514 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfAaJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:56:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so1133626pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9rgrmz7zvCwt6KzmO/XCtKc4dtNzesbjo8qK3Pc4oU=;
        b=HywkS7RpVzFiHpIKcNgYNBWLwlIbnjtPfx4OKoEFZNHUwGjTs1e1OdbpPU+3rMHnRF
         RGadcU8LKbx40fEagSPh3evM7FSQqOm075vYkKfrhrhFtOyloODLh2tWM1CszuG06nKY
         Trnj/oFTzyEdRyJQRzIKF7dvHyL7BSgCt2DDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9rgrmz7zvCwt6KzmO/XCtKc4dtNzesbjo8qK3Pc4oU=;
        b=HCtPisknqR3NZfOHaYQSuPIU1dYy3PSnQ3wEMe5HVO9qjKUb5Ge5t/EnWVuFlqzqrT
         zh5/WchBhKMi0+m89DiedaUNaiMH74kxhEH3pJcehgZQhwpItGA6GFpxrUeAt6cPXZrr
         4qK1fTOUh99Sw/dK/v8BqdeVwNUZBwHQ2+hWgJLGm4gwPz6TwjhrT0nGejBKvsgVa+Q5
         hw81RoidKiyXrmTz5bfux7eOvBInpwJHsaz70m8Ov2WEUWZp4HinGg9nOFAkxScm9MEu
         EMMSc79fZhsC76XdcrqWAfrbO4xrIyPT7S0Ky8jc9S4ysAAEU5km8OU+xMIlk+G24PbE
         6JcQ==
X-Gm-Message-State: AJcUukcCElXJiH5BYxz/OsEm31mM/IYAYoqgc03+0GPzAcQwjdAODiA1
        jl8ayDtoywARvYxHsOemvWn8jg8mt9o=
X-Google-Smtp-Source: ALg8bN5A51O624+PAY1oLcpdaHl3gbuFHTgfT2Y7+96ZMdwPAlpY9XS45/HsXC6dS14m6UHuJ90HSA==
X-Received: by 2002:a63:4c4e:: with SMTP id m14mr31227476pgl.173.1548928601491;
        Thu, 31 Jan 2019 01:56:41 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id e123sm5128879pgc.58.2019.01.31.01.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:56:40 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] checkpatch: Properly detect /* */ style SPDX header.
Date:   Thu, 31 Jan 2019 17:56:25 +0800
Message-Id: <20190131095625.261755-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently for a header line "/* SPDX-License-Identifier: GPL-2.0 */",
only the part starting from "SPDX-" is passed to spdxcheck.py, and cause
false warning. Fix this by passing the whole line to spdxcheck.py
instead.

Fixes: 3b6e8ac9e740 ("checkpatch: validate SPDX license with spdxcheck.py")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 scripts/checkpatch.pl | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cfe0396c98459a..8a7cca4e2efb00 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3044,10 +3044,9 @@ sub process {
 					 WARN("SPDX_LICENSE_TAG",
 					      "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
 				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
-					 my $spdx_license = $1;
-					 if (!is_SPDX_License_valid($spdx_license)) {
+					 if (!is_SPDX_License_valid($rawline)) {
 						  WARN("SPDX_LICENSE_TAG",
-						       "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
+						       "'$rawline' is not supported in LICENSES/...\n" . $herecurr);
 					 }
 				}
 			}
-- 
2.20.1.611.gfbb209baf1-goog

