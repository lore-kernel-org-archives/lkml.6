Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB4CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77EC214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JVnC7a3C";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eJk4KQ6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfAJRdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:33:06 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5653 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfAJRdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547141584; x=1578677584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MV5QbCEEk92BnEodIMLlNAOaqh3VE/sYLsGxe0kvcXg=;
  b=JVnC7a3CwrSoo5VgQNxUk6Z+HxJp9X57gyROiRdJxz1NCXAdNVYxC/xR
   pNuO2bDTZ/J+tmUiud7yD39zANnwvviwMykIEQ4I8In8/wktMqPc+LweX
   3eywsC/j40Q9y/VEF7BPdf2cQqJXSiClw5a7E94onONQgT6S2cMDXSL4i
   nm+c43Ej1FG0eG2ZiCDXTf6D+AAOtWJv8XYXm+pgjLZccdM2nGTMfI0Y0
   GKsjrs5C50S/ACLlDOHj+Xg3yVl0b+PqoWsWp+ippg94eWuJw4b6TqaiW
   pINn17vWKEcxYl9zCPXg1sm6sLGeVG4uIUgNWx1+z6v/CgAVUy33mNged
   g==;
X-IronPort-AV: E=Sophos;i="5.56,462,1539619200"; 
   d="scan'208";a="103412243"
Received: from mail-dm3nam05lp2057.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.57])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2019 01:33:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV5QbCEEk92BnEodIMLlNAOaqh3VE/sYLsGxe0kvcXg=;
 b=eJk4KQ6MhefAicdjj5YC3+xn/58IgKNG8Exk9Oyw0Ofdxbr9aE6wamPA1v4dIxTpRHH7PGtN+6qXJshBy80A3+1flwRIjNlpLVgMczjT9+hUJKMOWhBLUgeveDlxOzBBDLz9VqHsHq3Gt5J/v3ASd15Sh09miwkquywf+uUMhEM=
