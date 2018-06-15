Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC21C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB14C208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aMjy+zC+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZzwZ8sCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB14C208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756600AbeFOVB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:01:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46231 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756127AbeFOVBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1529096516; x=1560632516;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=9AGO3XXCeNvMgHs0sURzFqFFnu4brxGsx0FujbczBwU=;
  b=aMjy+zC+cYHXeI9C7IIKDV4Q+i0wNMjdVutzS/ZGzqg3rAga7n7cVJlj
   CkFfZIkgL7Rcuv3vioE9pe4OC2ZaTuESYqd9HOcaIopXh6sEzkhbDvDBN
   f7I8t/JTFbT8N0LrwZrCmOXzUNXx1iI8Q/Vt2i+MddSPJZwq1Eq9yHvUw
   Em5S1kGjyU3po4ehpIK1F4vHwULp/oBkCk/UQsUXxTagBoNV2m3nZrXGv
   N6eMZHemAhn0MWpwEEw1v+FAUSDG8Z1gDzfrU9V8nzketHY+vQmDCAeux
   RkzG9OTMa3PSZbPaa9wkrva9S7kIRqWgpKza2PL2eUlvY6hyJLD+8QbwH
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,228,1526313600"; 
   d="scan'208";a="81043342"
Received: from mail-by2nam03lp0051.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([216.32.180.51])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2018 05:01:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AGO3XXCeNvMgHs0sURzFqFFnu4brxGsx0FujbczBwU=;
 b=ZzwZ8sCpMmt36+PTe89rfDNEsNzPiFaXmVP00Si/WSP3EMtbBUVnMceuRJDfeuNrXA0zj5SfONr0mRgqxS3yEM/NmJMMIbxN5GXKEX1cMbQWDmbHFRAEd0yD22PMRETxMW4f9SA+bBttMxX7tVFf2C7e5EESs+JXjT6Hz9nk4oM=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0319.namprd04.prod.outlook.com (10.169.202.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Fri, 15 Jun 2018 21:01:53 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Fri, 15 Jun 2018
 21:01:53 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Tracing to console
Thread-Topic: Tracing to console
Thread-Index: AQHUBOwWr0u4eO6tCUCZoez+yTdsHA==
Date:   Fri, 15 Jun 2018 21:01:53 +0000
Message-ID: <08fe327a686f590008de3d6f43c880c655c648c2.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0319;7:s7jKODw7SZR3iIHln/Si0hJCCVERkMLpXo91x8fQ4WK4HoYaFYrzlb2v6RDHmuhpuq7bD4l1e/FFi3B1YLG2UY+kOlnuoxfSTSkQpEfYPv5UqL08b2S8P7XyOxxhrb9ZdtvRVhjcIXpPzKdhKYiCxr9GU1hsxH9OjgzwYEoohp5Bm/EF666drqCqP+V7Lp4608iAspX3HpjlcHhsVG5txIbU72lPJD754vvPAwAa+C0IVr7J5o1SAdC1Y4YLVkiW;20:wkI9IGPQ0ggpPrvZZvDbkC7CqkFoDV6kseS0I+V27xSzIOWa9MImSTLyMK/MmbW4Y4ZyW4MY9X7IotblgNjzBILUJIOP8YIgG0kLErcbwXX1KYI6m0lv5pwClkCKdxp1kpxxd5MoP8fCJBqNQn3OMi0tgnMt6z0rX06cbGgd3lY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92f012b5-a27f-48da-6718-08d5d30338c9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0319;
x-ms-traffictypediagnostic: MWHPR04MB0319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB03196F27E4214CBC5E8F3DB8987C0@MWHPR04MB0319.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0319;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0319;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(39380400002)(346002)(366004)(189003)(199004)(1730700003)(106356001)(2906002)(478600001)(7116003)(2900100001)(316002)(305945005)(5660300001)(5250100002)(2351001)(8676002)(7736002)(72206003)(99286004)(2501003)(68736007)(14454004)(81166006)(4326008)(53936002)(25786009)(54906003)(81156014)(3480700004)(5640700003)(6512007)(6116002)(6436002)(3846002)(118296001)(6486002)(6916009)(6506007)(3660700001)(105586002)(86362001)(8936002)(97736004)(26005)(3280700002)(36756003)(486006)(186003)(2616005)(66066001)(476003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0319;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HgGnrAd8WzWxyVvhOBvj9PxyJ6P28xFoEDDLnsRrVjkjyHz3+2VxVV4woxTF6OWUHD7VTY1b7P+GgOGk2/1P3iWqxk0NmqJzrRwA8VyNYLmRyv0uThn9QNPTMTRt4vvK8VniZrlD+vPU79KOzNDujK2depeSjCrzYsOdFOy7yawHzIY7dTxpkJaZMIRT5N1O
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <77A95CD772939F49BB771D0A8FD4DAB1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f012b5-a27f-48da-6718-08d5d30338c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 21:01:53.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU3RldmVuLA0KDQpJZiBJIHJ1biB0aGUgZm9sbG93aW5nIGNvbW1hbmRzIGFzIHJvb3Q6
DQoNCmNkIC9zeXMva2VybmVsL2RlYnVnL3RyYWNpbmcNCmdyZXAgcG1fIGF2YWlsYWJsZV9ldmVu
dHMgPiBzZXRfZXZlbnQNCmVjaG8gZnVuY3Rpb24gPmN1cnJlbnRfdHJhY2VyDQpncmVwIHNjc2lf
IGF2YWlsYWJsZV9maWx0ZXJfZnVuY3Rpb25zIHwgd2hpbGUgcmVhZCBhIGI7IGRvIGVjaG8gJGE7
IGRvbmUgPnNldF9mdHJhY2VfZmlsdGVyDQplY2hvIDEgPmV2ZW50cy9wcmludGsvZW5hYmxlDQpl
Y2hvIDEgPnRyYWNpbmdfb24NCmVjaG8gMSA+L3Byb2Mvc3lzL2tlcm5lbC90cmFjZXBvaW50X3By
aW50aw0KZWNobyAtIC0gLSA+L3N5cy9jbGFzcy9zY3NpX2hvc3QvaG9zdDAvc2Nhbg0KDQp0aGVu
IHRoZSBmb2xsb3dpbmcgYXBwZWFycyBvbiB0aGUgY29uc29sZToNCg0KY29uc29sZTogYXRhMTog
U0FUQSBsaW5rIHVwIDEuNSBHYnBzIChTU3RhdHVzIDExMyBTQ29udHJvbCAzMDApDQpjb25zb2xl
OiBjb25zb2xlOiBhdGExOiBTQVRBIGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEzIFNDb250
cm9sIDMwMCkNCmNvbnNvbGU6IGNvbnNvbGU6IGNvbnNvbGU6IGF0YTE6IFNBVEEgbGluayB1cCAx
LjUgR2JwcyAoU1N0YXR1cyAxMTMgU0NvbnRyb2wgMzAwKQ0KY29uc29sZTogY29uc29sZTogY29u
c29sZTogY29uc29sZTogYXRhMTogU0FUQSBsaW5rIHVwIDEuNSBHYnBzIChTU3RhdHVzIDExMyBT
Q29udHJvbCAzMDApDQpjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xl
OiBhdGExOiBTQVRBIGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEzIFNDb250cm9sIDMwMCkN
CmNvbnNvbGU6IGNvbnNvbGU6IGNvbnNvbGU6IGNvbnNvbGU6IGNvbnNvbGU6IGNvbnNvbGU6IGF0
YTE6IFNBVEEgbGluayB1cCAxLjUgR2JwcyAoU1N0YXR1cyAxMTMgU0NvbnRyb2wgMzAwKQ0KY29u
c29sZTogY29uc29sZTogY29uc29sZTogY29uc29sZTogY29uc29sZTogY29uc29sZTogY29uc29s
ZTogYXRhMTogU0FUQSBsaW5rIHVwIDEuNSBHYnBzIChTU3RhdHVzIDExMyBTQ29udHJvbCAzMDAp
DQpjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBj
b25zb2xlOiBjb25zb2xlOiBhdGExOiBTQVRBIGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEz
IFNDb250cm9sIDMwMCkNCmNvbnNvbGU6IGNvbnNvbGU6IGNvbnNvbGU6IGNvbnNvbGU6IGNvbnNv
bGU6IGNvbnNvbGU6IGNvbnNvbGU6IGNvbnNvbGU6IGNvbnNvbGU6IGF0YTE6IFNBVEEgbGluayB1
cCAxLjUgR2JwcyAoU1N0YXR1cyAxMTMgU0NvbnRyb2wgMzAwKQ0KY29uc29sZTogY29uc29sZTog
Y29uc29sZTogY29uc29sZTogY29uc29sZTogY29uc29sZTogY29uc29sZTogY29uc29sZTogY29u
c29sZTogY29uc29sZTogYXRhMTogU0FUQSBsaW5rIHVwIDEuNSBHYnBzIChTU3RhdHVzIDExMyBT
Q29udHJvbCAzMDApDQpjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xl
OiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBjb25zb2xlOiBh
dGExOiBTQVRBIGxpbmsgdXAgMS41IEdicHMgKFNTdGF0dXMgMTEzIFNDb250cm9sIDMwMCkNClsg
Li4uIF0NCg0KSSBhc3N1bWUgdGhhdCB0aGUgcmVwZWF0ZWQgImNvbnNvbGU6ICIgcHJlZml4IGlz
IGEgYnVnIGFuZCBhbHNvIHRoYXQgdGhlIHNhbWUNCmxpbmUgcmVwZWF0cyBvdmVyIGFuZCBvdmVy
IGFnYWluIGlzIGFsc28gYSBidWc/IEkgcmFuIGludG8gdGhpcyB3aXRoIGNvbW1pdA0KMDE3YjNm
OGExMGNhICgic2NzaTogc25pYzogZml4IGEgY291cGxlIG9mIHNwZWxsaW5nIG1pc3Rha2VzOiAi
Q09NUExFVEUiIikuDQoNClRoYW5rcywNCg0KQmFydC4NCg0KDQoNCg==
