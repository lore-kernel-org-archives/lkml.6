Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B20F9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBA2208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JD63SSZU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j0i0fCg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBA2208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755336AbeFNNfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:35:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43137 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754957AbeFNNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528983314; x=1560519314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AavmdhvQIYe1gZayGoL/j82L6rNfMrIsopNj6NKuLCo=;
  b=JD63SSZUqOe0W7UEo5EUCOWk/QFmMAG6LaBlvPMhfXjO/ScnhOtUKD79
   HQBst9lt77lxUVdAgAaNCBPi3WCspT0mhKaPfYbi5iiaSMrvM9Or/fY5m
   wdCZxcSS3ZtEEQRQEAhwwgBOZAiKTzo/SjYBlJP3Wajm2umO1pUHv+t6I
   XA5kk3ltLP9Xu7KBfmDGkYuLse3Nea4wrKH+Zp0rMpsyOqHp2mxG+w6tB
   vnPgOjL3WujXWLxGYALMl4Ep2cSpaMlwdvugoGFFVF0IV+stenMkszGRK
   1E5/HIKaCd5typj0JdhlNfjEEH/xtt21xQgPOg0rM/FT6Sb/tRs2WQ3Pm
   w==;
X-IronPort-AV: E=Sophos;i="5.51,222,1526313600"; 
   d="scan'208";a="82557432"
