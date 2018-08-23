Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E35C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E620E208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YlL37Xf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E620E208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeHWUpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:45:24 -0400
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:43904
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbeHWUpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0XMy4vgZ60P3CMZtVqdGSFo5uVt5bhDKAp6QuV43W0=;
 b=YlL37Xf05ApNR+EnFdhtsb7OBZYcavzHJOV+ErV2GCQgkjfbfG3DI3aL3R7/N+poll1pl6A5F27frmMS2+cI01CQC2/d5MYYPTKbjlo8WwpN+SwzRh5Zuny1sW3W/kpJy/3tD1ATmw8MDzwk0AWGs5x98KvDabAOFVgf+Z74ndI=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2621.eurprd05.prod.outlook.com (10.172.13.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.24; Thu, 23 Aug 2018 17:14:39 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::95be:5f3e:5f50:9826]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::95be:5f3e:5f50:9826%4]) with mapi id 15.20.1059.023; Thu, 23 Aug 2018
 17:14:39 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Biggers <ebiggers@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dasaratharaman.chandramouli@intel.com" 
        <dasaratharaman.chandramouli@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com>
Subject: RE: [RDMA bug] KASAN: use-after-free Read in __list_del_entry_valid
 (4)
Thread-Topic: [RDMA bug] KASAN: use-after-free Read in __list_del_entry_valid
 (4)
Thread-Index: AQHTxJWJngQhcM4MiEyf8GrvXvpsbqPh3+iAgOvol4CAAJDbAIAAG9cAgAAF2ACAAASgEA==
Date:   Thu, 23 Aug 2018 17:14:39 +0000
Message-ID: <VI1PR0501MB2271943461A960624D6E9197D1370@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <001a1141551246502d056845782e@google.com>
         <001a1140f6ac1677460568489287@google.com>
         <20180823061630.GB736@sol.localdomain> <20180823145458.GC9366@ziepe.ca>
         <VI1PR0501MB22714BE9A34FA333671A0623D1370@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <1256f66271b31955f6e77c59335f4f75801eacf2.camel@redhat.com>
