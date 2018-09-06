Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548DDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E8720652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="qjBm0YNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E8720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeIFVhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:37:55 -0400
Received: from mail-eopbgr730080.outbound.protection.outlook.com ([40.107.73.80]:5488
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbeIFVhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0BMHd60PGOKohHjXb51/IlyjkxM4a4rn0jkSaTEfSc=;
 b=qjBm0YNS9lFTHXT/N3nkqxjtT53j+AP5tPW+ngqRrz5nVQdDUgtPYtttC34j7zjlttUnaf2Y2KXeD/0r2ElX8MB339CYJf+Crws4SWN5ZDdt04nb7zH9btmUd894yArxpMVbtStLb4qiNO81Q5WYP3Vfy3eEOQZ6gprncUs12Ps=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB4691.namprd05.prod.outlook.com (20.177.145.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.11; Thu, 6 Sep 2018 17:01:25 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::70ee:7ce:cd75:1112%4]) with mapi id 15.20.1122.009; Thu, 6 Sep 2018
 17:01:25 +0000
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
Thread-Index: AQHUQuMbzkVQDn+XA0OpXaFEC8rBZ6TiDnqAgAABqICAAAJhAIAA2pAAgAAij4CAAHESgA==
Date:   Thu, 6 Sep 2018 17:01:25 +0000
Message-ID: <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
In-Reply-To: <20180906101641.GG24142@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB4691;20:6O8dSbFEXPgh753mgSVV6G9lvgbNw3tdz8FSTHBj9GThY1qf/7uCWh97yc4PLMnKuRHNQ8r45CrPyCf45qLL5XxE/6hKFD/gpjZtmOGR2J+egsE2YtYOOnxy6FQvxp5rEKe4ZNYDBUDYva6bJr6aY5QSxs5eQqJaGE0HkPM8GcI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 709ad019-8132-40dc-8209-08d6141a6162
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB4691;
x-ms-traffictypediagnostic: BL0PR05MB4691:
bcl:    0
x-microsoft-antispam-prvs: <BL0PR05MB4691F351AF4E995F642647B2D0010@BL0PR05MB4691.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BL0PR05MB4691;BCL:0;PCL:0;RULEID:;SRVR:BL0PR05MB4691;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(68736007)(33656002)(6436002)(2616005)(486006)(229853002)(6512007)(6486002)(54906003)(476003)(53936002)(3846002)(105586002)(82746002)(99286004)(7736002)(76176011)(305945005)(8676002)(6116002)(446003)(2900100001)(5250100002)(81166006)(36756003)(186003)(102836004)(6506007)(26005)(14454004)(6246003)(97736004)(25786009)(6916009)(316002)(256004)(575784001)(86362001)(2906002)(81156014)(14444005)(106356001)(7416002)(11346002)(83716003)(93886005)(5660300001)(66066001)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB4691;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p9r9m1y+XQMAQ7bcXFf9X2APqsbaMMF2wXaPQ4ftpvaBwIlHBvsRPhD05C7okle7w5oGFJiv8KbHf3CYacA3bu5BDIieN7T6ni6jhq1QoaR+CA0cL1n3857i2mq5cGzMFDLDNUzQ3nQ9QJW7BzNhYq/kwtNnIJ4+Tg24uVLrtuW3ewRw/7LvWUZsKqdZlZJRCa3DlRBPHg0EbaQAFMhnss9rsRoY/zU2mKS710tYxdsDix68ETBBbacgwsqztmxqC7rpiG/suRw0xUoJdtfhr78OhpuroUW5Bqkbr8SlkRjfHitATMjMXkbd68j4DbFhMkzFhj6AvUSAItaAyY8SZ+4nENJGL4l6afKcX4ZdTdQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D90A8F51D5ABE48BD48A1E0A0F3AA1C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709ad019-8132-40dc-8209-08d6141a6162
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 17:01:25.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB4691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMzoxNiBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiB3cm90ZToN
Cg0KPiBPbiBUaHUsIFNlcCAwNiwgMjAxOCBhdCAxMDoxMzowMEFNICswMjAwLCBQZXRlciBaaWps
c3RyYSB3cm90ZToNCj4+IE5vLCB5b3UgZ290IGl0IHRoZSBmaXJzdCB0aW1lLiBUaGVyZSBhcmUg
aW4gZmFjdCBtb3JlIGZpeG1hcCBhYnVzZXJzOw0KPj4gc2VlIGRyaXZlcnMvYWNwaS9hcGVpL2do
ZXMuYy4gIEFsc28sIGFzIGxvbmcgYXMgc2V0X2ZpeG1hcCgpIGFsbG93cw0KPj4gb3ZlcndyaXRp
bmcgYSBfUEFHRV9QUkVTRU5UIHB0ZSBhbmQgaGFzIHRoYXQgZG9kZ3kNCj4+IF9fZmx1c2hfdGxi
X29uZV9rZXJuZWwoKSBpbiBpdCwgdGhlIGJyb2tlbiByZW1haW5zIChhbmQgY2FuIHJldHVybiku
DQo+PiANCj4+IFNvIHdlIG5lZWQgdG8gZml4IGZpeG1hcCwgdG8gZWl0aGVyIGRpc2FsbG93IG92
ZXJ3cml0aW5nIGEgX1BBR0VfUFJFU0VOVA0KPj4gcHRlLCBvciB0byBpc3N1ZSBhIGZ1bGwgVExC
IGludmFsaWRhdGUuDQo+PiANCj4+IEVpdGhlciBmaXggd2lsbCB0ZXJtaW5hbGx5IGJyZWFrIEdI
RVMsIGJ1dCB0aGF0J3MgT0ssIHRoZXkndmUga25vd24NCj4+IGFib3V0IHRoaXMgaXNzdWUgc2lu
Y2UgMjAxNSBhbmQgaGF2ZW4ndCBjYXJlZCwgc28gSSBjYW4ndCBiZSBib3RoZXJlZA0KPj4gYWJv
dXQgdGhlbS4NCj4gDQo+IEluIGZhY3QsIHRoZSBiZWxvdyBzZWVtcyB0byBjdXJlIGFsbCB3b2Vz
Li4NCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYyBiL2Fy
Y2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+IGluZGV4IGI5ZDVlN2M5ZWY0My4uMDBmMWM5
ZTRmMGEzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYw0KPiAr
KysgYi9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYw0KPiBAQCAtNzA5LDIyICs3MDksMjUg
QEAgdm9pZCAqdGV4dF9wb2tlKHZvaWQgKmFkZHIsIGNvbnN0IHZvaWQgKm9wY29kZSwgc2l6ZV90
IGxlbikNCj4gCQlwYWdlc1sxXSA9IHZpcnRfdG9fcGFnZShhZGRyICsgUEFHRV9TSVpFKTsNCj4g
CX0NCj4gCUJVR19PTighcGFnZXNbMF0pOw0KPiAtCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsNCj4g
Kw0KPiAJc2V0X2ZpeG1hcChGSVhfVEVYVF9QT0tFMCwgcGFnZV90b19waHlzKHBhZ2VzWzBdKSk7
DQo+IAlpZiAocGFnZXNbMV0pDQo+IAkJc2V0X2ZpeG1hcChGSVhfVEVYVF9QT0tFMSwgcGFnZV90
b19waHlzKHBhZ2VzWzFdKSk7DQo+ICsNCj4gKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+IAl2
YWRkciA9IChjaGFyICopZml4X3RvX3ZpcnQoRklYX1RFWFRfUE9LRTApOw0KPiAJbWVtY3B5KCZ2
YWRkclsodW5zaWduZWQgbG9uZylhZGRyICYgflBBR0VfTUFTS10sIG9wY29kZSwgbGVuKTsNCj4g
LQljbGVhcl9maXhtYXAoRklYX1RFWFRfUE9LRTApOw0KPiAtCWlmIChwYWdlc1sxXSkNCj4gLQkJ
Y2xlYXJfZml4bWFwKEZJWF9URVhUX1BPS0UxKTsNCj4gLQlsb2NhbF9mbHVzaF90bGIoKTsNCj4g
CXN5bmNfY29yZSgpOw0KPiAJLyogQ291bGQgYWxzbyBkbyBhIENMRkxVU0ggaGVyZSB0byBzcGVl
ZCB1cCBDUFUgcmVjb3Zlcnk7IGJ1dA0KPiAJICAgdGhhdCBjYXVzZXMgaGFuZ3Mgb24gc29tZSBW
SUEgQ1BVcy4gKi8NCj4gCWZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykNCj4gCQlCVUdfT04oKChj
aGFyICopYWRkcilbaV0gIT0gKChjaGFyICopb3Bjb2RlKVtpXSk7DQo+IAlsb2NhbF9pcnFfcmVz
dG9yZShmbGFncyk7DQo+ICsNCj4gKwljbGVhcl9maXhtYXAoRklYX1RFWFRfUE9LRTApOw0KPiAr
CWlmIChwYWdlc1sxXSkNCj4gKwkJY2xlYXJfZml4bWFwKEZJWF9URVhUX1BPS0UxKTsNCj4gKw0K
PiAJcmV0dXJuIGFkZHI7DQo+IH0NCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tbS9pbml0
XzY0LmMgYi9hcmNoL3g4Ni9tbS9pbml0XzY0LmMNCj4gaW5kZXggZGQ1MTlmMzcyMTY5Li5mZDZh
ZjY2YmM0MDAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21tL2luaXRfNjQuYw0KPiArKysgYi9h
cmNoL3g4Ni9tbS9pbml0XzY0LmMNCj4gQEAgLTI2MCwxNCArMjYwLDI4IEBAIHN0YXRpYyB2b2lk
IF9fc2V0X3B0ZV92YWRkcihwdWRfdCAqcHVkLCB1bnNpZ25lZCBsb25nIHZhZGRyLCBwdGVfdCBu
ZXdfcHRlKQ0KPiB7DQo+IAlwbWRfdCAqcG1kID0gZmlsbF9wbWQocHVkLCB2YWRkcik7DQo+IAlw
dGVfdCAqcHRlID0gZmlsbF9wdGUocG1kLCB2YWRkcik7DQo+ICsJcHRlX3Qgb2xkX3B0ZSA9ICpw
dGU7DQo+IA0KPiAJc2V0X3B0ZShwdGUsIG5ld19wdGUpOw0KPiANCj4gCS8qDQo+IC0JICogSXQn
cyBlbm91Z2ggdG8gZmx1c2ggdGhpcyBvbmUgbWFwcGluZy4NCj4gLQkgKiAoUEdFIG1hcHBpbmdz
IGdldCBmbHVzaGVkIGFzIHdlbGwpDQo+ICsJICogSWYgaXQgd2FzIHByZXNlbnQgYW5kIGNoYW5n
ZXMsIHdlIG5lZWQgdG8gaW52YWxpZGF0ZSBUTEJzLg0KPiAJICovDQo+IC0JX19mbHVzaF90bGJf
b25lX2tlcm5lbCh2YWRkcik7DQo+ICsJaWYgKCEocHRlX3ByZXNlbnQob2xkX3B0ZSkgJiYgIXB0
ZV9zYW1lKG9sZF9wdGUsIG5ld19wdGUpKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKFdB
Uk4oaXJxc19kaXNhYmxlZCgpLCAiYnJva2VuIHNldF9maXhtYXAoJWQsICVseCksIHdhczogJWx4
IiwNCj4gKwkJCQkoaW50KV9fdmlydF90b19maXgodmFkZHIpLA0KPiArCQkJCXB0ZV92YWwobmV3
X3B0ZSksIHB0ZV92YWwob2xkX3B0ZSkpKSB7DQo+ICsJCS8qDQo+ICsJCSAqIEl0IGlzIF9OT1Rf
IGVub3VnaCB0byBmbHVzaCBqdXN0IHRoZSBsb2NhbCBtYXBwaW5nOw0KPiArCQkgKiBpdCBtaWdo
dCBtb3N0bHkgd29yaywgYnV0IHRoZXJlIGlzIG5vIGd1YXJhbnRlZSBhIHJlbW90ZQ0KPiArCQkg
KiBDUFUgZGlkbid0IGxvYWQgdGhpcyBlbnRyeSBpbnRvIGl0cyBUTEIuDQo+ICsJCSAqLw0KPiAr
CQlfX2ZsdXNoX3RsYl9vbmVfa2VybmVsKHZhZGRyKTsNCj4gKwl9IGVsc2Ugew0KPiArCQlmbHVz
aF90bGJfa2VybmVsX3JhbmdlKHZhZGRyLCB2YWRkciArIFBBR0VfU0laRSk7DQo+ICsJfQ0KPiB9
DQo+IA0KPiB2b2lkIHNldF9wdGVfdmFkZHJfcDRkKHA0ZF90ICpwNGRfcGFnZSwgdW5zaWduZWQg
bG9uZyB2YWRkciwgcHRlX3QgbmV3X3B0ZSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9h
cGVpL0tjb25maWcgYi9kcml2ZXJzL2FjcGkvYXBlaS9LY29uZmlnDQo+IGluZGV4IDUyYWU1NDM4
ZWRlYi4uZTNjNDE1YmRiZmJmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2FjcGkvYXBlaS9LY29u
ZmlnDQo+ICsrKyBiL2RyaXZlcnMvYWNwaS9hcGVpL0tjb25maWcNCj4gQEAgLTE5LDYgKzE5LDcg
QEAgY29uZmlnIEFDUElfQVBFSQ0KPiANCj4gY29uZmlnIEFDUElfQVBFSV9HSEVTDQo+IAlib29s
ICJBUEVJIEdlbmVyaWMgSGFyZHdhcmUgRXJyb3IgU291cmNlIg0KPiArCWRlcGVuZHMgb24gQlJP
S0VOIGlmIFg4Ng0KPiAJZGVwZW5kcyBvbiBBQ1BJX0FQRUkNCj4gCXNlbGVjdCBBQ1BJX0hFRA0K
PiAJc2VsZWN0IElSUV9XT1JLDQoNCkluZGVlZCwgSSBtaXNzZWQgdGhlc2Ugb3RoZXIgaW5zdGFu
Y2VzIHRoYXQgdXNlIHRoZSBmaXhtYXAuDQoNCknigJlsbCBnaXZlIHlvdXIgcGF0Y2ggYSB0cnkg
b25jZSBteSBzZXJ2ZXIgZ29lcyBiYWNrIG9ubGluZS4gSSB3YXMgKGFuZCBzdGlsbA0KYW0pIHdv
cnJpZWQgdGhhdCBpbnRlcnJ1cHRzIHdvdWxkIGJlIGRpc2FibGVkIHdoZW4gX19zZXRfcHRlX3Zh
ZGRyKCkgaXMNCmNhbGxlZCwgd2hpY2ggd291bGQgbWFrZSB0aGUgZml4IG1vcmUgY29tcGxpY2F0
ZWQuDQoNCkluIGFkZGl0aW9uLCB0aGVyZSBtaWdodCBiZSBhIGNvdXBsZSBvZiBpc3N1ZXMgd2l0
aCB5b3VyIGZpeDoNCg0KMS4gX19zZXRfcHRlX3ZhZGRyKCkgaXMgbm90IHVzZWQgZXhjbHVzaXZl
IGJ5IHNldF9maXhtYXAoKS4gVGhpcyBtZWFucw0KdGhlIHdhcm5pbmcgbWlnaHQgYmUgd3Jvbmcs
IGJ1dCBhbHNvIG1lYW5zIHRoYXQgdGhlc2UgY29kZSBwYXRjaGVzIChYZW7igJlzDQpzZXRfcHRl
X21mbigpLCBDUFUtZW50cnktYXJlYSBzZXR1cCkgbmVlZHMgdG8gYmUgY2hlY2tlZC4gQW5kIGFz
IHlvdSBzYWlkDQpiZWZvcmUsIHNvbWVvbmUgbWlnaHQgdXNlIHRoaXMgZnVuY3Rpb24gZm9yIG90
aGVyIHB1cnBvc2VzIGFzIHdlbGwuDQoNCjIuIFByaW50aW5nIHRoZSB2aXJ0dWFsIGFkZHJlc3Mg
Y2FuIGJyZWFrIEtBU0xSLg0KDQozLiBUaGUgV0FSTigpIGNhbiBpbnRyb2R1Y2Ugc29tZSBvdmVy
aGVhZCBzaW5jZSBjaGVja2luZyBpZiBJUlFzIGFyZQ0KZGlzYWJsZWQgdGFrZXMgY29uc2lkZXJh
Ymx5IGxvbmcgdGltZS4gUGVyaGFwcyBWTV9XQVJOKCkgb3Igc29tZXRoaW5nIGlzDQpiZXR0ZXIu
IEkgcmVhbGl6ZSB0aGlzIGNvZGUtcGF0aCBpcyBub3Qgb24gdGhlIGhvdC1wYXRoIHRob3VnaC4u
Lg0KDQo0LiBJIGd1ZXNzIGZsdXNoX3RsYl9rZXJuZWxfcmFuZ2UoKSBzaG91bGQgYWxzbyBoYXZl
IHNvbWV0aGluZyBsaWtlDQpWTV9XQVJOX09OKGlycXNfZGlzYWJsZWQoKSksIGp1c3QgYXMgYW4g
YWRkaXRpb25hbCBnZW5lcmFsIHNhbml0eSBjaGVjay4NCg0KTGV0IG1lIGtub3cgaWYgeW91IHdh
bnQgbWUgdG8gbWFrZSB0aGVzZSBjaGFuZ2VzIGFuZCBpbmNsdWRlIHlvdXIgcGF0Y2ggaW4NCnRo
ZSBzZXQuDQoNClJlZ2FyZHMsDQpOYWRhdg0KDQo=
