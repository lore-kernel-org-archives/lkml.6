Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A9EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC1A23FF8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IiNl/6ik";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IiNl/6ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC1A23FF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753785AbeGEVtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:49:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34152 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbeGEVta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:49:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CC93460251; Thu,  5 Jul 2018 21:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530827369;
        bh=3MiJ/T1V8cJdhyV/qedU4estdCBgqNeAiQ5rF4xTxkk=;
        h=From:To:Cc:Subject:Date:From;
        b=IiNl/6ik5UY8EUKZwvvI0kjxYry3atR9X17/PpLBNmAUaBYXR/Wlq4mo1xiq56igp
         0hdJBeb/aq8uWL7ekT4cUzErKBl9IzyOgImuSAiSiYWEWdZRs3jpfi9hSDfjNCZ6+5
         6wcx06PPIt/Zkj4z3qPd/L7D/YSBY6wv0mr3TkXw=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4AD960251;
        Thu,  5 Jul 2018 21:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530827369;
        bh=3MiJ/T1V8cJdhyV/qedU4estdCBgqNeAiQ5rF4xTxkk=;
        h=From:To:Cc:Subject:Date:From;
        b=IiNl/6ik5UY8EUKZwvvI0kjxYry3atR9X17/PpLBNmAUaBYXR/Wlq4mo1xiq56igp
         0hdJBeb/aq8uWL7ekT4cUzErKBl9IzyOgImuSAiSiYWEWdZRs3jpfi9hSDfjNCZ6+5
         6wcx06PPIt/Zkj4z3qPd/L7D/YSBY6wv0mr3TkXw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4AD960251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH] checkpatch: forbid filesystem accesses from within the kernel
Date:   Thu,  5 Jul 2018 14:47:50 -0700
Message-Id: <1530827270-19947-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As use of sys_open/close/read/write system calls from within the kernel 
code is inappropriate, an error is triggered if used.

Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c0550..e6e7e09 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5372,6 +5372,13 @@ sub process {
 			     "Avoid line continuations in quoted strings\n" . $herecurr);
 		}
 
+# sys_open/read/write/close are not allowed in the kernel
+		if ($line =~ /\b(sys_(?:open|read|write|close))\b/) {
+			ERROR("FILE_OPS",
+			      "$1 is inappropriate in kernel code.\n" .
+			      $herecurr);
+		}
+
 # warn about #if 0
 		if ($line =~ /^.\s*\#\s*if\s+0\b/) {
 			CHK("REDUNDANT_CODE",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

