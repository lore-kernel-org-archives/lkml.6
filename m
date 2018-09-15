Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A2ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796B8208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LHPMktw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796B8208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeIOGvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:51:51 -0400
Received: from mail-cys01nam02on0117.outbound.protection.outlook.com ([104.47.37.117]:43118
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729755AbeIOGvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1DCLSSPHAPYJxTyyxJhLn7Ejs8lVyMQLBxx8iIMSIc=;
 b=LHPMktw7tAMSbgcTsQnY6ZgcnFO0F/9XPCQeMkNS8kyrrEORaMjzkG7XFPA96m9T2ERoWu0gv2aD2kMpFcfoRPTL3NTAmt4denon/KzrnW/58p4J+KQ98fAFvdrrkQ9vwKo+FdTdNo4ymlnLcQiVZSiM+55kv2NJJVR1EqcTzD4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 29/34] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Topic: [PATCH AUTOSEL 4.9 29/34] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Index: AQHUTJRH/7DUBsTquE2LNzIkpQxqXQ==
Date:   Sat, 15 Sep 2018 01:34:44 +0000
Message-ID: <20180915013422.180023-29-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:Rq1VbxJFSBp3zySyNrTl4mBtG873i5zjjAMhfS2yQZFQGzvBKbhk28NCjfjFd48Naj4eCKZBtng5SETdmSC87Hx/FvJODlAGv3bR2NedqnZKeFGfQl24EqtTEVlRjLXZ+hD6Q7X8+uLXQ8zyXTUPISjFcyms2NkSovU2W/2OpHl8XiRs0dBdug3ryG62+6xw2a7OW1BfX2MHaiA78ax/raUra7OXxyEWVRQKjTj0Sk/6yW/iZd7RIVZPeggftINdI0Ajm9YwDdOBLjieex+aiaU4j2CatWvTBYT0dVy0ivdYKw0j9SGjq6DGjR8sChq3n1VDkLzUYtw7WTebn53e5LtRUaz6LPn6EFCZHJQyiNuny0mHeK6YN8GSFskZGB9ARwcglHJd6vviVeKQNEBp9Xmi21S0Yko4WqTZiJ31rKEYZL85Tnx+nVXf+x63r+LGNkBtr3EhkIfh1i00r/X0pg==;5:QzK7bz7KfTQgzYXmRvog79nVOohChkZi6PhznO4zeR9WuS6My2o0BwPGYOcPk3Rim8Ihi5lwcIGa15jcMisWuix1S6aQqQoLqUa1LW0Gdy8fYZ3EvJWxxB7iFRP3BdfL/XhVERujKAdarpb/U6a5MeLoWWo4TDeaATiwChbAWS8=;7:zoeF7ejaCM9ocudUD8PM1or8k1MfrEtQTOuVNXuCczUYz5i5AWJc5Zx728fG9gQ1gEH1CD/qwHCfdo3vhFKOQq1UU8oqVcMC0IbkVPF1pQLnEILHMTpPv6vRNN16kWRV5/b9gmpiyLxPG2QwhWHowkNbXgDcONH/yFzIay0U5BDHjcXCx93HiwnQWxLeoBQu4pgPv2YUXdmJ2HRB6cUcu96XTr2/j5soW4jX47AG5B3S5Hi1y9tJMtKqT8GN28ay
x-ms-office365-filtering-correlation-id: 4585af03-227b-4eb8-b116-08d61aab6a4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB08230E8B265C5CA1E51C1E32FB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(15760500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(966005)(25786009)(8676002)(86362001)(6306002)(66066001)(6512007)(86612001)(575784001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Tao7o+SVMGspAdkaK5ZFOMtJuZwp7BWWFIXCTe22MBhiUc9/OLYdDu1OLE1RReUbAURkNVMkhiqfsWnrLrA//9b9oZqSct3iM+qWVSCGxCoOjAQiOZtgLg39WKolgDTA0NQNFfNWiuoH1mhgPqxN3icSAsbvRB1pecRaT4ohK+Qc42mXQX+ZG8Y8wmrDIJD36NC2OHjV6QcAo1BcWSTeYT8QQHowpwZC5KdzD0jQyCqvvmj5LE8M2W+BW4APYWvNBgMB/OPhIuWkq8Q0eOKbdGRGAguFg+ni6EQ1OM2DGE5WodV+idfwikNEPfo79OtPkVzD835L5HIecB2Yrb2FIRfbFfEVx0LFL5ywMnDRYAo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4585af03-227b-4eb8-b116-08d61aab6a4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:44.3641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
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
