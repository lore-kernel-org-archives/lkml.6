Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476C0C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 16:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE95B20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 16:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="oPWlRULr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE95B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeIBVDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 17:03:15 -0400
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:28448
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbeIBVDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 17:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2i3uYuf4xJMOVruNao+lGNdJE0YFKMHxTs1X7rep4M=;
 b=oPWlRULrC04HdY+8Kt4O9REJZ57940PpZdY5+R3+JgpIgaooY4B6mgZFQaoXwYGP1doCHUbKDQh0rat4fkbiUEJh8OYHvDlqxJ6UyKEQlMcS6CaksYxzFWbfHK4dIh+54/riysifosfj1nzEjNjKkFoiIKgS7vHUOr5W18o3aaU=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4694.namprd05.prod.outlook.com (52.135.233.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.9; Sun, 2 Sep 2018 16:46:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.016; Sun, 2 Sep 2018
 16:46:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/6] x86/alternatives: text_poke() fixes
Thread-Topic: [PATCH 0/6] x86/alternatives: text_poke() fixes
Thread-Index: AQHUQIeqdSq3pYEU2E2efUzn1pdHnKTZSiGAgAAAwACAA+0fAA==
Date:   Sun, 2 Sep 2018 16:46:46 +0000
Message-ID: <FF03F7AC-B7D0-4A45-BC73-D67FEED7A976@vmware.com>
References: <20180830173218.238900-1-namit@vmware.com>
 <20180831134635.35b6c2a919449adf4b63a133@kernel.org>
 <20180831134916.f8c409da94baa492008b188e@kernel.org>
