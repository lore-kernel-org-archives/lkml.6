Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B69C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52282170F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OKxsUkXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52282170F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbeHHIPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:15:16 -0400
Received: from mail-eopbgr60041.outbound.protection.outlook.com ([40.107.6.41]:11017
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbeHHIPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5ACYA1Y+j6ybcR95FQGviIcW5Ax+2Sa0kQvZnzfO/Q=;
 b=OKxsUkXxl63VC9FheNpbTW/tbObaxs4FavKyod/A10BN6F0R54aX9sWC0DLW/y6TL3C6eeBjQkbMm5OH3IOHFqJovx/HHHBwrGhm9z/srcVR7kC/6u3IDqDXsY4Vj3GDgB7WOzNemcwabLGTZF0upHdQDGgPs260X2eI8TbdpgQ=
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com (10.169.245.8) by
 AM5PR0401MB2465.eurprd04.prod.outlook.com (10.169.244.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 05:57:09 +0000
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93]) by AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93%3]) with mapi id 15.20.1038.019; Wed, 8 Aug 2018
 05:57:09 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Scott Wood <oss@buserror.net>, Rob Herring <robh@kernel.org>
CC:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>,
        "joe@perches.com" <joe@perches.com>
Subject: RE: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq ranges
Thread-Topic: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq
 ranges
Thread-Index: AQHUJY+K8uzq+AdU50upvFCJxJJUJ6S0qHwAgAAwmwCAAGuVwIAAJ6wAgAABBpA=
Date:   Wed, 8 Aug 2018 05:57:09 +0000
Message-ID: <AM5PR0401MB254583A97F24DBE1BACF1B1E9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
         <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
         <20180807180938.GA13623@rob-hp-laptop>
         <a20f27b15161164c829f771d2b085639f6709374.camel@buserror.net>
         <AM5PR0401MB2545AF363F5DD258205177FC9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <7526e100693e4db9bb3adf576254b2161086dfe8.camel@buserror.net>
