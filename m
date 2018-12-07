Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEF8C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377D120892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vw6X6Mvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377D120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLGLaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:30:04 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:16150 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGLaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:30:01 -0500
X-IronPort-AV: E=Sophos;i="5.56,326,1539673200"; 
   d="scan'208";a="21244721"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Dec 2018 04:29:59 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 7 Dec 2018 04:29:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp6jbCrmyN+Mx6bcOBu4cnrLl2XdCOmBW7CC210i4pU=;
 b=vw6X6Mvw6lDQNFWsxR6kH/tA7DkSFix3bj4i5FksbvJxtDEmUCFAe/HFT0pkuOzs++PqXblB/s1NaDBgEGXorkOYgg8vFlh4hBUjJiXIBBiewXcz+RXcOxmWGV3fCafypkYjIW+/u69Fw8RM94dDoVY5FvVBMVHp9jsBw8TvGqE=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1395.namprd11.prod.outlook.com (10.173.33.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Fri, 7 Dec 2018 11:29:58 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 11:29:58 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wsa@the-dreams.de>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [2nd RESEND PATCH 1/2] i2c: enable buses to save their clock
 frequency in adapter
Thread-Topic: [2nd RESEND PATCH 1/2] i2c: enable buses to save their clock
 frequency in adapter
Thread-Index: AQHUjiAuPcBol/ktREin2XNfhFOg2A==
Date:   Fri, 7 Dec 2018 11:29:57 +0000
Message-ID: <20181207112939.15791-2-tudor.ambarus@microchip.com>
References: <20181207112939.15791-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181207112939.15791-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:803:14::20) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1395;6:GlM1m/H5gjK6ExuGmLZxj+Gp/bssQUHZGVojpoiH5T301Ho1ydJoK5q5y4g48+WhICv/cLVSLu/uYjHFRdmpfIjoPmLN0oozU2ZnOclNJV1Jir8sNgxfl9mZz/9V84qvivMk3LzqUyelwGCU48kR2gTxs2c4td1eMbG0fsGVq76CjIOnKt95+JxPAEPvwmCXsrEFgiOYRWlb+Gs0oVilqMl3LFTocC7E6n1jYSdnQOFJKdWCBzthHraFDuAZ7PqIeV7NtCIvE0zrT3fGd5PtRRXTto0Nbcr/S/oqw65+U3dvWUBBKIKhRxuwooj89lPyOkF4hIMiC2TEzRgPMNGVGwBRo6IXjBJMlxCDSaiilgZ+op+zUdIGPzsZdQQNtv53BciamtRWYaeInPUi51MRQRzaT9JgCtXB65DXrSzuwKvsdWwAu0yK4uLykxVNdqEcWI2fa9b7tLB3jXmaGyhciw==;5:LVfGTdB0kGOeauhEo824nF6aKxrb1kyuP/whjcPI7PhACMlg2sc69uHzIUbx01gWAL+Uc2gp//XdS91q3cbNaLQDDEHvKoMWDdaG1bRwYDoucY1y1LsPGiJK5I/t+6PR2jWhG7l1YruVGI+4+Sd9uRwodJEeOwXdbkjrLBXIY7s=;7:HlrgjR99QHLkZ7DgRm0+1Yx6gory2ZcNQOknvrinbxg2YT5ko38k/FDng0FVAqbWq6dXlTct4rAUE/5oIdZdTkYs6/sTMQkHOzq+PbscENuQcWsClLMIZ9/kjWbOM+nD9uxZ8V5DUXmShT2yOxeR1w==
x-ms-office365-filtering-correlation-id: 2ff80368-74ff-4837-a121-08d65c375136
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1395;
x-ms-traffictypediagnostic: BN6PR11MB1395:
x-microsoft-antispam-prvs: <BN6PR11MB13954389621BBB652523A663F0AA0@BN6PR11MB1395.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1395;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1395;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(7736002)(6116002)(68736007)(107886003)(186003)(26005)(36756003)(6506007)(71190400001)(305945005)(386003)(316002)(2501003)(53936002)(54906003)(71200400001)(97736004)(2616005)(76176011)(6916009)(1076002)(446003)(99286004)(11346002)(476003)(66066001)(217873002)(72206003)(52116002)(6486002)(2351001)(86362001)(81166006)(8936002)(105586002)(6512007)(486006)(5640700003)(5660300001)(6436002)(4326008)(3846002)(478600001)(102836004)(14444005)(14454004)(81156014)(8676002)(106356001)(256004)(2906002)(25786009)(1730700003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1395;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9lD1GxnWE5m3JBvx2YY0ru7zeUd1diJU/mGoecZe/gICW23FdxhF4rhi8vWac73OxB1XkSlS3g1ByQH59p7ldCfo+6JJwxD0js9D8v5SuBOYn7VS77prBLhutvgfDX46ZvocCjm3KzS3lr3wiodSxFqonZ43mCGiYVGAVZmP75DnO1UQ8YmF8WTcnWOYj7eYiDbB+345pVdQK++dFhvxAS/dH6Pu2r4B6QfUFM/sA/1b0ZnzI7wUOgRrmuk8QVacRmMoFi3+WBu7Y2zbP/mZwtTWXE66NRIZVfHERoYfgZ3bnX0Arj+XMuz2y3EpNgv/lY5ZRXevmMCAUWaWR094x3QwGtDbmOzWGnWwz16eAB8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff80368-74ff-4837-a121-08d65c375136
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 11:29:57.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1395
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>

The clock-frequency property is not mandatory for the i2c buses. If it's
not present in the device tree, the buses __usually__ assume it's 100kHZ
(see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
clock-frequency, so the default clock frequency varies from bus to bus.

There are i2c clients that need to know the bus clock frequency in order to
compute their wake token (see atecc508a i2c client).

The clock-frequency value has to be propagated to the i2c clients, otherwis=
e,
if they will not find the i2c bus clock frequency in the device tree, they
will have to make their own assumption of the clock frequency.

Spare the i2c clients of making wrong assumptions of the i2c bus clock
frequency and enable the buses to save their clock frequency in adapter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviwed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 include/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..f238da204c49 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -677,6 +677,7 @@ struct i2c_adapter {
 	struct rt_mutex bus_lock;
 	struct rt_mutex mux_lock;
=20
+	u32 bus_freq_hz;
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
--=20
2.9.4

