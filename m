Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A618C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB5C20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VUS1Pomf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB5C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeLACCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:02:04 -0500
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:19652
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbeLACCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VftuTY9YvYqrZ8IbBFby0gNela1aXJI0ak6GsIGqCo=;
 b=VUS1Pomftxz9nyxCaFBxi70OWp3th6rrh2u82GUnxK4/3UUmquDUNLHPUdBfFNB7HLiLzl7lUZLnN9tP4N/owG6B8RKe5npx+Zj0Mlq+XaEjesNIU6Hbo4K0+aRbK5WH+imsq8B+w3bN/kquqMPXZflKt2FLfiaRPcnPBa2UVDg=
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com (10.174.98.12) by
 MWHPR1201MB0224.namprd12.prod.outlook.com (10.174.99.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 14:52:27 +0000
Received: from MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869]) by MWHPR1201MB0061.namprd12.prod.outlook.com
 ([fe80::4481:91d7:9564:e869%9]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 14:52:27 +0000
From:   "StDenis, Tom" <Tom.StDenis@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Topic: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Thread-Index: AQHUiLXipdRkoql6EkWifNhS5aJus6VoZy0A
Date:   Fri, 30 Nov 2018 14:52:26 +0000
Message-ID: <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
References: <20181130134455.490139778@infradead.org>
In-Reply-To: <20181130134455.490139778@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::15) To MWHPR1201MB0061.namprd12.prod.outlook.com
 (2603:10b6:301:54::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0224;20:tw02LTg/OrFCLd6x4uV8vN+Tustzn1Tu1OYrzK6P5KZFIUC5o819VicELqS8XOXPGWd3hMMDgZsMblwYI49QirxoswXS4tdhgJTxNHtmYra/8SiqdCUtvF7JeIqmi5QAo5I5v5VVhwlKyS/KEJwGEZouMQTd7WFIYn7rIlp7nQBlxHVOa3T2hShyPPvHtcMyJHKQfxkzLlOtOuYx96EU4OwUlEiLW7u1rzuFjEKhgItYYJORijGbg/boVQ4edgjL
x-ms-office365-filtering-correlation-id: 4ec0aa6a-acbe-4a95-8013-08d656d371a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0224;
x-ms-traffictypediagnostic: MWHPR1201MB0224:
x-microsoft-antispam-prvs: <MWHPR1201MB0224EADF16380C22EA4A1702F7D30@MWHPR1201MB0224.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231453)(999002)(944501466)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR1201MB0224;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0224;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(366004)(346002)(376002)(136003)(199004)(189003)(486006)(2906002)(52116002)(2501003)(7736002)(2201001)(305945005)(86362001)(316002)(14454004)(6506007)(476003)(99286004)(81166006)(71190400001)(386003)(2616005)(71200400001)(81156014)(6512007)(31686004)(256004)(26005)(66066001)(229853002)(72206003)(68736007)(8936002)(478600001)(186003)(31696002)(106356001)(6486002)(105586002)(6116002)(36756003)(5660300001)(6436002)(25786009)(76176011)(6246003)(53936002)(97736004)(53546011)(102836004)(4326008)(8676002)(54906003)(110136005)(4001150100001)(3846002)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0224;H:MWHPR1201MB0061.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c27lK99HofesEfyh5CrVHju9xhEYsh+TAuM2ok7AgJru/TdefwHSc5KqJonMp0ebxxTLy0AhEeUVmBLu2zj/wZXh7VbD96ieT6qIPi5ZEyPBn81MKo3Qkd9c9ACLzHe0vMyxfTGIJ7hjsYRaeSO8K1klHr6MB8x/D3De7Bze8t4msHcJYVJQTasWE90vd9FbZvBJixFxpFT9C+sD6nxywmCpy8g7ISZNcEsnBFOlcpiNpr+0/qj7KssPvgk5RHEbVCzS1hRG/se3EBgTottiOpndnmN1DXY80AVKf4BQctVDTQZdWxOBtO/BCN8VJwBcwzglWv5qeDuLw7+qgOa6NFGo/z70rYSWAFQdSRisPAQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BDD37FFAF29EC46994C21D528AE70BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec0aa6a-acbe-4a95-8013-08d656d371a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 14:52:26.9961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNClVuZm9ydHVuYXRlbHkgSSBjYW4ndCBhcHBseSB0aGlzIG9uIHRvcCBvZiBv
dXIgZHJtLW5leHQgdGhlIGZpcnN0IHBhdGNoIA0KZmFpbHMuDQoNCkFsZXg6IGNvdWxkIHdlIHJl
YmFzZSBhZ2FpbiBhdCBzb21lIHBvaW50Pw0KDQpUb20NCg0KT24gMjAxOC0xMS0zMCA4OjQ0IGEu
bS4sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBIaSwNCj4gDQo+IFllc3RlcmRheSBUb20gcmVw
b3J0ZWQgYSBDUEEgYnVnIHRyaWdnZXJlZCBieSB0aGUgQU1ER1BVIHRlYW0uDQo+IA0KPiBJdCB0
dXJucyBvdXQgdGhhdCB3aXRoIGNvbW1pdDoNCj4gDQo+ICAgIGE3Mjk1ZmQ1M2MzOSAoIng4Ni9t
bS9jcGE6IFVzZSBmbHVzaF90bGJfa2VybmVsX3JhbmdlKCkiKQ0KPiANCj4gSSBtaXNyZWFkIHRo
ZSBjcGEgYXJyYXkgY29kZSBhbmQgbWVzc2VkIHVwIHRoZSBUTEIgaW52YWxpZGF0aW9ucyBmb3Ig
aXQuIFRoZXNlDQo+IHBhdGNoZXMgKGhvcGVmdWxseSkgZml4IHRoZSBpc3N1ZSB3aGlsZSBhbHNv
IHNocmlua2luZyB0aGUgQ1BBIGNvZGUgYWdhaW4uDQo+IA0KPiBUb20sIHdvdWxkIHlvdSBiZSBz
byBraW5kIGFzIHRvIHRlc3QgYWdhaW4/IFRoZXNlIHBhdGNoZXMgYXJlIHNpZ25pZmljYW50bHkN
Cj4gZGlmZmVyZW50IGZyb20gd2hhdCBJIHNlbmQgeW91IHllc3RlcmRheS4NCj4gDQo+IC0tLQ0K
PiBhcmNoL3g4Ni9tbS9tbV9pbnRlcm5hbC5oIHwgICAyICsNCj4gYXJjaC94ODYvbW0vcGFnZWF0
dHIuYyAgICB8IDE2NyArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+IGFyY2gveDg2L21tL3RsYi5jICAgICAgICAgfCAgIDQgKy0NCj4gMyBmaWxlcyBjaGFu
Z2VkLCA3OSBpbnNlcnRpb25zKCspLCA5NCBkZWxldGlvbnMoLSkNCj4gDQoNCg==
