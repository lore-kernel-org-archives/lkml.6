Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E24C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFFD2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hkBx0h/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFFD2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbeKHDcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:32:55 -0500
Received: from mail-eopbgr730051.outbound.protection.outlook.com ([40.107.73.51]:64019
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727168AbeKHDcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGHnd3eCtk15memSRns8o5dpCYTjENUxUo4TQqPtnPA=;
 b=hkBx0h/s/lQtR3x+bnTqb/wBIU5+5RPnuGEVz2osbFdtVW0ts6q9bKZmjaL4l+pxtdL4zS1gtF0rEUH4GPhMFlD+72AeMorsjxhvOFzVKc0rUuKbeEbQc+yHSEH8X4FEQQJaMNbhWzqX3l63omSrPA67lztf8vEkX0SPznEwjFY=
Received: from SN6PR05MB4783.namprd05.prod.outlook.com (52.135.115.17) by
 SN6PR05MB5949.namprd05.prod.outlook.com (20.178.6.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.15; Wed, 7 Nov 2018 18:01:23 +0000
Received: from SN6PR05MB4783.namprd05.prod.outlook.com
 ([fe80::c964:38d3:a19b:6091]) by SN6PR05MB4783.namprd05.prod.outlook.com
 ([fe80::c964:38d3:a19b:6091%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 18:01:23 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Ingo Molnar <mingo@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Topic: [PATCH v9 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Index: AQHUW2CZ0dZfAolPxUG9hT8O5ZUp5qVDToGAgAAFpACAAAwfgIABcMKA
Date:   Wed, 7 Nov 2018 18:01:23 +0000
Message-ID: <DC1EA50F-FAC3-4750-BCF7-0622D1FB4756@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-3-namit@vmware.com>
 <89262174-6f15-6116-e67f-436f7c1bfe99@deltatee.com>
 <6651971B-E3AB-4CDD-868C-2338593F7D83@vmware.com>
 <d0812681-4a8f-8cc4-24ce-d02002ee34d2@deltatee.com>
In-Reply-To: <d0812681-4a8f-8cc4-24ce-d02002ee34d2@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR05MB5949;20:wrSUqlIdvWyYnA7PUEvALfuoLZcnThJ7MMANm2EvY6c5BGaAM+lsrej9jdyUVn/l5nVMY/zuF2F/W95h+K7nTQ2KtPrgkeOqOhrvqJnyZLKla0Ps2JJ8I+ZI2ECAlpmSmGvB0jNIjGQFQYi/jzS/ePXY5gKV4lGUF76ox34XZeg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 734a6ede-5d64-43bd-651e-08d644db078f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR05MB5949;
x-ms-traffictypediagnostic: SN6PR05MB5949:
x-microsoft-antispam-prvs: <SN6PR05MB5949A6B658FB5E384ED1CB16D0C40@SN6PR05MB5949.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6PR05MB5949;BCL:0;PCL:0;RULEID:;SRVR:SN6PR05MB5949;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(136003)(376002)(51914003)(189003)(199004)(33656002)(6486002)(4326008)(106356001)(6116002)(8936002)(71190400001)(76176011)(3846002)(97736004)(5660300001)(476003)(186003)(11346002)(446003)(2616005)(8676002)(7736002)(2906002)(478600001)(2900100001)(256004)(81166006)(305945005)(81156014)(6246003)(6512007)(68736007)(229853002)(14454004)(82746002)(93886005)(316002)(99286004)(36756003)(26005)(102836004)(53546011)(86362001)(25786009)(6506007)(66066001)(110136005)(7416002)(83716004)(71200400001)(486006)(6436002)(53936002)(105586002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB5949;H:SN6PR05MB4783.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 421QjhVStfTVmeCxDAI9MOxBJO0Fv/D8eiPM9Ew3kAFk3WgmOV/9PS3f9c52Kp78EdTKUb4Nu1K4Ac2skeqrrUsWuV0Pl6BRfQ+W7y3JhE4ZKDkA9taZpAmpEqesYg1vupfq/RHyqwfgyEzEWn3HxmiIli9c2eyOTCQkxSkxW1+cyfLaiViMeVJuyQlLR+CVr2TbOgcFQDspPaU9kwxQN+LbrRZoCapppZxo2SX9acMBT5iz7SIBd+NmVAVqu0/qw2KqpNap1ECLhJSIE3oxNjc+mqwxIEYuxYGze/N/m98qTPxomzJpmOXZqQ+vy2uiaZOPRxW39/C9c9wr7kZD7BZwdA3dKYFwCybcbDGOA2Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <58E16AC9ECF591448DDEDA5E47381D1E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734a6ede-5d64-43bd-651e-08d644db078f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 18:01:23.3774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB5949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTG9nYW4gR3VudGhvcnBlDQpTZW50OiBOb3ZlbWJlciA2LCAyMDE4IGF0IDg6MDE6MzEg
UE0gR01UDQo+IFRvOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiwgSW5nbyBNb2xuYXIg
PG1pbmdvQHJlZGhhdC5jb20+DQo+IENjOiBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPiwgWDg2IE1MIDx4ODZAa2VybmVsLm9yZz4sIFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3Jn
Lm9yZz4sIE1pY2hhbCBNYXJlayA8bWljaGFsLmxrbWxAbWFya292aS5uZXQ+LCBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sIEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29t
PiwgTGludXggS2J1aWxkIG1haWxpbmcgbGlzdCA8bGludXgta2J1aWxkQHZnZXIua2VybmVsLm9y
Zz4sIFN0ZXBoZW4gQmF0ZXMgPHNiYXRlc0ByYWl0aGxpbi5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjkgMDIvMTBdIE1ha2VmaWxlOiBQcmVwYXJlIGZvciB1c2luZyBtYWNyb3MgZm9yIGlu
bGluZSBhc20NCj4gDQo+IA0KPiANCj4gDQo+IE9uIDIwMTgtMTEtMDYgMTI6MTggcC5tLiwgTmFk
YXYgQW1pdCB3cm90ZToNCj4+IEVyci4uIEkgZG9u4oCZdCBoYXZlIGEgZGlzdC1jYyBlbnZpcm9u
bWVudC4gSSB3b25kZXIgd2hldGhlciBzb21ldGhpbmcgbGlrZQ0KPj4gdGhhdCB3b3VsZCBkbyB0
aGUgdHJpY2s6DQo+IA0KPiBJIHRlc3RlZCBpdCB0byBiZSBzdXJlIC0tIGJ1dCwgbm8sIHRoaXMg
ZG9lcyBub3QgaGF2ZSBhbnkgYWZmZWN0IG9uDQo+IGRpc3RjYy4gRGlzdGNjIHVzdWFsbHkgZG9l
cyBwcmUtcHJvY2Vzc2luZyBsb2NhbGx5IGFuZCB0aGVuIHNlbmRzIHRoZQ0KPiBzaW5nbGUgb3V0
cHV0IG9mIGNwcCB0byBhIHJlbW90ZSBmb3IgY29tcGlsYXRpb24gYW5kIGFzc2VtYmx5LiBJdA0K
PiBkb2Vzbid0IGV4cGVjdCB0aGVyZSB0byBiZSBhZGRpdGlvbmFsIGFzc2VtYmx5IGZpbGVzIHRh
Y2tlZCBvbiB0aGUNCj4gY29tbWFuZCBsaW5lIGFuZCBpc24ndCBnb2luZyB0byBoYW5kbGUgdGhh
dCBjYXNlIGNvcnJlY3RseS4gVGh1cywNCj4gY2hhbmdpbmcgdGhlIHBhdGggb2YgdGhlIGZpbGUg
d29uJ3QgZml4IGFueXRoaW5nLg0KDQpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4NCg0KSSBw
bGF5ZWQgd2l0aCBkaXN0LWNjIGFuZCBnYXZlIGl0IHNvbWUgdGhvdWdodCwgYnV0IEkgZG8gbm90
IGhhdmUgYQ0Kc29sdXRpb24uIEkgdGhvdWdodCB0aGF0IHBlcmhhcHMgc29tZSBoYWNrIGlzIHBv
c3NpYmxlIGJ5IHVzaW5nIHRoZSBzYW1lDQpwcmVwcm9jZXNzZWQgZmlsZSBjYW4gYmUgdXNlZCBh
cyBib3RoIHRoZSBzb3VyY2UgZmlsZSBhbmQgdGhlIGFzc2VtYmx5IGZpbGUsDQpidXQgdGhhdOKA
mXMgYXMgZmFyIGFzIEkgbWFuYWdlZCB0byBnZXQuDQoNCklkZWFzPyBEbyBwZW9wbGUgY2FyZSBh
Ym91dCBpdD8=
