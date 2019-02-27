Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1140FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00D2218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="TqvUd31c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfB0S4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:56:20 -0500
Received: from mail-eopbgr760048.outbound.protection.outlook.com ([40.107.76.48]:36192
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726356AbfB0S4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjyIL2o3xDczDRHZ+drE2o+ndkTi3TKnckge7chEqGE=;
 b=TqvUd31caNyj/kWD3hM22Et4saRsSbvLQycBfIPQKIIFHhsPRBeuSJF0qrS87ZzEf2WQCMQb/sZZSc4kJ+qy7e2MA9kkX/9CKrbzvTnwIER5gCGgsd6cEnKtb7UkQnyglBbfji7KN6mf3krtiHoSGEKp29//70BFKqEUGkWSshc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4261.namprd05.prod.outlook.com (20.176.252.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.5; Wed, 27 Feb 2019 18:55:37 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::6cf6:1336:9f92:b1b5%4]) with mapi id 15.20.1665.012; Wed, 27 Feb 2019
 18:55:37 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and
 __this_cpu_{}()
Thread-Topic: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and
 __this_cpu_{}()
Thread-Index: AQHUzoWLaRk7bgtU4EOfs8jYdQI+faXz0eWAgAAc4YCAABA6AA==
Date:   Wed, 27 Feb 2019 18:55:37 +0000
Message-ID: <634996DB-18B4-4008-82C0-ADD7A6D84B22@vmware.com>
References: <20190227101252.413192716@infradead.org>
 <20190227101544.210748832@infradead.org>
 <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com>
 <06F1CFAA-DD80-4DA7-A97C-E57814149CC4@vmware.com>
In-Reply-To: <06F1CFAA-DD80-4DA7-A97C-E57814149CC4@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b9237ac-158c-45b4-5fc2-08d69ce52992
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4261;
x-ms-traffictypediagnostic: BYAPR05MB4261:
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4261;20:XOuW6V4u0rSv2/euy5wLuT185BaM2qx0+xi82wZkuTo+nikevBYntdDw9kS/TC14X2UFlWDsUvhhvojCkIhXayVl8dUGgsTKSRnDdvFdZZKjfmSV7+zpZbhgWi4117VYFwmmFQsN1Fsia7bUbvjLxCQgzbFLZ36MGH7EBDwMlpo=
x-microsoft-antispam-prvs: <BYAPR05MB4261E14B7C0BC1868D6171D0D0740@BYAPR05MB4261.namprd05.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(136003)(39860400002)(376002)(189003)(199004)(81156014)(97736004)(6116002)(4326008)(11346002)(68736007)(8676002)(102836004)(81166006)(5660300002)(3846002)(83716004)(476003)(93886005)(71190400001)(54906003)(71200400001)(229853002)(36756003)(486006)(305945005)(86362001)(26005)(82746002)(2616005)(8936002)(186003)(33656002)(446003)(7736002)(25786009)(99286004)(53546011)(76176011)(6506007)(478600001)(6512007)(5024004)(6916009)(256004)(14454004)(316002)(6436002)(66066001)(2906002)(6486002)(106356001)(6246003)(53936002)(105586002)(125773002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4261;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ya1Pi9rIHUgKCRSFeUG/ji2N001wRdrXf7WekdSNfTvcuDhTTNI46VkbIElnCxxWn97J7BuEwCudvS9Hc2hRKc544j3v6pF32LxJY1NS/edsiILqrEWSk8pqVDlllLPNOwbOnlDJy4hKvqrNJ6C2WvUFPziJdjYHYmSWriEeQHr6xBK9emEvkc3Kwb6bVyvP47LgvDko8k8vVLf6jj0Ewk+PjqyWzbF+aHTorg6+fuuvYc6q/Dycs/uqh5MlnXTHcvx/Hj0l1qBJZdk9TNeu3o8NFHjJuUBOXgBeVouuu+Z9Z7WpnZEUi98s6Iju9/1dKgowP8NGwVZ51aCO90ovwW5DH8e6xitRO+5RO+fsSzi3xTzeY0Ko+TmTutvUpy3JqJieppafLcgtmuJwrt3meuyoscM6ClODdOx/uO2mhyU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0A69D4750DD674C861D12C33BDBDEC2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9237ac-158c-45b4-5fc2-08d69ce52992
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 18:55:37.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMjcsIDIwMTksIGF0IDk6NTcgQU0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5j
b20+IHdyb3RlOg0KPiANCj4+IE9uIEZlYiAyNywgMjAxOSwgYXQgODoxNCBBTSwgTGludXMgVG9y
dmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+IA0KPj4gT24g
V2VkLCBGZWIgMjcsIDIwMTkgYXQgMjoxNiBBTSBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJh
ZGVhZC5vcmc+IHdyb3RlOg0KPj4+IE5hZGF2IEFtaXQgcmVwb3J0ZWQgdGhhdCBjb21taXQ6DQo+
Pj4gDQo+Pj4gYjU5MTY3YWM3YmFmICgieDg2L3BlcmNwdTogRml4IHRoaXNfY3B1X3JlYWQoKSIp
DQo+Pj4gDQo+Pj4gYWRkZWQgYSBidW5jaCBvZiBjb25zdHJhaW50cyB0byBhbGwgc29ydHMgb2Yg
Y29kZTsgYW5kIHdoaWxlIHNvbWUgb2YNCj4+PiB0aGF0IHdhcyBjb3JyZWN0IGFuZCBkZXNpcmVk
LCBzb21lIG9mIHRoYXQgc2VlbXMgc3VwZXJmbHVvdXMuDQo+PiANCj4+IFRyaXZpYWwgKGJ1dCBl
bnRpcmVseSB1bnRlc3RlZCkgcGF0Y2ggYXR0YWNoZWQuDQo+PiANCj4+IFRoYXQgc2FpZCwgSSBk
aWRuJ3QgYWN0dWFsbHkgY2hlY2sgaG93IGl0IGFmZmVjdHMgY29kZSBnZW5lcmF0aW9uLg0KPj4g
TmFkYXYsIHdvdWxkIHlvdSBjaGVjayB0aGUgY29kZSBzZXF1ZW5jZXMgeW91IG9yaWdpbmFsbHkg
bm90aWNlZD8NCj4gDQo+IFRoZSBvcmlnaW5hbCBpc3N1ZSB3YXMgcmFpc2VkIHdoaWxlIEkgd2Fz
IGxvb2tpbmcgaW50byBhIGRyb3BwZWQgcGF0Y2ggb2YNCj4gTWF0dGhldyBXaWxjb3ggdGhhdCBj
YXVzZWQgY29kZSBzaXplIGluY3JlYXNlIFsxXS4gQXMgYSByZXN1bHQgSSBub3RpY2VkDQo+IHRo
YXQgUGV0ZXLigJlzIHBhdGNoIGNhdXNlZCBiaWcgY2hhbmdlcyB0byB0aGUgZ2VuZXJhdGVkIGFz
c2VtYmx5IGFjcm9zcyB0aGUNCj4ga2VybmVsIC0gSSBkaWQgbm90IGhhdmUgYSBzcGVjaWZpYyBz
Y2VuYXJpbyB0aGF0IEkgY2FyZWQgYWJvdXQuDQo+IA0KPiBUaGUgcGF0Y2ggeW91IHNlbnQgKOKA
nCttLy12b2xhdGlsZeKAnSkgZG9lcyBpbmNyZWFzZSB0aGUgY29kZSBzaXplIGJ5IDE3MjgNCj4g
Ynl0ZXMuIEFsdGhvdWdoIGNvZGUgc2l6ZSBpcyBub3QgdGhlIG9ubHkgbWV0cmljIGZvciDigJxj
b2RlIG9wdGltaXphdGlvbuKAnSwNCj4gdGhlIG9yaWdpbmFsIHBhdGNoIG9mIFBldGVyICjigJx2
b2xhdGlsZeKAnSkgb25seSBpbmNyZWFzZWQgdGhlIGNvZGUgc2l6ZSBieSAyMDENCj4gYnl0ZXMu
IFBldGVy4oCZcyBvcmlnaW5hbCBjaGFuZ2UgYWxzbyBhZmZlY3RlZCBvbmx5IDcyIGZ1bmN0aW9u
cyB2cyAyMjggdGhhdA0KPiBpbXBhY3RlZCBieSB0aGUgbmV3IHBhdGNoLg0KPiANCj4gSeKAmWxs
IGhhdmUgYSBsb29rIGF0IHNvbWUgc3BlY2lmaWMgZnVuY3Rpb24gYXNzZW1ibHksIGJ1dCBvdmVy
YWxsLCB0aGUg4oCcK23igJ0NCj4gYXBwcm9hY2ggbWlnaHQgcHJldmVudCBldmVuIG1vcmUgY29k
ZSBvcHRpbWl6YXRpb25zIHRoYW4gdGhlIOKAnHZvbGF0aWxl4oCdIG9uZS4NCj4gDQo+IEnigJls
bCBzZW5kIGFuIGV4YW1wbGUgb3IgdHdvIGxhdGVyLg0KDQpIZXJlIGlzIG9uZSBleGFtcGxlOg0K
DQpEdW1wIG9mIGFzc2VtYmxlciBjb2RlIGZvciBmdW5jdGlvbiBldmVudF9maWx0ZXJfcGlkX3Nj
aGVkX3dha2V1cF9wcm9iZV9wcmU6DQogICAweGZmZmZmZmZmODExN2M1MTAgPCswPjoJcHVzaCAg
ICVyYnANCiAgIDB4ZmZmZmZmZmY4MTE3YzUxMSA8KzE+Ogltb3YgICAgJXJzcCwlcmJwDQogICAw
eGZmZmZmZmZmODExN2M1MTQgPCs0PjoJcHVzaCAgICVyYngNCiAgIDB4ZmZmZmZmZmY4MTE3YzUx
NSA8KzU+Ogltb3YgICAgMHgyOCglcmRpKSwlcmF4DQogICAweGZmZmZmZmZmODExN2M1MTkgPCs5
PjoJbW92ICAgICVnczoweDc4KCVyYXgpLCVkbA0KICAgMHhmZmZmZmZmZjgxMTdjNTFkIDwrMTM+
Ogl0ZXN0ICAgJWRsLCVkbA0KICAgMHhmZmZmZmZmZjgxMTdjNTFmIDwrMTU+OglqZSAgICAgMHhm
ZmZmZmZmZjgxMTdjNTM1IDxldmVudF9maWx0ZXJfcGlkX3NjaGVkX3dha2V1cF9wcm9iZV9wcmUr
Mzc+DQogICAweGZmZmZmZmZmODExN2M1MjEgPCsxNz46CW1vdiAgICAlcmRpLCVyYXgNCiAgIDB4
ZmZmZmZmZmY4MTE3YzUyNCA8KzIwPjoJbW92ICAgIDB4NzgoJXJkaSksJXJkaQ0KICAgMHhmZmZm
ZmZmZjgxMTdjNTI4IDwrMjQ+Ogltb3YgICAgMHgyOCglcmF4KSwlcmJ4ICAgIyBSRURVTkRBTlQN
CiAgIDB4ZmZmZmZmZmY4MTE3YzUyYyA8KzI4PjoJY2FsbHEgIDB4ZmZmZmZmZmY4MTE2NzgzMCA8
dHJhY2VfaWdub3JlX3RoaXNfdGFzaz4NCiAgIDB4ZmZmZmZmZmY4MTE3YzUzMSA8KzMzPjoJbW92
ICAgICVhbCwlZ3M6MHg3OCglcmJ4KQ0KICAgMHhmZmZmZmZmZjgxMTdjNTM1IDwrMzc+Oglwb3Ag
ICAgJXJieA0KICAgMHhmZmZmZmZmZjgxMTdjNTM2IDwrMzg+Oglwb3AgICAgJXJicA0KICAgMHhm
ZmZmZmZmZjgxMTdjNTM3IDwrMzk+OglyZXRxICAgDQoNClRoZSBpbnN0cnVjdGlvbiBhdCAweGZm
ZmZmZmZmODExN2M1MjggaXMgcmVkdW5kYW50LCBhbmQgZG9lcyBub3QgZXhpc3QNCndpdGhvdXQg
dGhlIHJlY2VudCBwYXRjaC4gSXQgc2VlbXMgdG8gYmUgYSByZXN1bHQgb2Ygbm8tc3RyaWN0LWFs
aWFzaW5nLA0Kd2hpY2ggZHVlIHRvIHRoZSBuZXcgIm1lbW9yeSB3cml0ZeKAnSAo4oCcK23igJ0p
IGNhdXNlcyB0aGUgY29tcGlsZXIgdG8gcmUtcmVhZA0KdGhlIGRhdGEuDQoNCg==
