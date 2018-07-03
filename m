Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965F7C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFBD24687
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lmxoagvr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lmxoagvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFBD24687
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934455AbeGCSJr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:09:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35424 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934195AbeGCSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:09:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C4BBA601CF; Tue,  3 Jul 2018 18:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530641385;
        bh=rL/ljN7umr3/KHvvo68viD/g72BeW6syn82xZpqQG9M=;
        h=From:To:Cc:Subject:Date:From;
        b=Lmxoagvr7vtbxrzrGXgBOCRAaXr4dUZ34QyvJX0out7ygoKCnY0xZhxPCspjLmfiW
         T5gBb1+SEjAclf9beGTWfwDAc4rDgjqDxVXO6co6OrWT215XCC+13mTr8Pm5iIzXyj
         rP4c3N/VeWK8lhnnABnQe6eHlaOWYI/PpyMnKMnQ=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C856960249;
        Tue,  3 Jul 2018 18:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530641385;
        bh=rL/ljN7umr3/KHvvo68viD/g72BeW6syn82xZpqQG9M=;
        h=From:To:Cc:Subject:Date:From;
        b=Lmxoagvr7vtbxrzrGXgBOCRAaXr4dUZ34QyvJX0out7ygoKCnY0xZhxPCspjLmfiW
         T5gBb1+SEjAclf9beGTWfwDAc4rDgjqDxVXO6co6OrWT215XCC+13mTr8Pm5iIzXyj
         rP4c3N/VeWK8lhnnABnQe6eHlaOWYI/PpyMnKMnQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C856960249
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Patrick Pannuto <ppannuto@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH] checkpatch: Check for illegal return codes
Date:   Tue,  3 Jul 2018 11:09:29 -0700
Message-Id: <1530641369-31098-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only legal integer return is 0, anything else
following "return" should be -ERRCODE or a function.

http://lkml.org/lkml/2010/7/23/318
  There's lots of "return -1;" statements in this patch - it's obscene
  that this is used to indicate "some error occurred" in kernel space
  rather than a real errno value - even when an existing function
  (eg, request_irq) gave you an error code already.

Signed-off-by: Patrick Pannuto <ppannuto@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c0550..260d252 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6197,6 +6197,12 @@ sub process {
 			     "switch default: should use break\n" . $herectx);
 		}
 
+# check for return codes on error paths
+		if ($line =~ /\breturn\s+-\d+/) {
+			ERROR("NO_ERROR_CODE",
+			      "illegal return value, please use an error code");
+		}
+
 # check for gcc specific __FUNCTION__
 		if ($line =~ /\b__FUNCTION__\b/) {
 			if (WARN("USE_FUNC",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

