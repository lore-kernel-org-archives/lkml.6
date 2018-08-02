Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E853C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DBE2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i7u3y3wf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EhznoHTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DBE2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbeHBRnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:43:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45301 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387703AbeHBRnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533225203; x=1564761203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M19E5O29Hbi6BdmWmGnGhvu3IkktCX+SIezkZXzFkr8=;
  b=i7u3y3wfwc+LGCR0Nr1IGLXgg+/OtBLvFe801K7SbEd/am3g+44Lhjpr
   vUUWTT33cAJz61xfCGYPKhTQukFlZS8aUlnPqQr05/T2TaGrpDkTa5yBH
   kCZ24f0ZoOT6nU/sNZX8+ZdkXi0BlBzhP6rB8DJ++JbXbVoAWEqnO6tNt
   0iWyJdAFixClqpNtpTH5UPLh/HQNQhyVQpAgyUejZGN+rskETHVE2+G/5
   cEwMiqXH6yFxhDWQqVDKGHwf3e3AbqBEJ4XKeUeXokQ9vopQ6G5OvMJYa
   jn/oRcwpNtMISZJfQgw9TyJrshW1cj+HUKd1laJ7hLGDyNP/zPE8TZxj7
   g==;
X-IronPort-AV: E=Sophos;i="5.51,436,1526313600"; 
   d="scan'208";a="183347962"
Received: from mail-co1nam05lp0083.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.83])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2018 23:53:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M19E5O29Hbi6BdmWmGnGhvu3IkktCX+SIezkZXzFkr8=;
 b=EhznoHTzcz/7uJEQlJYF4kQxf9Wj9Dk/x1E7RwwNmAJ4ck1dNtCjj3mF9jKhdroySfxYCX/qzK6qRFCSRVPpSkY+tlSB4IZAawuKFSSLKUANJsRJ1MavQSjk8szbH2VLLlxEih2ukZcCOAshkNE+6Vtc/N1h3+kyqmwsRxz3974=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0622.namprd04.prod.outlook.com (10.172.166.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 15:52:00 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 15:52:00 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Thread-Topic: [RFC] blk-mq: clean up the hctx restart
Thread-Index: AQHUKIMWxQ9ytKciREKo5HIno+xAH6SoxRwAgAAGCQCAAA/RAIABT5wAgABwGYCAAgXLAA==
Date:   Thu, 2 Aug 2018 15:52:00 +0000
Message-ID: <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
         <20180731045805.GE15701@ming.t460p>
         <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
         <20180731061616.GF15701@ming.t460p>
         <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
         <20180801085841.GA27962@ming.t460p>
In-Reply-To: <20180801085841.GA27962@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0622;20:a2up+F+Q3VMMzhrMaRFXuPWz+kIwk/lJisLn70jHYdS3ID/farO2xT72ULVf1jzSwp2E8n6gjUjgHAs1t+3W00Ks6NFDKohDhc7oghJ/Pdb5LeqgOlphl7wLYW6jNge36gGK+nCsGnuhdiKCNK8nljKVEbjNVP5nGTfjNlvhhBg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a316d69a-5ec6-4a47-c287-08d5f88fe263
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0622;
x-ms-traffictypediagnostic: MWHPR04MB0622:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0622580264D3583C0C01C9AD982C0@MWHPR04MB0622.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0622;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0622;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39830400003)(136003)(346002)(396003)(189003)(199004)(102836004)(256004)(93886005)(6486002)(2906002)(97736004)(86362001)(7736002)(305945005)(26005)(186003)(229853002)(316002)(54906003)(25786009)(72206003)(6246003)(68736007)(81166006)(14454004)(6116002)(110136005)(6512007)(3846002)(36756003)(478600001)(81156014)(4326008)(14444005)(6436002)(105586002)(8676002)(53936002)(66066001)(476003)(5250100002)(99286004)(486006)(2900100001)(11346002)(446003)(2616005)(76176011)(2501003)(118296001)(8936002)(106356001)(6506007)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0622;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +g6IYPM+G3oXEaawvCMqym1XEJlbYXCdX5OiS3HVZkHrb+tClJTAQIDzczW4pGZRLa0rzINoF7z8RKDwu/m+26w1AtNhmhq2pyj+uCa7Td++j7wBebm26HBg06Uca1/MSdW83IGQj+cSVs86++/8jkPxsUdEyntp0jEjLE3iKSEWCREGuqCnZ61RA4kp64LS3KCRsnIM7+KHsiBH8Az4qKBBVVNFTfVVuRwDzmokyODzdnquYy23IodMY7lTtM8aLqclJOfYo/nTAQykZCRIar9qlmj33CU8u5NsQjWJlDwi1UMmux8/8E+dHB7LImFkr3A730yyREqx0SXsIvPhQ+gfXGt+JmcKJR4OZB09Ff0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <AB34CB583226FB4386FD6C9E6A654214@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a316d69a-5ec6-4a47-c287-08d5f88fe263
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 15:52:00.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 16:58 +-0800, Ming Lei wrote:
+AD4- On Wed, Aug 01, 2018 at 10:17:30AM +-0800, jianchao.wang wrote:
+AD4- +AD4- However, due to the limits in hctx+AF8-may+AF8-queue, q+AF8-b s=
till cannot get the
+AD4- +AD4- tags. The RR restart also will not wake up q+AF8-a.
+AD4- +AD4- This is unfair for q+AF8-a.
+AD4- +AD4-=20
+AD4- +AD4- When we remove RR restart fashion, at least, the q+AF8-a will b=
e waked up by
+AD4- +AD4- the hctx restart.
+AD4- +AD4- Is this the improvement of fairness you said in driver tag allo=
cation ?
+AD4-=20
+AD4- I mean the fairness is totally covered by the general tag allocation
+AD4- algorithm now, which is sort of FIFO style because of waitqueue, but =
RR
+AD4- restart wakes up queue in the order of request queue.

From sbitmap.h:

+ACM-define SBQ+AF8-WAIT+AF8-QUEUES 8

What do you think is the effect of your patch if more than eight LUNs are
active and the SCSI queue is full?

Thanks,

Bart.

