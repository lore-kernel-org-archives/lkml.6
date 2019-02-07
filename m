Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF1BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBD921904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="XXMrKgMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfBGQvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:51:49 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:57661 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:51:49 -0500
Received: from hatter.bewilderbeest.net (hatter.bewilderbeest.net [IPv6:2001:470:c3f4:1::1:1])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BFBE280536;
        Thu,  7 Feb 2019 08:51:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net BFBE280536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1549558308;
        bh=xVX06y1LKMu5NfBzZAvl9SlvAUxKIpLVfzCNS4mE4yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXMrKgMk5s8AyMx+u0QV5fkthiN8FFUg7VhP1O6yy/6rQN2vYr4m2gqYOT0+vJ/Ca
         HTmq5qpZ3D8DD7naFBvVVNtMImDFJQnMEGTUhgLT3OFk9nptCXut8Lq1CaA/iQVkV1
         r6zPq+hwKrTnhSveGOipa9YG4OJ0k2RjuO+RS6nk=
Date:   Thu, 7 Feb 2019 10:51:38 -0600
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, yzaikin@google.com,
        brendanhiggins@google.com, Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH v2 3/3] kernel/sysctl.c: define minmax conv functions in
 terms of non-minmax versions
Message-ID: <20190207165138.5oud57vq4ozwb4kh@hatter.bewilderbeest.net>
References: <20190206195807.GG11489@garbanzo.do-not-panic.com>
 <20190207123426.9202-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207123426.9202-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.20.1
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_proc_do[u]intvec_minmax_conv() had included open-coded versions of
do_proc_do[u]intvec_conv(); the duplication led to buggy inconsistencies
(missing range checks).  To reduce the likelihood of such problems in
the future, we can instead refactor both to be defined in terms of their
non-bounded counterparts (plus the added check).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
  kernel/sysctl.c | 59 ++++++++++++++++++++++---------------------------
  1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a71c4b3935bc..4b6bce36737e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2562,32 +2562,26 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
  					int *valp,
  					int write, void *data)
  {
+	int tmp, ret;
  	struct do_proc_dointvec_minmax_conv_param *param = data;
+
+	/*
+	 * If writing, first do so via a temporary local int so we can
+	 * bounds-check it before touching *valp.
+	 */
+	int *ip = write ? &tmp : valp;
+
+	ret = do_proc_dointvec_conv(negp, lvalp, ip, write, data);
+	if (ret)
+		return ret;
+
  	if (write) {
-		int val;
-		if (*negp) {
-			if (*lvalp > (unsigned long) INT_MAX + 1)
-				return -EINVAL;
-			val = -*lvalp;
-		} else {
-			if (*lvalp > (unsigned long) INT_MAX)
-				return -EINVAL;
-			val = *lvalp;
-		}
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
  
@@ -2636,22 +2630,23 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
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

