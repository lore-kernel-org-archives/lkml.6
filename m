Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7196FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28482073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JRWWLFWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28482073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeIFAXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:23:22 -0400
Received: from mail-eopbgr700135.outbound.protection.outlook.com ([40.107.70.135]:45072
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbeIFAXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qivKMJ5WawISycIShd1CWk878/GMCR7LQbLSS7tk0E=;
 b=JRWWLFWgMStaf/PJb+hVqBYQIsGSvUjVidBx8xXh6fcDu4h50FADllGXTSvb7A3RXlVZn9Zuwk5a9I+08l90D0e2JNR+Q9hYdDqGx0PV06QNed06yyE9oBiu+Wml0uymmITn7IA0lmZPF9o6ADFtlR1gGJQlqUi14LEimhJzIZI=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0793.namprd21.prod.outlook.com (10.175.112.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 5 Sep 2018 19:51:34 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1143.000; Wed, 5 Sep 2018
 19:51:34 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>,
        "alex.kogan@oracle.com" <alex.kogan@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "dave.dice@oracle.com" <dave.dice@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "ldufour@linux.vnet.ibm.com" <ldufour@linux.vnet.ibm.com>,
        "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
        "shady.issa@oracle.com" <shady.issa@oracle.com>,
        "tariqt@mellanox.com" <tariqt@mellanox.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@intel.com" <tim.c.chen@intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "longman@redhat.com" <longman@redhat.com>,
        "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        "subhra.mazumdar@oracle.com" <subhra.mazumdar@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        "jwadams@google.com" <jwadams@google.com>,
        "ashwinch@google.com" <ashwinch@google.com>,
        "sqazi@google.com" <sqazi@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "walken@google.com" <walken@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "junaids@google.com" <junaids@google.com>,
        Neha Agarwal <nehaagarwal@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
Thread-Topic: Plumbers 2018 - Performance and Scalability Microconference
Thread-Index: AQHURJZKR5vprwHkVkauwM8hk1CepaThPQQAgADdfwA=
Date:   Wed, 5 Sep 2018 19:51:34 +0000
Message-ID: <846ac52b-1839-4aa1-3154-1925c159bf4c@microsoft.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <20180905063845.GA23342@rapoport-lnx>
In-Reply-To: <20180905063845.GA23342@rapoport-lnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0793;6:9C4TrKQOqbAAbAxZ6Z/vuuYXtzufHNIL1bVLKDqYyjTSpwAdVDV5glLea3JYLZUiGOcuFmXe7qT+7OOOdZRJQtsGUuStYU/KCK40siMLZ1SVTAF6svJ09B8Wq7u5297iZQEEoD3nvmzsR8X3XSnTQU7RVL1J6kl4MXMWBfMsiAvkUhTC2gSG8kv80ZqnpsLE5bqGICrgXRGqb+NdU8kmfe3wbd3gZK4jIIerF2W7MyurH2BA74e8VEaOpy9ZcYiE5OGf/NgMZOPPunLVovNsCvxY5JFMFN+hiFf+H9PAyedX0M8QMgf8QDwlSNqiKn+Vm1G3NoOv5znfdVcCKs4vlU2kVuMoPjg5biPu9+dV8P279NKHKTAEMbJIKuaNSjtzbT2jXu3BOCIjs9NhSAI17+zW+cMIn5vD2H/xxJZDFjsEhS00HU/+LVkQEW+m6WCeFTRwdeWMWUdMj/SxUp5BuQ==;5:4Sm+cuEaA4JozzDewp1GnmUkInpT9S7TEmrsML2ciCQodbO2BWKmQhFh/81PWWKhQCFxc4ESq11PyFjbUeM1xaz9wvKY9VuK2iN4deGz5NWUIu75Cwy9ukD6U8Rcktji0ogzWveBuGeIWwp5nXprfCpRHQwWTmd+J/wiEXli/kU=;7:RIDORkodpm6HGUXsBgScWeXdzCEprAxTLw5O4cMckb9N/F+X9UMqgNpj0MeIZ/HZG90Nx50UaeTvBvc3x2l9TKX8Cto1VRKnuNTUvqO7X0Z9+wYAGaLY6baISpky3icyoth6Vg4mydeRInNogvHBFMbQTC+rZb6phV3lOZXuI0+Myq3ei0FiKIcRjL3a5CVHxJ9mEpveKJjjWHyxhWMePjTM9+8dhURC9n93+VH4E1WTtYVds+r6c2xAsBsQy+27
x-ms-office365-filtering-correlation-id: fd9dabd8-2a6d-4579-5fc7-08d61368fbf0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0793;
x-ms-traffictypediagnostic: DM5PR21MB0793:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB07938CFCA3FB1C5507325B4D9D020@DM5PR21MB0793.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0793;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0793;
x-forefront-prvs: 078693968A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(189003)(2900100001)(36756003)(7736002)(31696002)(305945005)(7406005)(86362001)(86612001)(256004)(14444005)(76176011)(966005)(14454004)(31686004)(5250100002)(72206003)(105586002)(99286004)(106356001)(10090500001)(22452003)(478600001)(110136005)(54906003)(316002)(10290500003)(7416002)(68736007)(4326008)(229853002)(81156014)(81166006)(8936002)(66066001)(2906002)(25786009)(5660300001)(486006)(6246003)(6436002)(446003)(11346002)(6486002)(476003)(2616005)(53936002)(6512007)(39060400002)(6306002)(102836004)(6116002)(186003)(8676002)(97736004)(53546011)(6506007)(26005)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0793;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FSXdB4ySJ70lsHUtHa/nfhoOi4c/SWDMXpHlFMH7vaF61ePN1DZ6IUqP1YR5KvD/aVp1FUHZQdp0B1BFDJQu12oeANpPxACYrkHsIlDPXOXG5JWgC2Ty/8Y18InXAFqA67+ESxO95FMFPL2OAbVmk0b9disz+Evoi3wUGYBX9T2ceB48loDT5TwIkExLSb1jLAhF0BaF8fvOblu2He7yZUz+NESoP/Hf+Z+MsOcExIUqHqNUE7PnkofNyBW5f0yCuY1rOXV1uw+vdfv5YnJz2dPldvS/o6KUixnl05I14RFQ/Yi1KUeu/baG3izTRjq9LjYTUDyG5EcvGnQvC7jxF/NdjgjXpR+RaBYB/yAmTUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F73FBD97B54F4C4FB21EF65E7C1052EA@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9dabd8-2a6d-4579-5fc7-08d61368fbf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2018 19:51:34.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0793
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvNS8xOCAyOjM4IEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBPbiBUdWUsIFNl
cCAwNCwgMjAxOCBhdCAwNToyODoxM1BNIC0wNDAwLCBEYW5pZWwgSm9yZGFuIHdyb3RlOg0KPj4g
UGF2ZWwgVGF0YXNoaW4sIFlpbmcgSHVhbmcsIGFuZCBJIGFyZSBleGNpdGVkIHRvIGJlIG9yZ2Fu
aXppbmcgYSBwZXJmb3JtYW5jZSBhbmQgc2NhbGFiaWxpdHkgbWljcm9jb25mZXJlbmNlIHRoaXMg
eWVhciBhdCBQbHVtYmVyc1sqXSwgd2hpY2ggaXMgaGFwcGVuaW5nIGluIFZhbmNvdXZlciB0aGlz
IHllYXIuICBUaGUgbWljcm9jb25mZXJlbmNlIGlzIHNjaGVkdWxlZCBmb3IgdGhlIG1vcm5pbmcg
b2YgdGhlIHNlY29uZCBkYXkgKFdlZCwgTm92IDE0KS4NCj4+DQo+PiBXZSBoYXZlIGEgcHJlbGlt
aW5hcnkgYWdlbmRhIGFuZCBhIGxpc3Qgb2YgY29uZmlybWVkIGFuZCBpbnRlcmVzdGVkIGF0dGVu
ZGVlcyAoY2MnZWQpLCBhbmQgYXJlIHNlZWtpbmcgbW9yZSBvZiBib3RoIQ0KPj4NCj4+IFNvbWUg
b2YgdGhlIGl0ZW1zIG9uIHRoZSBhZ2VuZGEgYXMgaXQgc3RhbmRzIG5vdyBhcmU6DQo+Pg0KPj4g
IC0gUHJvbW90aW5nIGh1Z2UgcGFnZSB1c2FnZTogIFdpdGggbWVtb3J5IHNpemVzIGJlY29taW5n
IGV2ZXIgbGFyZ2VyLCBodWdlIHBhZ2VzIGFyZSBiZWNvbWluZyBtb3JlIGFuZCBtb3JlIGltcG9y
dGFudCB0byByZWR1Y2UgVExCIG1pc3NlcyBhbmQgdGhlIG92ZXJoZWFkIG9mIG1lbW9yeSBtYW5h
Z2VtZW50IGl0c2VsZi0tdGhhdCBpcywgdG8gbWFrZSB0aGUgc3lzdGVtIHNjYWxhYmxlIHdpdGgg
dGhlIG1lbW9yeSBzaXplLiAgQnV0IHRoZXJlIGFyZSBzdGlsbCBzb21lIHJlbWFpbmluZyBnYXBz
IHRoYXQgcHJldmVudCBodWdlIHBhZ2VzIGZyb20gYmVpbmcgZGVwbG95ZWQgaW4gc29tZSBzaXR1
YXRpb25zLCBzdWNoIGFzIGh1Z2UgcGFnZSBhbGxvY2F0aW9uIGxhdGVuY3kgYW5kIG1lbW9yeSBm
cmFnbWVudGF0aW9uLg0KPj4NCj4+ICAtIFJlZHVjaW5nIHRoZSBudW1iZXIgb2YgdXNlcnMgb2Yg
bW1hcF9zZW06ICBUaGlzIHNlbWFwaG9yZSBpcyBmcmVxdWVudGx5IHVzZWQgdGhyb3VnaG91dCB0
aGUga2VybmVsLiAgSW4gb3JkZXIgdG8gZmFjaWxpdGF0ZSBzY2FsaW5nIHRoaXMgbG9uZ3N0YW5k
aW5nIGJvdHRsZW5lY2ssIHRoZXNlIHVzZXMgc2hvdWxkIGJlIGRvY3VtZW50ZWQgYW5kIHVubmVj
ZXNzYXJ5IHVzZXJzIHNob3VsZCBiZSBmaXhlZC4NCj4+DQo+PiAgLSBQYXJhbGxlbGl6aW5nIGNw
dS1pbnRlbnNpdmUga2VybmVsIHdvcms6ICBSZXNvbHZlIHByb2JsZW1zIG9mIHBhc3QgYXBwcm9h
Y2hlcyBpbmNsdWRpbmcgZXh0cmEgdGhyZWFkcyBpbnRlcmZlcmluZyB3aXRoIG90aGVyIHByb2Nl
c3NlcywgcGxheWluZyB3ZWxsIHdpdGggcG93ZXIgbWFuYWdlbWVudCwgYW5kIHByb3BlciBjZ3Jv
dXAgYWNjb3VudGluZyBmb3IgdGhlIGV4dHJhIHRocmVhZHMuICBCb251cyB0b3BpYzogcHJvcGVy
IGFjY291bnRpbmcgb2Ygd29ya3F1ZXVlIHRocmVhZHMgcnVubmluZyBvbiBiZWhhbGYgb2YgY2dy
b3Vwcy4NCj4+DQo+PiAgLSBQcmVzZXJ2aW5nIHVzZXJsYW5kIGR1cmluZyBrZXhlYyB3aXRoIGEg
aGliZXJuYXRpb24tbGlrZSBtZWNoYW5pc20uDQo+IA0KPiBKdXN0IHNvbWUgY3JhenkgaWRlYTog
aGF2ZSB5b3UgY29uc2lkZXJlZCB1c2luZyBjaGVja3BvaW50LXJlc3RvcmUgYXMgYQ0KPiByZXBs
YWNlbWVudCBvciBhbiBhZGRpdGlvbiB0byBoaWJlcm5hdGlvbj8NCg0KSGkgTWlrZSwNCg0KWWVz
LCB0aGlzIGlzIG9uZSB3YXkgSSB3YXMgdGhpbmtpbmcgYWJvdXQsIGFuZCB1c2Uga2VybmVsIHRv
IHBhc3MgdGhlDQphcHBsaWNhdGlvbiBzdG9yZWQgc3RhdGUgdG8gbmV3IGtlcm5lbCBpbiBwbWVt
LiBUaGUgb25seSBwcm9ibGVtIGlzIHRoYXQNCndlIHdhc3RlIG1lbW9yeTogd2hlbiB0aGVyZSBp
cyBub3QgZW5vdWdoIHN5c3RlbSBtZW1vcnkgdG8gY29weSBhbmQgcGFzcw0KYXBwbGljYXRpb24g
c3RhdGUgdG8gbmV3IGtlcm5lbCB0aGlzIHNjaGVtZSB3b24ndCB3b3JrLiBUaGluayBhYm91dCBE
Qg0KdGhhdCBvY2N1cGllcyA4MCUgb2Ygc3lzdGVtIG1lbW9yeSBhbmQgd2Ugd2FudCB0byBjaGVj
a3BvaW50L3Jlc3RvcmUgaXQuDQoNClNvLCB3ZSBuZWVkIHRvIGhhdmUgYW5vdGhlciB3YXksIHdo
ZXJlIHRoZSBwcmVzZXJ2ZWQgbWVtb3J5IGlzIHRoZQ0KbWVtb3J5IHRoYXQgaXMgYWN0dWFsbHkg
dXNlZCBieSB0aGUgYXBwbGljYXRpb25zLCBub3QgY29waWVkLiBPbmUgZWFzeQ0Kd2F5IGlzIHRv
IGdpdmUgZWFjaCBhcHBsaWNhdGlvbiB0aGF0IGhhcyBhIGxhcmdlIHN0YXRlIHRoYXQgaXMgZXhw
ZW5zaXZlDQp0byByZWNyZWF0ZSBhIHBlcnNpc3RlbnQgbWVtb3J5IGRldmljZSBhbmQgbGV0IGFw
cGxpY2F0aW9ucyB0byBrZWVwIGl0cw0Kc3RhdGUgb24gdGhhdCBkZXZpY2UgKHNheSAvZGV2L3Bt
ZW1OKS4gVGhlIG9ubHkgcHJvYmxlbSBpcyB0aGF0IG1lbW9yeQ0Kb24gdGhhdCBkZXZpY2UgbXVz
dCBiZSBhY2Nlc3NpYmxlIGp1c3QgYXMgZmFzdCBhcyByZWd1bGFyIG1lbW9yeSB3aXRob3V0DQph
bnkgZmlsZSBzeXN0ZW0gb3ZlcmhlYWQgYW5kIGhvcGVmdWxseSB3aXRob3V0IG5lZWQgZm9yIERB
WC4NCg0KSSBqdXN0IHdhbnQgdG8gZ2V0IHNvbWUgaWRlYXMgb2Ygd2hhdCBwZW9wbGUgYXJlIHRo
aW5raW5nIGFib3V0IHRoaXMsDQphbmQgd2hhdCB3b3VsZCBiZSB0aGUgYmVzdCB3YXkgdG8gYWNo
aWV2ZSBpdC4NCg0KUGF2ZWwNCg0KDQo+ICANCj4+IFRoZXNlIGNlbnRlciBhcm91bmQgb3VyIGlu
dGVyZXN0cywgYnV0IGhhdmluZyBsb3RzIG9mIHRvcGljcyB0byBjaG9vc2UgZnJvbSBlbnN1cmVz
IHdlIGNvdmVyIHdoYXQncyBtb3N0IGltcG9ydGFudCB0byB0aGUgY29tbXVuaXR5LCBzbyB3ZSB3
b3VsZCBsaWtlIHRvIGhlYXIgYWJvdXQgYWRkaXRpb25hbCB0b3BpY3MgYW5kIGV4dGVuc2lvbnMg
dG8gdGhvc2UgbGlzdGVkIGhlcmUuICBUaGlzIGluY2x1ZGVzLCBidXQgaXMgY2VydGFpbmx5IG5v
dCBsaW1pdGVkIHRvLCB3b3JrIGluIHByb2dyZXNzIHRoYXQgd291bGQgYmVuZWZpdCBmcm9tIGlu
LXBlcnNvbiBkaXNjdXNzaW9uLCByZWFsLXdvcmxkIHBlcmZvcm1hbmNlIHByb2JsZW1zLCBhbmQg
ZXhwZXJpbWVudGFsIGFuZCBhY2FkZW1pYyB3b3JrLg0KPj4NCj4+IElmIHlvdSBoYXZlbid0IGFs
cmVhZHkgZG9uZSBzbywgcGxlYXNlIGxldCB1cyBrbm93IGlmIHlvdSBhcmUgaW50ZXJlc3RlZCBp
biBhdHRlbmRpbmcsIG9yIGhhdmUgc3VnZ2VzdGlvbnMgZm9yIG90aGVyIGF0dGVuZGVlcy4NCj4+
DQo+PiBUaGFua3MsDQo+PiBEYW5pZWwNCj4+DQo+PiBbKl0gaHR0cHM6Ly9ibG9nLmxpbnV4cGx1
bWJlcnNjb25mLm9yZy8yMDE4L3BlcmZvcm1hbmNlLW1jLw0KPj4NCj4g
