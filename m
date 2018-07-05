Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4724CC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE5E23E80
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gumlYIsB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L90/0iDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE5E23E80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932158AbeGERAV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:00:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12911 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754394AbeGERAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530810020; x=1562346020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OOsbdHM6E7iFoC9t4suV9xoubqlyJ8B3fXsakqHTQ7c=;
  b=gumlYIsBV2MCBDCXbJhZ65zcdZFImD3zTwF7YSJHzQkAZr61Kl+wllqL
   L7GY07xFflOuDDWpkZ9fBgcctcNMPmnBX6ZWJt5aQLkOSL5eBYbuxJIaH
   3NG/nG0eDoMWqFQkvToiT0E45DqNhIuk0fWLiGhaoFGK35ldTtWkGttLa
   g2H0LNlx36L4eXAXMF71kws7799mvTAwNk3SjNUboAjKEOm8H2SIlR0A4
   +H5hlOihmRbJ6z+l1B+I7QMn9njov/s84kDgf0hiOjn4As1IpW0hV3s4w
   geKiwmGA5DZWMXiMbxmyJpeKe1IJJws7gmoQo6ROTJ92PFF8zp3PCs2rs
   A==;
X-IronPort-AV: E=Sophos;i="5.51,313,1526313600"; 
   d="scan'208";a="83979094"
Received: from mail-by2nam03lp0047.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([216.32.180.47])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2018 01:00:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOsbdHM6E7iFoC9t4suV9xoubqlyJ8B3fXsakqHTQ7c=;
 b=L90/0iDzVnE0l3x6GsS0n5hQFPGbxufP6JPFTt9WdkZD2MFnzjnttsN+4Nr782guxVu9ZgaEg6CM6P0Ui/Oum9GJFsp1mdmxnt5ojEC7Bul0HPD2vedHBR1+JaPqpoSAwLmGGMef4btyBOfXrYudV1WBEWWo3ePq5+KRPEt/rCA=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0992.namprd04.prod.outlook.com (10.174.250.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Thu, 5 Jul 2018 17:00:10 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0906.026; Thu, 5 Jul 2018
 17:00:10 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] scsi: bfa: remove ScsiResult macro
Thread-Topic: [PATCH 2/4] scsi: bfa: remove ScsiResult macro
Thread-Index: AQHUFE+yVK8KBHg2bkCTSAoeGzzr1aSA2qOA
Date:   Thu, 5 Jul 2018 17:00:10 +0000
Message-ID: <1f5d6a4266daabfd49bad726f17524d80fdab524.camel@wdc.com>
References: <20180705110140.19545-1-jthumshirn@suse.de>
         <20180705110140.19545-3-jthumshirn@suse.de>
In-Reply-To: <20180705110140.19545-3-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0992;7:7S/Ncgs/I2T2KRlNP8mcDJ9LWW7AA+1U9oshg/lP/EPLjJm/wqiGFZGqCFZesZDbXnfBxMsb/J5e9IQJSrALB9s34mK72K+GrAfLl9gbWPLtJT5LYZtPEsvqCUJZeTao9zEJDyEe1fKdp0khuEzJGiIJSGdzgjppsJedSw+VDqcuBTLKcvDauC18XRk8Ceg250SjquWcxN3ktizUNKpAl2Y7V0roFiZH70/YNvNDi9IsuyE52MLnU3PvwbfYWZZv;20:yFOyKbfF/HI5Xfxsl24w8CCIhGNfMUdPx3bTgjcJutR7pHnNwov5hzyfa7eSkSLQ4oconhc1HH0q88T51VdZ02LTrD2/XNQ7z1QcCu/5UyICu8q77Gzuy3CsGVhUb+ZUvgx2gBBjHr0HyKqOFW4fSF7wfRQXTmnLPVMPgYND/hQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c7cc4e2d-0afb-443c-97d1-08d5e298c4d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0992;
x-ms-traffictypediagnostic: MWHPR04MB0992:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB09929695394E087BAD1BE5C198400@MWHPR04MB0992.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0992;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0992;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(2501003)(66066001)(6512007)(5250100002)(53936002)(6246003)(229853002)(76176011)(6486002)(102836004)(26005)(6436002)(6506007)(105586002)(5660300001)(4326008)(106356001)(68736007)(3846002)(99286004)(8936002)(8676002)(81156014)(97736004)(81166006)(316002)(2900100001)(7520500002)(2906002)(110136005)(54906003)(476003)(86362001)(118296001)(186003)(6116002)(305945005)(11346002)(446003)(7736002)(2616005)(14454004)(478600001)(36756003)(25786009)(486006)(72206003)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0992;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QCLGavZh5OxvE5hQam9D8OxDmjRQFrjlw1EHWK3OjqmrrdSuck4fyExYo24arKA9D3n5nz0f09Th6PjxSwQ6ogbVCXjItdASRkg5s5x4wm2QSkvTSScogDydgHa/YZ9D2kutf91YWi2D1QvghZbfnUK1YYbvgFSf+cxUCbFZCUPsyK+O7mcmOFuCWBr1uYvojR/0rLfHLBqDnhj9/ug/+Vjai6KoZ2rjUFadUd7ywtTgzpuA6ma2vCWTJs86f8Zfpchznl1jvwexXhDjAlVk4KOzG+gdSo9eADOPtqADdPynXLccGeAtf3Z2KkTcj7Pc+f/oQtjgsQxmlJ1A7DytsA3H4lgArAf7JotPAj4GGdk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE8B5046AA27CA42BF5604A8B57F6603@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cc4e2d-0afb-443c-97d1-08d5e298c4d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 17:00:10.7180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0992
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTA1IGF0IDEzOjAxICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IC0JY21uZC0+cmVzdWx0ID0gU2NzaVJlc3VsdChESURfT0ssIFNDU0lfU1RBVFVTX0dP
T0QpOw0KPiArCWNtbmQtPnJlc3VsdCA9IERJRF9PSyA8PCAxNiB8IFNDU0lfU1RBVFVTX0dPT0Q7
DQoNClBsZWFzZSBjb25zaWRlciB0byByZW1vdmUgdGhlIFNDU0lfU1RBVFVTX0dPT0QgY29uc3Rh
bnQgc2luY2UgaXQgaXMNCm5vbi1zdGFuZGFyZCBhbmQgc2luY2UgaXQgdXNlZCBieSB0aGUgYmZh
IGRyaXZlciBvbmx5LiBBZGRpdGlvbmFsbHksIHNpbmNlDQpTQ1NJX1NUQVRVU19HT09EID09IDAs
IHBsZWFzZSBsZWF2ZSBvdXQgInwgU0NTSV9TVEFUVVNfR09PRCIuDQoNClRoYW5rcywNCg0KQmFy
dC4NCg0KDQoNCg==
