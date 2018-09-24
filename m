Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F018EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED9F2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gvwNiT61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED9F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbeIXUwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:18 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:2846
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387653AbeIXUwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SddpUUMtdVJEdZpHJZ4S0iWyxg5LxENJ803iPMwHzWg=;
 b=gvwNiT615eHG6M50zXIIpBmd5RbfeiGqo3NmEusI8pczDfKuPMtfIm1WS2oSjRWb9g2o8aROkmvvRZVE8yByMVYAIRZjAYhbrD1vO3LUzsTUUYB6MSjB7AiOer6w/7dmvVfr+369tWSeM2lwvB7fdN0GtEIxzNPGI7N6CEPMRe0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zong Li <zong@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 69/76] nds32: Fix get_user/put_user macro expand
 pointer problem
Thread-Topic: [PATCH AUTOSEL 4.18 69/76] nds32: Fix get_user/put_user macro
 expand pointer problem
Thread-Index: AQHUVBWvfGqAW1E5wUSaD5cSJ+iEvA==
Date:   Mon, 24 Sep 2018 14:48:42 +0000
Message-ID: <20180924144751.164410-68-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:Asn9JzBsLwlhDnKABlJmXBHsNImWRabyjnJDA7BgdgBUZx+LFuuvuCZU8avdK2EnkRuf5nzZH+ZYQGWy1dwYoef83LhWEsdF66fZm+tuQqXqOBEr51K0e9mTJU2ybnUK8Ya9+Wl/mjGSlG4IoLwSSmmAVdVM6zKorsbIiB1ziN8bB0mzF2mTm8QP+TN6qIULELZdXui1XvOKLWFbghheq3FTOughf6MFWPXDn9WWEEbduecgd4EY1sf/ln++tgT5pfERiMlMV86aP1nfbDO1x+kMtA26p8kzF8Jj3PrikvPJrd+vry5LZha215iPSJXzJJ+NISRVUvMHucbR+4Ua5EAjb3H22Pa+DBg6MNYDuXNV/+mFeBNf21ZRw4ZCw7/j8eqnQvTcScfDj2lWyFh5rF12YTR0N8aMUCNHgvTi2v8Q7rMoPXUXo1e66hHi+KgHQHnepfkPaURLlbhr5W+gEQ==;5:U0MExbQDh4MCsCMqy2RTsuGsTKnK4gFomuAQyFPVSrtxPNclK130p1bAjjHDP8ZizfzUoRdcVyVK7i9GWmTM2D+BfJcY6fq5wWJcPGOJaojB/jM7K2GcQGPQRfGVFMX+2zWZxykq9Gm93SB0XO7/7ljxgycTAsvezHVq/hWcHVs=;7:5iSHWJdZkygYuzxWoHcG0CAWC8QOziTpY3jKt+pwOuRlcmaNDLReeJ4isG4+NYN4lJbJ/qpkF7NC9mC6tbb01edoptyjtdo2q31AcHF2G6mj7rR4bJZ2MEHjL3nSudyMsjPC8bvYblCdLfKs/QaEcfp8W82rOScumy87SilnjgFh0wvSA8EPyWU9TPtiqXImNHB+OphSFbTMDhPYf5WsK0YUHJqxDaEuXAPMUsi0AINks5zduGMHL7wMf4H7CI/z
x-ms-office365-filtering-correlation-id: 8328cf2e-a690-4c3d-6905-08d6222cf288
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04715509937BDD753B07FDAAFB170@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(189003)(6512007)(105586002)(256004)(53936002)(14444005)(106356001)(10090500001)(6486002)(217873002)(1076002)(6436002)(71190400001)(97736004)(71200400001)(446003)(476003)(11346002)(54906003)(316002)(2616005)(86362001)(2906002)(86612001)(8676002)(5250100002)(26005)(81166006)(81156014)(36756003)(10290500003)(4326008)(478600001)(2501003)(7736002)(110136005)(2900100001)(186003)(6666003)(22452003)(102836004)(25786009)(305945005)(68736007)(107886003)(76176011)(486006)(6116002)(6506007)(72206003)(3846002)(99286004)(66066001)(8936002)(5660300001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1PIDeb5Mw8h4HsZbV23oIQsvYXnTjp3EfIWmAHHfS4ibsvRYFE93L0HiutScgQ20ehu90baGKZXITmZyQQikHKejYpGJfaVRpWv1u9aE5AWcnF/8wr46Fk2vtJ0mNnOURZYnM/TX5Qmb/yV+LFh8qZ+wGRV6XYNoxco1WBixTLB63dlC2Tci1Wkb+LAbgM9UT3WUi6HCS+QEQVfk3OAcRpvn+l2Iqdwt8hUTaapN4sMeUEOZxlmcZ0123jxT4wFUaRVaFYIBe5pMPQ1BHWMpOrmsWy/ZMyd93jASDUpIItmebaoyZcsorNiqN/HXTBqPjHyygIo5WrtwFl09U/vgq8xqlV+htfb7txJekI4ehRo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8328cf2e-a690-4c3d-6905-08d6222cf288
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:42.3251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zong Li <zong@andestech.com>

[ Upstream commit 6cce95a6c7d288ac2126eee4b95df448b9015b84 ]

The pointer argument of macro need to be taken out once first, and then
use the new pointer in the macro body.

In kernel/trace/trace.c, get_user(ch, ubuf++) causes the unexpected
increment after expand the macro.

Signed-off-by: Zong Li <zong@andestech.com>
Acked-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/nds32/include/asm/uaccess.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uacc=
ess.h
index 18a009f3804d..3f771e0595e8 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -78,8 +78,9 @@ static inline void set_fs(mm_segment_t fs)
 #define get_user(x,p)							\
 ({									\
 	long __e =3D -EFAULT;						\
-	if(likely(access_ok(VERIFY_READ,  p, sizeof(*p)))) {		\
-		__e =3D __get_user(x,p);					\
+	const __typeof__(*(p)) __user *__p =3D (p);			\
+	if(likely(access_ok(VERIFY_READ, __p, sizeof(*__p)))) {		\
+		__e =3D __get_user(x, __p);				\
 	} else								\
 		x =3D 0;							\
 	__e;								\
@@ -99,10 +100,10 @@ static inline void set_fs(mm_segment_t fs)
=20
 #define __get_user_err(x,ptr,err)					\
 do {									\
-	unsigned long __gu_addr =3D (unsigned long)(ptr);			\
+	const __typeof__(*(ptr)) __user *__gu_addr =3D (ptr);		\
 	unsigned long __gu_val;						\
-	__chk_user_ptr(ptr);						\
-	switch (sizeof(*(ptr))) {					\
+	__chk_user_ptr(__gu_addr);					\
+	switch (sizeof(*(__gu_addr))) {					\
 	case 1:								\
 		__get_user_asm("lbi",__gu_val,__gu_addr,err);		\
 		break;							\
@@ -119,7 +120,7 @@ do {									\
 		BUILD_BUG(); 						\
 		break;							\
 	}								\
-	(x) =3D (__typeof__(*(ptr)))__gu_val;				\
+	(x) =3D (__typeof__(*(__gu_addr)))__gu_val;			\
 } while (0)
=20
 #define __get_user_asm(inst,x,addr,err)					\
@@ -169,8 +170,9 @@ do {									\
 #define put_user(x,p)							\
 ({									\
 	long __e =3D -EFAULT;						\
-	if(likely(access_ok(VERIFY_WRITE,  p, sizeof(*p)))) {		\
-		__e =3D __put_user(x,p);					\
+	__typeof__(*(p)) __user *__p =3D (p);				\
+	if(likely(access_ok(VERIFY_WRITE, __p, sizeof(*__p)))) {	\
+		__e =3D __put_user(x, __p);				\
 	}								\
 	__e;								\
 })
@@ -189,10 +191,10 @@ do {									\
=20
 #define __put_user_err(x,ptr,err)					\
 do {									\
-	unsigned long __pu_addr =3D (unsigned long)(ptr);			\
-	__typeof__(*(ptr)) __pu_val =3D (x);				\
-	__chk_user_ptr(ptr);						\
-	switch (sizeof(*(ptr))) {					\
+	__typeof__(*(ptr)) __user *__pu_addr =3D (ptr);			\
+	__typeof__(*(__pu_addr)) __pu_val =3D (x);			\
+	__chk_user_ptr(__pu_addr);					\
+	switch (sizeof(*(__pu_addr))) {					\
 	case 1:								\
 		__put_user_asm("sbi",__pu_val,__pu_addr,err);		\
 		break;							\
--=20
2.17.1
