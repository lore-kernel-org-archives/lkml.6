Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7F1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6708F20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qjdIRvbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6708F20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388166AbeGWIsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:48:52 -0400
Received: from mail-db5eur01on0089.outbound.protection.outlook.com ([104.47.2.89]:2555
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387964AbeGWIsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaEPMVJF0br1bCuL49OrLPYLqZUrPzIJMeOsbwbFOGs=;
 b=qjdIRvbbP6lqOdG292IikMX5lJyQVBgJon22QiQQDuSGIZ3j93A9OCayH4lSst6NmKrD8MI9jutsZHg5ZCOkANR6bMsBN7xAyOgsjBIcq8dWBS3pPdeFOjHgWfw1zzzAwlA2OwV7ev2MHoNrhzD/R8JnDhd/rG2co3hzFqeUFS4=
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com (52.133.39.11) by
 AM0PR0402MB3507.eurprd04.prod.outlook.com (52.133.45.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 07:48:54 +0000
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13]) by AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13%5]) with mapi id 15.20.0973.018; Mon, 23 Jul 2018
 07:48:54 +0000
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [PATCH] usb: dwc3: call set incr burst type func()
Thread-Topic: [PATCH] usb: dwc3: call set incr burst type func()
Thread-Index: AQHUIlAjEOBcZyuQLUKJ41YXj2nBWaScYQuAgAAJDIA=
Date:   Mon, 23 Jul 2018 07:48:54 +0000
Message-ID: <AM0PR0402MB3747D90C3CCC931128EEB108F4560@AM0PR0402MB3747.eurprd04.prod.outlook.com>
References: <1532328057-41777-1-git-send-email-pengbo.mu@nxp.com>
 <20180723070027.GB20056@kroah.com>
