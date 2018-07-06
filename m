Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AAAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275E92075B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TtByshHb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k6Ms3FY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275E92075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933959AbeGFRFY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:05:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19046 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeGFRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530896723; x=1562432723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BXMICnFO3KIHa05MKWIDhFszvq13aSRaFdgsbP5jQ2c=;
  b=TtByshHbSa53hykToAYC7pSdPN+/cZEOP8VzvT4xuu5HfiZoiUbhph9j
   Xd8Ckek9JTyAlLQpEif//bktXG9rwQzn6LG+/iuxKGCXswZOwp3wGXkQF
   lPcSW2rLuBf4MiuSFPk0q3tLLpcIlI50jRfBZuNJCVdoOzQG0/qZrCaQf
   l51RWrXtL4n+in25dYI2CV1GIdhpGKudeQz+bLD6W9uY1v5uvMRNk8zv5
   uFm73BURKSBSL0qZZSsB/U/HJ8TfYuRtmSnUzd6+AF2r/Eudo24Ksulvo
   /onWYsoTwPYZ/rjTrDZ41FAaM30Vx4juN9k1gez7UCQOUnJXYaAvcoIgT
   g==;
X-IronPort-AV: E=Sophos;i="5.51,317,1526313600"; 
   d="scan'208";a="84075308"
Received: from mail-co1nam05lp0082.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.82])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2018 01:05:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXMICnFO3KIHa05MKWIDhFszvq13aSRaFdgsbP5jQ2c=;
 b=k6Ms3FY8L7VDW7yyus6t8mWwMZ2XBYrSWE3vtNYOvwFUXpfa8VhB/Inh2W6bM6B19gaaCyOFUgOeWf896F1IReb8CR8WmqOffFrUJvayaLk0C7t1WGDjAFW2FF4DhzjhXn2fqh6hPCNcddIC+03edsggO8Q4V5gcnldYzxMscGo=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0881.namprd04.prod.outlook.com (10.174.174.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Fri, 6 Jul 2018 17:05:19 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0906.026; Fri, 6 Jul 2018
 17:05:19 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 4/4] scsi: ncr53c8xx: remove ScsiResult macro
Thread-Topic: [PATCH 4/4] scsi: ncr53c8xx: remove ScsiResult macro
Thread-Index: AQHUFE+iM3qD7o3uUUiDiWhgQxCl9qSA27sAgAD9BICAAJWpAA==
Date:   Fri, 6 Jul 2018 17:05:19 +0000
Message-ID: <ea39e5c6ff2b6081acd64cf14a0912e1510378a9.camel@wdc.com>
References: <20180705110140.19545-1-jthumshirn@suse.de>
         <20180705110140.19545-5-jthumshirn@suse.de>
         <a4a799f62ffa873fc3a7e23a5a46dafc8805b984.camel@wdc.com>
         <20180706080939.iotmgb24f6iaawkp@linux-x5ow.site>
