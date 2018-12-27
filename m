Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA4218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="fZWrTJBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbeL0LT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:19:27 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:41796 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbeL0LT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:19:26 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Dec 2018 06:19:26 EST
Received: from hatter.bewilderbeest.net (hatter.bewilderbeest.net [IPv6:2001:470:c3f4:1::1:1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 752F680535;
        Thu, 27 Dec 2018 03:13:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net 752F680535
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1545909232;
        bh=gWq089DtpuWYsmHQ7Id1gtor1jZkWB/dGshv8w5ykwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZWrTJBYio7h6LHaTfsXIhsF0SVhiH0XpLa0vuxP6nzbJF4lY0/Iv0b3RNGmZtrwO
         rMGsFjZUq5O413HwJDgiZE4Khb7CGYIims2N5S/3Meee+2kLfy5fXs4bTia38XCepK
         S9LvkomWYzLSwJrBhbfHElpfrX3SLBEuxPx5B6g8=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH 2/2] kernel/sysctl.c: define minmax conv functions in terms of non-minmax versions
Date:   Thu, 27 Dec 2018 05:12:30 -0600
Message-Id: <20181227111231.12912-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181227111231.12912-1-zev@bewilderbeest.net>
References: <20181227111231.12912-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_proc_do[u]intvec_minmax_conv() had included open-coded versions of
do_proc_do[u]intvec_conv(), though the signed one omitted the check
that the value is in [INT_MIN, INT_MAX].  Rather than increase the
duplication further by copying the additional check, we can instead
refactor both to be defined in terms of their non-bounded counterparts
(plus the added check).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 kernel/sysctl.c | 50 ++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5fc724e4e454..4a0261d32401 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2562,23 +2562,26 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 					int *valp,
 					int write, void *data)
 {
+	int tmp, ret;
 	struct do_proc_dointvec_minmax_conv_param *param = data;
+
+	/*
+	 * First write to a temporary local int so we can bounds-check it
+	 * before touching *valp.
+	 */
+	int *ip = write ? &tmp : valp;
+
+	ret = do_proc_dointvec_conv(negp, lvalp, ip, write, data);
+	if (ret)
+		return ret;
+
 	if (write) {
-		int val = *negp ? -*lvalp : *lvalp;
-		if ((param->min && *param->min > val) ||
-		    (param->max && *param->max < val))
+		if ((param->min && *param->min > tmp) ||
+		    (param->max && *param->max < tmp))
 			return -EINVAL;
-		*valp = val;
-	} else {
-		int val = *valp;
-		if (val < 0) {
-			*negp = true;
-			*lvalp = -(unsigned long)val;
-		} else {
-			*negp = false;
-			*lvalp = (unsigned long)val;
-		}
+		*valp = tmp;
 	}
+
 	return 0;
 }
 
@@ -2627,22 +2630,23 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 					 unsigned int *valp,
 					 int write, void *data)
 {
+	int ret;
+	unsigned int tmp;
 	struct do_proc_douintvec_minmax_conv_param *param = data;
 
-	if (write) {
-		unsigned int val = *lvalp;
+	/* write via temporary local uint for bounds-checking */
+	unsigned int *up = write ? &tmp : valp;
 
-		if (*lvalp > UINT_MAX)
-			return -EINVAL;
+	ret = do_proc_douintvec_conv(lvalp, up, write, data);
+	if (ret)
+		return ret;
 
-		if ((param->min && *param->min > val) ||
-		    (param->max && *param->max < val))
+	if (write) {
+		if ((param->min && *param->min > tmp) ||
+		    (param->max && *param->max < tmp))
 			return -ERANGE;
 
-		*valp = val;
-	} else {
-		unsigned int val = *valp;
-		*lvalp = (unsigned long) val;
+		*valp = tmp;
 	}
 
 	return 0;
-- 
2.20.1

