Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1174EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA93820819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Rip6pCO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA93820819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbeKFErU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:47:20 -0500
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:17872
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387556AbeKFErT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfFdv2TZwEkNZgKdknE5XcxfCuy6Ir7KvUg5Bf5Y06g=;
 b=Rip6pCO3lzf7yjuBsuMBSu6z1mvguqwkg6HXy0SDslNPnGN+49u7J9qeTsfHRV7RtWe/lPzLA+C7cQPC9BcjE2ILNpn7iREpEdkJxaNRf79AfYdL7pGBKUmbKgN+Sl37BCT1vB4wRxVVyi5u9btOWl7P9v+KLYZRBdvLeo1USRs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4503.namprd05.prod.outlook.com (52.135.203.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.8; Mon, 5 Nov 2018 19:25:27 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 19:25:26 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Thread-Topic: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Thread-Index: AQHUcwQ37jX8+phTpkyCnxi097WrnaVBPEeAgAA19QCAAAeVAIAAFLiAgAAGBwA=
Date:   Mon, 5 Nov 2018 19:25:26 +0000
Message-ID: <8DF7BED8-F1B2-4102-9452-46437D3E4FC6@vmware.com>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-3-namit@vmware.com>
 <20181105140925.GD22467@hirez.programming.kicks-ass.net>
 <BB6FC627-C152-4C4C-A6D4-FA7F42F2610D@amacapital.net>
 <4D260352-A9FF-47F2-B3B2-0A87DF16CB70@vmware.com>
 <D67F7C19-DF59-4405-A5A3-B56C0E491B41@amacapital.net>
In-Reply-To: <D67F7C19-DF59-4405-A5A3-B56C0E491B41@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4503;20:UTaTh500ltavfZCMGsVPE2590ixUtPF3Kf4crTML424cBPUWwMtY26DElb8+eFCIJqW12O/Q1NHm799CKBylrVqg1c8ZQ+0AlbOo4TFTSA6b+cCsLJUxMOeX/A+vBDLc8udO+ImwYT/4vYNMyFMjNjVLCXCHBs1IUs35bAcj28g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d6fb133c-b4d1-4d87-86e8-08d6435470df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4503;
x-ms-traffictypediagnostic: BYAPR05MB4503:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB4503C7155DE8180268339A4ED0CA0@BYAPR05MB4503.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(61668805478150)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4503;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4503;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(106356001)(105586002)(82746002)(66066001)(97736004)(102836004)(8676002)(2906002)(68736007)(229853002)(81166006)(256004)(8936002)(81156014)(14444005)(14454004)(5660300001)(478600001)(6916009)(6506007)(53546011)(26005)(186003)(476003)(2616005)(446003)(11346002)(486006)(76176011)(99286004)(93886005)(2900100001)(316002)(4326008)(33656002)(25786009)(54906003)(6246003)(3846002)(6116002)(7416002)(7736002)(53936002)(71190400001)(71200400001)(83716004)(6436002)(6486002)(6512007)(575784001)(36756003)(86362001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4503;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sUNnImDr9fCFeGvlmqHah0ERzHq34QjlRQdWwRT9DG1TdC75f45fW5U/59o7assa8iI3kSg8XBPZkql163V/ZYVC5rcosT16qQ/io6rxB7ditDhTmoMBL/F4eGDVYUPy6DZGljRbrksD5Wby8faH7oSfh2Q6jKyhcJwM8ir4j9nrskoZYEohN+cDiLRMuHkH9VvoeaOpxmpdARYjuLDbMGsyinKsJPAeK4dftvvvND0lRTGOOQCM501x9Rlk3eDXAhA7TjvLPHwwYGb+lwfKXYdPAIotGwb5h2KO7EuJ2FdULis/1AKvN+DC46OSpQT1IM6KhQ4yV9XArmAXwAuH9ye9RBg1+Nd0qJi4xJL7tGc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D203DE89B0D2745BE40C5A81683090E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fb133c-b4d1-4d87-86e8-08d6435470df
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 19:25:26.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQpTZW50OiBOb3ZlbWJlciA1LCAyMDE4IGF0IDc6MDM6NDkg
UE0gR01UDQo+IFRvOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPiBDYzogUGV0ZXIg
WmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiwgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhh
dC5jb20+LCBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiwgWDg2IE1MIDx4ODZA
a2VybmVsLm9yZz4sIEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPiwgVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+LCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4s
IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+LCBBbmR5IEx1dG9taXJz
a2kgPGx1dG9Aa2VybmVsLm9yZz4sIEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPiwg
RGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4sIE1hc2FtaSBIaXJhbWF0c3UgPG1o
aXJhbWF0QGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi83XSB4ODYvanVt
cF9sYWJlbDogVXNlIHRleHRfcG9rZV9lYXJseSgpIGR1cmluZyBlYXJseV9pbml0DQo+IA0KPiAN
Cj4gDQo+IA0KPj4gT24gTm92IDUsIDIwMTgsIGF0IDk6NDkgQU0sIE5hZGF2IEFtaXQgPG5hbWl0
QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4gDQo+PiBGcm9tOiBBbmR5IEx1dG9taXJza2kNCj4+IFNl
bnQ6IE5vdmVtYmVyIDUsIDIwMTggYXQgNToyMjozMiBQTSBHTVQNCj4+PiBUbzogUGV0ZXIgWmlq
bHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPj4+IENjOiBOYWRhdiBBbWl0IDxuYW1pdEB2
bXdhcmUuY29tPiwgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+LCBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnLCB4ODZAa2VybmVsLm9yZywgSC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRv
ci5jb20+LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sIEJvcmlzbGF2IFBl
dGtvdiA8YnBAYWxpZW44LmRlPiwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVs
LmNvbT4sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPiwgS2VlcyBDb29rIDxrZWVz
Y29va0BjaHJvbWl1bS5vcmc+LCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiwg
TWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4NCj4+PiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDIvN10geDg2L2p1bXBfbGFiZWw6IFVzZSB0ZXh0X3Bva2VfZWFybHkoKSBkdXJp
bmcgZWFybHlfaW5pdA0KPj4+IA0KPj4+IA0KPj4+IA0KPj4+Pj4gT24gTm92IDUsIDIwMTgsIGF0
IDY6MDkgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+
Pj4+PiANCj4+Pj4+IE9uIEZyaSwgTm92IDAyLCAyMDE4IGF0IDA0OjI5OjQxUE0gLTA3MDAsIE5h
ZGF2IEFtaXQgd3JvdGU6DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2p1bXBf
bGFiZWwuYyBiL2FyY2gveDg2L2tlcm5lbC9qdW1wX2xhYmVsLmMNCj4+Pj4+IGluZGV4IGFhYzBj
MWY3ZTM1NC4uMzY3YzFkMGMyMGEzIDEwMDY0NA0KPj4+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVs
L2p1bXBfbGFiZWwuYw0KPj4+Pj4gKysrIGIvYXJjaC94ODYva2VybmVsL2p1bXBfbGFiZWwuYw0K
Pj4+Pj4gQEAgLTUyLDcgKzUyLDEzIEBAIHN0YXRpYyB2b2lkIF9fcmVmIF9fanVtcF9sYWJlbF90
cmFuc2Zvcm0oc3RydWN0IGp1bXBfZW50cnkgKmVudHJ5LA0KPj4+Pj4gam1wLm9mZnNldCA9IGp1
bXBfZW50cnlfdGFyZ2V0KGVudHJ5KSAtDQo+Pj4+PiAgICAgICAgICAoanVtcF9lbnRyeV9jb2Rl
KGVudHJ5KSArIEpVTVBfTEFCRUxfTk9QX1NJWkUpOw0KPj4+Pj4gDQo+Pj4+PiAtICAgIGlmIChl
YXJseV9ib290X2lycXNfZGlzYWJsZWQpDQo+Pj4+PiArICAgIC8qDQo+Pj4+PiArICAgICAqIEFz
IGxvbmcgYXMgd2UgYXJlIGluIGVhcmx5IGJvb3QsIHdlIGNhbiB1c2UgdGV4dF9wb2tlX2Vhcmx5
KCksIHdoaWNoDQo+Pj4+PiArICAgICAqIGlzIG1vcmUgZWZmaWNpZW50OiB0aGUgbWVtb3J5IHdh
cyBzdGlsbCBub3QgbWFya2VkIGFzIHJlYWQtb25seSAoaXQNCj4+Pj4+ICsgICAgICogaXMgb25s
eSBtYXJrZWQgYWZ0ZXIgcG9raW5nX2luaXQoKSkuIFRoaXMgYWxzbyBwcmV2ZW50cyB1cyBmcm9t
IHVzaW5nDQo+Pj4+PiArICAgICAqIHRleHRfcG9rZSgpIGJlZm9yZSBwb2tpbmdfaW5pdCgpIGlz
IGNhbGxlZC4NCj4+Pj4+ICsgICAgICovDQo+Pj4+PiArICAgIGlmICghZWFybHlfYm9vdF9kb25l
KQ0KPj4+Pj4gICAgIHBva2VyID0gdGV4dF9wb2tlX2Vhcmx5Ow0KPj4+Pj4gDQo+Pj4+PiBpZiAo
dHlwZSA9PSBKVU1QX0xBQkVMX0pNUCkgew0KPj4+PiANCj4+Pj4gSXQgdG9vayBtZSBhIHdoaWxl
IHRvIHVudGFuZ2xlIGluaXQvbWF6ZV5IXkhpbi5jLi4uIGJ1dCBJIHRoaW5rIHRoaXMNCj4+Pj4g
aXMgYWxsIHdlIG5lZWQ6DQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L2p1bXBfbGFiZWwuYyBiL2FyY2gveDg2L2tlcm5lbC9qdW1wX2xhYmVsLmMNCj4+Pj4gaW5kZXgg
YWFjMGMxZjdlMzU0Li5lZDVmZTI3NGE3ZDggMTAwNjQ0DQo+Pj4+IC0tLSBhL2FyY2gveDg2L2tl
cm5lbC9qdW1wX2xhYmVsLmMNCj4+Pj4gKysrIGIvYXJjaC94ODYva2VybmVsL2p1bXBfbGFiZWwu
Yw0KPj4+PiBAQCAtNTIsNyArNTIsMTIgQEAgc3RhdGljIHZvaWQgX19yZWYgX19qdW1wX2xhYmVs
X3RyYW5zZm9ybShzdHJ1Y3QganVtcF9lbnRyeSAqZW50cnksDQo+Pj4+IGptcC5vZmZzZXQgPSBq
dW1wX2VudHJ5X3RhcmdldChlbnRyeSkgLQ0KPj4+PiAgICAgICAgICAoanVtcF9lbnRyeV9jb2Rl
KGVudHJ5KSArIEpVTVBfTEFCRUxfTk9QX1NJWkUpOw0KPj4+PiANCj4+Pj4gLSAgICBpZiAoZWFy
bHlfYm9vdF9pcnFzX2Rpc2FibGVkKQ0KPj4+PiArICAgIC8qDQo+Pj4+ICsgICAgICogQXMgbG9u
ZyBhcyB3ZSdyZSBVUCBhbmQgbm90IHlldCBtYXJrZWQgUk8sIHdlIGNhbiB1c2UNCj4+Pj4gKyAg
ICAgKiB0ZXh0X3Bva2VfZWFybHk7IFNZU1RFTV9CT09USU5HIGd1YXJhbnRlZXMgYm90aCwgYXMg
d2Ugc3dpdGNoIHRvDQo+Pj4+ICsgICAgICogU1lTVEVNX1NDSEVEVUxJTkcgYmVmb3JlIGdvaW5n
IGVpdGhlci4NCj4+Pj4gKyAgICAgKi8NCj4+Pj4gKyAgICBpZiAoc3lzdGVtX3N0YXRlID09IFNZ
U1RFTV9CT09USU5HKQ0KPj4+PiAgICAgcG9rZXIgPSB0ZXh0X3Bva2VfZWFybHk7DQo+Pj4+IA0K
Pj4+PiBpZiAodHlwZSA9PSBKVU1QX0xBQkVMX0pNUCkgew0KPj4+IA0KPj4+IENhbiB3ZSBtb3Zl
IHRoaXMgbG9naWMgaW50byB0ZXh0X3Bva2UoKSBhbmQgZ2V0IHJpZCBvZiB0ZXh0X3Bva2VfZWFy
bHkoKT8NCj4+IA0KPj4gVGhpcyB3aWxsIG5lZ2F0aXZlbHkgYWZmZWN0IHBva2luZyBvZiBtb2R1
bGVzIGRvaW5nIG1vZHVsZSBsb2FkaW5nLCBlLmcuLA0KPj4gYXBwbHlfcGFyYXZpcnQoKS4gVGhp
cyBjYW4gYmUgcmVzb2x2ZWQgYnkga2VlcGluZyB0cmFjayB3aGVuIHRoZSBtb2R1bGUgaXMNCj4+
IHdyaXRlLXByb3RlY3RlZCBhbmQgZ2l2aW5nIGEgbW9kdWxlIHBhcmFtZXRlciB0byB0ZXh0X3Bv
a2UoKS4gRG9lcyBpdCB3b3J0aA0KPj4gdGhlIGNvbXBsZXhpdHk/DQo+IA0KPiBQcm9iYWJseSBu
b3QuDQo+IA0KPiBPVE9ILCB3aHkgZG9lcyBhbHRlcm5hdGl2ZSBwYXRjaGluZyBuZWVkIHRleHRf
cG9rZSgpIGF0IGFsbD8gQ2Fu4oCZdCBpdCBqdXN0DQo+IHdyaXRlIHRvIHRoZSB0ZXh0Pw0KDQpH
b29kIHF1ZXN0aW9uLiBBY2NvcmRpbmcgdG8gbXkgdW5kZXJzdGFuZGluZywgdGhlc2UgZ2FtZXMg
b2YNCnRleHRfcG9rZV9lYXJseSgpIGFyZSBub3QgbmVlZGVkLCBhdCBsZWFzdCBmb3IgbW9kdWxl
cyAob24gSW50ZWwpLg0KDQpJbnRlbCBTRE0gMTEuNiAiU0VMRi1NT0RJRllJTkcgQ09EReKAnSBz
YXlzOiANCg0KIkEgd3JpdGUgdG8gYSBtZW1vcnkgbG9jYXRpb24gaW4gYSBjb2RlIHNlZ21lbnQg
dGhhdCBpcyBjdXJyZW50bHkgY2FjaGVkIGluDQp0aGUgcHJvY2Vzc29yIGNhdXNlcyB0aGUgYXNz
b2NpYXRlZCBjYWNoZSBsaW5lIChvciBsaW5lcykgdG8gYmUgaW52YWxpZGF0ZWQuDQpUaGlzIGNo
ZWNrIGlzIGJhc2VkIG9uIHRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIHRoZSBpbnN0cnVjdGlvbi7i
gJ0NCg0KVGhlbiB0aGUgbWFudWFsIHRhbGtzIGFib3V0IHByZWZldGNoZWQgaW5zdHJ1Y3Rpb25z
LCBidXQgdGhlIG1vZHVsZXMgY29kZSBpcw0KcHJlc3VtYWJseSBub3QgYmUg4oCccHJlZmV0Y2hh
Ymxl4oCdIGF0IHRoaXMgcG9pbnQuIFNvIEkgdGhpbmsgaXQgc2hvdWxkIGJlDQpzYWZlLCBidXQg
SSBndWVzcyB0aGF0IHlvdSByZXZpZXdlZCBJbnRlbC9BTUQgbWFudWFscyBiZXR0ZXIgd2hlbiB5
b3Ugd3JvdGUNCnN5bmNfY29yZSgpLg0KDQpBbnlob3csIHRoZXJlIHNob3VsZCBiZSBhIGZ1bmN0
aW9uIHRoYXQgd3JhcHMgdGhlIG1lbWNweSgpIHRvIGtlZXAgdHJhY2sNCndoZW4gc29tZW9uZSBj
aGFuZ2VzIHRoZSB0ZXh0IChmb3IgcG90ZW50aWFsIGZ1dHVyZSB1c2UpLg0KDQpEb2VzIGl0IG1h
a2Ugc2Vuc2U/IERvIHlvdSB3YW50IG1lIHRvIGdpdmUgaXQgYSBzcGluPw0KDQpUaGFua3MsDQpO
YWRhdg==
