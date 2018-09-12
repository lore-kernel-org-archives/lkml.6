Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D21C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D9120833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D9120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeILUwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:52:21 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:50117 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:52:21 -0400
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id B607B2A7;
        Wed, 12 Sep 2018 15:47:15 +0000 (UTC)
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id D87E86F;
        Wed, 12 Sep 2018 15:47:14 +0000 (UTC)
Received: from G4W9335.americas.hpqcorp.net (16.208.33.85) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Sep 2018 15:47:14 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G4W9335.americas.hpqcorp.net (2002:10d0:2155::10d0:2155) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Wed, 12 Sep 2018 15:47:14 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Wed, 12 Sep 2018 15:47:14 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0770.NAMPRD84.PROD.OUTLOOK.COM (10.169.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Wed, 12 Sep 2018 15:47:12 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1122.020; Wed, 12 Sep 2018
 15:47:12 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "jack@suse.cz" <jack@suse.cz>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
Thread-Topic: [PATCH 1/2] ext4, dax: update dax check to skip journal inode
Thread-Index: AQHUSekFUjINM6/+Z0KwkBt2ibRdAqTsYPUAgABlMgA=
Date:   Wed, 12 Sep 2018 15:47:12 +0000
Message-ID: <92faf51ac89e62dcd67e39cc66eef60966d1263c.camel@hpe.com>
References: <20180911154246.6844-1-toshi.kani@hpe.com>
         <20180911154246.6844-2-toshi.kani@hpe.com>
         <20180912092422.GA7782@quack2.suse.cz>
In-Reply-To: <20180912092422.GA7782@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0770;6:G3kWuCyMFlwVLIc9EpvebkJsrINznkYqmk8O735tPR3xFkmLeIUfVyvzxvxilbIlbpb9srZA6fKdCpkN/dT1i/xXdxJ6xIl5sAlLJFFYxDKJ17MSuQnuKpn23xpSV0SwFEHgwdM6v5Vg+aQMPnzFPYaf8nlfjkVCxiPLBPgXdRw1hrgBB+4tpbh3lKbq4AqUDa5ClhkD0v/Yw1Ta1tnkXucEBd2bK9H8RXvH9lIjMSim+3SZT1woxpfkDIpVVmOh+ByPfW9fCa9egqKjAaTXPwHaIAg9XqsvRcZ0kVjZsNajU6V4lBygcBlx0eoXDMpLq4vZChgmLfIX9dwrV1wFunXLZKTDW9mCa/vmt6Oky7k8fs+nIfinvK8cRwXibuHvtHBq0khX8raSNAU+eePUkFO5LipmiOFcvEoVqb0Lrav0tPczybC72oCPdJmUr4h7jJmWf01iqIVagvmW6bYjGA==;5:0iKfTfrZoVCpka86LRbjUV1DmGrCSnU6HnFSeASVFSPPT7yz+E0FZsUizpu7ZGTYOvDCn9S3rK+NiXJNSlWq+N8t4i3DIFIscZmaUFSPYVLxnx2lBNZcC5PrbLRPSBRhzC4tkp0uJKWsQkTyluOo4+yjyyhVFIoaMtm+d1Skf0Q=;7:JuZM1lQZrLFEn5CHkCPBhEpOiBCE/RRiW4N3fcJ6b6WXq41AJnYGBE7A2JOZ1G4iP++y0OYZKkJVBXR4bSLN6TW03caPzgxmyZDPh0rQyInUAtErU3nu3cHG14tAo4lSespMVdK6201qRmgQhBk6HSlx45ONSBfnA/nypTeGM2flkaJ81MM3yL1iB1YABWj/jUi5ZMXYipZh6T4w8Rr0nIiNXamxXOoBMwGlLBzAtOmQkS68udPV2UVtd41n+InA
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a9fb3978-0b96-44d9-659e-08d618c701b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0770;
x-ms-traffictypediagnostic: AT5PR8401MB0770:
x-microsoft-antispam-prvs: <AT5PR8401MB07705AEB2F38A30B7AE74008821B0@AT5PR8401MB0770.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(190756311086443)(227479698468861)(240460790083961)(222181515654134)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AT5PR8401MB0770;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0770;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(5250100002)(66066001)(15650500001)(14454004)(5640700003)(2501003)(6246003)(6486002)(229853002)(478600001)(6436002)(2616005)(86362001)(476003)(446003)(575784001)(8676002)(3846002)(6116002)(99286004)(7736002)(76176011)(186003)(11346002)(53936002)(316002)(97736004)(2906002)(26005)(5660300001)(54906003)(6506007)(4326008)(36756003)(486006)(6512007)(256004)(14444005)(102836004)(305945005)(25786009)(105586002)(2900100001)(106356001)(2351001)(8936002)(118296001)(81156014)(1730700003)(81166006)(68736007)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0770;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oAtFT1tI+qlQEGYVNrC0i39H5gBpmpEihScR1Ld6DteaAd2T+hNDPAy7YPryz8mlPFhJt5Ttd7sqab1IhConnnG5klhIF/C8tuKfmW1QJv046x/C7jm054ATLqnvuzEq5B0THKCktyk+oJ4ynUoeqI0hOKJ9xADngTTezr42TxZhRtxeU5FS719x6OJLKafPVssY3DbdNVgwWz1Tyk4yG/GxIqy88FjOfeMuRLph+hzUhzG4afZogOWbeA6nBXTi6jgLvxeeH61ZOignWLlw7k3UGr0Injej6jLR9NHOr5FAmLMyXcdn6Hc3Shr/Vys2v2zgU48N2xfrImhdLGRcMja00zvaCucbsIMsfisTYUQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF936500EEE4E946A008D2BE76FDBC73@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fb3978-0b96-44d9-659e-08d618c701b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 15:47:12.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0770
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA5LTEyIGF0IDExOjI0ICswMjAwLCBKYW4gS2FyYSB3cm90ZToNCj4gT24g
VHVlIDExLTA5LTE4IDA5OjQyOjQ1LCBUb3NoaSBLYW5pIHdyb3RlOg0KPiA+IEV4dDQgbW91bnQg
cGF0aCBjYWxscyBleHQ0X2lnZXQoKSB0byBvYnRhaW4gdGhlIGpvdXJuYWwgaW5vZGUuICBUaGlz
DQo+ID4gaW5vZGUgZG9lcyBub3Qgc3VwcG9ydCBEQVgsIGFuZCAnZXh0NF9kYV9hb3BzJyBuZWVk
cyB0byBiZSBzZXQuICBJdA0KPiA+IGN1cnJlbnRseSB3b3JrcyBmb3IgdGhlIERBWCBtb3VudCBj
YXNlIGJlY2F1c2UgZXh0NF9pZ2V0KCkgYWx3YXlzIHNldA0KPiA+ICdleHQ0X2RhX2FvcHMnIHRv
IGFueSByZWd1bGFyIGZpbGVzLg0KPiA+IA0KPiA+ICAgZXh0NF9maWxsX3N1cGVyDQo+ID4gICAg
IGV4dDRfbG9hZF9qb3VybmFsDQo+ID4gICAgICAgZXh0NF9nZXRfam91cm5hbF9pbm9kZQ0KPiA+
ICAgICAgICAgZXh0NF9pZ2V0DQo+ID4gDQo+ID4gSW4gcHJlcGFyYXRpb24gdG8gZml4IGV4dDRf
aWdldCgpIHRvIHNldCAnZXh0NF9kYXhfYW9wcycgZm9yIERBWCBmaWxlcywNCj4gPiB1cGRhdGUg
ZXh0NF9zaG91bGRfdXNlX2RheCgpIHRvIHJldHVybiBmYWxzZSBmb3IgdGhlIGpvdXJuYWwgaW5v
ZGUuDQo+ID4gDQo+ID4gRml4ZXM6IDVmMDY2M2JiNGE2NGY1ODhmMGEyZGQ2ZDFiZTY4ZDQwZjlh
ZjAwODYNCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb3NoaSBLYW5pIDx0b3NoaS5rYW5pQGhwZS5jb20+
DQo+ID4gQ2M6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQo+ID4gQ2M6IERhbiBXaWxsaWFtcyA8
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiA+IENjOiAiVGhlb2RvcmUgVHMnbyIgPHR5dHNv
QG1pdC5lZHU+DQo+ID4gQ2M6IEFuZHJlYXMgRGlsZ2VyIDxhZGlsZ2VyLmtlcm5lbEBkaWxnZXIu
Y2E+DQo+IA0KPiBUaGUgam91cm5hbCBpbm9kZSBpcyBzaW1pbGFyIHRvIGFueSBvdGhlciAnc3lz
dGVtJyBpbm9kZSB3ZSBoYXZlIGluIGV4dDQuDQo+IFdlIGRvbid0IHJlYWxseSBleHBlY3QgYW55
IG9mIHRoZSBhZGRyZXNzIHNwYWNlIG9wZXJhdGlvbnMgdG8gYmUgY2FsbGVkIGZvcg0KPiBpdCBi
ZWNhdXNlIHdlIGRvbid0IHVzZSBwYWdlIGNhY2hlIHdpdGggdGhlc2UgaW5vZGVzLiBWZXJ5IHNp
bWlsYXINCj4gc2l0dWF0aW9uIGlzIHdpdGggZS5nLiBxdW90YSBmaWxlcy4gU28gdG8gbWUgaXQg
c2VlbXMgdGhpcyBwYXRjaCBpcyBub3QNCj4gcmVhbGx5IG5lY2Vzc2FyeS4gT3IgZGlkIHlvdSBv
YnNlcnZlIGFueSBiYWQgZWZmZWN0cyB3aXRob3V0IHRoaXMgcGF0Y2g/DQoNClllcywgd2l0aG91
dCB0aGlzIGNoYW5nZSwgbW91bnQgZmFpbHMgd2l0aCB0aGUgZXJyb3IgYmVsb3cuICBJIGJlbGll
dmUNCi5ibWFwIG9wZXJhdGlvbiBpbiBleHQ0X2RhX2FvcHMgaXMgbmVjZXNzYXJ5IGZvciB0aGlz
IGNhc2UuDQoNCiAgamJkMl9qb3VybmFsX2luaXRfaW5vZGU6IENhbm5vdCBsb2NhdGUgam91cm5h
bCBzdXBlcmJsb2NrDQogIEVYVDQtZnMNCihwbWVtMSk6IENvdWxkIG5vdCBsb2FkIGpvdXJuYWwg
aW5vZGUNCg0KPiBUaGF0IGJlaW5nIHNhaWQgSSBhZ3JlZSB0aGF0IGl0IHdvdWxkIGJlIGEgZ29v
ZCBjbGVhbnVwIHRvIGRlZmluZSBzb21ldGhpbmcNCj4gbGlrZSBleHQ0X2lzX3N5c3RlbV9pbm9k
ZSgpIGFuZCBkaXNhYmxlIERBWCBmb3IgdGhlc2UgaW5vZGVzIGp1c3QgYmVjYXVzZQ0KPiB0aGV5
IGFyZSBzcGVjaWFsLiBCdXQgSSBkb24ndCBzZWUgYSBuZWVkIGZvciB0aGlzIGFzIGEgcGFydCBv
ZiB5b3VyIGZpeC4NCg0KSXMgdGhlcmUgb3RoZXIgc3lzdGVtIGlub2RlIHdlIG5lZWQgdG8gY2hl
Y2sgZm9yPw0KDQpUaGFua3MsDQotVG9zaGkNCg0KDQoNCg==
