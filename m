Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E687620C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u2xEIFPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfBTNdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:33:00 -0500
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:1235
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbfBTNc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB4rRS8rcRqh7jm65JECv60j93qZmlgVAseiSxW41zQ=;
 b=u2xEIFPS8+pMWFQ2jemXREHKkxicUSv8BrBZhUqTO8HM8MrQRrZjK++txhO4HIW6k6eDwPHK5Zs4zQp5KtgK0EfF6WvGdkRwoH7qzR5QkaTWfiP4QQWn0nODL3s4k0Jq/M0Rjf2U+BpAQ1lCSvcPQKN+pTifm+fyHN3iBiX+K1M=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.16) by
 DB7PR04MB5355.eurprd04.prod.outlook.com (20.178.85.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 13:32:55 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::fd45:a391:7591:1aa5%6]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 13:32:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC] percpu: use nr_groups as check condition
Thread-Topic: [RFC] percpu: use nr_groups as check condition
Thread-Index: AQHUySDJI5EsBnYxBEew8wybkHZ3fg==
Date:   Wed, 20 Feb 2019 13:32:55 +0000
Message-ID: <20190220134353.24456-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR03CA0071.apcprd03.prod.outlook.com
 (2603:1096:203:52::35) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:35::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf8672d9-3cdc-4b76-23e2-08d69737eb69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5355;
