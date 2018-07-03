Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C48C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4633022BD0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DxawjJi6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DxawjJi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4633022BD0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeGCQ4b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:56:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43518 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeGCQ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:56:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BDCC606FA; Tue,  3 Jul 2018 16:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530636989;
        bh=jqi4BWqFSZJJ1xstAtSdcsqPY3+uTMbrWZtQjvJ06qI=;
        h=From:To:Cc:Subject:Date:From;
        b=DxawjJi6XJw28GSrXCSZcfgt7a5rJUB/N0ico78weTd6C1OCywscqUuISW13tKGhg
         eqLV1ujXcdXeb/ghSHJr2J5Q/z4m+n/RCr8cLblBfFTcm5W+dTu/HCskDJlasJHxJE
         Q8SCr82BRySwGy7SiWiqtggzcq6htWnkljP/EvcE=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E071C6028D;
        Tue,  3 Jul 2018 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530636989;
        bh=jqi4BWqFSZJJ1xstAtSdcsqPY3+uTMbrWZtQjvJ06qI=;
        h=From:To:Cc:Subject:Date:From;
        b=DxawjJi6XJw28GSrXCSZcfgt7a5rJUB/N0ico78weTd6C1OCywscqUuISW13tKGhg
         eqLV1ujXcdXeb/ghSHJr2J5Q/z4m+n/RCr8cLblBfFTcm5W+dTu/HCskDJlasJHxJE
         Q8SCr82BRySwGy7SiWiqtggzcq6htWnkljP/EvcE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E071C6028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        bryanh@codeaurora.org, tsoni@codeaurora.org,
        Abhijeet Dharmapurikar <adharmap@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>,
        Murali Nalajala <mnalajal@codeaurora.org>
Subject: [PATCH] checkpatch: check for #if 0/#if 1
Date:   Tue,  3 Jul 2018 09:56:08 -0700
Message-Id: <1530636968-17906-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

The #if 0 and #if 1 are used to toggle features. Warn if #if 1 or #if 0 
is present. If #if 0 is present, warn about that part of code being 
redundant and that it could be removed. Also, if #if 1 is present, suggest
that if the code is required then the #if 1 can be removed. In either 
case, the preprocessor directives can be removed.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
---
 scripts/checkpatch.pl | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c0550..a3dc0c8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5374,9 +5374,16 @@ sub process {
 
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

