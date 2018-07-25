Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE0C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1449720833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gtIMOspb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1449720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeGYRDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:03:33 -0400
Received: from mail-by2nam03on0049.outbound.protection.outlook.com ([104.47.42.49]:5968
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728341AbeGYRDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaU7NQzCSFVNrO3i9ImOxl3ixQEYPJJlzkkVa86w42k=;
 b=gtIMOspbsO4J3HGTeZNr51M/5txR+oksGXyfbPuVVS2fdgbgR8WGiPmLeE9/MJHuRc5HFk8mMzKVHSj3GiwDUyLygc8cDJyas+RfSjw1+Sw5pcJpIfh4XKXr8jjN/iFmjSW4YQWS4gkWujKBkb+sqVGxAwLbJ/yNASYtKbkVVIU=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB3373.namprd02.prod.outlook.com (10.164.187.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Wed, 25 Jul 2018 15:51:14 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726%3]) with mapi id 15.20.0995.014; Wed, 25 Jul 2018
 15:51:14 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/8] usb: dwc3: implement stream transfer timeout
Thread-Topic: [PATCH 4/8] usb: dwc3: implement stream transfer timeout
Thread-Index: AQHUJA3sROLEOOfQMEemCHeBIrzYkaSgCeIAgAAA61CAAARJgIAABfUQ
Date:   Wed, 25 Jul 2018 15:51:14 +0000
Message-ID: <MWHPR02MB2816411003B8BB7D3B041587A7540@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1532519491-19502-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <CAHp75VfM8h9CKXO9bfmF74fcLW68Rs+1514Je=o1jOFd52Uf7A@mail.gmail.com>
 <MWHPR02MB2816A41E9C145BC8D89F834AA7540@MWHPR02MB2816.namprd02.prod.outlook.com>
 <CAHp75VfBYPF5u9e64VMrDfi7yC2XyAwr5qa7ow1Xat5hFq1etQ@mail.gmail.com>