Received: from mail-dm3nam03lp0015.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([207.46.163.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2018 21:35:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AavmdhvQIYe1gZayGoL/j82L6rNfMrIsopNj6NKuLCo=;
 b=j0i0fCg7CcNjcLftGSA5hP8Iw51Lo1TJ/4uwo1emogmssuk85D7smff33QelCCmgKJziYQLQ6yq6f4Y865/t9w/c+Fw3tdzRIsad+G4NrGfNvYrW+p9Qm6BigOKZqIx66uIM6BM0XdI+/0R5jbHp8Su6k5nRLh4kgvrhr29uoOs=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0561.namprd04.prod.outlook.com (10.173.49.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Thu, 14 Jun 2018 13:35:08 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Thu, 14 Jun 2018
 13:35:08 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "malat@debian.org" <malat@debian.org>
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
Thread-Topic: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
Thread-Index: AQHT/xje5+JCDxl7jUynLYZDAEp07KRdCFwAgAKgeICAACH+gA==
Date:   Thu, 14 Jun 2018 13:35:08 +0000
Message-ID: <33eec86a35248e5b20f15bb568641b9affcc0a9b.camel@wdc.com>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
         <1528455990-24572-2-git-send-email-sayalil@codeaurora.org>
         <20180612192636.GA31725@rob-hp-laptop>
         <000101d403d3$87210d20$95632760$@codeaurora.org>
In-Reply-To: <000101d403d3$87210d20$95632760$@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [76.103.130.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0561;7:zwIVKT3inKkKUcWGo5us8XYkAynaO4RHJjRyWqddWq5Z4QuhCDQG1ybGMVXa4Nfpi9nc/Ixv1xS5knPloH0+OeuBhzusJBPF6qUNPkL4Y0OL5zc+1l7ORkBB3u/EaasTfvLM5qKT+QCqzXPlsQXM6gS4gTaPD1Xn+p3tc5CaYBFRpoHy4v0VMgkKgHp5w1SRIxs4IRZk6pvDgDbm8Pie3JBYBrquEgr1F7E5YQj9+V7WrYb2mkL8Aw6ZP4Bh4VuG;20:8CBysfZQfgdYca5w6jOJgsAOcmfq4ciYVGjVDcG1+TnaYccbEDpopAX6HdVqfgJ9DIBJLDllpHLNR4bzX4Fy9Lt+huTe47XR+pn3e1MC9Ta7MOfcefEYBDNgtTB2W3upnBlZEi2T1Rj3yFWkoFQrnP9XUrOaMSQiIjKbeOfLF04=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 150b6d91-f242-4232-3382-08d5d1fba561
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0561;
x-ms-traffictypediagnostic: MWHPR04MB0561:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0561977A1FC9A64F31CC76F0987D0@MWHPR04MB0561.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(231250463719595);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0561;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0561;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(396003)(346002)(376002)(199004)(189003)(478600001)(68736007)(6512007)(5250100002)(59450400001)(118296001)(110136005)(186003)(7736002)(45080400002)(25786009)(446003)(26005)(3660700001)(54906003)(36756003)(8936002)(4326008)(97736004)(6116002)(72206003)(81156014)(66066001)(81166006)(305945005)(3846002)(8676002)(11346002)(53936002)(3280700002)(316002)(39060400002)(102836004)(6506007)(86362001)(6246003)(7416002)(99286004)(93886005)(14454004)(229853002)(2616005)(106356001)(6436002)(6486002)(76176011)(2906002)(5660300001)(486006)(105586002)(2900100001)(476003)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0561;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wSU2vmYcbn/B8C8myMT0JRuOy+kuqmBUiNm8RpNSIAtlzyS3d9vmULFnHjlDmgZv8f/ksJXCX4iCZk13WjYP5d+YS8aAEvB1KM3jLrK81eEZ86MaCSwtpcJOxvMPjpCKxn7LaxLHgJ9lzg2fLwrIt9+iftzedQbHHGYlZebFl4XYJ3moVWFsOUxHV/jPo1Wn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A551DE8273E98545AF0E04BE130E4A66@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150b6d91-f242-4232-3382-08d5d1fba561
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 13:35:08.3079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0561
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA2LTE0IGF0IDE3OjAzICswNTMwLCBzYXlhbGkgd3JvdGU6DQo+IENvbW1l
bnQgaW5saW5lLg0KDQpIZWxsbyBTYXlhbGksDQoNClBsZWFzZSBkb24ndCB1c2UgaW5saW5lIHJl
cGxpZXMuIFRoYXQgbWFrZXMgaXQgdmVyeSBoYXJkIHRvIGZvbGxvdyB0aGUNCmNvbnZlcnNhdGlv
bi4gQlRXLCBpbiB0aGUgaGVhZGVycyBvZiB5b3VyIGUtbWFpbCBJIGZvdW5kIHRoZSBmb2xsb3dp
bmc6DQoiWC1NYWlsZXI6IE1pY3Jvc29mdCBPdXRsb29rIDE2LjAiLiBQbGVhc2UgdXNlIGFub3Ro
ZXIgZS1tYWlsIGNsaWVudCB0aGF0IGlzDQpiZXR0ZXIgc3VpdGVkIGZvciBjb2xsYWJvcmF0aW9u
IG9uIG9wZW4gc291cmNlIG1haWxpbmcgbGlzdHMuIElmIG91dGdvaW5nDQplLW1haWxzIGhhdmUg
dG8gcGFzcyB0aHJvdWdoIGFuIEV4Y2hhbmdlIHNlcnZlciwgdGhlIGZvbGxvd2luZyBlLW1haWwg
Y2xpZW50cw0Kc3VwcG9ydCBFeGNoYW5nZSBzZXJ2ZXJzIGFuZCBhcmUgYmV0dGVyIHN1aXRlZCBm
b3Igb3BlbiBzb3VyY2UgY29sbGFib3JhdGlvbjoNCiogRXZvbHV0aW9uIChMaW51eCBvbmx5KS4N
CiogVGh1bmRlcmJpcmQgKyBFeFF1aWxsYSBwbHVnaW4uDQoqIElmIElNQVAgaGFzIGJlZW4gZW5h
YmxlZCBvbiB0aGUgRXhjaGFuZ2Ugc2VydmVyIHRoYXQgeW91IGFyZSB1c2luZyB0aGVuDQogIHRo
YXQgbWVhbnMgdGhhdCB5b3UgY2FuIGNob29zZSBmcm9tIHRoZSBtYW55IG9wZW4gc291cmNlIGUt
bWFpbCBjbGllbnRzDQogIHRoYXQgc3VwcG9ydCBJTUFQLg0KDQpUaGFua3MsDQoNCkJhcnQuDQoN
Cg0KDQo=
