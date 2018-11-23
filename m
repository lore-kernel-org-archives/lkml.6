Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE69C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08B3205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kddjSDOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08B3205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503104AbeKWUoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:44:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37796 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388455AbeKWUoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:44:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAN9sHJk161189;
        Fri, 23 Nov 2018 10:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=InOpmewHO9sq3FbRlMgi/DBEt0CSmNIJnWOpgjat4AE=;
 b=kddjSDOmdSAzZ90yfmCZJcFv6tFwHQcKIEC1JzyVFYMQf/B2ZeQaiOCGdCGlInt/clxe
 JhQRHwhGtPeRA2fQLbCbzRyXsXSO/BjD4RMXU7a9RsaOqssTc8dybIzf9AqZYSrkeScV
 Lxbrgmj8LnByhFa9+ybvJWrd8DkMSFF/nlxtd7juvk6nCXDcIT29B35kB8vbnbNyRpxb
 hqiIY/ppF4mS9rF0XxH3aNNJD8h1cfYoBeiIf/iG8dRXaf2q5IHOEBbEUQrIm0P51ji8
 D9vBS5yzEzREXdJBBbSJ5jhsWvH3EuEHt5x00X9Ejl7puAI2pnfL6IbU17Pqq+ZxvqI0 vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ntadua70h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Nov 2018 10:00:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wANA01UG003212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Nov 2018 10:00:01 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wANA00pJ010272;
        Fri, 23 Nov 2018 10:00:00 GMT
Received: from ca-dev-arm44.us.oracle.com (/10.211.8.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Nov 2018 02:00:00 -0800
From:   Eric Saint-Etienne <eric.saint.etienne@oracle.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.co>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: [PATCH] perf symbols: Cannot disassemble some routines when debuginfo present
Date:   Fri, 23 Nov 2018 02:25:26 -0800
Message-Id: <1542968726-20910-1-git-send-email-eric.saint.etienne@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9085 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811230079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is compiled with -ffunction-sections and perf uses the
kernel debuginfo, perf fails the very first symbol lookup and ends up with
an hex offset inside [kernel.vmlinux]. It's due to how perf loads the maps.

Indeed only .text gets loaded by map_groups__find() into al->map.
Consequently al->map address range encompass the whole code.
But map__load() has just loaded many function maps by splitting al->map,
which reduced al->map range drastically. Very likely the target address is
now in one of those newly created function maps, so we need to lookup the
map again to find that new map.

This issue is not specific to the kernel but to how the image is linked.
For the kernel, when we're not using the kernel debuginfo, perf will
fallback to using kallsyms and then the first lookup will work.

This patch makes sure that the event address we're looking-up is indeed
within the map we've found, otherwise we lookup another map again.
Only one extra lookup at most is required for the proper map to be found,
if it exists.

Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tools/perf/util/event.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e9c108a..a69ef52 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1571,7 +1571,28 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		 */
 		if (load_map)
 			map__load(al->map);
-		al->addr = al->map->map_ip(al->map, al->addr);
+
+		/*
+		 * When using -ffunction-sections, only .text gets loaded by
+		 * map_groups__find() into al->map. Consequently al->map address
+		 * range encompass the whole code.
+		 *
+		 * But map__load() has just loaded many function maps by
+		 * splitting al->map, which reduced al->map range drastically.
+		 * Very likely the target address is now in one of those newly
+		 * created function maps, so we need to lookup the map again
+		 * to find that new map.
+		 */
+		if (al->addr < al->map->start || al->addr >= al->map->end)
+			al->map = map_groups__find(mg, al->addr);
+
+		/*
+		 * The new map *ought* to exist because the initial al->map
+		 * contained that address and subsequently has been split into
+		 * many *contiguous* maps.
+		 */
+		if (al->map != NULL)
+			al->addr = al->map->map_ip(al->map, al->addr);
 	}
 
 	return al->map;
-- 
1.8.3.1

