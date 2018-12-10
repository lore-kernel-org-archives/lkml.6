Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E910C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588BA20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="f9ipNCe1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588BA20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeLJIlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:41:25 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:47791 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:41:23 -0500
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="21317792"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Dec 2018 01:41:22 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 10 Dec 2018 01:41:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6tDzFsXUsLGq8DM8wDFZGW8OGAxYUwvIsmScBtvY1k=;
 b=f9ipNCe140tZHuwFW2iMvvKbhTcD8OVWDvOqLmXTlucphgCG8qX2NTG13AFOgV1Jy69l0AL8wZhGvRC/qiKu3JhZlHzxoCM7Bv+Kr7Av1ESBXEt7L+5dUHfTTZ5XMIWaNR3G0nKMyjzgIcO8asfR1Jqq3YOaBaBoZ+3GXBWmkZc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1971.namprd11.prod.outlook.com (10.175.100.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 08:41:21 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 08:41:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wsa@the-dreams.de>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 1/2] i2c: enable buses to save their clock frequency in
 adapter
Thread-Topic: [PATCH v2 1/2] i2c: enable buses to save their clock frequency
 in adapter
Thread-Index: AQHUkGQg12gMYeerukaGe7imI+F8FQ==
Date:   Mon, 10 Dec 2018 08:41:21 +0000
Message-ID: <20181210084111.6938-2-tudor.ambarus@microchip.com>
References: <20181210084111.6938-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181210084111.6938-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::49) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1971;6:sSca5ZRTzULv5an9KHvg6gbEmfqAp0jZxHH17tr/wDTC4IWuCpcR1tHvI9LfJjeXinK589KSD8oGhHbG44HP9spsk59Mqx0Olk4PkVoCoLUVgn8Wrt4Yn9bFLwTGY7qr7wnxNXSIFnFJfYTUCkND5iCC2dIH+xCM1pfboaspXQiRx7JQRv267RjwQdPlIAVX3zBXxfOmuF2Cqv7SJGxpeis6VXnb5waR3DREFBuCaGMTqSXAin853jhmWfUJdzqGxNdFtReXqsKSKIlMiVCkAnWhFUs78WcNcjpFrVmAEAsHNV8zcjTKSNfD0T6rKgLRhbpdZJZI9V8aVp0sz96eC7xfXYBS4FhA4MhcMijg4BSqJRkDL5nl9+izE8jQprWO6JsSBYmXpMTfT/vnYQSyBCeYXZ0UljRp/B1B2bkDNH2wIPIEcwf2mSpNn6Lb2rp2gz7wLo0fQQ+8AsbnAFpG/Q==;5:ZeFRW0tvwA8LqutSsbtwLtMNBFgQp+wLxR7i3Fo60YslofrzJSVnVtdgZyzOvxKSgd5Yn3/3/0uxvLYVVunmnKITiHtpCjAvwlAMcGNIcSutFX/L3jMrQlCJNqnzs5txKTsvGfaeW0HbC9SDIY1UvhSXCVsjCdN5Q0l2i/rhjGA=;7:+KkSB7GyYW8zBT+E+0IbQWFkB6pcRal1ENV1PqwqxiJ8C/eUaUmXe59cqaYBX9eBvWoDniW1hO4bIDUiFASiz7p1OTJMQw3Z2wzJS12XpGnYtpJtkuZBbm7pj5zv2bdRaTyBt5nuNzvsDZzt+RmJZg==
x-ms-office365-filtering-correlation-id: 117ba36d-2814-48b1-9ef0-08d65e7b4294
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1971;
x-ms-traffictypediagnostic: BN6PR11MB1971:
x-microsoft-antispam-prvs: <BN6PR11MB197124CA3A38C2FAD1FE20B3F0A50@BN6PR11MB1971.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1971;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1971;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(1076002)(4326008)(5640700003)(107886003)(14454004)(26005)(71200400001)(6512007)(25786009)(54906003)(6486002)(71190400001)(97736004)(81156014)(81166006)(36756003)(6116002)(386003)(3846002)(6506007)(102836004)(1730700003)(8676002)(8936002)(99286004)(5660300001)(53936002)(2501003)(2906002)(76176011)(52116002)(305945005)(446003)(316002)(11346002)(476003)(486006)(2616005)(106356001)(14444005)(2351001)(6436002)(186003)(256004)(105586002)(68736007)(478600001)(66066001)(86362001)(7736002)(72206003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1971;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DVCpc3lJxAO66GOSN9IBeVv/HIEhy24dg/lee8Jj/Dfs7RkZOPX9hzugYBbRayrCWWdHw2fDmhAKhxrubjvf/rbbAENDyjYEncXIWAcLMdTEO2Vyva/AStX8XWpHJ3jvP44Hl5dzjuBC+ier1yDd6qFt7BEDaJI8gibAt0RePqCzU86+j06hp7zIhDqn96j6gQUsGCkwlo8rCZzVyzqkgeLQ+rxxp4fXEKyMgGJcXiaYVEqfvCTxVodgom6dZeESCkWPO3rVm5YA7/DPALd9VzhiDGAAK3EbaovMXq/yOf94gIspUhh6X/rwnRkGyo1C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 117ba36d-2814-48b1-9ef0-08d65e7b4294
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 08:41:21.3330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1971
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

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
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
v2: fix typo in R-b tag

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

