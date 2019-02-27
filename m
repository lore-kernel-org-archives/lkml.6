Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE7B218E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="QChFQyWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfB0IN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:13:26 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:56349 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbfB0INZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:13:25 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 3D4EA219F2;
        Wed, 27 Feb 2019 11:13:22 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id gvbECA5d0a-DLhKaDMa;
        Wed, 27 Feb 2019 11:13:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1551255202; bh=8kFu2wWh3Op+B8NZK/FPFrEnAAthfynrTJBN0YQ9dko=;
        h=Message-ID:Date:To:From:Subject;
        b=QChFQyWQRPml22HfRer0LqfEssiFGUcpS1KWe5R0TIdlZuGFWNRKKj56z9MhhdZXt
         Zd+DrubbdYyyqGmvyngmLnkwfAP4CcG/3cAK5wAtuyqVojB77JYtHHqk4pYxpRMr0x
         cHn31V4Ku8OwHCDGPQQjuQSDXj2R6508Qb/v2HBk=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8865:6f76:e76b:3fab])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 7MJk1IpqI3-DLo8IeCV;
        Wed, 27 Feb 2019 11:13:21 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] sched/core: check format and overflows in cgroup2 cpu.max
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Date:   Wed, 27 Feb 2019 11:13:21 +0300
Message-ID: <155125520155.293746.7017401430432481979.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgroup2 interface for cpu bandwidth limit has some flaws:

- on stack buffer overflow
- no checks for valid format or trailing garbage
- no checks for integer overflows

This patch fixes all these flaws.

Fixes: 0d5936344f30 ("sched: Implement interface for cgroup unified hierarchy")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/sched/core.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5f46aa335b28..123b1910bc2e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6947,19 +6947,34 @@ static int __maybe_unused cpu_period_quota_parse(char *buf,
 						 u64 *periodp, u64 *quotap)
 {
 	char tok[21];	/* U64_MAX */
+	int ret, len;
 
-	if (!sscanf(buf, "%s %llu", tok, periodp))
+	if (sscanf(buf, "%20s %n", tok, &len) != 1)
 		return -EINVAL;
 
-	*periodp *= NSEC_PER_USEC;
-
-	if (sscanf(tok, "%llu", quotap))
-		*quotap *= NSEC_PER_USEC;
-	else if (!strcmp(tok, "max"))
+	ret = kstrtou64(tok, 10, quotap);
+	if (ret) {
+		if (strcmp(tok, "max"))
+			return ret;
 		*quotap = RUNTIME_INF;
-	else
+	} else if (*quotap <= U64_MAX / NSEC_PER_USEC) {
+		*quotap *= NSEC_PER_USEC;
+	} else
 		return -EINVAL;
 
+	buf += len;
+	if (*buf) {
+		if (sscanf(buf, "%20s %n", tok, &len) != 1 || buf[len])
+			return -EINVAL;
+		ret = kstrtou64(tok, 10, periodp);
+		if (ret)
+			return ret;
+		if (*periodp > U64_MAX / NSEC_PER_USEC)
+			return -EINVAL;
+	}
+
+	*periodp *= NSEC_PER_USEC;
+
 	return 0;
 }
 

