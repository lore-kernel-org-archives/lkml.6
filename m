Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC0C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C3A205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RK/vfIKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C3A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeIBR2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:28:19 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728746AbeIBRXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxq1Xet6iYZQ8nXG14ceLyjcn0KDo8jMueTJCZTAOTY=;
 b=RK/vfIKdnXUR/a9CzIacn9uiOOrMtbivilsxjQHCRvQE+G99iJA0YOTFW0uI4M78PB0MLhDe5gjV+n+CsbKgtdKw9/1J/8fFm0W1a5S9oddafzTxRsDmYOXroxtptw5yP/HiddLuON9D+afY01Ou2JEA7GP11GeDIWt7BY1fZEg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:46 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:46 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jinbum Park <jinb.park7@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 55/89] pktcdvd: Fix possible Spectre-v1 for
 pkt_devs
Thread-Topic: [PATCH AUTOSEL 4.14 55/89] pktcdvd: Fix possible Spectre-v1 for
 pkt_devs
Thread-Index: AQHUQr3gxWl9CLEDWE+4Ki9jA4+GXA==
Date:   Sun, 2 Sep 2018 13:07:17 +0000
Message-ID: <20180902064918.183387-55-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:A6hDdkPJhJ57m6SjNL+vNXgVMtTKksJ+V5tRPoLm06b3H4eAecSO/uamjhWVA5JduGSaNNOusRIZri4xxXPlmfCsbVsZa6d4+uAGI5J20nf9nvJcfrjqX0XQFbXlfFkNiZ911RlnJbtvJm86w99RjwzKO3UBjB8ao5dLUZ2klJkd2vZ3u7HG5eIGbDVrC1W24J7NSW9K+qtRFCmJw4eNga2UM9SKEulR6aBJK3O83ktltPHfW83v1ct5Bs0IN4xP11IiiNwGG1fIY/xOUfs0CcdTBIcTN9voQaYxjz4MeioH2vCnDD84sDiMxQFZ6OhDKDDXlZEPb4JKdRK+rGjjQ12tRMDk2mS/0DZKWX7Pgy0Uic4PbtbfABwdbPa9PjbOTjJN6vd7WBbEYOUBGidN4HYDkHsVwDjZepY/ST6ov1uziJv8ofrcaLl1mfhQpJIJvduUA7cNbDFV3giOGNBhFw==;5:rWw24WZJrnxfY6OXkTKwLZ5XfZ8GD5SGfCuixJQs7t//6DAyLjUt72Lmjzg25MQpI1FSt6VB4gW9n5SeM+mtxXI87bz2R/X/RrsxBcx9Af5E8XZKz0X+oDNH3YPkfdFsb5qcgeady8sQrQI1btcy+tVfEhnTVHuJBqa/C/EKduk=;7:LKOi1fW5B5TegFGB2leNNgkHI94RuhLfPpQ5rVqt74Mjrhxbp6WS7lycXWPosopfJSnoLepz34iySUusr0jkLG/UczxHMtV7pwxB6kquEsyMrt2D+DknzwHvPciMXat2bmWUsLVyv/usND8U83gvz/Q5fGw8x76EiP31VmaeYNkVOQUa364uUMAtagdpktzL28zMnAeAaRrZ+I88SaYVc+aZb4COf6me4cKph3G2cgqJ6aeWz9lel0bAFvmOSJ+M
x-ms-office365-filtering-correlation-id: 10b23134-2385-4459-c0de-08d610d513d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503135CD08F36F7CEAB5337FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(192374486261705)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(966005)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(39060400002)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(6306002)(5250100002)(133343001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: NxWUb+2LlhA8/0fGrEmu1UbTdQg77wKvdZKgEi2jqsxdeHIda+QIrLi5F8dXODPIW8H6pLOyELBPQjrDEr1TAzwsJtNmYCDZlR9nIfBQqMakQqFkJasW1gEVz6yrLmYM7V7afXFLXiEP1dOUQX35tLD2gs1i70+kcLTPDK4eCican1agm4BbEuqKILlfA7T35H/4ol0oeGwBuosa3JiyMQj3kw8lfCrh7pzXrWe1VwqagB79I7x/In91n8XRAOXsq1bIYLDNKp3RjCuUWA6tOMpbtbwdzJGf7+FNtQCiAd2dwt8qjSwH9Y1Kz25pRXA82MTWe1DkGmpcZL69gCJUWBVQToRIoLfcHdvTpTGJDHE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b23134-2385-4459-c0de-08d610d513d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:17.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinbum Park <jinb.park7@gmail.com>

[ Upstream commit 55690c07b44a82cc3359ce0c233f4ba7d80ba145 ]

User controls @dev_minor which to be used as index of pkt_devs.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of pkt_devs, [1]
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @dev_minor before using it to prevent attack.

[1] https://github.com/jinb-park/linux-exploit/
tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/block/pktcdvd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 531a0915066b..11ec92e47455 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -67,7 +67,7 @@
 #include <scsi/scsi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
-
+#include <linux/nospec.h>
 #include <linux/uaccess.h>
=20
 #define DRIVER_NAME	"pktcdvd"
@@ -2231,6 +2231,8 @@ static struct pktcdvd_device *pkt_find_dev_from_minor=
(unsigned int dev_minor)
 {
 	if (dev_minor >=3D MAX_WRITERS)
 		return NULL;
+
+	dev_minor =3D array_index_nospec(dev_minor, MAX_WRITERS);
 	return pkt_devs[dev_minor];
 }
=20
--=20
2.17.1
