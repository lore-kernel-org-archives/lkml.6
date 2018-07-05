Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A75C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FF4208A1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YlcoeRPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FF4208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754364AbeGEVL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:11:57 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:11712
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754304AbeGEVL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5IUo/rb2dw1FquKIamxPSkThfhAHOA8j0fsdVgB318=;
 b=YlcoeRPvTz0RqIdJW+dQDC6JXTiOv8ExBuctqOvQie76LMRPafwWs5r7CvRr0eDtF5haL3E2nLEXaEUFk8a6lQWWbDiJYKdJvt6TrErgpEBjpgbY7SbIG5LiHHOwHqCXSsVdnz6CBtsqXo7DROoiNz/ImM4JrLzJ1KSGHvBgBmk=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0891.namprd21.prod.outlook.com (52.132.152.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Thu, 5 Jul 2018 21:11:53 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b%2]) with mapi id 15.20.0952.008; Thu, 5 Jul 2018
 21:11:53 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Thread-Topic: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Thread-Index: AQHUEyH9R1sw7hnGhUy3uKImudYi5KR/PNWAgAF9s6CAAAuaAIAAQyQA
Date:   Thu, 5 Jul 2018 21:11:53 +0000
Message-ID: <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
 <20180704161039.GA23658@gmail.com>
 <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705153820.GA26768@gmail.com>
