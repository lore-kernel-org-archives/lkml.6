Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9EDC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE0220855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MabB2Ucq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE0220855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeIBRYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:24:55 -0400
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:56192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728996AbeIBRYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL60ATj2OnZcPFbqH+lGcHZiJhoA5tBR/CAJQ8CChIc=;
 b=MabB2UcqjN9zi/zr3RHnyrU7zjG+8oOuZ9TxhT/MSlNohSfdrcqKZbLjeWLDR1nEJjatSdYwj5v0te08t3Cvuv7uYqqlkT/2dY/7UMSUWef9AX52t5v250fWLjyqdypT/LePDmkMIfe76l5se0UPeCTZdC2OnqKCSrQkDBt7CBA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 10/62] misc: ti-st: Fix memory leak in the error
 path of probe()
Thread-Topic: [PATCH AUTOSEL 4.9 10/62] misc: ti-st: Fix memory leak in the
 error path of probe()
Thread-Index: AQHUQr4VWj7n+i6vCU+A4mE51z1SlA==
Date:   Sun, 2 Sep 2018 13:08:46 +0000
Message-ID: <20180902065131.183542-10-alexander.levin@microsoft.com>
References: <20180902065131.183542-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:qXFzBTyryj4FbINUXXrgjWoXGZO8bRxzKwlP5A7+q8vjxts8B+uHCAuykb/skwY7qn0mDsgQLTJBqb2xub2bsSMod/6aiwW41o9IzX/2uDPyv3we4FTrsV9RZTCKqvrnpptssgS0WM7stlqxWqPcZu694M4VhLMXC2V5QomMKHKFwA4J2tYZyq+PGiyqZo9LE25E6ZubJCgtIvauy7XvboWLcdDKyUXUGGI0UF1NBgXooEVkJjW/w43HZmruVyw+imLvfQwVfozluFxgk2ZPvAFpRtpLOtCdAi8Gj2ur+mpfBzIccrdvU4oZxPZqqAMV/qLxqXacXFwxmjIX/6RuoEgs1wV6T9cEv9KiJ5rQUxxzuFQKMhSibaFVvhxS67aJoDZb0OuLHOXdRdY3CGqEJ6FtRFjaLa3BoNdel0IEB0jHBTrtB8fpWG1KIE9L1nISM51D/SiSMFm01jnIUe6CRg==;5:kXKseGjDdEeJ0pxmf1c7nFOc1z20tWSDFPBvlOENMbrQcy4zkqpdkxRG3xX7WGZ7CcBluwbjUR2QU8rKZTAt1feMgFClTvGlgeJXLNyl9XdwWDs7XB3SkMyAyjNbf9i+nG8jyRcc1OAV2ybUDbEetPp4ZVGzS5A8yQRwrdqXD1Q=;7:4J2UAeBB0x8EYA/wi0ZWwco/lPSuqu5VnTNpFp6XY+5/Zrut5RmBU+YnSiB1C3FcA4IghrdLqJRRcPF2irthq29bVL3VM3k5O/unUkMAYqWkXUhDW8O5AHIFNzokkWxHEpxxdWP2P34dYRekRRx9VBRIt/AwAb4lQAEx8SdeWug3c+f7ExaIEMHds/C6QhSGDw1R+IL4MMgy6hd1v38MQqDkxbUJQUKml8QpfmwWQ7Uhu+OtrmP9E0UkiACkInz1
x-ms-office365-filtering-correlation-id: 91d4cca8-16b9-4935-e507-08d610d53dbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469AA2765ACBFA7E60D350AFB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(4477795004)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AZKW0vsfV8imh0U8s7qW+fxx5kIkKaAFMrPRg1DbqqWhT04WAe3a+NTrDUOVW/Qq8JKAC+FG8HwYjlGoiZwZsDuhvHCIZVlF3UKGjlGeJ0KA9ps3rbBTdIA5XnTI8lHmWHU2GV7AcEsU+vkHyHtO9bOnES5RXj9NAnE6UpS/9rF7NdNBIAkHCiPHwkG5aKdcYYWnupMeuPmEUyAlqNxh39x3dpEEqpxTHal1mgnHflYfFIp5vEI9il19jP2OJk76/L75DdWnmIqMd7jPeVoLtEk0TEZtwEMOoXfsJRyo/sJLwU60r+h0/5HDf0RErEj7ZCuMIyQzP5zpf0LwrpjW07YyOBEiGbMUTpSaWwrFInY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d4cca8-16b9-4935-e507-08d610d53dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:46.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 81ae962d7f180c0092859440c82996cccb254976 ]

Free resources instead of direct return of the error code if kim_probe
fails.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/ti-st/st_kim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index bf0d7708beac..9be64336461e 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -756,14 +756,14 @@ static int kim_probe(struct platform_device *pdev)
 	err =3D gpio_request(kim_gdata->nshutdown, "kim");
 	if (unlikely(err)) {
 		pr_err(" gpio %d request failed ", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
=20
 	/* Configure nShutdown GPIO as output=3D0 */
 	err =3D gpio_direction_output(kim_gdata->nshutdown, 0);
 	if (unlikely(err)) {
 		pr_err(" unable to configure gpio %d", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
 	/* get reference of pdev for request_firmware
 	 */
--=20
2.17.1
