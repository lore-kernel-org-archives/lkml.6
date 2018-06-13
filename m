Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CB5B6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D46920020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="imzTJTku";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MdXavNbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D46920020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935574AbeFMNJP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:09:15 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32757 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935348AbeFMNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1528895353; x=1560431353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0q6Am/a6ljB7JFyqwZJfzKmzJ2f3usrLiFzDMMZ2nRc=;
  b=imzTJTkumMqIn4IEqPrxU/34nVgNSK7eqvt009xWeAgKqIIE2cSHa+5U
   x6qIysYooNRbmk4B4p4sAOI3p1v9RQhzjlljZj6sEEIhdU+tVAZqLx+lB
   VIBgsusZ9rGK1ePFPdWHuTDvYpfhpqsVeR39JnY5gjUhd2rpUHZb+KK1N
   +PzS3iEhJqqoN1ilu7H/xK5AwViDGhzR3EMslTVd5dKf67rS5kPlV8WZS
   vA9uHG1QVvIvHVV48mVoN9jLINUTwhgA96N9s8Ca19CyYgUu0DkR8ORpe
   V43ibuQv4v0FcPpCKP07+D/j8zCysBCstoHSqiVmLU4Z14EaWNl7q575I
   w==;
X-IronPort-AV: E=Sophos;i="5.51,218,1526313600"; 
   d="scan'208";a="183680754"
Received: from mail-sn1nam01lp0112.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.112])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2018 21:09:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0q6Am/a6ljB7JFyqwZJfzKmzJ2f3usrLiFzDMMZ2nRc=;
 b=MdXavNbfeLbDsAS/e5e1MXDfLRJPYAcbj2ynMcKmIkK2yj8pam7mGkjF3d5S1UMd4wOvdtvk3tNdB1D51ulQevLbyKjyaR2BvPu2Mow4p7gjMcCabhTVIwRSXhOIAPTHagPJwsHe21s/VKa2Zoeol8/1FpItecTrB6Yw7Q2Ddms=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0271.namprd04.prod.outlook.com (10.169.202.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.14; Wed, 13 Jun 2018 13:09:07 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::9de4:3c8d:39af:e4c5%8]) with mapi id 15.20.0841.019; Wed, 13 Jun 2018
 13:09:07 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] scsi: check for equality of result byte values
Thread-Topic: [PATCH v2 2/3] scsi: check for equality of result byte values
Thread-Index: AQHUAuvINjUlNPSC/Uu6DUQbJKd/IaReKZGA
Date:   Wed, 13 Jun 2018 13:09:06 +0000
Message-ID: <dcd5c76a5d9c2dd376bf7186376c7130889ebaa7.camel@wdc.com>
References: <20180613075349.7509-1-jthumshirn@suse.de>
         <20180613075349.7509-3-jthumshirn@suse.de>
In-Reply-To: <20180613075349.7509-3-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [76.103.130.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0271;7:a3vSxZsI0VO3UhE3CL773AhMJYCGm1K92VzFoJo4fsiedrLa2KWNtZ76idebvACt1+SfItmz9+ixU7Z5BCOzt4QZu+iHYCyF/phU1ptwOu84ye38XH2WlIA6CXks3UCUp1hg9MrBvehN/Fl6hdlVXSPR8WCNNOsi41tnHlok+oPCcs+EsJxVLAAFSHhg1oSzKxgMsesI/oVsTB+hdXQUr2lDBuinK+s2nPQuMxCrZ3hE49iky06uFDxXFpUVJUN9;20:OPTvPcYGamBfzyEHZeAWV+DsCcTfCftoHXlDbMHsvm7zpYhgRSCnxpwzxo+PoTjCbKqlS2+6bQLLQ/z9da7ldJvBb+BRNUEsyJnIEvdbRoVYiIzys/Hb7svLnNdBX2CRkHbA0PZCs0KgX8BAD6f6Zs6R4/K53Uz7GGZmMUwItSc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dc93350-1f3a-4f71-6b72-08d5d12ed84c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0271;
x-ms-traffictypediagnostic: MWHPR04MB0271:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB027122AAF5A0590B656B6B4D987E0@MWHPR04MB0271.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0271;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0271;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(346002)(396003)(376002)(189003)(199004)(3280700002)(2900100001)(14454004)(72206003)(2906002)(5250100002)(6436002)(2501003)(26005)(53936002)(66066001)(68736007)(6512007)(4326008)(102836004)(6246003)(6486002)(478600001)(97736004)(3660700001)(6506007)(446003)(25786009)(36756003)(5660300001)(486006)(2616005)(99286004)(105586002)(11346002)(229853002)(54906003)(81166006)(76176011)(106356001)(8676002)(6116002)(316002)(86362001)(81156014)(186003)(3846002)(110136005)(8936002)(118296001)(305945005)(7736002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0271;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: HQLtw7Oz6PIviaD1s0VhXOeN++oIFYAYrsXN6vx+tfT0TUPmSmsYYqvHlD1byuK6GXNc9ZRjzSRlHa6jvIjdYjSFid9NXaNNg1OTNG2jmFOgWoiTX3hUyBY/9mkZ2Ngs0NubnvpoNFqZ6/G+aAur50umMZmM9EMSoyIOy5W9Exh9tGV2SqgsLNp81xb5S6wa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8B09CF4EA84D449A015DBFA0B9ED5EA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc93350-1f3a-4f71-6b72-08d5d12ed84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 13:09:06.8799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA2LTEzIGF0IDA5OjUzICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+ICAJCWlmICgoY21kLT5yZXN1bHQgPT0gKERJRF9PSyA8PCAxNikNCj4gLQkJICAgICB8
fCBzdGF0dXNfYnl0ZShjbWQtPnJlc3VsdCkgJg0KPiAtCQkgICAgIENIRUNLX0NPTkRJVElPTikp
IHsNCj4gKwkJICAgICB8fCBzdGF0dXNfYnl0ZShjbWQtPnJlc3VsdCkgPT0gQ0hFQ0tfQ09ORElU
SU9OKSkgew0KDQpBIG1pbm9yIGNvbW1lbnQ6IHRoZSBwcmVmZXJyZWQgY29kaW5nIHN0eWxlIGlz
IHRvIHBsYWNlICJ8fCIgYXQgdGhlIGVuZCBvZiB0aGUNCnByZXZpb3VzIGxpbmUuDQoNCj4gLQkJ
aWYgKChkcml2ZXJfYnl0ZSh0aGVfcmVzdWx0KSAmIERSSVZFUl9TRU5TRSkgPT0gMCkgew0KPiAr
CQlpZiAoZHJpdmVyX2J5dGUodGhlX3Jlc3VsdCkgPT0gRFJJVkVSX1NFTlNFKSB7DQoNClRoaXMg
Y2hhbmdlIGxvb2tzIHdyb25nIHRvIG1lLg0KDQpCYXJ0Lg0KDQoNCg==
