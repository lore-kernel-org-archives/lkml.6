Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B27BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3CF222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="SOqP1fj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392771AbfBMQ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:29:39 -0500
Received: from mail-eopbgr10134.outbound.protection.outlook.com ([40.107.1.134]:44457
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392744AbfBMQ3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Zzml3fwp+RMBoMI9ovoFrQN/kLI7ckKjgpE7coXSbI=;
 b=SOqP1fj85LAofUx6eLmrnKvw8Fad4n7tlGycc3J5PM+tBLX493bXtlcZD7Pj6rnhmHH1/j2+7kJDS5451bhvEfav3zX9TXboIMWbeOgitQRbj4dL/TtiQGp4QNYxAViJ/+8TXUjX4FFuWEJL45FpHPh/RGqMVloDjTv8pPQ6o3o=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3721.eurprd07.prod.outlook.com (52.133.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 16:29:31 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:29:31 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 3/8] uio: use request_threaded_irq instead
Thread-Topic: [PATCH 4.14 3/8] uio: use request_threaded_irq instead
Thread-Index: AQHUw7lM/C2u/JbOYUqnSnPDv5MolQ==
Date:   Wed, 13 Feb 2019 16:29:31 +0000
Message-ID: <20190213162845.11688-4-tommi.t.rantala@nokia.com>
References: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
In-Reply-To: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: HE1P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::29)
 To HE1PR0702MB3675.eurprd07.prod.outlook.com (2603:10a6:7:8d::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.2.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d444b866-91ff-4f04-e972-08d691d06e7a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3721;
x-ms-traffictypediagnostic: HE1PR0702MB3721:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HE1PR0702MB3721;23:/izCXMTFaqI4RgwI1dwPtEUuKyQAgP6UCgIkv?=
 =?iso-8859-1?Q?JiK1F6bEzSez2azf4T17QpDkwnSu9Qry09uLd6ConRcW8uBZj9TUJ84Hqi?=
 =?iso-8859-1?Q?FCuCnEBWR084julsZFa5h0kw85dzuo2wC+O3Mpl+E30YhJivnm1vOA9Jmd?=
 =?iso-8859-1?Q?xEBHTmwhrx4ABH/t0DUSwdoAq5tw1IxsehNxsY7caAJRMdEccb68gjYWYZ?=
 =?iso-8859-1?Q?Iy9KSwULR291ASiOeZAUAexgzk3+jbuHAjT0tDUZOkP2DiEQ6u9MvkZFOy?=
 =?iso-8859-1?Q?Y4zjz5Z7bxdpH740GgCdNIqTtZys7FiQwJKT0VpWFpHxOVZ/t/AD1ec14o?=
 =?iso-8859-1?Q?PGRTtk9YJWkSHE/lZNkRxsAvpn8ypafEyqCw21YucbBoYX1T4qGMgo+BGD?=
 =?iso-8859-1?Q?3jzlEzNZRBApUAgRIFnYC7DENMAt7MpZMw672XVhEaVmFJ+15lvmlvanGZ?=
 =?iso-8859-1?Q?f6E0D+QUvJ0ilOy5ZxSZUhBfy79eTm06uoKcvb3dKPBr1BDGJ/HE0GOvcv?=
 =?iso-8859-1?Q?tb9cZ/dYWXTthTY56dgyL5othx66z49suzxr+9I/hNtm5Sx6LIjd8y88/8?=
 =?iso-8859-1?Q?7nCcNDbiTCEcHDBW8aoPFSVmD3vDif+T/0wgklBATPEaOQGYCrC+3TR+1y?=
 =?iso-8859-1?Q?s4rgJxzyToK/fTNEuPAfPHFhYh2SOr6McCsuz+6iyj8iU4aTMFIm0j11eg?=
 =?iso-8859-1?Q?AbnDoeT1EpbScGY2tu8+z3XadRtFypo5ovFqCNzLYX6DDQrnVCSXZk/BJ4?=
 =?iso-8859-1?Q?tgZY1zdX3+jyCr8sFGa/6MFu+aJudXLAEOWPXVugBPL4nP2UVoXw4xWiIr?=
 =?iso-8859-1?Q?3Z0kxRFZlg/RJcfVVi5UDRhpdnIsi+zEbaZ+qW1XitEGq/uJ1wMEVcgEGi?=
 =?iso-8859-1?Q?8Rq/86ALd7hRD5OSXfOw+pGUbJDd5Y01Eu/zCj3WZqer4qiGA7Kja5Fw+N?=
 =?iso-8859-1?Q?AZpnDKuDIgTtDWLuUVvakxVNiVNzFlMvsIK5mUwLD+JdFn3J+0ZBEHGPIN?=
 =?iso-8859-1?Q?ivUp87uaKLsW55BLZi3NyGc/3qVCXzBXedrku941CnwQwvLeL9oATan+wR?=
 =?iso-8859-1?Q?SsjeVfN3A1G7IC6rw+hAHlniEEh0/uxa6How/kQoT72XLMVWC4rngNMj1o?=
 =?iso-8859-1?Q?vFQiTzRpiCJnQOc5KvG2fxIK9xa8q7V5ZW+/UUfALL3DtcG6LqFMLIDmPb?=
 =?iso-8859-1?Q?gpQA6kB1iFiqEQTxu/yPzXbuXMPvuLGVDU+nV1kdu9t+1pujCKRDx4pYgX?=
 =?iso-8859-1?Q?TCz87ksJENeoRW7LPmo6g4/4cyP4nDUvELF9TzVHEWDLvnWMgn9g8SObqp?=
 =?iso-8859-1?Q?0uSilmwUjg3WX5WY2KUU/r6nzby/SWK0wmT0sWYZUakU0Fyk24WWF2eTbI?=
 =?iso-8859-1?Q?mp12pjCEzyzAJS8L7g/rxrGlYGhVsitz7t9Gfmx4bTlvPjV9KxVRaqIAPS?=
 =?iso-8859-1?Q?aAjeQ3vjpMwU5J/kr0u7vbfQI09UWGtFqZK3rdNjuq8H7F/GnQ2H8nWA5O?=
 =?iso-8859-1?Q?gX1itebSwyxGGtFQ20Vr8E=3D?=
x-microsoft-antispam-prvs: <HE1PR0702MB3721A21698245FFD0974A579B4660@HE1PR0702MB3721.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2906002)(1076003)(68736007)(71190400001)(71200400001)(446003)(486006)(4326008)(4744005)(8676002)(478600001)(5640700003)(81156014)(1730700003)(97736004)(6512007)(81166006)(11346002)(105586002)(6486002)(2616005)(476003)(6916009)(106356001)(6436002)(2501003)(14444005)(256004)(36756003)(99286004)(186003)(386003)(2351001)(66066001)(50226002)(14454004)(8936002)(54906003)(3846002)(305945005)(25786009)(53936002)(102836004)(316002)(6116002)(26005)(76176011)(107886003)(52116002)(7736002)(86362001)(6506007)(103116003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3721;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rxp+8ucmCQ4USNgvtOWZ9iVyaYJ8zws2GqyDaRNiqW3B+IKIIfXPadb+dmECICbzUVCq3xfNVNEZEHk+Qim4LCGhtWXPaCYRkIwYTFQ5izRb6lES206lqkW9SCeRvmgkEu9W6vNJ/h93ZaL8qdomHVnrfPJ2tF82yqmdNGT8GQyHTN24CJh3a6fAf8wbqdEKVfGk2REfFiiSmOn2JLkl5gAzxTym3SAunqDkAOz1MUcaJOzLpPqFY+0V76L5Qt9jod4bPQfFURESnXiQA+dlzzFiMAsfuMQysIk0sWtfoQog8iMcax04mfAmr3Fh78QxQP0evT3QqHqusEX5A1VE/MFdSBAf9i6YYJuD6ejnLvQeyCEZ8xQdgLt9rh28qUCmdnecvrw5qB1lcxUL/8+boFdEX/9pzSXzeW4HNrpacKo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d444b866-91ff-4f04-e972-08d691d06e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:29:31.0786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

commit 9421e45f5ff3d558cf8b75a8cc0824530caf3453 upstream.

Prepraing for changing to use mutex lock.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 drivers/uio/uio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 288c4b977184..c97945a3f572 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -911,8 +911,9 @@ int __uio_register_device(struct module *owner,
 		 * FDs at the time of unregister and therefore may not be
 		 * freed until they are released.
 		 */
-		ret =3D request_irq(info->irq, uio_interrupt,
-				  info->irq_flags, info->name, idev);
+		ret =3D request_threaded_irq(info->irq, NULL, uio_interrupt,
+					   info->irq_flags, info->name, idev);
+
 		if (ret) {
 			info->uio_dev =3D NULL;
 			goto err_request_irq;
--=20
2.20.1

