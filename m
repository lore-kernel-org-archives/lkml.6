Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17665C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B563F20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B563F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeIGJNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 05:13:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:52696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbeIGJNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 05:13:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8852AD75;
        Fri,  7 Sep 2018 04:33:59 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     john.johansen@canonical.com
Cc:     seth.arnold@canonical.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH] apparmor: Fix network performance issue in aa_label_sk_perm
Date:   Thu,  6 Sep 2018 21:33:57 -0700
Message-Id: <20180907043357.4638-1-tonyj@suse.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The netperf benchmark shows a 5.73% reduction in throughput for 
small (64 byte) transfers by unconfined tasks.

DEFINE_AUDIT_SK() in aa_label_sk_perm() should not be performed 
unconditionally, rather only when the label is confined.

netperf-tcp
                            56974a6fc^              56974a6fc
Min       64         563.48 (   0.00%)      531.17 (  -5.73%)
Min       128       1056.92 (   0.00%)      999.44 (  -5.44%)
Min       256       1945.95 (   0.00%)     1867.97 (  -4.01%)
Min       1024      6761.40 (   0.00%)     6364.23 (  -5.87%)
Min       2048     11110.53 (   0.00%)    10606.20 (  -4.54%)
Min       3312     13692.67 (   0.00%)    13158.41 (  -3.90%)
Min       4096     14926.29 (   0.00%)    14457.46 (  -3.14%)
Min       8192     18399.34 (   0.00%)    18091.65 (  -1.67%)
Min       16384    21384.13 (   0.00%)    21158.05 (  -1.06%)
Hmean     64         564.96 (   0.00%)      534.38 (  -5.41%)
Hmean     128       1064.42 (   0.00%)     1010.12 (  -5.10%)
Hmean     256       1965.85 (   0.00%)     1879.16 (  -4.41%)
Hmean     1024      6839.77 (   0.00%)     6478.70 (  -5.28%)
Hmean     2048     11154.80 (   0.00%)    10671.13 (  -4.34%)
Hmean     3312     13838.12 (   0.00%)    13249.01 (  -4.26%)
Hmean     4096     15009.99 (   0.00%)    14561.36 (  -2.99%)
Hmean     8192     18975.57 (   0.00%)    18326.54 (  -3.42%)
Hmean     16384    21440.44 (   0.00%)    21324.59 (  -0.54%)
Stddev    64           1.24 (   0.00%)        2.85 (-130.64%)
Stddev    128          4.51 (   0.00%)        6.53 ( -44.84%)
Stddev    256         11.67 (   0.00%)        8.50 (  27.16%)
Stddev    1024        48.33 (   0.00%)       75.07 ( -55.34%)
Stddev    2048        54.82 (   0.00%)       65.16 ( -18.86%)
Stddev    3312       153.57 (   0.00%)       56.29 (  63.35%)
Stddev    4096       100.25 (   0.00%)       88.50 (  11.72%)
Stddev    8192       358.13 (   0.00%)      169.99 (  52.54%)
Stddev    16384       43.99 (   0.00%)      141.82 (-222.39%)

Signed-off-by: Tony Jones <tonyj@suse.de>
Fixes: 56974a6fcfef ("apparmor: add base infastructure for socket
mediation")
---
 security/apparmor/net.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index bb24cfa0a164..d5d72dd1ca1f 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -146,17 +146,20 @@ int aa_af_perm(struct aa_label *label, const char *op, u32 request, u16 family,
 static int aa_label_sk_perm(struct aa_label *label, const char *op, u32 request,
 			    struct sock *sk)
 {
-	struct aa_profile *profile;
-	DEFINE_AUDIT_SK(sa, op, sk);
+	int error = 0;
 
 	AA_BUG(!label);
 	AA_BUG(!sk);
 
-	if (unconfined(label))
-		return 0;
+	if (!unconfined(label)) {
+		struct aa_profile *profile;
+		DEFINE_AUDIT_SK(sa, op, sk);
 
-	return fn_for_each_confined(label, profile,
-			aa_profile_af_sk_perm(profile, &sa, request, sk));
+		error = fn_for_each_confined(label, profile,
+			    aa_profile_af_sk_perm(profile, &sa, request, sk));
+	}
+
+	return error;
 }
 
 int aa_sk_perm(const char *op, u32 request, struct sock *sk)
-- 
2.18.0

