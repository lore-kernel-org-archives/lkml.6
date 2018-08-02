Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE18FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C93820862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="BjNCQEZN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ReOjlKOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C93820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeHBFlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:41:24 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5929 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeHBFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533183074; x=1564719074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vKdiIh9qvWHpZx4AD33Nrjef77jX8DM8SPdR4Rz3kr8=;
  b=BjNCQEZNsBq1VkatnjEHjR61PiD2oojURtS8Q68YdEz5F6mEzCQH9ZKy
   EWJBx2E/s5+Zcfsx3qWA4VNQK1WfLtZIAX0AJ0c7E+UpvD6oy43AIvoYn
   bauEHgvtyU++8S6OMke3peHvLTEcGL/ESZHa7fKq8KUNo8dP7oZQaRx2J
   iBwZUAbFIOznpkRcZ3s7kTgEh7Jw0bJQG4rNBmfLfIaGW4KG9rC9be2g3
   mNjyrVWurqnQjaU16tLggEfbPGx80KM8BeAeydnPB1l3j+wMfXKAOSPlr
   gBQl+4QSk1iLRxKB3KguQFFDQCjkB1e+ODSEq/hZbsNl7sCF5a/0wi5I5
   A==;
X-IronPort-AV: E=Sophos;i="5.51,434,1526313600"; 
   d="scan'208";a="183196557"
Received: from mail-bn3nam04lp0111.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.111])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2018 12:11:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaDA8FsqV0X9XC/m2zTyqWNqNoPfPTZ2oDhQ3NLK9SY=;
 b=ReOjlKOgyVd0BRydRg/sDf++giQflRIToMNNkoNmEa8YJsOQ+Fc3vK/cMr4NGMQKCc2y8SRf4I+FlEMT3I7EBF2DuU99acz7iV8f3dYx9M9ldl8lUBybwIOvlmJAGO+Jj/jB36+OpFJ7Y6+nNzAwaB/pfEJ25EA2DZpA60kugAA=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB3742.namprd04.prod.outlook.com (10.172.169.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Thu, 2 Aug 2018 03:52:14 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 03:52:14 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "zhongjiang@huawei.com" <zhongjiang@huawei.com>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "aacraid@microsemi.com" <aacraid@microsemi.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 2/2] scsi:qlogicfas408: remove the same check in
 qlogicfas408_detect
Thread-Topic: [PATCH 2/2] scsi:qlogicfas408: remove the same check in
 qlogicfas408_detect
Thread-Index: AQHUKgx/zt38yhew/kSYwTWaKUYeNaSry8qAgAACRQCAAAY8gA==
Date:   Thu, 2 Aug 2018 03:52:14 +0000
Message-ID: <2ff30988089f3cbc0d2127dbfaa29955e0449997.camel@wdc.com>
References: <1533177901-19514-1-git-send-email-zhongjiang@huawei.com>
         <1533177901-19514-3-git-send-email-zhongjiang@huawei.com>
         <dc1f8e81007466172d383cc63a4be246c568a2d4.camel@wdc.com>
         <5B627AB2.8000101@huawei.com>
