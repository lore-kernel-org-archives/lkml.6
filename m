Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870C1C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33ED7208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H7z7iONm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WdcDhPJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33ED7208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966371AbeFOU66 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:58:58 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15711 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966191AbeFOU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529096334; x=1560632334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gt1uuIUkbPMwuME133TmDcrfBYTxLyzYi7LKCTp3O9I=;
  b=H7z7iONmJbfip6I3CmfJ0IwGh1Fhz+fbA6ngyIV2dFBemNwK2TjDABAj
   O8YFccqakysE0T2EP9Fe2nW+OSkhRuIG/IUz20qvXtCIUtsjTAVycpB4A
   j/gD5WFuWojcuWNzNqSakHH0MhHhVcM4k+iLDwFRpt86K+1TzR9Dsn5ac
   +rniJVUpoRDRGkGW0/VdSIn9wuorkajXIBIYxgq1lN1ru7oQKRM3yfAn5
   SAfVnmxZSM0C/ixeib0WxJ175djBRMpW2gD5giHdQZM73q6lnmlFfuKWx
   0YiP/e2P6l/rBzFd5ZcoBbVwdNZAtJarplgeSp3F3VtndGad1TKmJM4s2
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,228,1526313600"; 
   d="scan'208";a="81639201"
Received: from mail-by2nam03lp0054.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([216.32.180.54])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2018 04:58:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt1uuIUkbPMwuME133TmDcrfBYTxLyzYi7LKCTp3O9I=;
 b=WdcDhPJ0eFe/XKKdv2Or/xH/zmokCC/xzRnn/ALOgByWOSdCSRAzvhi46udJcdXvykZj5c6uBZLKPjDc03rtyO4uWLsOX8kSPZ3XBevPcGkE6Fodd6o/giOwN+MXExZSfbI8+Z2oJv6EZ7gvhQLSbkBpB6CSNgvrq3+SXWypt/Q=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1056.namprd04.prod.outlook.com (10.174.250.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Fri, 15 Jun 2018 20:58:49 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Fri, 15 Jun 2018
 20:58:49 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>
CC:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "malat@debian.org" <malat@debian.org>
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
Thread-Topic: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
Thread-Index: AQHT/xje5+JCDxl7jUynLYZDAEp07KRdCFwAgAKgeICAACH+gIACCF0AgAABbACAAAL+AIAAAYOA
Date:   Fri, 15 Jun 2018 20:58:49 +0000
Message-ID: <a097db0b6a48533ceb6d45f1857e7068c905369c.camel@wdc.com>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
         <1528455990-24572-2-git-send-email-sayalil@codeaurora.org>
         <20180612192636.GA31725@rob-hp-laptop>
         <000101d403d3$87210d20$95632760$@codeaurora.org>
         <33eec86a35248e5b20f15bb568641b9affcc0a9b.camel@wdc.com>
         <95985.1529095054@turing-police.cc.vt.edu>
         <347237a7f32b79aa516aa285700396052a69ccf8.camel@wdc.com>
         <204056.1529096002@turing-police.cc.vt.edu>
In-Reply-To: <204056.1529096002@turing-police.cc.vt.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1056;7:Bqn1sbFb8LsMzoTEn4yeEWFL7b9iUgkOu/5SOE6fxJh1PKDSUsOk7gU+9eZYj/hKICXd0nLNoPgMtbJZAPqJtn7M5sSgZp0/k/968iHpZd8JOQTy1+6j6IermqAGJdVEUvv/CFFul+XbHC5cPb+hKhdD9d0aVooNzDg2swjVKUCtLfcnBFg58oAgvFkzzHmfB2P/zlMEH/NHohFWxketa2Ai48Pvgz4XrohgmQhkm0Ntv8Bn5acsnp5ll6ePipfK;20:2wNaIoTp5HmBEkzK3UaDMfsLVGTPNgk4bJtAadBSYMSQb+hQ1shxVoVmCYRJ1eukXdQ6lPbEtwSBPKeM1sN7KKAPimWY73wHGiq1+0jPacbV5j7vRkdVsT+XlMq6Pbq23De4GdYd3RvWRo1pK65gy5mEicssLSYnSKdW5kTDZgs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4aacf62e-05a7-4801-e12f-08d5d302cb2b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1056;
x-ms-traffictypediagnostic: MWHPR04MB1056:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1056FC39B3AE92F4A8CF4CEC987C0@MWHPR04MB1056.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1056;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1056;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(39380400002)(396003)(189003)(199004)(76176011)(54906003)(105586002)(6246003)(6436002)(8936002)(446003)(2171002)(6916009)(2501003)(8676002)(316002)(106356001)(5250100002)(93886005)(4326008)(39060400002)(486006)(53936002)(5660300001)(99286004)(7736002)(26005)(6116002)(6486002)(2906002)(5640700003)(2351001)(97736004)(478600001)(86362001)(81156014)(3660700001)(186003)(68736007)(81166006)(229853002)(305945005)(11346002)(118296001)(7416002)(66066001)(2616005)(14454004)(2900100001)(102836004)(476003)(6506007)(72206003)(25786009)(3280700002)(36756003)(3846002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1056;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Jn54OMPfy/wFj12AibiGI2obTRJ2g0QMqmYTcl2TUFUuFwukZo53BFesJOIDHVTfwVaoQ3y3FoeUh2+oLWW8bI+oOFk87bh82eQvFZyQnRmyjxOflp6U9RrhjF/vZeWq5xjaEQgOaqg+6mroDnyycmjawKiYo1cQzOjJwqzNisFE3XeBXStCrUfU0RzIgpR8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD7FF7FFAD4D2C4BB71EF952B7EB00D6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aacf62e-05a7-4801-e12f-08d5d302cb2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 20:58:49.3868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA2LTE1IGF0IDE2OjUzIC0wNDAwLCB2YWxkaXMua2xldG5pZWtzQHZ0LmVk
dSB3cm90ZToNCj4gT24gRnJpLCAxNSBKdW4gMjAxOCAyMDo0Mjo0MSAtMDAwMCwgQmFydCBWYW4g
QXNzY2hlIHNhaWQ6DQo+ID4gSW4gY2FzZSBJIHdhc24ndCBjbGVhciBlbm91Z2g6IEkgd2FzIHJl
ZmVycmluZyB0byByZXBseWluZyBpbmxpbmUNCj4gPiAqd2l0aG91dCogcXVvdGluZyB0aGUgb3Jp
Z2luYWwgbWVzc2FnZS4gVGhhdCBtYWtlcyBhIGNvbnZlcnNhdGlvbg0KPiA+ICpyZWFsbHkqIGhh
cmQgdG8gZm9sbG93Lg0KPiANCj4gU28gaWYgdGhlcmUncyBubyBxdW90ZWQgbWVzc2FnZSwgd2hh
dCBpcyB0aGUgaW5saW5lIHJlcGx5IGlubGluZWQgaW50bz8gOikNCg0KSSB3YXMgcmVmZXJyaW5n
IHRvIHF1b3Rpbmcgd2l0aG91dCBpbmRlbnRpbmcgdGhlIHF1b3RlIHdpdGggIj4gIi4gVGhhdA0K
c2hvdWxkIGFscmVhZHkgaGF2ZSBiZWVuIGNsZWFyIGlmIHlvdSBoYWQgYSBsb29rIGF0IHRoZSBt
ZXNzYWdlIEkgY29tcGxhaW5lZA0KYWJvdXQuDQoNCkJhcnQuDQoNCg0KDQo=