In-Reply-To: <20180706080939.iotmgb24f6iaawkp@linux-x5ow.site>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0881;7:3jQis0CRfE+TQZRuR/TBuJ/OD++jfa3jOuxkqC1EPCKIRwQxaTek/C6B2fJnQ0vtUgWAu9EbXsUkVivA0QNNscjNa++UYk6HZIVhqJaKoG6dZ+q3CCmr/BrmVtCeEBBVoTehaBMEJl98V5yWXlmrtZjriowG3wmpAWWNjhclAYZh3Lx4sADvSvowl01mpZO7KpXyMNXWtApySXC2R2O6M60cwb44APBlsSpHRaqeSRw3RiE9E0C7YwhAEGcV6Z8G;20:A/rJbSHq/k8tcQD4P27wgeZgB1WyUgOxTS3dqddFUPXhG9anRQp6ZDrrUbAGSbL9gHBQxOj8Dkp24NAx3kb2GMwcirVqdraepAjQUiOHp/SLcdCiN6muIEep89Njvu1af1ZX6wsEq7CAapDqGs4ZNJXlxZAKxK+0A0D/SYmxIZ4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a22cd7e6-6490-4f51-7d42-08d5e362a778
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0881;
x-ms-traffictypediagnostic: MWHPR04MB0881:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0881F3ABD870B11E81E565FE98470@MWHPR04MB0881.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0881;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0881;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(6916009)(1730700003)(81166006)(305945005)(2906002)(86362001)(97736004)(229853002)(6436002)(3846002)(76176011)(6486002)(6116002)(2501003)(256004)(316002)(36756003)(54906003)(5250100002)(93886005)(2900100001)(4326008)(25786009)(478600001)(6246003)(6506007)(72206003)(186003)(106356001)(105586002)(53936002)(102836004)(6512007)(66066001)(99286004)(81156014)(5640700003)(8936002)(446003)(8676002)(2351001)(5660300001)(11346002)(14454004)(7736002)(118296001)(486006)(68736007)(26005)(2616005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0881;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: MaCZ+5p3YQPtW5L22+DezI74WKCryDmm/IwXS4m7u5qkSy6OW3oiSMapU8kRReGU2A/XBfM9NJDyiTHH7Jfd5FElaPp7woBDu0JEDJWfmrJtZ8sNACF6JGQPcd8RwAMZlWByJrRA+O/RWGqzWkvSSdaFqPG+M7Dq5DGxZ+kSVZwEXor3DftxHTdkeqwyJHw585LBAQJAqg5vdWyzEOX35fY2Ci9Fj7lNCPLAn7ZYerDwMr0LIlvzdGnQhl4/yLBmVs5/mkuxWthaT5QYu1guMMWxxq2iXwPkvvHX6dKxMpXyUlkBx3KmkioUMfatZyN1S2fol+9PGFE7pXkHwT5RpGpyPh9tGfNCcgZDPg7MJR8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B620DB3646C404698762592F263B712@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22cd7e6-6490-4f51-7d42-08d5e362a778
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 17:05:19.7713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTA2IGF0IDEwOjA5ICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIFRodSwgSnVsIDA1LCAyMDE4IGF0IDA1OjA0OjA1UE0gKzAwMDAsIEJhcnQgVmFu
IEFzc2NoZSB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMTgtMDctMDUgYXQgMTM6MDEgKzAyMDAsIEpv
aGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gPiA+IC0JCWNtZC0+cmVzdWx0ID0gU2NzaVJlc3Vs
dChESURfT0ssIFNfQ0hFQ0tfQ09ORCk7DQo+ID4gPiArCQljbWQtPnJlc3VsdCA9IERJRF9PSyA8
PCAxNiB8IFNfQ0hFQ0tfQ09ORDsNCj4gPiANCj4gPiBTaW5jZSBESURfT0sgPT0gMCwgZG8gd2Ug
cmVhbGx5IG5lZWQgIkRJRF9PSyA8PCAxNiB8IiBoZXJlPw0KPiANCj4gUGxlYXNlIHNlZSBteSBh
bnN3ZXJzIHRvIHRoZSBvdGhlciBwYXRjaGVzIG9uIHRoaXMuDQoNCk5vIG1hdHRlciB3aGF0IHRo
ZSBuZXh0IHN0ZXAgaXMsIHlvdSB3aWxsIGhhdmUgdG8gZGVhbCB3aXRoIGNvZGUgdGhhdCBsb29r
cw0KdmVyeSBzaW1pbGFyIHRvIHdoYXQgSSBwcm9wb3NlZC4gQW4gZXhhbXBsZSBmcm9tIGxpYmF0
YToNCg0KCWVsc2UgaWYgKHFjLT5mbGFncyAmIEFUQV9RQ0ZMQUdfU0VOU0VfVkFMSUQpDQoJCWNt
ZC0+cmVzdWx0ID0gU0FNX1NUQVRfQ0hFQ0tfQ09ORElUSU9OOw0KDQpCVFcsIGluIGRyaXZlcnMv
c2NzaS9zeW01M2M4eHhfMi9zeW1fZGVmcy5oIHRoZXJlIGFyZSBkZWZpbml0aW9ucyBmb3Igc3lu
b255bXMNCm9mIHN0YW5kYXJkIFNDU0kgY29uc3RhbnRzLiBJIHdvdWxkbid0IG1pbmQgaWYgdGhl
c2Ugc3lub255bXMgd291bGQgYmUgcmVtb3ZlZDoNCg0KI2RlZmluZQlTX0dPT0QJCVNBTV9TVEFU
X0dPT0QNCiNkZWZpbmUJU19DSEVDS19DT05ECVNBTV9TVEFUX0NIRUNLX0NPTkRJVElPTg0KI2Rl
ZmluZQlTX0NPTkRfTUVUCVNBTV9TVEFUX0NPTkRJVElPTl9NRVQNCiNkZWZpbmUJU19CVVNZCQlT
QU1fU1RBVF9CVVNZDQojZGVmaW5lCVNfSU5UCQlTQU1fU1RBVF9JTlRFUk1FRElBVEUNCiNkZWZp
bmUJU19JTlRfQ09ORF9NRVQJU0FNX1NUQVRfSU5URVJNRURJQVRFX0NPTkRJVElPTl9NRVQNCiNk
ZWZpbmUJU19DT05GTElDVAlTQU1fU1RBVF9SRVNFUlZBVElPTl9DT05GTElDVA0KI2RlZmluZQlT
X1RFUk1JTkFURUQJU0FNX1NUQVRfQ09NTUFORF9URVJNSU5BVEVEDQojZGVmaW5lCVNfUVVFVUVf
RlVMTAlTQU1fU1RBVF9UQVNLX1NFVF9GVUxMDQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQo=
