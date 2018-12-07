Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE82C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184262064D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pEzyTvtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184262064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGCug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:50:36 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:17184
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbeLGCug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/PHsj94BpRTSKgyYaCNnQaflbeAYWTgCdVUtxXMk5E=;
 b=pEzyTvtDPlmWKM+DeOGJ97ccIvq07iemWZfDVz7ppfe2+nDFl5fAuBEDJYS2Pug69v10Vnr6od8SX6b/eIYdOch92uR/wbA0KE/KIy698T/Z00mBHYE3rU0Zx2u8EMFpylo1l+03T3/Rsdf7nufEzQKdR5r8MudcW0fH5SQFeFE=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5798.eurprd04.prod.outlook.com (20.179.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Fri, 7 Dec 2018 02:50:32 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 02:50:32 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V3 0/4] spi: lpspi: Add Slave Mode support for LPSPI
Thread-Topic: [PATCH V3 0/4] spi: lpspi: Add Slave Mode support for LPSPI
Thread-Index: AQHUjdeeZOXxTsF77E64IWVEjqCCWw==
Date:   Fri, 7 Dec 2018 02:50:32 +0000
Message-ID: <20181207024924.6315-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0601CA0011.apcprd06.prod.outlook.com (2603:1096:3::21)
 To AM6PR04MB5016.eurprd04.prod.outlook.com (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5798;6:C58f3whWSVdGOnzAhocnDRMEljfGJ00NDkJsNo4OuOs4CTv9756/BU4yvottD9CJGnGVTONwgn1+VFt38f+yc7ZhDm/Mv1UEIMHCUQGwsGTc/cTBBs09XHfRIdSHO/v40DEe6wpnZNloNBtU3loDrFD2XngD4z+adzyPTq2dN6HfB8u36NIHlpVJy7pDzbkW72Zv+mb99PXT4owBSP4OLHqVKCzW3qF72odID8rg1omvMekmaa+m40cVYkDDt4iLF+8+hRHpnkL2JFKE4heI9FynZGdt846yRuIAlIZmG62yVrYKDUNSUSJPPgSdZM6XgUdpPc33Qv4REWZwer9+xD4r9lonlpOza3d1C02pFlRIG9OZBPIDDJYuk1XuIO0YpMBaWDA14R5HcAgU7qhDZlZjQRYDPY6iHr+xshHDQSctwbxWANbaTl9frZkMQ/o62uzEyQl1/mC8qpHkrgOYvQ==;5:OJ9RdIP910XBEl4dps0IS2t5sqav4J/Q6Sj1hBpW5X3WWoaKH64t2cbamNQ54a99sNZWH2xxBG02a92FqR7w96AkocSRUxx0RZj9XXtevW7gztWMpQOy2NTcpfrDKxCqEmQMnDrkZCaWiPIv1QufHozRsuNwBiIHtcOMdx1RRTo=;7:LrpfPLUu3QwarcPEpcD/knXiTVgRcDYel2jtcsISeotUfKUWAxEGgSB2EYAEoodK46hDgNtBF1cKGi/lW0SsPxsTRYeaCICp7/x5c0epFZWphMggEekmWZdLGxIVoFnuWEYspodGoIvRYami+QEqHA==
x-ms-office365-filtering-correlation-id: 88b0283b-cf5f-4ba6-40ca-08d65beec13f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5798;
x-ms-traffictypediagnostic: AM6PR04MB5798:
x-microsoft-antispam-prvs: <AM6PR04MB579823FE0D721300FA5EC74AF3AA0@AM6PR04MB5798.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5798;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5798;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(54534003)(189003)(199004)(71200400001)(476003)(316002)(54906003)(71190400001)(14454004)(25786009)(256004)(14444005)(6512007)(2501003)(6916009)(68736007)(52116002)(386003)(6506007)(2351001)(66066001)(6486002)(6436002)(5640700003)(4326008)(106356001)(99286004)(105586002)(53936002)(186003)(36756003)(478600001)(1730700003)(26005)(2906002)(6116002)(3846002)(86362001)(8676002)(1076002)(97736004)(486006)(102836004)(7736002)(305945005)(2616005)(8936002)(81166006)(81156014)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5798;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tWCD3YdX+kfW/ACIkb/RHyBHNeOXDlKc95QcXRyIpLzkMUWCHiE6tyJpWyKASjq4Y/BBzpt+z5CdIbu4QM3hZIXYF41b4rcoRIU9pd+sM2WSVNyCJ/lYMISpXwRZfmO0oCTTtiuPaibgFp5okaGmjg/VZq9UlxNZ/xyYz2sROFNSqKP4xbHvArQBZncnRhwIT8uQd0FFu8Rx1fv57Khx71nTAklEeduaxk6nou5h71PfhsR4bXMZZqtqI/blkgB61pZviLCz2Hm0xPZsRL5e/ktGmXe318fCi+zvHFSMRcQuaQmUezMAD33zLqTonKWVtzxDLyr7P0zeTCZtAfwgVSIvynPVWF4RIaAu6tRmiKA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b0283b-cf5f-4ba6-40ca-08d65beec13f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 02:50:32.6639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5798
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
3. Slave device only accepts transfer->len data. Any data longer than
   this from master device will be dropped. Any data shorter than this
   from master will cause LPSPI to stuck due to mentioned limitation 2.
4. Only PIO transfer is supported in Slave Mode.

Wire connection:
GND, SCK, MISO(to MISO of slave), MOSI(to MOSI of slave), SCS

Change log:
V2:=20
 - Split last version patch into 3 patches, and add the doc update.
V3:
 - Add more detailed description in commit message of the second patch.
 - Keep the description of "fsl,imx8qxp-spi" in spi-fsl-lpspi.txt in the
   fourth patch.

Clark Wang (4):
  spi: lpspi: Replace all "master" with "controller"
  spi: lpspi: Add slave mode support
  spi: lpspi: Let watermark change with send data length
  doc: lpspi: Document DT bindings for LPSPI slave mode

 .../devicetree/bindings/spi/spi-fsl-lpspi.txt |   4 +
 drivers/spi/spi-fsl-lpspi.c                   | 202 ++++++++++++------
 2 files changed, 138 insertions(+), 68 deletions(-)

--=20
2.17.1

