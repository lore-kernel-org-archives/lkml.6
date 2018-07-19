Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F4820856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lq72wJyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F4820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeGSKOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:14:02 -0400
Received: from mail-pu1apc01on0103.outbound.protection.outlook.com ([104.47.126.103]:48916
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727345AbeGSKOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQBLtnJvP1k1eKTianLZ0gxX33HscB0S2TK5pj3BLpA=;
 b=Lq72wJyzYmq/CxwJyK0VQwqUZ1vkSffARZYYUf7e0OPUK5KD/+ZiqiDlZa15+1pHtaRR+ZxT1XkFHt0VoaVrynV3gSnEu7qx6nrJbmKfSRQreUqSIMef32q/4rDV9PU+9Nzz5BW6hW25iYflhQNjx6cTdH372hMbesoBS9rXq9Q=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0094.APCP153.PROD.OUTLOOK.COM (10.170.136.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.10; Thu, 19 Jul 2018 09:31:33 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.0995.008; Thu, 19 Jul 2018
 09:31:33 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Topic: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Index: AQHUHzwUffUmbGD3SUGBq0C4VrI5YKSWPqIAgAAJagA=
Date:   Thu, 19 Jul 2018 09:31:33 +0000
Message-ID: <b80dd1a7-b326-5289-4509-5001b3e42273@microsoft.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
 <70536ba6-fe2e-04ae-7055-e1eef4e87c64@redhat.com>
In-Reply-To: <70536ba6-fe2e-04ae-7055-e1eef4e87c64@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0094;6:NFTbI7hX9N5QVqXM6AcKZ7w9Z3bAxouKhCIuh5s6UbfkkAltc23a1hjvspBw023lmFKbKDPt/OSFUNYe4gvKsc+uzBBzZZ/srvQ2mGgUA580jyEUnvCfUD+R2F7KjPdzDgPOUsTd60DXaM2Ngr4+jXXG/48VY5x6TA8KaJYqQACS8unMc2i1VXhH+rUEUJhrJksNFMX+jxRUjNzu1tD77IOclghXyuB8jHFiIX/DlmeqVNU0ozB+J5WR+caYHOwoPbhWzb0cSEJQF1utZrV4qOJx8YRza5iIuMEyhkXAJAVJ/ZLPm5pNIr2y9S1WLWI3xqQWKmiI+b7Cap/QIgOSgKAvxMikmzHpZKyvMkICAyCyWQ0Gz2vhjCu76SaUOkSxIFL1xk0x6C4qcuL6RWJkT1gMRJrTScQ0tW3OnavPz+sUNiDXQKUkIoUnxW7xR8VSLMSd0GGgsqIqcIMfwGv5cw==;5:2OQmastym/Ap58OpJyd/6q171D73/oLjsT5LPlyse/wfudmmsH217ltDK4ZCjoHBB/BMYkLEia2DzWCpG3TmIuRlSpH7nofoTHLoDIPQrrd+RJTyrkWjhyZi1Bo9C7Vvnivd8CsJJksxD1hj8XqC4Pwn4uWxRvlXMMU8+zKlfn0=;7:wXlOZaPL5vIcAjCV8CZ/pU2KPeYqIu7wdLMIPieEtk4EaD/WZ6IXRWUVbG7xKLsKbYIrX6RlBzBQi1Dpnm2sKx/V3pn9gOV86FXm1tiv+xVJLb4GpGG337hJGP7k6Bcw57LllBQBbkAl/pFTBxjAF6i3QKD9BYvpG6gVEXM7SV394wFnGvScbYisyl6L//y7i5Tq1qkroeVDlI04Aieem8x9ICHVg84CbFxrfwZ8AdsgNqBOoS5lZgQTxiwa8jE7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5bd97de1-583a-4646-816a-08d5ed5a6ae6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7193020);SRVR:SG2P15301MB0094;
x-ms-traffictypediagnostic: SG2P15301MB0094:
x-microsoft-antispam-prvs: <SG2P15301MB00948B97259104F5B74CB30E92520@SG2P15301MB0094.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0094;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0094;
x-forefront-prvs: 0738AF4208
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(7416002)(110136005)(54906003)(316002)(22452003)(36756003)(5660300001)(76176011)(106356001)(25786009)(10290500003)(105586002)(10090500001)(66066001)(1511001)(186003)(5250100002)(26005)(305945005)(7736002)(53546011)(8676002)(102836004)(86362001)(72206003)(256004)(2906002)(68736007)(8936002)(6506007)(53936002)(229853002)(4326008)(31686004)(81156014)(81166006)(31696002)(86612001)(6246003)(14454004)(99286004)(3846002)(6116002)(97736004)(446003)(486006)(6436002)(478600001)(2616005)(11346002)(476003)(6486002)(6512007)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0094;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 31H2Ukync8ciGw9qySwlhUE+aY7XhS3FEcbzSmimtpo/YLirqpEFRFbnWBAsmamRjofl0rxdPLwIS59wIVJZ30r3XsI+l7LH0KnNepPm5OA897a1nZwA+zloD/fJgNwR/qCAreBIyRx4CoX7ROSwJU/Dfzyg440e5LFDTnGa3/XHq9oTenegtz2RzoWpWf8Q6H10ipxPfOcrZTQFr6vI8e0ShlhQOFYynE05HDjZhZzxRP8esGe9b1LuCn+5Qd/SRKlk3Ko5sOLFb4GliVG5yMQMOb/Y6QCcsjGovXQqkLHlnayWReb6SmzwVhAOlgA58gBZWT63JVMoMolC7BEx0tM36IjZonXIEOagDkO69QE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <49E2B9F77D1E2F41A6EE837556EA67C4@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd97de1-583a-4646-816a-08d5ed5a6ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2018 09:31:33.4390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xOS8yMDE4IDQ6NTcgUE0sIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IE9uIDE5LzA3LzIw
MTggMTA6MzksIFRpYW55dSBMYW4gd3JvdGU6DQo+PiBIeXBlci1WIHByb3ZpZGVzIGEgcGFyYS12
aXJ0dWFsaXphdGlvbiBoeXBlcmNhbGwgSHZGbHVzaEd1ZXN0UGh5c2ljYWxBZGRyZXNzU3BhY2UN
Cj4+IHRvIGZsdXNoIG5lc3RlZCBWTSBhZGRyZXNzIHNwYWNlIG1hcHBpbmcgaW4gbDEgaHlwZXJ2
aXNvciBhbmQgaXQncyB0byByZWR1Y2Ugb3ZlcmhlYWQNCj4+IG9mIGZsdXNoaW5nIGVwdCB0bGIg
YW1vbmcgdmNwdXMuIFRoZSB0cmFkaXRpb24gd2F5IGlzIHRvIHNlbmQgSVBJcyB0byBhbGwgYWZm
ZWN0ZWQNCj4+IHZjcHVzIGFuZCBleGVjdXRlcyBJTlZFUFQgb24gZWFjaCB2Y3B1cy4gSXQgd2ls
bCB0cmlnZ2VyIHNldmVyYWwgdm1leGl0cyBmb3IgSVBJIGFuZA0KPj4gSU5WRVBUIGVtdWxhdGlv
bi4gVGhlIHB2IGh5cGVyY2FsbCBjYW4gaGVscCB0byBmbHVzaCBzcGVjaWZpZWQgZXB0IHRhYmxl
IG9uIGFsbCB2Y3B1cw0KPj4gdmlhIG9uZSBzaW5nbGUgaHlwZXJjYWxsLg0KPiANCj4gVGhhbmtz
LCB0aGlzIGxvb2tzIGdvb2QgYXBhcnQgZnJvbSBhIGdsb2JhbCByZXBsYWNlIG9mIEVGQVVMVCB3
aXRoDQo+IEVOT1RTVVAgKHdoaWNoIGNhbiBiZSBkb25lIHdoZW4gYXBwbHlpbmcpLiAgQ2FuIEkg
aGF2ZSBhbiBleHBsaWNpdCBhY2sNCj4gZm9yIHBhdGNoZXMgMSBhbmQgMiBmcm9tIHRoZSBIeXBl
ci1WIHBlb3BsZT8NCg0KVGhhbmtzLCBQYW9sby4gSSB3aWxsIHRyeSB0byBoeXBlci1WIHBlb3Bs
ZSdzIGFjay4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gUGFvbG8NCj4gDQo+PiBDaGFuZ2Ugc2lu
Y2UgdjI6DQo+PiAgICAgICAgIC0gTWFrZSBlcHRfcG9pbnRlcnNfbWF0Y2ggYXMgdHJpc3RhdGUg
ImNoZWNrIiwgIm1hdGNoIiBhbmQgIm1pc21hdGNoIi4NCj4+ICAgICAgICAgU2V0ICJjaGVjayIg
aW4gdm14X3NldF9jcjMoKSwgY2hlY2sgYWxsIGVwdCB0YWJsZSBwb2ludGVycyBpbiBodl9yZW1v
dGVfZmx1c2hfdGxiKCkNCj4+ICAgICAgICAgYW5kIGNhbGwgaHlwZXJjYWxsIHdoZW4gYWxsIGVw
dCBwb2ludGVycyBhcmUgc2FtZS4NCj4+ICAgICAgICAgLSBSZW5hbWUga3ZtX2FyY2hfaHZfZmx1
c2hfcmVtb3RlX3RsYiB3aXRoIGt2bV9hcmNoX2ZsdXNoX3JlbW90ZV90bGIgYW5kDQo+PiAgICAg
ICAgIFJlbmFtZSBrdm1feDg2X29wcy0+aHZfdGxiX3JlbW90ZV9mbHVzaCB3aXRoIGt2bV94ODZf
b3BzLT50bGJfcmVtb3RlX2ZsdXNoDQo+PiAgICAgICAgIC0gRml4IGlzc3VlIHRoYXQgaWdub3Jl
IHVwZGF0aW5nIHRsYnNfZGlydHkgZHVyaW5nIGNhbGxpbmcga3ZtX2FyY2hfZmx1c2hfcmVtb3Rl
X3RsYnMoKQ0KPj4gICAgICAgICAtIE1lcmdlIHBhdGNoICJLVk0vVk1YOiBBZGQgaWRlbnRpY2Fs
IGVwdCB0YWJsZSBwb2ludGVyIGNoZWNrIiBhbmQNCj4+ICAgICAgICAgcGF0Y2ggIktWTS94ODY6
IEFkZCB0bGJfcmVtb3RlX2ZsdXNoIGNhbGxiYWNrIHN1cHBvcnQgZm9yIHZteCINCj4+DQo+PiBD
aGFuZ2Ugc2luY2UgdjE6DQo+PiAgICAgICAgIC0gRml4IGNvbXBpbGF0aW9uIGVycm9yIGZvciBu
b24teDg2IHBsYXRmb3JtLg0KPj4gICAgICAgICAtIFVzZSBlcHRfcG9pbnRlcnNfbWF0Y2ggdG8g
Y2hlY2sgY29uZGl0aW9uIG9mIGlkZW50aWNhbCBlcHQNCj4+ICAgICAgICAgICAgICB0YWJsZSBw
b2ludGVyIGFuZCBnZXQgZXB0IHBvaW50ZXIgZnJvbSBzdHJ1Y3QgdmNwdV92bXgtPmVwdF9wb2lu
dGVyLg0KPj4gICAgICAgICAtIEFkZCBoeXBlcnZfbmVzdGVkX2ZsdXNoX2d1ZXN0X21hcHBpbmcg
ZnRyYWNlIHN1cHBvcnQNCj4+IAkJDQo+Pg0KPj4NCj4+IExhbiBUaWFueXUgKDQpOg0KPj4gICAg
WDg2L0h5cGVyLVY6IEFkZCBmbHVzaCBIdkZsdXNoR3Vlc3RQaHlzaWNhbEFkZHJlc3NTcGFjZSBo
eXBlcmNhbGwNCj4+ICAgICAgc3VwcG9ydA0KPj4gICAgWDg2L0h5cGVyLVY6IEFkZCBoeXBlcnZf
bmVzdGVkX2ZsdXNoX2d1ZXN0X21hcHBpbmcgZnRyYWNlIHN1cHBvcnQNCj4+ICAgIEtWTTogQWRk
IHRsYiByZW1vdGUgZmx1c2ggY2FsbGJhY2sgaW4ga3ZtX3g4Nl9vcHMuDQo+PiAgICBLVk0veDg2
OiBBZGQgdGxiX3JlbW90ZV9mbHVzaCBjYWxsYmFjayBzdXBwb3J0IGZvciB2bXgNCj4+DQo+PiAg
IGFyY2gveDg2L2h5cGVydi9NYWtlZmlsZSAgICAgICAgICAgIHwgIDIgKy0NCj4+ICAgYXJjaC94
ODYvaHlwZXJ2L25lc3RlZC5jICAgICAgICAgICAgfCA2NyArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+PiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmggIHwg
IDggKysrKysNCj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCAgICAgfCAxMSAr
KysrKysNCj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCAgICAgfCAgMiArKw0K
Pj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90cmFjZS9oeXBlcnYuaCB8IDE0ICsrKysrKysrDQo+
PiAgIGFyY2gveDg2L2t2bS92bXguYyAgICAgICAgICAgICAgICAgIHwgNzIgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gICBpbmNsdWRlL2xpbnV4L2t2bV9ob3N0Lmgg
ICAgICAgICAgICB8ICA3ICsrKysNCj4+ICAgdmlydC9rdm0va3ZtX21haW4uYyAgICAgICAgICAg
ICAgICAgfCAgMyArLQ0KPj4gICA5IGZpbGVzIGNoYW5nZWQsIDE4MyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYvaHlwZXJ2L25l
c3RlZC5jDQo+Pg0KPiA=
