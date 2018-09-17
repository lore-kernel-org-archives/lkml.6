Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFFBECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBDB208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YGV83wQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBDB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeIQI1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:24 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:6704
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728417AbeIQI1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkviSSIWG5BFpoeqgk4ii7gKB25WahJa1vekQs2U794=;
 b=YGV83wQRU/2tgxAocyLNV9uO8NwI4EZm4xnw4pQYKYrlZXg7wLwW25jlcG3ryeXOALjqPWg9+2NPw5RHOlBhWbfCVT2JOwjYoIM4vglmPUDypakDF3TD7TkwIGBzJRW9lj37mEcVS60M3/SbMskWE93NtPiYq02UUiEZn1TtKPE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 083/136] ASoC: qdsp6: qdafe: fix some off by one
 bugs
Thread-Topic: [PATCH AUTOSEL 4.18 083/136] ASoC: qdsp6: qdafe: fix some off by
 one bugs
Thread-Index: AQHUTjKsY8p7bBiCEUmo9INplaGmsQ==
Date:   Mon, 17 Sep 2018 03:01:04 +0000
Message-ID: <20180917030006.245495-83-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:phcXq8YDO4FA2ojRNViB/5fuQLFypaZbwVCytO2l3WWgdbJPdHNS5Tm7QPZ6GVRfKDdX2qyFCdnKv2pj2yjVpipyACohMzZoGBLtoUtfQQ+DB56dxOD+pre4NJwt+W3stK3rOTR3Af10c2sie7xoGbSb/MxCIbrohzl4KRrCfTRsqZCruMR4F4OgOCZqkIy1WjeYouIwjDD07HyvvFmf0zs+OfG6nmXv/299rk9tLqELWIvild10CnvKCqmFRBGF4GYBjaAAuzDghk9RpvIlatQWcstx5uKK/2+ZU/T4TcGAj8Z+HaXhaCq7FY8ESJIWdQQ/uHID5Q1Ow2vt80UkWUsVMU9iUlzgcu+1HGAlPPYGsTU8+WoHwg3n5TjkJfSttTa5P6eDz5LOdoylXVWXrJhvROIoF9pWE/CQQfPgnUvLd0dchxziUladKBAE718stAeYeAD2jj6daCXibk+DiA==;5:/UdVb1ELaEZ/urdnIc15pUOWif4QeM3/1YEbFpVyhjsnUnkVQxKovyt4MyrempUrZAPttAuGpIUAZsyBVhkZpOysuLpcpLsFy3GOxfuE+zEuEl+s3xnk01EIn9hikLlis8mIQasmaWjF3ovJxkQe59jOp+b2EUfH4HpDv/S2XPQ=;7:lJPZAh7NiFw+6p2xMtS7K116rdq0nbc76Uo9RygU1nLY7tY7Hya/kWt91toGxkc0BTNFRM4qvQlPTgKxB+Z7lrD+jWww/dkVi+yTi2lwrD5CRq5FNjNTBigq7AbCen0S1Qq3fJyOS+c66y5e2qnhL4y7Ra3XAYjvlHL8QCEb6DMllJM5WGdAyhVTrsQGvB/E2+aIyWQLPWgc5c1UebBJ6Mtc9ugkpWxL0/pyX1sVC0eAZlpRVfJ+5aR4cJa1E9Y/
x-ms-office365-filtering-correlation-id: 2bd77f3a-e3b4-45f4-3820-08d61c49f095
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB07902B3054E5C705333756DFFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 0PjIRLU588BHcHmsU7gSgkQOwjAnpT2YyNlYUlO9TKhKZtCJDoa6eCi38hsofdLEVY4/D9qAWQKMu1b1gvgLtaeScoNfAk70vTOvdmDBKHkrzi+AIfUFdUEzWzEvwQXpd+ZV0PexWY+V3FgjUorQeYpWmkYpzwpuG27zH71uxr4acXL5/ucTPvDXwYYcufzz5Y7UiSCjiXO3JHNANtnbZChWmucj+9OgL3hSBlljld18BL86Hp+RlU0ZATL/nWtUAP32BL13rdOYaOWViX1fqw9vpKQWuIqGAesrNKK81vQ2dKhPPe8VX0+ZqdO0Ys3DEKFc9/IAcRO9t7ZW+nkxbx6ksm7St8+azlr/a513jFI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd77f3a-e3b4-45f4-3820-08d61c49f095
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:04.1824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit c54c1c5ee8e73b7cb752834e52e2129b1dab00bd ]

The > should be >=3D or we could read one element beyond the end of the
port_maps[] array.

Fixes: 7fa2d70f9766 ("ASoC: qdsp6: q6afe: Add q6afe driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/qcom/qdsp6/q6afe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 01f43218984b..69a7896cb713 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -777,7 +777,7 @@ static int q6afe_callback(struct apr_device *adev, stru=
ct apr_resp_pkt *data)
  */
 int q6afe_get_port_id(int index)
 {
-	if (index < 0 || index > AFE_PORT_MAX)
+	if (index < 0 || index >=3D AFE_PORT_MAX)
 		return -EINVAL;
=20
 	return port_maps[index].port_id;
@@ -1014,7 +1014,7 @@ int q6afe_port_stop(struct q6afe_port *port)
=20
 	port_id =3D port->id;
 	index =3D port->token;
-	if (index < 0 || index > AFE_PORT_MAX) {
+	if (index < 0 || index >=3D AFE_PORT_MAX) {
 		dev_err(afe->dev, "AFE port index[%d] invalid!\n", index);
 		return -EINVAL;
 	}
@@ -1355,7 +1355,7 @@ struct q6afe_port *q6afe_port_get_from_id(struct devi=
ce *dev, int id)
 	unsigned long flags;
 	int cfg_type;
=20
-	if (id < 0 || id > AFE_PORT_MAX) {
+	if (id < 0 || id >=3D AFE_PORT_MAX) {
 		dev_err(dev, "AFE port token[%d] invalid!\n", id);
 		return ERR_PTR(-EINVAL);
 	}
--=20
2.17.1
