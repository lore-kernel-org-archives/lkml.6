Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89770C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359CC2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bZfD3x5Z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CwIGqOnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359CC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbeGFRHq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:07:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15928 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933532AbeGFRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530896863; x=1562432863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M7aWv9xjDsvNCz56UbcCowqB6gr9jUKOLCkxynVqr1U=;
  b=bZfD3x5ZiNIa+sjv0IzkTAAnzlmy/1l+CGxRupAtnUCB6hpGbyGl4TvL
   zlBM7Zfppu+j+Zmh6IkAb9hMBorsH79a8vN5feC0yVcaTIQJta81Pfo4n
   EzfRIPtxBugp+1ZoOpMkkLcV391bnCcqmPBmipBj4E3RcZ5b24QKwoJjC
   2l/HpGbhS/rJKNGam+QDGkdQj/MlKPv+pKjl2c3NE3tEKRNdGlnop4DuB
   C922wXmMpMo/G6NKQDZoo+8rwWwwNe4VlbJlWCY6ROvRu8omDdO6y1i1J
   Jyu3PxVMO6htuiPOSKidxLZbjN+Gb1Q+02tqdtMwQp0wq1/prbF+/HGI1
   g==;
X-IronPort-AV: E=Sophos;i="5.51,317,1526313600"; 
   d="scan'208";a="84075484"
Received: from mail-co1nam05lp0087.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.87])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2018 01:07:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7aWv9xjDsvNCz56UbcCowqB6gr9jUKOLCkxynVqr1U=;
 b=CwIGqOnkogaWXz5YrOS22937PAdy8jLr+7g7Nhby64VeLaRoFIc3Q4d/Yay0UouKpvFHXH3TjYP8Ck/p8I8UmwCc79z9qJCfLpfZfI/47H0ccNqGOVshobAhOY8Y01KwR0J+afbQsTxXaLpCJ0BvLRusLVZeRtFfFYSTK1IDbPo=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0881.namprd04.prod.outlook.com (10.174.174.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Fri, 6 Jul 2018 17:07:40 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0906.026; Fri, 6 Jul 2018
 17:07:40 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "arnd@arndb.de" <arnd@arndb.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] sbitmap, scsi/target: add seq_file forward declaration
