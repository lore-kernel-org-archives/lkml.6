Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D52ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B9E20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lFJDDGSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B9E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeIOG6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:58:36 -0400
Received: from mail-eopbgr730099.outbound.protection.outlook.com ([40.107.73.99]:42981
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729446AbeIOGud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1DCLSSPHAPYJxTyyxJhLn7Ejs8lVyMQLBxx8iIMSIc=;
 b=lFJDDGSltyygjUSve2lQQeczYjl15QGlG12v03LNJlLFnHOJ4/3TZvrtd1YDl7cjUepetsHAMjp2q2f03LRYB6qc6AZVbv2zBjSU0yO09O3XRtBpn5KALJ06VKiIdTOtnVuG29Ousl6e6wkGehovU0vdQkfCLgLEExDpk+MMEMQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 48/57] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Topic: [PATCH AUTOSEL 4.14 48/57] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Index: AQHUTJQJlrIRBWymKUS7sDuO432nPQ==
Date:   Sat, 15 Sep 2018 01:32:59 +0000
Message-ID: <20180915013223.179909-48-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:JZhREbkS/WyXhMN+yqVnB9YA5MNJZXWz1NmDJi7J/5rBOvwSEWikB4rnsty+kv01VwXUtNsHaHJwwToBISfcd/Oh9qOLQaY7FjYbuXpYdSvlCHIoA2n1K6V61ZaWYmNP/yszhjB8MyxLmFECJM2TuHeq9qqwKWYigEXJPqA1Z/zSTHIDUzyPfVd68xV6P8P9jlZcQez4Bg8dpytYUyyv0/CJmhf7Sih1DDgmQcKU8+1Z6+IHqAHSZj9LTkCMSeosPXvNcXottmMonZfucEHlyxAn2d4hvZDhK4ztBT1WXL1m1M+qT4zSWQFG8sLPppsYF6vZ2IyiEaDzNJ1cd5JO4Ch1cEd3od0995GNv2yM+0p+oF4pNlKDc2zdYqf3JgEB9qlAdyxLf0X7wICcHmOSnD8GSpudNEFje5yN7I8TxD8GiSBrkxwXjSeJTPl5ED9oExb3B1WeyCnEZNKOEAiEYA==;5:bSpOJk5Y4codAdygt2HGnLhcAODdFEK9Fx1V1AIVyBKLeqB0ZowM+o2DFRXHmae8C73FWS6KtJuirsZZ2N01ZSyPVgz0bbNcYo6exgxM8P+xkewaEvrXp0iVpQ3j2wQaQslIFpHpV/lIlp/n2fwgS8la3+1curIlna0LCRGdynM=;7:JX2r389Jakx6FSxOqvBo0zz6BQRg6ZW0kCFzz3uSZChSD0b+fpkeIyBpRBC+HkKCnmzbHOK0PTXuZjw9eAQSnq/k4xSDEAVX68v3xM0w9gL50YS0jgVmmnleyt/yzSs+FzR01JJ+rLXM0iZK7ChpW4HnGZ4QtL9ZpTLZtG3sN0q+M29S+SsQpePwN3sK3wqbwg8j0Pr5u+o0U1jJPVF5ISgxnIC5bbmRkLg7G2ZQG7sXltqnnc8rV52kw3Q5MYzn
x-ms-office365-filtering-correlation-id: 56f37030-1475-4752-6c6e-08d61aab3afc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB04712F05DEBA7E9D1122D606FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(966005)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(6306002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005)(15760500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qNxdnHGI88KjbyjibCurIlxLdCgHZWYIQOvTVSFz69oh/LqECSlf8YNYcuzHXM8eEl5K5BbW8//+NrAXEQvsn8CyIfCyndp5tCVDegz+ysw7HMOx3E2Z6753vbUqTlCl5bVizfYhaoRAHjCe+JqlTFUUHJaDQmie8oJw1ni6ub9rsTCy9srh77e2OaO8HsKPaDtodtuLMK79YRzmP79SA+3XH6XqjyaF8/VPw8KKMat7+/cPQZAK6DseYjLHOG9trMKAVmF9FOsp315M69V2lXyaYDvuty7Iz6h1dCRPiPqz4NSX+r+rHbrKZ+UVM+73XanLcvmy/bByry52btPDzXzgsZ5WXwrxUc8+P2+0gqk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f37030-1475-4752-6c6e-08d61aab3afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:59.4458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit cd0e0ca69109d025b1a1b6609f70682db62138b0 ]

The ARRAY_SIZE() macro is type size_t.  If s6e8aa0_dcs_read() returns a
negative error code, then "ret < ARRAY_SIZE(id)" is false because the
negative error code is type promoted to a high positive value.

Fixes: 02051ca06371 ("drm/panel: add S6E8AA0 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180704093807.s3lqsb2v=
6dg2k43d@kili.mountain
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/dr=
m/panel/panel-samsung-s6e8aa0.c
index a188a3959f1a..6ad827b93ae1 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -823,7 +823,7 @@ static void s6e8aa0_read_mtp_id(struct s6e8aa0 *ctx)
 	int ret, i;
=20
 	ret =3D s6e8aa0_dcs_read(ctx, 0xd1, id, ARRAY_SIZE(id));
-	if (ret < ARRAY_SIZE(id) || id[0] =3D=3D 0x00) {
+	if (ret < 0 || ret < ARRAY_SIZE(id) || id[0] =3D=3D 0x00) {
 		dev_err(ctx->dev, "read id failed\n");
 		ctx->error =3D -EIO;
 		return;
--=20
2.17.1
