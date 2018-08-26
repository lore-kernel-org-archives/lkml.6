Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D969C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 10:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04C8208A2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 10:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04C8208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hotmail.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeHZOhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 10:37:42 -0400
Received: from mail-oln040092072106.outbound.protection.outlook.com ([40.92.72.106]:20016
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbeHZOhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 10:37:41 -0400
Received: from VE1EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (10.152.18.51) by VE1EUR03HT082.eop-EUR03.prod.protection.outlook.com
 (10.152.18.192) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1080.9; Sun, 26
 Aug 2018 10:55:25 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com (10.152.18.56) by
 VE1EUR03FT053.mail.protection.outlook.com (10.152.19.198) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.20.1101.10 via Frontend Transport; Sun, 26 Aug 2018 10:55:25 +0000
Received: from AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::24cf:823c:758c:41b7]) by AM5PR0701MB2657.eurprd07.prod.outlook.com
 ([fe80::24cf:823c:758c:41b7%7]) with mapi id 15.20.1101.007; Sun, 26 Aug 2018
 10:55:24 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3] Fix range checks in kernfs_get_target_path
Thread-Topic: [PATCHv3] Fix range checks in kernfs_get_target_path
Thread-Index: AQHUFhtQ75qzmnRLgk6REyo6TeLGGaTSKlsA
Date:   Sun, 26 Aug 2018 10:55:24 +0000
Message-ID: <AM5PR0701MB265723084A8E48954B914CF4E4340@AM5PR0701MB2657.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2657711C49D0229DBED3A24EE4460@AM5PR0701MB2657.eurprd07.prod.outlook.com>
In-Reply-To: <AM5PR0701MB2657711C49D0229DBED3A24EE4460@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0053.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::21) To AM5PR0701MB2657.eurprd07.prod.outlook.com
 (2603:10a6:203:75::7)
