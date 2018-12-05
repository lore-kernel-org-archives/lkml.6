Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D4FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5398320850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ijeckJCd";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="i/kvWBwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5398320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeLEHUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:20:01 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:52436 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbeLEHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:20:00 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB57GLDn013141;
        Tue, 4 Dec 2018 23:19:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=OXEXaXDhrJ2RReq9vujSmX7rrqgE3wozcH6LkDkT7WM=;
 b=ijeckJCdW1vZj+ktVLRfee7dqS84U/Z+bNu5GLh4yyU25t2NEhxrpe9B+IgY03zQKc8q
 LBk5TRZ+o2aUdmxKGUHsLFI/LYZ1rk59/wit2ZVHRR7LFbtkJyARfH+srCoAgYnThTr4
 AibMaa2qTc7vdTgSWBd88unXiQ5V9y7OSvOCwWblTEmmV/IwXurFouCCBTzz+xPm3rfa
 7ZmhK0WIfKi20TRWmuiJ/Lr4Bes7cbfKYISYMMJKSLQb2tcU8Ta98/WCmgjwjBMggG1/
 Y4q7YngqLKyH9yzwwptYKn4mWxoaa+S+mxdHSqN1AY14sXaci0Uqq5n+8strTXwppjES TA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2052.outbound.protection.outlook.com [104.47.45.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2p5scbmfgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Dec 2018 23:19:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXEXaXDhrJ2RReq9vujSmX7rrqgE3wozcH6LkDkT7WM=;
 b=i/kvWBwBB2KqkHCpAA/uGyDksbbi9M4+XA8A3FqMBIILZNE5I3rMNoneC6BDN0wM8zY/KWuAB/4jfpPCZxNmfl0q9r7Ne/D1dUStTc+R9srC5l/bgZ8Y4X5wJeX1DlahpB/V3X6zzxWgiFiwTK/vG1OPDATpGdDYe8KdOXtmmzY=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5704.namprd07.prod.outlook.com (20.178.0.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Wed, 5 Dec 2018 07:19:51 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::e0dc:ebd5:e248:d644%6]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 07:19:51 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <hzpeterchen@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Subject: RE: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
Thread-Topic: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
Thread-Index: AQHUfycKfg2nmnNwYkGzkCY+37gGkqVn/0mAgAP0wLCAAk7dAIABjrqw
Date:   Wed, 5 Dec 2018 07:19:51 +0000
Message-ID: <BYAPR07MB47090A16A7A8A85C6C3FD46ADDA80@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-5-git-send-email-pawell@cadence.com>
 <CAL411-rWbQ6yj1r_aaLP8UagVRJhsn7xdznQwXS9enkxXTs2LA@mail.gmail.com>
 <BYAPR07MB4709A8E4B0B0CC05A842B708DDAD0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-rzhH+y-b0-xze4-WmeVtey4bXt4Jc6TWYyfw6E8x-5Eg@mail.gmail.com>
In-Reply-To: <CAL411-rzhH+y-b0-xze4-WmeVtey4bXt4Jc6TWYyfw6E8x-5Eg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMjRmMWRlNjQtZjg1ZS0xMWU4LTg3MjYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDI0ZjFkZTY1LWY4NWUtMTFlOC04NzI2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDkzNyIgdD0iMTMxODg0Njc5OTE0NTkyNTIzIiBoPSI0WG0vM3ZCWThLdk1VRUU3MWtZTnVoWi9tbWc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5704;20:JSSzBQwQM2gMAJT9BMTZ/5pcr53vSNKaVBjbM8ANtkExaJEWjttW17jwc7VpIv2fs4Szsa3H5WnZ80TTj5K0FgR25qKfGTLHCGt3VdjfdGFe/T/1jo03lIs1r6nS5srGY7dIqYg8u2MRhr5oxoGzglkQtnYKEOqQbvW3mOcuzBcSoF6O/ObJTURhmGXxxffkE1W+iDmDFxJVJRvNYpLsnaIo5E06vlQVWsD6JCVpuu0cusR53pjNxDof1baLtZGG
x-ms-office365-filtering-correlation-id: b8633c40-ffaa-4cf7-79f9-08d65a820beb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5704;
x-ms-traffictypediagnostic: BYAPR07MB5704:
x-microsoft-antispam-prvs: <BYAPR07MB57042D0BAE247EFEBE89C8B1DDA80@BYAPR07MB5704.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5704;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5704;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(51444003)(36092001)(74316002)(55016002)(25786009)(107886003)(11346002)(316002)(6436002)(7736002)(305945005)(7416002)(9686003)(6246003)(54906003)(446003)(478600001)(229853002)(14454004)(6506007)(86362001)(33656002)(6916009)(2906002)(7696005)(68736007)(53936002)(99286004)(97736004)(76176011)(81166006)(3846002)(6116002)(8676002)(66066001)(81156014)(5660300001)(8936002)(1411001)(93886005)(39060400002)(102836004)(4326008)(186003)(105586002)(26005)(106356001)(71200400001)(71190400001)(486006)(476003)(217873002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5704;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3o9062TlETcXsy3JNYAdkSIwq/hAdV1XH8NNITdVGChAIHyTWlmBiTq0RMdwOnbEDQzj6TNOgDV5B0opRmdUdNPKRBE48myZbqUdjizj0huj89DEbA87XSQI9Aa0OB+qiTylttDiM876iUpAXX0cCXZ5P2e0AQiwvHi9ENdegB7fB/4nphuHB7Z2Kx6XbUEdjd6grZcqea3+uQDSQE96kJUcmq2JADukcOzKqdFA4iAdRiKt5YpmENE0xmTslXMZVTjH77wccIdWKsgFgfR2QRfCbhaJuywqly9yR7G0I+CjxD+P81T5V3K7GPa7s3Cwbi47ltZj5pgymtCB9/Qc8zxvFSw0GC8kQ/AYpJrXlZM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8633c40-ffaa-4cf7-79f9-08d65a820beb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 07:19:51.0442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5704
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4+ID4+DQo+PiA+PiBQYXRjaCBhZGRzIGNvcmUuYyBhbmQgY29yZS5oIGZpbGUgdGhh
dCBpbXBsZW1lbnRzIGluaXRpYWxpemF0aW9uDQo+PiA+PiBvZiBwbGF0Zm9ybSBkcml2ZXIgYW5k
IGFkZHMgZnVuY3Rpb24gcmVzcG9uc2libGUgZm9yIHNlbGVjdGluZywNCj4+ID4+IHN3aXRjaGlu
ZyBhbmQgcnVubmluZyBhcHByb3ByaWF0ZSBEZXZpY2UvSG9zdCBtb2RlLg0KPj4gPj4NCj4+ID4+
IFNpZ25lZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+DQo+PiA+
PiAtLS0NCj4+ID4+ICBkcml2ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZSB8ICAgMiArDQo+PiA+PiAg
ZHJpdmVycy91c2IvY2RuczMvY29yZS5jICAgfCA0MTMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4gPj4gIGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuaCAgIHwgMTAwICsr
KysrKysrKw0KPj4gPj4gIDMgZmlsZXMgY2hhbmdlZCwgNTE1IGluc2VydGlvbnMoKykNCj4+ID4+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvY29yZS5jDQo+PiA+PiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuaA0KPj4gPj4NCj4+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZSBiL2RyaXZlcnMvdXNiL2NkbnMz
L01ha2VmaWxlDQo+PiA+PiBpbmRleCBkY2RkNjIwMDNjNmEuLjAyZDI1YjIzYzVkMyAxMDA2NDQN
Cj4+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2NkbnMzL01ha2VmaWxlDQo+PiA+PiArKysgYi9kcml2
ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZQ0KPj4gPj4gQEAgLTEsMyArMSw1IEBADQo+PiA+PiArb2Jq
LSQoQ09ORklHX1VTQl9DRE5TMykgICAgICAgICAgICAgICAgICAgICAgICArPSBjZG5zMy5vDQo+
PiA+PiAgb2JqLSQoQ09ORklHX1VTQl9DRE5TM19QQ0lfV1JBUCkgICAgICAgKz0gY2RuczMtcGNp
Lm8NCj4+ID4+DQo+PiA+PiArY2RuczMteSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA6PSBjb3JlLm8NCj4+ID4+ICBjZG5zMy1wY2kteSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA6PSBjZG5zMy1wY2ktd3JhcC5vDQo+PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvY2RuczMvY29yZS5jIGIvZHJpdmVycy91c2IvY2RuczMvY29yZS5jDQo+PiA+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPj4gPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mOTA1NWQ0ZGE2N2YNCj4+
ID4+IC0tLSAvZGV2L251bGwNCj4+ID4+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0K
Pj4gPj4gQEAgLTAsMCArMSw0MTMgQEANCj4+ID4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMA0KPj4gPj4gKy8qDQo+PiA+PiArICogQ2FkZW5jZSBVU0JTUyBEUkQgRHJpdmVy
Lg0KPj4gPj4gKyAqDQo+PiA+PiArICogQ29weXJpZ2h0IChDKSAyMDE4IENhZGVuY2UuDQo+PiA+
PiArICoNCj4+ID4NCj4+ID5QbGVhc2UgYWRkIE5YUCBjb3B5cmlnaHQgdG9vLg0KPj4NCj4+IE9r
LCBJIGRvbid0IGtub3cgd2h5IEkgb21pdHRlZCB0aGlzLg0KPj4gSSBrbm93IHRoYXQgeW91IGFy
ZSB0aGUgbWFpbiBhdXRob3Igb2YgdGhpcyBmaWxlDQo+PiBTb3JyeSBmb3IgdGhhdC4NCj4+DQo+
PiBPbmUgYWRkaXRpb25hbCBxdWVzdGlvbi4gV2hhdCB5ZWFyIEkgc2hvdWxkIGFkZCBpbiBDb3B5
cmlnaHQgZm9yIE5YUD8uDQo+PiBUaGUgb3JpZ2luYWwgeWVhciAyMDE3IG9yIEkgc2hvdWxkIG1v
ZGlmaWVkIGFsbCB0byAyMDE4Lg0KPj4NCj5QbGVhc2UgdXNlIGJlbG93IGNvcHlyaWdodCwgdGhh
bmtzLg0KPg0KPkNvcHlyaWdodCAyMDE3LTIwMTggTlhQDQoNCkkgYWRkIHRoaXMgaW4gYWxsIGZp
bGVzICBtb2RpZmllZCBvciBjcmVhdGVkIGJ5IHlvdS4NCj4NCj4NCj4NCj4+ID4+ICsgICAgICAg
bXV0ZXhfaW5pdCgmY2Rucy0+bXV0ZXgpOw0KPj4gPj4gKw0KPj4gPj4gKyAgICAgICBjZG5zLT5w
aHkgPSBkZXZtX3BoeV9nZXQoZGV2LCAiY2RuczMsdXNicGh5Iik7DQo+PiA+PiArICAgICAgIGlm
IChJU19FUlIoY2Rucy0+cGh5KSkgew0KPj4gPj4gKyAgICAgICAgICAgICAgIGRldl9pbmZvKGRl
diwgIm5vIGdlbmVyaWMgcGh5IGZvdW5kXG4iKTsNCj4+ID4+ICsgICAgICAgICAgICAgICBjZG5z
LT5waHkgPSBOVUxMOw0KPj4gPj4gKyAgICAgICAgICAgICAgIC8qDQo+PiA+PiArICAgICAgICAg
ICAgICAgICogZmFsbCB0aHJvdWdoIGhlcmUhDQo+PiA+PiArICAgICAgICAgICAgICAgICogaWYg
bm8gZ2VuZXJpYyBwaHkgZm91bmQsIHBoeSBpbml0DQo+PiA+PiArICAgICAgICAgICAgICAgICog
c2hvdWxkIGJlIGRvbmUgdW5kZXIgYm9vdCENCj4+ID4+ICsgICAgICAgICAgICAgICAgKi8NCj4+
ID4NCj4+ID5JZiB0aGUgcGh5IGRyaXZlciBpcyBkZWZlci1wcm9iZWQsIGl0IHdpbGwgYmUgaGVy
ZSwgaXQgaXMgbm90IGFuIGVycm9yLg0KPj4gPkkgdGhpbmsgeW91IGNvdWxkIGhhdmUgYSBnZW5l
cmljIHBoeSBkcml2ZXIgb3IgdXNiIGdlbmVyaWMgcGh5IGRyaXZlcg0KPj4gPihkcml2ZXJzL3Vz
Yi9waHkvcGh5LWdlbmVyaWMuYykgZXZlbiB5b3UgZG9uJ3QgbmVlZCBhbnkgb3BlcmF0aW9ucyBm
b3INCj4+ID5QSFkuIEl0IHdpbGwgYmUgZWFzeSBmb3Igb3RoZXIgcGxhdGZvcm1zLg0KPj4NCj4+
IFllcywgUm9nZXIgYXNrIG1lIHRvIG1vZGlmeSB0aGlzIGZyYWdtZW50LiBJbiBuZXh0IHZlcnNp
b24gaXQgd2lsbCBsb29rIGxpa2U6DQo+PiAgICAgICAgIGNkbnMtPnBoeSA9IGRldm1fcGh5X2dl
dChkZXYsICJjZG5zMyx1c2JwaHkiKTsNCj4+ICAgICAgICAgaWYgKElTX0VSUihjZG5zLT5waHkp
KSB7DQo+PiAgICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihjZG5zLT5waHkpOw0KPj4gICAg
ICAgICAgICAgICAgIGlmIChyZXQgPT0gLUVOT1NZUyB8fCByZXQgPT0gLUVOT0RFVikgew0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgY2Rucy0+cGh5ID0gTlVMTDsNCj4+ICAgICAgICAgICAg
ICAgICB9IGVsc2UgaWYgKHJldCA9PSAtRVBST0JFX0RFRkVSKSB7DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIm5vIHBoeSBmb3VuZFxuIik7DQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjA7DQo+PiAgICAgICAgICAgICAgICAg
fQ0KPj4gICAgICAgICB9DQo+Pg0KPj4gICAgICAgICBwaHlfaW5pdChjZG5zLT5waHkpOw0KPj4N
Cj4+IFdlIGFyZSBnb2luZyB0byB1c2UgcGh5IGRyaXZlci4gSSBkb24ndCBrbm93IGlmIGl0IGNv
cnJlY3QuDQo+PiBJIGRvbid0IGhhdmUgZXhwZXJpZW5jZSBpbiB0aGlzIGZpbGVkLg0KPj4gV2Ug
bmVlZCBwaHkgaW5pdGlhbGl6YXRpb24gYnV0IEkgZG9uJ3QgaGF2ZSB0ZXN0aW5nIHBsYXRmb3Jt
IG5vdy4NCj4+IEluIG1vc3QgdXNiIGRyaXZlcnMgSSBzZWUgdGhhdCB0aGVyZSBhcmUgdXNlZCB1
c2IgcGh5IGRyaXZlcmQgaW5zdGVhZCBwaHkgZGlydmVyZC4NCj4+DQo+DQo+QXQgbXkgQ0ROUzMg
cGxhdGZvcm0sIHRoZXJlIGFyZSBzb21lIFVTQiBQSFkgaW5pdGlhbGl6YXRpb24gZm9yIHJlZ2lz
dGVyIHNldHRpbmcNCj5hbmQgY2xvY2sgZW5hYmxlLiBZb3UgY291bGQgYWRkIGdlbmVyaWMgUEhZ
IGRyaXZlciB1bmRlcjogZHJpdmVycy9waHkvY2FkZW5jZS8uDQo+DQo+QWJvdmUgUEhZIGluaXRp
YWxpemF0aW9uIGNvZGUgaXMgT0sgZm9yIG1lLg0KDQpJdCB3aWxsIGJlIGFkZGVkIGFzIHNlcGFy
YXRlIGRyaXZlci4gDQpJIHRoaW5rIHRoYXQgQWxsYW4gRG91Z2xhcyB3b3JraW5nIG9uIGl0LiAN
CkkgYXNrIGhpbSB0byBhZGQgeW91IHRvIC1jYyBpbiBwYXRjaCBmb3IgcGh5Lg0KDQo+DQo+DQo+
PiA+PiArc3RhdGljIHZvaWQgX19leGl0IGNkbnMzX2RyaXZlcl9wbGF0Zm9ybV91bnJlZ2lzdGVy
KHZvaWQpDQo+PiA+PiArew0KPj4gPj4gKyAgICAgICBwbGF0Zm9ybV9kcml2ZXJfdW5yZWdpc3Rl
cigmY2RuczNfZHJpdmVyKTsNCj4+ID4+ICt9DQo+PiA+PiArbW9kdWxlX2V4aXQoY2RuczNfZHJp
dmVyX3BsYXRmb3JtX3VucmVnaXN0ZXIpOw0KPj4gPj4gKw0KPj4gPj4gK01PRFVMRV9BTElBUygi
cGxhdGZvcm06Y2RuczMiKTsNCj4+ID4+ICtNT0RVTEVfQVVUSE9SKCJQYXdlbCBMYXN6Y3phayA8
cGF3ZWxsQGNhZGVuY2UuY29tPiIpOw0KPj4gPj4gK01PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsN
Cj4+ID4+ICtNT0RVTEVfREVTQ1JJUFRJT04oIkNhZGVuY2UgVVNCMyBEUkQgQ29udHJvbGxlciBE
cml2ZXIiKTsNCj4+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9jb3JlLmggYi9k
cml2ZXJzL3VzYi9jZG5zMy9jb3JlLmgNCj4+ID4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiA+
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjdjODIwNGZlNGQzZA0KPj4gPj4gLS0tIC9kZXYvbnVsbA0K
Pj4gPj4gKysrIGIvZHJpdmVycy91c2IvY2RuczMvY29yZS5oDQo+PiA+PiBAQCAtMCwwICsxLDEw
MCBAQA0KPj4gPj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+PiA+
PiArLyoNCj4+ID4+ICsgKiBDYWRlbmNlIFVTQlNTIERSRCBEcml2ZXIuDQo+PiA+PiArICoNCj4+
ID4NCj4+ID5IZWFkZXIgZmlsZQ0KPj4gSSBkb24ndCB1bmRlcnN0YW5kLiBXaGF0IGlzIHdyb25n
ID8NCj4+ID4NCj4NCj5UaGUgY29tbWVudCBmb3IgdGhpcyBmaWxlDQo+DQo+Q2FkZW5jZSBVU0JT
UyBEUkQgQ29yZSBIZWFkZXIgRmlsZQ0KDQpPaywgdGhhbmtzIA0KQ2hlZXJzLCANClBhd2VsDQo=
