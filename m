Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C9FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854052146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eLwhTvA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfBTUTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:19:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53548 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfBTUTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:19:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8Uhd081679;
        Wed, 20 Feb 2019 20:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=sI+XoHhsjwJV0n1ws79+QJSD983LQFkAU2y/PjLPk54=;
 b=eLwhTvA43e+K0d0bPGEgP41YXPJQzaqcvn6fgjcmYtzoZjPU/Jq31SFsUnjnNQTgEk57
 LKOqVxnhnuhsI3vz63C4fVzC5HY9sIEVb5P/3dzU+l6IQt48dDWBnX5wFoegnPprbPIt
 NnY1EieQX9sBJGIqJ3dGmFlp5mG0BZaJ7+XERbimD1MirCWA1Qef3YoWZfl1l5nNI6pa
 PucYr7X3xpx7JKU0HTO5M3rBBj6Z6JlX76XCxVgjvlx1XCtUsAyN29Zu+6KombBFZoIw
 ejxluXLvEvvR8b0zoaMRAkupHOV56iD0wItkkAQyhcNlDCDlExUgSl+5rlavefa+6cxb Xg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:49 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHnb5026797
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:49 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKHmCQ015556;
        Wed, 20 Feb 2019 20:17:48 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:48 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH RFC 17/39] x86/xen: export vcpu_info and shared_info
Date:   Wed, 20 Feb 2019 20:15:47 +0000
Message-Id: <20190220201609.28290-18-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankur Arora <ankur.a.arora@oracle.com>

Also remove __init annotations from xen_evtchn_2l/fifo_init().

This allows us to support 2-level event channel ABI on
xen_shim_domain().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/xen/enlighten.c         | 3 +++
 drivers/xen/events/events_2l.c   | 2 +-
 drivers/xen/events/events_fifo.c | 2 +-
 include/xen/xen-ops.h            | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 750f46ad018a..73b9736e89d2 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -50,6 +50,8 @@ DEFINE_PER_CPU(struct vcpu_info, xen_vcpu_info);
 /* Linux <-> Xen vCPU id mapping */
 DEFINE_PER_CPU(uint32_t, xen_vcpu_id);
 EXPORT_PER_CPU_SYMBOL(xen_vcpu_id);
+EXPORT_PER_CPU_SYMBOL(xen_vcpu);
+EXPORT_PER_CPU_SYMBOL(xen_vcpu_info);
 
 enum xen_domain_type xen_domain_type = XEN_NATIVE;
 EXPORT_SYMBOL_GPL(xen_domain_type);
@@ -79,6 +81,7 @@ EXPORT_SYMBOL(xen_start_flags);
  * page as soon as fixmap is up and running.
  */
 struct shared_info *HYPERVISOR_shared_info = &xen_dummy_shared_info;
+EXPORT_SYMBOL_GPL(HYPERVISOR_shared_info);
 
 /*
  * Flag to determine whether vcpu info placement is available on all
diff --git a/drivers/xen/events/events_2l.c b/drivers/xen/events/events_2l.c
index 8edef51c92e5..b5acf4b09971 100644
--- a/drivers/xen/events/events_2l.c
+++ b/drivers/xen/events/events_2l.c
@@ -369,7 +369,7 @@ static const struct evtchn_ops evtchn_ops_2l = {
 	.resume	           = evtchn_2l_resume,
 };
 
-void __init xen_evtchn_2l_init(void)
+void xen_evtchn_2l_init(void)
 {
 	pr_info("Using 2-level ABI\n");
 	evtchn_ops = &evtchn_ops_2l;
diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
index 76b318e88382..453b4b05f238 100644
--- a/drivers/xen/events/events_fifo.c
+++ b/drivers/xen/events/events_fifo.c
@@ -430,7 +430,7 @@ static int xen_evtchn_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
-int __init xen_evtchn_fifo_init(void)
+int xen_evtchn_fifo_init(void)
 {
 	int cpu = smp_processor_id();
 	int ret;
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 4969817124a8..92fc45075500 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -10,7 +10,7 @@
 #include <xen/interface/vcpu.h>
 
 DECLARE_PER_CPU(struct vcpu_info *, xen_vcpu);
-
+DECLARE_PER_CPU(struct vcpu_info, xen_vcpu_info);
 DECLARE_PER_CPU(uint32_t, xen_vcpu_id);
 static inline uint32_t xen_vcpu_nr(int cpu)
 {
-- 
2.11.0

