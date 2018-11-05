Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1BEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE9F22BED
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ks8izOdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE9F22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbeKFDfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:35:22 -0500
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:25060
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387561AbeKFDfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEkMUZ7KdIn98yln8CtyP/lZ4ld7n5zBf9HWD58Q+jY=;
 b=ks8izOdQ31mf0x5nRDxAXbgSxAGvS/KT0BX4noo9//Z9ML1pQ5061BAJ5ioIqku+cHsEKybokltLC0pBHDjM0mVL6jAcPcM/lgVqyMe5Oederq8Wv1Qa/6ihux0uOrS361GBqNXVi/nN83DFQu0xguW2Oob1kFaTqFL/i6olM5s=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4344.namprd05.prod.outlook.com (52.135.202.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.16; Mon, 5 Nov 2018 18:14:24 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 18:14:24 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 1/7] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Topic: [PATCH v3 1/7] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Index: AQHUcwQ6zzaSzSJdnkSnz2tKH+5VIqVAHDMAgAFkhQA=
Date:   Mon, 5 Nov 2018 18:14:24 +0000
Message-ID: <1708BB6F-5B71-4868-9D94-12A1C0CB0A36@vmware.com>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-2-namit@vmware.com>
 <alpine.DEB.2.21.1811042153430.10744@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811042153430.10744@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4344;20:0lM++KIW7tV70HiEwr10cMuA6j72XtTErJe8h1xXd6yP6jmeDDUnbsOWvg166DHjQvzvNJX9bdvAcOQ7eSuYCd/EH/CVm4EMhopC9mfHyvezYgwPnLYwSeguaG60RZgNvbg24a6E+uOPVq43rm/R7kQzEvyMe765XZpx6YDKy8s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8c7ce1a0-57d3-4250-97e3-08d6434a8478
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4344;
x-ms-traffictypediagnostic: BYAPR05MB4344:
x-microsoft-antispam-prvs: <BYAPR05MB4344C28A86C6485315A0B503D0CA0@BYAPR05MB4344.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(61668805478150)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4344;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4344;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(189003)(7416002)(11346002)(305945005)(7736002)(76176011)(6916009)(14454004)(446003)(82746002)(68736007)(6246003)(105586002)(66066001)(53936002)(25786009)(4326008)(83716004)(71190400001)(71200400001)(106356001)(99286004)(6486002)(6436002)(256004)(26005)(5660300001)(316002)(14444005)(33656002)(486006)(476003)(86362001)(229853002)(6116002)(8936002)(36756003)(186003)(54906003)(2906002)(8676002)(478600001)(53546011)(6506007)(2616005)(97736004)(81166006)(6512007)(81156014)(102836004)(2900100001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4344;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: re9/XWZ04BwFzpwzRQLUgvdkYUOc7BtLhYEa6OS2eyYIeF/oHpk5pG4Jm1+KFLZAzeJ68MHb52T15iYye8sa3JlXgtmewepsqVH/i3lsRHuHtcbcRl332IWWZy9VLBZLYuZntTYnhX9i/jgKp8MJKIjjgENBR6tpHifZhx/Kczpl6TseVoZKnKPu9zJ0jSDa+iAzMU/vcZVPtufzE34mlKVxXNnD5k8lH+mH1Dk7QHjH0Pl8PHJodZ67HEz7IPs6860lyThqyKSLbmwyRut1xvchv0Jr5LpUAXRrwNCiDB8FoKk6pFelPfy9lkLiL65KaWouqhoTmMMR5vNZQju27j1mFKf3SiFqR5Y4vBs2jq8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <262EA39A3AE66344B6357DF783B43F9A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7ce1a0-57d3-4250-97e3-08d6434a8478
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 18:14:24.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGhvbWFzIEdsZWl4bmVyDQpTZW50OiBOb3ZlbWJlciA0LCAyMDE4IGF0IDg6NTg6MjAg
UE0gR01UDQo+IFRvOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPiBDYzogSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiwg
eDg2QGtlcm5lbC5vcmc+LCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4sIEJvcmlzbGF2
IFBldGtvdiA8YnBAYWxpZW44LmRlPiwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4Lmlu
dGVsLmNvbT4sIEppcmkgS29zaW5hIDxqa29zaW5hQHN1c2UuY3o+LCBBbmR5IEx1dG9taXJza2kg
PGx1dG9Aa2VybmVsLm9yZz4sIEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPiwgRGF2
ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MyAxLzddIEZpeCAieDg2L2FsdGVybmF0aXZlczogTG9ja2RlcC1lbmZvcmNlIHRleHRfbXV0ZXgg
aW4gdGV4dF9wb2tlKigpIg0KPiANCj4gDQo+IE9uIEZyaSwgMiBOb3YgMjAxOCwgTmFkYXYgQW1p
dCB3cm90ZToNCj4gDQo+PiB0ZXh0X211dGV4IGlzIGV4cGVjdGVkIHRvIGJlIGhlbGQgYmVmb3Jl
IHRleHRfcG9rZSgpIGlzIGNhbGxlZCwgYnV0IHdlDQo+PiBjYW5ub3QgYWRkIGEgbG9ja2RlcCBh
c3NlcnRpb24gc2luY2Uga2dkYiBkb2VzIG5vdCB0YWtlIGl0LCBhbmQgaW5zdGVhZA0KPj4gKnN1
cHBvc2VkbHkqIGVuc3VyZXMgdGhlIGxvY2sgaXMgbm90IHRha2VuIGFuZCB3aWxsIG5vdCBiZSBh
Y3F1aXJlZCBieQ0KPj4gYW55IG90aGVyIGNvcmUgd2hpbGUgdGV4dF9wb2tlKCkgaXMgcnVubmlu
Zy4NCj4+IA0KPj4gVGhlIHJlYXNvbiBmb3IgdGhlICJzdXBwb3NlZGx5IiBjb21tZW50IGlzIHRo
YXQgaXQgaXMgbm90IGVudGlyZWx5IGNsZWFyDQo+PiB0aGF0IHRoaXMgd291bGQgYmUgdGhlIGNh
c2UgaWYgZ2RiX2RvX3JvdW5kdXAgaXMgemVyby4NCj4+IA0KPj4gQWRkIGEgY29tbWVudCB0byBj
bGFyaWZ5IHRoaXMgYmVoYXZpb3IsIGFuZCByZXN0b3JlIHRoZSBhc3NlcnRpb25zIGFzDQo+PiB0
aGV5IHdlcmUgYmVmb3JlIHRoZSByZWNlbnQgY29tbWl0Lg0KPiANCj4gSXQgcmVzdG9yZXMgbm90
aGluZy4gSXQganVzdCByZW1vdmVzIHRoZSBhc3NlcnRpb24uDQoNClNvcnJ5IC0gd3JvbmcgY29t
bWl0IGxvZy4gVGhlcmUgd2VyZSBubyBvdGhlciBhc3NlcnRpb25zIGJlZm9yZS4gDQoNCj4gDQo+
PiBUaGlzIHBhcnRpYWxseSByZXZlcnRzIGNvbW1pdCA5MjIyZjYwNjUwNmMgKCJ4ODYvYWx0ZXJu
YXRpdmVzOg0KPj4gTG9ja2RlcC1lbmZvcmNlIHRleHRfbXV0ZXggaW4gdGV4dF9wb2tlKigpIikN
Cj4gDQo+IFRoYXQgb3BlbnMgdXAgdGhlIHNhbWUgY2FuIG9mIHdvcm1zIGFnYWluLCB3aGljaCB0
b29rIHVzIGEgd2hpbGUgdG8gY2xvc2UuDQoNCknigJltIHN1cnByaXNlZC4gVGhpcyBwYXRjaCBv
bmx5IHJlbW92ZXMgb25lIGFzc2VydGlvbiB0aGF0IHdhcyBhZGRlZCB0d28NCm1vbnRocyBhZ28u
DQoNCj4gQ2FuIHdlIHBsZWFzZSBpbnN0ZWFkIHNwbGl0IG91dCB0aGUgdGV4dF9wb2tlKCkgY29k
ZSBpbnRvIGEgaGVscGVyIGZ1bmN0aW9uDQo+IGFuZCBoYXZlIHR3byBjYWxsZXJzOg0KPiANCj4g
ICAgdGV4dF9wb2tlKCkgd2hpY2ggY29udGFpbnMgdGhlIGFzc2VydA0KPiANCj4gICAgdGV4dF9w
b2tlX2tnZGIoKSB3aGljaCBkb2VzIG5vdA0KDQpTdXJlLiBJIHdpbGwgc2VuZCBhbm90aGVyIHZl
cnNpb24gb25jZSBJIHJlYWxpemUgaG93IHRvIGRlYWwgd2l0aCB0aGUgb3RoZXINCmNvbmNlcm5z
IHRoYXQgUGV0ZXIgYW5kIEFuZHkgcmFpc2VkLg0KDQpSZWdhcmRzLA0KTmFkYXYNCg0K
