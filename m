Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B7C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533072244C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533072244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeHJTf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:35:57 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40230 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:35:57 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so8226353iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 10:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X0eRFU4tLLKJ8DmW3ZsuHf2IqvnzKp8H4GzaKdW6xKs=;
        b=mDkjUSQAt/Mrj25KYhLaFulFwzGfnI4nvl5rrFYseVGlV1p7avjm0Y6uq2WCqahLyC
         jtKtOvYF8ODE0JD0LCsJwCtOe2+D2d22XO4HUOe4mcV6CDagzv6RS9vDAJIwLRLH1NhV
         bDWpxNu3pl9yQdqdWoIs8R3oCil4NcLW+/v1Tav2M1XzMwJndOkYEi1kcKF3nG26YhAb
         arAkAAS4MFeSMc/iPyH5t2c5Z2R+jcT3oNpqa+7bisRP/f8H6VtbD3oL9nqx8sFvS8Dj
         0WWJX0Wj52GUeRJCiT/zXv+YhwT6Eat4yggN8lM3KW98qP4vOHeZKGv4saIZ2jK1SDsd
         GLWw==
X-Gm-Message-State: AOUpUlFwrbkiGx11fLNfJGeyxAdauIdpZe60rtZ0kV4aSHPc7blBT+Ah
        Ae9e2CxfbEYJmebddj796DoQ8MU=
X-Google-Smtp-Source: AA+uWPwe5W3EFH9F9P/LJ0i+x/GZwsI5s9CoIPSjDaBMLRegYo8K1S2KoDObXdacXsOU6pmAlqTl5A==
X-Received: by 2002:a6b:ec0f:: with SMTP id c15-v6mr6219418ioh.18.1533920715296;
        Fri, 10 Aug 2018 10:05:15 -0700 (PDT)
Received: from localhost.localdomain ([24.51.61.72])
        by smtp.googlemail.com with ESMTPSA id z195-v6sm7294096ioe.38.2018.08.10.10.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 10:05:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: [PATCH v2] checkpatch: DT bindings should be a separate patch
Date:   Fri, 10 Aug 2018 11:05:13 -0600
Message-Id: <20180810170513.26284-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devicetree bindings should be their own patch as documented in
Documentation/devicetree/bindings/submitting-patches.txt section I.1.
This is because bindings are logically independent from a driver
implementation, they have a different maintainer (even though they often
are applied via the same tree), and it makes for a cleaner history in
the DT only tree created with git-filter-branch.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Add doc pointer to warning
- Simplify logic

Joe, this makes $is_binding_patch an empty value when the regex doesn't 
match rather than 0 which would be more logical IMO. It seems to work 
fine, but I'm not sure if there's a better way to do it.

 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c05506e325..f9aba4bc41ce 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2236,6 +2236,7 @@ sub process {
 	our $clean = 1;
 	my $signoff = 0;
 	my $is_patch = 0;
+	my $is_binding_patch = -1;
 	my $in_header_lines = $file ? 0 : 1;
 	my $in_commit_log = 0;		#Scanning lines before patch
 	my $has_commit_log = 0;		#Encountered lines before patch
@@ -2485,6 +2486,19 @@ sub process {
 				$check = $check_orig;
 			}
 			$checklicenseline = 1;
+
+			if ($realfile !~ /^MAINTAINERS/) {
+				my $last_binding_patch = $is_binding_patch;
+
+				$is_binding_patch = ($realfile =~ m@^(?:Documentation/devicetree/|include/dt-bindings/)@);
+
+				if (($last_binding_patch != -1) &&
+				    ($last_binding_patch ^ $is_binding_patch)) {
+					WARN("DT_SPLIT_BINDING_PATCH",
+					     "DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt");
+				}
+			}
+
 			next;
 		}
 
-- 
2.17.1