In-Reply-To: <1256f66271b31955f6e77c59335f4f75801eacf2.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [107.77.219.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2621;6:reAhKsx4DeXdAOtc7ivbA/N1AAnhL8SDpAXG5P5DOlgbAGb6mzKFR/sHmvytT518jHJaDAv5A1/I24I86qDqiryeKeWpxk7HYGGu2EuwxDREsDYCiBL3FspzHDJydkcdJOZxdi2dFoOX30Q8ci/WJBViZDzwpG0Jjc5ZuSRpqEmI71uuia1N4XUTrzx64IsO9ZeI5VzPD2AXWHXR0CltznNqpwbM6/D3wnrAeQRQYiiAiK2vClR+swXbCisfmdB8u7End6MGTlSlZIKWcXFW7yPSOJg3pmby9qMG3EvRDZpLLNmPQJfdn3wY34UEHBYQTGxE0ZL5xIziEMwC5z3pJCsGCnmS0D7di1uNdBt7sBtYG56gPfJ7D5pwmhNJT5U7bqh1QwLjNJ7ra7v+Yi9hyTiFr61uN0nbhreFU5vJyklUW3FqitQwtAiRpSPIdQLgV23Q9mRDoSjMAMsGtZBcXw==;5:pnvZINBSUZQnqa79PGDysRwUqK9JM3z4GTFSsBc/gVYFAllbCHCOPa5g5ybpU7dyeir4SlwLaVuB0k9nMyGvmhKAO60CZNG2PeF76eceQuyUntcDaTUZu5fsWIAemaOoqzv47sOXDF8WJ504VBuXanAHqf/oZHjLPVAqcP09T6I=;7:Bov3vkRdgl2wb3zTbVfCj4VMTFvxr8n1VhxwAJyG6WJMgUvkmXXtgQmDNDax//ia7+vCjoJDl/k5HVVsVQL4TI6/divzA65f1k939jHtInbDoLGcZHdu0qmLYfGsytowR+nk5qNX5OWOq+oFPnv3WrdJvJ0nslPU8zgOtipumuFKxZhlBgvcEWx3lqVPoq7UT6bYxTiGsVZwWWo0ziU7M89Xp2d9x3CttRWv4tBk6k+D9fdVwSn5bKIk/24M+gbp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a29db0c8-ef06-4853-d5ee-08d6091be8f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2621;
x-ms-traffictypediagnostic: VI1PR0501MB2621:
x-microsoft-antispam-prvs: <VI1PR0501MB2621EFF63A8CD37A76D6126CD1370@VI1PR0501MB2621.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(215639381216008)(9452136761055)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:VI1PR0501MB2621;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2621;
x-forefront-prvs: 0773BB46AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(346002)(396003)(13464003)(51444003)(189003)(199004)(93886005)(14454004)(6436002)(9686003)(478600001)(53936002)(86362001)(55016002)(2906002)(54906003)(575784001)(305945005)(81166006)(81156014)(5660300001)(110136005)(7736002)(5250100002)(8676002)(316002)(68736007)(33656002)(105586002)(106356001)(97736004)(229853002)(4326008)(25786009)(2900100001)(476003)(6246003)(66066001)(8936002)(486006)(7696005)(76176011)(186003)(3846002)(102836004)(6116002)(53546011)(26005)(11346002)(446003)(99286004)(6506007)(256004)(14444005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2621;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v6cFfbI15nYz9zYMavvMeJ9JAHd/M0BtljajJvQZ6tvP6VUSjQPFAdPYSJROJtZ9tM76aC/WC0w2wDvqVb1nloqELOBZNqrLLVd6moZ7+cOhyQhIFX3zHJYMKDGY7/bcBNQ8y0gzq4R1MxplGxFclIxTbG/97Ngf8Nhmbe8+OsQUom5Qi6Vo+2vmD108Bhmw8rDQ/nM6E4bSjR3MovAkECjbutnA4KSR1SAFyQz5eoG1QijJMmpWkmNa0yhpFIkPx1d/EONkpeyuDn5zbiHFhr3eJgDYsPAHNq/Z6gKzTWrnrv6geM6W+dzpAcZhg7r52Hre1iWO3BQnQXOj5csXyM49ZMNwNrzDXhpRFJXCgfo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29db0c8-ef06-4853-d5ee-08d6091be8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2018 17:14:39.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG91ZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEb3VnIExl
ZGZvcmQgPGRsZWRmb3JkQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjMs
IDIwMTggMTE6NTYgQU0NCj4gVG86IFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVsbGFub3guY29tPjsg
SmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+Ow0KPiBFcmljIEJpZ2dlcnMgPGViaWdnZXJz
QGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgZGFzYXJhdGhh
cmFtYW4uY2hhbmRyYW1vdWxpQGludGVsLmNvbTsNCj4gTGVvbiBSb21hbm92c2t5IDxsZW9ucm9A
bWVsbGFub3guY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gTWFyayBCbG9j
aCA8bWFya2JAbWVsbGFub3guY29tPjsgTW9uaSBTaG91YSA8bW9uaXNAbWVsbGFub3guY29tPjsN
Cj4gc3l6a2FsbGVyLWJ1Z3NAZ29vZ2xlZ3JvdXBzLmNvbTsgc3l6Ym90DQo+IDxzeXpib3QrMjll
ZThmNzYwMTdjZTZjZjAzZGFAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtSRE1BIGJ1Z10gS0FTQU46IHVzZS1hZnRlci1mcmVlIFJlYWQgaW4gX19saXN0X2RlbF9l
bnRyeV92YWxpZA0KPiAoNCkNCj4gDQo+IE9uIFRodSwgMjAxOC0wOC0yMyBhdCAxNjozOSArMDAw
MCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPg0KPiA+ID4gU2VudDog
VGh1cnNkYXksIEF1Z3VzdCAyMywgMjAxOCA5OjU1IEFNDQo+ID4gPiBUbzogRXJpYyBCaWdnZXJz
IDxlYmlnZ2Vyc0BrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IERvdWcgTGVkZm9yZCA8ZGxlZGZvcmRA
cmVkaGF0LmNvbT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gZGFzYXJhdGhh
cmFtYW4uY2hhbmRyYW1vdWxpQGludGVsLmNvbTsgTGVvbiBSb21hbm92c2t5DQo+ID4gPiA8bGVv
bnJvQG1lbGxhbm94LmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1hcmsgQmxv
Y2gNCj4gPiA+IDxtYXJrYkBtZWxsYW5veC5jb20+OyBNb25pIFNob3VhIDxtb25pc0BtZWxsYW5v
eC5jb20+OyBQYXJhdg0KPiBQYW5kaXQNCj4gPiA+IDxwYXJhdkBtZWxsYW5veC5jb20+OyBzeXpr
YWxsZXItYnVnc0Bnb29nbGVncm91cHMuY29tOyBzeXpib3QNCj4gPiA+IDxzeXpib3QrMjllZThm
NzYwMTdjZTZjZjAzZGFAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbT4NCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUkRNQSBidWddIEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBSZWFkIGluDQo+ID4gPiBfX2xp
c3RfZGVsX2VudHJ5X3ZhbGlkDQo+ID4gPiAoNCkNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEF1ZyAy
MiwgMjAxOCBhdCAxMToxNjozMVBNIC0wNzAwLCBFcmljIEJpZ2dlcnMgd3JvdGU6DQo+ID4gPiA+
IEhlbGxvIFJETUEgLyBJbmZpbmlCYW5kIG1haW50YWluZXJzLA0KPiA+ID4gPg0KPiA+ID4gPiBU
aGlzIGlzIGFuIFJETUEgYnVnIGFuZCBpdCBzdGlsbCBvY2N1cnMgb24gTGludXMnIHRyZWUgYXMg
b2YgdG9kYXkNCj4gPiA+ID4gKGNvbW1pdCA4MTVmMGRkYjM0NmMxOTYwKS4NCj4gPiA+ID4NCj4g
PiA+ID4gSSd2ZSBhbHNvIHNpbXBsaWZpZWQgdGhlIHJlcHJvZHVjZXIgZm9yIGl0OyBzZWUgYmVs
b3cgYWZ0ZXIgdGhlIG9yaWdpbmFsDQo+IHJlcG9ydC4NCj4gPiA+ID4gQXBwYXJlbnRseSBpdCBp
bnZvbHZlcyBhIHJhY2UgYmV0d2VlbiBSRE1BX1VTRVJfQ01fQ01EX1JFU09MVkVfSVANCj4gPiA+
DQo+ID4gPiBhbmQNCj4gPiA+ID4gUkRNQV9VU0VSX0NNX0NNRF9MSVNURU4uDQo+ID4gPg0KPiA+
ID4gVGhhdCBpcyBhbiBhbWF6aW5nIHJlcHJvZHVjZXIhDQo+ID4gPg0KPiA+ID4gSSBoYXZlIGEg
ZmVlbGluZyB0aGlzIGlzIHRoZSBzYW1lIGNhdXNlIGFzIGFsbCB0aGUgb3RoZXIgc3l6a2FsbGVy
IGJ1Z3MgaW4gdGhpcw0KPiBjb2RlOg0KPiA+ID4gbGFjayBvZiBhbnkgc2FuZSBsb2NraW5nIGF0
IGFsbCA6XA0KPiA+ID4NCj4gPiA+IFdlJ3ZlIHRhbGtlZCBhYm91dCBjaHVja2luZyBhIGJpZyBs
b2NrIGFyb3VuZCB0aGlzIHdob2xlIHRoaW5nLCBidXQNCj4gPiA+IG5vYm9keSBoYXMgZG9uZSBp
dCB5ZXQuLiBJdCBpc24ndCBzbyBzaW1wbGUuDQo+ID4gPg0KPiA+DQo+ID4gSSBoYWQgc29tZSBj
b2RlIGluIHdoaWNoIHJlZHVjZXMgdGhyZWUgbG9ja3MgKGhhbmRsZXJfbG9jaywgcXBfbXV0ZXgs
DQo+IGlkX2xvY2spIHRvIHNpbmdsZSBtdXRleCB0byBwcm90ZWN0IHRoZSBjbV9pZCBhbmQgcHJv
dGVjdHMgZXZlcnkgZXhwb3J0ZWQNCj4gc3ltYm9sIG9mIHJkbWFjbSB3aGljaCB3b3JrcyBvbiBj
bV9pZC4NCj4gPiBCdXQgbm90IHJlYWR5IGVub3VnaCB0byBwb3N0IGl0IGFzIHBhdGNoIHlldC4g
TG90IG9mIHRlc3RzIHJlcXVpcmVkIGJlZm9yZSBJIGdldA0KPiB0aGVyZSBhbmQgc29tZSByZWZh
Y3RvciB0b28gYmVmb3JlIHRoYXQuDQo+IA0KPiBEb2VzIGl0IGZpbmFsbHkgYWRkcmVzcyB0aGUg
ZmFjdCB0aGF0IHRoZSByZG1hY20gY29kZSB3YXMgd3JpdHRlbiBzbyB0aGF0IGl0IHdhcw0KPiBh
bHdheXMgc3luY2hyb25vdXMgYnV0IFJvQ0Ugc3JjIGdpZCAoSSB0aGluayB0aGF0J3Mgd2hhdCBp
dCB3YXMsIEknbSB0eXBpbmcgdGhpcw0KPiBmcm9tIGxvbmcgYWdvIG1lbW9yeSkgbG9va3VwIGJy
b2tlIHRoYXQgYXNzdW1wdGlvbj8NCj4gDQpJIGFtIG5vdCBzdXJlLiANClRvIG1lIGl0IGlzIHVu
bGlrZWx5LCBiZWNhdXNlIHJkbWFfcmVzb2x2ZV9yb3V0ZSgpIGZvciBJbmZpbmlCYW5kIGlzIG5v
dCBzeW5jaHJvbm91cyBlaXRoZXIgd2hpY2ggbmVlZHMgdG8gcXVlcnkgdGhlIFNBLg0KQnV0IHFw
X211dGV4IGV4aXN0ZWQgbG9uZyBiZWZvcmUgdGhhdCB3aGljaCBkb2Vzbid0IHByb3ZpZGUgYW55
IHBlcmZvcm1hbmNlIGltcHJvdmVtZW50cy4gKCBieSBzcGxpdHRpbmcgYXMgM3JkIGxvY2sgaW5z
dGVhZCBvZiBpZF9sb2NrIGFuZCBoYW5kbGVyX2xvY2spIGFuZCBzbyBvbi4NCg0KDQo+IC0tDQo+
IERvdWcgTGVkZm9yZCA8ZGxlZGZvcmRAcmVkaGF0LmNvbT4NCj4gICAgIEdQRyBLZXlJRDogQjgy
NkEzMzMwRTU3MkZERA0KPiAgICAgS2V5IGZpbmdlcnByaW50ID0gQUU2QiAxQkRBIDEyMkIgMjNC
NCAyNjVCICAxMjc0IEI4MjYgQTMzMyAwRTU3IDJGREQNCg==
