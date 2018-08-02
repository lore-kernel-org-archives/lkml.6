Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D01C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42132152B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cgkLUcpG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l3hQXNBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42132152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbeHBTA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:00:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33489 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeHBTA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533229738; x=1564765738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9rvpDryGlBo5U0R+HGb7QSWCjydlDHzzm5WUWgHMxPA=;
  b=cgkLUcpGk3NM1MQO0MINrOkjfhDJexFPTD600RR1Ev7d//t4NFcrZGVq
   iHZ3GC2VNG59eLbCn3ebG4dHKAakq6Ia9M+8XEUHFX2Hlqr8JWQ8QKuv2
   2wpFImt92zfApmet1AqK8zq0LVa+eNoFc9YjXOtatKyDzi7GPd9zR57wQ
   D8r4AXnVqdsQQO8FLgLB5GizpVpiaR8voTSr4DYCEwrAMn8gpXZ2KLWqS
   gch/ylzUp+FomvsXWrG4uFoQK+ZPcyp+v7+hJUqlO3DaVvk4DID26/xxV
   5AgpZ7ItZzGONyyLBr6CWxZ++fwyStQA+N7P8IWxS+8dzQ1pbM6WOS5fA
   A==;
X-IronPort-AV: E=Sophos;i="5.51,436,1526313600"; 
   d="scan'208";a="89714299"
Received: from mail-by2nam03lp0056.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([216.32.180.56])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2018 01:08:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rvpDryGlBo5U0R+HGb7QSWCjydlDHzzm5WUWgHMxPA=;
 b=l3hQXNBJAClxKC64yEB2nA0x09r+IiN/JEnMG46KiFMMHciYM0MYbA9w9OOmWI/i5Tya81ZiPVGzGJ2GsMEySf2Ly6gZzxdNwIOEjCYd9VSG/pln2vq5O2OxM5yMMWbrfYxIQyDpJ/8khqHNYehrJvl//1fkKJ42IgsGru0gEgk=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0752.namprd04.prod.outlook.com (10.172.168.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 17:08:56 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 17:08:55 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Thread-Topic: [RFC] blk-mq: clean up the hctx restart
Thread-Index: AQHUKIMWxQ9ytKciREKo5HIno+xAH6SoxRwAgAAGCQCAAA/RAIABT5wAgABwGYCAAgXLAIAAEpkAgAAC5gA=
Date:   Thu, 2 Aug 2018 17:08:55 +0000
Message-ID: <7c933e7e60831f985297d8cc5a540171fc921f44.camel@wdc.com>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
         <20180731045805.GE15701@ming.t460p>
         <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
         <20180731061616.GF15701@ming.t460p>
         <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
         <20180801085841.GA27962@ming.t460p>
         <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
         <20180802165831.GB8928@ming.t460p>
In-Reply-To: <20180802165831.GB8928@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0752;20:kEob+adLDly8SW203SdEd2zCr+bx8/z/D0HXF9q4RDhsRxf+IFr6sjM8TILmAJxe3f1O+6eMoLFBqsYX8DvQ+bR/AaLyReL7GrzjT71FbSASlg7bJq9KsKlIt52poW/RK9sdvORZ9Za9496b14xbtKcVPo81M1YGELP1m0XuRb8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 47652159-7683-4da4-b657-08d5f89aa16c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0752;
x-ms-traffictypediagnostic: MWHPR04MB0752:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB07523C66D72FFCEAC287531E982C0@MWHPR04MB0752.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0752;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0752;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(54906003)(68736007)(316002)(229853002)(5250100002)(66066001)(2501003)(2351001)(118296001)(8676002)(2900100001)(6486002)(72206003)(106356001)(105586002)(14454004)(53936002)(2906002)(305945005)(478600001)(5640700003)(6436002)(93886005)(97736004)(476003)(2616005)(86362001)(25786009)(486006)(6506007)(14444005)(81166006)(26005)(256004)(102836004)(186003)(76176011)(81156014)(8936002)(6916009)(3846002)(5660300001)(36756003)(446003)(6512007)(11346002)(6116002)(6246003)(4326008)(7736002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0752;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: pgIvEi0WKIyC1Njqeq3BRoo2f50/lFmd1SdfybgYOaB8gRCW5f/cQokWJ/PSDe1Ud1Tq3Ea1WiKPK3lYgjCEZbSkdMjgzW5qw6tiAgjGyTwQx3pEUUpoKIb+tDfSzZeSAuAuR2Pqm8ACd9bo3EDSXygS7L/GMtbzJZOQUvyyd499IJiskCffQAODFDjg06pLaDY+UpL8nkSqZ4vodEkHiUG1u6NnPfbh/dtVlfltj462E+Nf5FlTXTbuqCoEnD2qR+i8QrUuSR9XG+duxqOj/SUFilhRB9yi2uSFMbI84q8odV+86g3FU8Ij2aRRpw6KTTbv0wSKcfELTLFZW+SD65gSfV0JuHdPtTkcdJPjPy4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <E6836B12A35F92499D4BCDE9ECD60913@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47652159-7683-4da4-b657-08d5f89aa16c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 17:08:55.7670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 00:58 +-0800, Ming Lei wrote:
+AD4- And about the situations you mentioned, no any special as normal case=
s
+AD4- or thousands of LUNs. Just a batch of queues are waken up from one
+AD4- single wait queue(sbq+AF8-wait+AF8-state), and inside each wait queue=
, queues
+AD4- are handled actually in FIFO order.
+AD4-=20
+AD4- Or what is your expected ideal behaviour about fairness?

Hello Ming,

What I expect is if the number of LUNs is really large that all LUNs are tr=
eated
equally. Unless someone can set up a test that demonstrates that this is st=
ill
the case for commit 97889f9ac24f (+ACI-blk-mq: remove synchronize+AF8-rcu()=
 from
blk+AF8-mq+AF8-del+AF8-queue+AF8-tag+AF8-set()+ACI-), I will assume that th=
at commit breaks fairness.

Bart.

