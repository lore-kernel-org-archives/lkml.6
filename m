Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0960FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB4620837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eU5mahOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB4620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeH3XmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:42:15 -0400
Received: from mail-eopbgr680114.outbound.protection.outlook.com ([40.107.68.114]:45941
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3XmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3Ta/aRlyAeaLaIkC3uUZRmdwXik0pGpVChPhpUFJBc=;
 b=eU5mahOYkC/PDuisU3G18Jo2StUx3PRV/jMz1dK2/hlr7+GgkGVXuPKSeuskFkQH8Nn3tsjMDGC8JYeWBymP+q9ckCi2S7ORG5vYD9RCGHBnw6j0vRCgsPwEe2mTMJl72ZhtfjDIA8H0ZAPHx/Cfx0yKwxLIzFfkmc40l5YVc5s=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0698.namprd21.prod.outlook.com (10.175.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Thu, 30 Aug 2018 19:38:26 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::65dd:b17f:eb0d:2eee%8]) with mapi id 15.20.1122.009; Thu, 30 Aug 2018
 19:38:26 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH RFCv2 5/6] powerpc/powernv: hold device_hotplug_lock in
 memtrace_offline_pages()
Thread-Topic: [PATCH RFCv2 5/6] powerpc/powernv: hold device_hotplug_lock in
 memtrace_offline_pages()
Thread-Index: AQHUQJkF4A5ugJ7evE+50yrZin0knA==
Date:   Thu, 30 Aug 2018 19:38:26 +0000
Message-ID: <226aaaf7-7d1c-6f7b-5bf4-e6eb99862ebd@microsoft.com>
References: <20180821104418.12710-1-david@redhat.com>
 <20180821104418.12710-6-david@redhat.com>
