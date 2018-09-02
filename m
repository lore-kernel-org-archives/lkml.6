Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6413C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737D32077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="M39+OG4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737D32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbeIBRlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:41:00 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com ([104.47.36.115]:45032
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728489AbeIBRXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fj1jdgOH1Ka1xyiavspcSFK5Pp+01UAZ4VV2giR+mQ=;
 b=M39+OG4Ry/cXWKRGvuZFPqT6/xST3IllwSPkFvLWsoMznRZHtu19rpjBI6YRriqmLgDP8l3G0MrqBZpyDnI1BZn0QInDzVKdAgKI1qmRBvCn+z3C2D3RmAnIoTUSgkx8CUON2OIS9DjQk1+pF1ry+jH5s/S6Hi+wleIjiMNzazI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 42/89] ata: libahci: Correct setting of DEVSLP
 register
Thread-Topic: [PATCH AUTOSEL 4.14 42/89] ata: libahci: Correct setting of
 DEVSLP register
Thread-Index: AQHUQr3USQthGnRKQ0qnnzBwtrluHQ==
Date:   Sun, 2 Sep 2018 13:06:58 +0000
Message-ID: <20180902064918.183387-42-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:3xVjOI1fM/fY07VkYzqJ51EggueKCjYZ7+pvanyL52iBc9tqy9KWYy+Q5guXwo2OldB5V/al4ayoIT0cw5+aDTfsxAQSyCqPVlN2Zz/o7W4veK3vpPLBsDdyUargN9osXa7fS97Rp+nBvnPTw4w6UdAbwnSKSYTf5Ly65o8T9ju/GMn/iR+zt1mOK4WxlLAgfOFuhWBgfkJ1E+/IcsmSk7c8HDjY/ADj1GGT2gp5YbN533vtiprXi4UHXnexnTPC2fvBkbQ4cuH8FJrT2z41Tj/u4BnpB3Py19PDhstchYizzznyFeSZBkcR9NIhVBKTty9pApLVSythYj2fLoSoo48GVHis9yI22o8R0feMQi+IPQrb2H3Jktqr/BOQYF1AiaIporxCfvi3e4rnniQJZN//+zyqOeI+H9QSiFaJPITYozwwDj6I30dkzym0wq11ANf0H1K3bOtDxRsZcc3FDw==;5:BpGJ8UV5BGSezfOlSS5Er9Oqe7dmgCQgITEpyHBbkG7SP7/h7q2+SGBN+/Y3XaVUfeagBS59Cd1EhlM2073EeLBL/+A0/FjPoCiu2xf0vdP32QnUBKpQGulmWI2KrXjI9Brzm2T2h1LOyNUADPLPmpQ4XGpSFpszyb0y6L2A/cg=;7:MJC3e8ypTx9MTkMcz+H1zBkqikgEPkY9rgdxyuL7hVjHYhwT5whg93dpVE7W/yGWxXgsmnQZxojfowNFtNuvD8CxMmYqD2B0MImelVHLZdb+VmxYLJsfZGZyvrzl2+hfA0EUC5N6Ngcs3YJZ2bg15MQjjXseZYMbmC0QnhPwl2IgefTziPgPLvAriF/3/+d86EjmsBtWB3xSoCtJbFVMzye4zg5vZtgVGl0QCEYDtaSVKLX7mw49qxfUubu8AMej
x-ms-office365-filtering-correlation-id: 3ae47b73-ac6a-4fd9-63c1-08d610d4fef1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB05036D451F55353CF043399DFB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(270512070085399)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(106356001)(2906002)(6506007)(10290500003)(2501003)(966005)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(6306002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hNzPP+9JMLuLg/fEiCFAW3yMolDBNn0q/UKgfGLpiDgojbISFwx66XUT01mXPGTOopwu3UXGk8Ii2S+1hx5ME5gDKRUhn/rIsV17+Yhb1PO1jmesF+Gz6/j8H5W9BAVwixHw29lR8S3GnkdYRuPdPWPvnq3OfXkFetRl5BFXYAj6d9zS1NLuDV1UUcUzP2P70OKEHZmiH5D2mVXe6q+52XlKzMdix2OlkgQY86cut+iT3i21dusl95cQvZDXG2goM/bPjgAwHpvZUxSikZO5wpP1PfVD6tVFtQPkpJdRdUvwHsb245ztE+Rag25zXd+KC6cqTMLurK/Fv5E+ltHPT/zjT9dKDeW0UIpDxPmpmiw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae47b73-ac6a-4fd9-63c1-08d610d4fef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:58.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 2dbb3ec29a6c069035857a2fc4c24e80e5dfe3cc ]

We have seen that on some platforms, SATA device never show any DEVSLP
residency. This prevent power gating of SATA IP, which prevent system
to transition to low power mode in systems with SLP_S0 aka modern
standby systems. The PHY logic is off only in DEVSLP not in slumber.
Reference:
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets
/332995-skylake-i-o-platform-datasheet-volume-1.pdf
Section 28.7.6.1

Here driver is trying to do read-modify-write the devslp register. But
not resetting the bits for which this driver will modify values (DITO,
MDAT and DETO). So simply reset those bits before updating to new values.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ata/libahci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 25edaf8f9629..cda9a0b5bdaa 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2153,6 +2153,8 @@ static void ahci_set_aggressive_devslp(struct ata_por=
t *ap, bool sleep)
 		deto =3D 20;
 	}
=20
+	/* Make dito, mdat, deto bits to 0s */
+	devslp &=3D ~GENMASK_ULL(24, 2);
 	devslp |=3D ((dito << PORT_DEVSLP_DITO_OFFSET) |
 		   (mdat << PORT_DEVSLP_MDAT_OFFSET) |
 		   (deto << PORT_DEVSLP_DETO_OFFSET) |
--=20
2.17.1
