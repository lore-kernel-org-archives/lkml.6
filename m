Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C093C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540BA20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GX7h7BWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfAPGsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:48:08 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:46048
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728367AbfAPGsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjC7m9W88gJibkRl3N7XKHTN/8Pax7jOvyefhG22enU=;
 b=GX7h7BWraxQPzNKVMZV+QH7/nO8LamrUoMycZg0BFJ02K8J7NyA9WD9KzEOuUhasd9dAOj0wBvAuiZ8T0Cr6BQkwebjLoOC65jo3DBSXYWLIGrHwwURh8x4CAx7Hw7wySTSwgmqFV7OlMhBQTc89Vqb0lYfeQx6OhJjWrCI9T7g=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 06:48:03 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 06:48:03 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 0/2] usb: dwc3: Add avoiding vbus glitch happen during xhci
 reset
Thread-Topic: [PATCH 0/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
Thread-Index: AQHUrWdtsUeeCB078U219GKYD8sTDw==
Date:   Wed, 16 Jan 2019 06:48:03 +0000
Message-ID: <20190116064820.20007-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0077.apcprd03.prod.outlook.com
 (2603:1096:203:72::17) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2785;6:Zs2YUmBQqHqsG2pr7Fg8jSNG5F1fjvhvPX/8DPIz9FmMwTEMgMi5X1aT56MegkLG9nnomCVznGCVoVxwNStuHgYSkZfYTMD0NuTXX/HJtuAs6QmpfwvMLgVDpdO3CjcP4UO4gM61e5xFFWr7CoQmlbyqjy6OL1HhKEpI6A4pejq2H3cVqLgkMZ2QfDxDIlPhMQL54ACHZEkxRuQNzN9b7PZjBoly71yFDBSemwfkcwI8m68Qa7brzbipShaZ8neF+NwyxBc7TfhNCwK39sF4Vio2HlTNMLreAhYMiAY1woMLx+w0kirhrBES4BEpMNaiDQVY6Boa9t4NxT1jaLH3JR08rsKDpje5cfUjrRRKlzJFOVON+uhwvTqCecn9ToGOt6xSGi5eTHq2bLE6gHn3azqE8ZHBEAE1aLG+izzb0jx7WM/34yEwSxiou+TbUkEKYBSH+J6DDTsvAHmKug1UEg==;5:XRgofvROm/q5jF3Spc5nZuPVJzXpkLlKhwn0xt8YFIYJtB6/c3x0Eus20AGjbPXPcuar4/FWIFwQFDMyO+Lb/nzapD3xKCkGy44tEFPCevtibYIiwTzLs8+Pz8jH+JrNiaPCpuiO9nDw5eFNHPKOgPseyLGu5L905JwSlMs2cHrZui4KDcmIeNvfUBvZy9M21SOHONGslZTgIujjGlQB3Q==;7:CXC6AwA3DPuZVecVP6LFt/KvReeAmzSKaZeNeTZxJoa2yanXZXlPpZrvfO0sJIEkiTTxFEfUhD1kYk+x6TXNiPBZE+bmBxogoTMh/373ELBbEExnBxHfIaRflVnziTV5Gpkz/A9nTQFKn/bEoc1+wg==
x-ms-office365-filtering-correlation-id: 0464a4cf-4933-4485-4d72-08d67b7e8fa3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2785;
x-ms-traffictypediagnostic: AM5PR0402MB2785:
x-microsoft-antispam-prvs: <AM5PR0402MB27856748085BCB4480326D73F1820@AM5PR0402MB2785.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(51874003)(189003)(199004)(106356001)(105586002)(5660300001)(99286004)(6436002)(6486002)(6512007)(4744005)(52116002)(316002)(54906003)(110136005)(6306002)(486006)(2616005)(476003)(36756003)(186003)(1076003)(71200400001)(71190400001)(25786009)(4326008)(14444005)(256004)(386003)(102836004)(26005)(6506007)(66066001)(53936002)(97736004)(86362001)(68736007)(478600001)(14454004)(50226002)(966005)(7736002)(2906002)(305945005)(6116002)(3846002)(8936002)(81166006)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2785;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ajCjshReypKj89EfOxmvNSOUuhBRl3N8ugs+D2N8nJ9lze7a4m+xmF6E8TrrH0TIjNEWed+GDetwwvstCjetAXQ+k02L9PPAnec8whWxf7CNo06zwWi2G8YZOD3ag9s75nWZJ0Qx7QWJl1D4jqppspSsvtJ2fRClUBme9JRFVfz4m5NeazM0HFBL55rqcFthfHiuKuRXp6sQjEW9cnEyleAKqaH3h6ShKpfW7qEfgebb02rD8xdYNqN93LypN1N1gSOmYpaVgIKJkPLd+yer8GNPfOwnpEJPwnXM4QCum2ZhdSbOke5OrdHjNhxIPoIk2rbZve9J7vl3mycHhCNnLGvl9D6D28Vu1pvnYEB8y+P3gzLroCOW/3oGrsp2fExBY9qXSzoYMg3CUXzGAmlDHtYr8L77jTP3K5mYn+FXhlk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0464a4cf-4933-4485-4d72-08d67b7e8fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:47:59.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This to fix USB enumeration compatibility issue found on DWC3 (host mode)
IP only.

Some pre-discussion mails can be referred from:
https://lkml.org/lkml/2018/11/23/387
https://lkml.org/lkml/2018/11/22/683

As to the workaround, I know programming xhci register in DWC3 dirver
(probe function) is not good from perspective of SW stack, but it seems
to be the only place to fix this real existing problem (test result show
that doing this in xhci-plat.c or xhci.c would not hlep on this kind of
failure). If who have better idea, please let me know, thanks in advanced.

Ran Wang (2):
 dt-bindings: Add workaround for host mode VBUS glitch when boot
 dwc3 core driver: Add avoiding vbus glitch happen during xhci reset

 Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
 drivers/usb/dwc3/core.c |   47 +++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/usb/dwc3/core.h |   10 +++++++++-
 3 files changed, 60 insertions(+), 0 deletions(-)
--=20
1.7.1