x-ms-traffictypediagnostic: DB7PR04MB5355:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB7PR04MB5355;23:/Arm5YerdDf8qMusZYcWzIflAOzz2gdyXsc7cFy?=
 =?iso-8859-1?Q?3Ec74l1BO1KiWfYLGfmSO1KwhqqSyXoV4ABFC+b7ciO9p80Pt84sS2Mvr2?=
 =?iso-8859-1?Q?nK3FA4QJ6o1nw1C8MvBvXEQo0u2uQQUmWv9zbvQyI37xDkT8yUI0mwo7YU?=
 =?iso-8859-1?Q?XNRQElJXzHpwpiKzUtbhWqTDXl8R2LOYXIsFeTw0Tu9ptfw1Typw1hclH1?=
 =?iso-8859-1?Q?jLkyipfznI5TBK4EOfpfBkLtqr4HqWG3j9A6IR8ZLfdhcWaszz1ZCTJMaf?=
 =?iso-8859-1?Q?knbHNoq2OV1OrNEyQG0NX0kb/RruK+190uSNFkB1z1Wq1ImRKG3zI/wZDy?=
 =?iso-8859-1?Q?l7TnuvIMXvHJ67UMwprbR96yaZCCQa8nDusZpf5SwtlnIFsGTNx0xpfM0B?=
 =?iso-8859-1?Q?2mQtOZjnB4bhlJDDFnHtqRC4ygS3CvzqS2gPbXwAdkYdi4ot8ATiz7QMoW?=
 =?iso-8859-1?Q?jprs5Yqg4i69V/9voBr0KH5DK/mNp/D0EXRqUN6yQh6cShrazTUIlTSse6?=
 =?iso-8859-1?Q?QMul8VmcaOEnBo9EcU/Kmnq/inz+MVwIj61WypkEeyXcYYPN19qKtSK7QQ?=
 =?iso-8859-1?Q?jV52574vfn9Gu7mwKi5IuZ0nBkHhDNJdIHwPr+ovuZeJCquEoiIZ8Rz7bc?=
 =?iso-8859-1?Q?QYLnmqcdR7SotK08y9CBw00NmOrgvsSz89WhDlJxbpxBGlXSERq5Bwe/Xk?=
 =?iso-8859-1?Q?49U7idEHRWsc3uNCAo+E2IsT8FW5VhkAqgdXKqdcSlcz3ibWfG1rgrpkSl?=
 =?iso-8859-1?Q?4TueE3TakcQny0GcNaJVwUf0JAg2+qMZZyN65t+NbX7yT9KrDjeNWoD91I?=
 =?iso-8859-1?Q?43tFajYx9ZGCXHiGogN9XVlH3TYYpr2HZd51hXep9V974YuknhsLq7Rxkd?=
 =?iso-8859-1?Q?cOuLWFrPOh7oXtwJE9NiteviGQn6SLD86irszqXhQdNEFURiKYjaKvrtI2?=
 =?iso-8859-1?Q?3fjAfpBarWgVGWpfDUEF5yZqR0yybLRliE9rux7BEP9IgVqNcygqvauKHD?=
 =?iso-8859-1?Q?+6MNwH3LCf5e0VPv7G4B26thG6lPIu6NT3RGI4ylO5qdfwRJL3KgWw47IP?=
 =?iso-8859-1?Q?Iqffzq32KUbd4rF+2eYUK9q0APruBChEfp6N32jjO7Uqc2OV10fKZ/kRVf?=
 =?iso-8859-1?Q?RmAUoCehfrWjZbJtbfGtUyVgjNEGi0uAY+kKc2bEHgrthETGIXc86MZ81/?=
 =?iso-8859-1?Q?0zda/MXzePECMPXc4+tHTkI22rywGaIWsAsitbJcLlc+cmWech+h9R5TtF?=
 =?iso-8859-1?Q?0fF3w9gObLM4JnIsjjLqUhnBL7SMiX6vzDDJC/3jMV/T1wbfZSoKPJM02i?=
 =?iso-8859-1?Q?5E=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB5355BAFB97F3E3F808CCAF1E887D0@DB7PR04MB5355.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(25786009)(486006)(97736004)(52116002)(44832011)(478600001)(316002)(110136005)(6512007)(99286004)(26005)(105586002)(54906003)(66066001)(7736002)(4326008)(2501003)(186003)(3846002)(68736007)(6116002)(53936002)(14454004)(305945005)(71190400001)(71200400001)(81156014)(81166006)(8936002)(50226002)(2616005)(36756003)(4744005)(86362001)(2906002)(6486002)(102836004)(106356001)(1076003)(6436002)(476003)(256004)(14444005)(8676002)(386003)(6506007)(2201001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5355;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 12G8hzUO9t/sGSUMFCVA8yQEo5oM7tZOJoDbTLauX3KmMLNju8Oi04pMFt20GWCiskHNMBrYgZOrAVl9e/WQ7RocAtSCuzwmwQhh4nip1XzjyCAbadscMZWCHcid0XY51hk4374gkE9SiA58OAm9t/EVXKwXhiNKQ6U9qbBcP58mr3ScLRHzuerYOCZioLBD0oTRYJRoz757CCI/SyEGC1vgx8x/4G9bXsNyIhwjPb1QfzzNSq4DmkC8Ycz7QOVe1D1BZydpp9ksXpWoaRHSYJHFV7Lcain5jFtK8f021eVGGr0cAl9NUanAJxUsQ6ITWPPj9Pnw14ACk3evcnTv+uJEJsDgMyayYAZoGhvRUMSwpZsHVSxawtXaWV4gi/1HasYHJ+Q61oPsg30J8mFYPcVO0rWOTY0u83vtSSzA7/A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8672d9-3cdc-4b76-23e2-08d69737eb69
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 13:32:51.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5355
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

group_cnt array is defined with NR_CPUS entries, but normally
nr_groups will not reach up to NR_CPUS. So there is no issue
to the current code.

Checking other parts of pcpu_build_alloc_info, use nr_groups as
check condition, so make it consistent to use 'group < nr_groups'
as for loop check. In case we do have nr_groups equals with NR_CPUS,
we could also avoid memory access out of bounds.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index db86282fd024..c5c750781628 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2384,7 +2384,7 @@ static struct pcpu_alloc_info * __init pcpu_build_all=
oc_info(
 	ai->atom_size =3D atom_size;
 	ai->alloc_size =3D alloc_size;
=20
-	for (group =3D 0, unit =3D 0; group_cnt[group]; group++) {
+	for (group =3D 0, unit =3D 0; group < nr_groups; group++) {
 		struct pcpu_group_info *gi =3D &ai->groups[group];
=20
 		/*
--=20
2.16.4

