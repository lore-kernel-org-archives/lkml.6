Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848A320779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iuBiD0Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848A320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbeGWIw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:52:27 -0400
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:12200
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387954AbeGWIw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5fiCHwzSP6vCOe778fnBryw1q6gyRk8ixvz48hHVbE=;
 b=iuBiD0HzanePS4U/rw6k2DgqfT8I9OL3hdoAziGDiunQcgkZcmNXIWxSZnCsmmq4lDki7z2IHZKmUVH7iyQHPvb1rIvnt9sB2BO3wF/Ex3nIVBjePNN5n4M5uLwYyMlBLERZuOEsmDhAI8Ij0vnOSfHP4cRSqZK70Biak5zWMMY=
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM (10.170.136.145) by
 SG2P15301MB0061.APCP153.PROD.OUTLOOK.COM (10.170.136.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.1; Mon, 23 Jul 2018 07:52:21 +0000
Received: from SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25]) by SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM
 ([fe80::f916:a637:8730:be25%4]) with mapi id 15.20.1017.000; Mon, 23 Jul 2018
 07:52:21 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
To:     Wanpeng Li <kernellwp@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Topic: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
Thread-Index: AQHUHzwUffUmbGD3SUGBq0C4VrI5YKSXfQNAgABMoYCABKiMgIAAA3eA
Date:   Mon, 23 Jul 2018 07:52:20 +0000
Message-ID: <0af7858c-d964-224b-6478-b16708cea475@microsoft.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1113BF48AF4E3802CC29A10EA0510@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <a51f8e18-5592-5dbd-87e2-9cf42c1af16a@redhat.com>
 <CANRm+Cwbo5scibX4xusibb5TJZaQ_DjeY+c2bVLzGLte94Y-Lw@mail.gmail.com>
