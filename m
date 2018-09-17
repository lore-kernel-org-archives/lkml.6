Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28391ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1442147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZS162lxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1442147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeIQIZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:36 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com ([40.107.71.124]:62784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728348AbeIQIZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ShpSFuc636ZCDOqsuYQ499lwNkCUt/8AAdPn4muJxQ=;
 b=ZS162lxrLReFTZLfagUMpZR8uMhmORmxHRclqOFTqa3n/Yrmfcm82aFh7QUtkmYRd5Zlx5BTD/3bIq5LkOHUiOHvea46vZ8BGXNQF24MQH6lQdAHPw2yHjm77dl0kMR/77f3984xtKyKrjMS6PlEifIgqKLK0+fOdovvVQLyZwE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:00:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 008/136] net: hns3: Fix for mac pause not disable
 in pfc mode
Thread-Topic: [PATCH AUTOSEL 4.18 008/136] net: hns3: Fix for mac pause not
 disable in pfc mode
Thread-Index: AQHUTjKPgZpxbCj+z0eU2BEG7QqILA==
Date:   Mon, 17 Sep 2018 03:00:15 +0000
Message-ID: <20180917030006.245495-8-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:0fSRg8bCVnGnjd162yyH3LdJH7CYJhPVYAHbWzbum3gaFNJ4AMSWPyCk0g/+ED9ED1CmUNBoM07ZJwBNsVYEp1QAESwtTKptdmQJBMmsaxKV5Inro3himAkwnk6LCi+PkSfLAEV9f+BWt3Xm6Rqzq609rs8TgpFKGrESfMIwfhYFL6OrBoKz7Qm7VivS4XagPyb57A4z8I/vnvOyBFmrPnHAR/9afy4YGDpip6RRcymRgng1ZqlSWtHH0Exsm0rnfwkAgYGlU+qw3EXlzIh1wUsHGc6RNlF61g6ps9WKE0uFxbVoxQssRCJDMbbLjIIyDFpi/RUVnAzs/O/ATfrps13N8Pz/iqAlKd2kG11f48IBi86RrD0bbP2QHhWaXtqQ3cm37iP5Bc2E3+r7SZT/hBOz86ma98jOPE02jx4wNkgJ2kWom6rnJe+OUcZJiYA4L755m54tzq4AzJTTN9J51Q==;5:Q2a4o2Qn85Na/MhfQAiBTKvdDFNh0+35wNRc9f8JB73cwFQJofjXllId+IM8GcWPXe6magYqMr9Jtw+ATn/Rn5yACBQSS4rfuelwu1cNGehwaDLNJt6/j3s+iDi+XXUWkucYezxZOmi7wAw2xIpzSnHC0s1FKQXu/1dqzLhm/Uc=;7:JRdY+1JzhWFk64T77bZYUw642Vn8hUdSMEw1UC9Ptx27kuzq0czCExmVLzNn0AJfV08f3iSskICtseAWc2jYvZgMNPgCSf4xD2uhlWITMD5K1HNalluYzMyee8vpBWEIb7a+/9/OoYR5jWzVNAlNl0HaCNKibO4g37TngI2v1Fi4ZQ7JlaRYO8wCt84QN08w9yxdSt/u56eZC3pfgIu+sWo3oRwgdrODol1HrQMnmOCZOu+aKeY2yXno5iPCvqwU
x-ms-office365-filtering-correlation-id: bf3d255c-6e39-47d2-ffc7-08d61c49b1cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0134E88D7FAE2DEE823EA4D4FB1E0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(6506007)(10090500001)(14454004)(99286004)(76176011)(68736007)(6512007)(4326008)(25786009)(217873002)(107886003)(72206003)(22452003)(256004)(14444005)(36756003)(54906003)(110136005)(8676002)(6486002)(97736004)(10290500003)(6116002)(11346002)(26005)(7736002)(86612001)(5660300001)(86362001)(575784001)(53936002)(316002)(486006)(476003)(2900100001)(5250100002)(105586002)(102836004)(305945005)(106356001)(66066001)(81166006)(81156014)(1076002)(2501003)(2906002)(6436002)(8936002)(446003)(478600001)(2616005)(186003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4+qwKFZlnVbqFJLf4OsdbRMe61oaq1uiF2Apcb9zvALV41b/4+72s0pdqyaxik9gIvZ8jMAShkOQFMvwm/YX0uw85+xvZM5gcBjATx5nxKSQzquOvMQzaF1G76azO1n+lqnQ4OWwBCW1DyNs+xClI0MUCdKTZIQf9iBBaIIu4Q4IHymrf+qZtQBdtaO0EOIrkLSoKU+otD9xccQ38hfvA/bkEanQlHC+WePplSwuRBoTQGp01VeUP8PPQChfkI8A8YkUHV/mq5udHyTl5iVDYUHjIn9rGaBESK8aBI8fkTZ8wQU4quY0mU+1j9R6OvQ9dK+8PdSYxEOZoe8GuoEK+KexNL0ncxRuus8Dgw+FEPk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3d255c-6e39-47d2-ffc7-08d61c49b1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:15.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 6d0ec65cb5810f9bf08671be008785bb8c84d39f ]

When pfc pause mode is enable, the mac pause mode need to be
disabled, otherwise the pfc pause packet will not be sent when
congestion happens.

This patch fixes by disabling the mac pause when pfc pause is
enabled.

Fixes: 848440544b41 ("net: hns3: Add support of TX Scheduler & Shaper to HN=
S3 driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/driver=
s/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 262c125f8137..f027fceea548 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1223,6 +1223,10 @@ static int hclge_mac_pause_setup_hw(struct hclge_dev=
 *hdev)
 		tx_en =3D true;
 		rx_en =3D true;
 		break;
+	case HCLGE_FC_PFC:
+		tx_en =3D false;
+		rx_en =3D false;
+		break;
 	default:
 		tx_en =3D true;
 		rx_en =3D true;
@@ -1240,8 +1244,9 @@ int hclge_pause_setup_hw(struct hclge_dev *hdev)
 	if (ret)
 		return ret;
=20
-	if (hdev->tm_info.fc_mode !=3D HCLGE_FC_PFC)
-		return hclge_mac_pause_setup_hw(hdev);
+	ret =3D hclge_mac_pause_setup_hw(hdev);
+	if (ret)
+		return ret;
=20
 	/* Only DCB-supported dev supports qset back pressure and pfc cmd */
 	if (!hnae3_dev_dcb_supported(hdev))
--=20
2.17.1
