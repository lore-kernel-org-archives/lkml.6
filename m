Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D200EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8920826D26
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8920826D26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeFZPZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:25:45 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:45604 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeFZPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:25:43 -0400
Received: from G2W6309.americas.hpqcorp.net (g2w6309.austin.hp.com [16.197.64.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id 6A8BA63;
        Tue, 26 Jun 2018 15:25:42 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) by
 G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 26 Jun 2018 15:25:41 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 26 Jun 2018 15:25:41 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1057.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.20; Tue, 26 Jun 2018 15:25:39 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::51c9:8d4d:952d:94c8%5]) with mapi id 15.20.0906.018; Tue, 26 Jun 2018
 15:25:39 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mhocko@kernel.org" <mhocko@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>
Subject: Re: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
Thread-Topic: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
Thread-Index: AQHUC73/TYYF8RoO3UmhiJVFAtgPVKRxEVsAgAAx7QCAADfbgIAAnRaAgAAkR4CAAAKxgIAAbKcA
Date:   Tue, 26 Jun 2018 15:25:39 +0000
Message-ID: <1530026622.14039.269.camel@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
         <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
         <1529938470.14039.134.camel@hpe.com>
         <20180625175225.GQ28965@dhcp22.suse.cz>
         <1529961187.14039.206.camel@hpe.com>
         <20180626063521.GT28965@dhcp22.suse.cz>
         <alpine.DEB.2.21.1806261043080.2204@nanos.tec.linutronix.de>
         <20180626085449.GU28965@dhcp22.suse.cz>
