Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40B8C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574D02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWOcfZXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574D02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeLLQL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:11:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44616 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:11:55 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBCG8fsr024383;
        Wed, 12 Dec 2018 16:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=DW9VeCS9m7xK1iYiYvI1x1ygw0o6VPEx7tDz3mc6kYg=;
 b=cWOcfZXmQZE1LJW2nFgwlTJmBj4z5yA2xFsFxqkCGPEZDh9gFgv9zTKY03SMJQCrqHUh
 j5mrhnoMKIdXvk85bsMQ2k8ABe/ISriTtF/E2JJvI4qsp4Ng2dDB2vSNwqz+OJooCctP
 5WxhWAmFyH8q8gVhmL7PYulVipFyoxDLqjF+H1l5fnQZEJcP7EyiVo58BKQ83TLUTCn4
 O0AwGGBzdCkkkeV5CJuoS8ZRLR0mzmhNEKGk5rVYzAJBfwYOGUdy1l/SWSGUSSKkkt0q
 KTPaY7+faV1ATBVbPWEI2sis3qxIJ2hQhfxrwX2hyOgQF0Rw0ABO8+7lX2SUfP6aynM4 oQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2pawwp2qdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 16:11:26 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBCGBO28032622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 16:11:25 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBCGBNOG021089;
        Wed, 12 Dec 2018 16:11:23 GMT
Received: from ca-dev-arm44.us.oracle.com (/10.211.8.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 08:11:23 -0800
From:   Eric Saint-Etienne <eric.saint.etienne@oracle.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: [PATCH UEK5] perf symbols: Cannot disassemble some routines when debuginfo present
Date:   Wed, 12 Dec 2018 08:39:01 -0800
Message-Id: <1544632741-5556-1-git-send-email-eric.saint.etienne@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9104 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=910
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is compiled with -ffunction-sections and perf uses the kernel
debuginfo, perf fails the very first symbol lookup and ends up with an offset
in [kernel.vmlinux]. It's due to how perf loads the .text map first then loads
the other maps in the kernel debuginfo image.

This issue is specific to the debuginfo when using -ffunction-sections and it
doesn't happen with kallsyms because there's not multiple stages of loading
/proc/kallsyms.

This patch makes sure that the event address we're looking up is indeed within
the map we've found, otherwise we look another map up again. Only one extra
lookup at most is required for the proper map to be found, if it exists.

Orabug: 28543586

Reviewed-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
---
 tools/perf/util/event.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fc690fe..1fbbaf1 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1447,6 +1447,19 @@ void thread__find_addr_map(struct thread *thread, u8 cpumode,
 		 */
 		if (load_map)
 			map__load(al->map);
+
+ 		/*
+		 * Sometimes we find the wrong map: one whose end address is
+		 * ~0ULL, in particular when map__load() set a proper end
+		 * address for the map we're considering.
+		 *
+		 * So we make sure that it's actually the right map that we've
+		 * found, and if not, we try again and within at most one
+		 * attempt we'll get the right map, if it exists.
+		 */
+		if (al->addr < al->map->start || al->addr >= al->map->end)
+			goto try_again;
+
 		al->addr = al->map->map_ip(al->map, al->addr);
 	}
 }
-- 
1.8.3.1