In-Reply-To: <20180821104418.12710-6-david@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0698;6:08fVcqfIni5TL/cjeUA1W+AgpLZArXZMGF5PWpLVm8VBpz7F3mrPmTbG0T6ncQxjrt63UE/eBE0QQEJZO9mNiw5YlSE9IuAwX5gOVLpOPjMqpELdoVr/85nh2BZjat3Atnbnx3/8Nr+28f55eK30BFUxqFgoPmCHRBD9tvrhbzgHXQ2tYpATR+40wjbO0bb1KXnWovKSreue6bRCOw1Qr4otq6T6LGWU3KUuZ3qdrVDMX9cWLIiPm8JWbtLH2g2eu8vuFkG+sOQoMvKZ/r725pXV2Q1OlpFEcSHDGS+ZgclTsQetv/Abfi7ySHi5sy7++6XzGMUKGomZpe1M9R8QKzIOgD65b6s5nNGEe9flak2+0wKEuluW0mmdmJvjhdr16TKQngvJfy+En3WExostdW8SoKYAeH+lxsX0HXSiL3LJ6yx7iQGAam0N2mV/AqR0wN8gfQkAGz1xHt+OhEdNFg==;5:4KLONFU77TddsgcFA+iZUb38vq8dVOqV2chkp4aHqzwlPUEKT3m3MZENeqWj3EpDSYJumqcS3ZM4mfYtU2EOgg4hEsz+SgkVb1BDuYb74tZQMyw+Vp8EoVkz2xaRsIGqhm82/5uk7b0WmnN1eXyuxHkv9iVjxqtWHRb4cGYH+9I=;7:7bfZmBSzJmNCx5B4vGgRtIZATNxQsx814Az1CfU7dd8rB16Y2fydWaNjZ7eGgI22+QYmkY3dIxDg5Kt1AeDSmyP4AWESp84bL1mdzNsAMcQFOdn0zo8XbhbcVzGBdMws8QpaxC4w/ftPYnnmVzD+6PtbGwgYQiuSePLwaye6JC5m6j+vhOu82/oiS30Rts6/OiBu6pyp1dtMNqIHyJhsyw0Kb9LassAS31JqaFfOOXiTQ6VEdEFGx/FGNPf/DP9K
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 94f1e4a6-d601-4ec8-3652-08d60eb02808
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0698;
x-ms-traffictypediagnostic: DM5PR21MB0698:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0698A6796F69D4BCB93E8E999D080@DM5PR21MB0698.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:DM5PR21MB0698;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0698;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(136003)(366004)(189003)(199004)(22452003)(110136005)(54906003)(7416002)(31686004)(6116002)(316002)(10090500001)(3846002)(6486002)(97736004)(36756003)(105586002)(229853002)(106356001)(68736007)(2906002)(66066001)(14454004)(8936002)(186003)(14444005)(11346002)(26005)(486006)(2616005)(256004)(5660300001)(476003)(10290500003)(102836004)(72206003)(53546011)(478600001)(6506007)(31696002)(7736002)(81166006)(446003)(81156014)(25786009)(76176011)(2900100001)(8676002)(86362001)(5250100002)(39060400002)(99286004)(305945005)(6512007)(53936002)(86612001)(6246003)(6436002)(4326008)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0698;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fEI5hOfY38Pb/M0P4sWh7k9Ro96mMAuMzE0coIvApxboXdr5tZJYC6wuBnRFS/0ZdKaZaCmZzWAU3ooLdSZHLoJ4ihVm3vpAtbv98fiQp1qnQuKSomyeMeR58+C5jk4S72iVKQGsAHeLUfdfh8MoGebl/0JrBQqqRrv5afBF38zy0AgaigozJOeFzu3y4pe5bUkmpUComboIBUkW4FyZTZep9E/cc9kYVMqPXATyW2Tasp13UFuOxzbbRAQrC6JQtRYPKSjSaRSUd2IWBQyv1ABiWHO9ryqUGIaG2ABCz+X8RRLUxTW6Cr7C6izq+34a99qngXoTGrG50CVwBbXXQ5TJYG6ilVtBP2THII0gJOg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <22514313AC9ABF4BA9891A4203E5CEF8@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f1e4a6-d601-4ec8-3652-08d60eb02808
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 19:38:26.6702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0698
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29t
Pg0KDQpPbiA4LzIxLzE4IDY6NDQgQU0sIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiBMZXQn
cyBwZXJmb3JtIGFsbCBjaGVja2luZyArIG9mZmxpbmluZyArIHJlbW92aW5nIHVuZGVyDQo+IGRl
dmljZV9ob3RwbHVnX2xvY2ssIHNvIG5vYm9keSBjYW4gbWVzcyB3aXRoIHRoZXNlIGRldmljZXMg
dmlhDQo+IHN5c2ZzIGNvbmN1cnJlbnRseS4NCj4gDQo+IENjOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+DQo+IENjOiBQYXVsIE1hY2tlcnJhcyA8cGF1
bHVzQHNhbWJhLm9yZz4NCj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5h
dT4NCj4gQ2M6IFJhc2htaWNhIEd1cHRhIDxyYXNobWljYS5nQGdtYWlsLmNvbT4NCj4gQ2M6IEJh
bGJpciBTaW5naCA8YnNpbmdoYXJvcmFAZ21haWwuY29tPg0KPiBDYzogTWljaGFlbCBOZXVsaW5n
IDxtaWtleUBuZXVsaW5nLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQg
PGRhdmlkQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dl
cm52L21lbXRyYWNlLmMgfCAxMCArKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJw
Yy9wbGF0Zm9ybXMvcG93ZXJudi9tZW10cmFjZS5jIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9w
b3dlcm52L21lbXRyYWNlLmMNCj4gaW5kZXggZWY3MTgxZDRmZTY4Li40NzNlNTk4NDJlYzUgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9tZW10cmFjZS5jDQo+
ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9tZW10cmFjZS5jDQo+IEBAIC03
NCw5ICs3NCwxMyBAQCBzdGF0aWMgYm9vbCBtZW10cmFjZV9vZmZsaW5lX3BhZ2VzKHUzMiBuaWQs
IHU2NCBzdGFydF9wZm4sIHU2NCBucl9wYWdlcykNCj4gIHsNCj4gIAl1NjQgZW5kX3BmbiA9IHN0
YXJ0X3BmbiArIG5yX3BhZ2VzIC0gMTsNCj4gIA0KPiArCWxvY2tfZGV2aWNlX2hvdHBsdWcoKTsN
Cj4gKw0KPiAgCWlmICh3YWxrX21lbW9yeV9yYW5nZShzdGFydF9wZm4sIGVuZF9wZm4sIE5VTEws
DQo+IC0JICAgIGNoZWNrX21lbWJsb2NrX29ubGluZSkpDQo+ICsJICAgIGNoZWNrX21lbWJsb2Nr
X29ubGluZSkpIHsNCj4gKwkJdW5sb2NrX2RldmljZV9ob3RwbHVnKCk7DQo+ICAJCXJldHVybiBm
YWxzZTsNCj4gKwl9DQo+ICANCj4gIAl3YWxrX21lbW9yeV9yYW5nZShzdGFydF9wZm4sIGVuZF9w
Zm4sICh2b2lkICopTUVNX0dPSU5HX09GRkxJTkUsDQo+ICAJCQkgIGNoYW5nZV9tZW1ibG9ja19z
dGF0ZSk7DQo+IEBAIC04NCwxNCArODgsMTYgQEAgc3RhdGljIGJvb2wgbWVtdHJhY2Vfb2ZmbGlu
ZV9wYWdlcyh1MzIgbmlkLCB1NjQgc3RhcnRfcGZuLCB1NjQgbnJfcGFnZXMpDQo+ICAJaWYgKG9m
ZmxpbmVfcGFnZXMoc3RhcnRfcGZuLCBucl9wYWdlcykpIHsNCj4gIAkJd2Fsa19tZW1vcnlfcmFu
Z2Uoc3RhcnRfcGZuLCBlbmRfcGZuLCAodm9pZCAqKU1FTV9PTkxJTkUsDQo+ICAJCQkJICBjaGFu
Z2VfbWVtYmxvY2tfc3RhdGUpOw0KPiArCQl1bmxvY2tfZGV2aWNlX2hvdHBsdWcoKTsNCj4gIAkJ
cmV0dXJuIGZhbHNlOw0KPiAgCX0NCj4gIA0KPiAgCXdhbGtfbWVtb3J5X3JhbmdlKHN0YXJ0X3Bm
biwgZW5kX3BmbiwgKHZvaWQgKilNRU1fT0ZGTElORSwNCj4gIAkJCSAgY2hhbmdlX21lbWJsb2Nr
X3N0YXRlKTsNCj4gIA0KPiAtCXJlbW92ZV9tZW1vcnkobmlkLCBzdGFydF9wZm4gPDwgUEFHRV9T
SElGVCwgbnJfcGFnZXMgPDwgUEFHRV9TSElGVCk7DQo+ICsJX19yZW1vdmVfbWVtb3J5KG5pZCwg
c3RhcnRfcGZuIDw8IFBBR0VfU0hJRlQsIG5yX3BhZ2VzIDw8IFBBR0VfU0hJRlQpOw0KPiAgDQo+
ICsJdW5sb2NrX2RldmljZV9ob3RwbHVnKCk7DQo+ICAJcmV0dXJuIHRydWU7DQo+ICB9DQo+ICAN
Cj4g
