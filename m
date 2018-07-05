Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0689EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25E523E80
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GcM8UKNu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RgXYBD6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25E523E80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeGERCr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:02:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44787 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932123AbeGERCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530810456; x=1562346456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WQBY0EKlrwfufRZOkkNsp+nBaAUvHyv1wF2pmfM3Gvo=;
  b=GcM8UKNuGHKB9X/XY7o0rNeRE4rLYMT1VyEs+Wi3bhnzR0hYUg+cSR6i
   rTfNyRaw5um+R9Qo2GvFUziiD2hKEa0my+7frH0lFZBIOW17cTRUQgPDK
   0kPcdVNb72UcZemmma/kTVLUurkiU6EHb4ydL5zL53MKJ6z0MmW3QaCtB
   dC4AQpyrtRULBO7IkAEvCIAqOeudZNJypn3aG/KEugve19OzNGYqNt+b1
   jeRRwHeNFp2TjSZNnhX9mpuQJeHBp1Dm8YhiiYD7LuQ463+A0fM6K4Qpn
   DGUdLVCbz3FCRm7Ez8NVdFBxHJw/vLu17CfjQwPTSqLBvWJsgMgDcbVzR
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,313,1526313600"; 
   d="scan'208";a="180322396"
Received: from mail-by2nam05lp0242.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([216.32.181.242])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2018 01:07:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQBY0EKlrwfufRZOkkNsp+nBaAUvHyv1wF2pmfM3Gvo=;
 b=RgXYBD6xcakACEhTp1m8258YcCB1Y2tHZDmcSBSwoyfDBCNRpnnD8T5l1jWL6A1WsTgkvTJ/YhPgEW6olLHYXkhRflWqI3S9m4VlAHOSGhaBgtJ8UyCNeQLNrnI1BGqRPsgN+DsJbQQ0I0vWi5o+W4xywV7Jk7QMJaIUrUJaWEQ=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0640.namprd04.prod.outlook.com (10.172.166.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Thu, 5 Jul 2018 17:02:43 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0906.026; Thu, 5 Jul 2018
 17:02:43 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "dick.kennedy@broadcom.com" <dick.kennedy@broadcom.com>
Subject: Re: [PATCH 3/4] scsi: lpfc: remove ScsiResult macro
Thread-Topic: [PATCH 3/4] scsi: lpfc: remove ScsiResult macro
Thread-Index: AQHUFE++0b+ulz6XUU2YUVYo3+EC6aSA21kA
Date:   Thu, 5 Jul 2018 17:02:43 +0000
Message-ID: <b7be727f9d1b5281d6ce3a6f6765a372b28d3f78.camel@wdc.com>
References: <20180705110140.19545-1-jthumshirn@suse.de>
         <20180705110140.19545-4-jthumshirn@suse.de>
In-Reply-To: <20180705110140.19545-4-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0640;7:Qx8QAW7lRPPAIJR8ZMpJCzZKL1oke7uetl71VJYFZRGgeisgUEalUtKUgbMfyeXvFFLEh6XfYf9wMx5491QNfFuLj93nigea0ow6vj/HTN19FenrtWgvHgKPc4Nzqtoxj06z1dbmiRj8/bOeod4TXRucOr+nezyM/f66wHmucVAh/Emq/pjyx1/9XKd3aZOSDHw3QvzKzwDLXX2/NdbrwbUD/28lY39mCQqQHkH7hWknmW6nCi1O9AdT2SKFxeIy;20:tUz83CMgStpWhtrGW2dMEDYqugXgdEe0JbGGwVrHASxVrPv5wpRPPHroPd/YEftHPoWrPlMeUetVG8+nLh0tZMy+0NVqYhnw6F3FI0ZVhYnm6006n4OiupnmImVeOQjC8e+UkjayKqsI9hsAeGw26kFpYOZXM/yr3JQHob4CTss=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9628bd88-255e-4a54-815a-08d5e2991ff6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0640;
x-ms-traffictypediagnostic: MWHPR04MB0640:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB06404D5B343C7D8498C0246298400@MWHPR04MB0640.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0640;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0640;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(366004)(199004)(189003)(4326008)(25786009)(478600001)(6116002)(3846002)(229853002)(66066001)(305945005)(118296001)(6246003)(53936002)(6436002)(86362001)(2501003)(5250100002)(256004)(81156014)(8676002)(97736004)(81166006)(7736002)(8936002)(11346002)(54906003)(558084003)(110136005)(14454004)(486006)(446003)(2616005)(476003)(102836004)(186003)(5660300001)(6512007)(6506007)(26005)(76176011)(316002)(106356001)(6486002)(2900100001)(105586002)(99286004)(36756003)(2906002)(68736007)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0640;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: V43l/WoQBI7UvDxNxfPZTGgxZk/YZekVa/SNTayHzHrZTIN124kUFpBDDhOPy0g4NnpFqfA2AKdxvWnm0w2J3gSl/aofY/RJLxt0eLthvYYoRpTsesN+ym05njH53VzNrd94Nub18gvEoqfmdyrdE+A8r4NLR7DPBINmV54/7GZr3KChDmzQ+Wbm4FEkX/Jf72EhjB9eH6eOOy5eZpK9+zpXAWQRBOTb9wDGK4iUvcaRTD5lcVf6MyLIvkVTxsYnPydgYdJk8yIwXMI34d4g+Sy5bB+lS31iOdKy0NLSNcuBnZQd5AX1asebF5lSIw7g1MweVTvQ3gGMJR26qXXeOOn0QqkPKcuhZBC3baDhGaA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <02A164F36EE6E94E923B5A34233D3FB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9628bd88-255e-4a54-815a-08d5e2991ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 17:02:43.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTA1IGF0IDEzOjAxICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IFJlbW92ZSB0aGUgU2NzaVJlc3VsdCBtYWNybyBhbmQgb3BlbiBjb2RlIGl0IG9uIGFs
bCBjYWxsIHNpdGVzLg0KPiANCj4gVGhpcyB3aWxsIG1ha2Ugc3Vic2VxdWVudCByZWZhY3Rvcmlu
ZyBpbiB0aGlzIGFyZWEgZWFzaWVyLg0KDQpSZXZpZXdlZC1ieTogQmFydCBWYW4gQXNzY2hlIDxi
YXJ0LnZhbmFzc2NoZUB3ZGMuY29tPg0KDQoNCg0KDQo=
