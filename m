Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C1FC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777E120647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cP9rko6c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YtC8RdOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777E120647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbeGZSbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:31:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbeGZSbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:31:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 904D0607B9; Thu, 26 Jul 2018 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532625242;
        bh=ZHJb8Jr1BxVCVwX4Qlk7PnqxLmowZsWG09QmBn6nBxg=;
        h=From:To:Cc:Subject:Date:From;
        b=cP9rko6c1OBBLYDfWDnBd19SUomVEJu12GU2PUNGZ+QwCUQTY7SeJeC18QUOrJVUG
         6ulEC5ZX4i3YvSgKogd//HbBtGTTwT/REtAOFA6OS+ZQob1iI9jxL38TDcnD1BFCvr
         tjJMQZOoRVwe8FhvrYXHLIV6iozjd4NWf1qsGxAY=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F27D60C1C;
        Thu, 26 Jul 2018 17:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532625241;
        bh=ZHJb8Jr1BxVCVwX4Qlk7PnqxLmowZsWG09QmBn6nBxg=;
        h=From:To:Cc:Subject:Date:From;
        b=YtC8RdOj8ZO8Ev9t6SEWi4GOB/MMgd1e66GTadRagVGU98tdQfhmSIhq7TfAEJvm+
         98fB2/YLs03S8eB4ND9v0HiE3Ft2Gd19fXVMNkOyT4XAEwqZHHAR3TBUS7zCKeVrwF
         H7I/ag8TrrODu0Mto/TKHOSQZ6tI+KF66RUfXzYk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F27D60C1C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH v2] checkpatch: check for #if 0/#if 1
Date:   Thu, 26 Jul 2018 10:13:38 -0700
Message-Id: <1532625218-24321-1-git-send-email-pheragu@codeaurora.org>
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
Changes in v2:
- Rephrase the warning for #if 0

Changes in v1:
- Rephrase the warning message to fit in a single line without
  80 column limit

 scripts/checkpatch.pl | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3394ed8..1dfe83f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5383,9 +5383,14 @@ sub process {
 
 # warn about #if 0
 		if ($line =~ /^.\s*\#\s*if\s+0\b/) {
-			CHK("REDUNDANT_CODE",
-			    "if this code is redundant consider removing it\n" .
-				$herecurr);
+			WARN("IF_0",
+			     "Consider removing the code enclosed by this #if 0 and its #endif\n".  $herecurr);
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

