Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73757C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C07240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TK6nf3T9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TK6nf3T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C07240CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeGEVVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:21:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbeGEVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:21:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB61D60B19; Thu,  5 Jul 2018 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530825705;
        bh=M/5OQxHFijykufZ1bEODyWAYGHZgf4ucNE1PY1sodEo=;
        h=From:To:Cc:Subject:Date:From;
        b=TK6nf3T9mceV3RC/afBYFKe4pMEhQ9GmpledAyCN3Fh+zdBGcfksGhqTh4/Ib96FO
         o1q7SMmvJJJmY62Uh/pEyycZA1iejQo4lmI5xelxtQH1xVUiUHX+ykwjvVq6wV23tB
         wOYqjeSy3gfzEV1OtzKQ3ZOAy9VbyyjqESoK2Mck=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A9D960721;
        Thu,  5 Jul 2018 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530825705;
        bh=M/5OQxHFijykufZ1bEODyWAYGHZgf4ucNE1PY1sodEo=;
        h=From:To:Cc:Subject:Date:From;
        b=TK6nf3T9mceV3RC/afBYFKe4pMEhQ9GmpledAyCN3Fh+zdBGcfksGhqTh4/Ib96FO
         o1q7SMmvJJJmY62Uh/pEyycZA1iejQo4lmI5xelxtQH1xVUiUHX+ykwjvVq6wV23tB
         wOYqjeSy3gfzEV1OtzKQ3ZOAy9VbyyjqESoK2Mck=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A9D960721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        linux@arm.linux.org.uk,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH v2] checkpatch: Check for invalid return codes
Date:   Thu,  5 Jul 2018 14:21:14 -0700
Message-Id: <1530825674-22131-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Negative integer return codes should prefer to use #define -<ERRNO>
values instead of negative numbers. This patch checks if there are any
negative numbers returned. Also, display context so that the user knows
where the return value is incorrect.

http://lkml.org/lkml/2010/7/23/318
  There's lots of "return -1;" statements in this patch - it's obscene
  that this is used to indicate "some error occurred" in kernel space
  rather than a real errno value - even when an existing function
  (eg, request_irq) gave you an error code already.

Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
Changes in v2:
- Edit the descritpion to 'avoid returning any negative integers' rather 
  than saying 'returning anything but 0 is incorrect'
- Use APPROPRIATE_ERRNO instead of NO_ERROR_CODE as type of the message

Changes in v1:
- Use CHK instead of ERROR
- Rephrase the warning message
- Provide the file name and line number where return value is incorrect
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c0550..0f9c717 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6197,6 +6197,12 @@ sub process {
 			     "switch default: should use break\n" . $herectx);
 		}
 
+# check for return codes on error paths
+		if ($line =~ /\breturn\s+-\d+/) {
+			CHK("APPROPRIATE_ERRNO",
+			      "invalid return value, please return -<APPROPRIATE_ERRNO>\n" . $herecurr);
+		}
+
 # check for gcc specific __FUNCTION__
 		if ($line =~ /\b__FUNCTION__\b/) {
 			if (WARN("USE_FUNC",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

