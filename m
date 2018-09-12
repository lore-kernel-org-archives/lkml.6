Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B815AC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F720882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eLSD4UUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1F720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeILFYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:24:14 -0400
Received: from mail-eopbgr710118.outbound.protection.outlook.com ([40.107.71.118]:23465
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725738AbeILFYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPN2UHHzzFjbaHdj6bGQxDUQPdKfzgO9JL9oZKS4tmI=;
 b=eLSD4UUf9aWkYPFL9laagmCZYMR6FCny2Cva6Es3NGo6wyz9FoaRz7kofjyG8E8B2fe1FV5JAo+Sv888JiO1T+Ca/dog+fLZsCQdCUX3XJVR1nEoDGJxAKjZ0pCKoQzNYeLaFh6SRne2AyJCBZ2WXfP/NWsn6w1i2L4GbDFm7A0=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 12 Sep 2018 00:22:24 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1164.006; Wed, 12 Sep 2018
 00:22:24 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: RE: [PATCH 10/13] x86/hyper-v: Add HvFlushGuestAddressList hypercall
 support
Thread-Topic: [PATCH 10/13] x86/hyper-v: Add HvFlushGuestAddressList hypercall
 support
Thread-Index: AQHUSOHKCyT/bftPjEWVpya3I6De+qTrxQqw
Date:   Wed, 12 Sep 2018 00:22:24 +0000
Message-ID: <CY4PR21MB077329ED0E195CDF557A09DEDC1B0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
 <20180910083806.65177-11-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180910083806.65177-11-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-12T00:22:21.9920310Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:qI4L57AhvnspFxn0WO6KzHPhgCYxcOcczSty8SmCnWG5CXPVoDjhpD6Oo+pHYGJRiYrRRCuv++FH8unTYpkiMBt6j8NC3ST+u/y/9F4fvO59s+C+N+WggRx8KSXTjy3iux40Uaz6TnsHTC58aXvYlMIChoduh8fUiTvfvrXZHltzweB3yPZV5jfxRZe84curDZfQEZKdNoI+6cLTwS6HD8z5ak75+lZigpw9bhVL05ay1+Mg3uppUiTI+CGxailrWByPbiuthXKuQEN2maI4PvjHp24Bw7rYiMiKZ2R/ZmtnLFOehyH5qey2oe+Ir4JyV5pIBaeGpe+3KwYlqAUfwVRmqRqYdyePwYKuoj7fY9O/mHtWzH3XzA2e2ijXSfWiLc4VZCibOQSLsURHtV1mSe305TcOpoGDp9cbsBqM+WnevfKixnGgrNItnNRbK3YCAPe8xqyrRPjHbQv8Wffxqg==;5:hgXBhLJBAKj4E8yh8njgU2yjlRaO2XHZr9Mx/4DdqZXx+IDv3OG1BYaa3FQ95187keCJzgaJxifV7d3DHOkxiJ5Zmy1Hy68zDCvvuO3cod1XzWWNj5eKy58RJllBVM0yNclmmDpXMN4j1KeDLfNJP0PsUU7QLtFRfw28r0hk/oo=;7:qEWyyxx0NjggoknILb1Y28CExM5sJXy4n7hO8B6ZfUrNBRzQSGpzN/yF1TA382yGmE1LcIhCRWpb9CGQe7Tn1kUA0LCxtYbIOCTE5egCIBwlDG/nH7CBMs03ltMTVkR2Bc7XTp+Psn7XqQyjqbLPVENa6vK0U9uDNo5iN/0o0hPmHTN4GSKAgifn4treoxlFsAHceKeXiZJLLb+bM6zpQcZ+SUuSj/2RhGWPRi4/jOey25BGt100WWNDJj9Cxwil
x-ms-office365-filtering-correlation-id: 2f7190c8-e1ef-4bed-62f2-08d61845d03a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB08223828D4E0C3A2CFB2AF98DC1B0@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991039);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(86612001)(229853002)(7696005)(6246003)(7736002)(86362001)(14444005)(10290500003)(256004)(6116002)(3846002)(2906002)(53936002)(446003)(11346002)(25786009)(305945005)(6862004)(26005)(4326008)(105586002)(76176011)(106356001)(107886003)(14454004)(72206003)(486006)(478600001)(8936002)(476003)(102836004)(8676002)(5250100002)(66066001)(81166006)(81156014)(99286004)(6436002)(6506007)(2900100001)(97736004)(68736007)(6636002)(8990500004)(9686003)(74316002)(10090500001)(33656002)(55016002)(1511001)(22452003)(7416002)(5660300001)(54906003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uK6mmDC3aG+JiPSGWSLdc5El7WnzrzPBZCCMuC8RcHrZ7Ptm5naq1WUoU+ii9LcJhb6bbx/nH2f4MErl9idBHVfBALTwJyIl3bwD/7R/KU5aRll2IDu0oyX6tpfwQNpdhgzpMlMhdLPF37dxTbpLZZpYan+J1XZ2erhQPlOer1EnIH3OJg7/KRU9Mr37zDNUs9Sv9T4/Cc+imeKVSAbT06jvsVXmUC8PqLMZxx0FlAPUs2XMcED/KIdkNleNMtBa6+zsqw5KC43Pa+dDyT5iYtA9L+TrTfOnac1s2sCopBH8zg18OO/a8knukCaJ9wSWS4pVDlQ6nBBi3+oLSIkO+BevUQ1Ya/KMl3+oyaY+WiU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7190c8-e1ef-4bed-62f2-08d61845d03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 00:22:24.3540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGlhbnl1IExhbiAgU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTAsIDIwMTggMTozOSBB
TQ0KPiArDQo+ICtpbnQgaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmdfcmFuZ2UodTY0IGFzLCBz
dHJ1Y3Qga3ZtX3RsYl9yYW5nZSAqcmFuZ2UpDQoNCkknbSByZWFsbHkgY29uY2VybmVkIGFib3V0
IGRlZmluaW5nIHRoZSBIeXBlci1WIGZ1bmN0aW9uIHRvIGZsdXNoDQpndWVzdCBtYXBwaW5ncyBp
biB0ZXJtcyBvZiBhIEtWTSBzdHJ1Y3QgZGVmaW5pdGlvbi4gIFlvdXIgcGF0Y2ggcHV0cw0KdGhp
cyBmdW5jdGlvbiBpbiBhcmNoL3g4Ni9oeXBlcnYvbmVzdGVkLmMuICBJIGhhdmVuJ3QgaW52ZXN0
aWdhdGVkIGFsbA0KdGhlIGRldGFpbHMsIGJ1dCBvbiBpdHMgZmFjZSB0aGlzIGFwcHJvYWNoIHNl
ZW1zIGxpa2UgaXQgd291bGQgY2F1c2UNCnRyb3VibGUgaW4gdGhlIGxvbmcgcnVuLCBhbmQgaXQg
ZG9lc24ndCBzdXBwb3J0IHRoZSBjYXNlIG9mIGENCmh5cGVydmlzb3Igb3RoZXIgdGhhbiBLVk0g
cnVubmluZyBhdCBMMS4NCg0KSSBrbm93IHRoYXQgS1ZNIGNvZGUgaGFzIHRha2VuIGEgZGVwZW5k
ZW5jeSBvbiBIeXBlci1WIHR5cGVzIGFuZA0KY29kZSwgYnV0IHRoYXQncyBiZWNhdXNlIEtWTSBp
cyBlbXVsYXRpbmcgYSBsb3Qgb2YgSHlwZXItViBmdW5jdGlvbmFsaXR5DQphbmQgaXQncyB0YWtp
bmcgYWR2YW50YWdlIG9mIEh5cGVyLVYgZW5saWdodGVubWVudHMuICBJcyB0aGVyZSBhIHRvcA0K
bGV2ZWwgcmVhc29uIEkgaGF2ZW4ndCB0aG91Z2h0IG9mIGZvciBIeXBlci1WIGNvZGUgdG8gdGFr
ZSBhDQpkZXBlbmRlbmN5IG9uIEtWTSBkZWZpbml0aW9ucz8gIEkgd291bGQgdGhpbmsgd2Ugd2Fu
dCBIeXBlci1WDQpjb2RlIHRvIGJlIGdlbmVyaWMsIHVzaW5nIEh5cGVyLVYgZGF0YSBzdHJ1Y3R1
cmUgZGVmaW5pdGlvbnMuICBUaGVuIGluDQprZWVwaW5nIHdpdGggd2hhdCdzIGFscmVhZHkgYmVl
biBkb25lLCBLVk0gY29kZSB3b3VsZCB1c2UgdGhvc2UNCmRlZmluaXRpb25zIHdoZXJlIGl0IG5l
ZWRzIHRvIG1ha2UgY2FsbHMgdG8gSHlwZXItViBjb2RlLg0KDQo+ICt7DQo+ICsJc3RydWN0IGt2
bV9tbXVfcGFnZSAqc3A7DQo+ICsJc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2hfbGlzdCAq
KmZsdXNoX3BjcHU7DQo+ICsJc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2hfbGlzdCAqZmx1
c2g7DQo+ICsJdTY0IHN0YXR1cyA9IDA7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKwlp
bnQgcmV0ID0gLUVOT1RTVVBQOw0KPiArCWludCBncGFfbiA9IDA7DQo+ICsNCj4gKwlpZiAoIWh2
X2h5cGVyY2FsbF9wZykNCj4gKwkJZ290byBmYXVsdDsNCj4gKw0KPiArCWxvY2FsX2lycV9zYXZl
KGZsYWdzKTsNCj4gKw0KPiArCWZsdXNoX3BjcHUgPSAoc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdf
Zmx1c2hfbGlzdCAqKikNCj4gKwkJdGhpc19jcHVfcHRyKGh5cGVydl9wY3B1X2lucHV0X2FyZyk7
DQo+ICsNCj4gKwlmbHVzaCA9ICpmbHVzaF9wY3B1Ow0KPiArCWlmICh1bmxpa2VseSghZmx1c2gp
KSB7DQo+ICsJCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4gKwkJZ290byBmYXVsdDsNCj4g
Kwl9DQo+ICsNCj4gKwlmbHVzaC0+YWRkcmVzc19zcGFjZSA9IGFzOw0KPiArCWZsdXNoLT5mbGFn
cyA9IDA7DQo+ICsNCj4gKwlpZiAoIXJhbmdlLT5mbHVzaF9saXN0KSB7DQo+ICsJCWdwYV9uID0g
ZmlsbF9mbHVzaF9saXN0KGZsdXNoLT5ncGFfbGlzdCwgZ3BhX24sDQo+ICsJCQkJcmFuZ2UtPnN0
YXJ0X2dmbiwgcmFuZ2UtPmVuZF9nZm4pOw0KPiArCX0gZWxzZSB7DQo+ICsJCWxpc3RfZm9yX2Vh
Y2hfZW50cnkoc3AsIHJhbmdlLT5mbHVzaF9saXN0LA0KPiArCQkJCWZsdXNoX2xpbmspIHsNCj4g
KwkJCXU2NCBlbmRfZ2ZuID0gc3AtPmdmbiArDQo+ICsJCQkJS1ZNX1BBR0VTX1BFUl9IUEFHRShz
cC0+cm9sZS5sZXZlbCkgLSAxOw0KPiArCQkJZ3BhX24gPSBmaWxsX2ZsdXNoX2xpc3QoZmx1c2gt
PmdwYV9saXN0LCBncGFfbiwNCj4gKwkJCQkJc3AtPmdmbiwgZW5kX2dmbik7DQo+ICsJCX0NCg0K
UGVyIHRoZSBwcmV2aW91cyBjb21tZW50LCBpZiB0aGlzIGxvb3AgcmVhbGx5IG5lZWRzIHRvIHdh
bGsgYSBLVk0NCmRhdGEgc3RydWN0dXJlLCBsb29rIGZvciBhIGRpZmZlcmVudCB3YXkgdG8gb3Jn
YW5pemUgdGhpbmdzIHNvIHRoYXQNCnRoZSBoYW5kbGluZyBvZiBLVk0tc3BlY2lmaWMgZGF0YSBz
dHJ1Y3R1cmVzIGlzIGluIGNvZGUgdGhhdOKAmXMgcGFydA0Kb2YgS1ZNLCByYXRoZXIgdGhhbiBp
biBIeXBlci1WIGNvZGUuDQoNCk1pY2hhZWwNCg0K
