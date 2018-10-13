Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89378C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D3E20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 10:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fcvMg5XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D3E20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJMR46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:56:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51800 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeJMR46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:56:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9DAJ3Dg070493;
        Sat, 13 Oct 2018 10:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=gu2yfU1zGpF68vhPSIh4N/TcMFmZy3/12e6wunWZz0c=;
 b=fcvMg5XWKLVQkyCy7n0mdkwJQdOzfdgt+T7kev9gsQmNrEkkPewCKT005jCaDprNiduD
 9hRLnUDKqH9U6Q9brsXyqB9DLuCG4C5TBHxn5+4nHWnGd6OaCN8ujMkJDGYGbE4oQalt
 AggjJ2X2wsB4eW0stt7EId0wCIy0DjZugiiwc4BhPhOCgHSppW3mpZ3o/1nkRGQkdvWO
 KwvmkLOQnBNmZIfxqVmgl78m+cONNpY2Tky2nPQyzOUAzc3v3e9OLkzgptI6a0N0HABO
 xwV3e+t0FUDPA288BLs8DrPMVrtRS5Docz5byWcUrbHS0Gsk11CB9XhqIiWnEtgdUH00 QA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n38nph71e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Oct 2018 10:19:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9DAJn2l000527
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Oct 2018 10:19:50 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9DAJmJp024104;
        Sat, 13 Oct 2018 10:19:49 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 13 Oct 2018 10:19:48 +0000
Date:   Sat, 13 Oct 2018 13:19:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] perf stat: Potential NULL dereference in print_aggr()
Message-ID: <20181013101940.GA16086@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9044 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810130099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch complains that:

    ./tools/perf/util/stat-display.c:616 print_aggr()
    error: we previously assumed 'config->aggr_map' could be null (see line 607)

Not only that, but it looks like aggr_update_shadow() can Oops if
"config->aggr_get_id" is NULL.  The intent seems to have been to return
if either of these pointers is NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e7b4c44ebb62..db635c01d3a3 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -604,7 +604,7 @@ static void print_aggr(struct perf_stat_config *config,
 	u64 ena, run, val;
 	bool first;
 
-	if (!(config->aggr_map || config->aggr_get_id))
+	if (!config->aggr_map || !config->aggr_get_id)
 		return;
 
 	aggr_update_shadow(config, evlist);
-- 
2.18.0

