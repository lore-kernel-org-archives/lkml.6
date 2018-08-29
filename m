Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D433DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794DC20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="T75nmVTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794DC20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeH3DIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:08:16 -0400
Received: from mail-sn1nam02on0120.outbound.protection.outlook.com ([104.47.36.120]:10816
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727406AbeH3DIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCjibWdphzKAnLEwhDpAOeERrTzigVFjT/DZvPGQfrI=;
 b=T75nmVTIiMdlmCfRzRAmtGwL47l1VOHAvqK0h3dErqUNMcSog2AGHVGc9RYh5zBaqOZ1e964hPrTFxgwBSvTlXNRmyAbNRMZmdVbc1djdKZiOOut4Cnr85MmVsVuQlmZjcYOpqfVV9Zy9ZmUpM8ft2pIHRgpMpVnPnuwcymfJtg=
Received: from CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Wed, 29 Aug 2018 23:09:01 +0000
Received: from CY4PR21MB0503.namprd21.prod.outlook.com
 ([fe80::113a:f97e:d360:4aee]) by CY4PR21MB0503.namprd21.prod.outlook.com
 ([fe80::113a:f97e:d360:4aee%11]) with mapi id 15.20.1122.000; Wed, 29 Aug
 2018 23:09:01 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Oscar Salvador <osalvador@techadventures.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "yasu.isimatu@gmail.com" <yasu.isimatu@gmail.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC v2 2/2] mm/memory_hotplug: Shrink spanned pages when
 offlining memory
Thread-Topic: [RFC v2 2/2] mm/memory_hotplug: Shrink spanned pages when
 offlining memory
Thread-Index: AQHUNkDKNNRd0tKlCESaSUuOqlYb4KTXbggA
Date:   Wed, 29 Aug 2018 23:09:01 +0000
Message-ID: <348c662b-455a-1ea4-1db5-3bddcbdb4f14@microsoft.com>
References: <20180817154127.28602-1-osalvador@techadventures.net>
 <20180817154127.28602-3-osalvador@techadventures.net>
