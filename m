Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12D92075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="By/otUt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12D92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeIGAfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:35:45 -0400
Received: from mail-eopbgr710066.outbound.protection.outlook.com ([40.107.71.66]:65263
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727955AbeIGAfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x4fm3Dx1msRxBCVKWHMvTpcqe3O/9Y1FR6SUbpoe10=;
 b=By/otUt89bc2llWPTV1BoMt6z2yV9IofoNwZjANW8WLz5Ip+BROekilohvicicMea9E+qGWFJfPTr0FrprXrftcDTAEGToq4hKI+ZJOSULxkNe02AD6QPlQ5IZBKfreQY8JYgXRUPcv4fIpsPN3M7xs2mStO9+QGiAhCJWW9BOI=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4723.namprd05.prod.outlook.com (20.177.145.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Thu, 6 Sep 2018 19:58:40 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 19:58:40 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Topic: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Thread-Index: AQHUQuMbEqvSNOHryEuRcEhAlbQ9L6TjrQmAgAAAm4CAAANAgIAAAVYA
Date:   Thu, 6 Sep 2018 19:58:40 +0000
Message-ID: <D8CE0D88-9507-421C-9C97-ACAB05388F8D@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
 <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
 <20180906195351.GB9358@worktop.programming.kicks-ass.net>
In-Reply-To: <20180906195351.GB9358@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4723;20:hALobHeD8bX9doifqkppcRwtLdFWaiGWpcLUw0BJwULHlwLdFZtbbaR8EwOySstIxYvrSJ+jgmBidgo6wRNVrQH4dVtCAQvgx4QgRpAdW5Y+haLz3XlNVfZcpIR2dBgdG2qFv3Zfy5No99e5QqXOQNNeZ+UlaNbUGbgGQL0RWPU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0217a021-ee2d-46ab-5bdb-08d614332460
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4723;
x-ms-traffictypediagnostic: BL0PR05MB4723:
bcl:    0
x-microsoft-antispam-prvs: <BL0PR05MB4723CB39DC838D9E8470FA72D0010@BL0PR05MB4723.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:BL0PR05MB4723;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB4723;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(93886005)(256004)(6486002)(7736002)(33656002)(305945005)(6246003)(8676002)(36756003)(53936002)(6512007)(7416002)(6116002)(3846002)(2906002)(6916009)(14444005)(5660300001)(2900100001)(478600001)(229853002)(14454004)(186003)(5250100002)(6506007)(76176011)(26005)(102836004)(97736004)(83716003)(106356001)(68736007)(105586002)(6346003)(476003)(2616005)(486006)(446003)(11346002)(6436002)(99286004)(316002)(81166006)(25786009)(4326008)(81156014)(54906003)(66066001)(8936002)(86362001)(82746002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4723;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: jZYEZbFCfnhY8Kq4hDDpBo+tWPLOpg6sjAVcS260tuQZcYRUGkokWErKznSjzIhxxmkQA34BYgtNlKNFhRoKLlgjxvVWHMM2aj2oE3oisSiKhvpzui6z6eRpeOF1AinUv/vVjZk3Vc6NVlIswHsW6MHkseH51xWY9f68K2zi/1YD/2G4yZwhjBoCMXyyGX9y0LqcS87Ntf8PRAvYTU69BIVwdDsQg5s/bU/eC5CiupfoLUb2ZmEWKZboo1DHkIarbTRh5Jz5pB96Wtb3qr37wnd3X3jRKl7X/qtrtLJiLAqkxMj9IH8uFDH8InTQJhnSk9CmISXWm3rIWtxOOUyzUXxOYNndE5ayrPJuhnZGT88=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC9E11FA9D12524082AA5BC914F4E697@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0217a021-ee2d-46ab-5bdb-08d614332460
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 19:58:40.2561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTI6NTMgUE0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQoNCj4gT24gVGh1LCBTZXAgMDYsIDIwMTggYXQgMDc6NDI6MTRQTSArMDAwMCwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+IGF0IDEyOjQwIFBNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+IHdyb3RlOg0KPj4gDQo+Pj4gT24gU3VuLCBTZXAgMDIsIDIwMTggYXQgMTA6MzI6MTlB
TSAtMDcwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+Pj4gdGV4dF9tdXRleCBpcyBleHBlY3RlZCB0
byBiZSBoZWxkIGJlZm9yZSB0ZXh0X3Bva2UoKSBpcyBjYWxsZWQsIGJ1dCB3ZQ0KPj4+PiBjYW5u
b3QgYWRkIGEgbG9ja2RlcCBhc3NlcnRpb24gc2luY2Uga2dkYiBkb2VzIG5vdCB0YWtlIGl0LCBh
bmQgaW5zdGVhZA0KPj4+PiAqc3VwcG9zZWRseSogZW5zdXJlcyB0aGUgbG9jayBpcyBub3QgdGFr
ZW4gYW5kIHdpbGwgbm90IGJlIGFjcXVpcmVkIGJ5DQo+Pj4+IGFueSBvdGhlciBjb3JlIHdoaWxl
IHRleHRfcG9rZSgpIGlzIHJ1bm5pbmcuDQo+Pj4+IA0KPj4+PiBUaGUgcmVhc29uIGZvciB0aGUg
InN1cHBvc2VkbHkiIGNvbW1lbnQgaXMgdGhhdCBpdCBpcyBub3QgZW50aXJlbHkgY2xlYXINCj4+
Pj4gdGhhdCB0aGlzIHdvdWxkIGJlIHRoZSBjYXNlIGlmIGdkYl9kb19yb3VuZHVwIGlzIHplcm8u
DQo+Pj4gDQo+Pj4gQXJnaCwgdGhhdCdzIHByZXR0eSBzaGl0IGNvZGUuLi4NCj4+PiANCj4+PiBO
b3Qgb25seSBpcyB0aGF0IHRleHRfbXV0ZXggYWJ1c2UgdWdseSwgc28gdG9vIGlzIHRoZSBmaXht
YXAgdXNhZ2UgZnJvbQ0KPj4+IElSUSBjb250ZXh0LiBJIHN1cHBvc2UgdGhpcyByZWFsbHkgZG9l
cyByZXF1aXJlIHlvdXIgYWx0ZXJuYXRpdmUgbW0NCj4+PiBwYXRjaGVzIGZvciB0ZXh0X3Bva2Uo
KS4NCj4+IA0KPj4gUmlnaHQsIEkgZm9yZ290IGFib3V0IHRoYXTigKYNCj4gDQo+IFdpdGggdGhh
dCBDUjMgdHJpY2tlcnksIHdlIGNhbiByaWQgb3Vyc2VsdmVzIG9mIHRoZSB0ZXh0X211dGV4DQo+
IHJlcXVpcmVtZW50LCBzaW5jZSBjb25jdXJyZW50IHRleHRfcG9rZSBpcyAnc2FmZScuIFRoYXQg
d291bGQgY2xlYW4gdXANCj4gdGhlIGtnZGIgY29kZSBxdWl0ZSBhIGJpdC4NCg0KSSBkb27igJl0
IGtub3cuIEnigJltIHNvbWV3aGF0IHdvcnJpZWQgd2l0aCBtdWx0aXBsZSBtZWNoYW5pc21zIHBv
dGVudGlhbGx5DQpjaGFuZ2luZyB0aGUgc2FtZSBjb2RlIGF0IHRoZSBzYW1lIHRpbWUgLSBhbmQg
bWF5YmUgZW5kaW5nIHVwIHdpdGggc29tZQ0KbWVzcy4NCg0K
