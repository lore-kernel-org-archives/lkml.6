Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A89C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C1C2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C1C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeKLFyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:54:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbeKLFyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:54:20 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJwsJR074971
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:04:51 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdvs9d51-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:04:50 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:04:50 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:04:44 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABK4hiH26083458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:04:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2945B205F;
        Sun, 11 Nov 2018 20:04:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F57FB2067;
        Sun, 11 Nov 2018 20:04:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:04:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A46E816C5D5F; Sun, 11 Nov 2018 12:04:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lance Roy <ldr709@gmail.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 3/7] smsc: Replace spin_is_locked() with lockdep
Date:   Sun, 11 Nov 2018 12:04:39 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111200421.GA10551@linux.ibm.com>
References: <20181111200421.GA10551@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0068-0000-0000-0000035E49CD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116026; UDB=6.00578736; IPR=6.00896126;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:04:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0069-0000-0000-0000466454C6
Message-Id: <20181111200443.10772-3-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=770 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lance Roy <ldr709@gmail.com>

lockdep_assert_held() is better suited to checking locking requirements,
since it only checks if the current thread holds the lock regardless of
whether someone else does. This is also a step towards possibly removing
spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <netdev@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 drivers/net/ethernet/smsc/smsc911x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.h b/drivers/net/ethernet/smsc/smsc911x.h
index 8d75508acd2b..51b2fc1a395f 100644
--- a/drivers/net/ethernet/smsc/smsc911x.h
+++ b/drivers/net/ethernet/smsc/smsc911x.h
@@ -67,7 +67,7 @@
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define SMSC_ASSERT_MAC_LOCK(pdata) \
-		WARN_ON_SMP(!spin_is_locked(&pdata->mac_lock))
+		lockdep_assert_held(&pdata->mac_lock)
 #else
 #define SMSC_ASSERT_MAC_LOCK(pdata) do {} while (0)
 #endif				/* CONFIG_DEBUG_SPINLOCK */
-- 
2.17.1

