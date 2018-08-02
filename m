Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B55C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE8E2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H2UbrOF3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Sa+SXmpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE8E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeHBFLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:11:40 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24071 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeHBFLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533180386; x=1564716386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vau3so/p4SAx1CcsDJrEGQWGRqIKIwjXEaGwZy/LEhY=;
  b=H2UbrOF3q/LyFNUvspoUyUFM9cnyE7vF/9OPfIjQc184Js4CoRymnHEu
   J3+u5hd8KLG4hz4tfd45LlyibHOdfw5Hz4tQRcM27aNh50bBtDxj3Fxt+
   yqtKiwXp7o86uRO3bPaCHvh0GduMQCKBUzAdyADKHjlnDDjtC9mOVSSKb
   GLh9bInL13xuqV+c706KKpbx6gEKe2yYK3/jRJDqbpZskGdmj9ty+VOux
   Doy69PZ/EcGh2SDtIziwK/5WEocHolc4aJlqJGhGSd4LMDopIdOJ5u5is
   pPjHcRMUWvbdC5usFdV3M/TsoMQN+0YyqXxajgZqmXPwNk0+Mh5gWAXpc
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,434,1526313600"; 
   d="scan'208";a="183192151"
Received: from mail-sn1nam02lp0018.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([216.32.180.18])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2018 11:26:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78oMOIAZ6Fo1ZL6DZX7ar7CF7SOTrep6o7txHyo/v3U=;
 b=Sa+SXmpF38m2RMwNoDS9HlE42G76Djbqoco5lZhY2CQrmn/TyFK8owksYwxNIzCXgeSMhEcCOBVroY6hb5DOyfP/Va2MWPjOZSq8+BYiQ5t8MuyBhy6X8PunjwWOXoLs0H50sks0CBliC/g4KqjFDUsT/vpm/oMgcuGz6EBr4pk=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0177.namprd04.prod.outlook.com (10.169.201.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.20; Thu, 2 Aug 2018 03:22:37 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 03:22:36 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "zhongjiang@huawei.com" <zhongjiang@huawei.com>,
        "aacraid@microsemi.com" <aacraid@microsemi.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] scsi:qla1280: remove unnessary same condition check
Thread-Topic: [PATCH 1/2] scsi:qla1280: remove unnessary same condition check
Thread-Index: AQHUKgx/nIZmxCmIlU28lHYohQY7BqSrzAOA
Date:   Thu, 2 Aug 2018 03:22:36 +0000
Message-ID: <4f6e32d59aec6a75332b36377ed719dda293fe45.camel@wdc.com>
References: <1533177901-19514-1-git-send-email-zhongjiang@huawei.com>
         <1533177901-19514-2-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533177901-19514-2-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0177;20:fQKpk5UxMjbec69o9u2UTUiuI2sC0baU4QTf92OzSVnphBy1kXysIUBc27+VOvOiZGg7BXBOXKBnIWn0i67zUhQiacZIg2sijFlnFsTVnOcujgdJLEO3q10qI8iUCABcb/0OVREaBCFUNvMRLkcXFhgpcPQgLzox+M1e2tHbeTs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9796c64b-c152-4a34-ffd4-08d5f827320a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0177;
x-ms-traffictypediagnostic: MWHPR04MB0177:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB017730BC5FBABDD8F7DEF662982C0@MWHPR04MB0177.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0177;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0177;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(6486002)(486006)(118296001)(81156014)(3846002)(2906002)(106356001)(86362001)(68736007)(2900100001)(72206003)(76176011)(186003)(36756003)(6506007)(26005)(2201001)(8676002)(97736004)(6116002)(7736002)(478600001)(11346002)(446003)(2501003)(476003)(5250100002)(99286004)(105586002)(102836004)(4326008)(8936002)(316002)(53936002)(66066001)(110136005)(14454004)(25786009)(81166006)(6436002)(2616005)(54906003)(14444005)(256004)(5660300001)(305945005)(6512007)(6246003)(229853002)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0177;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: v5ZBEWo1atlc/3zBXgvNKgPDsvPB9vk7gYu+rs7edc6d5n2yYfWBZNJxEKLa2ge2GN8YSmvD035zdhJCfhJ0RtDPmhrlFb36fZHPsmRyVzhWUuDifQ3BcLAiAvO7Vu804iiMBiRviRCZwcI0g+hvN3chFUIbpGr3Tav0r/7JCuhlYpz4EjlQneWLJvyQYw1UXrbpYH1iqId76CLXvFH4sXOqjV3B1LhpfQTT7uNIOMOmNEadlm32STsBR9d2rc4xV6iAD36ABhuI9dq48F4r+YEm6L9LKpxdhE11NdvGe8Tvpi5yRsVAdAtB1Rwzo26bwAB4k/Xp1wWvv4Y8fajz1fAaz+oK+QMDcDCzI8zGh4o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <40BE66B5F2E88F4EA54B1CFF3B566BCD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9796c64b-c152-4a34-ffd4-08d5f827320a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 03:22:36.8069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 10:45 +-0800, zhong jiang wrote:
+AD4- doulbe test in a expression is redundant. so just remove one of
+AD4- them.
+AD4-=20
+AD4- Signed-off-by: zhong jiang +ADw-zhongjiang+AEA-huawei.com+AD4-
+AD4- ---
+AD4-  drivers/scsi/qla1280.c +AHw- 1 -
+AD4-  1 file changed, 1 deletion(-)
+AD4-=20
+AD4- diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
+AD4- index 390775d..8e6f156 100644
+AD4- --- a/drivers/scsi/qla1280.c
+AD4- +-+-+- b/drivers/scsi/qla1280.c
+AD4- +AEAAQA- -1504,7 +-1504,6 +AEAAQA- static void qla1280+AF8-mailbox+AF=
8-timeout(struct timer+AF8-list +ACo-t)
+AD4-  	/+ACo- Issue SCSI reset, if we can't reset twice then bus is dead +=
ACo-/
+AD4-  	for (bus +AD0- 0+ADs- bus +ADw- ha-+AD4-ports+ADs- bus+-+-) +AHs-
+AD4-  		if (+ACE-ha-+AD4-bus+AF8-settings+AFs-bus+AF0-.disable+AF8-scsi+AF=
8-reset +ACYAJg-
+AD4- -		    qla1280+AF8-bus+AF8-reset(ha, bus) +ACYAJg-
+AD4-  		    qla1280+AF8-bus+AF8-reset(ha, bus))
+AD4-  			ha-+AD4-bus+AF8-settings+AFs-bus+AF0-.scsi+AF8-bus+AF8-dead +AD0-=
 1+ADs-
+AD4-  	+AH0-

Same question here: does qla1280+AF8-bus+AF8-reset() have any side effects?

Bart.