In-Reply-To: <20180831134916.f8c409da94baa492008b188e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4694;20:ctiSaGrJ64C0CRP+r+12VpqPBe30K7siIbSZzYYj6Mit9qoSpD9klST+MfXRLsgiPbNXs48M9PmAAQpl6l1S1RG5EQ2he+fZWXuGlu34R41iNK0yxTSYt3tPSvMggihr0RTbMrWoluqvknS69qy303CtFsPUncAr6sIo9jmU32E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 91d81deb-714d-4d4b-1161-08d610f3ac0c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4694;
x-ms-traffictypediagnostic: BYAPR05MB4694:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB469478519C5341A8A6BEF8EBD00D0@BYAPR05MB4694.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR05MB4694;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4694;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(366004)(376002)(51914003)(199004)(189003)(6436002)(26005)(6116002)(14454004)(102836004)(3846002)(54906003)(7416002)(316002)(2900100001)(186003)(68736007)(36756003)(6486002)(6916009)(66066001)(83716003)(6512007)(25786009)(4326008)(229853002)(8936002)(5660300001)(82746002)(6506007)(81166006)(33656002)(81156014)(97736004)(53936002)(6246003)(446003)(2906002)(99286004)(486006)(105586002)(2616005)(7736002)(5250100002)(106356001)(476003)(305945005)(76176011)(478600001)(8676002)(14444005)(86362001)(256004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4694;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iW4HqTV/ZtHaE3K789slHEvQ+QC2CzEYzUpNDhv4K0a88jP7qqpHa4yZGeeUoqKPtnjhnbTrxRM0o9RpZ+hOzZ4C/q3PxhjCKcW2aQAHcNwX7kbm8neCudwFfuJEEwW9W6CD753iDyT2hmSekI/uy0CHi4kjV+xVpCtj2ZKeDXqtLaPzaIx46/7alSiwmV5Q5fqyOkuU+sS7eroaNDjtN3SvEZOfhSGKZpkCSuJEAOaFS31BGX3AB0sX92C7ZqHqtzMWB9QsGCivKAa8buD3enmyEKpf3vnq55qSN2Ye1W9z4Jn+JHcgL+A+7EDxQC6mM55tUEDvjI9oCmcNurf+UalUdLdE0+Dd/xlda1KlzR4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EE168CDBCA8804B800A6709F16EB968@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d81deb-714d-4d4b-1161-08d610f3ac0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 16:46:46.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgOTo0OSBQTSwgTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4gd3JvdGU6
DQoNCj4gT24gRnJpLCAzMSBBdWcgMjAxOCAxMzo0NjozNSArMDkwMA0KPiBNYXNhbWkgSGlyYW1h
dHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+PiBPbiBUaHUsIDMwIEF1ZyAy
MDE4IDEwOjMyOjEyIC0wNzAwDQo+PiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90
ZToNCj4+IA0KPj4+IFRoaXMgcGF0Y2gtc2V0IGFkZHJlc3NlcyBzb21lIGlzc3VlcyB0aGF0IHdl
cmUgcmFpc2VkIGluIGEgcmVjZW50DQo+Pj4gY29ycmVzcG9uZGVuY2UgYW5kIG1pZ2h0IGFmZmVj
dCB0aGUgc2VjdXJpdHkgYW5kIHRoZSBjb3JyZWN0bmVzcyBvZiBjb2RlDQo+Pj4gcGF0Y2hpbmcu
IChOb3RlIHRoYXQgcGF0Y2hpbmcgcGVyZm9ybWFuY2UgaXMgbm90IGFkZHJlc3NlZCBieSB0aGlz
DQo+Pj4gcGF0Y2gtc2V0KS4NCj4+PiANCj4+PiBUaGUgbWFpbiBpc3N1ZSB0aGF0IHRoZSBwYXRj
aGVzIGRlYWwgd2l0aCBpcyB0aGUgZmFjdCB0aGF0IHRoZSBmaXhtYXANCj4+PiBQVEVzIHRoYXQg
YXJlIHVzZWQgZm9yIHBhdGNoaW5nIGFyZSBhdmFpbGFibGUgZm9yIGFjY2VzcyBmcm9tIG90aGVy
DQo+Pj4gY29yZXMgYW5kIG1pZ2h0IGJlIGV4cGxvaXRlZC4gVGhleSBhcmUgbm90IGV2ZW4gZmx1
c2hlZCBmcm9tIHRoZSBUTEIgaW4NCj4+PiByZW1vdGUgY29yZXMsIHNvIHRoZSByaXNrIGlzIGV2
ZW4gaGlnaGVyLiBBZGRyZXNzIHRoaXMgaXNzdWUgYnkNCj4+PiBpbnRyb2R1Y2luZyBhIHRlbXBv
cmFyeSBtbSB0aGF0IGlzIG9ubHkgdXNlZCBkdXJpbmcgcGF0Y2hpbmcuDQo+Pj4gVW5mb3J0dW5h
dGVseSwgZHVlIHRvIGluaXQgb3JkZXJpbmcsIGZpeG1hcCBpcyBzdGlsbCB1c2VkIGR1cmluZw0K
Pj4+IGJvb3QtdGltZSBwYXRjaGluZy4gRnV0dXJlIHBhdGNoZXMgY2FuIGVsaW1pbmF0ZSB0aGUg
bmVlZCBmb3IgaXQuDQo+Pj4gDQo+Pj4gVGhlIHNlY29uZCBpc3N1ZSBpcyB0aGUgbWlzc2luZyBs
b2NrZGVwIGFzc2VydGlvbiB0byBlbnN1cmUgdGV4dF9tdXRleA0KPj4+IGlzIHRha2VuLiBJdCBp
cyBhY3R1YWxseSBub3QgYWx3YXlzIHRha2VuLCBzbyBmaXggdGhlIGluc3RhbmNlcyB0aGF0DQo+
Pj4gd2VyZSBmb3VuZCBub3QgdG8gdGFrZSB0aGUgbG9jayAoYWx0aG91Z2ggdGhleSBzaG91bGQg
YmUgc2FmZSBldmVuDQo+Pj4gd2l0aG91dCB0YWtpbmcgdGhlIGxvY2spLg0KPj4+IA0KPj4+IEZp
bmFsbHksIHRyeSB0byBiZSBtb3JlIGNvbnNlcnZhdGl2ZSBhbmQgdG8gbWFwIGEgc2luZ2xlIHBh
Z2UsIGluc3RlYWQNCj4+PiBvZiB0d28sIHdoZW4gcG9zc2libGUuIFRoaXMgaGVscHMgYm90aCBz
ZWN1cml0eSBhbmQgcGVyZm9ybWFuY2UuDQo+Pj4gDQo+Pj4gSW4gYWRkaXRpb24sIHRoZXJlIGlz
IHNvbWUgY2xlYW51cCBvZiB0aGUgcGF0Y2hpbmcgY29kZSB0byBtYWtlIGl0IG1vcmUNCj4+PiBy
ZWFkYWJsZS4NCj4+IA0KPj4gT0ssIHRoaXMgc2VyaWVzIGxvb2tzIGdvb2QgdG8gbWUsIGFuZCB0
ZXN0ZWQgd2l0aCBmdHJhY2V0ZXN0LCBrcHJvYmUgdGVzdHNldHMuDQo+PiANCj4+IFJldmlld2Vk
LWJ5OiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPg0KPj4gVGVzdGVkLWJ5
OiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPg0KPiANCj4gT2gsIEkgbWlz
c2VkIGEgbm90ZS4NCj4gDQo+IFRvIGFwcGx5IHRoaXMgc2VyaWVzIG9uIC10aXAgdHJlZSwgd2Ug
aGF2ZSB0byByZXZlcnQgSmlyaSdzIHRleHRfbXV0ZXgNCj4gY2hlY2tlci4NCj4gDQo+IDkyMjJm
NjA2NTA2YyAoIng4Ni9hbHRlcm5hdGl2ZXM6IExvY2tkZXAtZW5mb3JjZSB0ZXh0X211dGV4IGlu
IHRleHRfcG9rZSooKSIpDQoNClRoYW5rcyBmb3IgdGhlIGhlYWRzLXVwLiBJ4oCZbGwgYWRkIGEg
cmV2ZXJ0IGZvciB0aGlzIHBhdGNoIGFuZCBzZW5kIHYyLg0KDQpSZWdhcmRzLA0KTmFkYXYNCg0K
