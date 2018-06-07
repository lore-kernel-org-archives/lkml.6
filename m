Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id shsqL1pRGVtUDAAAmS7hNA
	; Thu, 07 Jun 2018 15:38:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 97BD16063F; Thu,  7 Jun 2018 15:38:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dL/X7F0O"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2DFBE601B4;
	Thu,  7 Jun 2018 15:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DFBE601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935413AbeFGPh4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:37:56 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:22896
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934754AbeFGPhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9tfhKatjOF7FlxmpKKkboAZCW6yhDLWv+W3nNj33Zg=;
 b=dL/X7F0OXsoULdww0PSoCcW/rQb0W+pdq+C3LA3pM/9cdbC4snIczlytU1l1ELm6ZSBy66Qd+IXYWiOOcv+PPkpC6AOjn4kAfseUia9Hl+Tj/i9xPIDIybWEGYew2BmAZYiLPkO/XW9ZFmXTtspkEZPOpZ/+G9VQNmVXJhxddtI=
Received: from BL0PR2101MB0884.namprd21.prod.outlook.com (52.132.23.145) by
 BL0PR2101MB0881.namprd21.prod.outlook.com (52.132.23.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Thu, 7 Jun 2018 15:37:50 +0000
Received: from BL0PR2101MB0884.namprd21.prod.outlook.com
 ([fe80::6018:2e0e:107:12e6]) by BL0PR2101MB0884.namprd21.prod.outlook.com
 ([fe80::6018:2e0e:107:12e6%2]) with mapi id 15.20.0863.004; Thu, 7 Jun 2018
 15:37:50 +0000
From: Matthew Wilcox <mawilcox@microsoft.com>
To: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hakon Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Wei Wang <wei.w.wang@intel.com>,
        Chris Mi <chrism@mellanox.com>,
        Eric Biggers <ebiggers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] IB/mad: Use ID allocator routines to allocate
 agent number
Thread-Topic: [PATCH v3 2/2] IB/mad: Use ID allocator routines to allocate
 agent number
Thread-Index: AQHT/lDXGAKyGKDwa02zuwur9YRShKRU7PdQ
Date: Thu, 7 Jun 2018 15:37:50 +0000
Message-ID: <BL0PR2101MB088460CA4C97562CB311ED3ECB640@BL0PR2101MB0884.namprd21.prod.outlook.com>
References: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
 <20180607111435.17538-1-hans.westgaard.ry@oracle.com>
 <20180607111435.17538-3-hans.westgaard.ry@oracle.com>