In-Reply-To: <20180817154127.28602-3-osalvador@techadventures.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:Q5SmwQN9kB95BOtAWQJqk9OF/DYGLfN6HpI1BP+Q65pMDlrF4ci761hev6sgBnkcM24Dp7w2DfpGktGdwJfKdvfi5a6letGqvUj2jJqVB2LQDNtSNou1QoBdpFUUWWcLPzU82G5nro5YmFg47n036qvZcUeoYkpdTowoqoWCenD5PSKuy1l4tMeS7I+Dg/vV+a5nghsi7HheKcJyPT6rkP6yeyDXTOMybrw5HmeurvzD1vUw+STMpq5A5ORiOpTUvd6IQFy3bAIyvIgzSA1BFEQLKDlgw+pp6XGHNHNmwGLAoVU/z/faW9FImNpdIZASEe/gN6r9JHCvNjPNItQAAZ1uoX3IBEBkX4x4Gs6UN+DN8h6sOixlNDBssNLz3xPM+p/0+QQfLs8xjj7iv7c54xxUq1RlFO+4z8XnvdPy7UV/GbPxTFMHARA8tmeCl+nZypn85yIy3hFJKYnANFGTog==;5:YodvdZtHSIHMGAk8v/hoabf7T4ZxaJx0O05G+xpqWx6WsQLJIOCt1gZvV6Eh6q47W2vYYX02ov+I3hHabNiN+DmLUALMlR0uhzjbKZakJIfowiMIS0qr1Y/PwpdrDKG0g3VE9zTEuaD5LlYQvmGlD8Nwyw0vvCHS5vHXIklcoGU=;7:tBY1Bj94eg2RezYgnpUlSQXoWtwVdXzrcd+NNDs4lfeSmofmvlxb5ip3AY2ga6WrZOPMc/JwLoXfyTvlonVIkQUWthThBZ61tj4eHbjNfGjCNxdcQ+4FRL4UVaQC9LpgkRAT/NlAXKUMr7kt7EzoHJSmhOdFCl8nyGH2oMhkvsvbK4m8z1l9NDhlcNpga4TxGM2QGtkdMgU87FVfGMh1znhg78AQF0YDPf1WHukR/D3UoLs3ePG6BL1Fn6v4Nql3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a84bd5aa-32c5-4845-7ef2-08d60e0468b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07919C6D873C1BF3BF4854039D090@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(51444003)(316002)(53936002)(66066001)(3846002)(22452003)(110136005)(54906003)(6116002)(99286004)(7736002)(305945005)(8936002)(97736004)(6246003)(2906002)(446003)(26005)(81166006)(102836004)(81156014)(6306002)(6512007)(2900100001)(6506007)(8676002)(53546011)(7416002)(36756003)(5660300001)(186003)(486006)(25786009)(11346002)(2616005)(476003)(105586002)(229853002)(106356001)(14454004)(478600001)(4326008)(39060400002)(6486002)(86362001)(31686004)(68736007)(256004)(966005)(31696002)(86612001)(14444005)(76176011)(5250100002)(72206003)(6436002)(10090500001)(2501003)(10290500003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0503.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JvjXvHv8skClIlo2AzhiXGw7AGCTwup4KrCD7Bn032TM7pwMFkDcoEgr35meEvuRlbzy2ogsFwuHpUXZ73+wxdR/dEYO4sESbzcK8e3jSWBb/QeiyE3JMBZ7/T/xxELCUw106UxU1bSb+X4qR2fbN+r+crticmNLKIKY4u1PZBfg4WTrackqWrbJ6sUKvAb589eue6SjrJLHmG/gk6bWDYXZOVrvH8C7y8atAxaOCQG/ZRSKix4PenDyT0cmAIbCI0CBYtJNjQf/VJD9/cbozj+mYPZ5GAT/lAatLnE2l3yJgEuolgekK2Yw3kxGVDtWkBrx1BXndp3N1YHhMFvYpP4AGDgKpVIybfd8mch36Yw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FADFF99E34495149A7C952B3B36C26B2@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84bd5aa-32c5-4845-7ef2-08d60e0468b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 23:09:01.7594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA4LzE3LzE4IDExOjQxIEFNLCBPc2NhciBTYWx2YWRvciB3cm90ZToNCj4gRnJvbTogT3Nj
YXIgU2FsdmFkb3IgPG9zYWx2YWRvckBzdXNlLmRlPg0KPiANCj4gQ3VycmVudGx5LCB3ZSBkZWNy
ZW1lbnQgem9uZS9ub2RlIHNwYW5uZWRfcGFnZXMgd2hlbiB3ZQ0KPiByZW1vdmUgbWVtb3J5IGFu
ZCBub3Qgd2hlbiB3ZSBvZmZsaW5lIGl0Lg0KPiANCj4gVGhpcywgYmVzaWRlcyBvZiBub3QgYmVp
bmcgY29uc2lzdGVudCB3aXRoIHRoZSBjdXJyZW50IGNvZGUsDQo+IGltcGxpZXMgdGhhdCB3ZSBj
YW4gYWNjZXNzIHN0ZWFsIHBhZ2VzIGlmIHdlIG5ldmVyIGdldCB0byBvbmxpbmUNCj4gdGhhdCBt
ZW1vcnkuDQo+IA0KPiBJbiBvcmRlciB0byBwcmV2ZW50IHRoYXQsIHdlIGhhdmUgdG8gbW92ZSBh
bGwgem9uZS9wYWdlcyBzdHVmZiB0bw0KPiB0aGUgb2ZmbGluaW5nIG1lbW9yeSBzdGFnZS4NCj4g
UmVtb3ZpbmcgbWVtb3J5IHBhdGggc2hvdWxkIG9ubHkgY2FyZSBhYm91dCBtZW1vcnkgc2VjdGlv
bnMgYW5kIG1lbW9yeQ0KPiBibG9ja3MuDQo+IA0KPiBBbm90aGVyIHRoaW5nIHRvIG5vdGljZSBo
ZXJlIGlzIHRoYXQgdGhpcyBpcyBub3Qgc28gZWFzeSB0byBiZSBkb25lDQo+IGFzIEhNTS9kZXZt
IGhhdmUgYSBwYXJ0aWN1bGFyIGhhbmRsaW5nIG9mIG1lbW9yeS1ob3RwbHVnLg0KPiBUaGV5IGRv
IG5vdCBnbyB0aHJvdWdoIHRoZSBjb21tb24gcGF0aCwgYW5kIHNvLCB0aGV5IGRvIG5vdA0KPiBj
YWxsIGVpdGhlciBvZmZsaW5lX3BhZ2VzKCkgbm9yIG9ubGluZV9wYWdlcygpLg0KPiANCj4gQWxs
IHRoZXkgY2FyZSBhYm91dCBpcyB0byBhZGQgdGhlIHNlY3Rpb25zLCBtb3ZlIHRoZSBwYWdlcyB0
bw0KPiBaT05FX0RFVklDRSwgYW5kIGluIHNvbWUgY2FzZXMsIHRvIGNyZWF0ZSB0aGUgbGluZWFy
IG1hcHBpbmcuDQo+IA0KPiBJbiBvcmRlciB0byBkbyB0aGlzIG1vcmUgc21vb3RoLCB0d28gbmV3
IGZ1bmN0aW9ucyBhcmUgY3JlYXRlZA0KPiB0byBkZWFsIHdpdGggdGhlc2UgcGFydGljdWxhciBj
YXNlczoNCj4gDQo+IGRlbF9kZXZpY2VfbWVtb3J5DQo+IGFkZF9kZXZpY2VfbWVtb3J5DQo+IA0K
PiBhZGRfZGV2aWNlX21lbW9yeSBpcyBpbiBjaGFyZ2Ugb2YNCj4gDQo+IGEpIGNhbGxpbmcgZWl0
aGVyIGFyY2hfYWRkX21lbW9yeSgpIG9yIGFkZF9wYWdlcygpLCBkZXBlbmRpbmcgb24gd2hldGhl
cg0KPiAgICB3ZSB3YW50IGEgbGluZWFyIG1hcHBpbmcNCj4gYikgb25saW5lIHRoZSBtZW1vcnkg
c2VjdGlvbnMgdGhhdCBjb3JyZXNwb25kIHRvIHRoZSBwZm4gcmFuZ2UNCj4gYykgY2FsbGluZyBt
b3ZlX3Bmbl9yYW5nZV90b196b25lKCkgYmVpbmcgem9uZSBaT05FX0RFVklDRSB0bw0KPiAgICBl
eHBhbmQgem9uZS9wZ2RhdCBzcGFubmVkIHBhZ2VzIGFuZCBpbml0aWFsaXplIGl0cyBwYWdlcw0K
PiANCj4gZGVsX2RldmljZV9tZW1vcnksIG9uIHRoZSBvdGhlciBoYW5kLCBpcyBpbiBjaGFyZ2Ug
b2YNCj4gDQo+IGEpIG9mZmxpbmUgdGhlIG1lbW9yeSBzZWN0aW9ucyB0aGF0IGNvcnJlc3BvbmQg
dG8gdGhlIHBmbiByYW5nZQ0KPiBiKSBjYWxsaW5nIHNocmlua19wYWdlcygpLCB3aGljaCBzaHJp
bmtzIG5vZGUvem9uZSBzcGFubmVkIHBhZ2VzLg0KPiBjKSBjYWxsaW5nIGVpdGhlciBhcmNoX3Jl
bW92ZV9tZW1vcnkoKSBvciBfX3JlbW92ZV9wYWdlcygpLCBkZXBlbmRpbmcgb24NCj4gICAgd2hl
dGhlciB3ZSBuZWVkIHRvIHRlYXIgZG93biB0aGUgbGluZWFyIG1hcHBpbmcgb3Igbm90DQo+IA0K
PiBUaGVzZSB0d28gZnVuY3Rpb25zIGFyZSBjYWxsZWQgZnJvbToNCj4gDQo+IGFkZF9kZXZpY2Vf
bWVtb3J5Og0KPiAJLSBkZXZtX21lbXJlbWFwX3BhZ2VzKCkNCj4gCS0gaG1tX2Rldm1lbV9wYWdl
c19jcmVhdGUoKQ0KPiANCj4gZGVsX2RldmljZV9tZW1vcnk6DQo+IAktIGRldm1fbWVtcmVtYXBf
cGFnZXNfcmVsZWFzZSgpDQo+IAktIGhtbV9kZXZtZW1fcmVsZWFzZSgpDQo+IA0KPiBJIHRoaW5r
IHRoYXQgdGhpcyB3aWxsIGdldCBlYXNpZXIgYXMgc29vbiBhcyBbMV0gZ2V0cyBtZXJnZWQuDQo+
IA0KPiBGaW5hbGx5LCBzaHJpbmtfcGFnZXMoKSBpcyBtb3ZlZCB0byBvZmZsaW5lX3BhZ2VzKCks
IHNvIG5vdywNCj4gYWxsIHBhZ2VzL3pvbmUgaGFuZGxpbmcgaXMgYmVpbmcgdGFrZW4gY2FyZSBp
biBvbmxpbmUvb2ZmbGluZV9wYWdlcyBzdGFnZS4NCj4gDQo+IFsxXSBodHRwczovL2xrbWwub3Jn
L2xrbWwvMjAxOC82LzE5LzExMA0KPiANCj4gU2lnbmVkLW9mZi1ieTogT3NjYXIgU2FsdmFkb3Ig
PG9zYWx2YWRvckBzdXNlLmRlPg0KPiAtLS0NCj4gIGFyY2gvaWE2NC9tbS9pbml0LmMgICAgICAg
ICAgICB8ICAgNCArLQ0KPiAgYXJjaC9wb3dlcnBjL21tL21lbS5jICAgICAgICAgIHwgIDEwICst
LQ0KPiAgYXJjaC9zaC9tbS9pbml0LmMgICAgICAgICAgICAgIHwgICA0ICstDQo+ICBhcmNoL3g4
Ni9tbS9pbml0XzMyLmMgICAgICAgICAgfCAgIDQgKy0NCj4gIGFyY2gveDg2L21tL2luaXRfNjQu
YyAgICAgICAgICB8ICAgOCArLS0NCj4gIGluY2x1ZGUvbGludXgvbWVtb3J5X2hvdHBsdWcuaCB8
ICAgOSArKy0NCj4gIGtlcm5lbC9tZW1yZW1hcC5jICAgICAgICAgICAgICB8ICAxNCArKy0tDQo+
ICBrZXJuZWwvcmVzb3VyY2UuYyAgICAgICAgICAgICAgfCAgMTYgKysrKysNCj4gIG1tL2htbS5j
ICAgICAgICAgICAgICAgICAgICAgICB8ICAzMiArKysrLS0tLS0NCj4gIG1tL21lbW9yeV9ob3Rw
bHVnLmMgICAgICAgICAgICB8IDE0MyArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLQ0KPiAgbW0vc3BhcnNlLmMgICAgICAgICAgICAgICAgICAgIHwgICA0ICstDQo+ICAx
MSBmaWxlcyBjaGFuZ2VkLCAxNDUgaW5zZXJ0aW9ucygrKSwgMTAzIGRlbGV0aW9ucygtKQ0KDQpI
aSBPc2NhciwNCg0KSSBoYXZlIGJlZW4gc3R1ZHlpbmcgdGhpcyBwYXRjaCwgYW5kIGRvIG5vdCBz
ZWUgYW55dGhpbmcgYmFkIGFib3V0IGl0DQpleGNlcHQgdGhhdCBpdCBiZWdzIHRvIGJlIHNwbGl0
IGludG8gc21hbGxlciBwYXRjaGVzLiBJIHRoaW5rIHlvdSBjYW4NCnNlbmQgdGhpcyB3b3JrIGFz
IGEgc2VyaWVzIHdpdGhvdXQgUkZDIGlmIHRoaXMgcGF0Y2ggaXMgc3BsaXQgaW50byAzIG9yDQpz
byBwYXRjaGVzLiBJIHdpbGwgcmV2aWV3IHRoYXQgc2VyaWVzLg0KDQpUaGFuayB5b3UsDQpQYXZl
bA==