x-incomingtopheadermarker: OriginalChecksum:B02A2BE6024F18A3536F61B306BC0B40DA846F888A9B57E004F7C9A22D59D555;UpperCasedChecksum:C0D57844E4C6C648288F642C416772E2786A57FFCAF3685330E77C0C914BA4BB;SizeAsReceived:7653;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/3qXxaSGLX4lTgKHr3i18ZlCvicBPLak]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR03HT082;6:8P2iuZm9T48WVRJULhvDjubbvktwhi95TNXDW4vY1DRgpf1+jR/47o0hqJl55HH8dao6Ymt4UOoPN/KcE2UhfXR4S37WxqamFyTvoqKB4IFM0QC4040L/qHfqheNdRCt3t5R/1xSdr7jz0Xn12gF2MR5iMMnfRCW1UyJ7qvflGnN5ZVPszrYBinscxfsavwT6COddYW4lXXoLX+dKRDtnT9yIfVd6Hw4GSuUbrYvJZsz2W/w3ErhS/fBffHD1TJ9GSrYtQagGzguwnQ+/0kqblIic7/vDIhiOnsyNBCIpgbMjjiNLyRVnwftGJX+t+qXTVhMSbSHYemjnRs4afjWwbBUaB0872Qp+Qzq6WlaotAQcC4PrpSTbihnOD7CD4P5tcoyk8AfslDFYyZ5tZkRTjyJgEzetZfj/UFLR01VQmFFBGBSFdIOC3B1rweykbPtbbU2d/opIXQMIkbJSlT+3g==;5:MEDZAzCsLVSo8hdBtvaUiO+Q2N+2xfUi80rayshmV/pQhUUltCCd3mSn6WxvBUsE0DdDnPSxeDVXstw4tdN2df+EjVLQ3zmF0ACavUtNET4m6jUzjaXiRaEh8Y+oI95cMMdwj4pST2qZD440bZL9LmkJLdUFQThX9J3Te42gp9s=;7:mxnZWS8Pp5Ct9uEQ4gwRMDE1b+3EcdoQ0+18P5mtQYbD1I0R1w5TOl5BqwXRvLEE8z8bFtKiRBlaSE1hHGVRzFr4NAxtYcn0REZq6Z66LB5GbH+P+pHrwQQLhC5lty/77vw0/0x+/Xc1rpq6nWCfCnJ/g7dI9ioQtvlg9TrQKFfYdyXZKu7vRoN6YzIIXL/pEwkeOeMv58igMCtBfOVbOFRpFiEhX6yhzAVECQInjLJIPtU1n3d284ciaslMtOtD
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:VE1EUR03HT082;
x-ms-traffictypediagnostic: VE1EUR03HT082:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR03HT082;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR03HT082;
x-forefront-prvs: 0776C39A48
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(476003)(6436002)(44832011)(55016002)(26005)(5250100002)(76176011)(53546011)(7696005)(110136005)(68736007)(11346002)(2900100001)(446003)(6346003)(6506007)(106356001)(105586002)(102836004)(386003)(104016004)(99286004)(33656002)(486006)(8936002)(14454004)(5660300001)(56003)(81156014)(14444005)(8676002)(74316002)(256004)(74482002)(82202002)(25786009)(6246003)(229853002)(97736004)(305945005)(86362001)(73972006)(2501003)(9686003)(75402003);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR03HT082;H:AM5PR0701MB2657.eurprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hotmail.de does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bernd.edlinger@hotmail.de; 
x-microsoft-antispam-message-info: Si/ZB+oOZq9kUnvUeqr1M0jx4j5h5IxL0NJhdLinpVj/peuNgKvUPDI2zSXeWUkl9+yM+/xNkOa4IURmKK2ks8dkdhIM1cGlkqRrMmCPHKkdGYafPUVA6kYDLzLAXIGSlvn3wil5tOcCLKlOvOQRF9rqED+j2QSsOc68UFFHEi+QfrjoOlxiJATnpMObbaBLNDjP6Jczy+diETKczy7gXfrRR5C1jb2mybcGtKsLTYY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E48E3FF339A6144A34DC183AF60672A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: a93407d2-4fbc-432d-0dc5-08d60b426ce6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2018 10:55:24.6930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KU29ycnksIEkgaGFkIGFjdHVhbGx5IGNvbXBsZXRlbHkgZm9yZ290dGVuIGFib3V0
IHRoaXMgb25lLg0KDQpPbiAwNy8wNy8xOCAxOTo1MiwgQmVybmQgRWRsaW5nZXIgd3JvdGU6DQo+
IFRoZSB0ZXJtaW5hdGluZyBOVUwgYnl0ZSBpcyBvbmx5IHRoZXJlIGJlY2F1c2UgdGhlIGJ1ZmZl
ciBpcw0KPiBhbGxvY2F0ZWQgd2l0aCBremFsbG9jKFBBR0VfU0laRSwgR0ZQX0tFUk5FTCksIGJ1
dCBzaW5jZSB0aGUNCj4gcmFuZ2UtY2hlY2sgaXMgb2ZmLWJ5LW9uZSwgYW5kIFBBR0VfU0laRT09
UEFUSF9NQVgsIHRoZQ0KPiByZXR1cm5lZCBzdHJpbmcgbWF5IG5vdCBiZSB6ZXJvLXRlcm1pbmF0
ZWQgaWYgaXQgaXMgZXhhY3RseQ0KPiBQQVRIX01BWCBjaGFyYWN0ZXJzIGxvbmcuwqAgRnVydGhl
cm1vcmUgYWxzbyB0aGUgaW5pdGlhbCBsb29wDQo+IG1heSB0aGVvcmV0aWNhbGx5IGV4Y2VlZCBQ
QVRIX01BWCBhbmQgY2F1c2UgYSBmYXVsdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlcm5kIEVk
bGluZ2VyIDxiZXJuZC5lZGxpbmdlckBob3RtYWlsLmRlPg0KPiAtLS0NCj4gIMKgZnMva2VybmZz
L3N5bWxpbmsuYyB8IDUgKysrKy0NCj4gIMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2tlcm5mcy9zeW1saW5rLmMg
Yi9mcy9rZXJuZnMvc3ltbGluay5jDQo+IGluZGV4IDA4Y2NhYmQuLjc3NGJhZGEgMTAwNjQ0DQo+
IC0tLSBhL2ZzL2tlcm5mcy9zeW1saW5rLmMNCj4gKysrIGIvZnMva2VybmZzL3N5bWxpbmsuYw0K
PiBAQCAtNjMsNiArNjMsOSBAQCBzdGF0aWMgaW50IGtlcm5mc19nZXRfdGFyZ2V0X3BhdGgoc3Ry
dWN0IGtlcm5mc19ub2RlDQo+ICDCoMKgwqDCoMKgwqDCoMKgIGlmIChiYXNlID09IGtuKQ0KPiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiANCj4gK8KgwqDCoMKgwqDCoMKgIGlm
ICgocyAtIHBhdGgpICsgMyA+PSBQQVRIX01BWCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FTkFNRVRPT0xPTkc7DQo+ICsNCj4gIMKgwqDCoMKgwqDCoMKgwqAgc3RyY3B5KHMs
ICIuLi8iKTsNCj4gIMKgwqDCoMKgwqDCoMKgwqAgcyArPSAzOw0KPiAgwqDCoMKgwqDCoMKgwqDC
oCBiYXNlID0gYmFzZS0+cGFyZW50Ow0KPiBAQCAtNzksNyArODIsNyBAQCBzdGF0aWMgaW50IGtl
cm5mc19nZXRfdGFyZ2V0X3BhdGgoc3RydWN0IGtlcm5mc19ub2RlDQo+ICDCoMKgwqDCoCBpZiAo
bGVuIDwgMikNCj4gIMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+ICDCoMKgwqDC
oCBsZW4tLTsNCj4gLcKgwqDCoCBpZiAoKHMgLSBwYXRoKSArIGxlbiA+IFBBVEhfTUFYKQ0KPiAr
wqDCoMKgIGlmICgocyAtIHBhdGgpICsgbGVuID49IFBBVEhfTUFYKQ0KPiAgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVOQU1FVE9PTE9ORzsNCj4gDQo+ICDCoMKgwqDCoCAvKiByZXZlcnNlIGZp
bGx1cCBvZiB0YXJnZXQgc3RyaW5nIGZyb20gdGFyZ2V0IHRvIGJhc2UgKi8NCg==
