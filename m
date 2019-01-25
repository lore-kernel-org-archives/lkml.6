Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0105C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD953218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="n78qvGGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfAYHkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:40:36 -0500
Received: from mail-eopbgr710041.outbound.protection.outlook.com ([40.107.71.41]:19872
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbfAYHkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK4fBTFSIMw6I8Ka1Z2zTKEC1C8kcDFKFZd6k3RITMg=;
 b=n78qvGGL6SBcx67UW62KyG9ldTdFg4cC7C6UfKiGFcHRlIHU0wl8KmyCnvO1S4b5v5pFc6vdjMQqJHOMahv/cSLS3/zAw7il4Kqf+rPaQeR6saXCiYDZ9CwRjl7DFz3tjFIw4LynRa0RiDPoWQEvhp0ULLOXkgnEKAgc/4+yUmI=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB3503.namprd03.prod.outlook.com (52.135.79.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Fri, 25 Jan 2019 07:40:32 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f%2]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 07:40:32 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] i3c: fix missing detach if failed to retrieve i3c dev
Thread-Topic: [PATCH] i3c: fix missing detach if failed to retrieve i3c dev
Thread-Index: AQHUtIFA6VlT+4CX00GLhIOQTsp/gQ==
Date:   Fri, 25 Jan 2019 07:40:32 +0000
Message-ID: <20190125153420.0533d156@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:404:10a::14) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR03MB3503;6:tEXvl7wQxAEhWUYlFoTUXRTnMDfPjustfN8m7A7FKr1CHoSFJlpBgP1cmYfVfWV+aloT2+B7aVF+xvnrgfLufThqfL/W1/IHtCzUhNUePKZRj3IC2I453qULJsH0+EkuF84dLFYR3x9+nOyYmRX2/4jhJimNMk2es8a0pY28ut1mJo11d9zlJvvxlSTG09ihwyR5LnO3RtHwZH+err4/IprOB5bG4V2DaKPoO02wiBx1SwbOaQEsMKPhu02TaxEofeI1VkPkfKGqyGh6fY3f/2k79sReygNJFfcN+kn3Kwh8ll1EftYRVqMpSiwQvc5FtmKJF9nKwgHmMDoRgWu+m6arGf7Qrkw0kwd5fD3Qv8k2Ydj8f4Diony24HNTMLn63C0dor19AkqZbIzkab8KY4d185E01LPWoLHbVr1qjhnPH7NkVEMPO3QlZ9jFeOQXtGupK6BZ93pqd0uFaas9+g==;5:avtHNqSHmZYpnPA7zfsOKI/NBj/6iUWGEVzK8mzy1cOqso2VaE4HMrOfQRFZ+Kwt58SFrIplATaaxkQXcSFYQ7+WQ59syqNEKbqgSLb+wA/JlbyiogJGXuXKVPgxHPeJVCGuVQr9pm/hxFygs+l/ViBd3+DYx4QNfjCv0UvLwW5uMH5j4cnR6BwOnu3uLQzjN4iFuE56qMQxsryYTSpAAw==;7:GEE72wAk0lP/T8thRgEdWeJxu+JEAmbnBy5UtRvgBm2DqZdrhif5G7Q+qLQZrOAsmB513GKPVuSabT0T8xuQQrzyMM1imgBsuJeCQD8rdHyvrns6mjtFjoBKWrjkko0weriweG4Y/1zt16hKMHzC1A==
x-ms-office365-filtering-correlation-id: d7ebe86a-1922-4e21-c944-08d6829862a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3503;
x-ms-traffictypediagnostic: SN6PR03MB3503:
x-microsoft-antispam-prvs: <SN6PR03MB3503C30113AB4D14DB89C907ED9B0@SN6PR03MB3503.namprd03.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(376002)(346002)(189003)(199004)(486006)(3846002)(6116002)(476003)(53936002)(68736007)(7736002)(305945005)(25786009)(50226002)(105586002)(8936002)(4326008)(81166006)(8676002)(66066001)(81156014)(86362001)(6916009)(106356001)(6436002)(6486002)(97736004)(72206003)(99286004)(14454004)(386003)(6506007)(2906002)(9686003)(6512007)(4744005)(186003)(316002)(102836004)(26005)(54906003)(1076003)(256004)(14444005)(71190400001)(71200400001)(52116002)(478600001)(33896004)(42413003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3503;H:SN6PR03MB4398.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YKB4J5r6KxxAVsb6VsAA4a64m6JgJwsTKU4m1Oes5sOGcbBBoMb9udzk98Ro/IJlLvMobquRVvmIfsL27lmGjC6scK4y/d2ryfATNpvZxKmdUphmuTavCuBBrXuyHVfTZCUeTDlEZ6uPak6TcveaaVillO6Hrv9mdKfHVdvFde/cdF2JofgQkZD0rNBFelEhp3srVgU8cYvrzfXF4JeoQNP0OTkiTKeoyy5vFZDvopXuZxA5g1LkLDCjHVIyt8F6vwMS6dD6smHhXSBLbLECVtojxYVGx0bvhRNpO386n3HQGvM9hnAcqxST5vTI6T9R7dz2GpVYf7pUZ9p3GGngs5KFS+l02PZ1wcB+xyqMOCmdWxTSA33+hRPFQUbIAfCbs21QuPLyefnD7QD0CWwGkkVWPXRu5QrvPOnFfiv6ayc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6910436CE5444249A38A01E2D35CC120@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ebe86a-1922-4e21-c944-08d6829862a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 07:40:30.7454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we failed to retrieve the i3c dev, we should detach the i3c dev
I.E i3c_master_detach_i3c_dev().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index c39f89d2deba..2dc628d4f1ae 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1828,7 +1828,7 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_c=
ontroller *master,
=20
 	ret =3D i3c_master_retrieve_dev_info(newdev);
 	if (ret)
-		goto err_free_dev;
+		goto err_detach_dev;
=20
 	olddev =3D i3c_master_search_i3c_dev_duplicate(newdev);
 	if (olddev) {
--=20
2.20.1

