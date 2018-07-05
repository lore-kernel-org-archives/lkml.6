Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5506A208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="URrszoyK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FhTeUuwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5506A208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeGESzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:55:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39946 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeGESze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:55:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CE3E60B25; Thu,  5 Jul 2018 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530816934;
        bh=ckD748rq2cXHUU5b17avEUPvP8L3qIIDQv2lYe157Hc=;
        h=From:To:Cc:Subject:Date:From;
        b=URrszoyKA9meUZlmADG6dyrN4MacLckSMu513kWTjXbbqxH3uhTnE8fa57WzqQ2TM
         0v6o2UQHLuqI70dV4mwBX1rcHUngNks8IQ+H4FCm+piGSyn8SSH++Tzy+ED7j9jloh
         0Njp6Cqago7FT8cw7Q0mx0vd4s7Pa7eoBNh7IN1c=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E53B360646;
        Thu,  5 Jul 2018 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530816933;
        bh=ckD748rq2cXHUU5b17avEUPvP8L3qIIDQv2lYe157Hc=;
        h=From:To:Cc:Subject:Date:From;
        b=FhTeUuwpufk/Mr3rXpC9fCg4BTAlTCjRNsaLW/l8WnuR9jjjD+rQrKFBpPmrkKVXr
         KPaE+p/wawTxAfimbUSfPGeQoPr7xzzwzG5YKCjVnthcXwhCKWT38ntE7fsrq9e8nX
         8ijIG9J0Miw2mhvxLXrPgzTQ4moHyemMWaRPpxe8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E53B360646
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH] checkpatch: check for #if 0/#if 1
Date:   Thu,  5 Jul 2018 11:55:22 -0700
Message-Id: <1530816922-27100-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #if 0 and #if 1 are used to toggle features. Wharn if #if 1 or #if 0
is present. If #if 0 is present, warn about that part of code being
redundant and that it could be removed. Also, if #if 1 is present, suggest
that if the code is required then the #if 1 can be removed. In either
case, these preprocessor directives can be removed.

Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 scripts/checkpatch.pl | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 978c752..fa3e695 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5378,11 +5378,19 @@ sub process {
                  "Use of dsb is discouranged: prefer mb.\n" .
                  $herecurr);
 		}
+
 # warn about #if 0
 		if ($line =~ /^.\s*\#\s*if\s+0\b/) {
-			CHK("REDUNDANT_CODE",
-			    "if this code is redundant consider removing it\n" .
-				$herecurr);
+			WARN("IF_0",
+			     "if this code is redundant consider removing it\n"
+				.  $herecurr);
+		}
+
+# warn about #if 1
+		if ($line =~ /^.\s*\#\s*if\s+1\b/) {
+			WARN("IF_1",
+			     "if this code is required consider removing"
+				. " #if 1\n" .  $herecurr);
 		}
 
 # check for needless "if (<foo>) fn(<foo>)" uses
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