In-Reply-To: <20180705153820.GA26768@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:2:f0c2:475b:c15e:e46d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0891;7:6npaW3HGCol4tZQn26ug/LXI5RE8GZrzrYtOYDrVNS72XYKfAVagN+EbZpTy4NqpuLh+77v9+ZXzr1v/olTGu4BPBpC2Wc7uPDfqjReKNXvogDoJJrMmovftCMY843Gnsjl3+rODR2ubcLtu763x8ded7A2T5LtW4C0T/lx6pt6M3FAoIW/8oKbY+Bu/jo2pCbbYkeJqKSm9LFdiBDyB0ZOL6INfNyqw8J100ThOMHu9ZFJWjUE80dJ6bd/rmA6P
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 61fd169f-2f36-47b9-b2fc-08d5e2bbeebd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:MW2PR2101MB0891;
x-ms-traffictypediagnostic: MW2PR2101MB0891:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB08910D27DCBF7B39994D9ED1A0400@MW2PR2101MB0891.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231280)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0891;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0891;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(136003)(396003)(13464003)(189003)(199004)(99286004)(4326008)(446003)(86612001)(76176011)(46003)(6246003)(186003)(9686003)(8936002)(316002)(11346002)(7696005)(81166006)(53936002)(97736004)(86362001)(8676002)(81156014)(6116002)(74316002)(54906003)(93886005)(105586002)(7416002)(106356001)(7736002)(8990500004)(25786009)(22452003)(10090500001)(305945005)(5250100002)(2906002)(6506007)(68736007)(53546011)(229853002)(14454004)(486006)(6916009)(102836004)(478600001)(10290500003)(256004)(2900100001)(14444005)(5660300001)(6436002)(476003)(55016002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0891;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1295VfPKnoEh391ujLV+i5cObx65q6sut40wdnehzSrA3BlG9W7dTxBqGwoWggvwFrxplEwrjggkv7BzrH2O847+dG1T31lOwW7XVI03rHJ357Z0tzBzAENWEFEifqkOejGfiiYHkuUipfj1DOu63ezXnrvqJ4XIJ5/VBT6mBuSxrfS60tlyDp0ZC48FQ8d9uLW6/tJZN74eXwA1rvIQ2MmJPGdCU15MBO8oW8h17rthAyOsANyuq8vKTHotSYACTWGR3X1lxDfxo3IMx8EUq5JPRIv+nzT2K466RsXVqNed9VUIKsuzbzW+4nr15z9YaCbH3sYMs6FfQU6r+bbyEwUQwBZksehVzdgli0g/pmo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fd169f-2f36-47b9-b2fc-08d5e2bbeebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 21:11:53.3363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0891
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW5nbyBNb2xuYXIgPG1p
bmdvLmtlcm5lbC5vcmdAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgSW5nbyBNb2xuYXINCj4gU2Vu
dDogVGh1cnNkYXksIEp1bHkgNSwgMjAxOCA4OjM4IEFNDQo+IFRvOiBLWSBTcmluaXZhc2FuIDxr
eXNAbWljcm9zb2Z0LmNvbT4NCj4gQ2M6IHg4NkBrZXJuZWwub3JnOyBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmVsQGxpbnV4
ZHJpdmVycHJvamVjdC5vcmc7IG9sYWZAYWVwZmxlLmRlOw0KPiBhcHdAY2Fub25pY2FsLmNvbTsg
amFzb3dhbmdAcmVkaGF0LmNvbTsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBocGFAenl0b3IuY29t
OyBTdGVwaGVuIEhlbW1pbmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT47IE1pY2hhZWwNCj4g
S2VsbGV5IChFT1NHKSA8TWljaGFlbC5ILktlbGxleUBtaWNyb3NvZnQuY29tPjsgdmt1em5ldHNA
cmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gWDg2L0h5cGVyLVY6OiBGaXgg
dGhlIGNpcmN1bGFyIGRlcGVuZGVuY3kgaW4gSVBJDQo+IGVubGlnaHRlbm1lbnQuDQo+IA0KPiAN
Cj4gKiBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT4gd3JvdGU6DQo+IA0KPiA+DQo+
ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBJbmdvIE1v
bG5hciA8bWluZ28ua2VybmVsLm9yZ0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBJbmdvDQo+IE1v
bG5hcg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDQsIDIwMTggOToxMSBBTQ0KPiA+ID4g
VG86IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPg0KPiA+ID4gQ2M6IHg4NkBrZXJu
ZWwub3JnOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbGludXgtDQo+ID4gPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBkZXZlbEBsaW51eGRyaXZlcnByb2plY3Qub3JnOyBvbGFmQGFlcGZs
ZS5kZTsNCj4gPiA+IGFwd0BjYW5vbmljYWwuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyB0Z2x4
QGxpbnV0cm9uaXguZGU7DQo+ID4gPiBocGFAenl0b3IuY29tOyBTdGVwaGVuIEhlbW1pbmdlciA8
c3RoZW1taW5AbWljcm9zb2Z0LmNvbT47DQo+IE1pY2hhZWwNCj4gPiA+IEtlbGxleSAoRU9TRykg
PE1pY2hhZWwuSC5LZWxsZXlAbWljcm9zb2Z0LmNvbT47DQo+IHZrdXpuZXRzQHJlZGhhdC5jb20N
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBYODYvSHlwZXItVjo6IEZpeCB0aGUgY2ly
Y3VsYXIgZGVwZW5kZW5jeSBpbiBJUEkNCj4gPiA+IGVubGlnaHRlbm1lbnQuDQo+ID4gPg0KPiA+
ID4NCj4gPiA+ICoga3lzQGxpbnV4b25oeXBlcnYuY29tIDxreXNAbGludXhvbmh5cGVydi5jb20+
IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gRnJvbTogIksuIFkuIFNyaW5pdmFzYW4iIDxreXNAbWlj
cm9zb2Z0LmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIElQSSBoeXBlcmNhbGxzIGRlcGVuZCBv
biBiZWluZyBhYmxlIHRvIG1hcCB0aGUgTGludXggbm90aW9uIG9mIENQVQ0KPiBJRA0KPiA+ID4g
PiB0byB0aGUgaHlwZXJ2aXNvcidzIG5vdGlvbiBvZiB0aGUgQ1BVIElELiBUaGUgYXJyYXkgaHZf
dnBfaW5kZXhbXQ0KPiBwcm92aWRlcw0KPiA+ID4gPiB0aGlzIG1hcHBpbmcuIENvZGUgZm9yIHBv
cHVsYXRpbmcgdGhpcyBhcnJheSBkZXBlbmRzIG9uIHRoZSBJUEkNCj4gPiA+IGZ1bmN0aW9uYWxp
dHkuDQo+ID4gPiA+IEJyZWFrIHRoaXMgY2lyY3VsYXIgZGVwZW5kZW5jeS4NCj4gPiA+ID4NCj4g
PiA+ID4gRml4ZXM6IDY4YmI3YmZiNzk4NSAoIlg4Ni9IeXBlci1WOiBFbmFibGUgSVBJIGVubGln
aHRlbm1lbnRzIikNCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSy4gWS4gU3Jpbml2
YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+DQo+ID4gPiA+IFRlc3RlZC1ieTogTWljaGFlbCBLZWxs
ZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgYXJjaC94
ODYvaHlwZXJ2L2h2X2FwaWMuYyAgICAgICB8IDUgKysrKysNCj4gPiA+ID4gIGFyY2gveDg2L2h5
cGVydi9odl9pbml0LmMgICAgICAgfCA1ICsrKystDQo+ID4gPiA+ICBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9tc2h5cGVydi5oIHwgMiArKw0KPiA+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0KPiA+ID4gVWdoLCB0aGlzIHBhdGNoIHdh
c24ndCBldmVuIGJ1aWxkIHRlc3RlZCwgb24gNjQtYml0IGFsbHllcy9hbGxtb2Rjb25maWc6DQo+
ID4gPg0KPiA+ID4gIGFyY2gveDg2L2h5cGVydi9odl9hcGljLmM6IEluIGZ1bmN0aW9uIOKAmF9f
c2VuZF9pcGlfbWFza+KAmToNCj4gPiA+ICBhcmNoL3g4Ni9oeXBlcnYvaHZfYXBpYy5jOjE3MTo0
OiBlcnJvcjogbGFiZWwg4oCYaXBpX21hc2tfZG9uZeKAmSB1c2VkIGJ1dA0KPiBub3QNCj4gPiA+
IGRlZmluZWQNCj4gPiA+ICBzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjMxNzogcmVjaXBlIGZvciB0
YXJnZXQgJ2FyY2gveDg2L2h5cGVydi9odl9hcGljLm8nDQo+ID4gPiBmYWlsZWQNCj4gPiA+ICBt
YWtlWzJdOiAqKiogW2FyY2gveDg2L2h5cGVydi9odl9hcGljLm9dIEVycm9yIDENCj4gPg0KPiA+
IFNvcnJ5IEluZ28uIEkgaGFkIGEgY2xlYW4gYnVpbGQgb24gdGhlIGxpbnV4LW5leHQgdHJlZSAo
dGFnOiBuZXh0LTIwMTgwNzAyKQ0KPiB0aGF0DQo+ID4gSSB1c2VkIHRvIGJhc2UgdGhpcyBwYXRj
aC4gV2hhdCB3YXMgdGhlIHRyZWUgeW91IGFwcGxpZWQgdGhlIHBhdGNoIHRvPw0KPiANCj4gSWYg
eW91IGxvb2sgYXQgdGhlIGVycm9yIG1lc3NhZ2UsIGl0IHdvbid0IGJ1aWxkIGFnYWluc3QgKmFu
eSogdHJlZSwgYmVjYXVzZQ0KPiB0aGVyZSdzIG5vICdpcGlfbWFza19kb25lJyBsYWJlbCBlaXRo
ZXIgaW4gdGhlIGtlcm5lbCBzb3VyY2UsIG9yIGludHJvZHVjZWQNCj4gYnkgdGhlIHBhdGNoLg0K
PiANCj4gU28gd2hhdGV2ZXIgdHJlZSB5b3UgdXNlZCBpdCBvbiwgaWYgeW91IGJ1aWxkIGFyY2gv
eDg2L2h5cGVydi9odl9hcGljLm8gaXQNCj4gc2hvdWxkDQo+IGJlIGJyb2tlbi4NCg0KSW5nbywN
Cg0KSSBhbSBjb25mdXNlZC4gVGhlIGxhYmVsIGlwaV9tYXNrX2RvbmUgd2FzIGludHJvZHVjZWQg
aW4gdGhpcyBwYXRjaA0KKHRoZSBwYXRjaCB1bmRlciBxdWVzdGlvbiBmaXhlcyBhIGNpcmN1bGFy
IGRlcGVuZGVuY3kgaW4gdGhpcyBwYXRjaCk6DQoNCmNvbW1pdCA2OGJiN2JmYjc5ODVkZjJiZDE1
YzJkYzk3NWNiNjhiN2E5MDE0ODhhDQpBdXRob3I6IEsuIFkuIFNyaW5pdmFzYW4gPGt5c0BtaWNy
b3NvZnQuY29tPg0KRGF0ZTogICBXZWQgTWF5IDE2IDE0OjUzOjMxIDIwMTggLTA3MDANCg0KICAg
IFg4Ni9IeXBlci1WOiBFbmFibGUgSVBJIGVubGlnaHRlbm1lbnRzDQoNCiAgICBIeXBlci1WIHN1
cHBvcnRzIGh5cGVyY2FsbHMgdG8gaW1wbGVtZW50IElQSTsgdXNlIHRoZW0uDQoNCiAgICBTaWdu
ZWQtb2ZmLWJ5OiBLLiBZLiBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT4NCiAgICBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCiAgICBSZXZp
ZXdlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQoNClRoaXMg
cGF0Y2ggd2FzIGNvbW1pdHRlZCBieSBUaG9tYXMgc29tZSB3ZWVrcyBhZ28gYW5kIGlzIGluIGxp
bnV4LW5leHQuDQpUaGlzIHBhdGNoIGlzIGFsc28gaW4gNC4xOC1yYzMuDQoNClJlZ2FyZHMsDQoN
CksuIFkNCg0KDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IAlJbmdvDQo=
