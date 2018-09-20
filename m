Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC9DECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA721521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QtFvV7oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFA721521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbeITI3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:08 -0400
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:25376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387789AbeITI3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyTj6aPN45lCxH9hlCUqN66enAaeZYkuP7yp293viHM=;
 b=QtFvV7oH0CHku/gOW+FTKZqfgGLaGZXpy7OTjNOzTWS3uHv0MafYFj6z9cfi8k0ZJSaO77KU3uNyV1UltAOPyIQiNDFCFUOIu+iji4zxlAabuf2YKyCVk1Q23e8WF5PxWMNva2rWwjNbGcMs39aUjmeZmkRuIBKxGZooPanJWfc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Preethi Banala <preethi.banala@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 29/56] ice: Clean control queues only when they
 are initialized
Thread-Topic: [PATCH AUTOSEL 4.18 29/56] ice: Clean control queues only when
 they are initialized
Thread-Index: AQHUUIxQM7sqVjoHcUW1dHNmAg4zVA==
Date:   Thu, 20 Sep 2018 02:47:47 +0000
Message-ID: <20180920024716.58490-29-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:PTKXaxpREsKkqbDcTrt1fFFH86mlhLo40mXla731znazV3e3pGDLj6VbKy/OVTbWwFGzoUxt5YxDkudd6JRIwXWjEu5BnPgmPdfX8n60SobES3a1TYQA1B7VM5BYee9g3fBWBxcQG/NqvM9mIF7PJexJjpcdyDWRn/+suPjwRG+6PYxxmwlek1Y5eHUJXCXtwHbNV4scWlPtPghjSbh7Pw/usTZ11BJIPxKtnD5ZSgbdSAcBBWJdNrRiYaPsUfJyQmKWnc9Qf/YQTT5LvTktGWn1xxuOqpCX9kMHdsLQNJ08LVeIcei6OMeFXZYtYiOPsBQ5cMHlnw1FW/MVwBNORmyTPdMfNObMpoqhp5JI1WoZJwWrs4wVRuhgrrIs06RVuPsUQoWX6l+JmS7RfeugbyXp7weP4b4talYYLITxGIqtW81Sw7OJQ+6qp4BT6vsfOvDvUXmeqbjk1ud6qzXftg==;5:sVU02yi/AAyouILAlUtQFuog1qZVNcTn9hQT0oNSvc/t1td/xV1BSwA/01s9tFf9m+vRvkxy6IP9IbT6GuJYfw9VN3h52UgAs51Gs5qsyN3m7sNSxoEPeTtof2S4WsUBo6wmdVlKTGT4DBqK7mPmlhItjkUGrseOWmv2dYmPlL4=;7:GP+c0A326ksn2R6n6upz7vGML4bU3Jxx3agEMEW+9DcX4CN3ywmHpvGEwjyCHs6HF80SYK9y6zTX8ghPkhLwU51A3b07UazTlQB9G7IKLZOsQoqajGWbzSH+RfJKauB+3kp5/ZeG7WBKlT6RRQ6sJIE9ZuM568fRtatQc9URWkJqL+fUqei3mOkNqxB+g1X5DVpva4i0srAkBuxrVH3uUnygi7jtV5rGXE0Oh1Nu4jOnqAMoIo4rL5KAPyRkRiSe
x-ms-office365-filtering-correlation-id: bb09aae0-8e54-47aa-a06c-08d61ea373a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822C4565EAB0F2BF98881EFFB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(14444005)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: UmCHT80hh/w33eG8iBJcq+RzDj6oo6kR8kLx4tV4uqUyKW82rFKPoSECRLDjjCelAgpwQ+B2Ky5NIATWZteHjI5XFUZq5rn/DXgGlrq/Q++TYpCtfXi9tSXeFTTiXv67nECpUS9DekopJ/gso+HS67ES11TXCyE3SvVPK+8T6FHNlFE7PtCNfO0Wueq9e8/1cwcGx9LGE89eExrG+y8SJEpa5D+BJfyh6ai1RShDsm+1m9DKrf9YIXLoh4wd9wBMRQZRCbR55+2Tv4QkjRp+IJl5uM6OrvkN3Bo6k7FSpQh23Z6L3aX6Q11ZmkwclrleQ/A1/8OlhCtTPVINxwh+Sz0WD987FiItxxvdt9p9ETI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb09aae0-8e54-47aa-a06c-08d61ea373a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:47.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Preethi Banala <preethi.banala@intel.com>

[ Upstream commit b29bc220e2c7bd494a4605defcd93b18d5a8cf86 ]

Clean control queues only when they are initialized. One of the ways to
validate if the basic initialization is done is by checking value of
cq->sq.head and cq->rq.head variables that specify the register address.
This patch adds a check to avoid NULL pointer dereference crash when tried
to shutdown uninitialized control queue.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/et=
hernet/intel/ice/ice_controlq.c
index 7c511f144ed6..c064416080e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -597,10 +597,14 @@ static enum ice_status ice_init_check_adminq(struct i=
ce_hw *hw)
 	return 0;
=20
 init_ctrlq_free_rq:
-	ice_shutdown_rq(hw, cq);
-	ice_shutdown_sq(hw, cq);
-	mutex_destroy(&cq->sq_lock);
-	mutex_destroy(&cq->rq_lock);
+	if (cq->rq.head) {
+		ice_shutdown_rq(hw, cq);
+		mutex_destroy(&cq->rq_lock);
+	}
+	if (cq->sq.head) {
+		ice_shutdown_sq(hw, cq);
+		mutex_destroy(&cq->sq_lock);
+	}
 	return status;
 }
=20
@@ -706,10 +710,14 @@ static void ice_shutdown_ctrlq(struct ice_hw *hw, enu=
m ice_ctl_q q_type)
 		return;
 	}
=20
-	ice_shutdown_sq(hw, cq);
-	ice_shutdown_rq(hw, cq);
-	mutex_destroy(&cq->sq_lock);
-	mutex_destroy(&cq->rq_lock);
+	if (cq->sq.head) {
+		ice_shutdown_sq(hw, cq);
+		mutex_destroy(&cq->sq_lock);
+	}
+	if (cq->rq.head) {
+		ice_shutdown_rq(hw, cq);
+		mutex_destroy(&cq->rq_lock);
+	}
 }
=20
 /**
--=20
2.17.1
