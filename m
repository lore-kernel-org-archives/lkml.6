Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523B6C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDC920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="DTq4Vtxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDC920821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeLJIlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:41:22 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:31060 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:41:22 -0500
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="25047880"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Dec 2018 01:41:21 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 10 Dec 2018 01:41:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lijh/OlpYivOZJzVk1DnhteLODRPgsjl2aP+zafNg8U=;
 b=DTq4VtxoA8VApyrb4pxrkjrLvzjwwpa1XOCs52yO9w3Cygsy1kvkMcM38uyn5mW1QtzW5/+Yf7sGnvZvdwpc1HmVx4ZsSUaQoTiEcnmQks1O3HcVLT8BfYjyg3AtpzGSenPAm74pgoHSpDeaefLNqRur6D4v0dxO475H/cD21AE=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1971.namprd11.prod.outlook.com (10.175.100.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 08:41:19 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 08:41:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wsa@the-dreams.de>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 0/2] i2c: enable buses to save their clock frequency in
 adapter
Thread-Topic: [PATCH v2 0/2] i2c: enable buses to save their clock frequency
 in adapter
Thread-Index: AQHUkGQfwmV/50HjDkSt9Yybx87P2g==
Date:   Mon, 10 Dec 2018 08:41:19 +0000
Message-ID: <20181210084111.6938-1-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1971;6:re+VcVn271Zoi/R6NiaNU5SV//LyzFmGqc/8FLBkaF7RC/xlFjwE96uaJ2qYGn4f6vQq3dzjR6g20UWkbj9sG+ZuQLeumLaF58ztv4socKT8SMqrqw/zXt6EHv4rkm7AJAQTCdiJF1Ax3HjqJgnyyM7oVPfauqXjyb8EF8iqPKmTqwz5xl5dotT2ghanAyjPZTmYvpeh+gkvsR7HBwBdwpTVQUxxLtA/6jNYQ9VfWD5+RJpPn/MdXq5kJLAw++dTt+FmLjXAsxgMZxdr2HVClFIdvOsr4Og9vshUmzOU85QklCBn6PtkY9OpSpWEOPnVH+IQZImrP/sf8Vh0pn24Corueq/6Yj4ochs7pAjJ+lfgwvKNIBft3VeS2EGHDAnFsv4GAiESBFjr10Ukk+86s4xX3E+98UvFGqvfyI5lDjKECc5uj4YCzd7YYEi5UjAdNK1jZUGZZv8pKVDZmHi7Rg==;5:dj6JcAPC2goARBttTRvR/Z685oRV9tnUcvz8I449I6FADdaWU9NZD98hkzjpXzH5yySbsMJeXKNXgvfJAP8E69Lja7JQ0JM87aIgND0SYVrpdZFRNAUFeRGTJyw2LsmMdBSQor4on8k1Qq38DIrY5f5XfffRgMDkwpDx5aWfk8I=;7:/h49O0RYEZ0IBovc+jj9CVJQcrhxlpOyZAJI/X98K9T04KUjO7UXhrm+5I0D/eCXt+e0op+NkE1mpZsLXmg/IZek0pCyktZriW/x72BwoY+2bKkmgcaPbBH7H497UY0RW82QxGlPh+ttxz8qsO3PRA==
x-ms-office365-filtering-correlation-id: 33fb23f3-3cf1-497b-b0c6-08d65e7b4168
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1971;
x-ms-traffictypediagnostic: BN6PR11MB1971:
x-microsoft-antispam-prvs: <BN6PR11MB1971E4F1CC7BCC0630DD9259F0A50@BN6PR11MB1971.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1971;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1971;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(1076002)(4326008)(5640700003)(107886003)(14454004)(26005)(71200400001)(6512007)(25786009)(54906003)(6486002)(71190400001)(97736004)(81156014)(81166006)(36756003)(6116002)(386003)(3846002)(6506007)(102836004)(1730700003)(8676002)(8936002)(99286004)(5660300001)(53936002)(2501003)(2906002)(52116002)(305945005)(316002)(476003)(486006)(2616005)(106356001)(14444005)(2351001)(6436002)(186003)(256004)(105586002)(68736007)(478600001)(66066001)(86362001)(7736002)(72206003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1971;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pVczaC4LU+FR3tN/0t8YAK47o/HxLV5vEhXfPmsJKglj2RmQjjWCEmODyi/d91PW44iapv4HNhuZzHp/XStUgyGCt2HQEAhGtHdh2kyEsmjlOa4dCLQHoso51OhzxYLG607ZzkEHDygKjC/qDaym9QiQG6cAkyZEJ6/S5nrjHXAt7Nfeymn78TodUr918W4B7IP8fwAFlYl21vXWdi+mSheKuZ11V4dUERrptHmSVZw3V97mFn1bC0enfe8w2eSaeMKM5Q5W6mCQ0xuKCc7FDkY3LAHkNVKUY0zUbRICHvewZ7SvK0SL6QVl8ISLMVG3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fb23f3-3cf1-497b-b0c6-08d65e7b4168
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 08:41:19.4875
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

v2: fix typo in R-b tag
since rfc: reword commit messages

Tudor Ambarus (2):
  i2c: enable buses to save their clock frequency in adapter
  i2c: at91: Save the bus clock frequency in adapter

 drivers/i2c/busses/i2c-at91.c | 1 +
 include/linux/i2c.h           | 1 +
 2 files changed, 2 insertions(+)

--=20
2.9.4

