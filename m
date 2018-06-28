Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA1DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE14F277D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jgl5cz0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE14F277D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936137AbeF1Wn4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:43:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47382 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934442AbeF1Wnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:43:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5SMd6PN035421;
        Thu, 28 Jun 2018 22:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=ku8xBGZiCyWmNDUzv4ayAt5Rwiea3p9IL20jGtX8myM=;
 b=jgl5cz0nyytX5kSIdh3DgxE9nIZKewoXEHZIbt7yQNekZh3V42tDi+Mcpr2/cqDnCmGg
 Pymu2i521ZzaAM+hrzWwW/bUS1qrN2hxUhq9EhIJog9v0Xo7gj6DNZINgfKQ6BtYTc1I
 bYmxhqGi81KMZU4khgc60k5cdVUVWBGWBAk7LwOVI7Wss7s/QD8d5DzVW4W3Kt8tJAET
 St1NsDZro80g3G45b4/Y06zUhyTPH3Qd+vJYkSJGAcT5POszs6F1G6l12ipwEh4nfQMa
 Sfesy+T2AoYDdPexsMuiNF7AVpqAbJJH1TNkxKBa3rkpUX00pYcA6pB7IyzjOHPnvixd jw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jum5844yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 22:43:23 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5SMhNll012759
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jun 2018 22:43:23 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5SMhM7R023369;
        Thu, 28 Jun 2018 22:43:22 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 15:43:22 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.lezcano@linaro.org
Subject: [PATCH 4/5] sched: add sched feature to disable idle core search
Date:   Thu, 28 Jun 2018 15:44:55 -0700
Message-Id: <20180628224456.13548-5-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180628224456.13548-1-subhra.mazumdar@oracle.com>
References: <20180628224456.13548-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=920
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280249
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

