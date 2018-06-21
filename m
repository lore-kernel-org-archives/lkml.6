Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975E5C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42894219F1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YrmVmvRA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f5Fmho2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42894219F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFUSVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:21:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35489 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUSVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529605272; x=1561141272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tUqZ07GIpKomcSi7VLrELEMzVgJPaTgWdIGN1SF0AD8=;
  b=YrmVmvRAcUAfoc07NMW3oKRjxrJIDw1aU/qCPTwFExBYMsaAO3mLKR0C
   cxfN2jvMd2JV8x6kfw45KJ8fSjHptTrk//4HOcNn6hWClred0B3sO9aV/
   HKmdZUPLfy7osP49oiEoJ4RpMjbihC1sr9y9/c524QN9neQDRN/N/sbVc
   omwABeUTTzT19gpwMOAXWYh861YaasnHSjqD/CrLz7eFGUD1H16QhsxyX
   NHGrK2u1Q5a/ybbrU+fy+6PL4FqoQTtbpJAWKy7BqvlOJIWOGWnAwECqx
   0QbyuzXmXhTPoHI2ftl3PmbHAfIUVbQdea/6f/zjVGKK3WhWXq01XPiYT
   g==;
X-IronPort-AV: E=Sophos;i="5.51,253,1526313600"; 
   d="scan'208";a="81701940"
