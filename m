Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD94BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685682147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FEcg1w+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685682147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeIQIbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:53 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:32192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730988AbeIQIbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAytq+xtwLyc61Rane4bE2FbcKDYySYTtmLWyyZlv/Q=;
 b=FEcg1w+/0HEgb1mrYe179ycd6b1sfXxSd0tloRuP6x+C/zduhwUwOu2XXjywO5R8fLMrMJSoUVTrILhrvMrcCuhfFHvpqlsf1m0N8BJZF2i+wgoi1Ku+CBXSnrk0klOUQ37lQbdwTUzhyn85IAHz+RnjuOxpWvn8EiyEIjuxy74=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 03/43] vmci: type promotion bug in
 qp_host_get_user_memory()
Thread-Topic: [PATCH AUTOSEL 4.4 03/43] vmci: type promotion bug in
 qp_host_get_user_memory()
Thread-Index: AQHUTjMyBomwjcbP60mfn5wIls4BJQ==
Date:   Mon, 17 Sep 2018 03:04:50 +0000
Message-ID: <20180917030445.484-3-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:Jn9xJl4Ob16EjdBMXh65/Lj/ulot6Ax87sb6mrA9lLtp6Pd0L1PRfDiZ3912yEDxABt/QrFuuFzIuZN9J6j93ELrrhRRyrxMzniedNooAmoN7i7SF25t8vvOER66M0FLJ5wrtc5yTb3c91X5rP3uBxchWLNCrFsbBi9IpbuYOJAlnLfXTATvUDZHpZWzerKE39m03Z6dffDGXuxDuDw7zv3Rrsl6vtyukkgq4bxzJDF0aFOTd7oQQwtH9kpYOt12Z9FGeY3WxkMykP0dOnbBnAXR3mf338WKRCFnRbUryHkHpPSLQzcwCO3xpVut7xmN4R0p8K4cSxvZfim0TSXoOcK32wctPqi+zcRDn6aDc7yJodB7ZfIcYTTx2Y5oTMhpF/BE9MT1v4Lw5/rKYwAHyPC/Fa4PoOAsvXafQp+WeyQUJYjoQvBa6tOnTcF8Hx2JJs4+oaeX2wqOgDGDHbA7Bw==;5:R0LpIpMk5iCFwg+RixfU3QcraBYlyp2PEpyXPxatslrfAWLCXqizyElnoAYzAZnNTcvch7e8vaSRm2F65pNWfyuPRk0irj9Od/FNe0sD50T0fsF1A9scMRf30IuPiU3WDMgThtLP//1BWnGwCCZKHbLiMvJORCLD9hyNAUR1vF8=;7:WkhEQK1QsFvfGOXS7iwkGyhxaTHqBGg/ZBELhHVCPHppSbu45TOL+/6ptOFeMhaTauaEKZY5451Z1kPjwWwgKkCAmPKC0EKQPnTS3aQ5pnnOw39vnR2YSMg3hlh0qrD9b/uGMLbrr2k4/udP96bauqWmopF3GNI9/L23UelPFRnSt56v8pyJSDgH5Uj66hjKDF8YqBHPUjX5bG72oDCFYI/3Y7PJ4aHOehKSvtUL23gCRvPQJUnlb5ajf1Mn+C3e
x-ms-office365-filtering-correlation-id: 75cbfb0f-7a63-4f93-11bf-08d61c4a90b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB01662E3777C13A3CBAE80AF9FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(1076002)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(76176011)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(446003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(11346002)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 7W6TDMLe9Vt4RE8GpVgIZ3w/jCkA6Iqa8TCd6Wn/MaYYgQT+K5pFjDaOwNL42X6A/GJmpVg45kvTINj9cEPDgc3Z//DL9jUyLrR5F1EGTmlB1/k8tq1ewI/CRSNjn1BxJVEQIGcB7Xht5dsOH7O4w9ecAjLuBqdc5qSnuzZSytNtvzTSf85mpTFWrX0HcJmQr/g1xwq6J4GCDKpnryrVMEFNV+IS7ahIl7NCErb2Y0ABOuzgU4gAwrhx5UG5g15oDJttQll61Tz8d0Ga0wQ1rpLbXJgUvjN/szwaBA7KWHIjmH7yEjoHR4AanxT+l/T4qQVK9isqC5c0gd60fd6c3Ce/NYNA6N3kFIs//B0GhWY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cbfb0f-7a63-4f93-11bf-08d61c4a90b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:50.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7fb2fd4e25fc1fb10dcb30b5519de257cfeae84c ]

The problem is that if get_user_pages_fast() fails and returns a
negative error code, it gets type promoted to a high positive value and
treated as a success.

Fixes: 06164d2b72aa ("VMCI: queue pairs implementation.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmc=
i/vmci_queue_pair.c
index cc277f7849b0..3877f534fd3f 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -755,7 +755,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	retval =3D get_user_pages_fast((uintptr_t) produce_uva,
 				     produce_q->kernel_if->num_pages, 1,
 				     produce_q->kernel_if->u.h.header_page);
-	if (retval < produce_q->kernel_if->num_pages) {
+	if (retval < (int)produce_q->kernel_if->num_pages) {
 		pr_debug("get_user_pages_fast(produce) failed (retval=3D%d)",
 			retval);
 		qp_release_pages(produce_q->kernel_if->u.h.header_page,
@@ -767,7 +767,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	retval =3D get_user_pages_fast((uintptr_t) consume_uva,
 				     consume_q->kernel_if->num_pages, 1,
 				     consume_q->kernel_if->u.h.header_page);
-	if (retval < consume_q->kernel_if->num_pages) {
+	if (retval < (int)consume_q->kernel_if->num_pages) {
 		pr_debug("get_user_pages_fast(consume) failed (retval=3D%d)",
 			retval);
 		qp_release_pages(consume_q->kernel_if->u.h.header_page,
--=20
2.17.1
