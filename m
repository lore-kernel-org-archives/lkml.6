Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE1BECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26C221521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ShjQOv0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26C221521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbeITIhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:37:51 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387788AbeITI24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heawJzCrKhtWVMOfqu6ZUWTFX4ROlS2nY8W/L5Qtwog=;
 b=ShjQOv0n1h9XijqgPk4lSDBZ2uma45uERXwQ/UDVMgDpGsYBkRW5bp1Uu5zIvkwRLlf9A/MEzbUwytuh5KOfbxaonKWJFfkc/u8i+1RtaP1A/wwiCZCU+5qJt2dbqJpMyJ+QjQenbAsxIx1hL2WSvc5+7JsoRRCWoXFPoL8vyAA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 21/56] net/ncsi: Fixup .dumpit message flags and
 ID check in Netlink handler
Thread-Topic: [PATCH AUTOSEL 4.18 21/56] net/ncsi: Fixup .dumpit message flags
 and ID check in Netlink handler
Thread-Index: AQHUUIxNNwubSLEuI02BJMw6L23QKQ==
Date:   Thu, 20 Sep 2018 02:47:41 +0000
Message-ID: <20180920024716.58490-21-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:lkrWtRlg9yiJ6Z5sdHpmqveHWBwH49OtO++tVwRq1lNmymoDTLov+NtfoVaLkQR/sDeotSMNSLy3gmbdbU4jHoY/UELX/Ynj2NG3wDWcnHc6zL8QGbOqEyuPf2IncKXvrUHVSbczRHem9mLQ4LAVTI5lNRPlIm85e2g/ng1t14do5VxPqVx+ueUKhyi6AjyLg0cFRxXpkXJyqgZcngsu7Q6DT66ZyWlGG9pRyFrEkLjCs3zrFnckAiolYbsirjYdSWxCikVJIdJwP3edmOmY7x5bmmaRwwlFmJp3WA87i4KW9TyAUBPAwavpKMe7QDSh3v2q67T+14EGW+KUcr6/SFlZGso9IPrLpD6i4HV3jycNilp27JCDCl9iEePMfY7U7IB7eISyQEfwlrw5wQpvfU1WttBEU6oy+NBsD1UXpOF2RfcBz8lSifaHbu9qoQdv33tzqLop6Kml+lB88KzHTQ==;5:gbeBA3U6i8j2dyAlqrNUYpE3k8Dr5sZ8DeelOXLIVhAExKY+7TVKMVmG0h2gE85qiSRLKCrYruWNL8s9iTkdnm034pMq6obp0EL66iU3E0df7j+56OjYsKeXGgcxXsPPAjUlaRFpojKJu8uRR3WvwJpsABAF20dkZsNQUA0t6uc=;7:lPRWh6r5H2yCLysqkdjQOm+RoCt3w5MUa3lfGahNFXAyqj+ocb70X1FPrU9lulsbqJBEpjLYIBlvCqKMdENu3hxBIHXcdGd8dALNplTDCQAfr8hLQt23w9Yh4eiyrN/oWF3/Tm1ero20bwU/rM63xRJblMcoE6Du4tokm4UPOBXrbWhh/V3XW0SX74YJKVje9jkV8bO0vgPR/6R78UIxU4CHZqh5BkYXO9gbxHMuJIn989gQBrwBOtZq/jXsGIPS
x-ms-office365-filtering-correlation-id: 90e65bff-f769-4d87-ec0c-08d61ea370c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB082287B975BDF23B9094CB87FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(2906002)(107886003)(2616005)(486006)(256004)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: XsKjTXuNQ7B0MMDcQNRrVxPUW3o31RTidk1HJJE823Kf7MWcpco9hmfmNN87ccjbZ0ub+wT9uc8Hm+tkhTZGEVGUqndktwBPwIqyr6UZc/+MUGGjqDMEw9sAm01qKwFktzGENriW7YxgeBxj9ERcR4r3u4OryvY3I+KGV4qzLcSl1OvOJe4VdYLN6lst9qb0aIsE7HFVJ4nYtKMSECrbXgc9GwqyaAlgKljbjNi7SbWZWPlWvRG5cW5RUPhnFqbHoRCmAIln/49SCPNg+2s87fxpa0vrmon9CX9LxB4+TBPsEuHo6ycOtez3lgCiP9m/EyIYBTMBZedt2fZzeIw0wlp4AQkBHFwofA1Wf5G0ZRI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e65bff-f769-4d87-ec0c-08d61ea370c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:41.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Mendoza-Jonas <sam@mendozajonas.com>

[ Upstream commit 3d0371b313b84ba7c16ebf2526a7a34f1c57b19e ]

The ncsi_pkg_info_all_nl() .dumpit handler is missing the NLM_F_MULTI
flag, causing additional package information after the first to be lost.
Also fixup a sanity check in ncsi_write_package_info() to reject out of
range package IDs.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ncsi/ncsi-netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 82e6edf9c5d9..45f33d6dedf7 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -100,7 +100,7 @@ static int ncsi_write_package_info(struct sk_buff *skb,
 	bool found;
 	int rc;
=20
-	if (id > ndp->package_num) {
+	if (id > ndp->package_num - 1) {
 		netdev_info(ndp->ndev.dev, "NCSI: No package with id %u\n", id);
 		return -ENODEV;
 	}
@@ -240,7 +240,7 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 		return 0; /* done */
=20
 	hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
-			  &ncsi_genl_family, 0,  NCSI_CMD_PKG_INFO);
+			  &ncsi_genl_family, NLM_F_MULTI,  NCSI_CMD_PKG_INFO);
 	if (!hdr) {
 		rc =3D -EMSGSIZE;
 		goto err;
--=20
2.17.1
