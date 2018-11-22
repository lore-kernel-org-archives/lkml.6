Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C48C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52D6206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="nXo0/uYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52D6206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405970AbeKWDFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:05:45 -0500
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:6410
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394668AbeKWDFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEYkhAQzeDKkcgOBPjKMdf/s0KK3KFnA8jioaR3aja0=;
 b=nXo0/uYMEVpy5ij1rn6XMe66/oml+HQsw80OmKMDKA1hxATXZ+9VXBDhu0brdevG2oyrjJKq4syVANYvKciCZn914v5r4kBU+FqhvxBHS66NZe37q80xPyHP2E5pS/3E7MO9cUtmJ4RT4h7t9KVREXZJUie/FKcsmRTVRRdkEkM=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB4173.eurprd08.prod.outlook.com (20.178.204.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 16:24:56 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b%4]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 16:24:56 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>
CC:     nd <nd@arm.com>, Rich Felker <dalias@libc.org>,
        carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
Thread-Topic: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
Thread-Index: AQHUgcmYxLh54Hb0r0GDFIJAvPiE/6Vb3dCAgAAH4gCAAAIt+4AAAW4AgAABKRSAAANagIAADmkA
Date:   Thu, 22 Nov 2018 16:24:56 +0000
Message-ID: <7032ab45-8314-b85d-5b4d-f83b41dab5b6@arm.com>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com>
 <20181122143603.GD23599@brightrain.aerifal.cx>
 <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com>
 <87a7m1ywni.fsf@oldenburg.str.redhat.com>
 <20181122151710.GF23599@brightrain.aerifal.cx>
 <875zwpyw81.fsf@oldenburg.str.redhat.com>
 <1306224240.10055.1542900799576.JavaMail.zimbra@efficios.com>
