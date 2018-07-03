Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A540FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9CF20849
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cW/wQPTs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QTcGJMY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9CF20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeGCXmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:42:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46614 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeGCXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:42:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E44E60B19; Tue,  3 Jul 2018 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530661327;
        bh=+ys1m+dBbM6TyCUtxKUQye6tNlkZiGjWtkhhfk6rI/c=;
        h=From:To:Cc:Subject:Date:From;
        b=cW/wQPTsDRRw5JjU7JjOp6Mr53sURjFFt7pDP0CRAcJEV/H//uGoqQEJ4PJ5RCkKN
         QDxYsYHfmkOjNFZkxRWb8h5hA4+ZpI6RplTFEpwJvUAQN/jMEAX9lKZMNf+wWM2SpV
         ekGgLvl2FAtnI+PM0HW1r5P+P/eUEU9V2RkzA8zc=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A3CA6028D;
        Tue,  3 Jul 2018 23:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530661326;
        bh=+ys1m+dBbM6TyCUtxKUQye6tNlkZiGjWtkhhfk6rI/c=;
        h=From:To:Cc:Subject:Date:From;
        b=QTcGJMY1JnpzAnt1OMEpsCzxw7+D9HBe1DGVc5/RgLV34BvG+LLLzzjVHEPKCY8z9
         xMguu4FJjZVzNaTonTwjpjcDrCB4EOWAioJsfm8mrQq8V8cHKH43dOW8h/VJYipwJW
         y4UM53i2ccgMDVFAAPf3WpPJno8mt/LV8OuZfZOs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A3CA6028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        bryanh@codeaurora.org, tsoni@codeaurora.org,
        Patrick Pannuto <ppannuto@codeaurora.org>,
        Stepan Moskovchenko <stepanm@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH v1] checkpatch: Check for invalid return codes
Date:   Tue,  3 Jul 2018 16:41:45 -0700
Message-Id: <1530661305-11959-1-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only valid integer return is 0, anything else
following "return" should be -ERRCODE or a function. Also, display context
so that the user knows where the return value is incorrect.

http://lkml.org/lkml/2010/7/23/318
  There's lots of "return -1;" statements in this patch - it's obscene
  that this is used to indicate "some error occurred" in kernel space
  rather than a real errno value - even when an existing function
  (eg, request_irq) gave you an error code already.

Signed-off-by: Patrick Pannuto <ppannuto@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
Changes in v1:
- Use CHK instead of ERROR
- Rephrase the warning message
- Provide the file name and line number where return value is incorrect

 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a9c0550..2808c27 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6197,6 +6197,12 @@ sub process {
 			     "switch default: should use break\n" . $herectx);
 		}
 
+# check for return codes on error paths
+		if ($line =~ /\breturn\s+-\d+/) {
+			CHK("NO_ERROR_CODE",
+			      "invalid return value, please return -<APPROPRIATE_ERRNO>\n" . $herecurr);
+		}
+
 # check for gcc specific __FUNCTION__
 		if ($line =~ /\b__FUNCTION__\b/) {
 			if (WARN("USE_FUNC",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

