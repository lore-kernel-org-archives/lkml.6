Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D9CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F3B22CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bhH+4PxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F3B22CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934067AbeFVAtu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:49:50 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:21504
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933819AbeFVAts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB6qCwKFBQLIwQYjTLMZgMYgvar7Af+Q+ZacEsOtLLA=;
 b=bhH+4PxHT/heo68yc78tapNQtgq1HEVbxhKNL2B7SSkk5toG6bDMCi3WYQ9Lcf/sgrMbg4ATvnhrzhU1FhJzKLjl/6aX4WStd6LSpDBi/h6frW1Puc6oCjGd5a07bScemirEjLvFQOpoRE+JhVGh43pdBMrY+j1AeWAlxgG/BfU=
Received: from HE1PR04MB1450.eurprd04.prod.outlook.com (10.163.176.12) by
 HE1PR04MB1562.eurprd04.prod.outlook.com (10.164.48.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Fri, 22 Jun 2018 00:49:44 +0000
Received: from HE1PR04MB1450.eurprd04.prod.outlook.com
 ([fe80::6c56:638d:9996:7449]) by HE1PR04MB1450.eurprd04.prod.outlook.com
 ([fe80::6c56:638d:9996:7449%4]) with mapi id 15.20.0863.016; Fri, 22 Jun 2018
 00:49:44 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: RE: [PATCH] usb: chipidea: Fix ULPI on imx51
Thread-Topic: [PATCH] usb: chipidea: Fix ULPI on imx51
Thread-Index: AQHT+Dx9S+jGiJqO7k2zhWn8R6Ncp6Rp1dOAgAAELICAAPGKgIAAF74AgAADh4CAAKyKoA==
Date:   Fri, 22 Jun 2018 00:49:43 +0000
Message-ID: <HE1PR04MB1450D1881C07BEAEF4A8283B8B750@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <0f31d801-528e-54ee-f385-b7aa3eef414f@cogentembedded.com>
 <26d9fd57-07bc-0bba-2f29-ca778bd85328@cogentembedded.com>
In-Reply-To: <26d9fd57-07bc-0bba-2f29-ca778bd85328@cogentembedded.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1562;7:6hUe2gbiEo3IYZt/Z5zSpXUIRSRLnA1XHvnXUWx++Atbpx1iQQjXahhv2hH9eTNVqm4voszSUhOkqWBTpHNN5CwUz17rUm8cVn/TDKEMWbEFTJobKAHNaoznXhRB+soqEHbEV2KaUHFca5KtmEp5gVkueuGk3nQa5m50dpRm5r01UYEfP9LXAtZlMiri91k6Juyjv/WMN0x7vmvUFnaVgpRBz5O6+9Amp8pBHCSjyGqbzNunrS9XqhC+RgPaG4w6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bc88af13-f969-4edf-a805-08d5d7da0b9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1562;
x-ms-traffictypediagnostic: HE1PR04MB1562:
x-microsoft-antispam-prvs: <HE1PR04MB1562EAFB06E4040DEE54F1818B750@HE1PR04MB1562.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1562;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1562;
x-forefront-prvs: 071156160B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(199004)(189003)(99286004)(6436002)(86362001)(6246003)(229853002)(316002)(97736004)(8936002)(53936002)(105586002)(9686003)(2906002)(76176011)(3846002)(7696005)(8676002)(81166006)(106356001)(6116002)(55016002)(486006)(110136005)(446003)(476003)(54906003)(3660700001)(7736002)(81156014)(3280700002)(305945005)(44832011)(11346002)(74316002)(5250100002)(2900100001)(59450400001)(186003)(5660300001)(39060400002)(93886005)(68736007)(14454004)(66066001)(4326008)(33656002)(25786009)(478600001)(7416002)(102836004)(6506007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1562;H:HE1PR04MB1450.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RpzHwOYhDLBxDzRDdps7iywDcYX/wO64ojO4AyBqbhIrkTbMkRouSe2u63PEZQTRBiCtY5dHtiYJkcHqNcmzsbNnYk1ehdJt2zrGFiKOTz800cP90YLlb+L7olKX1RUCOElUAIObEfqXrqHDdT/m7UAhbhg9+nGgFSwCuqB6nRUD7ATXrNTxiTla99JQeg/PL5cnSPbNaO8PncC0U6QN+Gp6LJmvM6k8/+bNnDQKzlVxGGsfrXZcVqs0w7L1r6xpgR8tY85U15ZHVt6J4CBB5a1xmDxU8uHF5pmlPSoJuUVUqtfDI98UE2cWJ9Yc9deg66y5fkrMeOHqcKYDxUiJHQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc88af13-f969-4edf-a805-08d5d7da0b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2018 00:49:43.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1562
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+Pj4+DQo+ID4+DQo+ID4+IEkgbmV2ZXIgYXNzdW1lZCBpdCB3YXMgYSByZWdyZXNzaW9u
IGFuZCB0aGF0IFVTQiB3b3JrZWQgb24gUkRVMSBib2FyZA0KPiA+PiBiZWZvcmUsIHNvIEkgbmV2
ZXIgdHJpZWQgdG8gc2VlIGlmIHRoaXMgd2FzIGEgcmVncmVzc2lvbi4gSSBjYW4gb25seQ0KPiA+
PiB0ZWxsIHlvdSB0aGF0IGl0IGhhbmdzIGFzIHNvb24gYXMgYW55IFBPUlRTQyByZWdpc3RlcnMg
YXJlIGFjY2Vzc2VkLg0KPiA+DQo+ID4gSGFuZyBhdCByZWdpc3RlciBhY2Nlc3MgdXN1YWxseSBt
ZWFucyB0aGF0IG1vZHVsZSB0aGF0IG93bnMgdGhlDQo+ID4gcmVnaXN0ZXIgaXMgbm90IGNsb2Nr
ZWQuDQo+IA0KPiBPbiBSRFUxLCBjYWxsIHRvIHVzYl9waHlfaW5pdCgpIGFjdHVhbGx5IGNhbGxz
IHVzYl9nZW5fcGh5X2luaXQoKSB0aGF0IGRvZXMNCj4gcmVndWxhdG9yX2VuYWJsZSgpIGZvciAm
dnVzYl9yZWcgYW5kIGNsa19wcmVwYXJlX2VuYWJsZSgpIGZvciAmY2xrXzI2TV91c2IuICBJDQo+
IHRoaW5nIHNvbWUgb2YgdGhlc2UgdHdvIGlzIGFjdHVhbGx5IG5lZWRlZCB0byBhdm9pZCBoYW5n
IG9uIHJlZ2lzdGVyIGFjY2Vzcy4NCg0KRmFiaW8sIHdvdWxkIHlvdSBwbGVhc2UgY2hlY2sgYm90
aCByZWd1bGF0b3IgYW5kIGNsb2NrIGZvciBVTFBJIFBIWSBhcmUgb24gYXQgaW14NTFiYmc/DQoN
ClBldGVyDQo=
