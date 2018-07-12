Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BA721471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3aVISO+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BA721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbeGLANO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:13:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35432 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390917AbeGLANJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:13:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C04hIo186080;
        Thu, 12 Jul 2018 00:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=u9xkzVrGLcSIP1S5upihsE8ORFj1GIa4knBRLdaeXvE=;
 b=3aVISO+Kd4LiYp1RUe+Gw0yao5XyHvVk2JfE3h+8nLzqKoBlqSecqhNebaL5mBnUoda6
 mPoTw1ub1VpgWfiBHga/vClZBbYPMXstHa/5SDm2WUwOKIqahZ2mzawuF0o5GV3dyxmO
 ZoL37iWKH1zsxe77QOgthHwSIFj9R+YcYtbM+8bkl0nl5K3HXCVh9P5ZOGw6XrUAmm47
 56v5X/ibJBSNO3TvCZvMbX424Uvs765Ia7VwdtjfopqHjfhvvhojRcSrniohmyDiVCUo
 oA3DnBXAdmjfcRxbOI00XuKuikdzjf/+23rHXS0oQVG++8qkdE0SQ452IVAy7AvpnB2N vA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k2p7e09gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:43 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6C04gGT029360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:42 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6C04fgI004604;
        Thu, 12 Jul 2018 00:04:41 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 17:04:40 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [PATCH v13 08/18] s390/time: add read_persistent_wall_and_boot_offset()
Date:   Wed, 11 Jul 2018 20:04:09 -0400
Message-Id: <20180712000419.5165-9-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_persistent_wall_and_boot_offset() will replace read_boot_clock64()
because on some architectures it is more convenient to read both sources
as one may depend on the other. For s390, implementation is the same
as read_boot_clock64() but also calling and returning value of
read_persistent_clock64()

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kernel/time.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index cf561160ea88..d1f5447d5687 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -221,6 +221,24 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ext_to_timespec64(clk, ts);
 }
 
+void __init read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
+						 struct timespec64 *boot_offset)
+{
+	unsigned char clk[STORE_CLOCK_EXT_SIZE];
+	struct timespec64 boot_time;
+	__u64 delta;
+
+	delta = initial_leap_seconds + TOD_UNIX_EPOCH;
+	memcpy(clk, tod_clock_base, STORE_CLOCK_EXT_SIZE);
+	*(__u64 *)&clk[1] -= delta;
+	if (*(__u64 *)&clk[1] > delta)
+		clk[0]--;
+	ext_to_timespec64(clk, &boot_time);
+
+	read_persistent_clock64(wall_time);
+	*boot_offset = timespec64_sub(*wall_time, boot_time);
+}
+
 void read_boot_clock64(struct timespec64 *ts)
 {
 	unsigned char clk[STORE_CLOCK_EXT_SIZE];
-- 
2.18.0