In-Reply-To: <20180723070027.GB20056@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pengbo.mu@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3507;6:lHJe4FI3qVmJRc8ofyYCd3A4NPSvZnWCcz4lwOFNMpu+x9l652qhhebGfUXgP2p7RYaJ/J4wAvd8/oo3ZhNByB/tXsg02Fu4IejouO0K1sDGv/ptPEk2A4tz+L5REOME9SlKiTfREBG0+CiTk7CwynvR7i3MJatmM8MPrg1XftVRZ/RS90ZxJfqYA2p4Qfxeg2YI4I2H/YhIjSTbf7ANPHd2R1waQqDrpmQXQQUuh85ocJK5WBpvkYjmpzLObSCm90IFi7cbBOmX3snyUjv3qYqglKqbC8GaWZnVtVOtdFJvWng5M8QiJmtu3D2/e0WPT1QEqiU0ES0Dsosr6kx+v9C+iP6b0rYhf9fJv5VkKLa81C47OKGVbsB3iy2Pl25C7yWm2xZ+Nl5iihgglWF6KZ102BNfw7TYqSPh/4yRWQYM/WkEpc/UFKFiOsbXaElQMam+Ts5U+RANE8K2hxSJVA==;5:Fh8lnxZpHVKQiq/rWN8vlA+MWh+4jxjtuYAfbLMBkGlxaIgFO9LsKjg3kcW6CC4L6/Rfw5+7l/jGntIOoGyp75A95mEsW18PA5ezKR7o32jCIopHfz1671/cWp7gajw+KykhUFtNFOAK6TokjNKsNLSopk8TEHNQMLCrwrG3UPA=;7:hseGZucZND2Jyf0XR/sNROEeMeo458uNXINSQoOagcs8OZD61SoCo14YW8w74f/jJq68VXKiwixix4VYikoRlLaYwADZosw+5HS3lmqmjAzTGGlvsyNBPzAQb1ceyQtYZ5HA7pTLxcU4hwWjV0sJlABDXadCGwiHN/5WueXN0LxnpZNcfixEZsrxyD8LKrNf2rG0FjsZ4toBQKOVhwUGsGE8FinMzvKv8Go572FAh0dEFSspRmlwMr+SRaKiXIk4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 63c405f1-f1dd-40aa-0f02-08d5f070bd7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3507;
x-ms-traffictypediagnostic: AM0PR0402MB3507:
x-microsoft-antispam-prvs: <AM0PR0402MB35073E825A5AEE6A1B1DC006F4560@AM0PR0402MB3507.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR0402MB3507;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3507;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(13464003)(54534003)(199004)(189003)(105586002)(106356001)(102836004)(186003)(66066001)(26005)(6506007)(478600001)(74316002)(53546011)(14444005)(2906002)(6436002)(7736002)(305945005)(316002)(9686003)(54906003)(55016002)(476003)(76176011)(486006)(99286004)(2900100001)(3846002)(5250100002)(6246003)(53936002)(25786009)(44832011)(11346002)(7696005)(5660300001)(6116002)(4326008)(8936002)(8676002)(81156014)(81166006)(14454004)(68736007)(97736004)(229853002)(6916009)(446003)(256004)(86362001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3507;H:AM0PR0402MB3747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qfob4J8Rhn3MlurxBin1lQ+4OE2zlx8Zl3MEwvYN24HoPFn7+/tusBD817iA4DGIv/5FdDwaY8Dvzt8WKfRTpUQrit7MMz5lMNiPuB/phop+YjWHosOmV7A2fNKdaaKiYBv6UvKXW/uMY2cFKnd1kfl84fYTWXusaDQXCbQap063SgBlp8RquD/a3twyJokPPasq2NddYBUj/QSdb01vFiu2/qStBrAoGgP1bFGpJnpjnedl8DPy3mziftujOYjcmqMso8XpToNzAF4fFR2Hr3aoCMuismL6SKSAoGHU9AxCyeoQmF7o+fk5thO1iWe8DfC5Q5eCyO/Sh6efpWCSizQ5Y5T1wCL+CMcjk4/DE04=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c405f1-f1dd-40aa-0f02-08d5f070bd7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 07:48:54.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBoYXZlIHJlYWxpemVkIHRoaXMgd2lsbCBjYXVzZSBjb25mdXNpb24uDQpXaWxsIHJlbWFrZSBp
dCAhDQoNClRoYW5rcywNClBlbmdibyBNdQ0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IEdyZWcgS3JvYWgtSGFydG1hbiBbbWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
XSANClNlbnQ6IDIwMTjE6jfUwjIzyNUgMTU6MDANClRvOiBQZW5nYm8gTXUgPHBlbmdiby5tdUBu
eHAuY29tPg0KQ2M6IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz47IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IFJhbiBXYW5nIDxy
YW4ud2FuZ18xQG54cC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSB1c2I6IGR3YzM6IGNhbGwg
c2V0IGluY3IgYnVyc3QgdHlwZSBmdW5jKCkNCg0KT24gTW9uLCBKdWwgMjMsIDIwMTggYXQgMDI6
NDA6NTdQTSArMDgwMCwgUGVuZ2JvIE11IHdyb3RlOg0KPiBDYWxsaW5nIGR3YzNfc2V0X2luY3Jf
YnVyc3RfdHlwZSgpIGluIGR3YzNfY29yZV9pbml0KCkuDQo+IFRoaXMgZnVuY3Rpb24gZW5hYmxl
ZCB0aGUgdW5kZWZpbmVkIGxlbmd0aCBJTkNSIGJ1cnN0IHR5cGUgYW5kIHNldCANCj4gSU5DUngu
IERpZmZlcmVudCBwbGF0Zm9ybSBtYXkgaGFzIHRoZSBkaWZmZXJlbnQgYnVyc3Qgc2l6ZSB0eXBl
LiBJbiANCj4gb3JkZXIgdG8gZ2V0IGJlc3QgcGVyZm9ybWFuY2UsIHdlIG5lZWQgdG8gdHVuZSB0
aGUgYnVyc3Qgc2l6ZSB0byBvbmUgDQo+IHNwZWNpYWwgdmFsdWUsIGluc3RlYWQgb2YgdGhlIGRl
ZmF1bHQgdmFsdWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nYm8gTXUgPHBlbmdiby5tdUBu
eHAuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MToNCj4gIC0gYWRkIHRoZSBjYWxsaW5nIG9m
IGR3YzNfc2V0X2luY3JfYnVyc3RfdHlwZS4NCg0KVGhpcyBpc24ndCB0aGUgY2hhbmdlbG9nIDoo
ICBZb3UgYWxzbyBkaWRuJ3QgdmVyc2lvbiB0aGUgcGF0Y2ggaW4gdGhlIFtQQVRDSF0gYXJlYSA6
KA0KDQpQbGVhc2UgcHV0IHRoaXMgYXMgcGFydCBvZiB0aGUgb3RoZXIgc2VyaWVzIHByb3Blcmx5
Lg0KDQp0aGFua3MsDQoNCmdyZWcgay1oDQo=
