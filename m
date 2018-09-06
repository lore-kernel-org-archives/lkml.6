Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA18C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3D32075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="WpmXxdQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3D32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeIFXPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:15:21 -0400
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:20875
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728228AbeIFXPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Go5DFPhFV+Gbs1JxLUcZJwaXUL8P4V0VOzXul3g3Fw=;
 b=WpmXxdQVKC/asNMDAg5GBk7U+sAXOjoq72F8GsgD8FbJ42Xa+LygisigOYSTa6U+OHL7Ek9kjMi7Ya7sykbhfSVlRwidKrn26KQ5w2IGeP7Xar5p6uhhqgTW8nuQ9DdXjoSqlbc4YR8d2p3kluJdL4ELC9Xa9/RL55mZ5J3wm+Y=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4609.namprd05.prod.outlook.com (20.177.144.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.9; Thu, 6 Sep 2018 18:38:31 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 18:38:31 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Thread-Topic: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Thread-Index: AQHUQuMbzkVQDn+XA0OpXaFEC8rBZ6TiDnqAgAABqICAAAJhAIAA2pAAgAAij4CAAHESgIAABJ4AgAALaACAAAL6gIAABk6AgAAB0gA=
Date:   Thu, 6 Sep 2018 18:38:30 +0000
Message-ID: <9F76711C-393C-4F8D-B460-26D400458690@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
 <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
 <20180906171754.GJ24106@hirez.programming.kicks-ass.net>
 <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
 <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
 <20180906183157.GK24106@hirez.programming.kicks-ass.net>
In-Reply-To: <20180906183157.GK24106@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4609;20:VgtQcHrdqfWCLpZLF2rPVNzk/FNv6gBkufMvNkR3zUW7T+l6P6kjUhyCwrOXAhMEV40ZSwQJGX/P/uWCfRxDBZh7mQXCcR0oOjnP+Is5cMbKakUgIEbhMExTe7cEoZDBHq4pcsBYfxgIfZkFBYEiUaL9lbNG6ShnKFiUm5jSTmY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b3bf5c30-4bf3-42c8-0437-08d61427f1b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4609;
x-ms-traffictypediagnostic: BL0PR05MB4609:
bcl:    0
x-microsoft-antispam-prvs: <BL0PR05MB4609D9519C7588E3F58253C2D0010@BL0PR05MB4609.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BL0PR05MB4609;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB4609;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(7736002)(229853002)(7416002)(6486002)(68736007)(76176011)(33656002)(6512007)(99286004)(6436002)(8676002)(2616005)(476003)(2906002)(53546011)(186003)(102836004)(26005)(6506007)(305945005)(14444005)(8936002)(66066001)(86362001)(256004)(25786009)(53936002)(478600001)(82746002)(81156014)(5660300001)(81166006)(446003)(106356001)(4326008)(11346002)(97736004)(486006)(5250100002)(36756003)(6246003)(316002)(54906003)(83716003)(3846002)(110136005)(14454004)(6116002)(105586002)(2900100001)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4609;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6A8ffn3yl7vnx53gGiZ51JSBr21KaqOgT5GtVhY6Zt6lYZynf1KuIo0C/ibdYyOoWdiW2hstHSDreyhjyZqL7a5dbCaVG81eK8xZMpJaBE6hALENCy7uWCqbV0VEHSnOxpFmMC7KBtFtB5xWvWPnV9viFGmAZ5yV02ORcuM4/jAoqkcc6lj9BWqNyUld2UVs8cMR9avZ8iRp/X4+G6xQl+xRqvjAFbsGJulghUJjbO2Rul7cRzA5d1BQxInOxXEBLKL6nw3im3XSPdfDCsvxsZNkEkFk7CnvSoL5s2HUdyJCGx5UPvbkvi+DvDdfx9SMHGzzPM7gRP5Y2hrSBXb5Hl19mpavUFvVD052cIpPlmg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EC0BAB23E8708448EC3299616BDBDBD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bf5c30-4bf3-42c8-0437-08d61427f1b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 18:38:30.6318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTE6MzEgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQoNCj4gT24gVGh1LCBTZXAgMDYsIDIwMTggYXQgMTE6MDk6MjNBTSAtMDcwMCwgQW5keSBMdXRv
bWlyc2tpIHdyb3RlOg0KPj4+IE9uIFNlcCA2LCAyMDE4LCBhdCAxMDo1OCBBTSwgTmFkYXYgQW1p
dCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4gSXQgZGVwZW5kcyB3aGF0IHNlY3VyaXR5
IHlvdSB3YW50LiBTb21lIG1heSBjb25zaWRlciBldmVuIHRoZSBzaG9ydA0KPj4+IHRpbWUtd2lu
ZG93IGluIHdoaWNoIHRoZSBrZXJuZWwgY29kZSBpcyB3cml0YWJsZSBmcm9tIG90aGVyIGNvcmVz
IGFzDQo+Pj4gaW5zdWZmaWNpZW50IGZvciBzZWN1cml0eS4NCj4+PiANCj4+PiBJbiBhZGRpdGlv
biwgdGhlIHNldCByZW1vdmVzIHRoZSBuZWVkIGZvciByZW1vdGUgVExCIHNob290ZG93bnMgdGhh
dA0KPj4+IHRleHRfcG9rZSgpIC0gd2l0aCB0aGlzIGZpeCAtIHJlcXVpcmVzLg0KPj4gDQo+PiBJ
4oCZbSBwZXJzb25hbGx5IGluIGZhdm9yIG9mIG5vdCBuZWVkaW5nIGEgZ2xvYmFsIGJyb2FkY2Fz
dCBmbHVzaCB0byBpbnN0YWxsIGtwcm9iZXMuDQo+IA0KPiBUaGF0J3MgZmluZS4gQnV0IGF0IHRo
YXQgcG9pbnQgaXRzIGFuIG9wdGltaXphdGlvbiwgbm90IGEgY29ycmVjdG5lc3MNCj4gaXNzdWUu
DQoNCk5vdGUgdGhhdCBwYXRjaCAxLzYgaXMgc3RpbGwgbmVlZGVkIHRvIGZpeCBmYWxzZSBsb2Nr
ZGVwIHNob3V0b3V0cyBkdWUgdG8gYQ0KcmVjZW50IHBhdGNoLg0KDQo=
