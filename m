Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F08C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BF9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NphKfWPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BF9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeK1Vot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:44:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53106 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeK1Vot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:44:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wASAdb97110122;
        Wed, 28 Nov 2018 10:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=JMFQMXzSIZjHqboz3NrICNq/xNAz1lgO+DAw1lScLtg=;
 b=NphKfWPjfYOT+4Q7ewzeLTZgFoJuz9aZyC8s1KeCxi4Tw4JsZ0KWRPp1DsAiLw930My7
 XLKz6j6JOy+wCHrTDk++nwaH3JM1UFSltx/RrsAX8ZrDD81ofaPaxJm7kYZ9FmwA3HLp
 U3n/huz4v6i5WtBHEjTiOaeLWHSJv1INumJ+mE5dzFpOJGhBpEfVlifApggEs4XC9LSV
 IXKffCfcfQHpyYIeesYtQXCKsHPYGICKefafZ2sjT3ThIsP0HgyxvNTsMV+TR5KYQrPu
 6JMr7yb5kmqMFCePUuPNiIvcsbGbFIE3XRTdKPZfIcsoAb3dBmp8wUsatpF+K4iRH3A1 tA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nxy9r9deb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 10:43:11 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wASAh6WH032407
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 10:43:06 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wASAh4m2011351;
        Wed, 28 Nov 2018 10:43:04 GMT
Received: from ca-dev-arm44.us.oracle.com (/10.211.8.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 02:43:04 -0800
From:   Eric Saint-Etienne <eric.saint.etienne@oracle.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.co>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: [PATCH v2] perf symbols: Cannot disassemble some routines when debuginfo present
Date:   Wed, 28 Nov 2018 03:08:32 -0800
Message-Id: <1543403312-26687-1-git-send-email-eric.saint.etienne@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is compiled with -ffunction-sections and perf uses the
kernel debuginfo, perf fails the very first symbol lookup and ends up with
an hex offset inside [kernel.vmlinux]. It's due to how perf loads the maps.

Indeed only .text gets loaded by map_groups__find() into al->map.
Consequently al->map address range encompass the whole kernel image.
But then map__load() loads many function maps by splitting al->map,
which reduces al->map range drastically. Very likely the target address is
then in one of those newly created function maps, so we need to lookup the
map again to find that new map.

I'm not sure if this issue is only specific to the kernel but at least it
occurs withe the kernel dso, and when we're not using the kernel debuginfo,
perf will fallback to using kallsyms and then the first lookup will work.

The split of .text section happens in dso_process_kernel_symbol() where we
call map_groups__find_by_name() to find an existing map, but with
-ffunction-sections and a symbol belonging to a new (function) map, such
map doesn't exist yet so we end up creating one and adjusting existing maps
accordingly because adjust_kernel_syms is set there.

This patch makes sure that the event address we're looking-up is indeed
within the map we've found, otherwise we lookup another map again.
Only one extra lookup at most is required for the proper map to be found,
if it exists.

Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tools/perf/util/event.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e9c108a..be333a9 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1569,9 +1569,54 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		 * Kernel maps might be changed when loading symbols so loading
 		 * must be done prior to using kernel maps.
 		 */
-		if (load_map)
+		if (load_map) {
+			/*
+			 * Note when using -ffunction-sections on the kernel:
+			 *
+			 * Only .text got loaded into al->map at this point.
+			 * Consequently al->map address range encompass the
+			 * whole image.
+			 *
+			 * map__load() will split this map into many function
+			 * maps by shrinking al->map accordingly.
+			 *
+			 * The split happens in dso_process_kernel_symbol()
+			 * where we call map_groups__find_by_name() to find an
+			 * existing map, but with -ffunction-sections and a
+			 * symbol belonging to a new (function) map, such map
+			 * doesn't exist yet so we end up creating one and
+			 * adjusting existing maps accordingly because
+			 * adjust_kernel_syms is set there.
+			 */
+
 			map__load(al->map);
-		al->addr = al->map->map_ip(al->map, al->addr);
+
+			/*
+			 * Note when using -ffunction-sections on the kernel:
+			 *
+			 * Very likely the target address will now be in one of
+			 * the newly created function maps but al->map still
+			 * points to .text which has been drastically shrank by
+			 * the split done in map__load()
+			 */
+			if (al->addr < al->map->start ||
+			    al->addr >= al->map->end)
+				al->map = map_groups__find(mg, al->addr);
+
+			/*
+			 * map_groups__find() should always find a map because
+			 * the target address was initially found in .text which
+			 * got split *without introducing gaps* by map__load()
+			 */
+		}
+
+		/*
+		 * In case the later call to map_groups__find() didn't find a
+		 * suitable map (it should always, but better be safe) we make
+		 * sure that al->map is still valid before deferencing it.
+		 */
+		if (al->map != NULL)
+			al->addr = al->map->map_ip(al->map, al->addr);
 	}
 
 	return al->map;
-- 
1.8.3.1