In-Reply-To: <20180626085449.GU28965@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1057;7:0t7ZoFWpDd5lEut2iZMhyLQsLPA1F6g2U185Hf+zORTpJmaGyUTIDLI/srM9LFpN550U65YfqfoJqRV8R0iBReG57VRd0CpkWcAViT+r1x2pRyvA7F4UZDYxk7wbJNvZDT8OjkngBETq1dOW2RKd7pVRfOD6x0OqXtsCK+VxZLSZLGmOkJqwdTAc/ZeK4L6JqQ0UMnxFRZplQcUMKt0dAifuO06D+McNfuqzKJQVM32PhdfMfgkeiCYJq9+8EClm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 48947b92-7db8-426e-8a8f-08d5db7912a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1057;
x-ms-traffictypediagnostic: AT5PR8401MB1057:
x-microsoft-antispam-prvs: <AT5PR8401MB10576F2E45660ACB708C299282490@AT5PR8401MB1057.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB1057;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1057;
x-forefront-prvs: 071518EF63
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(43544003)(199004)(106356001)(2906002)(6116002)(3846002)(97736004)(6506007)(53936002)(103116003)(476003)(6246003)(486006)(66066001)(2616005)(76176011)(446003)(11346002)(7736002)(305945005)(93886005)(105586002)(36756003)(7416002)(4326008)(186003)(110136005)(5660300001)(25786009)(8676002)(102836004)(8936002)(26005)(99286004)(229853002)(54906003)(81156014)(81166006)(316002)(966005)(14454004)(6306002)(6436002)(478600001)(68736007)(2501003)(86362001)(14444005)(6512007)(5250100002)(256004)(2900100001)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1057;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iwG97iYSrvRKrBWyAWECRbQyIguyhctFhQRqqZ6EU5gzedI7jNjQm/BLpYcwS5xmj8rHFX4WfYE53abDTicLbIlMh01122iLnfYwNjiOzqJY3CbBi/uhZMWqbmlNNtv8bNKkVRg72xCeMTYiLM78VbGtFDmi08sbYdDpfNgsk24Ssp1k3pTBglsohqS8yX07jsNE0TfPs/+OXfkhOd4/H+1lE03ywttuvFSI5K6E1KEfI4u7YQ1u7SeRI5Ehmi9qanFNngb0uS7CX7FxXUmiZWExTjP3PTRoOZccv1sCJVTTZ8ei4217lmqgIr++ax9fAC1a2tnDprvW8QPkq5qYY/csMEGf56efXVrTId3nyQo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CB88FBC3D5B3949B0B56DEB8DAA6C41@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48947b92-7db8-426e-8a8f-08d5db7912a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 15:25:39.2020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1057
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA2LTI2IGF0IDEwOjU0ICswMjAwLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+
IE9uIFR1ZSAyNi0wNi0xOCAxMDo0NToxMSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+IE9u
IFR1ZSwgMjYgSnVuIDIwMTgsIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gPiA+IE9uIE1vbiAyNS0w
Ni0xOCAyMToxNTowMywgS2FuaSBUb3NoaW1pdHN1IHdyb3RlOg0KPiA+ID4gPiBMYXN0bHksIGZv
ciB0aGUgY29kZSBtYWludGVuYW5jZSwgSSBiZWxpZXZlIHRoaXMgbWVtb3J5IGFsbG9jYXRpb24g
a2VlcHMNCj4gPiA+ID4gdGhlIGNvZGUgbXVjaCBzaW1wbGVyIHRoYW4gaXQgd291bGQgb3RoZXJ3
aXNlIG5lZWQgdG8gbWFuYWdlIGEgc3BlY2lhbA0KPiA+ID4gPiBwYWdlIGxpc3QuDQo+ID4gPiAN
Cj4gPiA+IFllcywgSSBjYW4gc2VlIGEgc2ltcGxpY2l0eSBhcyBhIHJlYXNvbmFibGUgYXJndW1l
bnQgZm9yIGEgcXVpY2sgZml4LA0KPiA+ID4gd2hpY2ggdGhlc2UgcGlsZSBpcyBzdXBwb3NlZCB0
byBiZSBBRkFJVS4gU28gdGhpcyBtaWdodCBiZSBnb29kIHRvIGdvDQo+ID4gPiBmcm9tIHRoYXQg
cGVyc3BlY3RpdmUsIGJ1dCBJIGJlbGlldmUgdGhhdCB0aGlzIHNob3VsZCBiZSBjaGFuZ2VkIGlu
DQo+ID4gPiBmdXR1cmUgYXQgbGVhc3QuDQo+ID4gDQo+ID4gU28gdGhlIGNvbmNsdXNpb24gaXMs
IHRoYXQgd2Ugc2hpcCB0aGlzIHNldCBvZiBwYXRjaGVzIG5vdyB0byBjdXJlIHRoZQ0KPiA+IGV4
aXN0aW5nIHdyZWNrYWdlLCByaWdodD8NCj4gDQo+IEpvZXJnIHdhcyBzdWdnZXN0aW5nIHNvbWUg
YWx0ZXJuYXRpdmUgYnV0IEkgZ290IGxvc3QgaW4gdGhlIGRpc2N1c3Npb24NCj4gdG8gYmUgaG9u
ZXN0IHNvIEkgbWlnaHQgbWlze2ludGVycHJldCxyZW1lbWJlcn0uDQoNCkkndmUgYWRkcmVzc2Vk
IGhpcyBtdWx0aXBsZSBjb21tZW50cyBpbiB0aGlzIHNlcmllcywgYnV0IGhhZCB0byBkaXNhZ3Jl
ZQ0Kd2l0aCBoaXMgZm9sbG93aW5nIHN1Z2dlc3Rpb25zOg0KDQoxLiBBcHBseSBoaXMgcmV2ZXJ0
IHBhdGNoIGZpcnN0IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzQvMjYvNjM2DQoNCkRpc2Fn
cmVlZCBiZWNhdXNlIHRoaXMgcGF0Y2ggYnJlYWtzIHRoZSBjdXJyZW50IGlvcmVtYXAoKSBjYWxs
ZXJzIHVzaW5nDQoyTUIgbWFwcGluZ3MgYnkgZmFpbGluZyBwbWRfZnJlZV9wdGVfcGFnZSgpLg0K
DQoyLiBBZGQgYSBzcGVjaWFsIHBhZ2UgbGlzdCwgaW5zdGVhZCBvZiBtZW1vcnkgYWxsb2MsIGlu
IHBhdGNoIDMvMw0KDQpRdW90aW5nIGhpcyBjb25jZXJucyBhYm91dCB0aGUgbWVtb3J5IGFsbG9j
YXRpb246DQo9PT0NCk9uIFR1ZSwgTWF5IDI5LCAyMDE4IGF0IDA0OjEwOjI0UE0gKzAwMDAsIEth
bmksIFRvc2hpIHdyb3RlOg0KPiBDYW4geW91IGV4cGxhaW4gd2h5IHlvdSB0aGluayBhbGxvY2F0
aW5nIGEgcGFnZSBoZXJlIGlzIGEgbWFqb3INCnByb2JsZW0/DQoNCkJlY2F1c2UgYSBsYXJnZXIg
YWxsb2NhdGlvbiBpcyBtb3JlIGxpa2VseSB0byBmYWlsLiBBbmQgaWYgeW91IGZhaWwgdGhlDQph
bGxvY2F0aW9uLCB5b3UgYWxzbyBmYWlsIHRvIGZyZWUgbW9yZSBwYWdlcywgd2hpY2ggX2lzXyBh
IHByb2JsZW0uIFNvDQpiZXR0ZXIgYXZvaWQgYW55IGFsbG9jYXRpb25zIGluIGNvZGUgcGF0aHMg
dGhhdCBhcmUgYWJvdXQgZnJlZWluZw0KbWVtb3J5Lg0KPT09DQoNCldoaWNoIEkgaGFkIHJlcGxp
ZWQgYXM6DQo9PT09DQpJdCBvbmx5IGFsbG9jYXRlcyBhIHNpbmdsZSBwYWdlLiAgSWYgaXQgZmFp
bHMgdG8gYWxsb2NhdGUgYSBzaW5nbGUgcGFnZSwNCnRoaXMgcHVkIG1hcHBpbmcgcmVxdWVzdCBz
aW1wbHkgZmFsbHMgdG8gcG1kIG1hcHBpbmdzLCB3aGljaCBpcyBvbmx5IGFzDQpiYWQgYXMgeW91
ciBzdWdnZXN0ZWQgcGxhaW4gcmV2ZXJ0IGFsd2F5cyBkb2VzIGZvciBib3RoIHB1ZCBhbmQgcG1k
DQptYXBwaW5ncy4gIEFsc28sIHRoaXMgZnVuYyBpcyBjYWxsZWQgZnJvbSBpb3JlbWFwKCkgd2hl
biBhIGRyaXZlcg0KaW5pdGlhbGl6ZXMgaXRzIG1hcHBpbmcuICBJZiB0aGUgc3lzdGVtIGRvZXMg
bm90IGhhdmUgYSBzaW5nbGUgcGFnZSB0bw0KYWxsb2NhdGUsIHRoZSBkcml2ZXIgaGFzIGEgbXVj
aCBiaWdnZXIgaXNzdWUgdG8gZGVhbCB3aXRoIHRoYW4gaXRzDQpyZXF1ZXN0IGZhbGxpbmcgYmFj
ayB0byBwbWQgbWFwcGluZ3MuICBQbGVhc2UgYWxzbyBub3RlIHRoYXQgdGhpcyBmdW5jDQppcyBu
b3QgY2FsbGVkIGZyb20gZnJlZS1tZW1vcnkgcGF0aC4NCj09PT0NCg0KSSBoYXZlIGZ1cnRoZXIg
c3VtbWFyaXplZCBteSByZWFzb25zIHRvIGtlZXAgdGhlIG1lbW9yeSBhbGxvY2F0aW9uIGluIG15
DQpyZXBseSB0byBNaWNoYWwuICBBbm90aGVyIHJlYXNvbiwgd2hpY2ggSSBmb3Jnb3QgdG8gbWVu
dGlvbiwgaXMgdGhhdA0KaW9yZW1hcCgpIGRvZXMgbm90IGhhdmUgYW4gaW5pdCBpbnRlcmZhY2Ug
dG8gaW5pdGlhbGl6ZSBhIHNwZWNpYWwgcGFnZQ0KbGlzdCBpbiBhcmNoaXRlY3R1cmUtc3BlY2lm
aWMgd2F5IChhbmQgdGhlcmUgaXMgYSBnb29kIHJlYXNvbiBub3QgdG8NCmhhdmUgaXQpLg0KDQo+
ID4gRmluZSB3aXRoIHRoYXQsIGJ1dCB3aG8gd2lsbCB0YWtlIGNhcmUgb2YgcmV3b3JraW5nIGl0
IHByb3Blcj8gSSdtDQo+ID4gY29uY2VybmVkIHRoYXQgdGhpcyB3aWxsIGp1c3QgZ28gc3RhbGUg
dGhlIG1vbWVudCB0aGUgZml4ZXMgaGl0IHRoZSB0cmVlLg0KPiANCj4gWWVhaCwgdGhpcyBpcyB3
aHkgSSB1c3VhbGx5IHRyeSB0byBwdXNoIGJhY2sgaGFyZCBiZWNhdXNlICJ3aWxsIGJlIGZpeGVk
DQo+IGxhdGVyIiBpcyBzaW1pbGFyIHRvIHNheSAiZG9jdW1lbnRhdGlvbiB3aWxsIGNvbWUgbGF0
ZXIiIGV0Yy4uLg0KPiANCj4gQSBiaWcgZmF0IFRPRE8gd291bGQgYmUgYXBwcm9wcmlhdGUgc28g
aXQgd29uJ3QgZ2V0IGZvcmdvdHRlbiBhdCBsZWFzdC4NCg0KSSdkIGJlIGhhcHB5IHRvIHJld29y
ayBpZiB3ZSBmaW5kIGEgYnVnIGluIHRoZSBjb2RlLiAgQnV0IEkgZG8gbm90IHRoaW5rDQp3ZSBu
ZWVkIHRvIHJld29yayBmb3IgdGhlIHNha2Ugb2YgcG9zc2libGUgZnV0dXJlIGNhbGxlcnMgdGhh
dCBub2JvZHkNCmtub3dzIGZvciBzdXJlLiAgU28sIEkgd2lsbCBhZGQgdGhlIE5PVEUgYmxvdyB0
byBjbGFyaWZ5IHRoZSBwcmUtDQpyZXF1aXNpdGUuDQogDQpOT1RFOg0KIC0gQ2FsbGVycyBtdXN0
IGFsbG93IGEgc2luZ2xlIHBhZ2UgYWxsb2NhdGlvbi4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
