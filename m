Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77945C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191DD2152B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XKkpikNl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Xe9re7iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191DD2152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeHBScK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:32:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46179 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeHBScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533228016; x=1564764016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aloWdAntXtub5tcAiv7A5jZeQglzWvn9NxYo3qyYg74=;
  b=XKkpikNl1h+JFNhYiFfbzpCz1trbbGxF42IoxUenVKeOQjPhFhQsUCd4
   LDEEyk7kNw5oZH2B/xK/RS5rADSRe1m3tdohha2dgIQvn/8GG/tF3CfXf
   DV19MqAB6zHuAZ61NGdwZ1P/XbYC4EfDdiRXlrRVDv8OE0s1otvZ0m+oN
   gu4U3FMyiG0H8LuhGbbl5gdlxfMz2Wm/v7lrz7whiiahdxWF8+YOBTDMb
   1mI9NQDAiUk/hs/Az9h44Kvx5OEaZCHRziWTaCIwYW5g3LyhMxdOO+XFX
   GXZ2J2AZTqngXR1SFn368EvmA70BrXgWb3XEQAy/LGO7eudMVNJdhHUZ9
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,436,1526313600"; 
   d="scan'208";a="86110678"
Received: from mail-bn3nam04lp0114.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.114])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2018 00:40:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6QR+MdbHVxByyETU4gOdA+3k6rsyrgpkoZa2lQvaLQ=;
 b=Xe9re7iDL4VsCEL9b50Q0bM+4bs/aXuxpUD9xjVz1X848ttRKHP5RWLQoJjoYVDxHuKYvmpAHER6VelWTgdJxi93doAC8A/xi7cG/Es/n1/DZckUx6NuW7jBb8fd/iVzcfGMqErrCKA0SJDkK0x4efAoHNYec517PpGNrdApvZQ=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0606.namprd04.prod.outlook.com (10.173.49.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Thu, 2 Aug 2018 16:40:10 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 16:40:10 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: linux-next: Tree for Aug 1
Thread-Topic: linux-next: Tree for Aug 1
Thread-Index: AQHUKeplC62Adp/s7EWpMcTZnFWHbKSrkCyAgAAC74CAAAGHgIAAUnqAgABuzgCAABkqAIAAOGGAgAADqYA=
Date:   Thu, 2 Aug 2018 16:40:10 +0000
Message-ID: <9329f50c734eec5fa994ea652890f017a88625c2.camel@wdc.com>
References: <20180801175852.36549130@canb.auug.org.au>
         <20180801224813.GA13074@roeck-us.net>
         <1533163965.3158.1.camel@HansenPartnership.com>
         <20180801234727.GA3762@roeck-us.net>
         <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
         <1533168205.3158.12.camel@HansenPartnership.com>
         <171b2cdc-2e74-2b3c-e5f5-c656a196601a@roeck-us.net>
         <CACVXFVMT7UwWHPQ6K-eNWZJOoZ77==Ki7zmX5UtDz4ZQFFB0Jw@mail.gmail.com>
         <a10a509a-7e5c-1706-52ee-79849cad4224@roeck-us.net>
         <20180802162654.GA8928@ming.t460p>
In-Reply-To: <20180802162654.GA8928@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0606;20:zdXdr0FwCzwzlgLWTaS/5GoFcKUyqv2dgaHQj2FPv0H8g8PGHXcPHaUdam+P/aNz2gaROLRY9HAYtegID0zyGcfpWuWUHQmEEKZTQWJiCVeOHhcFTeaKPGMug8VTr95U/nt16+W8qQru2wRXkDjsC5T3xcWqvPFUQXDEKIu0R1k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4b493f8f-e233-4c9d-9d9a-08d5f8969d36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0606;
x-ms-traffictypediagnostic: MWHPR04MB0606:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB06068569D83ED1A30437DF7F982C0@MWHPR04MB0606.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0606;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0606;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(2900100001)(36756003)(486006)(7736002)(81166006)(110136005)(54906003)(5250100002)(4326008)(446003)(93886005)(72206003)(5660300001)(316002)(305945005)(11346002)(186003)(68736007)(14444005)(8676002)(256004)(476003)(2616005)(81156014)(6512007)(26005)(7416002)(2501003)(25786009)(66066001)(2906002)(86362001)(53936002)(6486002)(6246003)(6506007)(102836004)(76176011)(118296001)(8936002)(39060400002)(3846002)(229853002)(6116002)(478600001)(105586002)(97736004)(14454004)(106356001)(6436002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0606;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: B9fTNet/LH1Cf2AeTBr2C7O0lILj+YsFLsBfjUL9AO3lVgelsFRrDKGGU64JFpzorWXh/Dq0k6zLZo3dEbSfVLCn+jNdWAQOIKhKOuXxzzhx1gygSpi//kwVwpbtJL/1M7YOrR4RbfIs6Lu8KN20Mr/JIfAjo4205CeijGUS6RzZHN4lrcalHPJ4pxmpyGhNeAKaa211KiZoInfh5K9kL956gwojo6Sx2IZgTeSkHgm6VIeHcYkm++RdEZWRm+jexGZ0lMgLPR5eWK3ASYdzR9WsOdOAfnYAHS/bSNsiAevdLFiAgI+3ksMICXx8/VIWIms/lN2vyh5VUIT2mJGb4VyHAsqHJx1A/3bPM3yqhzs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <F31844CD68AA864392DEFCF316450956@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b493f8f-e233-4c9d-9d9a-08d5f8969d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 16:40:10.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0606
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 00:27 +-0800, Ming Lei wrote:
+AD4- This issue can be fixed by reverting d250bf4e776ff09d5 (+ACI-blk-mq: =
only iterate over
+AD4- inflight requests in blk+AF8-mq+AF8-tagset+AF8-busy+AF8-iter+ACI-).
+AD4-=20
+AD4- This patch looks wrong, because 'blk+AF8-mq+AF8-rq+AF8-state(rq) +AD0=
APQ- MQ+AF8-RQ+AF8-IN+AF8-FLIGHT'
+AD4- isn't completely same with 'blk+AF8-mq+AF8-request+AF8-started(req)'.

Please test the following change instead of reverting the commit mentioned
above:

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 09b2ee6694fb..25a0583d8b4c 100644
--- a/block/blk-mq-tag.c
+-+-+- b/block/blk-mq-tag.c
+AEAAQA- -271,7 +-271,7 +AEAAQA- static bool bt+AF8-tags+AF8-iter(struct sb=
itmap +ACo-bitmap, unsigned int bitnr, void +ACo-data)
 	 +ACo- test and set the bit before assining -+AD4-rqs+AFsAXQ-.
 	 +ACo-/
 	rq +AD0- tags-+AD4-rqs+AFs-bitnr+AF0AOw-
-	if (rq +ACYAJg- blk+AF8-mq+AF8-rq+AF8-state(rq) +AD0APQ- MQ+AF8-RQ+AF8-IN=
+AF8-FLIGHT)
+-	if (rq +ACYAJg- blk+AF8-mq+AF8-rq+AF8-state(rq) +ACEAPQ- MQ+AF8-RQ+AF8-I=
DLE)
 		iter+AF8-data-+AD4-fn(rq, iter+AF8-data-+AD4-data, reserved)+ADs-
=20
 	return true+ADs-

Thanks,

Bart.