In-Reply-To: <20180607111435.17538-3-hans.westgaard.ry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mawilcox@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-07T15:34:42.4125172Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [206.248.175.83]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0881;7:hYciIdinrSkjmWPN4AV5PppMt913jcwYR8psh6fGLznxQtmJD/52VuPymji+dzVf0MzYDBrvwDwVJDDoSFzIMqLwOs81qeTo6sSJ768k2SaC5gQHZL63fCJMNCqiXKEb/v2zTVxlJkY2bKDGIEi2NtpkErJyNAHRzXDdbMiD/oyUbwALUVl7FxwksuvycNGva4pimvxaa0XtcJKtAtpsKQ5iZYyPCynkP8ZzvCdAhxP3zTklil/ef7/fXdVyoMq0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0881;
x-ms-traffictypediagnostic: BL0PR2101MB0881:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mawilcox@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB0881B3A569D6A7A74DAD7E16CB640@BL0PR2101MB0881.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(211936372134217)(153496737603132)(21403327493029)(146099531331640)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0881;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0881;
x-forefront-prvs: 06968FD8C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39380400002)(39860400002)(189003)(199004)(13464003)(99286004)(26005)(9686003)(2900100001)(14454004)(53936002)(10290500003)(25786009)(39060400002)(478600001)(6246003)(5250100002)(105586002)(7416002)(5660300001)(6116002)(7736002)(305945005)(3846002)(106356001)(10090500001)(229853002)(2501003)(102836004)(81166006)(81156014)(8676002)(55016002)(8936002)(53546011)(76176011)(7696005)(59450400001)(486006)(6506007)(186003)(8990500004)(74316002)(6436002)(97736004)(446003)(476003)(316002)(3280700002)(2906002)(86612001)(2201001)(22452003)(33656002)(3660700001)(86362001)(66066001)(11346002)(68736007)(110136005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0881;H:BL0PR2101MB0884.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IxOXr+l02tRrfeTWzrnB0p5Zk+U6RLiDchGy8ZUbkqIH7BkA0+E4HB4z/vpCtbq+xUAbAhCsCzPmWrdGuC9BTGJtw57cDmDw26S79tBe44cEankqPBCmWTcJ2e5meoCGM+CAGkm7yioGivad8yPB4qKRbZdm3OUzOPsX4D0lJPUz9id6V5oUp6L9yTiHCle5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d4357d74-98c2-42fd-70a2-08d5cc8ca0a4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4357d74-98c2-42fd-70a2-08d5cc8ca0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2018 15:37:50.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2h5IGRvIHlvdSBuZWVkIHRoZSBJRCB0byBpbmNyZW1lbnQgbGlrZSB0aGlzPyAgV2h5IGNhbid0
IHlvdSBqdXN0IHVzZSBhIHVuaXF1ZSBJRD8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBIYW5zIFdlc3RnYWFyZCBSeSBbbWFpbHRvOmhhbnMud2VzdGdhYXJkLnJ5QG9y
YWNsZS5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDcsIDIwMTggNzoxNSBBTQ0KPiBUbzog
RG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRoYXQuY29tPjsgSmFzb24gR3VudGhvcnBlIDxqZ2dA
emllcGUuY2E+Ow0KPiBIYWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+OyBQYXJh
diBQYW5kaXQNCj4gPHBhcmF2QG1lbGxhbm94LmNvbT47IEphY2sgTW9yZ2Vuc3RlaW4gPGphY2tt
QGRldi5tZWxsYW5veC5jby5pbD47IFByYXZpbg0KPiBTaGVkZ2UgPHByYXZpbi5zaGVkZ2U0bGlu
dXhAZ21haWwuY29tPjsgTWF0dGhldyBXaWxjb3gNCj4gPG1hd2lsY294QG1pY3Jvc29mdC5jb20+
OyBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsNCj4gSmVmZiBMYXl0
b24gPGpsYXl0b25Aa2VybmVsLm9yZz47IFdlaSBXYW5nIDx3ZWkudy53YW5nQGludGVsLmNvbT47
IENocmlzDQo+IE1pIDxjaHJpc21AbWVsbGFub3guY29tPjsgRXJpYyBCaWdnZXJzIDxlYmlnZ2Vy
c0Bnb29nbGUuY29tPjsgUmFzbXVzDQo+IFZpbGxlbW9lcyA8bGludXhAcmFzbXVzdmlsbGVtb2Vz
LmRrPjsgTWVsIEdvcm1hbg0KPiA8bWdvcm1hbkB0ZWNoc2luZ3VsYXJpdHkubmV0PjsgbGludXgt
cmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFtQQVRDSCB2MyAyLzJdIElCL21hZDogVXNlIElEIGFsbG9jYXRvciByb3V0aW5l
cyB0byBhbGxvY2F0ZSBhZ2VudA0KPiBudW1iZXINCj4gDQo+IFRoZSBhZ2VudCBUSUQgaXMgYSA2
NCBiaXQgdmFsdWUgc3BsaXQgaW4gdHdvIGR3b3Jkcy4gIFRoZSBsZWFzdA0KPiBzaWduaWZpY2Fu
dCBkd29yZCBpcyB0aGUgVElEIHJ1bm5pbmcgY291bnRlci4gVGhlIG1vc3Qgc2lnbmlmaWNhbnQN
Cj4gZHdvcmQgaXMgdGhlIGFnZW50IG51bWJlci4gSW4gdGhlIENYLTMgc2hhcmVkIHBvcnQgbW9k
ZWwsIHRoZSBtbHg0DQo+IGRyaXZlciB1c2VzIHRoZSBtb3N0IHNpZ25pZmljYW50IGJ5dGUgb2Yg
dGhlIGFnZW50IG51bWJlciB0byBzdG9yZSB0aGUNCj4gc2xhdmUgbnVtYmVyLCBtYWtpbmcgYWdl
bnQgbnVtYmVycyBncmVhdGVyIGFuZCBlcXVhbCB0byAyXjI0ICgzIGJ5dGVzKQ0KPiB1bnVzYWJs
ZS4gIFRoZSBjdXJyZW50IGNvZGViYXNlIHVzZXMgYSB2YXJpYWJsZSB3aGljaCBpcyBpbmNyZW1l
bnRlZA0KPiBhdG9taWNhbGx5IGZvciBlYWNoIG5ldyBhZ2VudCBudW1iZXIgZ2l2aW5nIHRvbyBs
YXJnZSBhZ2VudCBudW1iZXJzDQo+IG92ZXIgdGltZS4gIFRoZSBJREEgc2V0IG9mIGZ1bmN0aW9u
cyBhcmUgdXNlZCBpbnN0ZWFkIG9mIHRoZSBzaW1wbGUNCj4gY291bnRlciBhcHByb2FjaC4gVGhp
cyBhbGxvd3MgcmUtdXNlIG9mIGFnZW50IG51bWJlcnMuDQo+IA0KPiBUaGUgc2lnbmF0dXJlIG9m
IHRoZSBidWcgaXMgYSBNQUQgbGF5ZXIgdGhhdCBzdG9wcyB3b3JraW5nIGFuZCB0aGUNCj4gY29u
c29sZSBpcyBmbG9vZGVkIHdpdGggbWVzc2FnZXMgbGlrZToNCj4gIG1seDRfaWI6IGVncmVzcyBt
YWQgaGFzIG5vbi1udWxsIHRpZCBtc2I6MSBjbGFzczo0IHNsYXZlOjANCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEhhbnMgV2VzdGdhYXJkIFJ5IDxoYW5zLndlc3RnYWFyZC5yeUBvcmFjbGUuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL21hZC5jIHwgMjUgKysrKysrKysrKysr
KysrKysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvbWFk
LmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9tYWQuYw0KPiBpbmRleCBiMjg0NTJhNTVhMDgu
LmMwMWEyZDYzZmZhMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvbWFk
LmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvbWFkLmMNCj4gQEAgLTQxLDYgKzQx
LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc2VjdXJpdHkuaD4NCj4gKyNpbmNsdWRlIDxsaW51
eC9pZHIuaD4NCj4gICNpbmNsdWRlIDxyZG1hL2liX2NhY2hlLmg+DQo+IA0KPiAgI2luY2x1ZGUg
Im1hZF9wcml2LmgiDQo+IEBAIC01OSw4ICs2MCw3IEBAIG1vZHVsZV9wYXJhbV9uYW1lZChyZWN2
X3F1ZXVlX3NpemUsDQo+IG1hZF9yZWN2cV9zaXplLCBpbnQsIDA0NDQpOw0KPiAgTU9EVUxFX1BB
Uk1fREVTQyhyZWN2X3F1ZXVlX3NpemUsICJTaXplIG9mIHJlY2VpdmUgcXVldWUgaW4gbnVtYmVy
IG9mDQo+IHdvcmsgcmVxdWVzdHMiKTsNCj4gDQo+ICBzdGF0aWMgc3RydWN0IGxpc3RfaGVhZCBp
Yl9tYWRfcG9ydF9saXN0Ow0KPiAtc3RhdGljIGF0b21pY190IGliX21hZF9jbGllbnRfaWQgPSBB
VE9NSUNfSU5JVCgwKTsNCj4gLQ0KPiArc3RhdGljIERFRklORV9JREEoaWJfbWFkX2NsaWVudF9p
ZHMpOw0KPiAgLyogUG9ydCBsaXN0IGxvY2sgKi8NCj4gIHN0YXRpYyBERUZJTkVfU1BJTkxPQ0so
aWJfbWFkX3BvcnRfbGlzdF9sb2NrKTsNCj4gDQo+IEBAIC0yMTIsNyArMjEyLDcgQEAgc3RydWN0
IGliX21hZF9hZ2VudCAqaWJfcmVnaXN0ZXJfbWFkX2FnZW50KHN0cnVjdA0KPiBpYl9kZXZpY2Ug
KmRldmljZSwNCj4gIAlpbnQgcmV0MiwgcXBuOw0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+
ICAJdTggbWdtdF9jbGFzcywgdmNsYXNzOw0KPiAtDQo+ICsJdTMyIGliX21hZF9jbGllbnRfaWQ7
DQo+ICAJLyogVmFsaWRhdGUgcGFyYW1ldGVycyAqLw0KPiAgCXFwbiA9IGdldF9zcGxfcXBfaW5k
ZXgocXBfdHlwZSk7DQo+ICAJaWYgKHFwbiA9PSAtMSkgew0KPiBAQCAtMzc1LDkgKzM3NSwxOSBA
QCBzdHJ1Y3QgaWJfbWFkX2FnZW50ICppYl9yZWdpc3Rlcl9tYWRfYWdlbnQoc3RydWN0DQo+IGli
X2RldmljZSAqZGV2aWNlLA0KPiAgCQlyZXQgPSBFUlJfUFRSKHJldDIpOw0KPiAgCQlnb3RvIGVy
cm9yNDsNCj4gIAl9DQo+ICsJaWJfbWFkX2NsaWVudF9pZCA9IGlkYV9zaW1wbGVfZ2V0X2N5Y2xp
YygmaWJfbWFkX2NsaWVudF9pZHMsDQo+ICsJCQkJCQkxLA0KPiArCQkJCQkJQklUKDI0KSAtIDEs
DQo+ICsJCQkJCQlHRlBfS0VSTkVMKTsNCj4gKwlpZiAoaWJfbWFkX2NsaWVudF9pZCA8IDApIHsN
Cj4gKwkJcHJfZXJyKCJDb3VsZG4ndCBhbGxvY2F0ZSBhZ2VudCB0aWQ7IGVycmNvZGU6ICUjeFxu
IiwNCj4gKwkJCWliX21hZF9jbGllbnRfaWQpOw0KPiArCQlyZXQgPSBFUlJfUFRSKGliX21hZF9j
bGllbnRfaWQpOw0KPiArCQlnb3RvIGVycm9yNDsNCj4gKwl9DQo+ICsJbWFkX2FnZW50X3ByaXYt
PmFnZW50LmhpX3RpZCA9IGliX21hZF9jbGllbnRfaWQ7DQo+IA0KPiAgCXNwaW5fbG9ja19pcnFz
YXZlKCZwb3J0X3ByaXYtPnJlZ19sb2NrLCBmbGFncyk7DQo+IC0JbWFkX2FnZW50X3ByaXYtPmFn
ZW50LmhpX3RpZCA9DQo+IGF0b21pY19pbmNfcmV0dXJuKCZpYl9tYWRfY2xpZW50X2lkKTsNCj4g
DQo+ICAJLyoNCj4gIAkgKiBNYWtlIHN1cmUgTUFEIHJlZ2lzdHJhdGlvbiAoaWYgc3VwcGxpZWQp
DQo+IEBAIC00MjgsNiArNDM4LDggQEAgc3RydWN0IGliX21hZF9hZ2VudCAqaWJfcmVnaXN0ZXJf
bWFkX2FnZW50KHN0cnVjdA0KPiBpYl9kZXZpY2UgKmRldmljZSwNCj4gIGVycm9yNToNCj4gIAlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZwb3J0X3ByaXYtPnJlZ19sb2NrLCBmbGFncyk7DQo+ICAJ
aWJfbWFkX2FnZW50X3NlY3VyaXR5X2NsZWFudXAoJm1hZF9hZ2VudF9wcml2LT5hZ2VudCk7DQo+
ICsJaWRhX3NpbXBsZV9yZW1vdmUoJmliX21hZF9jbGllbnRfaWRzLCBpYl9tYWRfY2xpZW50X2lk
KTsNCj4gKw0KPiAgZXJyb3I0Og0KPiAgCWtmcmVlKHJlZ19yZXEpOw0KPiAgZXJyb3IzOg0KPiBA
QCAtNTc2LDYgKzU4OCw3IEBAIHN0YXRpYyB2b2lkIHVucmVnaXN0ZXJfbWFkX2FnZW50KHN0cnVj
dA0KPiBpYl9tYWRfYWdlbnRfcHJpdmF0ZSAqbWFkX2FnZW50X3ByaXYpDQo+ICB7DQo+ICAJc3Ry
dWN0IGliX21hZF9wb3J0X3ByaXZhdGUgKnBvcnRfcHJpdjsNCj4gIAl1bnNpZ25lZCBsb25nIGZs
YWdzOw0KPiArCXUzMiBpYl9tYWRfY2xpZW50X2lkOw0KPiANCj4gIAkvKiBOb3RlIHRoYXQgd2Ug
Y291bGQgc3RpbGwgYmUgaGFuZGxpbmcgcmVjZWl2ZWQgTUFEcyAqLw0KPiANCj4gQEAgLTU4Nyw2
ICs2MDAsOCBAQCBzdGF0aWMgdm9pZCB1bnJlZ2lzdGVyX21hZF9hZ2VudChzdHJ1Y3QNCj4gaWJf
bWFkX2FnZW50X3ByaXZhdGUgKm1hZF9hZ2VudF9wcml2KQ0KPiAgCXBvcnRfcHJpdiA9IG1hZF9h
Z2VudF9wcml2LT5xcF9pbmZvLT5wb3J0X3ByaXY7DQo+ICAJY2FuY2VsX2RlbGF5ZWRfd29yaygm
bWFkX2FnZW50X3ByaXYtPnRpbWVkX3dvcmspOw0KPiANCj4gKwlpYl9tYWRfY2xpZW50X2lkID0g
bWFkX2FnZW50X3ByaXYtPmFnZW50LmhpX3RpZDsNCj4gKw0KPiAgCXNwaW5fbG9ja19pcnFzYXZl
KCZwb3J0X3ByaXYtPnJlZ19sb2NrLCBmbGFncyk7DQo+ICAJcmVtb3ZlX21hZF9yZWdfcmVxKG1h
ZF9hZ2VudF9wcml2KTsNCj4gIAlsaXN0X2RlbCgmbWFkX2FnZW50X3ByaXYtPmFnZW50X2xpc3Qp
Ow0KPiBAQCAtNjAyLDYgKzYxNyw3IEBAIHN0YXRpYyB2b2lkIHVucmVnaXN0ZXJfbWFkX2FnZW50
KHN0cnVjdA0KPiBpYl9tYWRfYWdlbnRfcHJpdmF0ZSAqbWFkX2FnZW50X3ByaXYpDQo+IA0KPiAg
CWtmcmVlKG1hZF9hZ2VudF9wcml2LT5yZWdfcmVxKTsNCj4gIAlrZnJlZShtYWRfYWdlbnRfcHJp
dik7DQo+ICsJaWRhX3NpbXBsZV9yZW1vdmUoJmliX21hZF9jbGllbnRfaWRzLCBpYl9tYWRfY2xp
ZW50X2lkKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgdm9pZCB1bnJlZ2lzdGVyX21hZF9zbm9vcChz
dHJ1Y3QgaWJfbWFkX3Nub29wX3ByaXZhdGUNCj4gKm1hZF9zbm9vcF9wcml2KQ0KPiBAQCAtMzM0
Nyw0ICszMzYzLDUgQEAgaW50IGliX21hZF9pbml0KHZvaWQpDQo+ICB2b2lkIGliX21hZF9jbGVh
bnVwKHZvaWQpDQo+ICB7DQo+ICAJaWJfdW5yZWdpc3Rlcl9jbGllbnQoJm1hZF9jbGllbnQpOw0K
PiArCWlkYV9kZXN0cm95KCZpYl9tYWRfY2xpZW50X2lkcyk7DQo+ICB9DQo+IC0tDQo+IDIuMTQu
Mw0KDQo=