Received: from MWHPR0401MB3514.namprd04.prod.outlook.com (10.167.162.141) by
 MWHPR0401MB3529.namprd04.prod.outlook.com (10.167.162.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 17:33:01 +0000
Received: from MWHPR0401MB3514.namprd04.prod.outlook.com
 ([fe80::588e:9c8f:55b9:2980]) by MWHPR0401MB3514.namprd04.prod.outlook.com
 ([fe80::588e:9c8f:55b9:2980%3]) with mapi id 15.20.1516.016; Thu, 10 Jan 2019
 17:33:00 +0000
From:   Alex Lemberg <Alex.Lemberg@wdc.com>
To:     "ihhuang@abmail.org" <ihhuang@abmail.org>
CC:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huangrandall@google.com" <huangrandall@google.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: associate bio write hint with WRITE CDB
Thread-Topic: [PATCH] scsi: associate bio write hint with WRITE CDB
Thread-Index: AQHUnNGdtE0mzYbmH02/9EuFvNXaBaWdOKaAgAAgg4CAALvXgIAAC0+AgAB6UWiAAAbPgIAKOfiA
Date:   Thu, 10 Jan 2019 17:33:00 +0000
Message-ID: <1547141575.2982.4.camel@alexl-VirtualBox>
References: <20181226041504.66283-1-huangrandall@google.com>
         <20190103075133.GA5141@infradead.org> <20190103094755.GA96532@google.com>
         <e5bc96cd-1b48-3b7e-706f-4cbbd1a040a4@interlog.com>
         <6152b478ea77dacf57eef6f758ba795f756cd3da.camel@redhat.com>
         <yq1ef9t81fh.fsf@oracle.com> <20190104052251.GA205256@google.com>
In-Reply-To: <20190104052251.GA205256@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Lemberg@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0401MB3529;6:8AJpLeTKAuU5tToCa+AvqbLFApTmQkxlx4GiaOSBT7PQiFns5tSZ1yMzmKNm2fUxIwIZNJh/sRovqAU8UJsccGnLY7UCLc69SIrd3dV0/qsm9f4T5GF4N8gnfSXu0q0YTk5uctIVHc8kFg1WXtcXYvy7KiJrXsPI2tYXwma1Yv8zRZ/+KU35ETAUfjSE0HhdzFjmrrBhhiIV7+ni3ui/Ny8/jkanjVBKTx0wA2m7R6EL/BjK8dMHNwDHKB8XYHR4Cx8E//iyrQedGyRTFpDghlXm+KdgU6Uz0KA2HtOdCGRJJS7CQIYQyIP9bpp164GS3o/W2/zykj9LMKCY1IbaPAde4bCW+JOs898W1b5XMJofWuyZ0+a4dDu2faWwaWoUTC3qk+YdsOE4qY1iW8QsG/F1KSP9L8pnrQAqjoKVw2YFBNvACAdLhwsO/OddQsILh0R1AKHzRIzZe49ytXPFhw==;5:nZKL4CuZu79x12vtEfXJeS96DYqNyufS5eBTH9MPruOKdM6PEzcHpuUYHr8CqlBQh7XdVwdV7p5dOZSvy6b2M7vzKV5jImtZQBIHoG9p84y52dObNGPrPIUKmuGxuE/COtwHGvzLaEo32WwtBwPeSM9oIznvPxZD88L5NeUH2f6x9vdf/BNtj0lF8StZggbB+qeAM8gRR7NHj4WNNXuNew==;7:1rmyu7JcUkmNt6bKj4NMsnNNOvKFb7XMHZPcee0O6eRlZ/XuphCLMFPHk7YzSHQDWGtxn7GIbXYADhNZLJqvpRKcBB280c4hHdZifp3hmpz6qep6lsiJSfnmMngYJvT9qxZRkCA1ylJRJwEyp9U1yg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3d297797-01a9-48e4-d39e-08d67721ab39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0401MB3529;
x-ms-traffictypediagnostic: MWHPR0401MB3529:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR0401MB35290252232A7D953E89F2858D840@MWHPR0401MB3529.namprd04.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(99286004)(5640700003)(4326008)(476003)(6512007)(9686003)(2906002)(53936002)(6436002)(93886005)(6506007)(102836004)(186003)(72206003)(229853002)(486006)(6486002)(33716001)(86362001)(25786009)(6246003)(71190400001)(446003)(71200400001)(11346002)(68736007)(256004)(97736004)(14444005)(7736002)(5660300001)(105586002)(316002)(76176011)(66066001)(305945005)(3846002)(6116002)(2351001)(8936002)(54906003)(14454004)(26005)(33896004)(561944003)(6916009)(8676002)(81166006)(81156014)(1730700003)(2501003)(106356001)(103116003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0401MB3529;H:MWHPR0401MB3514.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G4+7DuCzEHXNns7rKMBYgm9RpJfCmqhRNUZ3s+5j9Rwf7lnYzqAJkf0y6ALtmK3FssVtE66xjBwd44KIf7lE+uisT16l7f5XXfYnheJQmWBVduGQp7fQnWoBj+wbJYJ1+e101YWLoOUbRZdwiVcBcXEALtMfj2VFo+tAJtOv6QDXtJPnuzzQ4s+8+eHyGT7G6QC4jvt+fkJMoStxCyzdwXCBZb+0wnjg3of+3gRUYtmizRpORYTGOcYtNAQQ+u8eCuSQwYqY88iJ2RD85TFjJnDJPMaKq5LwvODY3QYniZ63CPHeQL6PYCNSQY8sZA2j
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB221D84882AF042BE46CB56DE0D84C8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d297797-01a9-48e4-d39e-08d67721ab39
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 17:33:00.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZGFsbCwNCg0KT24gRnJpLCAyMDE5LTAxLTA0IGF0IDEzOjIyICswODAwLCBSYW5kYWxs
IEh1YW5nIHdyb3RlOg0KPiBPbiBUaHUsIEphbiAwMywgMjAxOSBhdCAxMTo1NzozOFBNIC0wNTAw
LCBNYXJ0aW4gSy4gUGV0ZXJzZW4gd3JvdGU6DQo+ID4gDQo+ID4gRXdhbiwNCj4gPiANCj4gPiA+
IFNCQy01IHNheXMgdGhhdCBzdXBwb3J0IGZvciB0aGUgZ3JvdXBpbmcgZnVuY3Rpb24gaXMgaW5k
aWNhdGVkIGJ5IHRoZQ0KPiA+ID4gR1JPVVBfU1VQIGJpdCBpbiB0aGUgRXh0ZW5kZWQgSW5xdWly
eSBWUEQgcGFnZSAoODZoKS4gIEknbSBub3Qgc3VyZQ0KPiA+ID4gaG93IG1hbnkgZGV2aWNlcyBh
Y3R1YWxseSBzdXBwb3J0IHRoYXQgcGFnZSB0aG91Z2guICBQcm9iYWJseSBtb3N0DQo+ID4gPiBk
b24ndC4NCj4gPiANCj4gPiBTZXZlcmFsIGRldmljZXMgc3VwcG9ydCBpdCwgYWxiZWl0IGZvciB2
YXJpb3VzIGRpZmZlcmVudCBwdXJwb3Nlcy4gSXQncw0KPiA+IG9uZSBvZiB0aGVzZSB3b25kZXJm
dWwgZmVhdHVyZXMgd2hvc2UgaW50ZXJwcmV0YXRpb24gd2FzIGxlZnQgb3V0c2lkZQ0KPiA+IHRo
ZSBzY29wZSBvZiB0aGUgc3BlYyBmb3IgYSBsb25nIHRpbWUuDQo+ID4gDQo+ID4gU28gZXZlbiB0
aG91Z2ggd2UgYWJzb2x1dGVseSBhbmQgcG9zaXRpdmVseSBuZWVkIHRvIG1ha2Ugc2V0dGluZyBH
Uk9VUA0KPiA+IE5VTUJFUiBjb25kaXRpb25hbCBvbiBHUk9VUF9TVVAgYmVpbmcgcmVwb3J0ZWQs
IHdlIGFsc28gbmVlZCBhZGRpdGlvbmFsDQo+ID4gaW5mb3JtYXRpb24gZnJvbSB0aGUgc3RvcmFn
ZSBhYm91dCBob3cgdGhlIGZpZWxkIHNob3VsZCBiZSBpbnRlcnByZXRlZC4NCj4gPiANCj4gPiBU
aGUgb2ZmaWNpYWwgd2F5IHRvIHJlcG9ydCBoaW50aW5nIGlzIGZvciB0aGUgZGV2aWNlIHRvIGlt
cGxlbWVudCB0aGUgSU8NCj4gPiBBZHZpY2UgSGludHMgR3JvdXBpbmcgbW9kZSBwYWdlLiBJIHdy
b3RlIHNvbWUgY29kZSB0byBzdXBwb3J0IHRoYXQgYnV0DQo+ID4gbm8gdmVuZG9ycyB0aGF0IEkg
a25vdyBvZiBlbmRlZCB1cCBhY3R1YWxseSBzaGlwcGluZyBhbiBpbXBsZW1lbnRhdGlvbi4NCj4g
PiBBIGZldyBpbXBsZW1lbnRlZCBteSBvbGRlciBJL08gY2xhc3MgcHJvcG9zYWwgYnV0IGRpZG4n
dCBzaGlwIHRoYXQNCj4gPiBlaXRoZXIgZGVzcGl0ZSByZWFsbHkgY29udmluY2luZyBwZXJmb3Jt
YW5jZSByZXN1bHRzLg0KPiA+IA0KPiA+IElmIFJhbmRhbGwgaGFzIGFjY2VzcyB0byBhIGRldmlj
ZSB3aGljaCBpbXBsZW1lbnRzIGhpbnRpbmcsIEknZCBsb3ZlIHRvDQo+ID4ga25vdyBtb3JlLg0K
PiBJIGFtIHdvcmtpbmcgb24gQW5kcm9pZCBwaG9uZS4NCj4gVGhlIGlkZWEgaXMgdG8gZW5hYmxl
IHdyaXRlIGhpbnQgZm9yIFR1cmJvIHdyaXRlIFVGUyBmZWF0dXJlLg0KPiBUdXJibyB3cml0ZSBm
ZWF0dXJlIGluIFVGUyAzLnggaXMgdW5kZXIgZGlzY3Vzc2lvbiBpbiBKRURFQyBKQy02NC4gDQo+
IFRoaXMgcGF0Y2ggaXMgdGhlIHVuZGVyLWx5aW5nIGZyYW1ld29yayBmb3Igc3VwcG9ydGluZyB0
aGlzIGZlYXR1cmUuDQoNCkFzIGZhciBhcyBJIGtub3csIHRoZXJlIGFyZSBtb3JlIHRoYW4gb25l
IFR1cmJvIFdyaXRlIGZlYXR1cmUNCnByb3Bvc2FscyBpbiBKRURFQywgd2hpY2ggYXJlIGN1cnJl
bnRseSB1bmRlciBkaXNjdXNzaW9uLg0KRm9yIG5vdywgbm90IGFsbCBwcm9wb3NhbHMgYXJlIHVz
aW5nIENEQiBieXRlcyBmb3IgZW5hYmxpbmcNClR1cmJvV3JpdGUuDQpTbywgbWF5YmUgbWFraW5n
IHRoaXMgY2hhbmdlIGluIFNDU0kgaXMgc3RpbGwgdG9vIGVhcmx5Lg0KDQo+ID4gDQo+ID4gLS0g
DQo+ID4gTWFydGluIEsuIFBldGVyc2VuCU9yYWNsZSBMaW51eCBFbmdpbmVlcmluZw0KDQo=
