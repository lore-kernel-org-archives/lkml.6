Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF5CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B472E20693
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kcLaeCYu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KIao/tU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B472E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756274AbeFOUmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:42:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26945 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbeFOUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529095367; x=1560631367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZUF4lyzBmo5ThZzv32Yx2SSD5d8TwEeZQe1+N4Z9YZU=;
  b=kcLaeCYuHOESaEOEabXvDgFRMRc3fWXKSivwitNlBPctq3j1O2DfBhVm
   4NM0C22on30l11aIkPKnx9Ej3XatbYFjXYZEyYBy05DKrwjgwGkk45OSn
   00NroXqn7FptbeZFgqOzpPB5cx2kTo5911L6TiEwr8ViU1+O79fPysXoQ
   wiqvJyNKJlKJIVn0NTX2976EL8D4prsLrMoh0r05cjWJ16ukiLdcMETmB
   sOl3YioDIr9T7eJV51zQV1J+2lL/8pskxanxm7wYaYcb/Mg79JMPLu8Du
   fPnEf7fQ4mtdGsYprSNJm95m2fsOm/H2YO5ui689WL4w1KkWuUz/gxuig
   A==;
X-IronPort-AV: E=Sophos;i="5.51,228,1526313600"; 
   d="scan'208";a="80542259"
Received: from mail-sn1nam01lp0114.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.114])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2018 04:42:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUF4lyzBmo5ThZzv32Yx2SSD5d8TwEeZQe1+N4Z9YZU=;
 b=KIao/tU+RbOCZDJjprM0e/dVuc5VyDs1JgbOCkMMkNU2My458in5W8/uDnjLzvdUtNLAwZITIoRn8XOw53hK+LH9R6L6vjs5RUivh01iR+vnpt6yMJZMtFdGxwHbHxVbTZKvt7EdZ5O8XOFeaoiQlgXSJAAMorXNefg81gn80Fc=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0399.namprd04.prod.outlook.com (10.173.48.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 15 Jun 2018 20:42:41 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Fri, 15 Jun 2018
 20:42:41 +0000
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
Thread-Index: AQHT/xje5+JCDxl7jUynLYZDAEp07KRdCFwAgAKgeICAACH+gIACCF0AgAABbAA=
Date:   Fri, 15 Jun 2018 20:42:41 +0000
Message-ID: <347237a7f32b79aa516aa285700396052a69ccf8.camel@wdc.com>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
         <1528455990-24572-2-git-send-email-sayalil@codeaurora.org>
         <20180612192636.GA31725@rob-hp-laptop>
         <000101d403d3$87210d20$95632760$@codeaurora.org>
         <33eec86a35248e5b20f15bb568641b9affcc0a9b.camel@wdc.com>
         <95985.1529095054@turing-police.cc.vt.edu>
In-Reply-To: <95985.1529095054@turing-police.cc.vt.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0399;7:bo/0fRoh6yG2jj9L407L/LOYCJl8qFLK27WzgIWNYnm6sj14ngYaXBVXexmSGpNo4a3sdJDK4yepNCQt+Lk7e8m5VjuiiQlfrF6m4kH2N0w455Sy/MLiGl52UY6xTzxQdJfqcEyBjX21ty+zX/F09a8ChoPiomFPxuAUaNIBlndo4cyOdhcgq4Qmco3mmgc9osTk5Ps5JMOYuCBc/mYmWHsDfs+aAnqX/doNOllalu43LXlD1roJNescm5iUaRlu;20:hShC0qXbOpwT4krLb7OhKX9mbz++dkHuRAW5kXKxEv1Y5ZMLyaXednD6XpGZ/HZs3+eN7Bs4Ut7y6AOUOZ87hifUPh1vfoMKVXJpTkvibdIVsIQ2idelvQIbjaT2NztG5CrUOfBUyWiVaLe1uejjzMDST0qdYj0AZN5LAA/nFRA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9dad99e8-552e-43d9-6e0d-08d5d3008a52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0399;
x-ms-traffictypediagnostic: MWHPR04MB0399:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB039977436C7B8622B69C5EDB987C0@MWHPR04MB0399.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0399;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0399;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(366004)(376002)(39380400002)(199004)(189003)(4326008)(72206003)(66066001)(39060400002)(478600001)(229853002)(305945005)(6486002)(105586002)(106356001)(54906003)(486006)(7736002)(316002)(99286004)(86362001)(2616005)(11346002)(25786009)(97736004)(476003)(93886005)(36756003)(26005)(5250100002)(186003)(6916009)(68736007)(2501003)(14454004)(2351001)(6436002)(446003)(102836004)(6506007)(76176011)(8936002)(558084003)(8676002)(3660700001)(3280700002)(2906002)(6116002)(3846002)(81156014)(7416002)(81166006)(118296001)(53936002)(5660300001)(2171002)(6512007)(2900100001)(6246003)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0399;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /TnEL2trJ2lMPSU/1lPylKyvNnBwC2I/FJ6CgXAYNCqfsyrL0U1Di50rFWN7Gdb8SEjk2nMxWs9bKLsiCqGWGRT3h23qjtUjSSGH0D4UYSYTKe7HQzwYDNCTSl4ELrDstnYsJDUonFnGCjPSmQqP5auhM8ckIe5KewV9X0KwliyYEmATRAHWHxBKc4ZhEd7d
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <01F51899DCBDB8468891B986C1F8E17F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dad99e8-552e-43d9-6e0d-08d5d3008a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 20:42:41.5420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA2LTE1IGF0IDE2OjM3IC0wNDAwLCB2YWxkaXMua2xldG5pZWtzQHZ0LmVk
dSB3cm90ZToNCj4gQWN0dWFsbHksIGl0IG1ha2VzIGl0IGVhc2llciB0byBmb2xsb3cgdGhlIGNv
bnZlcnNhdGlvbi4NCg0KSW4gY2FzZSBJIHdhc24ndCBjbGVhciBlbm91Z2g6IEkgd2FzIHJlZmVy
cmluZyB0byByZXBseWluZyBpbmxpbmUNCip3aXRob3V0KiBxdW90aW5nIHRoZSBvcmlnaW5hbCBt
ZXNzYWdlLiBUaGF0IG1ha2VzIGEgY29udmVyc2F0aW9uDQoqcmVhbGx5KiBoYXJkIHRvIGZvbGxv
dy4NCg0KQmFydC4NCg0KDQoNCg==