In-Reply-To: <CANRm+Cwbo5scibX4xusibb5TJZaQ_DjeY+c2bVLzGLte94Y-Lw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2P15301MB0061;6:w23TJmJduLwrKDcRc6fmlDhInjuY+3Dx51X6nLh0UockOTqvyxxNnbfexigQr8tJYVenzCmS2W0t+FlNmXtKPCVjPsocAwQfH4iUPJD2W83C840JWKfjz9W6GXdVMJbEj2WKaSrxsmI25IMwWgSHCOpvx1xpiwm7QNhH+BrnhNvC37peOtXYwXNdRNk9zf33fjY2gBEWagsRSdbk4VsPv8aNH/sMW987Kbckac2Fm0UnwBxw9Nal7nce6NKadWZdWEt9y3z86R7SPOJ01Wgnwh91/WlYbnnmJYRGG0TJ8jc1Ovwr8aFvMjRuP8vmj8/pwQL9vZos+0y92ABebjZ2JIkiD3XrtPY1t70VXl7M8NdV+xqznkiK24k0plmTueBffyI3Dz4UQoiuAf88pNPj6bIDxHEjshwxjwRklDalnGQH+haSRhaZAk/tGve/dzrCnSRJ0NZGYUZ1nDhU4V1ZSA==;5:bQBR6wSxI2vq5mP/tbrJs5dUJwmGk9jZeZyd9X/0ARREfK+DyS3UtQ4yLrLnY7O1k5offPZGxUeUsWI/S1oaS/Xx8oKpUdUcgjs4Ibi7cJ9J3Hd0GaqanzST8zFNJKUqQHRox5P5lp3+pfXKbcz++DVoHMQAyDtFnu/FiFtG8Rk=;7:/KtD2gM7YXdTVLAwVTl5cyIeTw921Y3CFY2I5UWxhUwWXV49EC14eWoAIANDBQ6tTEAuu7h0ymcIrt+rb5qDi4Ta70D/1KBqiLqD1jlSPw3qoxlD16MnujZ8BGeyoAcIzRBdDAb0lYtlYjo0In40pZsw9xfrc0xEY3WJk97gLf9wO9NHRF6TxA0FdId9dVQG9KePzBGaMK0DCJGVTX9/aqQOlWXe5WO/63dVx6R7nqL/Nibm6GktBgT6y+gJcErG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bb25fbfe-d640-4fa7-f3c5-08d5f0713898
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:SG2P15301MB0061;
x-ms-traffictypediagnostic: SG2P15301MB0061:
x-microsoft-antispam-prvs: <SG2P15301MB0061177703F03D2922B542E192560@SG2P15301MB0061.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SG2P15301MB0061;BCL:0;PCL:0;RULEID:;SRVR:SG2P15301MB0061;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(13464003)(446003)(39060400002)(2616005)(229853002)(6486002)(25786009)(10290500003)(478600001)(4326008)(53936002)(97736004)(11346002)(6246003)(72206003)(86612001)(476003)(66066001)(102836004)(31696002)(26005)(99286004)(6512007)(8936002)(81166006)(81156014)(8676002)(10090500001)(7416002)(5660300001)(6436002)(86362001)(2900100001)(486006)(105586002)(106356001)(2906002)(31686004)(3846002)(305945005)(68736007)(186003)(6116002)(7736002)(14444005)(256004)(76176011)(93886005)(14454004)(5250100002)(54906003)(36756003)(53546011)(6506007)(110136005)(316002)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2P15301MB0061;H:SG2P15301MB0093.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fpf0g1iaJOSrBDLZhJiCjJEiCuNzwY4ykHyjSxB8yTlzx2oejP6TnG8KtqQfMdbVbFRFjoIhyHkSDYmeBY38uAuZo0/O1b0dpz6rJqbBa+5B1CFdMgocBMQILSNMJK0thVx7Z3NJjEklmrgUTYrfthTCQx+Y5gSR/u4icuQuUH9CPK8hOFFH/JllZ1P/nYvdLZMB/doH3++g9uzMFDEq3vUVU7kKwqMS9FdEW+RNc+RiaUA+uUx1E96GQqg3CUSiAm0zbNsYjLWRyJtfDZw+OqPHIh6WuH+ckYIQwHAUeTkUSLeBSZumEaSmT9586laS8Lv3po5I0OypdIfY0erPBpSVRcdIEyTpdc9AT+FLlK0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <791698992A7EDA46AB156B05DC1AB0EA@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb25fbfe-d640-4fa7-f3c5-08d5f0713898
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 07:52:20.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P15301MB0061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yMy8yMDE4IDM6MzkgUE0sIFdhbnBlbmcgTGkgd3JvdGU6DQo+IE9uIEZyaSwgMjAgSnVs
IDIwMTggYXQgMTY6MzIsIFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+IHdyb3Rl
Og0KPj4NCj4+IE9uIDIwLzA3LzIwMTggMDU6NTgsIEtZIFNyaW5pdmFzYW4gd3JvdGU6DQo+Pj4N
Cj4+Pg0KPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+PiBGcm9tOiBUaWFueXUg
TGFuDQo+Pj4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDE5LCAyMDE4IDE6NDAgQU0NCj4+Pj4gQ2M6
IFRpYW55dSBMYW4gPFRpYW55dS5MYW5AbWljcm9zb2Z0LmNvbT47IGRldmVsQGxpbnV4ZHJpdmVy
cHJvamVjdC5vcmc7DQo+Pj4+IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+
OyBocGFAenl0b3IuY29tOw0KPj4+PiBrdm1Admdlci5rZXJuZWwub3JnOyBLWSBTcmluaXZhc2Fu
IDxreXNAbWljcm9zb2Z0LmNvbT47IGxpbnV4LQ0KPj4+PiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBtaW5nb0ByZWRoYXQuY29tOyBwYm9uemluaUByZWRoYXQuY29tOw0KPj4+PiBya3JjbWFyQHJl
ZGhhdC5jb207IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsNCj4+
Pj4gdGdseEBsaW51dHJvbml4LmRlOyB4ODZAa2VybmVsLm9yZzsgTWljaGFlbCBLZWxsZXkgKEVP
U0cpDQo+Pj4+IDxNaWNoYWVsLkguS2VsbGV5QG1pY3Jvc29mdC5jb20+OyB2a3V6bmV0c0ByZWRo
YXQuY29tDQo+Pj4+IFN1YmplY3Q6IFtQQVRDSCBWMyAwLzRdIEtWTS94ODYvaHlwZXItVjogSW50
cm9kdWNlIFBWIGd1ZXN0IGFkZHJlc3MNCj4+Pj4gc3BhY2UgbWFwcGluZyBmbHVzaCBzdXBwb3J0
DQo+Pj4+DQo+Pj4+IEh5cGVyLVYgcHJvdmlkZXMgYSBwYXJhLXZpcnR1YWxpemF0aW9uIGh5cGVy
Y2FsbA0KPj4+PiBIdkZsdXNoR3Vlc3RQaHlzaWNhbEFkZHJlc3NTcGFjZQ0KPj4+PiB0byBmbHVz
aCBuZXN0ZWQgVk0gYWRkcmVzcyBzcGFjZSBtYXBwaW5nIGluIGwxIGh5cGVydmlzb3IgYW5kIGl0
J3MgdG8gcmVkdWNlDQo+Pj4+IG92ZXJoZWFkDQo+Pj4+IG9mIGZsdXNoaW5nIGVwdCB0bGIgYW1v
bmcgdmNwdXMuIFRoZSB0cmFkaXRpb24gd2F5IGlzIHRvIHNlbmQgSVBJcyB0byBhbGwNCj4+Pj4g
YWZmZWN0ZWQNCj4+Pj4gdmNwdXMgYW5kIGV4ZWN1dGVzIElOVkVQVCBvbiBlYWNoIHZjcHVzLiBJ
dCB3aWxsIHRyaWdnZXIgc2V2ZXJhbCB2bWV4aXRzIGZvcg0KPj4+PiBJUEkgYW5kDQo+Pj4+IElO
VkVQVCBlbXVsYXRpb24uIFRoZSBwdiBoeXBlcmNhbGwgY2FuIGhlbHAgdG8gZmx1c2ggc3BlY2lm
aWVkIGVwdCB0YWJsZSBvbiBhbGwNCj4+Pj4gdmNwdXMNCj4+Pj4gdmlhIG9uZSBzaW5nbGUgaHlw
ZXJjYWxsLg0KPj4+Pg0KPj4+PiBDaGFuZ2Ugc2luY2UgdjI6DQo+Pj4+ICAgICAgICAgLSBNYWtl
IGVwdF9wb2ludGVyc19tYXRjaCBhcyB0cmlzdGF0ZSAiY2hlY2siLCAibWF0Y2giIGFuZCAibWlz
bWF0Y2giLg0KPj4+PiAgICAgICAgIFNldCAiY2hlY2siIGluIHZteF9zZXRfY3IzKCksIGNoZWNr
IGFsbCBlcHQgdGFibGUgcG9pbnRlcnMgaW4NCj4+Pj4gaHZfcmVtb3RlX2ZsdXNoX3RsYigpDQo+
Pj4+ICAgICAgICAgYW5kIGNhbGwgaHlwZXJjYWxsIHdoZW4gYWxsIGVwdCBwb2ludGVycyBhcmUg
c2FtZS4NCj4+Pj4gICAgICAgICAtIFJlbmFtZSBrdm1fYXJjaF9odl9mbHVzaF9yZW1vdGVfdGxi
IHdpdGgNCj4+Pj4ga3ZtX2FyY2hfZmx1c2hfcmVtb3RlX3RsYiBhbmQNCj4+Pj4gICAgICAgICBS
ZW5hbWUga3ZtX3g4Nl9vcHMtPmh2X3RsYl9yZW1vdGVfZmx1c2ggd2l0aCBrdm1feDg2X29wcy0N
Cj4+Pj4+IHRsYl9yZW1vdGVfZmx1c2gNCj4+Pj4gICAgICAgICAtIEZpeCBpc3N1ZSB0aGF0IGln
bm9yZSB1cGRhdGluZyB0bGJzX2RpcnR5IGR1cmluZyBjYWxsaW5nDQo+Pj4+IGt2bV9hcmNoX2Zs
dXNoX3JlbW90ZV90bGJzKCkNCj4+Pj4gICAgICAgICAtIE1lcmdlIHBhdGNoICJLVk0vVk1YOiBB
ZGQgaWRlbnRpY2FsIGVwdCB0YWJsZSBwb2ludGVyIGNoZWNrIiBhbmQNCj4+Pj4gICAgICAgICBw
YXRjaCAiS1ZNL3g4NjogQWRkIHRsYl9yZW1vdGVfZmx1c2ggY2FsbGJhY2sgc3VwcG9ydCBmb3Ig
dm14Ig0KPj4+Pg0KPj4+PiBDaGFuZ2Ugc2luY2UgdjE6DQo+Pj4+ICAgICAgICAgLSBGaXggY29t
cGlsYXRpb24gZXJyb3IgZm9yIG5vbi14ODYgcGxhdGZvcm0uDQo+Pj4+ICAgICAgICAgLSBVc2Ug
ZXB0X3BvaW50ZXJzX21hdGNoIHRvIGNoZWNrIGNvbmRpdGlvbiBvZiBpZGVudGljYWwgZXB0DQo+
Pj4+ICAgICAgICAgICAgICB0YWJsZSBwb2ludGVyIGFuZCBnZXQgZXB0IHBvaW50ZXIgZnJvbSBz
dHJ1Y3QgdmNwdV92bXgtPmVwdF9wb2ludGVyLg0KPj4+PiAgICAgICAgIC0gQWRkIGh5cGVydl9u
ZXN0ZWRfZmx1c2hfZ3Vlc3RfbWFwcGluZyBmdHJhY2Ugc3VwcG9ydA0KPj4+Pg0KPj4+Pg0KPj4+
Pg0KPj4+PiBMYW4gVGlhbnl1ICg0KToNCj4+Pj4gICAgWDg2L0h5cGVyLVY6IEFkZCBmbHVzaCBI
dkZsdXNoR3Vlc3RQaHlzaWNhbEFkZHJlc3NTcGFjZSBoeXBlcmNhbGwNCj4+Pj4gICAgICBzdXBw
b3J0DQo+Pj4+ICAgIFg4Ni9IeXBlci1WOiBBZGQgaHlwZXJ2X25lc3RlZF9mbHVzaF9ndWVzdF9t
YXBwaW5nIGZ0cmFjZSBzdXBwb3J0DQo+Pj4+ICAgIEtWTTogQWRkIHRsYiByZW1vdGUgZmx1c2gg
Y2FsbGJhY2sgaW4ga3ZtX3g4Nl9vcHMuDQo+Pj4+ICAgIEtWTS94ODY6IEFkZCB0bGJfcmVtb3Rl
X2ZsdXNoIGNhbGxiYWNrIHN1cHBvcnQgZm9yIHZteA0KPj4+Pg0KPj4+PiAgIGFyY2gveDg2L2h5
cGVydi9NYWtlZmlsZSAgICAgICAgICAgIHwgIDIgKy0NCj4+Pj4gICBhcmNoL3g4Ni9oeXBlcnYv
bmVzdGVkLmMgICAgICAgICAgICB8IDY3DQo+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+Pj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9oeXBlcnYtdGxmcy5oICB8ICA4
ICsrKysrDQo+Pj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCAgICAgfCAxMSAr
KysrKysNCj4+Pj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oICAgICB8ICAyICsr
DQo+Pj4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vdHJhY2UvaHlwZXJ2LmggfCAxNCArKysrKysr
Kw0KPj4+PiAgIGFyY2gveDg2L2t2bS92bXguYyAgICAgICAgICAgICAgICAgIHwgNzINCj4+Pj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+PiAgIGluY2x1ZGUvbGlu
dXgva3ZtX2hvc3QuaCAgICAgICAgICAgIHwgIDcgKysrKw0KPj4+PiAgIHZpcnQva3ZtL2t2bV9t
YWluLmMgICAgICAgICAgICAgICAgIHwgIDMgKy0NCj4+Pj4gICA5IGZpbGVzIGNoYW5nZWQsIDE4
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL3g4Ni9oeXBlcnYvbmVzdGVkLmMNCj4+Pg0KPj4+IEFja2VkLWJ5OiBLLiBZLiBTcmlu
aXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4+DQo+PiBRdWV1ZWQsIHRoYW5rcyENCj4gDQo+
IE15IENPTkZJR19IWVBFUlYgaXMgZGlzYWJsZWQsIHRoZXJlIGlzIGEgd2FybmluZyB3aGVuIGNv
bXBpbGluZyBrdm0vcXVldWUuDQo+IHdhcm5pbmc6IOKAmGh2X3JlbW90ZV9mbHVzaF90bGLigJkg
ZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQ0KPiAgIHN0YXRpYyBpbnQg
aHZfcmVtb3RlX2ZsdXNoX3RsYihzdHJ1Y3Qga3ZtICprdm0pDQoNClRoYW5rcy4gV2FucGVuZyEg
SnVzdCBzZW5kIGEgZml4IHBhdGNoLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBXYW5wZW5nIExpDQo+
IA==
