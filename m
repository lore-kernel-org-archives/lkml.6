Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361C2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED5B20877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eXgGuLXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED5B20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbeIXUvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:39 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:39765
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732151AbeIXUvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kf+Ha3ugOdzw2EJnfJRNmtqK39T66ZDJJBT0zeSPRg=;
 b=eXgGuLXWVLsMRBQdqmU9R1CDk4HlGUAJt6sL/DseTpNAJq6iDKNvGlJ4dv0wgAOBOx73DMmrJx9Olrqr1HPz5aszIODzGkKoGjNSB0SNNtmhU9YXLlqKhH62vRkqKzYsUYPAbNACcYvd4mmFMAGpLdRBV+1pqScLU1wVZwp4GWw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0744.namprd21.prod.outlook.com (10.173.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.2; Mon, 24 Sep 2018 14:49:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 53/76] i2c: uniphier: issue STOP only for last
 message or I2C_M_STOP
Thread-Topic: [PATCH AUTOSEL 4.18 53/76] i2c: uniphier: issue STOP only for
 last message or I2C_M_STOP
Thread-Index: AQHUVBWrXrThOmfoIEuLv2oEOyM3xw==
Date:   Mon, 24 Sep 2018 14:48:34 +0000
Message-ID: <20180924144751.164410-52-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0744;6:BC1PoxrtxGcXikZiXSN8l7n9qfq0qa8PQdSu839L6mV4/4mKInd1I05QhWy8vDH+GAUUXlutYpicjQxhaVNYeKneFT2hLGqFSKW1vUVbW/kJU1svC69UuUI/N5KD5sO9jhSrJDNFe0lK2towJM/K/mrMHIwzDiOtSrSSdziDhzcjr7kiYO6P5xR5Zu6UhDcKNunQdo/+Xpa88VYHB0RxGnWs5idPHEYZlu5lq5EczbvvYWmTRyFR+hC1P/Qmf8CGFwUjtOf8wqWhYMp09iAooBpm+fZDJoOVuzsl26QWnWXxi3HTtujLPhkm9naf/B5e1Xcvq08xZxFG/DIT0UTaF0cQHZsgPUKaGSYGvyedfj87lhvb28gQKiPuLjwN+zr2d6M/Wm63mZxBFkMafbNuidV3PZPSTwvvWsNjnt/G5DCrhovMOqApE4XqpsBPEOFiIDc1JENNwnAdBpG6HpYtHQ==;5:x+2TssD5yVz797XeN1ppVf1WEaX09TMcaVhoAyobee5paoXiNf8/DlMdGpBrmpsTci+7Vp1Q8htGJ+tDV/Zl8oAahi3TGi83VXt46wQhUkCq5/oIg7wpKHjMrqWcVjSqpzJHcOtjS8WkkDAPo3FdwH0T+Kq4DPOSdHBGWQ3UxXM=;7:5vGBRcE0TiftK+LvEPFVF8h31XOtc/o5QmgMYPPxjtuZc8MsHFgx/QAmlvGeNz1QtxALz20rEop44HFYqbSmZLmqJwvBSwmTdq8U5LDbxgYzZ4rjPigf0j2FeDF+/RFXQ+zxLkj/ZC48T0c3hLL5N7wkEVHjAHB3FGiQtYVe5j+0QaNXgOgLzrMkYhpiBSzKTP+Jx69kr/RngnHu1pdu/OhvtyE6Up78GKHwSmnEwWPgoeAgZBVftu6tkMUZmUHr
x-ms-office365-filtering-correlation-id: 70ec33a4-edd6-4485-c07f-08d6222cdd1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0744;
x-ms-traffictypediagnostic: CY4PR21MB0744:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07444DD6BA7DEFF6F807FC2FFB170@CY4PR21MB0744.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0744;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0744;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(366004)(189003)(199004)(11346002)(446003)(476003)(86362001)(186003)(81166006)(6506007)(8676002)(81156014)(6666003)(5660300001)(486006)(99286004)(53936002)(305945005)(6512007)(6436002)(2616005)(71200400001)(71190400001)(68736007)(6486002)(102836004)(10090500001)(7736002)(36756003)(97736004)(86612001)(316002)(3846002)(6116002)(1076002)(217873002)(256004)(54906003)(110136005)(107886003)(10290500003)(4326008)(478600001)(22452003)(15650500001)(5250100002)(26005)(8936002)(2906002)(2501003)(2900100001)(66066001)(72206003)(105586002)(14454004)(76176011)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0744;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gNsaYKT0wP2AysPhVELE5ai+lp9WbEkImakFa9Oiop45FwOT/GcugDL/nVWMoxlLmVCktqRfCW+SQuItK3G8xCCoNLrdAMiXhJm5xZiqFiDRhGioNZ0g5oBcKk87zqWGYZyoavbSfqFUVB7R7fxE0Cf28/HDXJG3AwCnw0tgvdo5nTmJfVIlzsMRbj0dXUouUTLJeSmAULnkt4qMxCIKpiBdOkGetKM/z8FoKTydhsiThR1H3vsy+D70SxSvNi8GtGCRhrbXTiZUEmtoMYeQ6+GU4NoCrfALTKLIrIvxce8GIFPdkf6uIDrr8DmqN3FeASvKPj1GzzJwBPxgCzURKoO1KPLZUxKzNTrcTg0Ae20=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ec33a4-edd6-4485-c07f-08d6222cdd1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:34.1033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 38f5d8d8cbb2ffa2b54315118185332329ec891c ]

This driver currently emits a STOP if the next message is not
I2C_MD_RD.  It should not do it because it disturbs the I2C_RDWR
ioctl, where read/write transactions are combined without STOP
between.

Issue STOP only when the message is the last one _or_ flagged with
I2C_M_STOP.

Fixes: dd6fd4a32793 ("i2c: uniphier: add UniPhier FIFO-less I2C driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-uniphier.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uni=
phier.c
index bb181b088291..454f914ae66d 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -248,11 +248,8 @@ static int uniphier_i2c_master_xfer(struct i2c_adapter=
 *adap,
 		return ret;
=20
 	for (msg =3D msgs; msg < emsg; msg++) {
-		/* If next message is read, skip the stop condition */
-		bool stop =3D !(msg + 1 < emsg && msg[1].flags & I2C_M_RD);
-		/* but, force it if I2C_M_STOP is set */
-		if (msg->flags & I2C_M_STOP)
-			stop =3D true;
+		/* Emit STOP if it is the last message or I2C_M_STOP is set. */
+		bool stop =3D (msg + 1 =3D=3D emsg) || (msg->flags & I2C_M_STOP);
=20
 		ret =3D uniphier_i2c_master_xfer_one(adap, msg, stop);
 		if (ret)
--=20
2.17.1
