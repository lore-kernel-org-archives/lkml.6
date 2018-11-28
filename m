Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96596C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554282081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VloKSpub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554282081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeK2DMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:12:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48496 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2DMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:12:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wASG9H21192841;
        Wed, 28 Nov 2018 16:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=HIIkZr31oEk2TrTQTa6H9fLt9liRixVmqY18y4r8FsM=;
 b=VloKSpubsDr+czfHF1K0ewvsTW1Oz3/lCrcJpXeIqpP6WqUyf/O1dFuWz2qAe3qqHPzI
 JJ/+blJd5Y4NXlBpAfLvaYhJJQ678bgntOxRhpiv6deRtcRNi7HVIl5Q8e/xmfg4hGb5
 NO1OVoBFmU3G1DDX1g/eYYoQeby89IJ2E8UEUNCY/EsQEph8EUKK6RrgC++glmcIpIpf
 qUdc8vZEZ0malPtaGC08361VT7EAWsm0d1br1OBW7ZOxyT+ggn72EEGQa8m1tyim7NNj
 COwoDSnSEaSwvQS3D7aQJgutiYY43gaConxEtefs0HOmbd3suZJhxaB0RldqyUKPc0rn dw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nxy9rb4gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 16:10:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wASGA4UD000609
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 16:10:05 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wASGA4Je023052;
        Wed, 28 Nov 2018 16:10:04 GMT
Received: from ca-dev-arm44.us.oracle.com (/10.211.8.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 08:10:04 -0800
From:   Eric Saint-Etienne <eric.saint.etienne@oracle.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: [PATCH v3] perf symbols: Cannot disassemble some routines when debuginfo present
Date:   Wed, 28 Nov 2018 08:35:34 -0800
Message-Id: <1543422934-1228-1-git-send-email-eric.saint.etienne@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280142
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
 tools/perf/util/event.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e9c108a..f7cad1a 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1569,9 +1569,58 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
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
+			    al->addr >= al->map->end) {
+				al->map = map_groups__find(mg, al->addr);
+
+				/*
+				 * map_groups__find() should always find a map
+				 * because the target address was initially
+				 * found in .text which got split by map__load()
+				 * *WITHOUT INTRODUCING ANY GAP*
+				 */
+				WARN_ONCE(al->map == NULL,
+					  "map__load created unexpected gaps!");
+			}
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

