Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683A6C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AC52083B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hqv7HZpQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HyGhldts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AC52083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeHBFKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:10:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7738 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeHBFKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533180114; x=1564716114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VdRoPrY9z6Uk7JLybt7qYOGQj3VAvMOq0i9LBbVgiDo=;
  b=Hqv7HZpQkmAgW4vA+obDj23KPRy+9+Q3L5D9QMkmEI7baM+RSJRRoTxY
   7GGSuOER2ilMoOEvo8pJT9U7+u/2HNKrjUH7SR9kDWQHRbWwwX+OE2Nke
   4SfOyL6o6FEIlfY8aVX0db+hrVrEg8tqp4Z2oiTfcxxx0ZLSnhfPNVaTG
   iS88bV2unqwg8ocSq0J16UO3qsouHx1WQGhxw1wi+62cS/huzGCKpz0y+
   73xXF5UrdfHu4H35Liv5IXsvEjzv4MsTIAbNtpV+UQFWUwulPdrjPWsab
   6bIAm7ys2kzwvu3IzuSjPsBQ9dCIBHBulqLRGofNoUaIGk8ozaD1l1WJJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,434,1526313600"; 
   d="scan'208";a="85958126"
Received: from mail-cys01nam02lp0053.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([207.46.163.53])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2018 11:21:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXbxqqA+MZOj1jKlogs8eKpzmvf5Wl5+KSvzTsG/A6k=;
 b=HyGhldtsgoWvwpnf3KvRmkgdVAqI+wWPMk88wu9sycrEZ0rtQGIhVTXlrUFrjFuJMyLeniKdYBWt2hMqbKCdppCgWvyEha4W71ftG/M21bso73eaZO3RAFf7va7jZz/PH/9w++gV2tw5YxO9lbM07k7MNfxMGXqpr86D3AYFcvM=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0177.namprd04.prod.outlook.com (10.169.201.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.20; Thu, 2 Aug 2018 03:21:51 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 03:21:50 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>,
        "aacraid@microsemi.com" <aacraid@microsemi.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] scsi:qlogicfas408: remove the same check in
 qlogicfas408_detect
Thread-Topic: [PATCH 2/2] scsi:qlogicfas408: remove the same check in
 qlogicfas408_detect
Thread-Index: AQHUKgx/zt38yhew/kSYwTWaKUYeNaSry8qA
Date:   Thu, 2 Aug 2018 03:21:50 +0000
Message-ID: <dc1f8e81007466172d383cc63a4be246c568a2d4.camel@wdc.com>
References: <1533177901-19514-1-git-send-email-zhongjiang@huawei.com>
         <1533177901-19514-3-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533177901-19514-3-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0177;20:xTHpU1EwvDG0fgrNSUrgCmyya6Yzk4nlKWdrfmVWasca4gfM3QAsIFQPF/BCq4xW2iKfbKI1R51JGSkb33sBGTdoKAbY+e2aK+dapbyohdJE9vzb1D5uK16u6ZIRNE3w0Z420mAsRIfJZWh0950A2LnPFnVLez1Rbo6gYMen5EQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 692f7c26-8b0e-4ac7-762a-08d5f8271696
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0177;
x-ms-traffictypediagnostic: MWHPR04MB0177:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB017729504D4B3101B10B960D982C0@MWHPR04MB0177.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0177;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0177;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(6486002)(486006)(118296001)(81156014)(3846002)(2906002)(106356001)(86362001)(68736007)(2900100001)(72206003)(76176011)(186003)(36756003)(6506007)(26005)(2201001)(8676002)(97736004)(6116002)(15760500003)(7736002)(478600001)(11346002)(446003)(2501003)(476003)(5250100002)(99286004)(105586002)(102836004)(4326008)(8936002)(316002)(53936002)(66066001)(110136005)(14454004)(25786009)(81166006)(6436002)(2616005)(54906003)(14444005)(256004)(5660300001)(305945005)(6512007)(6246003)(229853002)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0177;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KFdwD9HqFYOvIUl4asUqmZcTNQ6iiDfKOm60PwCLk/qehTHVShc/u6GcWfCzHGk9sjDrWwtva0p49qgZagWMZNjubHPJNQHb32LWCEiRwoYyczs/ePfFJEdzLcF+aQOY/SYu1MpEVlkeYb5dYbQ11BCKKNd02n0eFqBZSrN487kithmY7lHXWWkBGXNHos1yQQUNs4EITDsYLEhwWEUcFawUK0jrajdby+fz4ouJi6YqZxOHsb6VOz4BA9vq01B2IfSIVrGVhzVSrqmCq8xaIPWagPvJL/FgEFhM0Q2X3nbDcxcmcNrJuUbvP9onXbGlT8fsNwjGnKexsxN3vljGpuQ/WdZd8oW6yAwcri22JKU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <811230E76F197A41B51B167B7507D38B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692f7c26-8b0e-4ac7-762a-08d5f8271696
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 03:21:50.7290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 10:45 +-0800, zhong jiang wrote:
+AD4- we should not use same check in a expression. just remove one
+AD4- of them.
+AD4-=20
+AD4- Signed-off-by: zhong jiang +ADw-zhongjiang+AEA-huawei.com+AD4-
+AD4- ---
+AD4-  drivers/scsi/qlogicfas408.c +AHw- 3 +---
+AD4-  1 file changed, 1 insertion(+-), 2 deletions(-)
+AD4-=20
+AD4- diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/qlogicfas408.=
c
+AD4- index 8b471a9..1409ac1 100644
+AD4- --- a/drivers/scsi/qlogicfas408.c
+AD4- +-+-+- b/drivers/scsi/qlogicfas408.c
+AD4- +AEAAQA- -567,8 +-567,7 +AEAAQA- void qlogicfas408+AF8-setup(int qbas=
e, int id, int int+AF8-type)
+AD4-  int qlogicfas408+AF8-detect(int qbase, int int+AF8-type)
+AD4-  +AHs-
+AD4-          REG1+ADs-
+AD4- -	return (((inb(qbase +- 0xe) +AF4- inb(qbase +- 0xe)) +AD0APQ- 7) +A=
CYAJg-
+AD4- -	       ((inb(qbase +- 0xe) +AF4- inb(qbase +- 0xe)) +AD0APQ- 7))+AD=
s-	=09
+AD4- +-	return (inb(qbase +- 0xe) +AF4- inb(qbase +- 0xe)) +AD0APQ- 7+ADs-
+AD4-  +AH0-

Does inb() have any side effects?

Bart.

