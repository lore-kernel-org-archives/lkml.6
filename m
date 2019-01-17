Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D21C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6E520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gzjYkWV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfAQKL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:11:27 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58498 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfAQKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:11:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0H9xUMF168996;
        Thu, 17 Jan 2019 10:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=uK5gtDz3/2qRYgKOGoBN8YJgCyyAOq5Z3CxfnL6znhY=;
 b=gzjYkWV1rNEOy/7Lsm0N7LFPHt7gDEIbFY0hmNJPLHoEqg5X6jFSJuGBoN+BRrCZz1zA
 y8h3T5ebmOzp5Wx7JkmZtV2ZTfUxeWq+X7oL6OYYTrkyYYks2A1VjAhBLV1rKkMz0uxH
 rxzpFT64xGvik8Ecdy+6LdZ2fGBpGBF9isvARP8+16t1/pvHI2H+1zcNJvu57e6Tf+BZ
 WfszS2byOOkzCV1NGRUJZwoc/cpuRTw5B0lsU/gQYc/zQwSV1rBNjEQdI5FSuXqh+EJC
 9oyqK8tgLX2PnNd1hbnvVrzEMKUr62KM6+GrSU73ChyRNk9QUL+3EqnGBQctTIkHqfBX nA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pybkcq1ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 10:11:06 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0HAAxjQ007767
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 10:11:00 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0HAAxAV016668;
        Thu, 17 Jan 2019 10:10:59 GMT
MIME-Version: 1.0
Message-ID: <e2e064f2-e8ef-42ca-bf4f-76b612964752@default>
Date:   Thu, 17 Jan 2019 02:10:59 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <konrad.wilk@oracle.com>, <tglx@linutronix.de>,
        <dwmw@amazon.co.uk>, <bp@suse.de>, <srinivas.eeda@oracle.com>,
        <peterz@infradead.org>, <hpa@zytor.com>
Subject: [PATCH] x86/speculation: Remove redundant arch_smt_update() call in
 sysfs SMT control
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=941
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit a74cfffb03b7 ("x86/speculation: Rework SMT state change"),
arch_smt_update() is invoked from each individual CPU hotplug function.
Then the extra arch_smt_update() call in the sysfs SMT control is
redundant.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 kernel/cpu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38..c0c7f64 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2090,10 +2090,8 @@ static int cpuhp_smt_disable(enum cpuhp_smt_control =
ctrlval)
 =09=09 */
 =09=09cpuhp_offline_cpu_device(cpu);
 =09}
-=09if (!ret) {
+=09if (!ret)
 =09=09cpu_smt_control =3D ctrlval;
-=09=09arch_smt_update();
-=09}
 =09cpu_maps_update_done();
 =09return ret;
 }
@@ -2104,7 +2102,6 @@ static int cpuhp_smt_enable(void)
=20
 =09cpu_maps_update_begin();
 =09cpu_smt_control =3D CPU_SMT_ENABLED;
-=09arch_smt_update();
 =09for_each_present_cpu(cpu) {
 =09=09/* Skip online CPUs and CPUs on offline nodes */
 =09=09if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
--=20
1.8.3.1
