Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B346ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED352075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X5O9R/gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED352075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeGROEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:04:00 -0400
Received: from mail-hk2apc01on0131.outbound.protection.outlook.com ([104.47.124.131]:41677
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeGROEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzvv2p+Aa92+tdc76VcRbkCxW8POSw2670Vxwm+Lil0=;
 b=X5O9R/gT5T5SvY3OJPivhaTvR8/gHjVwGzV55eFbkm0TT7baIX8NkpY4zbZ7Hygp7uVsnYmzCxp4xGco4fBgqc7JewQ0PtV8lKtH/wzZmfVtXT6HcqFt+cCmVniO/r66QNHkYLfzV7HUvZ0mNFPV/geB68gjJO4UHn5gznOWa80=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0080.APCP153.PROD.OUTLOOK.COM (10.170.136.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.6; Wed, 18 Jul 2018 13:25:44 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0995.008; Wed, 18 Jul 2018
 13:25:44 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH V2 2/5] KVM: Add tlb remote flush callback in kvm_x86_ops.
Thread-Topic: [PATCH V2 2/5] KVM: Add tlb remote flush callback in
 kvm_x86_ops.
Thread-Index: AQHUF2OX1I0JhtR1E0WteDVCqvbbq6SU72kAgAAXbAA=
Date:   Wed, 18 Jul 2018 13:25:44 +0000
Message-ID: <fcce0753-a51a-aa47-d0df-053f0a355410@microsoft.com>
References: <20180709090218.15342-1-Tianyu.Lan@microsoft.com>
 <20180709090218.15342-3-Tianyu.Lan@microsoft.com>
 <3b2a6c3c-ba73-1c34-248f-f5d40c691b58@redhat.com>
In-Reply-To: <3b2a6c3c-ba73-1c34-248f-f5d40c691b58@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0080;6:WfqoL77zJDLuxpKbJOF86kLloV4gCFAg3N3pIAJY2LYyc4Yeg1yLwKlA/vWWQvPkJTuQkpIIXiqdq1/RRhj1cObCLV6M+UaMIlQfdgALkMbEXKIccs9r66v0Xs2h8HRdDXDKZ7GQr03ZPEE1PtVDrXq09D6/SbUuw6iTeQ6NbJaSrxQ9TkSYW3JWxWPIvod2A1nDxmuhZ4FThfIlo4ybdzK3CT4oLvqaiII+Bk4iZtnf5kCSUVhaY1i9yujlxf3gJDDVLj6cVPEYdZERTHzA5nka3YYt4gkE2BjGE4404+8q/UmhaYGq2GnoE1cc97jDPC3iY8UzfXOEtyrotctaMy2S9Js0lSQ4H4HfJn5L1uvvTfNYSjq5+5allf+ex5s/924I9of4uZm1Pgw+honpBi9FaiK2KJ5xcmTATnbZUt6qtVmaCJlJoPCYMlT9XZ/r1g4QYZyW9en3VQDNINkM+g==;5:L6ajUic8Y6tS9zdpf+RNTlNLc5NC0b5yb8I1uHQWRChpE9efJjz5PR0RRJuhuUbmiBTk7DMUasNfqv3ccl7KUphdzTWrPnl4m1g92mxhQXTkf3D5KgmHnD0w4Te2Lisxy79H5ESvYiX0HjIB8bDxex/XcYdKEahsqgBeLSxxZUQ=;7:405aw/LvAGx5Z117qWhx6TJ3DOnJR5AO3RiCPjI3J7nA5XOq+gK8bPrywZJSGp5y2sFdpwwgJQ/tykSJJRUSHj6f9FKpb9o71kXWf/a3wx60Fdfje8QUq/YPg4lbjP/DjAN17paXLL8ojeoxErdc1AedNYpF9Oyzc0kjDhdXjPpX9tE+nTszWVzmogRvKwAn76eBoAFpWdpvJrohtd9wG8VSpOXDKHToTPHFFFHOGoV8zXMoh/WGvcphvUqDFDH7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4ab4f365-f8b8-41d3-6bd5-08d5ecb1f785
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0080;
x-ms-traffictypediagnostic: SG2P15301MB0080:
x-microsoft-antispam-prvs: <SG2P15301MB00803A79F514C67C7FA4B3E692530@SG2P15301MB0080.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0080;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0080;
x-forefront-prvs: 0737B96801
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(229853002)(6512007)(1511001)(8676002)(6436002)(22452003)(305945005)(6486002)(81156014)(8936002)(7736002)(316002)(6116002)(66066001)(3846002)(54906003)(81166006)(105586002)(2906002)(7416002)(5250100002)(31686004)(106356001)(2900100001)(476003)(2616005)(110136005)(14454004)(5660300001)(97736004)(10090500001)(53936002)(11346002)(25786009)(99286004)(36756003)(68736007)(6246003)(4326008)(72206003)(446003)(486006)(10290500003)(478600001)(53546011)(102836004)(256004)(186003)(14444005)(76176011)(31696002)(86612001)(86362001)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0080;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FyvM7AQVSSeQkf+GLMu8myOed5HbmhQgP0lu2YYzRvzJEqqyf1ESytTOyKfQ04hXI1xjPjs0DIKvVkydqvoHYQGxv0lci0ihP5VO8mj5Tu/7f18OCDOW6vwmIHmeZW8p84dwKOn6AKgl6JkcBawB4baA0ZsYo9gqqV6mjzKsYF8txlCoTbigB4lpvbis5r4hKF32qc9jL4inKerHdiPJn+ZfE6x+shKPXD/Tlm7DEKBn4lrTE3bZHkQWRZEuC+0RqOKqf4k5UCAFtaO+MakNFEGLxO3EWsVyqt80uqaObQ/QUeDZzOgGRpQfennXl6XUWHeHKv3mviwZJg2qiIhdTmpD8NFuMA9yZKbvRdcAjkQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8420AB191C2BF4C8474F7AE193B867F@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab4f365-f8b8-41d3-6bd5-08d5ecb1f785
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2018 13:25:44.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGFvbG86DQoJVGhhbmtzIGZvciByZXZpZXcuDQoNCk9uIDcvMTgvMjAxOCA4OjAxIFBNLCBQ
YW9sbyBCb256aW5pIHdyb3RlOg0KPiBPbiAwOS8wNy8yMDE4IDExOjAyLCBUaWFueXUgTGFuIHdy
b3RlOg0KPj4gKwkvKg0KPj4gKwkgKiBDYWxsIGt2bV9hcmNoX2h2X3RsYl9yZW1vdGUgZmlyc3Qg
YW5kIGdvIGJhY2sgb2xkIHdheSB3aGVuDQo+PiArCSAqIHJldHVybiBmYWlsdXJlLg0KPj4gKwkg
Ki8NCj4+ICsJaWYgKCFrdm1fYXJjaF9odl9mbHVzaF9yZW1vdGVfdGxiKGt2bSkpDQo+PiArCQly
ZXR1cm47DQo+PiArDQo+PiAgIAkvKg0KPj4gICAJICogUmVhZCB0bGJzX2RpcnR5IGJlZm9yZSBz
ZXR0aW5nIEtWTV9SRVFfVExCX0ZMVVNIIGluDQo+PiAgIAkgKiBrdm1fbWFrZV9hbGxfY3B1c19y
ZXF1ZXN0Lg0KPj4gICAJICovDQo+PiAtCWxvbmcgZGlydHlfY291bnQgPSBzbXBfbG9hZF9hY3F1
aXJlKCZrdm0tPnRsYnNfZGlydHkpOw0KPj4gKwlkaXJ0eV9jb3VudCA9IHNtcF9sb2FkX2FjcXVp
cmUoJmt2bS0+dGxic19kaXJ0eSk7DQo+IA0KPiBBbHNvLCB0aGUgY2FsbCB0byBrdm1fYXJjaF9m
bHVzaF9yZW1vdGVfdGxicyBzaG91bGQgbm90IHJlcGxhY2UgdGhlDQo+IHdob2xlIGZ1bmN0aW9u
LiAgSXQgc2hvdWxkIGJlIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gICAgICAgICAgbG9uZyBkaXJ0
eV9jb3VudCA9IHNtcF9sb2FkX2FjcXVpcmUoJmt2bS0+dGxic19kaXJ0eSk7DQo+IA0KPiAgICAg
ICAgICAvKg0KPiAgICAgICAgICAgKiBXZSB3YW50IHRvIHB1Ymxpc2ggbW9kaWZpY2F0aW9ucyB0
byB0aGUgcGFnZSB0YWJsZXMgYmVmb3JlIHJlYWRpbmcNCj4gICAgICAgICAgICogbW9kZS4gUGFp
cnMgd2l0aCBhIG1lbW9yeSBiYXJyaWVyIGluIGFyY2gtc3BlY2lmaWMgY29kZS4NCj4gICAgICAg
ICAgICogLSB4ODY6IHNtcF9tYl9fYWZ0ZXJfc3JjdV9yZWFkX3VubG9jayBpbiB2Y3B1X2VudGVy
X2d1ZXN0DQo+ICAgICAgICAgICAqIGFuZCBzbXBfbWIgaW4gd2Fsa19zaGFkb3dfcGFnZV9sb2Nr
bGVzc19iZWdpbi9lbmQuDQo+ICAgICAgICAgICAqIC0gcG93ZXJwYzogc21wX21iIGluIGt2bXBw
Y19wcmVwYXJlX3RvX2VudGVyLg0KPiAgICAgICAgICAgKg0KPiAgICAgICAgICAgKiBUaGVyZSBp
cyBhbHJlYWR5IGFuIHNtcF9tYl9fYWZ0ZXJfYXRvbWljKCkgYmVmb3JlDQo+ICAgICAgICAgICAq
IGt2bV9tYWtlX2FsbF9jcHVzX3JlcXVlc3QoKSByZWFkcyB2Y3B1LT5tb2RlLiBXZSByZXVzZSB0
aGF0DQo+ICAgICAgICAgICAqIGJhcnJpZXIgaGVyZS4NCj4gICAgICAgICAgICovDQo+ICAgICAg
ICAgIGlmICgha3ZtX2FyY2hfaHZfZmx1c2hfcmVtb3RlX3RsYihrdm0pIHx8DQo+IAkgICAga3Zt
X21ha2VfYWxsX2NwdXNfcmVxdWVzdChrdm0sIEtWTV9SRVFfVExCX0ZMVVNIKSkNCj4gICAgICAg
ICAgICAgICAgICArK2t2bS0+c3RhdC5yZW1vdGVfdGxiX2ZsdXNoOw0KPiAgICAgICAgICBjbXB4
Y2hnKCZrdm0tPnRsYnNfZGlydHksIGRpcnR5X2NvdW50LCAwKTsNCj4gDQo+IE90aGVyd2lzZSwg
a3ZtX21tdV9ub3RpZmllcl9pbnZhbGlkYXRlX3JhbmdlX3N0YXJ0IHdpbGwgaW5jb3JyZWN0bHkg
c2tpcA0KPiBhIFRMQiBmbHVzaC4NCg0KTmljZSBjYXRjaC4gV2lsbCB1cGRhdGUgaW4gdGhlIG5l
eHQgdmVyc2lvbi4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gUGFvbG8NCj4g
