Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5063BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DA520684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W69m/sO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DA520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeIZTN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:13:59 -0400
Received: from mail-eopbgr690042.outbound.protection.outlook.com ([40.107.69.42]:30405
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbeIZTN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyMN1b/GwZOMPq8Q8v3R65gbkIDbUbAbvRogBxAbakA=;
 b=W69m/sO/CrXK68aUoqQK1r86FDK8xoYspjInpyP5fgNkjuzu3Dzg1X3XJMZMFUyqqGwi2KdpknRoEbRwb7xAuC3SnPwNbfUQHdLFT8z2QP2E0z70rP8O99SCP1w9uIxhJ0wMQuV66V67HL3zs/TsfwPZtWKzZ3Fqq/peZahpJUE=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0224.namprd12.prod.outlook.com (10.162.3.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.19; Wed, 26 Sep 2018 13:01:01 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.022; Wed, 26 Sep 2018
 13:01:01 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@suse.de>
CC:     Kairui Song <kasong@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dyoung@redhat.com" <dyoung@redhat.com>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Thread-Topic: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot
 support
Thread-Index: AQHUVMCt5d5bmoFMGEWPE1C0OEtwMKUAvDIAgACD/QCAAOyTAIAAQA4AgAAbngA=
Date:   Wed, 26 Sep 2018 13:01:00 +0000
Message-ID: <3b41fee3-e2f6-2e36-d2ca-1074c5f62bb8@amd.com>
References: <20180925111020.23834-1-kasong@redhat.com>
 <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
 <20180925172608.GB15464@zn.tnic> <20180926073252.GC2555@MiWiFi-R3L-srv>
 <20180926112208.GE2555@MiWiFi-R3L-srv>
In-Reply-To: <20180926112208.GE2555@MiWiFi-R3L-srv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:903:33::33) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0224;20:GeSKWd4GyMtDh+RU8FAjm0r9h4+KwgM+HERdjz401rWZ2IYrDRN6+IC9lvrdA/OTaLeOv/dxWOfLomgxImokhGgXs7wVfJyZvUwyflbEov8hwqzjmgeYtRIlZ+x5etE+k6j4lIF0AN9ApK+dVuMCYk32rvUhw2JsB89t34ZsNZ8hwHwAxNRsXVd6w2ESf3XLyerwAY+1Vqc7DoQlOQFN3zjjeksCm6qen4lzgfbwiUuJFZW5oahfYDpEFRn3upNi
x-ms-office365-filtering-correlation-id: 8f015735-5c0a-49d9-b4df-08d623b01b94
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0224;
x-ms-traffictypediagnostic: SN1PR12MB0224:
x-microsoft-antispam-prvs: <SN1PR12MB0224350EE12AD5AA58C2EE06EC150@SN1PR12MB0224.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN1PR12MB0224;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0224;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(396003)(376002)(346002)(189003)(199004)(575784001)(86362001)(14454004)(2906002)(6436002)(7416002)(2900100001)(81166006)(81156014)(4326008)(8936002)(52116002)(229853002)(3846002)(5250100002)(36756003)(11346002)(486006)(2616005)(71200400001)(476003)(6116002)(71190400001)(8676002)(446003)(186003)(6486002)(72206003)(31696002)(478600001)(34290500001)(97736004)(386003)(6506007)(53546011)(5660300001)(31686004)(26005)(105586002)(256004)(102836004)(106356001)(305945005)(68736007)(25786009)(14444005)(7736002)(76176011)(6246003)(53936002)(316002)(93886005)(99286004)(66066001)(6512007)(110136005)(54906003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0224;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wHk0gM9Rc6R3T7pkcWmfnYGwiq0KI+0326w5kbikRyuparLwcE6aNu93Ejrq8D1LllZ+6v2vQFNUHRgFmGtlfSnDiFAfGpatDiAKnCLn1YGp/zzOhzLp3Q83G2DdeNFiuMVd6GGEmlG2ungr2nr79EEhtkclcP2+NPoBn+39/wmNEbsywptT63ubAR3avBq/ch1sK6dH347FQISSSemLXduLInIJNXkvHVl6hw4ChLnviuqR7t0kuDG1LXgxElTwtiIjBFDLiQeExzHqzSUAswmCYwPhpxOujIsqDSQ8ie3pfqYDt9msSKm5gaZr5Fg6YkDkFMrY89LEH54EgpBBIvpSafjwaZa51TtgA+IKNlc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2145C828E2B1C47BA0CA5371D2872BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f015735-5c0a-49d9-b4df-08d623b01b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 13:01:01.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMjYvMjAxOCAwNjoyMiBBTSwgQmFvcXVhbiBIZSB3cm90ZToNCj4gT24gMDkvMjYvMTgg
YXQgMDM6MzJwbSwgQmFvcXVhbiBIZSB3cm90ZToNCj4+IE9uIDA5LzI1LzE4IGF0IDA3OjI2cG0s
IEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4+PiBJSU5NLCB0aGUgcHJvYmxlbSBjYW4gYmUgYWRk
cmVzc2VkIGluIGEgc2ltcGxlciB3YXkgYnkgZ2V0dGluZyByaWQgb2YNCj4+PiBlbmNfYml0IGFu
ZCB0aHVzIGdldHRpbmcgcmlkIG9mIHRoZSBuZWVkIHRvIGRvIHJlbGF0aXZlIGFkZHJlc3Npbmcg
b2YNCj4+PiBhbnl0aGluZyBhbmQgc2ltcGx5IGRvaW5nIHRoZSB3aG9sZSBkYW5jZSBvZiBmaWd1
cmluZyBvdXQgdGhlIEMtYml0IGVhY2gNCj4+PiB0aW1lLiBJdCBwcm9iYWJseSB3b3VsZG4ndCBi
ZSBldmVuIG1lYXN1cmFibGUuLi4NCj4+DQo+PiBDb3VsZG4ndCBhZ3JlZSBtb3JlLg0KPj4NCj4+
IE9idmlvdXNseSBlbmNfYml0IGlzIHJlZHVuZGVudCBoZXJlLiBXZSBvbmx5IGNoZWNrIGVheCBl
YWNoIHRpbWUsDQo+PiByZW1vdmluZyBpdCBjYW4gZml4IHRoZSBSSVAtcmVsYXRpdmUgYWRkcmVz
c2luZyBpc3N1ZSBpbiBrZXhlYy4NCj4gDQo+IE9LLCBpbiBkaXN0cm9zIENPTkZJR19BTURfTUVN
X0VOQ1JZUFQ9eSBpcyBzZXQgYnkgZGVmYXVsdCB1c3VhbGx5Lg0KPiBlbmNfYml0IGNhbiBzYXZl
IG9uY2UgaW4gbm9ybWFsIGJvb3QsIHRoZW4gZmV0Y2ggYW5kIHNraXAgdGhlIGNwdWlkDQo+IGRl
dGVjdGlvbiBpbiBpbml0aWFsaXplX2lkZW50aXR5X21hcHMoKS4gSG93ZXZlciB0aGlzIG9ubHkg
c3BlZWRzIHVwIGluDQo+IGFtZCBzeXN0ZW0gd2l0aCBTTUUsIG9uIGludGVsIGNwdSBhbmQgYW1k
IGNwdSB3L28gc21lLCBpdCBzdGlsbCBuZWVkcyB0bw0KPiBkbyBjcHVpZCB0d2ljZS4gUmVtb3Zp
bmcgaXQgc2hvdWxkIGJlIG5vdCBtZWFzdXJhYmxlIGFzIEJvcmlzIHNhaWQuDQo+IE5vdCBzdXJl
IGlmIFRvbSBoYXMgb3RoZXIgY29uY2Vybi4NCg0KTm8gY29uY2VybiBmcm9tIG1lLiAgVGhlIG9y
aWdpbmFsIHZlcnNpb24gb2YgdGhlIHBhdGNoIGRpZCBub3QgY2FjaGUgdGhlDQp2YWx1ZSwgdGhh
dCB3YXMgYWRkZWQgYmFzZWQgb24gdGhlIHBhdGNoIHNlcmllcyBmZWVkYmFjay4gIFNvLCBpZiB0
aGVyZQ0KaXMgbm8gY29uY2VybiBhYm91dCBleGVjdXRpbmcgc29tZSBleHRyYSBDUFVJRC9SRE1T
UiBpbnN0cnVjdGlvbnMsIHRoZW4NCml0IHdvdWxkIGNlcnRhaW5seSBzaW1wbGlmeSB0aGUgY29k
ZSBxdWl0ZSBhIGJpdC4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+IFRoYW5rcw0KPiBCYW9xdWFu
DQo+IA0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvbWVtX2Vu
Y3J5cHQuUyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9tZW1fZW5jcnlwdC5TDQo+PiBpbmRl
eCBlYWE4NDNhNTI5MDcuLjBiNjBlYjg2N2QyNSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2Jv
b3QvY29tcHJlc3NlZC9tZW1fZW5jcnlwdC5TDQo+PiArKysgYi9hcmNoL3g4Ni9ib290L2NvbXBy
ZXNzZWQvbWVtX2VuY3J5cHQuUw0KPj4gQEAgLTI3LDE5ICsyNyw2IEBAIEVOVFJZKGdldF9zZXZf
ZW5jcnlwdGlvbl9iaXQpDQo+PiAgCXB1c2gJJWVkeA0KPj4gIAlwdXNoCSVlZGkNCj4+ICANCj4+
IC0JLyoNCj4+IC0JICogUklQLXJlbGF0aXZlIGFkZHJlc3NpbmcgaXMgbmVlZGVkIHRvIGFjY2Vz
cyB0aGUgZW5jcnlwdGlvbiBiaXQNCj4+IC0JICogdmFyaWFibGUuIFNpbmNlIHdlIGFyZSBydW5u
aW5nIGluIDMyLWJpdCBtb2RlIHdlIG5lZWQgdGhpcyBjYWxsL3BvcA0KPj4gLQkgKiBzZXF1ZW5j
ZSB0byBnZXQgdGhlIHByb3BlciByZWxhdGl2ZSBhZGRyZXNzaW5nLg0KPj4gLQkgKi8NCj4+IC0J
Y2FsbAkxZg0KPj4gLTE6CXBvcGwJJWVkaQ0KPj4gLQlzdWJsCSQxYiwgJWVkaQ0KPj4gLQ0KPj4g
LQltb3ZsCWVuY19iaXQoJWVkaSksICVlYXgNCj4+IC0JY21wbAkkMCwgJWVheA0KPj4gLQlqZ2UJ
LkxzZXZfZXhpdA0KPj4gLQ0KPj4gIAkvKiBDaGVjayBpZiBydW5uaW5nIHVuZGVyIGEgaHlwZXJ2
aXNvciAqLw0KPj4gIAltb3ZsCSQxLCAlZWF4DQo+PiAgCWNwdWlkDQo+PiBAQCAtNjksMTIgKzU2
LDEwIEBAIEVOVFJZKGdldF9zZXZfZW5jcnlwdGlvbl9iaXQpDQo+PiAgDQo+PiAgCW1vdmwJJWVi
eCwgJWVheA0KPj4gIAlhbmRsCSQweDNmLCAlZWF4CQkvKiBSZXR1cm4gdGhlIGVuY3J5cHRpb24g
Yml0IGxvY2F0aW9uICovDQo+PiAtCW1vdmwJJWVheCwgZW5jX2JpdCglZWRpKQ0KPj4gIAlqbXAJ
LkxzZXZfZXhpdA0KPj4gIA0KPj4gIC5Mbm9fc2V2Og0KPj4gIAl4b3IJJWVheCwgJWVheA0KPj4g
LQltb3ZsCSVlYXgsIGVuY19iaXQoJWVkaSkNCj4+ICANCj4+ICAuTHNldl9leGl0Og0KPj4gIAlw
b3AJJWVkaQ0KPj4gQEAgLTExMyw5ICs5OCw2IEBAIEVOVFJZKHNldF9zZXZfZW5jcnlwdGlvbl9t
YXNrKQ0KPj4gIEVORFBST0Moc2V0X3Nldl9lbmNyeXB0aW9uX21hc2spDQo+PiAgDQo+PiAgCS5k
YXRhDQo+PiAtZW5jX2JpdDoNCj4+IC0JLmludAkweGZmZmZmZmZmDQo+PiAtDQo+PiAgI2lmZGVm
IENPTkZJR19BTURfTUVNX0VOQ1JZUFQNCj4+ICAJLmJhbGlnbgk4DQo+PiAgR0xPQkFMKHNtZV9t
ZV9tYXNrKQ0K
