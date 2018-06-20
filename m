Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F934C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1492D20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ne2P4FLe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WbBrzCZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1492D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeFTQTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:19:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27305 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbeFTQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529511542; x=1561047542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QGD22alnab73Tl87qzD/WPOEIHnvQVGgRaV4B6QSfGo=;
  b=Ne2P4FLeP3XJBfxsmltJOg8S5pnvSEXLCVwd7npArbzdrGGUYJBckVa8
   sRQoF5vaWzF0OwqiWnSkJqaXVvFuz2kT8TWNp5hMr/YBd+GkCB/UEQXVH
   w3q5VRXtaUPS+9MtXF5Hu7w9+9jugq4wSQMMPtLBBsPXLntK/9LueNkno
   s+OS9NhJQZZK4bx+D9ZUgnovmGaYHnw1ekUu5Ndxy6cZ5KthnS/k97sdU
   xadAOeeoBVCA87WIanw7lr5Bp27XiZV7VBarKVaQaSFnb7r7K0ttCzMBT
   BZLoT7231xXxJvTPdv2tDJb1uyziy8Kqe5mQyT0mnNHXWe8ggIAPuc4+1
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,248,1526313600"; 
   d="scan'208";a="82121018"
Received: from mail-bl2nam02lp0085.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.85])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2018 00:18:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGD22alnab73Tl87qzD/WPOEIHnvQVGgRaV4B6QSfGo=;
 b=WbBrzCZRJC+IvwCYqzYpnfOVflgW/kDPDqhEfOBOcCT+CHmu+oAOtg5MOETHEV3beg/DRYUqhpEPqWmqtyv3vW2ch+d989Tab64w8hj3jk9hsM5tqHAE6qDfQkB62g7vZxuy+luptDw1Ikt8NCCuNrE/O2pfi3075bu8r7KwmXg=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0542.namprd04.prod.outlook.com (10.173.49.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Wed, 20 Jun 2018 16:18:49 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 16:18:49 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
Thread-Topic: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
Thread-Index: AQHUB5sTat++auXTF02av9K10QZViaRnsvCAgAC1SICAAO1OAA==
Date:   Wed, 20 Jun 2018 16:18:49 +0000
Message-ID: <2c2003ff1baac05688495677f67239d52f6d9527.camel@wdc.com>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
         <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
         <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
In-Reply-To: <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0542;7:jMy2cWwUZXYc/ovNfbDWe982AIWBnrLf8sgOcNNAvf/cw4mx1YE9xMERJ6Uynmd3qXtPqH28zZEBeoQqQf3lLUjsoIhVUGyts3+CG/sGfWSye2vylAHcvNHOB+xLygTBWZrfxJru/xPQ5xSFxGipc8X4H3SScy6sctLoomHxKngz98tOPUSgPfqJ+tmuJbaL13UQJVJsakcoqWeZ0/1TFy/1NNLPxVv7b0g245iyZFZuSRgfot/wRHrIB1jn77Ju;20:VIHtCh+UolIJOgpljziGrfadr2U/qHYus69wlwekzPfYkHcnaokEtAmB1DDsMfQ6CRg0HAX6VybTBph4eXbiQL6uhF/8yDPpLMcIJfzb1Ukheb4a2lVFvYPfqoYXyL2+H4zrlNQ45ZUrAkM1VO/Fw53vwl3E6uw7i4ho5SXBKAc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: be1569a0-abf3-4288-049d-08d5d6c981ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0542;
x-ms-traffictypediagnostic: MWHPR04MB0542:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB05420270358E9E3B3DF5DB9398770@MWHPR04MB0542.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0542;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0542;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(66066001)(14454004)(118296001)(53936002)(105586002)(2616005)(186003)(2906002)(3846002)(6512007)(6306002)(6116002)(72206003)(106356001)(36756003)(6486002)(6436002)(4326008)(3280700002)(3660700001)(6246003)(11346002)(25786009)(2900100001)(476003)(446003)(5250100002)(86362001)(68736007)(6506007)(54906003)(59450400001)(305945005)(8936002)(110136005)(97736004)(99286004)(316002)(81166006)(5660300001)(102836004)(486006)(76176011)(2501003)(478600001)(7736002)(26005)(81156014)(229853002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0542;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: u4FXDM3pgdurRx/jcKIrnUhZTmtJTnV/F8ksbESmvtQ4PpR8OiqTPVMhQxuLkYZCBeGpuKYab6iLEOaxlXYFRQEmpnNl6cUbnR6S7Mcm2Frcjr4TYvuK6kg/uTEiWJOD6hx3FlH2kkuvUwiJ0NFDmiNZUu0OPsFmHn+iW/WCwa7rxodzQbVVgukpX3TMgkHd8VTnHeNHTdZZo1g+XPPQTTTa49MOdHsMYB50RuBlnSseZ4JhrDLs9Ra7TQo8yHb0AldU5NKy1Sqx1V+M+99vvWjf1ZGw3Zw9frNNzV2SMcmwvD4pTc6iexT9DKiRvqYf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <841C793036088C4F8685A2B03D294933@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1569a0-abf3-4288-049d-08d5d6c981ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 16:18:49.2541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0542
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTIwIGF0IDEwOjA5ICswODAwLCBqaWFuY2hhby53YW5nIHdyb3RlOg0K
PiBJdCBpcyB2ZXJ5IGVhc3kgdG8gcmVwcm9kdWNlIHdpdGggZm9sbG93aW5nIHNjcmlwdHMuDQo+
IA0KPiBzY3JpcHQgMA0KPiB3aGlsZSB0cnVlDQo+IGRvDQo+IAltb2Rwcm9iZSBudWxsX2JsayBx
dWV1ZV9tb2RlPTIgc2hhcmVkX3RhZ3M9MQ0KPiAJc2xlZXAgMC4xDQo+IAlybW1vZCBudWxsX2Js
aw0KPiAJc2xlZXAgMC4xDQo+IGRvbmUNCj4gDQo+IHNjcmlwdCAxDQo+IGZpbGUwPSIvc3lzL2Js
b2NrL251bGxiMC9tcS8wL25yX3RhZ3MiDQo+IGZpbGUxPSIvc3lzL2Jsb2NrL251bGxiMC9tcS8w
L2NwdTAvcnFfbGlzdCINCj4gd2hpbGUgdHJ1ZTsNCj4gZG8NCj4gCWlmIFsgLWUgJGZpbGUwIF07
dGhlbg0KPiAJCWNhdCAkZmlsZTANCj4gCWZpDQo+IAlpZiBbIC1lICRmaWxlMSBdO3RoZW4NCj4g
CQljYXQgJGZpbGUxDQo+IAlmaQ0KPiBkb25lDQoNCkhlbGxvIEppYW5jaGFvLA0KDQpUaGFua3Mg
Zm9yIGhhdmluZyBzaGFyZWQgYSByZXByb2R1Y2VyLiBIb3dldmVyLCB0aGUgYXBwcm9hY2ggb2Yg
dGhlIHBhdGNoIHlvdQ0KcG9zdGVkIGRvZXNuJ3Qgc2VlbSBsaWtlIHRoZSByaWdodCBhcHByb2Fj
aCB0byBtZS4gSSBwcm9wb3NlIHRvIHByb2NlZWQgYXMNCmZvbGxvd3M6DQoqIENvbnZlcnQgdGhl
IHJlcHJvZHVjZXIgaW50byBhIGJsa3Rlc3RzIHRlc3QgYW5kIHN1Ym1pdCBpcyBhcyBhIHBhdGNo
IHRvIHRoZQ0KICBibGt0ZXN0cyBwcm9qZWN0IChodHRwczovL2dpdGh1Yi5jb20vb3NhbmRvdi9i
bGt0ZXN0cykuDQoqIFJlbW92ZSB0aGUgbXV0ZXhfbG9jay91bmxvY2soJnN5c2ZzX2xvY2spIGNh
bGxzIGZyb20gYmxrX2NsZWFudXBfcXVldWUoKS4NCiAgVGhlc2UgY2FsbHMgYXJlIHVzZWxlc3Mu
ICBCbG9jayBkcml2ZXJzIGFyZSByZXF1aXJlZCB0byBjYWxsIGRlbF9nZW5kaXNrKCkNCiAgYmVm
b3JlIGNhbGxpbmcgYmxrX2NsZWFudXBfcXVldWUoKS4gVGhhdCBtZWFucyB0aGF0IHN5c2ZzIGF0
dHJpYnV0ZXMgYXJlDQogIHJlbW92ZWQgc3luY2hyb25vdXNseSBiZWZvcmUgYmxrX2NsZWFudXBf
cXVldWUoKSBpcyBjYWxsZWQuIFRoZSBmb2xsb3dpbmcNCiAgc3RhdGVtZW50IGluIGJsa19jbGVh
bnVwX3F1ZXVlKCkgdmVyaWZpZXMgdGhhdDoNCiAgICBXQVJOX09OX09OQ0UocS0+a29iai5zdGF0
ZV9pbl9zeXNmcyk7DQogIEJUVywgdGhpcyBhbHNvIG1lYW5zIHRoYXQgdGhlIGJsa19xdWV1ZV9k
eWluZygpIGNoZWNrcyBpbiB2YXJpb3VzIHNob3cgYW5kDQogIHN0b3JlIG1ldGhvZHMgYXJlIHN1
cGVyZmx1b3VzLg0KKiBJbnRyb2R1Y2UgYSBuZXcgbXV0ZXggdG8gc2VyaWFsaXplIGJsa19tcV9y
ZWdpc3Rlcl9kZXYoKSBhbmQNCiAgYmxrX21xX3N5c2ZzX3JlZ2lzdGVyKCkgYW5kIGJsa19tcV9z
eXNmc191bnJlZ2lzdGVyKCkuIEkgdGhpbmsgaXQgaXMgd3JvbmcNCiAgdGhhdCB0aGVzZSBmdW5j
dGlvbnMgdXNlIHN5c2ZzX211dGV4Lg0KKiBEb2N1bWVudCB0aGUgcHVycG9zZSBvZiBzeXNmc19t
dXRleCBpbiBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oLCBuYW1lbHkgdG8NCiAgc2VyaWFsaXplIHRo
ZSBzeXNmcyAuc2hvdygpIGFuZCAuc3RvcmUoKSBjYWxsYmFjayBmdW5jdGlvbnMgYW5kIGFsc28g
dG8NCiAgc2VyaWFsaXplIGVsZXZhdG9yIGNoYW5nZXMuDQoNClRoYW5rcywNCg0KQmFydC4NCg0K
DQo=
