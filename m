Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6AD24003
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bTaZSOBw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hPxK6KwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6AD24003
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754043AbeGEREJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:04:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3872 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753664AbeGEREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530810248; x=1562346248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=etNy9b4+8IfVrWiLwec/plDj8NzFWpCeCOU6Ym90tXQ=;
  b=bTaZSOBws1IzJBddTCM4nACIk7XmpLQY85hfLygXB/qiDORrlUMBs0ju
   cMxb8GAfG8SnIQF4C6nwrBW6JMupcntoYhzn0qHttvclA/mThus5wcIxC
   OYcvfieXmMawehEXv8QADAdf2dcIlKFQDk03FB2PUaU55h4r7H2twWpQr
   48b8am4xrU7HN8x5zRS1DUunDUrl0Berq1UhmIg/QN3HslUtQsGVs4lHw
   sbDST/y217Kc/l8r78N77fK1S8vWCfFySyDB+BNaZqe4aPiH/iW2DiOiZ
   8k4LCb83YZfhUQ82w/9OZDg4Bo16or971DtweB9BPXMgERxNtdSyrmlMn
   g==;
X-IronPort-AV: E=Sophos;i="5.51,313,1526313600"; 
   d="scan'208";a="83322935"
Received: from mail-by2nam03lp0047.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([216.32.180.47])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2018 01:04:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etNy9b4+8IfVrWiLwec/plDj8NzFWpCeCOU6Ym90tXQ=;
 b=hPxK6KwA0vEhWvMci9NDP0+2uuDkkkZKkRtNZyGs5o1QEXRvhAAp3rnkVlTmMept1U2hS5ZI3nvYrN+y1uRZBndfz1wUSZyJfjiMtBKy5sOHmFNBRtcWa5YyosgHjcWhzcx9FuYTOeDN3X8VzqhqcsNcPIuq9Aqo3E/OTa3XO50=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0640.namprd04.prod.outlook.com (10.172.166.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Thu, 5 Jul 2018 17:04:05 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0906.026; Thu, 5 Jul 2018
 17:04:05 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] scsi: ncr53c8xx: remove ScsiResult macro
Thread-Topic: [PATCH 4/4] scsi: ncr53c8xx: remove ScsiResult macro
Thread-Index: AQHUFE+iM3qD7o3uUUiDiWhgQxCl9qSA27sA
Date:   Thu, 5 Jul 2018 17:04:05 +0000
Message-ID: <a4a799f62ffa873fc3a7e23a5a46dafc8805b984.camel@wdc.com>
References: <20180705110140.19545-1-jthumshirn@suse.de>
         <20180705110140.19545-5-jthumshirn@suse.de>
In-Reply-To: <20180705110140.19545-5-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0640;7:r1qbx1skKyC+XQL/PNSHDtaZyOJmDiU+6leAhL9JMOf2JwHyoTGpv78ZVbgycnDgLfHiMa2o3G4tU9oFPtaIJDFuEOR3l6/C24p7bE8cfih5He/VP/2hGsrrN07NLIivs6xJEDTTPpJ6pwqMAhHJ71DCFRg/POuQKh7PbXIYYdsK3yVK6YOH5h7Jqs1TeSBdK9NAoZemU+YouQk4PfgIGyzp9jMjTdYXREvu/WJCwO5H3BQ5e6Rgx2NrHn3Hv7hS;20:mtLKsPWMS0YliMEQ4Ei5z+SVuwjyIG8i2B+eAcacDgaSGkdQcLg4kU4WxGEi9ANhdIjBfsGU39XzgpPJiPq5Op9oVe7JuuDZTy8OSYF+SYZWPoTc7PWUVCzGqpFrUlAxdPgy8fWWEHe2GAEZlUkshjC7QTeRQ0Q01RrA1Z4cZCY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c868d895-8dfd-4736-b23e-08d5e29950f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0640;
x-ms-traffictypediagnostic: MWHPR04MB0640:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB064098700E4C4CC9AFB0DBD698400@MWHPR04MB0640.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0640;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(366004)(199004)(189003)(4326008)(25786009)(478600001)(6116002)(3846002)(229853002)(66066001)(305945005)(118296001)(6246003)(53936002)(6436002)(86362001)(2501003)(5250100002)(256004)(81156014)(8676002)(97736004)(81166006)(7736002)(8936002)(11346002)(54906003)(558084003)(110136005)(14454004)(486006)(446003)(2616005)(476003)(102836004)(186003)(5660300001)(6512007)(6506007)(26005)(76176011)(316002)(106356001)(6486002)(2900100001)(105586002)(99286004)(36756003)(2906002)(68736007)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0640;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2blUKkXmQHEXdy9RahjcR8aD1u2BQQ8Jn9LDXTlRAkq0PZqrdUMlhzSzl9USIv7G62DXbFBmJwiUrDysXmqgw97WatoRZLd4h/d9YpbqoALbVH6JyFgxBjn3CnK43Py6fHq6qog4T860LBYM53V5l2b6uuGdzkGZVJsozSYDeupTkqb/Gaj676qJPUwwoVBfn7FeQkKdwqfPvk8ldmrIAGU06wX0+Gtk7G52BuidGRT349QxPsr8bJysiWgS1XjUUNTcQJ1eamPra9wJ0CEA+XBPhDlVTTJ5386jHYn7+APyI5rabZIFhFB34hF+EIzEanFSWz93rKw1+ZxiFjSQIcaPuiVzqFaBUNciiVY5+E4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6221EDCCB63F0E4A85BC96B61C388837@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c868d895-8dfd-4736-b23e-08d5e29950f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 17:04:05.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTA1IGF0IDEzOjAxICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IC0JCWNtZC0+cmVzdWx0ID0gU2NzaVJlc3VsdChESURfT0ssIFNfQ0hFQ0tfQ09ORCk7
DQo+ICsJCWNtZC0+cmVzdWx0ID0gRElEX09LIDw8IDE2IHwgU19DSEVDS19DT05EOw0KDQpTaW5j
ZSBESURfT0sgPT0gMCwgZG8gd2UgcmVhbGx5IG5lZWQgIkRJRF9PSyA8PCAxNiB8IiBoZXJlPw0K
DQpUaGFua3MsDQoNCkJhcnQuDQoNCg0KDQo=
