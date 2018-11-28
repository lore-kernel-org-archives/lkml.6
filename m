Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D415C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B353020832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B353020832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeK2BZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:25:47 -0500
Received: from mail-eopbgr800085.outbound.protection.outlook.com ([40.107.80.85]:37184
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727832AbeK2BZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+LfO1P/fvYf9ucn0WLYmy5h55nqFc8TLpqjnJxzaWk=;
 b=iasqj1dAYD0BiMvsEXk0krEq7/uWGvi7LEhyQzPMNfdSzbtZiqGTc2Eljhj8od+vonf1JrAI8WKeQ51LNZ7K9253h2UmsJhRI7a7DbkdD88AMOUlae03PvDDnKQ+KWJ/+UCkJYeuElR/BImIJ1f7ZlbwCLPXG2eksuQEo+xniv8=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB2557.namprd12.prod.outlook.com (52.132.197.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Wed, 28 Nov 2018 14:23:49 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 14:23:49 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] amd-xgbe: set skb to NULL after freeing it
Thread-Topic: [PATCH V2] amd-xgbe: set skb to NULL after freeing it
Thread-Index: AQHUhvmj7eiN0hl8Y0Wq5w2VcYNNK6VlPf+A
Date:   Wed, 28 Nov 2018 14:23:48 +0000
Message-ID: <49bcee7c-9c8e-33af-4cea-6f76c6f00349@amd.com>
References: <1543395975-25339-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1543395975-25339-1-git-send-email-bianpan2016@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0018.prod.exchangelabs.com (2603:10b6:805:1::31)
 To SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2557;20:HD9cp+REpqFTAt3io1vY8GlBu/R3LBkaDHfPsvTRWjR0Qez8ETn+fK+jsm54nKEYEOoZx5okA26aq/YtlYsJPGF1K7w+8siUoj0khYYd/4vITtlogFRJpKyp0IYx1Szr8iMlOSTBZSvVVU879r/6CAkAxwj8PX5wjFe0MXViC9/hO4ZojWalM6ZIZ1IGt+ZLfJ3nWMGzQjd9aFNBD9+gyX8Ij27R3281sqBnhh8Z4JW2SSE0Yuo85GuyUtQipXXX
x-ms-office365-filtering-correlation-id: b3e9419e-fb64-42fa-a510-08d6553d1cd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2557;
x-ms-traffictypediagnostic: SN1PR12MB2557:
x-microsoft-antispam-prvs: <SN1PR12MB255762D53CAD11D0385EA5D1ECD10@SN1PR12MB2557.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231443)(999002)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB2557;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2557;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(6116002)(3846002)(2906002)(81156014)(81166006)(31686004)(68736007)(256004)(305945005)(229853002)(8936002)(36756003)(8676002)(25786009)(478600001)(86362001)(72206003)(105586002)(71200400001)(71190400001)(106356001)(6436002)(14454004)(186003)(26005)(5660300001)(31696002)(6486002)(486006)(99286004)(2616005)(476003)(54906003)(11346002)(446003)(110136005)(6512007)(4326008)(66066001)(102836004)(386003)(6506007)(53546011)(76176011)(7736002)(52116002)(53936002)(316002)(97736004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2557;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fFBzSnbXpcbjjQ0sjmRumJCnhMjHg7j5VYpQNP1akQkzMYtK5C2w73GFAidznC4z2HzUekKExi+3v0wNADcv7eWRbnSkkctD51IPK4M1kxg05mghxKYnWAEmfdksezJfYBzJO4Gq5wFEIhh5D1RZTX0Z/dMzNC/4UXjc/3HADmK1diFI+xCpmgQMjtgpp/MMMvn6G/ooQDPpAJ41WE2/oPcfzzNn4egBopE2sAjCUCoZxbydBIFxIOU1w+9ikno1eOKSKHu9YFHESVIs1bwY+bzn2lQ3aZyTIXKzKcV2epZa+l8yterLzDsbngjjgLyS102vYMWaca5dUif/KH8fUF0Qd3lrWYmqyk7UzRfCSHE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8550D3FD1783FB40A7AF3C38113A9ABC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e9419e-fb64-42fa-a510-08d6553d1cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 14:23:49.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjgvMjAxOCAwMzowNiBBTSwgUGFuIEJpYW4gd3JvdGU6DQo+IFRoZSBidWZmZXIgc2ti
IGlzIGZyZWVkIHZpYSBkZXZfa2ZyZWVfc2tiIGluIGEgbG9vcC4gQWZ0ZXIgZnJlZWluZyBza2Is
IA0KPiB0aGUgdmFsdWUgb2YgcGFja2V0X2NvdW50IGlzIHVwZGF0ZWQgdmlhIHBhY2tldF9jb3Vu
dCsrLiBJZiBwYWNrZXRfY291bnQNCj4gaGFwcGVucyB0byBlcXVhbCB0aGUgdXBwZXIgYm91bmQg
YnVkZ2V0LCB0aGUgbG9vcCB3aWxsIGJlIGJyb2tlbiBhbmQgc2tiIA0KPiBtYXkgYmUgYXNzaWdu
ZWQgdG8gcmRhdGEtPnN0YXRlLnNrYi4gUmVzdWx0aW5nIHRoYXQgcmRhdGEtPnN0YXRlLnNrYiBt
YXkNCg0KRXhjZXB0IHRoYXQgcmRhdGEtPnN0YXRlLnNrYiBpcyBvbmx5IGFzc2lnbmVkIGlmIHdl
IGhhdmUgcmVjZWl2ZWQNCnNvbWV0aGluZyBhbmQgaXQgaXMgKCFsYXN0IHx8IGNvbnRleHRfbmV4
dCkuICBJZiBlcnJvciBpcyBldmVyIHNldCwNCnRoZW4gd2UgcmVhZCBkZXNjcmlwdG9ycyBhcyBs
b25nIGFzICghbGFzdCB8fCBjb250ZXh0X25leHQpLiAgQWxzbywNCnBhY2tldC0+ZXJyb3JzIGNh
biBvbmx5IGJlIHNldCBmb3IgdGhlIGxhc3QgcGFja2V0IHdoaWNoIGltcGxpZXMgbm8NCmZvbGxv
d2luZyBjb250ZXh0IGRlc2NyaXB0b3JzLiAgU28gcmRhdGEtPnN0YXRlLnNrYiBjYW4gbmV2ZXIg
YmUgc2V0DQp3aXRoIHRoZSAiYmFkIiBza2IgdmFsdWUuDQoNClRoZSBvbmx5IHdheSBJIGNhbiBz
ZWUgdGhpcyBvY2N1cnJpbmcgaXMgaWYgYSBjb250ZXh0IGRlc2NyaXB0b3IgaXMNCmluZGljYXRl
ZCAoY29udGV4dF9uZXh0KSBhbG9uZyB3aXRoIHBhY2tldC0+ZXJyb3JzLiBBcmUgeW91IGFjdHVh
bGx5DQpzZWVpbmcgYW4gZXJyb3IvY3Jhc2ggd2hlcmUgdGhpcyBpcyBvY2N1cnJpbmc/ICBJZiBz
bywgdGhlbiB0aGUgZml4DQpzaG91bGQgYmUgdG8gZ290byByZWFkX2FnYWluIGlmIGNvbnRleHRf
bmV4dCBpcyBzZXQgYmVjYXVzZSB3ZSB3YW50DQp0byByZW1vdmUgdGhlIGNvbnRleHQgZGVzY3Jp
cHRvciBpbiB0aGlzIGNhc2UgYW5kIG5vdCBzYXZlIHRoZSBzdGF0ZS4NCg0KVGhhbmtzLA0KVG9t
DQoNCj4gcG9pbnQgdG8gYSBmcmVlZCBtZW1vcnkgY2h1bmsuIFRvIGZpeCB0aGlzLCB0aGUgcGF0
Y2ggc2V0cyBza2IgdG8gTlVMTCANCj4gYWZ0ZXIgZGV2X2tmcmVlX3NrYihza2IpLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogUGFuIEJpYW4gPGJpYW5wYW4yMDE2QDE2My5jb20+DQo+IC0tLQ0KPiBW
MjogY29ycmVjdCB0aGUgY29tbWl0IGxvZw0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2FtZC94Z2JlL3hnYmUtZHJ2LmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1kL3hnYmUv
eGdiZS1kcnYuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FtZC94Z2JlL3hnYmUtZHJ2LmMNCj4g
aW5kZXggMGNjOTExZi4uYWM2YjgyZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvYW1kL3hnYmUveGdiZS1kcnYuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWQv
eGdiZS94Z2JlLWRydi5jDQo+IEBAIC0yNzU0LDYgKzI3NTQsNyBAQCBzdGF0aWMgaW50IHhnYmVf
cnhfcG9sbChzdHJ1Y3QgeGdiZV9jaGFubmVsICpjaGFubmVsLCBpbnQgYnVkZ2V0KQ0KPiAgCQkJ
CW5ldGlmX2VycihwZGF0YSwgcnhfZXJyLCBuZXRkZXYsDQo+ICAJCQkJCSAgImVycm9yIGluIHJl
Y2VpdmVkIHBhY2tldFxuIik7DQo+ICAJCQlkZXZfa2ZyZWVfc2tiKHNrYik7DQo+ICsJCQlza2Ig
PSBOVUxMOw0KPiAgCQkJZ290byBuZXh0X3BhY2tldDsNCj4gIAkJfQ0KPiAgDQo+IEBAIC0yODA2
LDYgKzI4MDcsNyBAQCBzdGF0aWMgaW50IHhnYmVfcnhfcG9sbChzdHJ1Y3QgeGdiZV9jaGFubmVs
ICpjaGFubmVsLCBpbnQgYnVkZ2V0KQ0KPiAgCQkJbmV0aWZfZXJyKHBkYXRhLCByeF9lcnIsIG5l
dGRldiwNCj4gIAkJCQkgICJwYWNrZXQgbGVuZ3RoIGV4Y2VlZHMgY29uZmlndXJlZCBNVFVcbiIp
Ow0KPiAgCQkJZGV2X2tmcmVlX3NrYihza2IpOw0KPiArCQkJc2tiID0gTlVMTDsNCj4gIAkJCWdv
dG8gbmV4dF9wYWNrZXQ7DQo+ICAJCX0NCj4gIA0KPiANCg==
