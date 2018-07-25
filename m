Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA46BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6260B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zt7mueYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6260B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbeGYVNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:13:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44526 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbeGYVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:13:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6PJroSO017309;
        Wed, 25 Jul 2018 20:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=AypZRqBE10d6f4VNvTjPawXW0HUJGuDu29fPrxF5Emo=;
 b=zt7mueYJKWJ92eFNeFvR6uO3a+vjjtRkYAO364EocgxeSYlMXYf+cUEfXB7BvUXTUYRW
 stbyJDH+eq7Dz7KIPkM7ZfAWh0zY79DV57Q7bSiA+mSdgim6QnmcyGszi6YZ48DXyCXR
 QiSidCvdWxodlVJEYLqXHyeLfUc6qQKSNB/2jiuqYCv63nuPQ2rhVp9fBW2vmvrzdR8W
 r4qFw2teC1jUiYUL9R+NzYM2Q8XdHbyXG0VQamj5GeQuYoaL3peQNJ9xPoIY+0yxc5bf
 Zv45IwmTtFQiAxGXeBzLi/8mHr456IjZiN8A8NGuupjx+s51xbcslwg/chb8TCO13CPi IA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2kbtbcy5hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 20:00:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6PK0OnT020586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 20:00:25 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6PK0Opo007685;
        Wed, 25 Jul 2018 20:00:24 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Jul 2018 13:00:24 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        sboyd@kernel.org, pasha.tatashin@oracle.com, john.stultz@linaro.org
Subject: [PATCH] timekeeping: warning when persistent clock is not available
Date:   Wed, 25 Jul 2018 16:00:18 -0400
Message-Id: <20180725200018.23722-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=722
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arches with no persistent clock a message like this is printed during
boot:

[    0.000000] Persistent clock returned invalid value

The value is not invalid: it simply zero meaning no persistent clock and
the absence of persistent clock should be quietly accepted.

Fixes: 3eca993740b8 ("timekeeping: Replace read_boot_clock64() with read_persistent_wall_and_boot_offset()")

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index edf5da78a449..f3b22f456fac 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1557,7 +1557,7 @@ void __init timekeeping_init(void)
 	if (timespec64_valid_strict(&wall_time) &&
 	    timespec64_to_ns(&wall_time) > 0) {
 		persistent_clock_exists = true;
-	} else {
+	} else if (timespec64_to_ns(&wall_time) != 0) {
 		pr_warn("Persistent clock returned invalid value");
 		wall_time = (struct timespec64){0};
 	}
-- 
2.18.0

