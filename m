Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E67C2BC8C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98A92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FWfykTFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98A92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeIGFOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:03 -0400
Received: from mail-eopbgr690100.outbound.protection.outlook.com ([40.107.69.100]:6633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbeIGFOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQhUzJLa2gh3l1H98mIQrYVzHBMtgnmacGSieOfa1Vs=;
 b=FWfykTFTMUOPUovV2991pSNEqr6MndVRFigOYzRZLRMez8HTfqCnMQIKhpJuaMv4blMqoGpo4Q8XM6xjCVaaWfxL6zXqI3vkcGv+xjciTu4ATB7FiTLN4jqlZQJl4uOMxVBpEAyK8XE7GLZrI6os6/4Z1ZwReOaLXw9qVXG+qhk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:35:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:35:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miao Zhong <zhongmiao@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 03/88] iommu/arm-smmu-v3: sync the OVACKFLG to
 PRIQ consumer register
Thread-Topic: [PATCH AUTOSEL 4.18 03/88] iommu/arm-smmu-v3: sync the OVACKFLG
 to PRIQ consumer register
Thread-Index: AQHURkK72NPbFN9Zr0uLcKF2yjk2RQ==
Date:   Fri, 7 Sep 2018 00:35:53 +0000
Message-ID: <20180907003547.57567-3-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:aN6VLLcBwKRph6p5PGOAuT7wE+Rc6lF929rrglMG2bHZqr8cWXxSjYOQKceaXJ+AGtcSuqV/jltma+P/6wW1md24yqorHKmN858vRZwknvfgdU+yNwSy3jg1+b5AI7EYogReepWnNnCLKpXrZei2lSgrX/5VAHu5NacG817RHXzTqHNDN+Kr+IHbZvRNwY+PP1PDUuzh0T1HYmYAbDH7CG7YqpVpD1unYhWLl0GtLNOcfibFZMbC2Aj2gooKAEF36h88J8ZDMigNV0ty51uBDvJrUK4EnXL9C9mIC+v26kQGLEji15NlI88Quk3OMn83ZwtHtYOJNGfvnzPb/PTk7BWSZd/XaGg/XlW0ioksRhxby1oqUKDgBUpR1QVsICT0y2BdZ1m+j8Y1dCFg3iYbR2yTg0pnFokmqu5qVOSLxTTHr3xwJtZhFHNHa+GqgRRUiI7Za2TdzIdeSmWsDEKG5A==;5:WdzV4/goD5ZNPaW3cmcUITK4KB3ccDk4TCvXokI3XTxRlv29vaVV2X0+rrW9y/4o6dY3Y9CQjtG71kJRhlg9y/bdUT6xQ4piH2zRw7cQkuAXxONXqrpxoGwL38xRVzyLdPxugrcNEAuxwdlomCZDBMC+JfR91ElxnDmpk/fUa6w=;7:1wlP0vdGYVblydx2C+HeZh7R8kzC6BL3JRzDOsokLFjyaggzKNDHIl3JkgeKlxXr48XkUT8bRe20DhfG14v+9DAp10nYR7g0XNQTX/oh7akWbcd3WMTpEjAUJUenoScUhHkn9jSxS26hajFw3DoMl7LfwUv/fI/+Fe0LsPsPNRo0129tel0qJ7Pei+glJLcI1zsFkTg+TtCqAjuq9oPbhQI1gNpJk9vrHsFhl9qk3kk/SXf9NIqxSzbYriLl/ijm
x-ms-office365-filtering-correlation-id: d42d35df-6fee-429f-54d6-08d61459de85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773B7E937F28B5B290D606AFB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lyiDxyDlbTHDKXAoS50t8BLcutYrenJCrz2WqyyhoR0mzBWhe8pNzOTKbyeuvK2MVfeAz6qRTDhmXGjJgoVpGJRol6zQzOLYGHFkJEaPXSo9bEongyHq7AJ4sEw68IHEhKS+otyylwNncSAExoDnHnZy021Ivzehsoda3xhtNhFpSte9tkyfVzEEKztZwiuzUSekrM+Ni1GIXX0rBaz1GQ4O/WEPCsLQD8qKRCRbzk4T4xoLEvVPm/q7lmJ9ZviEXG4CCD2MoCk4q8A+gP4LmI4BFiJfcG2eChlGkOb7QlQM29oz431l4T8DTu9Pco4TbqTIcBsnfLULt906qppVWGcLV0Hy7FbnbxT5dQ5sd2g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42d35df-6fee-429f-54d6-08d61459de85
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:35:53.5577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miao Zhong <zhongmiao@hisilicon.com>

[ Upstream commit 0d535967ac658966c6ade8f82b5799092f7d5441 ]

When PRI queue occurs overflow, driver should update the OVACKFLG to
the PRIQ consumer register, otherwise subsequent PRI requests will not
be processed.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Miao Zhong <zhongmiao@hisilicon.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d647104bccc..deacc152f09f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1301,6 +1301,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void=
 *dev)
=20
 	/* Sync our overflow flag, as we believe we're up to speed */
 	q->cons =3D Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	writel(q->cons, q->cons_reg);
 	return IRQ_HANDLED;
 }
=20
--=20
2.17.1
