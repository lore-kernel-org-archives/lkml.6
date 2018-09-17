Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCABECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C46F214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nwYWiRgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C46F214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbeIQIdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:18 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:17664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731475AbeIQIdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE/iCx03MmHaWblvh2S2qGrvodyn2PsrG8LxDZIC+5o=;
 b=nwYWiRgulbGLNB8CXgGVbQIUOyPHTUdzFuXrDp3VO8kfh09kN/tjBuv8PbDYT+qug76UhAHBhxQJ5jZDpPFvRIB0O7cgLHjlvK0EAmeQAZ90rXJTRqXjc6zavb0/kWoUJRJM/6etfRqDgoKM80KSXHfRETd/jdIuVZ3iGFXStZE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:07:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 18/29] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Topic: [PATCH AUTOSEL 3.18 18/29] drivers/tty: add error handling for
 pcmcia_loop_config
Thread-Index: AQHUTjNVfc4MvMYeXUG00AoEpwTQ1Q==
Date:   Mon, 17 Sep 2018 03:05:48 +0000
Message-ID: <20180917030533.592-18-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:+RTUMgvkK7sh7P1gKTgZqDbDpyuvBOeDkz0O+ZSXiaZUSEpRwxCjixlk7/2TEz8KKKEvuyzzCMSNkKCvKE/SgGQyHgJA9jzbWBwOXUPQkMKqoiNF7K8u+2paVhkMN9tBwHfvln2gg5zeO+eP64S/vDZKGbdSnBzvHW2hIeq8XDv2arkbukK7DhQ+LWGxJfarh2wLrAv5KnOMkfOnePoi3PzC5Gpyb5uS145qWgTpBz4to1ctM/eFOZWtS3jCBbEyzwHPs0KOtfGD+DiZnkfHrQnuruDUxHSTOCE1ymPwd8UZCC5DtizlmDDvKZQp66lWiILzJWKCm1axuzJewcQxlawWXUJicxGZKt7n48wSUAm8V5Vb7dYlsRtLaQyaVRqBs6aFa5XR7kZ7UqULedoNXNT2JBxZOIe/6OFaZKZzUCvBmH4UQMkzqGC2DxgyoO5AKYPzoX+WtMOHHJCLDL33cA==;5:hWtRgG+Pnic6/gXezaTCZJgYMyeGe0KYu+XCd/zcqdnCSadXMsroBQHwpL0W1u4cld6reGElTHanOiZytGwwkTwgpg2WKpuMzaJhbLr2rdh0+1ohttULx6A5ItUDDzmBzjA98Pr75cqZ8nR2OitPEcLuWaxJsYxXfWBOi7IEXwU=;7:jy1x9a7FjZB4EL+WZiXGpyb/lc1ySEcHE4JgLL7sstcOEGMCDlG7Xt3OxkSQLbhgpMVJEEQLPenj4euK7Km+HGSe6dzJNFaimIjCpzzfkH7eHrSxASfPYd7rJJ+ubPAh9o1U61L/EBC+ZG+LuFt5ABSHq6UWrF6PcknbUz9kYQ1CvIZEeSMHBTPMkPv0rtQBQbFcoUMndoMAJBgqMYvrSf9ncMZY+MRVC8kb6IqkFj4zdxFVi3Guddj8hRm6k9eu
x-ms-office365-filtering-correlation-id: db437a64-d689-4f71-33ba-08d61c4ac33b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150D66BB414DB144C9E3745FB1E0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(2900100001)(39060400002)(2501003)(6666003)(11346002)(107886003)(5250100002)(14454004)(26005)(10290500003)(36756003)(217873002)(7736002)(99286004)(305945005)(102836004)(72206003)(2616005)(86612001)(476003)(6346003)(186003)(486006)(54906003)(110136005)(446003)(6436002)(5660300001)(4326008)(256004)(86362001)(10090500001)(2906002)(6486002)(316002)(6512007)(53936002)(22452003)(66066001)(97736004)(76176011)(81156014)(81166006)(8676002)(3846002)(6116002)(8936002)(25786009)(6506007)(68736007)(105586002)(106356001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 9ZaubGf3DoTgozmjjPOvOWyqkvgPauABA7zCjfCCq8CM10GCZzXODTuRwtNt5vyyI6AUX+MAuSP/5bKkZeqLeZlemQ+wjmYZak8u0qNSYJ6+j6CrK4fkN+23d+9hHeOd6Vab44lg1v+ThbC+YrxfeQhaq6yfo31ExCwC8E+LrnwXT1PEzRcmOR+IC4zZtA9Mf4mPUekINqYOHHxTsGyRSxefxyg6/PJiptMIYKnoikNN96pOb8IW3lAmsLRSq2xNrft5qT8l8XbliKc7gKScWu4xzX0S5DVJCw7b8Xz2OsaBIqaUnejCdZHUqrYzGb4KOhAbmEo+YTMxiuLdz7augU+Qt2R14kHzXH5MTHZYAMg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db437a64-d689-4f71-33ba-08d61c4ac33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:48.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 85c634e919bd6ef17427f26a52920aeba12e16ee ]

When pcmcia_loop_config fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pcmcia_loop_config.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/tty/serial/8250/serial_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/=
serial_cs.c
index 4d180c9423ef..1a14948c86d6 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -629,8 +629,10 @@ static int serial_config(struct pcmcia_device * link)
 	    (link->has_func_id) &&
 	    (link->socket->pcmcia_pfc =3D=3D 0) &&
 	    ((link->func_id =3D=3D CISTPL_FUNCID_MULTI) ||
-	     (link->func_id =3D=3D CISTPL_FUNCID_SERIAL)))
-		pcmcia_loop_config(link, serial_check_for_multi, info);
+	     (link->func_id =3D=3D CISTPL_FUNCID_SERIAL))) {
+		if (pcmcia_loop_config(link, serial_check_for_multi, info))
+			goto failed;
+	}
=20
 	/*
 	 * Apply any multi-port quirk.
--=20
2.17.1
