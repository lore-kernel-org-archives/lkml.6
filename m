Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D82C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F5620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KbPkq3T/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F5620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbeKTBYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:24:51 -0500
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:11392
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729376AbeKTBYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2YgBDAny7oFh1Z8gMQhZYFrIAShUl3KsMpb6pYz+ZM=;
 b=KbPkq3T/rvi1AOv+jSj1zM2W1uva4EKiqZvVYn8twaB4eykNfdwjQj4ro8VO5enJnJUfISopRhXSKs+kg09oTSRzxR6Rov19d7m4Al5SSVYDZTIglytpz+dj5UwKWwLhV9orIEiq7vNqWSz1ts8+r2OZqIMnOfKaNHsg+CrUahE=
Received: from DB6PR05MB3256.eurprd05.prod.outlook.com (10.170.221.150) by
 DB6PR05MB4727.eurprd05.prod.outlook.com (10.168.21.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Mon, 19 Nov 2018 15:00:53 +0000
Received: from DB6PR05MB3256.eurprd05.prod.outlook.com
 ([fe80::38bb:b216:97b7:d1d2]) by DB6PR05MB3256.eurprd05.prod.outlook.com
 ([fe80::38bb:b216:97b7:d1d2%2]) with mapi id 15.20.1339.026; Mon, 19 Nov 2018
 15:00:53 +0000
From:   Tariq Toukan <tariqt@mellanox.com>
To:     Aaron Lu <aaron.lu@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?UGF3ZcWCIFN0YXN6ZXdza2k=?= <pstaszewski@itcare.pl>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Ian Kumlien <ian.kumlien@gmail.com>
Subject: Re: [PATCH v2 RESEND 1/2] mm/page_alloc: free order-0 pages through
 PCP in page_frag_free()
Thread-Topic: [PATCH v2 RESEND 1/2] mm/page_alloc: free order-0 pages through
 PCP in page_frag_free()
Thread-Index: AQHUgA6W4ccJdHhjHUaAMoxtv40S0aVXMTCA
Date:   Mon, 19 Nov 2018 15:00:53 +0000
Message-ID: <be048469-d29d-e700-4858-4a5263a50eb6@mellanox.com>
References: <20181119134834.17765-1-aaron.lu@intel.com>
 <20181119134834.17765-2-aaron.lu@intel.com>
In-Reply-To: <20181119134834.17765-2-aaron.lu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0139.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::44) To DB6PR05MB3256.eurprd05.prod.outlook.com
 (2603:10a6:6:1b::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR05MB4727;6:Ukj8n3VGCD+JFyhVNgfps8fhDPLPK/HUs3kFBexwotVkPmm7YcR+F9s/qeoWgn6L1qfMY0neXttSg+EtHPEjOY5YLfiE5JDmOA3u/4Tl58GYUZ8hpBX8viMDWlDNDMw3HYnqT53WU1g5rbUg1DDV7Ib+3eS2Gfo7U9v44QE9rspH7bZn+AACo0MiLV72QwTwCzVdOzxzadp0/ef9qVbOVeEwSu9Lqh2u9GxARWkFm1fIn1kHnB0ygOy3PXhC5IpUlpOU9LH1trZhZFP0HF2c7hqUsBxPzraPB4FRCHpiDRLLSnSDmybPy8dSaqcajDrlSHkNwAsfoEdrvznY2ZmDegONorm9gwglFn6oGdCSVO/cwbCNMHbTu1o1aU+mxFqzoRruysYYV9T2AT5GCL2tPou5GD4yJcXaqG/CJFXNSKO6FV3Jn3EoBOBPGhxRX1KO09MU3nU2G5emPZ9pHqFqRg==;5:/xkGgglBg3Xc/X/Aye/EKAvNKxatIS9P6SXWaKP7dkcx94VQ/+2BJLgZKPpCVHzPCo5IQJtEGVoK4r/qgi5xyqztIBmu/mXdTOUrcxc7kiBkduVMY2uNLH8xWVo9ZMsPc/r9oER7WocmhEZsuz/8Y8Ty7g/KIbeEYIHPEdGyXL4=;7:Oi2yHVHVLBbJKTSDS/m8va+Z95kqP0JgD6PohPnHUe4J4fxFtXT8+CHUkWwoxMlqASXIlomVMpjKQKD7fF14KBF5eoro4a7FbgU9sB+OgnJRJOlhD5VAXM/37DbYG99vGK/1VQS+/Wl70Hr5G3ZuuQ==
x-ms-office365-filtering-correlation-id: 7b67cf00-2e47-4a5e-c8ce-08d64e2fccf0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4727;
x-ms-traffictypediagnostic: DB6PR05MB4727:
x-microsoft-antispam-prvs: <DB6PR05MB4727002664D61E75F3EFD323AED80@DB6PR05MB4727.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB6PR05MB4727;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4727;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(2201001)(6246003)(81166006)(81156014)(31696002)(7736002)(66066001)(8936002)(71190400001)(68736007)(71200400001)(8676002)(2900100001)(2616005)(11346002)(476003)(36756003)(446003)(316002)(6512007)(6306002)(53936002)(2906002)(256004)(7416002)(86362001)(14444005)(39060400002)(3846002)(6116002)(5660300001)(97736004)(305945005)(4326008)(2501003)(52116002)(76176011)(31686004)(102836004)(386003)(53546011)(6506007)(99286004)(186003)(26005)(14454004)(54906003)(25786009)(110136005)(486006)(478600001)(6486002)(6436002)(229853002)(966005)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4727;H:DB6PR05MB3256.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sgiQpIvKUc2E+cL8O1uBvSLignlOh9MVuKNeN2Wb10+bjtaYFpKOlKJPWu2ugXqBEECW5Tiv7WvdWu4R4gBQI7d/Wm+FwCEGI9FgBwtkUkiQ6nZIUAmLLIosezv+IKzXFz7UxSZe5hnPZTss1ryV29JqkZIFcsxulzPZBiSfM8pibD8JzU2MzSRg3mt+pTVGDJVMT4dPfjvVSY41rSu4PMTge0BBKoXRZ5jH0cCLwl5kQPbBVTlHB+gnxKpXY2oAxUa/ttjrxJuJxzdwNBQ22iFbsf9C4Pv1DmaCOEveJXiFl6fy2E+nwFqHQmNkMIN2ozzurlm1oVYHY31hgmP7+QZFRubSjK7l8wXiZMYAvkQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A9C7ED5C96A7A499DA2C1C1F937C3B8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b67cf00-2e47-4a5e-c8ce-08d64e2fccf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 15:00:53.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE5LzExLzIwMTggMzo0OCBQTSwgQWFyb24gTHUgd3JvdGU6DQo+IHBhZ2VfZnJhZ19m
cmVlKCkgY2FsbHMgX19mcmVlX3BhZ2VzX29rKCkgdG8gZnJlZSB0aGUgcGFnZSBiYWNrIHRvDQo+
IEJ1ZGR5LiBUaGlzIGlzIE9LIGZvciBoaWdoIG9yZGVyIHBhZ2UsIGJ1dCBmb3Igb3JkZXItMCBw
YWdlcywgaXQNCj4gbWlzc2VzIHRoZSBvcHRpbWl6YXRpb24gb3Bwb3J0dW5pdHkgb2YgdXNpbmcg
UGVyLUNwdS1QYWdlcyBhbmQgY2FuDQo+IGNhdXNlIHpvbmUgbG9jayBjb250ZW50aW9uIHdoZW4g
Y2FsbGVkIGZyZXF1ZW50bHkuDQo+IA0KPiBQYXdlxYIgU3Rhc3pld3NraSByZWNlbnRseSBzaGFy
ZWQgaGlzIHJlc3VsdCBvZiAnaG93IExpbnV4IGtlcm5lbA0KPiBoYW5kbGVzIG5vcm1hbCB0cmFm
ZmljJ1sxXSBhbmQgZnJvbSBwZXJmIGRhdGEsIEplc3BlciBEYW5nYWFyZCBCcm91ZXINCj4gZm91
bmQgdGhlIGxvY2sgY29udGVudGlvbiBjb21lcyBmcm9tIHBhZ2UgYWxsb2NhdG9yOg0KPiANCj4g
ICAgbWx4NWVfcG9sbF90eF9jcQ0KPiAgICB8DQo+ICAgICAtLTE2LjM0JS0tbmFwaV9jb25zdW1l
X3NrYg0KPiAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAgICAgICB8LS0xMi42NSUtLV9fZnJl
ZV9wYWdlc19vaw0KPiAgICAgICAgICAgICAgIHwgICAgICAgICAgfA0KPiAgICAgICAgICAgICAg
IHwgICAgICAgICAgIC0tMTEuODYlLS1mcmVlX29uZV9wYWdlDQo+ICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgfC0tMTAuMTAlLS1xdWV1ZWRfc3Bpbl9sb2NrX3Nsb3dwYXRoDQo+ICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgIC0tMC42NSUtLV9yYXdfc3Bpbl9sb2NrDQo+ICAgICAgICAgICAgICAgfA0KPiAgICAg
ICAgICAgICAgIHwtLTEuNTUlLS1wYWdlX2ZyYWdfZnJlZQ0KPiAgICAgICAgICAgICAgIHwNCj4g
ICAgICAgICAgICAgICAgLS0xLjQ0JS0tc2tiX3JlbGVhc2VfZGF0YQ0KPiANCj4gSmVzcGVyIGV4
cGxhaW5lZCBob3cgaXQgaGFwcGVuZWQ6IG1seDUgZHJpdmVyIFJYLXBhZ2UgcmVjeWNsZQ0KPiBt
ZWNoYW5pc20gaXMgbm90IGVmZmVjdGl2ZSBpbiB0aGlzIHdvcmtsb2FkIGFuZCBwYWdlcyBoYXZl
IHRvIGdvDQo+IHRocm91Z2ggdGhlIHBhZ2UgYWxsb2NhdG9yLiBUaGUgbG9jayBjb250ZW50aW9u
IGhhcHBlbnMgZHVyaW5nDQo+IG1seDUgRE1BIFRYIGNvbXBsZXRpb24gY3ljbGUuIEFuZCB0aGUg
cGFnZSBhbGxvY2F0b3IgY2Fubm90IGtlZXANCj4gdXAgYXQgdGhlc2Ugc3BlZWRzLlsyXQ0KPiAN
Cj4gSSB0aG91Z2h0IHRoYXQgX19mcmVlX3BhZ2VzX29rKCkgYXJlIG1vc3RseSBmcmVlaW5nIGhp
Z2ggb3JkZXINCj4gcGFnZXMgYW5kIHRob3VnaHQgdGhpcyBpcyBhbiBsb2NrIGNvbnRlbnRpb24g
Zm9yIGhpZ2ggb3JkZXIgcGFnZXMNCj4gYnV0IEplc3BlciBleHBsYWluZWQgaW4gZGV0YWlsIHRo
YXQgX19mcmVlX3BhZ2VzX29rKCkgaGVyZSBhcmUNCj4gYWN0dWFsbHkgZnJlZWluZyBvcmRlci0w
IHBhZ2VzIGJlY2F1c2UgbWx4NSBpcyB1c2luZyBvcmRlci0wIHBhZ2VzDQo+IHRvIHNhdGlzZnkg
aXRzIHBhZ2UgcG9vbCBhbGxvY2F0aW9uIHJlcXVlc3QuWzNdDQo+IA0KPiBUaGUgZnJlZSBwYXRo
IGFzIHBvaW50ZWQgb3V0IGJ5IEplc3BlciBpczoNCj4gc2tiX2ZyZWVfaGVhZCgpDQo+ICAgIC0+
IHNrYl9mcmVlX2ZyYWcoKQ0KPiAgICAgIC0+IHBhZ2VfZnJhZ19mcmVlKCkNCj4gQW5kIHRoZSBw
YWdlcyBiZWluZyBmcmVlZCBvbiB0aGlzIHBhdGggYXJlIG9yZGVyLTAgcGFnZXMuDQo+IA0KPiBG
aXggdGhpcyBieSBkb2luZyBzaW1pbGFyIHRoaW5ncyBhcyBpbiBfX3BhZ2VfZnJhZ19jYWNoZV9k
cmFpbigpIC0NCj4gc2VuZCB0aGUgYmVpbmcgZnJlZWQgcGFnZSB0byBQQ1AgaWYgaXQncyBhbiBv
cmRlci0wIHBhZ2UsIG9yDQo+IGRpcmVjdGx5IHRvIEJ1ZGR5IGlmIGl0IGlzIGEgaGlnaCBvcmRl
ciBwYWdlLg0KPiANCj4gV2l0aCB0aGlzIGNoYW5nZSwgUGF3ZcWCIGhhc24ndCBub3RpY2VkIGxv
Y2sgY29udGVudGlvbiB5ZXQgaW4NCj4gaGlzIHdvcmtsb2FkIGFuZCBKZXNwZXIgaGFzIG5vdGlj
ZWQgYSA3JSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudA0KPiB1c2luZyBhIG1pY3JvIGJlbmNobWFy
ayBhbmQgbG9jayBjb250ZW50aW9uIGlzIGdvbmUuIElsaWFzJyB0ZXN0DQo+IG9uIGEgJ2xvdycg
c3BlZWQgMUdiaXQgaW50ZXJmYWNlIG9uIGFuIGNvcnRleC1hNTMgc2hvd3MgfjExJQ0KPiBwZXJm
b3JtYW5jZSBib29zdCB0ZXN0aW5nIHdpdGggNjRieXRlIHBhY2tldHMgYW5kIF9fZnJlZV9wYWdl
c19vaygpDQo+IGRpc2FwcGVhcmVkIGZyb20gcGVyZiB0b3AuDQo+IA0KPiBbMV06IGh0dHBzOi8v
d3d3LnNwaW5pY3MubmV0L2xpc3RzL25ldGRldi9tc2c1MzEzNjIuaHRtbA0KPiBbMl06IGh0dHBz
Oi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL25ldGRldi9tc2c1MzE0MjEuaHRtbA0KPiBbM106IGh0
dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL25ldGRldi9tc2c1MzE1NTYuaHRtbA0KPiANCj4g
UmVwb3J0ZWQtYnk6IFBhd2XFgiBTdGFzemV3c2tpIDxwc3Rhc3pld3NraUBpdGNhcmUucGw+DQo+
IEFuYWx5c2VkLWJ5OiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxicm91ZXJAcmVkaGF0LmNvbT4N
Cj4gQWNrZWQtYnk6IFZsYXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+DQo+IEFja2VkLWJ5
OiBNZWwgR29ybWFuIDxtZ29ybWFuQHRlY2hzaW5ndWxhcml0eS5uZXQ+DQo+IEFja2VkLWJ5OiBK
ZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxicm91ZXJAcmVkaGF0LmNvbT4NCj4gQWNrZWQtYnk6IEls
aWFzIEFwYWxvZGltYXMgPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz4NCj4gVGVzdGVkLWJ5
OiBJbGlhcyBBcGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+DQo+IEFja2Vk
LWJ5OiBBbGV4YW5kZXIgRHV5Y2sgPGFsZXhhbmRlci5oLmR1eWNrQGxpbnV4LmludGVsLmNvbT4N
Cj4gQWNrZWQtYnk6IFRhcmlxIFRvdWthbiA8dGFyaXF0QG1lbGxhbm94LmNvbQ0KDQptaXNzaW5n
ICc+JyBzaWduIGluIG15IGVtYWlsIHRhZy4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBBYXJvbiBMdSA8
YWFyb24ubHVAaW50ZWwuY29tPg0KPiAtLS0NCg==
