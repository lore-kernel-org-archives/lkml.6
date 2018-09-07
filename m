Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4043DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEAA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gj51zzlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEAA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbeIGFUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:06 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:29449
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731031AbeIGFTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umQxCuDeRLGh2fdTjFj4xs5lilJmw1apAK1AP9VDO5E=;
 b=Gj51zzlG0FXmSmN1xDNu7nCjtfoQr6Xz+jGxRV+QSQeYaq4B79ZyLo04v4f9R+nxELfQpLDveWxL/T7zdb/XVZtyvLbFu1IHa0o3Wz2SrYmQVSEODMGKbGpx1h7UnWtzJfg4d1wp+Dz0R/h7bJqQdEhdpv6wnt1KYyVuOTAkiik=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Keeping <john@metanate.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 09/30] dmaengine: pl330: fix irq race with
 terminate_all
Thread-Topic: [PATCH AUTOSEL 4.4 09/30] dmaengine: pl330: fix irq race with
 terminate_all
Thread-Index: AQHURkMsnuD/RCXpb02rgz+JK3X6Mg==
Date:   Fri, 7 Sep 2018 00:39:02 +0000
Message-ID: <20180907003853.57942-9-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0853;6:yPWQ0WbuXysFH0sHsNxVn3LVCUCk78Bs+ia8bO5raV54kH9ijfz+laVZMgrSJGofBM1ZbLtBU5CiDlBLAxnzoZnd7dt6LGSK/P9MRK+Qy4oyFoX4kDaeZBN4wdAzMr6SWaJiO7R+Rd4J6A4GhhijhNFpxhvmqGlh7i7koeIXguUjZIg1N3EJe5xKaB9hI50vb0Jqak4FryNA3aEP+IfjzfNfuNCt4Dk8QAGrRigOG9IFmVnsAo75Nmkirw0FpiTsun0bViuEiqIbaPYyOrLZA2XkN2ys/Hj0sVomobYJi9g5vUc5vQTF6NaGdZdVLAT9RGly5xVkxUcm6tq6c37nqWRS+bKZ9wEJGKK4Wymeo7CcCIsoDi13RDrtcOZIKb0hYvD+rWBtOZF3wwBVo/bpNuueurX66mHcqFowF5Ox58NMbezYUHmTUxI6zHD976R1CSvnWKIEM1WqEkD5unDW5w==;5:45fY3+Tl4Ns0bZHmP1KyxaOX7DPLBrygsWTL7wfyVNcfBhTP7jMATBY8/9dMEfdZc2KIVy1yrzFPfuOeoyM4NnACkcKPSa13QNJyH4OegehBLZC+fxaZfv166gvEhgOT/L00nC0vE2Yxa0LIf2k62RTxiTBEYrga6vQ8iDrwx+E=;7:n5iZJGcLA+S9UJUmNnio+wy8twWA27HowJDgVlOyZtzMfClobqFICwSv4fSpRfy48PyYwNu7ug4sgrsEKQHk05FYYgJdWN42BjdX7v+o19xNryZ0yxezGnh2pT7GTHlMRjUfkgVAJu5BFL4rXY5voStRDqsEHchDG392sprlzLghU6BvCtTWkv4W3jwaMHVUBNgFsBjiOqgfa36RYMpkh/aXk+tNyyJ/edosrSgqlCJEQpWyf3zEFlI/tHHc9DxW
x-ms-office365-filtering-correlation-id: ac85e6d2-0e18-4596-8cb6-08d6145aa61c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0853;
x-ms-traffictypediagnostic: CY4PR21MB0853:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08535B5E7BF4B6533309245CFB000@CY4PR21MB0853.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0853;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(217873002)(105586002)(106356001)(14444005)(256004)(1076002)(66066001)(3846002)(6116002)(4326008)(25786009)(107886003)(486006)(6436002)(6512007)(6666003)(53936002)(5660300001)(68736007)(102836004)(10290500003)(186003)(2906002)(2616005)(11346002)(476003)(2501003)(5250100002)(6506007)(446003)(110136005)(8936002)(36756003)(54906003)(76176011)(99286004)(26005)(2900100001)(81166006)(7736002)(81156014)(8676002)(14454004)(305945005)(6486002)(97736004)(72206003)(478600001)(86362001)(10090500001)(316002)(22452003)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ThVN0N8xyj8gJs/GKixZDToJnqfSyY5Ho59CevcYmKmK+DKYMH/inS8OfOzEDi9x9T0jJ/WqrUm3YRdNNnuAstHi4LuhkcYbCNBq3pB5st8g3hxh2+kedxOCQMZXDbtXeiUZaHWtHqNrh1rQgIGBhYCMmRErADG9toE7iGFu0ih8B3wA2f64ZAxPoW0thyBnCZDi0jxKMsPnFFDAlU7Fz+oIUunjyimJSb0PeHVoTIRsn4h9sYa8/cfo9fu5syDo23rW4w9YD8/ukj5figINXMnLXdjDVMf5FnX0Pu6BOS0vkPM89aJdqOUN9j9cnpxNiIligp5aFc/xEZx2I00dANHum6E2zcn4SJqge9kCyhc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac85e6d2-0e18-4596-8cb6-08d6145aa61c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:02.1756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Keeping <john@metanate.com>

[ Upstream commit e49756544a21f5625b379b3871d27d8500764670 ]

In pl330_update() when checking if a channel has been aborted, the
channel's lock is not taken, only the overall pl330_dmac lock.  But in
pl330_terminate_all() the aborted flag (req_running=3D=3D-1) is set under
the channel lock and not the pl330_dmac lock.

With threaded interrupts, this leads to a potential race:

    pl330_terminate_all	        pl330_update
    -------------------         ------------
    lock channel
                                entry
    lock pl330
    _stop channel
    unlock pl330
                                lock pl330
                                check req_running !=3D -1
    req_running =3D -1
                                _start channel

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/pl330.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 8db791ef2027..95619ee33112 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2132,13 +2132,14 @@ static int pl330_terminate_all(struct dma_chan *cha=
n)
=20
 	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
+
 	spin_lock(&pl330->lock);
 	_stop(pch->thread);
-	spin_unlock(&pl330->lock);
-
 	pch->thread->req[0].desc =3D NULL;
 	pch->thread->req[1].desc =3D NULL;
 	pch->thread->req_running =3D -1;
+	spin_unlock(&pl330->lock);
+
 	power_down =3D pch->active;
 	pch->active =3D false;
=20
--=20
2.17.1
