Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AF4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7A2208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d+nVdvAc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n5E1nBzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7A2208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933759AbeGJPJF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:09:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58087 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeGJPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531235343; x=1562771343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U9wbtMFGujBUPncWClyTTs2PUuLk693IeSGxemaAaYI=;
  b=d+nVdvAcGY0aXx1lpE/5xr75N0gouYIxWZuWRFqbI07bx8cvdhuVLQ9U
   7j1qlkGPSFZlOibFWCUCnjf+gRAWFf2pXwQi49sggPTZFWyEDmqGEpLyX
   UHNFwJaRVdW43H5WyBE/oPyr5L8MzNPZBIVhahhM2TvJL2lT4e8TLe4RO
   N5fubRwv2dmoXAh/uBSk739TltkJGl+TxAI4lGBHNG3AyGZvm8UqVH/tP
   9t/eKnwcBN6zP8xSOIk4dEu/DJtVWoTI46iWPrnG9UbE8kSdohjqNcuzQ
   Gk7QKTpVQS9QpQ782OVlIu2UW79l8yuIsqFFBXjvGopz/MPZbPKqn8T3P
   A==;
X-IronPort-AV: E=Sophos;i="5.51,335,1526313600"; 
   d="scan'208";a="187140468"
Received: from mail-co1nam05lp0088.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.88])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2018 23:08:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9wbtMFGujBUPncWClyTTs2PUuLk693IeSGxemaAaYI=;
 b=n5E1nBzonSubhzEBjCuilfo72PaES3ZXbMX0T6BAiNkCaa8mIzid4B6a2RiwTmL80QBp1OSmwv2OI8QZEW087QGSquLOWJGge/L3/eb6rpQ4A855LK0FYmhu549l4bkjda7vxQh9zMgCNqNO+lqarEgaDcGfnXdShdi/9syi6Z8=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB3744.namprd04.prod.outlook.com (10.172.169.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 15:08:39 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Tue, 10 Jul 2018
 15:08:39 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "leon@kernel.org" <leon@kernel.org>,
        "jan.dakinevich@virtuozzo.com" <jan.dakinevich@virtuozzo.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "den@virtuozzo.com" <den@virtuozzo.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "khorenko@virtuozzo.com" <khorenko@virtuozzo.com>
Subject: Re: [PATCH] ib_srpt: use kvmalloc to allocate ring pointers
Thread-Topic: [PATCH] ib_srpt: use kvmalloc to allocate ring pointers
Thread-Index: AQHUF4vtgYRvGL8p4EG6k4CNcrQ9GaSH8bcAgACe8oA=
Date:   Tue, 10 Jul 2018 15:08:38 +0000
Message-ID: <5196ea6e33825dd5fde58d23b38630afafcb77f1.camel@wdc.com>
References: <1531144268-25361-1-git-send-email-jan.dakinevich@virtuozzo.com>
         <20180710053944.GN3014@mtr-leonro.mtl.com>
In-Reply-To: <20180710053944.GN3014@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB3744;7:8RGyx6g3tgImJZFqsz4XxiGUn64lx/p+MuLxdGr+huR4OFkSgWM5z9sub6UbYempodOdDWa+bkujR12CB92FwFiuNcioipAsvkNYNWeAP2+gOiMXy7uS/kq8alYj3gCZPCV3zSePul7kt0JkdcLDVLSE31LazEn6xYiOhF5D1GSpXsH8au/uPEfar3qe1Q1tPvvYOrNpRtpkWX67j0txzyfP9nPNCaLHaxlZmaMP2W5BuYlpBDGcNSbFlZH8dSR7;20:M1AHDE1VfQ0UQeTjdquiioUKBC1I3p2GRkmYKvAyxU/it7JsAELAIO+R9vZ4A2rbr+jYuSCDnqPe/JRY/eK6xITTtbnohqyoU2HdPdVggR3KdxBUUWKppENfZyJuE06b9sIgbIURusSzJN7C+zA1FoYVIIPSs4ct+cP74y7SAWI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b01c4410-62e3-492c-bbe8-08d5e6770464
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB3744;
x-ms-traffictypediagnostic: MWHPR04MB3744:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB3744918A912326ED2FBDD9F9985B0@MWHPR04MB3744.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB3744;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB3744;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(106356001)(6116002)(105586002)(186003)(305945005)(99286004)(36756003)(256004)(11346002)(446003)(7736002)(66066001)(486006)(3846002)(53936002)(476003)(6506007)(2906002)(2616005)(6486002)(5660300001)(6436002)(2900100001)(25786009)(2501003)(14454004)(5250100002)(229853002)(86362001)(72206003)(68736007)(81166006)(81156014)(97736004)(110136005)(54906003)(26005)(8936002)(6512007)(76176011)(8676002)(102836004)(4326008)(6246003)(118296001)(316002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB3744;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: iShTzdSCzsyqWKbkRmQU06HNP2GtZEqsXG0iUz6Pj+vdiXABXHPHxK1BOC0/SEi43K95gAlWsNuzGeyeUZ6NX8WzaQTQ556EfrN2/P+I0YAiR2k2NgEhYVWV3EOiEJTxONRbyOGV0qhQ+/h4XMUPcf1xjmFpy8rziDXlC1qj7Wc6X+RRj5qCdTOMFrVAZqJGyzH3fvWQ7Rrj61d4zs15YOHXSGlUV12hQmSQ2fI0S7gpuz2Cla4Q5FmWVniy4z2AkiVYaEri5iOVGrsNv6/zm9o9UU/dXcbKkkGnV1+mZfuLaMZh4h+KwLydBU57eQ3w9qPx6aUb0i1pTF/mn13lKNHP04vrfc0SykZd/kniyYw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5319023AC802C94C93A502B3B54131CA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b01c4410-62e3-492c-bbe8-08d5e6770464
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 15:08:39.0309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB3744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTEwIGF0IDA4OjM5ICswMzAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6
DQo+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDA0OjUxOjA4UE0gKzAzMDAsIEphbiBEYWtpbmV2
aWNoIHdyb3RlOg0KPiA+IEFuIGFycmF5IG9mIHBvaW50ZXJzIHRvIFNSUFQgY29udGV4dHMgaW4g
aWJfZGV2aWNlIGlzIG92ZXIgMzBLaUIgZXZlbg0KPiA+IGluIGRlZmF1bHQgY2FzZSwgaW4gd2hp
Y2ggYW4gYW1vdW50IG9mIGNvbnRleHRzIGlzIDQwOTUuIFRoZSBwYXRjaA0KPiA+IGlzIGludGVu
ZGVkIHRvIHdlZWQgb3V0IGxhcmdlIGNvbnRpZ291cyBhbGxvY2F0aW9uIGZvciBub24tRE1BIG1l
bW9yeS4NCj4gDQo+IGt2bWFsbG9jKiBkb2Vzbid0ICJ3ZWVkIG91dCIgbGFyZ2UgY29udGlndW91
cyBhbGxvY2F0aW9ucywgYnV0IHRyaWVzIHRvDQo+IGFsbG9jYXRlIHRoZW0gYW5kIGdyYWNlZnVs
bHkgZmFsbGJhY2sgdG8gdm1hbGxvYyBpZiBrbWFsbG9jIGZhaWxzLg0KPiANCj4gTW9yZSBvbiB0
aGF0LCBmb3IgYWxsb2NhdGlvbnMgbGVzcyB0aGFuIHBhZ2UgKDY0S0IgZm9yIFBvd2VyUEMpLCBp
dCB3aWxsDQo+IG5vdCBjYWxsIHRvIHZtYWxsb2MgYXQgYWxsLCB3aGljaCBpcyBmaW5lIHRvbywg
YmVjYXVzZSBwYWdlcyBncmFudWxhcml0eS4NCj4gDQo+IElmIHlvdSB3YW50IHRvIGdldCByaWQg
b2YgImNvbnRpZ3VvdXMgYWxsb2NhdGlvbnMiLCB1c2Ugdm1hbGxvYyBpbnN0ZWFkLg0KDQp2bWFs
bG9jKCkgaGFzIGEgdmVyeSBzaWduaWZpY2FudCBkaXNhZHZhbnRhZ2UgY29tcGFyZWQgdG8ga3Zt
YWxsb2MoKTogd2l0aA0Kdm1hbGxvYygpIGl0IGlzIGd1YXJhbnRlZWQgdGhhdCBtZW1vcnkgYWxs
b2NhdGlvbnMgd2lsbCBiZSBzbG93LiBUaGF0J3Mgbm90DQp0aGUgY2FzZSBmb3Iga3ZtYWxsb2Mo
KSBpZiB0aGUgbnVtYmVyIG9mIGJ5dGVzIHRoYXQgaXMgYWxsb2NhdGVkIGlzIHNtYWxsDQplbm91
Z2guDQoNCkJhcnQuDQoNCg0KDQoNCg==