Received: from mail-cys01nam02lp0052.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2018 02:21:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUqZ07GIpKomcSi7VLrELEMzVgJPaTgWdIGN1SF0AD8=;
 b=f5Fmho2tQupUXa+8/z8D13LX7AMbKMzphAoCegW6C131+CC3zh7IABZOrk1Uz9ZIicYwWTQ4XKxy92OWAXW8xDUelQv09ZQIlJoW1UJOrrqsVR4sjDZvV2GO45hKOyDpbQProANMoE2V3d6r8oG8YxKMwipbRGWYSVY3SniUZz4=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0384.namprd04.prod.outlook.com (10.173.48.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Thu, 21 Jun 2018 18:21:09 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0863.016; Thu, 21 Jun 2018
 18:21:09 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hch@lst.de" <hch@lst.de>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH 0/5]stop normal completion path entering a timeout req
Thread-Topic: [PATCH 0/5]stop normal completion path entering a timeout req
Thread-Index: AQHUCJnoIecRRJla+EmbicMCCgB8HaRpdEiAgAB9AgCAAG6FAIAAqDwA
Date:   Thu, 21 Jun 2018 18:21:09 +0000
Message-ID: <84a5b54c318b130f47775747d37dc139c27ebda7.camel@wdc.com>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
         <20180620181601.GA24145@localhost.localdomain>
         <e87f5946-bb21-942e-2dcc-b24cee1ad23c@oracle.com>
         <20180621081900.GA5183@lst.de>
In-Reply-To: <20180621081900.GA5183@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0384;7:3ApJPVEVRmzuqMh8Au35alLcLs+aMC+wjSmV231xuJWDeAGJYYyq4X9OVIykmXJM6NV4VDIz9GoNGbFYn4oPzJvHrfXIOeT06XnXOK49xxPQS1CzuUL2IzHRlcOuicsGwZxM/ZrbZl41XRRPnwlcauhjFhCGm/oSS++iSoQJEDikdxMlVycEbb9uhkFPslG13y0J/JKtMjaNqOGvn6F6HT6bBlHfXQGHsvWzl2sr5DmCOWpxnJ9dnRDnKkPRSebX;20:MWmVl3FNDEI7py65/vkeaSc411EUYiZq3DEng/xOlmzeZEfq9TlKr7iB88O1/yJAjES9OACBeFahZDNhuNjfMb6IScDsEjv09wsOvEDGBxo2nros13V0QvUvJWG9n+fXM986pQptU9eqDdp25EER+s8KRSBgY0TpEjPjdGhcpv0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 04472591-58b9-401d-7ee9-08d5d7a3c351
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0384;
x-ms-traffictypediagnostic: MWHPR04MB0384:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0384BAEA2FD2531D05CAA57B98760@MWHPR04MB0384.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0384;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0384;
x-forefront-prvs: 07106EF9B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(366004)(376002)(39860400002)(199004)(189003)(186003)(11346002)(2501003)(7416002)(26005)(316002)(3280700002)(14454004)(8676002)(81166006)(102836004)(5250100002)(81156014)(3660700001)(93886005)(99286004)(72206003)(7736002)(118296001)(305945005)(478600001)(2900100001)(2616005)(476003)(5660300001)(446003)(110136005)(486006)(54906003)(105586002)(106356001)(3846002)(6116002)(68736007)(229853002)(25786009)(86362001)(66066001)(4326008)(6512007)(53936002)(59450400001)(6506007)(36756003)(8936002)(76176011)(6486002)(2906002)(97736004)(6246003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0384;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2eV2VDVhNK7ffLXCJpC8svV9dTa0/ZKUEgKqLHELKiTZ4d6G4RBzEsvZQUYumyOU86Lcb00Ljv0RRGDWTnsRt71TMjI70ZmKdNEn2qiTePhwHpxMqnMq6jIb6rhbOj3j1gor0U6dPa2coujxchkYYSh3OP3nD5RF9ImikT3J1EGz18UduIp+e7fA7ivOrLJtgEtX73+MP/d5HAdYo4UdwJlWYIU3NnmhNVRYkV+ZEZOn9GrP3roPjcMjt2mqDKy4fxTXrn3ShB8Fevvm11EqXd6XyEdVUiv7kuFs5RfQTFjWlouaMrQLBpmOOualxevC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <70EF024D9D58DE4FA224F3B7CFE2AAB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04472591-58b9-401d-7ee9-08d5d7a3c351
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2018 18:21:09.8621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA2LTIxIGF0IDEwOjE5ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVGh1LCBKdW4gMjEsIDIwMTggYXQgMDk6NDM6MjZBTSArMDgwMCwgamlhbmNoYW8u
d2FuZyB3cm90ZToNCj4gPiBTbyB3ZSBoYXZlIHRvIHByZXNlcnZlIHRoZSBhYmlsaXR5IG9mIGJs
b2NrIGxheWVyIHRoYXQgaXQgY291bGQgcHJldmVudA0KPiA+IElPIGNvbXBsZXRpb24gcGF0aCBm
cm9tIGVudGVyaW5nIGEgdGltZW91dCByZXF1ZXN0Lg0KPiA+IA0KPiA+IFdpdGggc2NzaS1kZWJ1
ZyBtb2R1bGUsIEkgdHJpZWQgdG8gc2ltdWxhdGUgYSBzY2VuYXJpbyB3aGVyZSB0aW1lb3V0IGFu
ZCBJTw0KPiA+IGNvbXBsZXRpb24gcGF0aCBjb3VsZCBvY2N1ciBjb25jdXJyZW50bHksIHRoZSBz
eXN0ZW0gcmFuIGludG8gY3Jhc2ggZWFzaWx5Lg0KPiANCj4gVHJhY2UsIHBsZWFzZS4gIFdpdGgg
dGhlIGxhdGVzdCBrZXJuZWwuICBJJ20gbm90IHNheWluZyB0aGF0IHRoZXJlDQo+IGlzIG5vdGhp
bmcgdG8gZml4LCBidXQgdGhlIG1vZGUgb2YgbmV2ZXIgY29tcGxldGluZyBvbmNlIHRpbWVvdXQN
Cj4gcmVxdWVzdHMgYXMgY3VycmVudGx5IGRvbmUgaXMgU0NTSSBpcyBjbGVhcmx5IGJyb2tlbi4N
Cg0KVGhhdCdzIG5vdCBob3cgdGhlIFNDU0kgY29yZSB3b3Jrcy4NCg0KQmFydC4NCg0KDQoNCg==
