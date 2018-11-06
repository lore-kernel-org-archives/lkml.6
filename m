Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CF420827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AsF1ifcu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I3m+zjhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CF420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeKFPeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:34:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57510 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729342AbeKFPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:33:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51DF4602F4; Tue,  6 Nov 2018 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541484624;
        bh=8q51VbeDT1DoNSO7aS5ppssUjiaEFViWFx1QkplxRnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AsF1ifcuUjvffRjZEdj0NrgL7rLjAZdOxvQGtu8ZdhEVWnuWm8Sxgo3hgbtYpYsEF
         FKvG51xA5pY+LQ02Dpkoi9aHzgGCyco5KcKuswu4CpEZ9V0jenwn/5l20zdAy6fgwN
         MI/RfYzRbfJIVpF8jnOpHpUHl4FmgrU7lw4ctl1E=
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B06B605FD;
        Tue,  6 Nov 2018 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541484623;
        bh=8q51VbeDT1DoNSO7aS5ppssUjiaEFViWFx1QkplxRnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3m+zjhjfTIHz/VNcTzb5Fpc4OlaIa2ujR5ewjJYpc6hl/G2iuImIATHiCBkS+CvS
         rDeIg2YCATy13Xg1r2J8XcsMCvS+TgIcA1p2/ZB7gdvxXviZnojIBhmIcbuq/bX4/W
         MN1OlTI4v3eaLZZOUpP+0CRyyBHhlkgZJ0lLuetg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B06B605FD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        chris@chris-wilson.co.uk, jcrouse@codeaurora.org,
        robdclark@gmail.com, linux-kernel@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH 2/3] include/linux/ascii85: Add ascii85_encode_to_buf()
Date:   Tue,  6 Nov 2018 11:40:05 +0530
Message-Id: <1541484606-20813-2-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541484606-20813-1-git-send-email-smasetty@codeaurora.org>
References: <1541484606-20813-1-git-send-email-smasetty@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function which, in addition to ascii85 encoding to buffer
also returns the length of the encoded string. The length return enables
iteration over the output buffer space. This helps with efficient encoding
of larger buffers, since we avoid an additional memcpy/scnprintf.

Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
---
 include/linux/ascii85.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/ascii85.h b/include/linux/ascii85.h
index 4cc4020..3665899 100644
--- a/include/linux/ascii85.h
+++ b/include/linux/ascii85.h
@@ -23,8 +23,12 @@
 {
 	int i;
 
-	if (in == 0)
-		return "z";
+	if (in == 0) {
+		out[0] = 'z';
+		out[1] = '\0';
+
+		return out;
+	}
 
 	out[5] = '\0';
 	for (i = 5; i--; ) {
@@ -35,4 +39,15 @@
 	return out;
 }
 
+static inline size_t
+ascii85_encode_to_buf(u32 in, char *out)
+{
+	ascii85_encode(in, out);
+
+	if (in == 0)
+		return 1;
+
+	return 5;
+}
+
 #endif
-- 
1.9.1