In-Reply-To: <1306224240.10055.1542900799576.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [217.140.106.49]
x-clientproxiedby: CWLP265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5d::27) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB4173;6:GZ7gY08HFnfU0uga/fPH674cOqJqI0QybcBnAK82y10EmkCS2huc0cUWisCTJ3de1kby6qRwipjGd2KSYMghoxyCVNMn0RGicZSXWQu++3wVJy8End1t6mMe2ymrzFuVgwKEro0IupPXYUcs/g2o3OKAgNhJ4rWxLccaV9J1jX/wJbbYSSNemBCOvTxMYyGIzIw0l7/xZCOcdW4C7fakBuKEuBQmd5EYLXgWhdGgMW0j2kS8IloypnLCD+bnmrvinq3huHwEXtFNjaG285iiN3tBeCVXeDnBE21OApiQtB2BNDrfhxYeDiO9v+F/GM0DoTAoS0PtxURLfBmqWUh1ZTTH2AXj7994YRrYlV98sy0I8wzdfWwWwYLry2MbSfS2I6q8vnJ92DjE6S7erD2i66rEa7sStp5wp2HgcTHjpcGY0UuprvjLXUYNhCeRQJtbQN7iFX1qDl9pwb9MJeu07Q==;5:UUge4xGAI2bz/5kQqEY6uGZ0EUU/A9OXNaVOKcV3eyaBMlO/3kcoUObXoqwt0xxzmQttLccTJizN7CWVuSxKxCQmKFLl+fo7dh11dlrefjueXWpePx3q5oUhVsQjr4n4IiAB+sv9aJe0U35XxEe24oLqYzuzShpaieC/wlDTeP4=;7:gnc/IlXDSOU//9YtLYIn6zxTaHTn2TEvnaBGWB5nu9SvydYjwbfND9EbvcpJJdduOU8NxQa20rgV9aH7czg676Yzet9nvDKRigUO7TEH4NmKoBHBt8PlWr8jvdB+i2243JC3+be4C6+xMro7v/fiZA==
x-ms-office365-filtering-correlation-id: 90cd1591-578d-4c6d-858b-08d650970a32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB4173;
x-ms-traffictypediagnostic: VI1PR08MB4173:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB41735B1707BA7189AAFA6B56EDDB0@VI1PR08MB4173.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231442)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB4173;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB4173;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(366004)(199004)(189003)(36756003)(99286004)(6436002)(6246003)(39060400002)(26005)(6486002)(2616005)(25786009)(476003)(44832011)(4326008)(106356001)(105586002)(486006)(217873002)(478600001)(186003)(6116002)(3846002)(53936002)(31696002)(11346002)(2906002)(6512007)(229853002)(102836004)(86362001)(93886005)(446003)(72206003)(58126008)(110136005)(7416002)(81166006)(8676002)(54906003)(52116002)(7736002)(31686004)(305945005)(14454004)(256004)(5660300001)(65826007)(14444005)(8936002)(81156014)(76176011)(97736004)(71200400001)(64126003)(66066001)(65956001)(71190400001)(316002)(65806001)(6506007)(386003)(2900100001)(68736007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4173;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cXsLbhF7D+QoAAyo53SK7WQgwUYeTHP5A0wnfBxTkp4Vgyw2efSFmOKUZOhczB7KPZsX18jhD4ABRJnc/Zm41aqzg6i6WJPDs1z0+FuIHr33IIXTwWP5yj+BqSZInzkl69S9KZabVN0jAHxFRyLqXg1//0rrh2bHP//xlZoVy8i2TjiQIoDLZKEhSVnehmM7G3QejtB3XsRsIe272uTMkPPLVhOnOqrRfJHBrhsapM2MueOuurEEjOfRFn3LPS6XBV+tvpKEynu/rRFL+206ZFdItl3SLxKL3FVwJhM7jYMFAWBM0QWVO7qn1bC28uq3u+4G//HPw3q42DHtLfFQj3IhIyDF3Bxl1RM647wuJ8Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9173429E9D72E04E90A56A409D0D6B1C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cd1591-578d-4c6d-858b-08d650970a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 16:24:56.4777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMTEvMTggMTU6MzMsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPiAtLS0tLSBPbiBO
b3YgMjIsIDIwMTgsIGF0IDEwOjIxIEFNLCBGbG9yaWFuIFdlaW1lciBmd2VpbWVyQHJlZGhhdC5j
b20gd3JvdGU6DQo+PiBSaWdodCwgYnV0IGluIGNhc2Ugb2YgdXNlci1zdXBwbGllZCBzdGFja3Ms
IHdlIGFjdHVhbGx5IGZyZWUgVExTIG1lbW9yeQ0KPj4gYXQgdGhpcyBwb2ludCwgc28gc2lnbmFs
cyBuZWVkIHRvIGJlIGJsb2NrZWQgYmVjYXVzZSB0aGUgVENCIGlzDQo+PiAocGFydGlhbGx5KSBn
b25lIGFmdGVyIHRoYXQuDQo+IA0KPiBVbmZvcnR1bnRhdGVseSwgZGlzYWJsaW5nIHNpZ25hbHMg
aXMgbm90IGVub3VnaC4NCj4gDQo+IFdpdGggcnNlcSByZWdpc3RlcmVkLCB0aGUga2VybmVsIGFj
Y2Vzc2VzIHRoZSByc2VxIFRMUyBhcmVhIHdoZW4gcmV0dXJuaW5nIHRvDQo+IHVzZXItc3BhY2Ug
YWZ0ZXIgX3ByZWVtcHRpb25fIG9mIHVzZXItc3BhY2UsIHdoaWNoIGNhbiBiZSB0cmlnZ2VyZWQg
YXQgYW55DQo+IHBvaW50IGJ5IGFuIGludGVycnVwdCBvciBhIGZhdWx0LCBldmVuIGlmIHNpZ25h
bHMgYXJlIGJsb2NrZWQuDQo+IA0KPiBTbyBpZiB0aGVyZSBhcmUgY2FzZXMgd2hlcmUgdGhlIFRM
UyBtZW1vcnkgaXMgZnJlZWQgd2hpbGUgdGhlIHRocmVhZCBpcyBzdGlsbA0KPiBydW5uaW5nLCB3
ZSBfbmVlZF8gdG8gZXhwbGljaXRseSB1bnJlZ2lzdGVyIHJzZXEgYmVmb3JlaGFuZC4NCg0KaSB0
aGluayB0aGUgbWFuIHBhZ2Ugc2hvdWxkIHBvaW50IHRoaXMgb3V0Lg0KDQp0aGUgbWVtb3J5IG9m
IGEgcmVnaXN0ZXJlZCByc2VxIG9iamVjdCBtdXN0IG5vdCBiZSBmcmVlZA0KYmVmb3JlIHRocmVh
ZCBleGl0LiAoZWl0aGVyIHVucmVnaXN0ZXIgaXQgb3IgZnJlZSBsYXRlcikNCg0KYW5kIGlkZWFs
bHkgYWxzbyBwb2ludCBvdXQgdGhhdCBjIGxhbmd1YWdlIHRocmVhZCBzdG9yYWdlDQpkdXJhdGlv
biBkb2VzIG5vdCBwcm92aWRlIHRoaXMgZ3VhcmFudGVlOiBpdCBtYXkgYmUgZnJlZWQNCmJ5IHRo
ZSBpbXBsZW1lbnRhdGlvbiBiZWZvcmUgdGhyZWFkIGV4aXQgKHdoaWNoIGlzIGN1cnJlbnRseQ0K
bm90IG9ic2VydmFibGUsIGJ1dCB3aXRoIHRoZSByc2VxIHN5c2NhbGwgaXQgaXMpLg0K
