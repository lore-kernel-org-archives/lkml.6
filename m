Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D8C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23DF27815
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mRcPOgd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23DF27815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeF1VPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:15:50 -0400
Received: from mail-bl2nam02on0050.outbound.protection.outlook.com ([104.47.38.50]:55233
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751757AbeF1VPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHunTRL14jSrua3TL2HgOxNZBlnNhNzQk7JlyN9UsXc=;
 b=mRcPOgd7P8yCiDIqBdoTCNbpo2ioAjjhCi6gItHU2nqPz6fQjRX4L3aCqD4VkB1WfvOYBKVtiIYjkUU+woYG4B9/t7UF3zjjnuQL2VQTONmAFWT7pzoHuojAWs0IJffL1tFWAhjF4SG0jNkD3ZlzvIppfw+pvhIJqV32wmaDsyc=
Received: from SN6PR05MB3997.namprd05.prod.outlook.com (52.132.123.32) by
 SN6PR05MB4480.namprd05.prod.outlook.com (52.135.74.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.10; Thu, 28 Jun 2018 21:15:46 +0000
Received: from SN6PR05MB3997.namprd05.prod.outlook.com
 ([fe80::a9ac:c481:b07e:1557]) by SN6PR05MB3997.namprd05.prod.outlook.com
 ([fe80::a9ac:c481:b07e:1557%3]) with mapi id 15.20.0906.025; Thu, 28 Jun 2018
 21:15:46 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Neil Horman <nhorman@tuxdriver.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        pv-drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmw_pvrdma: Release netdev when vmxnet3 module is removed
Thread-Topic: [PATCH] vmw_pvrdma: Release netdev when vmxnet3 module is
 removed
Thread-Index: AQHUDuhoN6dcSnHixEi4tSoFADFUjKR2BosAgAAMwgCAAA50gP//lgkA
Date:   Thu, 28 Jun 2018 21:15:46 +0000
Message-ID: <74E5B871-3D33-4C75-8FD4-C5D5BE2182AD@vmware.com>
References: <20180628135938.19625-1-nhorman@tuxdriver.com>
 <20180628185946.GC379@ziepe.ca>
 <20180628194526.GA14168@hmswarspite.think-freely.org>
 <20180628203709.GD379@ziepe.ca>
In-Reply-To: <20180628203709.GD379@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR05MB4480;7:b0i5PfL/eMz+oqxRyWCiCL/6wO87ADDpaypQ9jisznXJmQCzXdywm0JrXz+Qbf5w36gUG00UQJFEd//YkHkCtQ6ms9RJU1s7wKipBAA6kP2Xr8mHZC1gQmg8u7vn284IIbnwSHUNKZXnsypH9IzD4QDjDKaoAa+aYVZFSZRywObqrtwaGpWT0i8l9Y7ZbcXfF+jxdxB3QF/SRx0/pIto7AU+6Z2ts3dmNDGp4sPwPZQrOj2craYWn1mufWVk1g5M;20:QwNciFyFaRFqYwXe3OIsXPoLmX5koQTaoua4QvU0SVAfbwGnJjSJFPWZaMKFKdgtV9P+0Dh92Gc1Sew9yZAyFIf810f32T460x3D9pAiQKPFiDfd92HyYYbJiFc18KLWXZYZtvJiJ5/UPuzMxclVMRpSkK59tl6D8FC0hy2toxg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 19b440e0-772e-44c1-7f1d-08d5dd3c50a0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB4480;
x-ms-traffictypediagnostic: SN6PR05MB4480:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-microsoft-antispam-prvs: <SN6PR05MB4480970B43164288190FD107C54F0@SN6PR05MB4480.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR05MB4480;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB4480;
x-forefront-prvs: 0717E25089
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(486006)(82746002)(68736007)(93886005)(53546011)(99286004)(83716003)(6506007)(76176011)(110136005)(54906003)(316002)(2616005)(476003)(256004)(2900100001)(36756003)(6512007)(102836004)(186003)(5660300001)(4326008)(6246003)(26005)(53936002)(446003)(11346002)(25786009)(5250100002)(106356001)(7736002)(86362001)(97736004)(305945005)(8676002)(105586002)(6486002)(6436002)(2906002)(33656002)(229853002)(3846002)(6116002)(478600001)(8936002)(66066001)(81156014)(81166006)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4480;H:SN6PR05MB3997.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XJRocRD4yStYE4A3iVtvU2bxGAOgkgl24ECmKA+oLy7tjdWdD1jEzlGrF0B4B5XiJyNi3y89XRbmb89Jrw2itRD+pwiUlbTs4x05WrxUXAA4XuiomqSZsMIXgmnOJlHeM83ywe7j3dW+2SSuTDiHxyuexeHNLGmZZXeyS+TXz5uja2idyZGDtMpBp7It35U05334Sfav9z8pYLwqpHTStQjFB8GzYxU9fRFSC7NuvZ1i0lL5ku4Zj9QuI3Okt6Km2aIsl6svluDeYwus2/kH0menx5Nco98InyTxrmJn0/FBkXeagClYDfU40/YtVe8tbLX7pwvoMj8+9b5JhWKY3P/gv+pxDWDxY7ihSL27bV8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <306B4E0DDF4C6B4EB180D2418741FEA2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b440e0-772e-44c1-7f1d-08d5dd3c50a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2018 21:15:46.2483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4480
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yOC8xOCwgMTozNyBQTSwgIkphc29uIEd1bnRob3JwZSIgPGpnZ0B6aWVwZS5jYT4gd3Jv
dGU6DQo+IE9uIFRodSwgSnVuIDI4LCAyMDE4IGF0IDAzOjQ1OjI2UE0gLTA0MDAsIE5laWwgSG9y
bWFuIHdyb3RlOg0KPiA+IE9uIFRodSwgSnVuIDI4LCAyMDE4IGF0IDEyOjU5OjQ2UE0gLTA2MDAs
IEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiA+IE9uIFRodSwgSnVuIDI4LCAyMDE4IGF0IDA5
OjU5OjM4QU0gLTA0MDAsIE5laWwgSG9ybWFuIHdyb3RlOg0KPiA+ID4gPiBPbiByZXBlYXRlZCBt
b2R1bGUgbG9hZC91bmxvYWQgY3ljbGVzLCBpdHMgcG9zc2libGUgZm9yIHRoZSBwdnJtZGENCj4g
PiA+ID4gZHJpdmVyIHRvIGVuY291bnRlciB0aGlzIGNyYXNoOg0KPHNuaXA+DQo+ID4gPiA+IEBA
IC05NjIsNiArOTgyLDcgQEAgc3RhdGljIGludCBwdnJkbWFfcGNpX3Byb2JlKHN0cnVjdCBwY2lf
ZGV2ICpwZGV2LA0KPiA+ID4gPiAgCX0NCj4gPiA+ID4gIA0KPiA+ID4gPiAgCWRldi0+bmV0ZGV2
ID0gcGNpX2dldF9kcnZkYXRhKHBkZXZfbmV0KTsNCj4gPiA+ID4gKwlkZXZfaG9sZChkZXYtPm5l
dGRldik7DQoNClRoYXQgZG9lc24ndCBzZWVtIHJpZ2h0LiBJZiB0aGUgdm14bmV0MyBkcml2ZXIg
aXNuJ3QgbG9hZGVkIGF0IGFsbCBvciBmYWlsZWQNCnRvIGNyZWF0ZSBhIG5ldGRldiwgeW91IHdv
dWxkIGJlIHJlcXVlc3RpbmcgYSBob2xkIG9uIGEgTlVMTCBuZXRkZXYuIFdoYXQgaWYNCnlvdSBt
b3ZlZCB0aGlzIHRvIGFmdGVyIHRoZSBpZighZGV2LT5uZXRkZXYpIGNoZWNrPw0KDQo+ID4gPiA+
ICAJcGNpX2Rldl9wdXQocGRldl9uZXQpOw0KPiA+ID4gPiAgCWlmICghZGV2LT5uZXRkZXYpIHsN
Cj4gPiA+ID4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFpbGVkIHRvIGdldCB2bXhuZXQzIGRl
dmljZVxuIik7DQo+ID4gPiANCj4gPiA+IEkgc2VlIGEgbG90IG9mIG5ldyBkZXZfaG9sZCdzIGhl
cmUsIHdoZXJlIGFyZSB0aGUgbWF0Y2hpbmcNCj4gPiA+IGRldl9wdXRzKCk/DQo+ID4gPiANCj4g
SSdtIG5vdCBzdXJlIEknZCBjYWxsIDIgYWxvdCwgYnV0IHN1cmUsIHRoZXJlIGlzIGEgbmV3IGRl
dl9ob2xkIGluIHRoZQ0KPiBwdnJkbWFfcGNpX3Byb2JlIHJvdXRpbmUsIHRvIGhvbGQgYSByZWZl
cmVuY2UgdG8gdGhlIG5ldGRldiB0aGF0IGlzIGxvb2tlZCB1cA0KPiB0aGVyZS4gIEl0IGlzIGJh
bGFuY2VkIGJ5IHRoZSBORVRERVZfVU5SRUdJU1RFUiBjYXNlIGluDQo+IHB2cmRtYV9uZXRkZXZp
Y2VfZXZlbnRfaGFuZGxlLiAgVGhlIFVOUkVHSVNURVIgY2xhdXNlIGlzIGFsc28gYmFsYW5jaW5n
IHRoZQ0KPiBORVRERVZfUkVHSVNURVIgY2FzZSBvZiB0aGUgaGFubGRlciB0aGF0IGxvb2tzIHVw
IHRoZSBtYXRjaGluZyBuZXRkZXYgc2hvdWxkIGENCj4gbmV3IGRldmljZSBiZSByZWdpc3RlcmVk
LiAgTm90ZSB0aGF0IHdlIHdpbGwgb25seSBob2xkIGEgc2luZ2xlIGRldmljZSBhdCBhDQo+IHRp
bWUsIGJlY2F1c2UgYSBnaXZlbiBwdnJkbWEgZGV2aWNlIG9ubHkgcmVjb25nbml6ZXMgYSBzaW5n
bGUgdm14bmV0MyBkZXZpY2UNCj4gKHRoZSBvbmUgb24gZnVuY3Rpb24gMCBvZiBpdHMgb3duIGJ1
cy9kZXZpY2UgdHVwbGUpLg0KPiANCj4gSSBkb24ndCBzZWUgaG93IHRoZSBkZXZfaG9sZCBpbiBw
dnJkbWFfcGNpX3Byb2JlIGlzIHVuZG9uZSBkdXJpbmcNCj4gZXJyb3IgdW53aW5kIChlZyBnb3Rv
IGVycl9mcmVlX2NxX3JpbmcpDQo+IA0KPiBBbmQgSSBkb24ndCBzZWUgaG93IGl0IGlzIHB1dCB3
aGVuIHB2cmRtYV9wY2lfcmVtb3ZlKCkgaXMgY2FsbGVkLg0KDQpUaGF0J3MgcmlnaHQuIFRoZXNl
IHNlZW0gbWlzc2luZyBhcyB3ZWxsLiANCg0K
