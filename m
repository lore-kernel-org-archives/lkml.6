Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA344C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBD12087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="khk/IO3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBD12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeH1SZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:25:09 -0400
Received: from mail-eopbgr690130.outbound.protection.outlook.com ([40.107.69.130]:47810
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbeH1SZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KGFM0p2pBbWa6A498V468z1yFQl322Ot7ltSvAxB+s=;
 b=khk/IO3KhNjX0VpfyPKjD8VScdeQ95wTJuSNqCfMsVGGuHdTA/kmQa8jhD0Vu1+BdPAH4ZLR/ibLBvfV+yNMiHt10pVAuHYAiTVi5RNuUGMa2zGc2B6zQD90uGPszFqzx6NZOrzR+XBy5ATTPBr81OEej05xndZpxvHH4CMy0P0=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0842.namprd21.prod.outlook.com (10.173.172.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Tue, 28 Aug 2018 14:33:09 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.000; Tue, 28 Aug 2018
 14:33:09 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>
Subject: Re: [PATCH] memory_hotplug: fix kernel_panic on offline page
 processing
Thread-Topic: [PATCH] memory_hotplug: fix kernel_panic on offline page
 processing
Thread-Index: AQHUPtwJzbI/s3I97UCDL9iYTlV/Kg==
Date:   Tue, 28 Aug 2018 14:33:09 +0000
Message-ID: <4d5dfb19-0ae7-a730-4066-df0b98cb4a0b@microsoft.com>
References: <20180828090539.41491-1-zaslonko@linux.ibm.com>
 <20180828112543.GK10223@dhcp22.suse.cz>
In-Reply-To: <20180828112543.GK10223@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0842;6:w2+otTEFK24vYNIudNjr73IrvKHOaVVep5j8UiftzSX7ckXE+qv7TtUETxGPF+9etuqS594kdHrCZPEPXew/tG/we4NXNyusk11Wf7yR37IDHvi4N72seMqPy8NPVT7V3SI8R3yb4NVEa2YJPMBUoNRoNLdoGK7Kt+5JdZYqXh8VJV3+LgVEHvFBCvb6NpOe+bB63e1qJGhOqFI9ytX0swwcoxWHPtBSQcxFVIf2MNt0W/hJcEFek+PUZ0m44mAVX26SK6cNaH+3Q8yXo0UcmSxSXZ4C0aY/Uxy40IE71t+4z+lbmPsoBBrxnkpgpHhaDEtHQKx9bo2ArX62v/7oD7kbmWlnyXgBdj7qhUZgpCveAJM6pgl6NXQomBBLUpd6go+mRCQ/pxVTIkFnU9rQ4y2mf6Q7Uvg76Q/Xvc9helhhccXeMV35QUwuXMFjQHrgHurXGl7wvQCPZhhvLyQehw==;5:oLpcVlGWEoPoX1hHoShI4mFYY66zUTI5xTDskJNlkqc4GvFMhxl6rcxMjd7Y6GcFmGICC6VypOgHe2sLO6CHN23be6JPKPmALIkioAT27ON2yItnrTNSzrOcl2ipuxZ3ZXiTHVnpVAYy8ALs/QEk7IaTME2U0uOdpFuOM9Echoo=;7:DMWTwZEsuqGpALpbb4DYxFJY+Nuy4IdFR7QJF5D3enud/Dz2DWzugU7LwxCbXGGdzeBoP+YFbt+NEreFGr0eFw0U3zwhsXRTPTLqogvHtBA4tarUKz6KcBC73QmTHbj4X7uFtdwoVAqeOwuQm5AYWjNDV9138ON/8UfF7urEco1RKWBCybwKT/8XAFx4n84K5J+PXgStrMxAI34NUwtljKCXqbgRGWdfsLRmUm/NbtSSUVSseDATtx6B078H+jUS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 75de852a-5c90-4829-d4b8-08d60cf32d6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0842;
x-ms-traffictypediagnostic: DM5PR21MB0842:
x-microsoft-antispam-prvs: <DM5PR21MB08421F8B58C1AAA4EAA8A2299D0A0@DM5PR21MB0842.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(9452136761055)(104084551191319)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231336)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0842;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0842;
x-forefront-prvs: 077884B8B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(14444005)(256004)(2906002)(66066001)(8676002)(305945005)(7736002)(10090500001)(2900100001)(106356001)(105586002)(6486002)(4326008)(11346002)(446003)(81156014)(476003)(2616005)(81166006)(8936002)(6246003)(486006)(6512007)(86362001)(575784001)(68736007)(31696002)(86612001)(6436002)(31686004)(25786009)(53936002)(76176011)(36756003)(22452003)(316002)(186003)(229853002)(99286004)(26005)(6346003)(53546011)(54906003)(6506007)(110136005)(102836004)(14454004)(5250100002)(72206003)(478600001)(6116002)(3846002)(5660300001)(97736004)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0842;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: 3ZSW1BEx/US+NlrDIz3HaNYSUeJpe690gtYZXm6JtbC8IzXcFEFwP7P+YmOra1eKIx/2Ms9GrRaSs54XxriSziU9zuwMKDsyj1Cn2w4nW3zJsJ4nPENCRZ+JfXjSHeJO8OoyyGqp6nLcBMHzXXpRgRo20Yth4wKTWLIRS6KNAfCFKPFntrSnZfLTCueRu3j5D8pomvpCK6O7OqchIOUhQKqreZUladjjP6ZhsNp3dctNofvFCOgZT7ct4tqlxVuN2Qoe3JvnvDMrX68NXPLSV3gG6P8BkR6ZOxorZQTYJHqPBs2uMrhvyyqbsK6y0nXtGTUnt4NhNerMtPR7n2QStW8FiesGUFl9RZh7JP3wcUE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <497F05CD25541240AB7543EEC2AF466B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75de852a-5c90-4829-d4b8-08d60cf32d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2018 14:33:09.6652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDgvMjgvMTggNzoyNSBBTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiBPbiBUdWUgMjgt
MDgtMTggMTE6MDU6MzksIE1pa2hhaWwgWmFzbG9ua28gd3JvdGU6DQo+PiBXaXRoaW4gc2hvd192
YWxpZF96b25lcygpIHRoZSBmdW5jdGlvbiB0ZXN0X3BhZ2VzX2luX2Ffem9uZSgpIHNob3VsZCBi
ZQ0KPj4gY2FsbGVkIGZvciBvbmxpbmUgbWVtb3J5IGJsb2NrcyBvbmx5LiBPdGhlcndpc2UgaXQg
bWlnaHQgbGVhZCB0byB0aGUNCj4+IFZNX0JVR19PTiBkdWUgdG8gdW5pbml0aWFsaXplZCBzdHJ1
Y3QgcGFnZXMgKHdoZW4gQ09ORklHX0RFQlVHX1ZNX1BHRkxBR1MNCj4+IGtlcm5lbCBvcHRpb24g
aXMgc2V0KToNCj4+DQo+PiAgcGFnZSBkdW1wZWQgYmVjYXVzZTogVk1fQlVHX09OX1BBR0UoUGFn
ZVBvaXNvbmVkKHApKQ0KPj4gIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0K
Pj4gIENhbGwgVHJhY2U6DQo+PiAgKFs8MDAwMDAwMDAwMDM4ZjkxZT5dIHRlc3RfcGFnZXNfaW5f
YV96b25lKzB4ZTYvMHgxNjgpDQo+PiAgIFs8MDAwMDAwMDAwMDkyMzQ3Mj5dIHNob3dfdmFsaWRf
em9uZXMrMHg1YS8weDFhOA0KPj4gICBbPDAwMDAwMDAwMDA5MDAyODQ+XSBkZXZfYXR0cl9zaG93
KzB4M2MvMHg3OA0KPj4gICBbPDAwMDAwMDAwMDA0NmY2ZjA+XSBzeXNmc19rZl9zZXFfc2hvdysw
eGQwLzB4MTUwDQo+PiAgIFs8MDAwMDAwMDAwMDNlZjY2Mj5dIHNlcV9yZWFkKzB4MjEyLzB4NGI4
DQo+PiAgIFs8MDAwMDAwMDAwMDNiZjIwMj5dIF9fdmZzX3JlYWQrMHgzYS8weDE3OA0KPj4gICBb
PDAwMDAwMDAwMDAzYmYzY2E+XSB2ZnNfcmVhZCsweDhhLzB4MTQ4DQo+PiAgIFs8MDAwMDAwMDAw
MDNiZmEzYT5dIGtzeXNfcmVhZCsweDYyLzB4YjgNCj4+ICAgWzwwMDAwMDAwMDAwYmMyMjIwPl0g
c3lzdGVtX2NhbGwrMHhkYy8weDJkOA0KPj4NCj4+IFRoYXQgVk1fQlVHX09OIHdhcyB0cmlnZ2Vy
ZWQgYnkgdGhlIHBhZ2UgcG9pc29uaW5nIGludHJvZHVjZWQgaW4NCj4+IG1tL3NwYXJzZS5jIHdp
dGggdGhlIGdpdCBjb21taXQgZDBkYzEyZTg2YjMxICgibW0vbWVtb3J5X2hvdHBsdWc6IG9wdGlt
aXplDQo+PiBtZW1vcnkgaG90cGx1ZyIpDQo+PiBXaXRoIHRoZSBzYW1lIGNvbW1pdCB0aGUgbmV3
ICduaWQnIGZpZWxkIGhhcyBiZWVuIGFkZGVkIHRvIHRoZSBzdHJ1Y3QNCj4+IG1lbW9yeV9ibG9j
ayBpbiBvcmRlciB0byBzdG9yZSBhbmQgbGF0ZXIgb24gZGVyaXZlIHRoZSBub2RlIGlkIGZvciBv
ZmZsaW5lDQo+PiBwYWdlcyAoaW5zdGVhZCBvZiBhY2Nlc3Npbmcgc3RydWN0IHBhZ2Ugd2hpY2gg
bWlnaHQgYmUgdW5pbml0aWFsaXplZCkuIEJ1dA0KPj4gb25lIHJlZmVyZW5jZSB0byBuaWQgaW4g
c2hvd192YWxpZF96b25lcygpIGZ1bmN0aW9uIGhhcyBiZWVuIG92ZXJsb29rZWQuDQo+PiBGaXhl
ZCB3aXRoIGN1cnJlbnQgY29tbWl0Lg0KPj4gQWxzbywgbnJfcGFnZXMgd2lsbCBub3QgYmUgdXNl
ZCBhbnkgbW9yZSBhZnRlciB0ZXN0X3BhZ2VzX2luX2Ffem9uZSgpIGNhbGwsDQo+PiBkbyBub3Qg
dXBkYXRlIGl0Lg0KPj4NCj4+IEZpeGVzOiBkMGRjMTJlODZiMzEgKCJtbS9tZW1vcnlfaG90cGx1
Zzogb3B0aW1pemUgbWVtb3J5IGhvdHBsdWciKQ0KPj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwu
b3JnPiAjIHY0LjE3Kw0KPj4gQ2M6IFBhdmVsIFRhdGFzaGluIDxwYXNoYS50YXRhc2hpbkBvcmFj
bGUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogTWlraGFpbCBaYXNsb25rbyA8emFzbG9ua29AbGlu
dXguaWJtLmNvbT4NCj4gDQo+IEJ0dy4gdGhpcyBsYW5kIG1pbmVzIHdoaWNoIGFyZSBiYXNpY2Fs
bHkgaW1wb3NzaWJsZSB0byBmaW5kIGR1cmluZyB0aGUNCj4gcmV2aWV3IGFyZSB0aGUgcmVhc29u
IHdoeSBJIHdhcyBub3QgYWxsIHRoYXQgaGFwcHkgYWJvdXQgZDBkYzEyZTg2YjMxLg0KPiBJdCBh
ZGRlZCBhIG1hcmduaW5hbCBpbXByb3ZlbWVudCBidXQgb3BlbmVkIGEgY2FuIG9mIHdhcm1zLiBP
biB0aGUgb3RoZXINCg0KSGkgTWljaGFsLA0KDQpJIGFncmVlLCB0aGUgaG90cGx1ZyBjb2RlIGlz
IHZlcnkgZnJhZ2lsZS4gQnV0LCBpdCBvbmx5IG1lYW5zIHRoYXQgaXQNCnJlcXVpcmVzIGltcHJv
dmVtZW50cy4NCg0KSSBzcGVjaWZpY2FsbHkgYWRkZWQgUGFnZVBvaXNvbmVkKCkgY2hlY2sgd2l0
aCBob3RwbHVnIG9wdGltaXphdGlvbnMNCmNoYW5nZXMgaW4gb3JkZXIgdG8gY2F0Y2ggdGhlc2Ug
a2luZCBvZiBidWdzLCBhbmQgSSBhbSBnbGFkIHdlIGFyZQ0KY2F0Y2hpbmcgdGhlbS4NCg0KUmV2
aWV3ZWQtYnk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg0K
DQpUaGFuayB5b3UsDQpQYXZlbA0KDQo+IGhhbmQgbWF5YmUgd2UganVzdCBoYWQgdG8gb3BlbiB0
aGF0IGNhbiBvbmUgZGF5Li4uDQo+IA0KPiBBY2tlZC1ieTogTWljaGFsIEhvY2tvIDxtaG9ja29A
c3VzZS5jb20+DQo+IA0KPiBUaGFua3MhDQo+IA0KPj4gLS0tDQo+PiAgZHJpdmVycy9iYXNlL21l
bW9yeS5jIHwgMjAgKysrKysrKysrLS0tLS0tLS0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgOSBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9iYXNlL21lbW9yeS5jIGIvZHJpdmVycy9iYXNlL21lbW9yeS5jDQo+PiBpbmRleCBmNWU1NjAx
ODhhMTguLjYyMmFiOGVkYzAzNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYmFzZS9tZW1vcnku
Yw0KPj4gKysrIGIvZHJpdmVycy9iYXNlL21lbW9yeS5jDQo+PiBAQCAtNDE2LDI2ICs0MTYsMjQg
QEAgc3RhdGljIHNzaXplX3Qgc2hvd192YWxpZF96b25lcyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+
PiAgCXN0cnVjdCB6b25lICpkZWZhdWx0X3pvbmU7DQo+PiAgCWludCBuaWQ7DQo+PiAgDQo+PiAt
CS8qDQo+PiAtCSAqIFRoZSBibG9jayBjb250YWlucyBtb3JlIHRoYW4gb25lIHpvbmUgY2FuIG5v
dCBiZSBvZmZsaW5lZC4NCj4+IC0JICogVGhpcyBjYW4gaGFwcGVuIGUuZy4gZm9yIFpPTkVfRE1B
IGFuZCBaT05FX0RNQTMyDQo+PiAtCSAqLw0KPj4gLQlpZiAoIXRlc3RfcGFnZXNfaW5fYV96b25l
KHN0YXJ0X3Bmbiwgc3RhcnRfcGZuICsgbnJfcGFnZXMsICZ2YWxpZF9zdGFydF9wZm4sICZ2YWxp
ZF9lbmRfcGZuKSkNCj4+IC0JCXJldHVybiBzcHJpbnRmKGJ1ZiwgIm5vbmVcbiIpOw0KPj4gLQ0K
Pj4gLQlzdGFydF9wZm4gPSB2YWxpZF9zdGFydF9wZm47DQo+PiAtCW5yX3BhZ2VzID0gdmFsaWRf
ZW5kX3BmbiAtIHN0YXJ0X3BmbjsNCj4+IC0NCj4+ICAJLyoNCj4+ICAJICogQ2hlY2sgdGhlIGV4
aXN0aW5nIHpvbmUuIE1ha2Ugc3VyZSB0aGF0IHdlIGRvIHRoYXQgb25seSBvbiB0aGUNCj4+ICAJ
ICogb25saW5lIG5vZGVzIG90aGVyd2lzZSB0aGUgcGFnZV96b25lIGlzIG5vdCByZWxpYWJsZQ0K
Pj4gIAkgKi8NCj4+ICAJaWYgKG1lbS0+c3RhdGUgPT0gTUVNX09OTElORSkgew0KPj4gKwkJLyoN
Cj4+ICsJCSAqIFRoZSBibG9jayBjb250YWlucyBtb3JlIHRoYW4gb25lIHpvbmUgY2FuIG5vdCBi
ZSBvZmZsaW5lZC4NCj4+ICsJCSAqIFRoaXMgY2FuIGhhcHBlbiBlLmcuIGZvciBaT05FX0RNQSBh
bmQgWk9ORV9ETUEzMg0KPj4gKwkJICovDQo+PiArCQlpZiAoIXRlc3RfcGFnZXNfaW5fYV96b25l
KHN0YXJ0X3Bmbiwgc3RhcnRfcGZuICsgbnJfcGFnZXMsDQo+PiArCQkJCQkgICZ2YWxpZF9zdGFy
dF9wZm4sICZ2YWxpZF9lbmRfcGZuKSkNCj4+ICsJCQlyZXR1cm4gc3ByaW50ZihidWYsICJub25l
XG4iKTsNCj4+ICsJCXN0YXJ0X3BmbiA9IHZhbGlkX3N0YXJ0X3BmbjsNCj4+ICAJCXN0cmNhdChi
dWYsIHBhZ2Vfem9uZShwZm5fdG9fcGFnZShzdGFydF9wZm4pKS0+bmFtZSk7DQo+PiAgCQlnb3Rv
IG91dDsNCj4+ICAJfQ0KPj4gIA0KPj4gLQluaWQgPSBwZm5fdG9fbmlkKHN0YXJ0X3Bmbik7DQo+
PiArCW5pZCA9IG1lbS0+bmlkOw0KPj4gIAlkZWZhdWx0X3pvbmUgPSB6b25lX2Zvcl9wZm5fcmFu
Z2UoTU1PUF9PTkxJTkVfS0VFUCwgbmlkLCBzdGFydF9wZm4sIG5yX3BhZ2VzKTsNCj4+ICAJc3Ry
Y2F0KGJ1ZiwgZGVmYXVsdF96b25lLT5uYW1lKTsNCj4+ICANCj4+IC0tIA0KPj4gMi4xNi40DQo+
IA==
