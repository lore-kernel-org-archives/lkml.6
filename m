Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0C099C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CEC208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dBrSfkJD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gk/LtK31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CEC208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935887AbeFMOIf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:08:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8181 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935667AbeFMOIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528898898; x=1560434898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u/u3X1OZ70mI1B1VtpRMvs4revk5DS6oVKbdNKv08Ts=;
  b=dBrSfkJDg6Fsf5A5MRperHHu0wLNk9yI6rzsrMbXk8UcNTGfJa/hleHX
   bpjxvG4rp+nbo/Ikh2aWMbuS8PPzYaHFDUkV+4e/2pe3kpCqmrUJz4e/L
   hQqYI/WcJwuNJu0jfz0Gh8eRMi/o42Lrq4UztiM5tK0CWHV6mzWTubJhb
   9TlCrTySXpYW8FuBam8tkX5wGa2uqMzBnuvtzmu3KAwViC3Tq+rwpKv7L
   S4UrWkxOAaPreJsPfnaB1Shp4vegsATCcC9MfAtAo3nUJtns3R6BcWt0e
   qrp+EGjNAipa0uj+9jbPAjXlCzPtCUQ+Cjll/ZekIQzD3UjZ//jxnsUQA
   w==;
X-IronPort-AV: E=Sophos;i="5.51,219,1526313600"; 
   d="scan'208";a="80290028"
