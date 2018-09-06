Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9FDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026E120844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="EQH+S3T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026E120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeIFWfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:35:25 -0400
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:18412
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728002AbeIFWfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX6Ax4I2ezPu/3Ghk79F36cD8BaHEmDhICbqoCOjz8k=;
 b=EQH+S3T23gJJEr0kl/1axyJy8Vn9FlM9fe7a57Ly+WKs4n0EdNJE8ndpY/6laW1zJ98vyuratVtKgeGCPFLFCIyDXKVTyLya8X8/CZIZQcYYsXsPaaJUlpwwxOL4sVri853oARJ5LyXff1mFRz9Hfh4TtWn0MlPp5NuCe44OrYI=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB5009.namprd05.prod.outlook.com (20.177.241.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.13; Thu, 6 Sep 2018 17:58:46 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 17:58:46 +0000
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Thread-Topic: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Thread-Index: AQHUQuMbzkVQDn+XA0OpXaFEC8rBZ6TiDnqAgAABqICAAAJhAIAA2pAAgAAij4CAAHESgIAABJ4AgAALaAA=
Date:   Thu, 6 Sep 2018 17:58:46 +0000
Message-ID: <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
 <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
 <20180906171754.GJ24106@hirez.programming.kicks-ass.net>
In-Reply-To: <20180906171754.GJ24106@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB5009;20:j9iTSQ84K1cVcRc57scgls5SmGzcIBXQNa/ihwAsRN00TvzPb7Ts/CIHkQKD+OMZzYNzXeETroKK4PDt+kcjGn8P/IaRcYM7t4WPZNRkpuVwgwMwsTqFC30ahqz9RWCAU3qRsjZN/Z3jUYPagE4iaMXcKI6XaSocgSCcd24Lh1U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d8a11ce0-5fcf-4a34-01da-08d614226475
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB5009;
x-ms-traffictypediagnostic: BL0PR05MB5009:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
bcl:    0
x-microsoft-antispam-prvs: <BL0PR05MB50096487F22F2EDC50AF1F18D0010@BL0PR05MB5009.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:BL0PR05MB5009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB5009;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(8676002)(36756003)(86362001)(305945005)(106356001)(7736002)(478600001)(66066001)(102836004)(3846002)(6116002)(6506007)(4326008)(105586002)(229853002)(6486002)(33656002)(76176011)(6246003)(6436002)(6512007)(53936002)(8936002)(83716003)(5250100002)(486006)(54906003)(11346002)(99286004)(14454004)(6916009)(316002)(68736007)(7416002)(97736004)(186003)(93886005)(5660300001)(2900100001)(25786009)(26005)(81156014)(2906002)(81166006)(2616005)(476003)(14444005)(256004)(446003)(82746002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5009;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f52jTVNs2SrqAUSi+rv6+xT2ChltGCPj2F3iU0H+ldLN2A9j0KMS93EFHbiS3ufKPXNPh+ocpWMeKKaY+E1psB95KF9rkGiYP/pDeGKXeXRfi6VUe9cFe5naYW/JcvmiuAakcz7Rx8PexlOPCO8Dn8AQLR4jSW9srMAb+9vzgErn49XcgwHhks8GpcnOVKiOjuR9ZtqaG4dlZLO6Lk+xyl/+hPuMg2qvEySnG4NgxQWPfbTXlEk8euZn2CvtIMSVy+Z2lCdTm2JASbGzwSN8qFFpLYPlOaKp+hH3W5MJ8EPAK71t0NXn5O+rHuHzUrx+mgrohUzoSG7Ni0N+Tmilgh9jZk3KB7V7FKUvpFiet/4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A722F72CAF7CC4287FF9C1679A62E18@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a11ce0-5fcf-4a34-01da-08d614226475
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 17:58:46.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTA6MTcgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQoNCj4gT24gVGh1LCBTZXAgMDYsIDIwMTggYXQgMDU6MDE6MjVQTSArMDAwMCwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+IEluIGFkZGl0aW9uLCB0aGVyZSBtaWdodCBiZSBhIGNvdXBsZSBvZiBpc3N1
ZXMgd2l0aCB5b3VyIGZpeDoNCj4gDQo+IEl0IGJvb3RzIG9uIG15IGJveCA7LSkNCj4gDQo+PiAx
LiBfX3NldF9wdGVfdmFkZHIoKSBpcyBub3QgdXNlZCBleGNsdXNpdmUgYnkgc2V0X2ZpeG1hcCgp
LiBUaGlzIG1lYW5zDQo+PiB0aGUgd2FybmluZyBtaWdodCBiZSB3cm9uZywgYnV0IGFsc28gbWVh
bnMgdGhhdCB0aGVzZSBjb2RlIHBhdGNoZXMgKFhlbuKAmXMNCj4+IHNldF9wdGVfbWZuKCksIENQ
VS1lbnRyeS1hcmVhIHNldHVwKSBuZWVkcyB0byBiZSBjaGVja2VkLiBBbmQgYXMgeW91IHNhaWQN
Cj4+IGJlZm9yZSwgc29tZW9uZSBtaWdodCB1c2UgdGhpcyBmdW5jdGlvbiBmb3Igb3RoZXIgcHVy
cG9zZXMgYXMgd2VsbC4NCj4gDQo+IENFQSBpcyBmaW5lLCB0aGF0IGFjdHVhbGx5IG5lZWRzIGl0
IHRvby4NCj4gDQo+IFRoZSBvbmUgdGhpbmcgSSBtaXNzZWQgb3V0IG9uIGVhcmxpZXIgaXMgdGhl
IGJlbG93IGNodW5rLCB0aGF0IGlzIG5vDQo+IGxvbmdlciBuZWVkZWQgbm93IHRoYXQgY2VhX3Nl
dF9wdGUoKSBhY3R1YWxseSBkb2VzIHRoZSByaWdodCB0aGluZy4NCj4gDQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvZHMuYyBiL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9kcy5j
DQo+IGluZGV4IGI3YjAxZDc2MmQzMi4uMTRhZDk3ZmEwNzQ5IDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3g4Ni9ldmVudHMvaW50ZWwvZHMuYw0KPiArKysgYi9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvZHMu
Yw0KPiBAQCAtMjkzLDEyICsyOTMsNiBAQCBzdGF0aWMgdm9pZCBkc191cGRhdGVfY2VhKHZvaWQg
KmNlYSwgdm9pZCAqYWRkciwgc2l6ZV90IHNpemUsIHBncHJvdF90IHByb3QpDQo+IHByZWVtcHRf
ZGlzYWJsZSgpOw0KPiBmb3IgKDsgbXN6IDwgc2l6ZTsgbXN6ICs9IFBBR0VfU0laRSwgcGEgKz0g
UEFHRV9TSVpFLCBjZWEgKz0gUEFHRV9TSVpFKQ0KPiBjZWFfc2V0X3B0ZShjZWEsIHBhLCBwcm90
KTsNCj4gLQ0KPiAtIC8qDQo+IC0gICogVGhpcyBpcyBhIGNyb3NzLUNQVSB1cGRhdGUgb2YgdGhl
IGNwdV9lbnRyeV9hcmVhLCB3ZSBtdXN0IHNob290IGRvd24NCj4gLSAgKiBhbGwgVExCIGVudHJp
ZXMgZm9yIGl0Lg0KPiAtICAqLw0KPiAtIGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2Uoc3RhcnQsIHN0
YXJ0ICsgc2l6ZSk7DQo+IHByZWVtcHRfZW5hYmxlKCk7DQo+IH0NCj4gDQo+IEBAIC0zMTAsOCAr
MzA0LDYgQEAgc3RhdGljIHZvaWQgZHNfY2xlYXJfY2VhKHZvaWQgKmNlYSwgc2l6ZV90IHNpemUp
DQo+IHByZWVtcHRfZGlzYWJsZSgpOw0KPiBmb3IgKDsgbXN6IDwgc2l6ZTsgbXN6ICs9IFBBR0Vf
U0laRSwgY2VhICs9IFBBR0VfU0laRSkNCj4gY2VhX3NldF9wdGUoY2VhLCAwLCBQQUdFX05PTkUp
Ow0KPiAtDQo+IC0gZmx1c2hfdGxiX2tlcm5lbF9yYW5nZShzdGFydCwgc3RhcnQgKyBzaXplKTsN
Cj4gcHJlZW1wdF9lbmFibGUoKTsNCj4gfQ0KPiANCj4gDQo+PiAyLiBQcmludGluZyB0aGUgdmly
dHVhbCBhZGRyZXNzIGNhbiBicmVhayBLQVNMUi4NCj4gDQo+IExvY2FsIEtBU0xSIGlzIGEgbXl0
aC4uIGJ1dCBzdXJlLCB3ZSBjYW4gZml4IHRoZSBwcmludC4NCj4gDQo+PiAzLiBUaGUgV0FSTigp
IGNhbiBpbnRyb2R1Y2Ugc29tZSBvdmVyaGVhZCBzaW5jZSBjaGVja2luZyBpZiBJUlFzIGFyZQ0K
Pj4gZGlzYWJsZWQgdGFrZXMgY29uc2lkZXJhYmx5IGxvbmcgdGltZS4gUGVyaGFwcyBWTV9XQVJO
KCkgb3Igc29tZXRoaW5nIGlzDQo+PiBiZXR0ZXIuIEkgcmVhbGl6ZSB0aGlzIGNvZGUtcGF0aCBp
cyBub3Qgb24gdGhlIGhvdC1wYXRoIHRob3VnaC4uLg0KPiANCj4gWWVhaCwgaWYgaXQgdHJpZ2dl
cnMgeW91IGhhdmUgYmlnZ2VyIHByb2JsZW1zLiBXZSBjYW4gbWFrZSBpdA0KPiBXQVJOX09OQ0Uo
KSBJIHN1cHBvc2UuDQo+IA0KPj4gNC4gSSBndWVzcyBmbHVzaF90bGJfa2VybmVsX3JhbmdlKCkg
c2hvdWxkIGFsc28gaGF2ZSBzb21ldGhpbmcgbGlrZQ0KPj4gVk1fV0FSTl9PTihpcnFzX2Rpc2Fi
bGVkKCkpLCBqdXN0IGFzIGFuIGFkZGl0aW9uYWwgZ2VuZXJhbCBzYW5pdHkgY2hlY2suDQo+IA0K
PiBJdCBoYXMsIGl0J3MgaGlkZGVuIGluIGtlcm5lbC9zbXAuYzpzbXBfY2FsbF9mdW5jdGlvbl9t
YW55KCkuDQoNClJpZ2h0LiBUaGFua3MuDQoNCj4gDQo+PiBMZXQgbWUga25vdyBpZiB5b3Ugd2Fu
dCBtZSB0byBtYWtlIHRoZXNlIGNoYW5nZXMgYW5kIGluY2x1ZGUgeW91ciBwYXRjaCBpbg0KPj4g
dGhlIHNldC4NCj4gDQo+IFRoZSBzZXQgaXMgbm8gbG9uZ2VyIG5lZWRlZC4gdGV4dF9wb2tlKCkg
aXMgZmluZSBhbmQgY29ycmVjdCB3aXRoIHRoaXMNCj4gb25lIHBhdGNoLg0KDQpJdCBkZXBlbmRz
IHdoYXQgc2VjdXJpdHkgeW91IHdhbnQuIFNvbWUgbWF5IGNvbnNpZGVyIGV2ZW4gdGhlIHNob3J0
DQp0aW1lLXdpbmRvdyBpbiB3aGljaCB0aGUga2VybmVsIGNvZGUgaXMgd3JpdGFibGUgZnJvbSBv
dGhlciBjb3JlcyBhcw0KaW5zdWZmaWNpZW50IGZvciBzZWN1cml0eS4NCg0KSW4gYWRkaXRpb24s
IHRoZSBzZXQgcmVtb3ZlcyB0aGUgbmVlZCBmb3IgcmVtb3RlIFRMQiBzaG9vdGRvd25zIHRoYXQN
CnRleHRfcG9rZSgpIC0gd2l0aCB0aGlzIGZpeCAtIHJlcXVpcmVzLg0KDQo=
