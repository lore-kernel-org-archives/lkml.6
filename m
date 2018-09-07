Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BBFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455792083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="R+B9yD3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455792083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbeIGFSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:49 -0400
Received: from mail-bn3nam01on0093.outbound.protection.outlook.com ([104.47.33.93]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbeIGFSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0Fizgkrf8guiYw/K2lq5j6Cz9Mfr47WUCBQIAHzBT4=;
 b=R+B9yD3Utbsfxu5fJpH2O38RogTAo2N1q4Lc/2aAapb6xCPcltYxycD3QB8eqcf1FazW76QDofHKwRDGo8glSrESIcTKm8C+TVGsq2TwFE0zqPGjsO8PWQHc+3jNLTXbpf06sXUkrtOPK2L7d0K0azvsSdrx8pKNOiyEdMdS7AE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:40:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Miao Zhong <zhongmiao@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 02/43] iommu/arm-smmu-v3: sync the OVACKFLG to
 PRIQ consumer register
Thread-Topic: [PATCH AUTOSEL 4.9 02/43] iommu/arm-smmu-v3: sync the OVACKFLG
 to PRIQ consumer register
Thread-Index: AQHURkMT5DZqbKhSZk+1KVRZOHFW8w==
Date:   Fri, 7 Sep 2018 00:38:20 +0000
Message-ID: <20180907003816.57852-2-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:2/rLpx6xtMNriOs9ZJKgZvkxR903xrG0RdJ3OusxyDE3Pueky6kaKUK1Og1Jnq0v6SIBpDIh5fp9zu87qKwGvsX93t7K0XIlJdJNh4seL9t8OfSWM5hVig07yaDI2A1mq8Hn7W7pw+IiX0uO2O1FqEcvlvoeX726VMNRKUJtPyRiXAYC79nfcwF7ljPDHPtJztfOaW65//ihXHPJtTJxGuOdM824712NcoN7vYHviJ2fXFGh+d9DaguPbCyR+BfHtm0q/fob41Md1ADpop6mOjN3lBBfyIKYmjLPXRr+kw1/JDxb0RMcq82DLxSJ6/Q1Q9kbAnWM9qDwUF0YIxcZ8zXSUHQ2t+Oa5bMMColU8HIcc9DLee/i1/yKAcss3JhrFu1+yan7C6gP5JultAPZUwCobPa6Kr3D6V6LxA97LdYM0Pc1Dv9FreHIDHPOqiDXpX/3Pcj9FCen9udfoFLWDw==;5:+G2bm8QCw/gpHplYJdEdQLt+vI2eFWmngi+YmenFeh9vwuEL59aQMOARwlkHB7NsJ8SUpVxXXd6u4VGy/eUYPbptYpRlZGUicPG13jd94kOeLt/GIIxuPPO+vM7u6chAvKYjDd4UXGkTBH12oeUy7YXR0jTwbb3OvlcANGqAhEU=;7:YMF480we8qfU9aRtGWTY00tsSt/u2rVo4tOKqchssfhw3xavdH7YI6jYvaWzKH0SBs88g10F3T6oThuL+fqXottBn/p5fowupXeE0ba4HE4Zk9+a+l9n+g/sD0iysrmVd6bEkouCcALRuSk5Y40Papu7c+0JqfYCGQhjcAJXrnByXP/NjA4BYmxqCPYZiypLDhVJ/DRi9Ty4ZOsum6IthRnUJljDcN/Jh76fTK9aa59W7JfCTzn9AH8O2NuhnsD3
x-ms-office365-filtering-correlation-id: c5fffc3c-05bf-481f-025f-08d6145a720e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855A7CD032E02FE4C728EC5FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6512007)(54906003)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TfKKbytD4VDGD8sV6Vob/3mHk0dvovjbvXvCxMB5HmZQ/1Z02fQzT2MgFRwcDKXcRsEgIrKwp1kxD9kCC3tEhWnclwsKR3mlRpszrDLbunMOIDDMJfrQrirzOyAD3KFm7chkTTzU11PV6nSRzVpIsBbo/lyu2sdHqXJffT5IWZRhkkLcoVVCn2w7bxpQOql3P5oeK6XtFBzPaN7GNAQBVXDtpBdhJSSUMXTUOcRN/vyDv6CZoo7J+YqIsa+bGJPF2+g3Hz2df685oge3eIx1q9Pv7MBsoi0P20ODd972UxBgvjywF8NhygczfGt6+9uNX3CsHvtHCQ7/wR+BsSpnQzMKiL1IfBEFlKR7YH815ik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fffc3c-05bf-481f-025f-08d6145a720e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:20.4981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index 7f294f785ce6..ff4be1174ff0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1233,6 +1233,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void=
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
