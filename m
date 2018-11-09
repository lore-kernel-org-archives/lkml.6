Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07E720827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07E720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeKITOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:14:43 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55138 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeKITOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:14:43 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gL3Bp-0000rn-Gg; Fri, 09 Nov 2018 10:34:57 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, akmp@linux-foundation.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] kernel.h: hide __is_constexpr() from sparse
Date:   Fri,  9 Nov 2018 10:34:48 +0100
Message-Id: <20181109093449.15037-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181109093449.15037-1-johannes@sipsolutions.net>
References: <20181109093449.15037-1-johannes@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

__is_constexpr() is a work of art, understandable only to the most
respected wizards of C. Even sparse doesn't seem to belong to that
group and warns that there's an "expression using sizeof(void)".

Just hide the definition from sparse and pretend it's always true.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/kernel.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75b51ba..d4d2233f95c9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -844,6 +844,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #define __typecheck(x, y) \
 		(!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
 
+#ifndef __CHECKER__
 /*
  * This returns a constant expression while determining if an argument is
  * a constant expression, most importantly without evaluating the argument.
@@ -851,6 +852,13 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
  */
 #define __is_constexpr(x) \
 	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+#else
+/*
+ * We don't really care about the check when running sparse and the
+ * above expression causes a warning due to sizeof(void).
+ */
+#define __is_constexpr(x) 1
+#endif
 
 #define __no_side_effects(x, y) \
 		(__is_constexpr(x) && __is_constexpr(y))
-- 
2.17.2

