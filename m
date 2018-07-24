Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB87ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7D120882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="US3Bs+A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7D120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbeGXM50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:57:26 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:13248
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388225AbeGXM50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXSJP7L32acKWAF6k23dBRvEcs1HZyqh1OSQSTnN+b0=;
 b=US3Bs+A98gdDoj0ggOz2GpRwNSbrenLmC3GY7AxXJRh4upfDdoKELqou/jwq2yzdXLrgoXwZK2kZuIXoQwrXngyibN9l4Z8QVURkzlNt/ZkcBo5Rf0Y2cHVHaYuoiwOYhTWP9cQ0yZWjS6msWSzvrwNjBShTIoE0Vm+2zb0nUmg=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5188.eurprd04.prod.outlook.com (20.177.42.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.4; Tue, 24 Jul 2018 11:51:16 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%4]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 11:51:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Sven.Schmitt@mixed-mode.de" <Sven.Schmitt@mixed-mode.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] soc: imx: gpc: fix PDN delay
Thread-Topic: [PATCH v3 1/3] soc: imx: gpc: fix PDN delay
Thread-Index: AQHUIzE2wa1SDOEVZU+1lGyGXEPU0qSeQt2A
Date:   Tue, 24 Jul 2018 11:51:16 +0000
Message-ID: <d30cde038ae7a28bf9264e4e1cc5612f4634e3f5.camel@nxp.com>
References: <1532425558626.11533@mixed-mode.de>
In-Reply-To: <1532425558626.11533@mixed-mode.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5188;6:XK7isikgOmAiTyy7qZJi9ZI8im0XVzUhhwshLbgb8SDrU3XPmpstJwnOUnb42JKFLLLaqVY/t7e4oyacy9JlbNssHVSZ14pNyvXurelr0so0P34nTXlscEGD55hd/ZyNR8+w0ZjhoSgKigFIvp+FwjMuat8s3hpggupdkUK9ilMNlXWdtqepn94eFDxCMES63qt3PdpZr5BZ0o5THfuwtjRQIJKY4sy7Oc+s/j9Al0hSNSQ3Y9GB/BgC3OGFeANniGzHOblwP3pGMCBjfoAsY6OMSx3hJHsO2VCqeTL16MYCUgHSe4KHLj4YctfVcdOie+Y8BdUc5E/YGsG1u4bORK8H2PjfJcPO2rO49Zxm3r1AAxC8WDe+L/zwXorQxIFXLf1+lMciAIdLBMi7yzRfYZQwjGSW2pkTCAghzLyT4W/3S9sFTvt11RG/viwowVeNx02Mk06HJp64yWUuRCU0gw==;5:Hod3cMyNLdXjk61nPXJMo79Yg7qZR0VUTLC2p86zgNH/q8nZfFE4sn1opSv775c12/5w8zqkGc+rtAv/iCOJQZsRBJ56b3AxAEVrPzNl/HCnXmTpxsYEX1QwokrKCoMzWzProow96Irrc9paTt7ry1bMybOE1D9us4eAEUYhaX8=;7:B/by5dfQxxs6tnwKeBoEf5BZ2eHeDvvSAbCIJj+8DXEgS/Ad/GRwxhn2NCMGz5+OCAmvVESwFXCW0EeSe/rTqcUblC+GFMRSHWwGZnI9RfU6gQk62LYpuYbrNpDo+yGjji96A8IPrq0X2/8nE1/9FwtMgAlKnZukpKqbevpOAXod48+dIMLWcW2L4m1tYUqM/cqMqyoGpmnYbTJMYIwRoNKbaEQgNCXEuIfZw7mO+mBXPkVxoDDjdWnOjVXuh1lj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4e5bda86-6fc4-43c4-d9b3-08d5f15bc36b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5188;
x-ms-traffictypediagnostic: AM0PR04MB5188:
x-microsoft-antispam-prvs: <AM0PR04MB5188BA6406FCA2A0FEF7D800EE550@AM0PR04MB5188.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5188;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5188;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(11346002)(6506007)(14454004)(102836004)(478600001)(44832011)(8676002)(186003)(26005)(476003)(76176011)(81166006)(68736007)(99286004)(7736002)(8936002)(2906002)(5660300001)(3846002)(81156014)(6116002)(2616005)(25786009)(53936002)(4326008)(305945005)(316002)(66066001)(54906003)(110136005)(6246003)(6486002)(97736004)(106356001)(118296001)(6512007)(105586002)(6436002)(256004)(2900100001)(446003)(86362001)(5250100002)(229853002)(486006)(36756003)(2501003)(50226002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5188;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ymedBndafcVw+AUFvrQNFkCyq9XVC6c1WXaPr7OCbv3cCWHucUry9JcfLaJhAiGfZ19R+JR/elykFNnjlppm6aDGV3su7m2VyL5w3etg21hsT0LoJQml7D56bVex2i0nH9za21sTHniim5QsX06ZILuh1N6x9en5IbXcsVXeWhY8K25Qm4GSZttvCRw40ukAm6l8V55fSL90Tp/QLVrx7FU83Zdx/jOsyIQQS/ndnqKLONMuokfEbvsQIbUHz5mW0IeCPvljlvRoXOG0Av0NwBoLiCqFjGm0LTuGqrxiK/dc4kWVClvRRX9XC96VXVsJZNedXdOcl9PB7jpwd9aC5nrIpEkWJ+wVGWKtoS8cNqc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <29681A3B87890945B9C6D2F59799D0F8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5bda86-6fc4-43c4-d9b3-08d5f15bc36b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 11:51:16.5111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTI0IGF0IDA5OjQ2ICswMDAwLCBTdmVuIFNjaG1pdHQgd3JvdGU6DQo+
IGlteDZfcG1fZG9tYWluX3Bvd2VyX29mZigpIHJlYWRzIGlzbyBhbmQgaXNvMnN3IGZyb20NCj4g
R1BDX1BHQ19QVVBTQ1JfT0ZGUyANCj4gd2hpY2ggc3RvcmVzIHRoZSBwb3dlciB1cCBkZWxheXMu
IA0KPiBTbyB1c2UgR1BDX1BHQ19QRE5TQ1JfT0ZGUyBmb3IgdGhlIGNvcnJlY3QgZGVsYXlzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU3ZlbiBTY2htaXR0IDxzdmVuLnNjaG1pdHRAbWl4ZWQtbW9k
ZS5kZT4NCg0KUmV2aWV3ZWQtYnk6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54
cC5jb20+DQoNCj4gLS0tIGEvZHJpdmVycy9zb2MvaW14L2dwYy5jDQo+ICsrKyBiL2RyaXZlcnMv
c29jL2lteC9ncGMuYw0KPiBAQCAtNzMsNyArNzMsNyBAQCBzdGF0aWMgaW50IGlteDZfcG1fZG9t
YWluX3Bvd2VyX29mZihzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0KPiAgCQlyZXR1
cm4gLUVCVVNZOw0KPiAgDQo+ICAJLyogUmVhZCBJU08gYW5kIElTTzJTVyBwb3dlciBkb3duIGRl
bGF5cyAqLw0KPiAtCXJlZ21hcF9yZWFkKHBkLT5yZWdtYXAsIHBkLT5yZWdfb2ZmcyArIEdQQ19Q
R0NfUFVQU0NSX09GRlMsICZ2YWwpOw0KPiArCXJlZ21hcF9yZWFkKHBkLT5yZWdtYXAsIHBkLT5y
ZWdfb2ZmcyArIEdQQ19QR0NfUEROU0NSX09GRlMsICZ2YWwpOw0KPiAgCWlzbyA9IHZhbCAmIDB4
M2Y7DQo+ICAJaXNvMnN3ID0gKHZhbCA+PiA4KSAmIDB4M2Y7DQogDQo=
