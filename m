Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B7BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2092D21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="ko95gvjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfBGMfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:35:17 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:58548 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:35:15 -0500
Received: from hatter.bewilderbeest.net (hatter.bewilderbeest.net [IPv6:2001:470:c3f4:1::1:1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 32DD280538;
        Thu,  7 Feb 2019 04:35:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net 32DD280538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1549542915;
        bh=WOacmMoSdbkCtFHgv8WIILsxSz4lEwJeayXiBWZmFac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ko95gvjtL+WExABkqoG5S7pJyi2E7JkXUOpAzK7GWWQ7OXKaJD079vI1iI8c08OId
         bA4oJiPfA6JoBGVtFGpSvLPaSUKwk2SjcABmmnEMYHPiBD/ByFlBAeICW93nWXkbhw
         iZCmP5FCyiFiSrxbBaTwo+Di6a3rmDxTJ5y4fL1Q=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, yzaikin@google.com,
        brendanhiggins@google.com, Zev Weiss <zev@bewilderbeest.net>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/3] kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_conv
Date:   Thu,  7 Feb 2019 06:34:25 -0600
Message-Id: <20190207123426.9202-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207123426.9202-1-zev@bewilderbeest.net>
References: <20190206195807.GG11489@garbanzo.do-not-panic.com>
 <20190207123426.9202-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug has apparently existed since the introduction of this function
in the pre-git era (4500e91754d3 in Thomas Gleixner's history.git,
"[NET]: Add proc_dointvec_userhz_jiffies, use it for proper handling of
neighbour sysctls.").  As a minimal fix we can simply duplicate the
corresponding check in do_proc_dointvec_conv().

Cc: <stable@vger.kernel.org> # v2.6.2+
Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 kernel/sysctl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5fc724e4e454..a71c4b3935bc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2564,7 +2564,16 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 {
 	struct do_proc_dointvec_minmax_conv_param *param = data;
 	if (write) {
-		int val = *negp ? -*lvalp : *lvalp;
+		int val;
+		if (*negp) {
+			if (*lvalp > (unsigned long) INT_MAX + 1)
+				return -EINVAL;
+			val = -*lvalp;
+		} else {
+			if (*lvalp > (unsigned long) INT_MAX)
+				return -EINVAL;
+			val = *lvalp;
+		}
 		if ((param->min && *param->min > val) ||
 		    (param->max && *param->max < val))
 			return -EINVAL;
-- 
2.20.1