In-Reply-To: <7526e100693e4db9bb3adf576254b2161086dfe8.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2465;6:q2bTcpDIMqI1JTY+hO7YNaJyU52L0kZuhWu+/xy2YRfI49bT+NjtC6aktjeYbgkcB/KafbWMOGGPIxhWYr0rlucDG6VPJdcg5hU/u65cbGVwPLKBkrewli9BgAA2K0lNSLKEMumlA3U4UWavIM2rrwZmKY44/mrhEGgBrobMCobWTrfAwTGwx9UT8VR8vu1iefNPbUJ0B3WXRY7oRp8gVw7wMQX+EA++DGeudVhT0XBAp/4UN3lT4HSFpRL0PF1SSGqJ7kx37nDsagDs4mmKUngyThL0TsbkDij8JkCSNBLt19EUO4bMkY4o8A0coFxDf5hL2Ov+K9VRsQV8c6gv2iTxOyhAivXyF0LIT2+4V3h+cfUMjEuSkN85Xo78Rg6kbggwB93+yQ9tdkCaJMOot6nVPHAEkwcw2BHg86fc0vtO4KuScgrg8jEDrUXsB+LB4dIbW7mvvBkhIpZfkUUIIQ==;5:k+aHkGQpjy1ZSEwj0V1stg8KQk0nlZtdOMbwgshS21pETmjBsNNe9GdNYdPsxPWAZpcB6DVezefEjYAGFKcb1jWkL1DOFhXVLvSvpqnQoDUoWf/KcBBPW2Ij81VYA3TBXOMRFbidrgKCu/rKXOqKuQS8xLmY1/JEi0AvVJLrqWs=;7:UlzMzFLbtr3k0NWZ5Xa3UD3M17qHEtoja4Aw7n67m5z58AwGD1nfSq9rZdwVRjjHFF78aJ3ZhqHJgnbV1i2IZ4mEWZWyIJfAWYBWo9CedoVd53NxJ3BW+t/w/CBRsSLAk3LRQ8ynpOBpRsomLSZ/kbBmZYZZcgnBW2k5uj35/etPUt1La4pPfNLZNd3dh9LyaSlRyxuDgHilEAFV8vjZBJNBG83YvnUyUZ6b1rLPaH5JIayVDPbxs8WTLPLXnlsU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7f723942-043c-49e6-5461-08d5fcf3c73a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2465;
x-ms-traffictypediagnostic: AM5PR0401MB2465:
x-microsoft-antispam-prvs: <AM5PR0401MB24653301B481780B0F15664D9A260@AM5PR0401MB2465.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0401MB2465;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2465;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(13464003)(6436002)(486006)(9686003)(26005)(229853002)(68736007)(476003)(33656002)(55016002)(76176011)(53546011)(55236004)(8936002)(2906002)(4326008)(6506007)(186003)(7696005)(44832011)(102836004)(53936002)(93886005)(5660300001)(7416002)(6246003)(81156014)(81166006)(110136005)(66066001)(478600001)(54906003)(14454004)(74316002)(105586002)(106356001)(25786009)(7736002)(305945005)(99286004)(316002)(5250100002)(2900100001)(8676002)(6116002)(3846002)(256004)(14444005)(446003)(97736004)(11346002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2465;H:AM5PR0401MB2545.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1SE/PVRKcftEyaXMfB07aCeDORp+OUCCduq+7Djnsueq35jTws+h0EVHlpiACJoUoTSAVsJZ/6WM966jZMT7QNOzO7+jIHzx8V/iTVjA44DFcgRu589gxYudp1nHIg3N9yXHb1nv+W4I6K/c3znzewqRsWyQChrjJnoBeuVRzmeSJ/TpPa0oZZtpICqIY+A/6Ro2M9eRkuxZ8LVnR00IPsTedUlLP4Yd7N6rAiRY6nVo8lc9oF91N2+TSbmSFQsBmqb/Nf2oZACwmmE/2eYQFzU3+l88hFbkp6RRSelpPdlC3hjiztg8+xEnMU4jXzMkV4J8q1oRlFOB2Q+J+dJLgeTuKWa3WMX52WIzSRCp5/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f723942-043c-49e6-5461-08d5fcf3c73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 05:57:09.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDgsIDIwMTgg
MTE6MjEgQU0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPjsg
Um9iIEhlcnJpbmcNCj4gPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IGJlbmhAa2VybmVsLmNyYXNo
aW5nLm9yZzsgcGF1bHVzQHNhbWJhLm9yZzsgbXBlQGVsbGVybWFuLmlkLmF1Ow0KPiBnYWxha0Br
ZXJuZWwuY3Jhc2hpbmcub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4ga3N0ZXdhcnRAbGlu
dXhmb3VuZGF0aW9uLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7DQo+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgbGludXgt
DQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gdHly
ZWxkQGxpbnV4LnZuZXQuaWJtLmNvbTsgam9lQHBlcmNoZXMuY29tDQo+IFN1YmplY3Q6IFJlOiBb
UkZDIDMvNV0gcG93ZXJwYy9tcGljOiBBZGQgc3VwcG9ydCBmb3Igbm9uLWNvbnRpZ3VvdXMgaXJx
DQo+IHJhbmdlcw0KPiANCj4gT24gV2VkLCAyMDE4LTA4LTA4IGF0IDAzOjM3ICswMDAwLCBCaGFy
YXQgQmh1c2hhbiB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBTY290dCBXb29kIFttYWlsdG86b3NzQGJ1c2Vycm9yLm5ldF0NCj4gPiA+IFNlbnQ6
IFdlZG5lc2RheSwgQXVndXN0IDgsIDIwMTggMjozNCBBTQ0KPiA+ID4gVG86IFJvYiBIZXJyaW5n
IDxyb2JoQGtlcm5lbC5vcmc+OyBCaGFyYXQgQmh1c2hhbg0KPiA+ID4gPGJoYXJhdC5iaHVzaGFu
QG54cC5jb20+DQo+ID4gPiBDYzogYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2Ft
YmEub3JnOyBtcGVAZWxsZXJtYW4uaWQuYXU7DQo+ID4gPiBnYWxha0BrZXJuZWwuY3Jhc2hpbmcu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gPiA+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlv
bi5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiA+ID4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC0NCj4gPiA+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsNCj4gPiA+IHR5
cmVsZEBsaW51eC52bmV0LmlibS5jb207IGpvZUBwZXJjaGVzLmNvbQ0KPiA+ID4gU3ViamVjdDog
UmU6IFtSRkMgMy81XSBwb3dlcnBjL21waWM6IEFkZCBzdXBwb3J0IGZvciBub24tY29udGlndW91
cw0KPiA+ID4gaXJxIHJhbmdlcw0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgMjAxOC0wOC0wNyBhdCAx
MjowOSAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgSnVsIDI3LCAy
MDE4IGF0IDAzOjE3OjU5UE0gKzA1MzAsIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+ID4gPiA+
IEZyZWVzY2FsZSBNUElDIGgvdyBtYXkgbm90IHN1cHBvcnQgYWxsIGludGVycnVwdCBzb3VyY2Vz
DQo+ID4gPiA+ID4gcmVwb3J0ZWQgYnkgaGFyZHdhcmUsICJsYXN0LWludGVycnVwdC1zb3VyY2Ui
IG9yIHBsYXRmb3JtLiBPbg0KPiA+ID4gPiA+IHRoZXNlIHBsYXRmb3JtcyBhIG1pc2NvbmZpZ3Vy
ZWQgZGV2aWNlIHRyZWUgdGhhdCBhc3NpZ25zIG9uZSBvZg0KPiA+ID4gPiA+IHRoZSByZXNlcnZl
ZCBpbnRlcnJ1cHRzIGxlYXZlcyBhIG5vbi1mdW5jdGlvbmluZyBzeXN0ZW0gd2l0aG91dA0KPiB3
YXJuaW5nLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVyZSBhcmUgbG90cyBvZiB3YXlzIHRvIG1pc2Nv
bmZpZ3VyZSBEVHMuIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcw0KPiA+ID4gPiBzcGVjaWFsIGFuZCBu
ZWVkcyBhIHByb3BlcnR5Lg0KPiA+ID4NCj4gPiA+IFllYWgsIHRoZSBzeXN0ZW0gd2lsbCBiZSBq
dXN0IGFzIG5vbi1mdW5jdGlvbmluZyBpZiB5b3Ugc3BlY2lmeSBhDQo+ID4gPiB2YWxpZC0NCj4g
PiA+IGJ1dC0NCj4gPiA+IHdyb25nLWZvci10aGUtZGV2aWNlIGludGVycnVwdCBudW1iZXIuDQo+
ID4NCj4gPiBTb21lIGlzIG9uZSBhZGRpdGlvbmFsIGJlbmVmaXRzIG9mIHRoaXMgY2hhbmdlcywg
TVBJQyBoYXZlIHJlc2VydmVkDQo+ID4gcmVnaW9ucyBmb3IgdW4tc3VwcG9ydGVkIGludGVycnVw
dHMgYW5kIHJlYWQvd3JpdGVzIHRvIHRoZXNlIHJlc2VydmVkDQo+ID4gcmVnaW9ucyBzZWFtcyBo
YXZlIG5vIGVmZmVjdC4NCj4gPiBNUElDIGRyaXZlciByZWFkcy93cml0ZXMgdG8gdGhlIHJlc2Vy
dmVkIHJlZ2lvbnMgZHVyaW5nIGluaXQvdW5pbml0DQo+ID4gYW5kIHNhdmUvcmVzdG9yZSBzdGF0
ZS4NCj4gPg0KPiA+IExldCBtZSBrbm93IGlmIGl0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSB0aGVzZSBj
aGFuZ2VzIGZvciBtZW50aW9uZWQNCj4gcmVhc29ucy4NCj4gDQo+IFRoZSBkcml2ZXIgaGFzIGJl
ZW4gZG9pbmcgdGhpcyBmb3JldmVyIHdpdGggbm8gaWxsIGVmZmVjdC4NCg0KWWVzLCB0aGVyZSBh
cmUgbm8gaXNzdWUgcmVwb3J0ZWQNCg0KPiAgV2hhdCBpcyB0aGUgIG1vdGl2YXRpb24gZm9yIHRo
aXMgY2hhbmdlPw0KDQpPbiBTaW11bGF0aW9uIG1vZGVsIEkgc2VlIHdhcm5pbmcgd2hlbiBhY2Nl
c3NpbmcgdGhlIHJlc2VydmVkIHJlZ2lvbiwgU28gdGhpcyBwYXRjaCBpcyBqdXN0IGFuIGVmZm9y
dCB0byBpbXByb3ZlLg0KDQpUaGFua3MNCi1CaGFyYXQNCg0KPiANCj4gLVNjb3R0DQoNCg==
