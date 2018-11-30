Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602ECC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C29D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 04:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uGxy2Waq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C29D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeK3PhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 10:37:06 -0500
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:52709
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbeK3PhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 10:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAvejjhDz+c9BmzTOIxrncxFQRQuWVci8zc5DQcDY14=;
 b=uGxy2Waql+eJY0nU5QAhBDP9X2DGP6uC0e0TBx11tydUt5oIHaJ2z5oCJjTZGOYtzmrjijJ593anQWhNJIKBFGpYDmFDGcQMKfwIADB5PZo6y/XjetNE+p7Ti37MNwdHWR909D7zpA3oTyx/hH/hPkYsI/61uDirZP/O/HBCKkc=
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com (20.177.50.90) by
 VI1PR04MB4413.eurprd04.prod.outlook.com (20.177.55.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 04:29:03 +0000
Received: from VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359]) by VI1PR04MB5021.eurprd04.prod.outlook.com
 ([fe80::d07c:4dc2:d18:c359%2]) with mapi id 15.20.1339.031; Fri, 30 Nov 2018
 04:29:03 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 0/4] spi: lpspi: Add Slave Mode support for LPSPI
Thread-Topic: [PATCH V2 0/4] spi: lpspi: Add Slave Mode support for LPSPI
Thread-Index: AQHUiGU5bPSGI+k3ukm6x9sv4SqCTg==
Date:   Fri, 30 Nov 2018 04:29:03 +0000
Message-ID: <20181130042753.28756-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To VI1PR04MB5021.eurprd04.prod.outlook.com
 (2603:10a6:803:59::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4413;6:5MczZP1KyVpZ19vh0quewGS9WFQNhcpEbqB9pq+BsdSRAgU5F8uUCvxydlY58IX5eVCJnQhIZLN7VFbwXPVD0GD4+m0BCdEKOrcwUhP/I0jRft6wooxh3APb2A1mshuQd498MPOgtdXs3y9k+nS10boYkOrCIFNbYF6pGaZKSaY1OvI3rP89bfhUklvYnqUYkyFK7rrsanebpZokbxUQntDw9LSFgv+F/L7BSxwv1T4KZXW+INVDGqOgD+OzeEToWlG91kCAaZpoOSdZfcvR5FL0xY58o58l+c8ost0aRuQodqFkKl0V7X1EO21b6wUOAHPF54up9SbEVv5Jm++JXVZ839iNL21g/vsKdz/3nMTqSKu32rs00Ceahg8/qgP0jUY+7SL7M28PUOsG81YANiOMHzPwLJr7jv/Rv7AVDcMsltaHQMR80+2vvjcr+cFXcRm/JW9SNDh6reR7GNa0tw==;5:Q34VSD+fV0ejG47Dr8sfVwkVCuiXLnm15t15zs3/W5iCf5RspD8m3yOJs0LdT6uinDLnUmV932k9eoy9QjrHNE3iL83XbMGKsXIwFCItq5oLhDb/l5sGb+Ufo0NtQDIfUWBEMPpt02QCZoJD1vhahbCYhtzrOrF7Ts5jwGU/XHo=;7:5ja+QKorjmp8weyG2NpZVw0OyO2c45boTpR/4age1hgwa/cY8C5D1/3tsCvINul+6hmIsnoTt412E5MNUiUImn/gI9wYnNCZt5qRwRMAET5kIlbbJlWJZfKyHCPFGAMooH8wzRvXISKqhpja8jFw2Q==
x-ms-office365-filtering-correlation-id: 6155e55f-56d0-47dd-5637-08d6567c5b33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4413;
x-ms-traffictypediagnostic: VI1PR04MB4413:
x-microsoft-antispam-prvs: <VI1PR04MB4413514958C6E1C518709388F3D30@VI1PR04MB4413.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4413;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4413;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(39860400002)(396003)(54534003)(199004)(189003)(81156014)(6436002)(53936002)(186003)(6506007)(81166006)(256004)(8676002)(6486002)(386003)(26005)(8936002)(14444005)(99286004)(52116002)(7736002)(316002)(36756003)(2616005)(54906003)(86362001)(305945005)(102836004)(71200400001)(2351001)(14454004)(478600001)(2501003)(71190400001)(68736007)(476003)(1730700003)(6512007)(5640700003)(6916009)(105586002)(3846002)(486006)(66066001)(25786009)(106356001)(2906002)(6116002)(97736004)(5660300001)(4326008)(1076002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4413;H:VI1PR04MB5021.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: k7oP0uKaIdtwSOIsmrHgmEirFkc5cXEv4UDWdKChUddG25CSpBJREqfFKvue/cM/3pCCCskJ86K6XoHca0vbA4IlHMf4JsI54gwKWndRzX8KqyHhBA0fMHaHVUCqRb2i5q+zVopWW1kcUxaxfg/83mYitJmimhuCD0rmYJSi251rIeRr2BIJHTDp7ArLAbrKBxxVQsOq5nSq/1Z9TjpocZxrLdTNbghq7RwYqCXG8QYURM3jxQ0Znxtse2qDFCHE0H40VQrv76aW8ghG/wccsbp2V9q9zlE6KFkx4OdZrsxmDJg4eE9RGEf6BYh6oA4IWI1SXWwMRfESz/50kxOvho4IEJ+sBuVkbZUUI64Vciw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6155e55f-56d0-47dd-5637-08d6567c5b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 04:29:03.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

i.MX LPSPI controller only works in Master mode previously. This patch
series adds support slave mode to LPSPI controller, including:
 - Replace all related structure names and object names which is named
   "master" with "controller",
 - adds SPI slave mode support for i.MX7ulp and i.MX8qm/qxp in PIO mode,
 - DT binding updates for slave mode.

Currently SPI Slave mode support patch has the following limitations:
1. The stale data in RXFIFO will be dropped when the Slave does any new
   transfer.
2. One transfer can be finished only after all transfer->len data been
   transferred to master device
3. Slave device only accepts transfer->len data. Any data longer than this
   from master device will be dropped. Any data shorter than this from
   master will cause LPSPI to stuck due to mentioned limitation 2.
4. Only PIO transfer is supported in Slave Mode.

Wire connection:
GND, SCK, MISO(to MISO of slave), MOSI(to MOSI of slave), SCS

Change log:
V2:=20
 - Split last version patch into 3 patches, and add the doc update.

Clark Wang (4):
  spi: lpspi: Replace all "master" with "controller"
  spi: lpspi: Add slave mode support
  spi: lpspi: Let watermark change with send data length
  doc: lpspi: Document DT bindings for LPSPI slave mode

 .../devicetree/bindings/spi/spi-fsl-lpspi.txt |   5 +-
 drivers/spi/spi-fsl-lpspi.c                   | 202 ++++++++++++------
 2 files changed, 138 insertions(+), 69 deletions(-)

--=20
2.17.1