Received: from mail-by2nam01lp0178.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([216.32.181.178])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2018 22:08:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/u3X1OZ70mI1B1VtpRMvs4revk5DS6oVKbdNKv08Ts=;
 b=gk/LtK31Wt/DayzWVG8sm2D8oIl7fR4+nE1l8aNBVGbsr1SvL4NvOlnhjPECUR/v0co4WP8FWyGo7hD/0/gDQ1jQ9CQ+RyjvhaT6inWFj2FzO3DBWXDy+fLwO5oaMidAi7aNbCOzG+qOA0LnrlKEu3H3zqf7hvLRIGQxOJA13R0=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0815.namprd04.prod.outlook.com (10.172.168.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Wed, 13 Jun 2018 14:08:13 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Wed, 13 Jun 2018
 14:08:13 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "hch@lst.de" <hch@lst.de>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
CC:     "randrianasulu@gmail.com" <randrianasulu@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: kernel BUG at drivers/scsi/scsi_error.c:197! - git
 4.17.0-x64-08428-g7d3bf613e99a
Thread-Topic: kernel BUG at drivers/scsi/scsi_error.c:197! - git
 4.17.0-x64-08428-g7d3bf613e99a
Thread-Index: AQHUAx/3f9pXtuF1QkCCXpKTmDouxQ==
Date:   Wed, 13 Jun 2018 14:08:12 +0000
Message-ID: <09e8bd7605febd091679172d68ca1e9ca3990c91.camel@wdc.com>
References: <201806091606.51078.randrianasulu@gmail.com>
         <025bf705-15b0-65e5-4b16-6c91d41c1730@infradead.org>
         <40617b19667b3c1302f8a903c19f2fa2f409b12a.camel@wdc.com>
         <5ca74fb7-af70-31c3-0e3f-bace058e5a57@oracle.com>
         <20180613140411.GA32701@lst.de>
In-Reply-To: <20180613140411.GA32701@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [76.103.130.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0815;7:LLtMcLD4NA5rGqVoqxjcGC27lF+FTSOq3BJYe5hqLjcG8StchLEIA97wGPH9oOfxOilBch5NletpwLzwitbnCY80UCQPWPHLN085jmEGj3m0YSv0v0h3mnvXiGWH62Acn/y3qUqrJNQX9dF8A8ieX7cH+LybHkNhtgZfdMVqF36uAO6+SeRO39WEQzqn+Ld8y9WqAF52VUG9cKHIoYQ4JylVzS8jEl9TN76cOEEaQ7r5k1UbEYDHEOQdAFDjss6q;20:/QAfywEMIlNsmXGb1K6u3v+IVJMtSqgiOhgsBdkfrg8Kr3NFI/jgMaAg4rqMRlZzeA8PfawJmqvfYn6gVQA9IrevuMhIghWTtzpNGlKNHOIuNZkV3/gU4bapTOuQe1v68P4PIjn3kJOZCQ7zGJFIZl5EAhSDVeVLlKCam4h0muU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fff609a-90f0-4347-83c7-08d5d13719e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0815;
x-ms-traffictypediagnostic: MWHPR04MB0815:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0815DD37B20ECF0DBC1E24AC987E0@MWHPR04MB0815.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0815;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0815;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(39380400002)(366004)(376002)(346002)(189003)(199004)(93886005)(2906002)(5660300001)(36756003)(97736004)(118296001)(486006)(186003)(102836004)(6486002)(26005)(229853002)(76176011)(6116002)(6436002)(6506007)(3846002)(59450400001)(6246003)(2616005)(86362001)(110136005)(106356001)(68736007)(54906003)(72206003)(81166006)(476003)(81156014)(478600001)(14454004)(7736002)(305945005)(25786009)(5890100001)(446003)(8676002)(4326008)(39060400002)(316002)(105586002)(3660700001)(99286004)(2501003)(11346002)(8936002)(5250100002)(53936002)(66066001)(2900100001)(6512007)(3280700002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0815;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: rf/E8+0do1FXevoW03l9J5WqCaGoFJ714r7/oOfDFUlxcqtuCdT9bUPjqzYh0TjNKF6SFd2few9E6US4g2Pjf289VSckxNX09YFh0acz6iZKaeJ+A4fa1p9oQxVC7yMJ67eOpRQjJOMUFqsxwTbeMED0mFIcorrniiv2Yhl0VkhFJ/9Pf1l0/GIyZWLBjh8B
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB4F3E66E50E8E4B81BCAD42760E67F7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fff609a-90f0-4347-83c7-08d5d13719e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 14:08:12.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTEzIGF0IDE2OjA0ICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiA+
IEkgc3VzcGVjdCB0aGlzIGlzIGR1ZSB0byB3ZSBjb3VsZCBleHBpcmUgYSBzYW1lIHJlcXVlc3Qg
dHdpY2Ugb3IgZXZlbiBtb3JlLg0KPiA+IEZvciBzY3NpIG1pZC1sYXllciwgaXQgcmV0dXJuIEJM
S19FSF9ET05FIGZyb20gLnRpbWVvdXQsIGluIGZhY3QsIHRoZSByZXF1ZXN0IGlzIG5vdA0KPiA+
IGNvbXBsZXRlZCB0aGVyZSwgYnV0IGp1c3QgcXVldWUgYSBkZWxheWVkIGFib3J0X3dvcmsgKEha
LzEwMCkuIElmIHRoZSBibGtfbXFfdGltZW91dF93b3JrDQo+ID4gcnVucyBhZ2FpbiBiZWZvcmUg
dGhlIGFib3J0X3dvcmssIHRoZSByZXF1ZXN0IHdpbGwgYmUgdGltZWQgb3V0IGFnYWluLCBiZWNh
dXNlIHRoZXJlIGlzIG5vdA0KPiA+IGFueSBtYXJrIG9uIGl0IHRvIGlkZW50aWZ5IHRoaXMgcmVx
dWVzdCBoYXMgYmVlbiB0aW1lZCBvdXQuDQo+ID4gDQo+ID4gV291bGQgcGxlYXNlIHRyeSB0aGUg
cGF0Y2ggYXR0YWNoZWQgb24gdG8gc2VlIHdoZXRoZXIgdGhpcyBpc3N1ZSBjb3VsZCBiZSBmaXhl
ZCA/DQo+ID4gKHRoaXMgcGF0Y2ggb25seSB3b3JrcyBmb3Igc2NzaSBkZXZpY2UgY3VycmVudGx5
KQ0KPiANCj4gVGhlIHBhdGNoIGlzbid0IHJlYWxseSBnb2luZyB0byB3b3JrIHdpdGhvdXQgYSBj
YWxsZXIgb2YgeW91ciBuZXcNCj4gX19ibGtfbXFfY29tcGxldGVfcmVxdWVzdCBoZWxwZXIsIGlz
IGl0Pw0KDQpfX2Jsa19tcV9jb21wbGV0ZV9yZXF1ZXN0KCkgaXMgYWxyZWFkeSBjYWxsZWQgdG9k
YXkgYnkgYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QoKS4NCkhvd2V2ZXIsIGl0J3Mgbm90IGNsZWFy
IHRvIG1lIHdoeSB0aGF0IGZ1bmN0aW9uIGlzIGV4cG9ydGVkIGJ5IEppYW5jaGFvJ3MgcGF0Y2gu
DQoNCj4gRWl0aGVyIHdheSB0aGUgY29uY2VwdCBvZiBkb2luZyBlcnJvciBoYW5kbGluZyB3aXRo
b3V0IHF1aWVzY2luZyB0aGUNCj4gcXVldWUganVzdCBsb29rcyBib2d1cyB0byBtZSBhbmQgd2ls
bCBlbmQgdXAgd2l0aCBzb21lIHNvcnQgb2YgcmFjZQ0KPiBoZXJlIG9yIHRoZXJlLg0KDQpUaGUg
U0NTSSBlcnJvciBoYW5kbGVyIGFscmVhZHkgd2FpdHMgdW50aWwgYWxsIHBlbmRpbmcgcmVxdWVz
dHMgaGF2ZSBmaW5pc2hlZA0KYmVmb3JlIGl0IHN0YXJ0cyBoYW5kbGluZyB0aW1lZCBvdXQgY29t
bWFuZHMuIFRoaXMgZS1tYWlsIHRocmVhZCBzdGFydGVkIHdpdGggYQ0KcmVwb3J0IG9mIGEgY3Jh
c2ggaW4gdGhlIFNDU0kgZXJyb3IgaGFuZGxlciwgd2hpY2ggaXMgYSByZWdyZXNzaW9uIGludHJv
ZHVjZWQgaW4NCnRoZSB2NC4xOCBtZXJnZSB3aW5kb3cuDQoNCkJhcnQuDQoNCg0K