In-Reply-To: <5B627AB2.8000101@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB3742;20:cL/9JTJZqph+8g/2DC6rbTf0px421x4aoe3pwT1qmwRVAg2c5cbpd5jR5Ed9tCI7BRV8u6smDP5RwMgkHCKBy/21+LX6Ck0RvBIMCI17jkCZuhnvv91Z0inKUDHiqZmqMZV3H87jVUcdfaR/BtCP7jfRE4pnVLzBYuGKnuD1FTY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ec861e01-9c88-42af-325f-08d5f82b55b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB3742;
x-ms-traffictypediagnostic: MWHPR04MB3742:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB3742D43465323CCDA38196F8982C0@MWHPR04MB3742.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB3742;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB3742;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(51444003)(229853002)(2906002)(14444005)(2351001)(53546011)(446003)(8936002)(68736007)(97736004)(54906003)(72206003)(2616005)(118296001)(478600001)(11346002)(486006)(256004)(476003)(1730700003)(53936002)(106356001)(5250100002)(186003)(2501003)(105586002)(5660300001)(15760500003)(81156014)(26005)(6512007)(25786009)(66066001)(7736002)(81166006)(39060400002)(3846002)(6486002)(305945005)(6116002)(99286004)(6916009)(36756003)(8676002)(102836004)(14454004)(4326008)(93886005)(5640700003)(2900100001)(86362001)(76176011)(6506007)(6246003)(316002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB3742;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1XKWYrt+7viUuzJ6ocJA6b8l9AOg2V2Oz7qfTSXuYxVtNx2nJlSF0l6zj/rX4XbVKgURV2PR08blBGwVllCjkc7kJmgXX14LOHZP0X3ZkX3OuGSlTJ552kWWDtStmEuvDzA4Y9RayPxNucrA+QfjsaeEy4YwbK6yPn+ZPCnUF/26TZZy0hf+1NhokkmfTLuDFEn/cd880Q97Dg7r+D0dYA3CS7JK8stmMuNrGpT9WW1mSFjc3qpGmwerz09paiLtcZaOMmagdboiGxParNxhoQYyiNFnYyk9I5WE0a3SNzLV+IjEeLzMeQ4RoB4UPk9gdQzqLXJVRHeKegl1cN8Ftl6yjWhEdnDl8Mjk+AjjyyA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <73802270CCDF2E48B707FDE28290CB10@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec861e01-9c88-42af-325f-08d5f82b55b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 03:52:14.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB3742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 11:29 +-0800, zhong jiang wrote:
+AD4- On 2018/8/2 11:21, Bart Van Assche wrote:
+AD4- +AD4- On Thu, 2018-08-02 at 10:45 +-0800, zhong jiang wrote:
+AD4- +AD4- +AD4- we should not use same check in a expression. just remove=
 one
+AD4- +AD4- +AD4- of them.
+AD4- +AD4- +AD4-=20
+AD4- +AD4- +AD4- Signed-off-by: zhong jiang +ADw-zhongjiang+AEA-huawei.com=
+AD4-
+AD4- +AD4- +AD4- ---
+AD4- +AD4- +AD4-  drivers/scsi/qlogicfas408.c +AHw- 3 +---
+AD4- +AD4- +AD4-  1 file changed, 1 insertion(+-), 2 deletions(-)
+AD4- +AD4- +AD4-=20
+AD4- +AD4- +AD4- diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/q=
logicfas408.c
+AD4- +AD4- +AD4- index 8b471a9..1409ac1 100644
+AD4- +AD4- +AD4- --- a/drivers/scsi/qlogicfas408.c
+AD4- +AD4- +AD4- +-+-+- b/drivers/scsi/qlogicfas408.c
+AD4- +AD4- +AD4- +AEAAQA- -567,8 +-567,7 +AEAAQA- void qlogicfas408+AF8-se=
tup(int qbase, int id, int int+AF8-type)
+AD4- +AD4- +AD4-  int qlogicfas408+AF8-detect(int qbase, int int+AF8-type)
+AD4- +AD4- +AD4-  +AHs-
+AD4- +AD4- +AD4-          REG1+ADs-
+AD4- +AD4- +AD4- -	return (((inb(qbase +- 0xe) +AF4- inb(qbase +- 0xe)) +A=
D0APQ- 7) +ACYAJg-
+AD4- +AD4- +AD4- -	       ((inb(qbase +- 0xe) +AF4- inb(qbase +- 0xe)) +AD=
0APQ- 7))+ADs-	=09
+AD4- +AD4- +AD4- +-	return (inb(qbase +- 0xe) +AF4- inb(qbase +- 0xe)) +AD=
0APQ- 7+ADs-
+AD4- +AD4- +AD4-  +AH0-
+AD4- +AD4-=20
+AD4- +AD4- Does inb() have any side effects?
+AD4-=20
+AD4-  just redundant. is it necessary for this . Maybe I miss something.

If doubletest.cocci came up with this patch, I think that script is
wrong and needs a thorough review.

Bart.

