Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818A2C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE4120833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="POjXu/Co";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cjAErDUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE4120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeGZA3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:29:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44008 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbeGZA3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:29:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D65B360B11; Wed, 25 Jul 2018 23:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532560539;
        bh=FOoQYDNMd4CA/tCAHrwJLafeYwxz7FMrYGZ1CPZhz6c=;
        h=From:To:Cc:Subject:Date:From;
        b=POjXu/CoPIJEpk0KrPrTOtnx321adFAx55anoHB3wDNATWOD9oblNG9vH/KmdJQic
         7sKTpdyAaRgMfrs5TeqpNhp/CwEzswjpi51aT8J6cHWpqrz7g1sJEICo9etufaC8pm
         INhiAgv0Wndp6XzGjjreSZRGPMhZL3rmnrPuS6ps=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CBA5605BD;
        Wed, 25 Jul 2018 23:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532560538;
        bh=FOoQYDNMd4CA/tCAHrwJLafeYwxz7FMrYGZ1CPZhz6c=;
        h=From:To:Cc:Subject:Date:From;
        b=cjAErDUx1a4/rTckvYNgnDCsUz4q6ceeFdy0Tc75/IP1xFTgCQ07L3zpzCntxxFiX
         h0M7iL2tdas2IIIo6cfrz1i/InfEXbIuO4goplhrvX49aFjQr3SeFqKHLb9pTz9JD+
         /zy7/XzwqcMY+YvDQcWi9AHAe0dxKrnb+YaZ2q+Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CBA5605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH v1] checkpatch: check for #if 0/#if 1
Date:   Wed, 25 Jul 2018 16:14:05 -0700
Message-Id: <1532560446-15827-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The #if 0 or #if 1 is used to toggle features. Warn if #if 0 or #if 1
is present and suggest that they can be removed.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
Changes in v1:
- Rephrase the warning message to fit in a single line without 
  80 column limit

 scripts/checkpatch.pl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3394ed8..72513c2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5383,9 +5383,14 @@ sub process {
 
 # warn about #if 0
 		if ($line =~ /^.\s*\#\s*if\s+0\b/) {
-			CHK("REDUNDANT_CODE",
-			    "if this code is redundant consider removing it\n" .
-				$herecurr);
+			WARN("IF_0",
+			     "Consider removing the #if 0 and its #endif\n".  $herecurr);
+		}
+
+# warn about #if 1
+		if ($line =~ /^.\s*\#\s*if\s+1\b/) {
+			WARN("IF_1",
+			     "Consider removing the #if 1 and its #endif\n".  $herecurr);
 		}
 
 # check for needless "if (<foo>) fn(<foo>)" uses
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

