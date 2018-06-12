Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F1A6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532B520660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uXTne7Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532B520660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934319AbeFLRsp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:48:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54054 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934018AbeFLRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:48:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CHjvq3139741;
        Tue, 12 Jun 2018 17:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=ku8xBGZiCyWmNDUzv4ayAt5Rwiea3p9IL20jGtX8myM=;
 b=uXTne7WgYCcuFsRVZT+g36E/GtcHIbxHcZKP0R+5DuVH0KlwCReO0jtWHec1elEAtsMe
 EHQ6/xuCJ2ro+mf6l57p5SWZJ2h8+ClYynH8cxpwiRiyrs6HGIRWLqGK2VbePfcCdC8a
 FvjiGRZuRBVAN/HivfowF7Yn3qqgVY0/RLNNotckCXKWMyboBdzTQ2DwfZlULSiIGAUN
 CK9femQZcP1MvNSteqEVgKPIV6MdgxDGtMMUKlWvZUT5ccBO8B79Xt1sWElYar86YoiE
 KRwnf0KDf5aLo0fJYZIHaNjKxKqbdGw7nK0MA1IMrDggyHI4rCM9M730vdxCcwcyTSJE /g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jgecxjbfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:08 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5CHm7fQ023509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 17:48:08 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CHm72a006226;
        Tue, 12 Jun 2018 17:48:07 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 10:48:07 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
Subject: [PATCH 4/5] sched: add sched feature to disable idle core search
Date:   Tue, 12 Jun 2018 10:50:01 -0700
Message-Id: <20180612175002.31453-5-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
References: <20180612175002.31453-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=927
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sched feature SIS_CORE to have an option to disable idle core
search (select_idle_core).

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/features.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 85ae848..de15733 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -57,6 +57,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_AVG_CPU, false)
 SCHED_FEAT(SIS_PROP, true)
+SCHED_FEAT(SIS_CORE, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
-- 
2.9.3