Thread-Topic: [PATCH] sbitmap, scsi/target: add seq_file forward declaration
Thread-Index: AQHUFSzB1NuzQG1ha0O5wRToWdql86SCbVUA
Date:   Fri, 6 Jul 2018 17:07:39 +0000
Message-ID: <47d87d9ca498687344fcb18067ffe5e7bc313616.camel@wdc.com>
References: <20180706132407.4069001-1-arnd@arndb.de>
In-Reply-To: <20180706132407.4069001-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0881;7:zATLIDZkcI8xUM0NcwDOA8j7lyXpa1MnzVQVyLUTQviMn6rL30OikoaK9/7ic/3QmsIZi6c5PI17GVjoFnXcWBrEvd8nFbMqfGA9C2qxo6D80lSoDVb8zTq5MPGNvwisPEred3arFHX4+irxK5QCB7Bc7OaNmqbgcEMJxvG2x02akEeHyjfCPFtMvMmjv3uVCGvUwnRgu0HY83zemgm8U3Xe+oDpIJ54JqRPoNxgU/rnV3ymsqS88Xge481cTjao;20:q1o1L1YjVmG+/y0AjlXSHxyjeSDkaf8Ry15YIkNUHokKfPYeVHEgvLglcHgh5VebZ3TlbiAIB14RNy5QXoO7Zt3FXSg5b9gneWOekgChhYR4OMl38mFfYKVX3coD5qY9Ym0HEb1h1YNMOa0GBv13GRDiOJif+qBCFd4VZvQKCgo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 676376b6-8ac0-42b1-7648-08d5e362fb03
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0881;
x-ms-traffictypediagnostic: MWHPR04MB0881:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB08818AAE965D30B10990E2DD98470@MWHPR04MB0881.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0881;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0881;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(81166006)(305945005)(2906002)(7416002)(86362001)(97736004)(229853002)(6436002)(3846002)(76176011)(6486002)(6116002)(2501003)(14444005)(256004)(316002)(110136005)(36756003)(54906003)(5250100002)(2900100001)(4326008)(25786009)(478600001)(6246003)(6506007)(72206003)(186003)(106356001)(105586002)(53936002)(102836004)(6512007)(66066001)(99286004)(81156014)(8936002)(446003)(8676002)(5660300001)(11346002)(14454004)(7736002)(118296001)(486006)(68736007)(26005)(2616005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0881;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HTRxVPrrKsfwpJVUa3pW48dOtRc2+iYTFSlJtL9p1FpOnuMMrFfmSB0BdPKqwfRNnnU8fXkPTfeV6q2vErgX7WS39bvK8gE8ANl+3phI9zDqilqDcjEt+mi+YoFK9/mMXh8doyNdA+rTs2cluMxEjdB1Ke+3Nro27ZlOKs0AQ8j6hqMv5uwHqmPilVU82m3v4KTz1zV7+bemgYEYXYPCKp1L03uKBYFMN4+cFT/YuhlM/VgMYDovxaQ51gIR7heQ3kTTg3LvmAkEgABc59gWL9l8WnzrW6aUPyL82jJ8g8cHg4lbsC3/vPPuSPmP4dbis4RBnb6Xt5KM+c23XVpCGIKndE0SusXAsZi79I7NZV0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0661AB6394CE748B03AC49D334F2F2A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676376b6-8ac0-42b1-7648-08d5e362fb03
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 17:07:39.9200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTA2IGF0IDE1OjIzICswMjAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBUaGUgdGFyZ2V0IGNvcmUgcnVucyBpbnRvIGEgd2FybmluZyBpbiB0aGUgbGludXgvc2JpdG1h
cC5oDQo+IGZpbGUgaW4gc29tZSBjb25maWd1cmF0aW9uczoNCj4gDQo+IEluIGZpbGUgaW5jbHVk
ZWQgZnJvbSBpbmNsdWRlL3RhcmdldC90YXJnZXRfY29yZV9iYXNlLmg6NywNCj4gICAgICAgICAg
ICAgICAgICBmcm9tIGRyaXZlcnMvdGFyZ2V0L3RhcmdldF9jb3JlX2ZhYnJpY19saWIuYzo0MToN
Cj4gaW5jbHVkZS9saW51eC9zYml0bWFwLmg6MzMxOjQ2OiBlcnJvcjogJ3N0cnVjdCBzZXFfZmls
ZScgZGVjbGFyZWQgaW5zaWRlIHBhcmFtZXRlciBsaXN0IHdpbGwgbm90IGJlIHZpc2libGUgb3V0
c2lkZSBvZiB0aGlzIGRlZmluaXRpb24gb3IgZGVjbGFyYXRpb24gWy1XZXJyb3JdDQo+ICB2b2lk
IHNiaXRtYXBfc2hvdyhzdHJ1Y3Qgc2JpdG1hcCAqc2IsIHN0cnVjdCBzZXFfZmlsZSAqbSk7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fg0K
PiANCj4gSW4gZ2VuZXJhbCwgaGVhZGVycyBzaG91bGQgbm90IGRlcGVuZCBvbiBvdGhlcnMgYmVp
bmcgaW5jbHVkZWQgZmlyc3QsDQo+IHNvIHRoaXMgZml4ZXMgaXQgd2l0aCBhIGZvcndhcmQgZGVj
bGFyYXRpb24gZm9yIHRoYXQgc3RydWN0IG5hbWUsIGJ1dA0KPiB3ZSBwcm9iYWJseSB3YW50IHRv
IG1lcmdlIHRoZSBwYXRjaCB0aHJvdWdoIHRoZSBzY3NpIHRyZWUgdG8gaGVscA0KPiBiaXNlY3Rp
b24uDQo+IA0KPiBGaXhlczogMTBlOWNiYjZiNTMxICgic2NzaTogdGFyZ2V0OiBDb252ZXJ0IHRh
cmdldCBkcml2ZXJzIHRvIHVzZSBzYml0bWFwIikNCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJn
bWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L3NiaXRtYXAuaCB8
IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3NiaXRtYXAuaCBiL2luY2x1ZGUvbGludXgvc2JpdG1hcC5oDQo+
IGluZGV4IGU2NTM5NTM2ZGVhOS4uY2M1NGI5ZjdmZjhiIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3NiaXRtYXAuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3NiaXRtYXAuaA0KPiBAQCAt
MzIxLDYgKzMyMSw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHNiaXRtYXBfdGVzdF9iaXQoc3RydWN0
IHNiaXRtYXAgKnNiLCB1bnNpZ25lZCBpbnQgYml0bnIpDQo+ICANCj4gIHVuc2lnbmVkIGludCBz
Yml0bWFwX3dlaWdodChjb25zdCBzdHJ1Y3Qgc2JpdG1hcCAqc2IpOw0KPiAgDQo+ICtzdHJ1Y3Qg
c2VxX2ZpbGU7DQo+ICsNCj4gIC8qKg0KPiAgICogc2JpdG1hcF9zaG93KCkgLSBEdW1wICZzdHJ1
Y3Qgc2JpdG1hcCBpbmZvcm1hdGlvbiB0byBhICZzdHJ1Y3Qgc2VxX2ZpbGUuDQo+ICAgKiBAc2I6
IEJpdG1hcCB0byBzaG93Lg0KDQpJbiBtYW55IExpbnV4IGtlcm5lbCBoZWFkZXIgZmlsZXMgYWxs
IGZvcndhcmQgZGVjbGFyYXRpb25zIGFyZSBncm91cGVkIG5lYXINCnRoZSBzdGFydCBvZiB0aGUg
aGVhZGVyIGZpbGUgKGFmdGVyICNpbmNsdWRlcyBhbmQgI2RlZmluZXMgYW5kIGJlZm9yZSBzdHJ1
Y3R1cmUNCmRlZmluaXRpb25zKS4gU2hvdWxkIHdlIGZvbGxvdyB0aGF0IHBhdHRlcm4gaW4gPGxp
bnV4L3NiaXRtYXAuaD4/DQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQoNCg==