In-Reply-To: <CAHp75VfBYPF5u9e64VMrDfi7yC2XyAwr5qa7ow1Xat5hFq1etQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3373;6:9r4lohOF+TAwhyVf9H3h7m8LQmvD1Zd+jXxRpgxdJwg0gI5InRbHgkUhbJxYPfW4XVQrWGthc1l72CE5ByPeh+JfeefdfaTlyFdIM8qDkG95OKMYRWj5X78NPnV5pxKVkmrtMnqzNCkcQW4XDR364SMe0dgFKnnMc/pDLSQgIE5h5e0WTsGGTPu/4WdPXtL6ZqL8k3KyEYepdBmSJJvnSxEikqKV8OovWR9lMbCoC9D0n7d3P+g0TZVzWrMghAbSYfKQRncOhRlciUKcxJy4zHllxOuZWHDajJej9fWBu4KzTgGQZgol/SZ5V5sL7uadtR03P+bmslC9+Y+/0G0jVlf/OLKUXWSR6HdLWpPBZiMw+IjBK0Rwd9etFf0xNmpeNefbeoP1jcPuP52HWetDpyvkWpvGh0I2E797Ayy/qbIg1oQ4689V4jeGYA3NvkKeIlz1gs9iL1eqvak2H6kx+Q==;5:QdyQ6syfjskJznYn8fuW14kKV9Kv+wYmwxLg75vvp6Aa9/VoIS6hXJ5olGWHxkdhw7H0sJ6Xv0TecV217rn17IRjh5SOgyjrb1gvUl4w/1oTLvHz3V5K4qBT752irsINJ/dG/3sGE3IaP//jXpB/gbdEHzVhujVOs3cnU6O53Qk=;7:gnOeJJ03YFhdv1qOP54Gyh1TQLo+DyZP4Oxg6SY9op2mrJYAt4t+yjG1PiwDO/Gz1zu92uafcMcJppguP0uA3cSM1jte8xcVT5xp+/9bSl9fz2+3jQhaKFmzr/DdCRQZaFqfZMuzgeHJB1AlDNF6KJw7UgpAEfAlY7ZJg/3VYcGnkT+ngxOd7dF1njBK/ujKDWUjxp6JfV3qzySfyPAFEttZ4kQoFCoSI8ftxdv+zGQLKlFXldbZgtNAJNd6CFu0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f5229d99-dda0-4d4a-ce94-08d5f24673a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3373;
x-ms-traffictypediagnostic: MWHPR02MB3373:
x-microsoft-antispam-prvs: <MWHPR02MB33734EBC03CE71683C76851AA7540@MWHPR02MB3373.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3373;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3373;
x-forefront-prvs: 0744CFB5E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(13464003)(199004)(189003)(7736002)(4326008)(8676002)(81166006)(81156014)(39060400002)(305945005)(74316002)(8936002)(97736004)(6506007)(7696005)(26005)(486006)(76176011)(5250100002)(14444005)(102836004)(186003)(446003)(86362001)(256004)(476003)(25786009)(14454004)(99286004)(93886005)(3846002)(106356001)(6116002)(478600001)(68736007)(6436002)(2900100001)(66066001)(2906002)(9686003)(55016002)(53936002)(6246003)(105586002)(11346002)(229853002)(5660300001)(54906003)(316002)(6916009)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3373;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JQYFCSu7TdZWV3/T3ys7s2BMSRsM/x73ECMVxLuDrsh7q0CqRwSvxxKAp1W89X8NpC9RN/5TySR+mS+DwOQvk6D2LTh2P/n++QUkoxO6oiHFTgM2mLkXkYzK+bn1YR5U3I1GaloG7y3BOiRZCHt8Z1dH4VPzdtK7rvzmADCZsbKItil04yTokQS5PRc/mrSyGStEnMnEY8iu3zSJWQZpctsnClLrN1Vpk0uKo/P0slLkAFFF1Wa4mKEme/24Lao6NBNctrURIT+SL6jLKTea89HaptPMBeJtcz7TEDhDFMToGeb8DMWnvKGgTG675z9E8ZksLVD1jPPA5NkYQK6rdudveg8HIagKJ7NofR+0P6w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5229d99-dda0-4d4a-ce94-08d5f24673a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2018 15:51:14.3198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFuZHkgU2hldmNoZW5rbyBb
bWFpbHRvOmFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb21dDQo+U2VudDogV2VkbmVzZGF5LCBKdWx5
IDI1LCAyMDE4IDg6NTUgUE0NCj5UbzogQW51cmFnIEt1bWFyIFZ1bGlzaGEgPGFudXJhZ2t1QHhp
bGlueC5jb20+DQo+Q2M6IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz47IEdyZWcgS3Jv
YWgtSGFydG1hbg0KPjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IHYuYW51cmFna3VtYXJA
Z21haWwuY29tOyBVU0IgPGxpbnV4LQ0KPnVzYkB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJu
ZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPlN1YmplY3Q6
IFJlOiBbUEFUQ0ggNC84XSB1c2I6IGR3YzM6IGltcGxlbWVudCBzdHJlYW0gdHJhbnNmZXIgdGlt
ZW91dA0KPg0KPk9uIFdlZCwgSnVsIDI1LCAyMDE4IGF0IDY6MTQgUE0sIEFudXJhZyBLdW1hciBW
dWxpc2hhDQo+PGFudXJhZ2t1QHhpbGlueC5jb20+IHdyb3RlOg0KPg0KPj4+PiArLyoNCj4+Pj4g
KyAqIFRpbWVvdXQgdmFsdWUgaW4gbXNlY3MgdXNlZCBieSBzdHJlYW1fdGltZW91dF90aW1lciB3
aGVuIHN0cmVhbXMNCj4+Pj4gK2FyZSBlbmFibGVkICAqLw0KPj4+PiArI2RlZmluZSBTVFJFQU1f
VElNRU9VVCAgICAgICAgIDUwDQo+Pj4NCj4+PlBlcmhhcHMsIFNUUkVBTV9USU1FT1VUX01TIDUw
DQo+Pj4NCj4+PkR1bm5vIGFib3V0IHRoaXMgZHJpdmVyLCBidXQgaXQncyBhIHVzdWFsIHByYWN0
aWNlIHRvIGhlbHAgcmVhZGVyIHdpdGggdW5kZXJzdGFuZGluZw0KPj4+Y29kZSBvbiB0aGUgZmly
c3QgZ2xhbmNlLg0KPj4+DQo+Pg0KPj4gU2luY2UgSSBoYXZlIG1lbnRpb25lZCAibXNlY3MiIGlu
IGNvbW1lbnQgYWJvdmUgZGVzY3JpYmluZyB0aGUNCj5TVFJFQU1fVElNRU9VVCwNCj4+IHRob3Vn
aHQgaXQgd291bGQgc3VmZmljZS4gQnV0IGlmIHlvdSBmZWVsIEkgc2hvdWxkIGNoYW5nZSBpdCwg
SSAgd2lsbCBmaXggaXQgaW4gdjINCj4NCj5CdXQgeW91IGRpZG4ndCBwdXQgdGhhdCBjb21tZW50
IGJlZm9yZSBlYWNoIG9jY3VycmVuY2Ugb2YgdGhpcw0KPmNvbnN0YW50IGluIHRoZSBjb2RlLCBy
aWdodD8NCj5UaGF0J3Mgd2hhdCBJJ20gdGFsa2luZyBhYm91dC4gSWYgcmVhZGVyIGxvb2tzIGlu
dG8gdGhlIGNvZGUsIHRoZXJlIGlzDQo+bm8gbmVlZCB0byB1bmRlcnN0YW5kIHRoZSBvcmRlciBv
ZiB0aGUgdmFsdWUgZm9yIHRpbWVvdXQsIHNpbmNlIHVuaXRzDQo+YXJlIHBhcnQgb2YgdGhlIG5h
bWUuDQo+DQo+T2YgY291cnNlLCB5b3UgbWF5IGlnbm9yZSB0aGlzIGNvbW1lbnQuDQo+DQoNCkkg
YWdyZWUgd2l0aCB5b3VyIGNvbW1lbnRzICwgd2lsbCB3YWl0IGZvciBvdGhlciBjb21tZW50cyBv
biB0aGlzIHBhdGNoDQpzZXJpZXMgYW5kIGFkZHJlc3MgdGhlbSBhbHRvZ2V0aGVyIGluIHYyDQoN
ClRoYW5rcywNCkFudXJhZyBLdW1hciBWdWxpc2hhDQo+LS0NCj5XaXRoIEJlc3QgUmVnYXJkcywN
Cj5BbmR5IFNoZXZjaGVua28NCg==
