Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4165C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8F121534
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PKxOkMbe";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Saf5trra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8F121534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeHBStt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:49:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19252 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbeHBStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533229071; x=1564765071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cBxd9GH59EBBlMEU2cP6nKJ9BKtoR7/tFrs+sgSdW6s=;
  b=PKxOkMbeQe8LjbReMJfd0cl/S6gC0WO/muRtLByEleCMltgz6DWLjpvU
   zQa4na5SVBAhQC3h7FYjqNDeCxet6RO9XijXwX/Aue0+ig/68YvRSLLUj
   zhPXOfIiZuLbzt81+YPuHkcHphQ72BufoGDZHzLpygRlOh4JDJnbmUB5d
   zuj9gDGssWw1hqCYRSRME0lHe8NjKNPKHpv2f4DsOF3R1ga0CHJBw+84m
   LdTciscDQiQA8ICkQPCc+YIWp8Jx0CZZoUtjM7jDlPUZ6iLz1SgvcfFt5
   KxEqSPlpR6IL9flleiEhtJJ1AfFXJFUTQGD9DXDNji+gWEP9dVu5yMbu1
   A==;
X-IronPort-AV: E=Sophos;i="5.51,436,1526313600"; 
   d="scan'208";a="189914610"
Received: from mail-bn3nam04lp0119.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.119])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2018 00:57:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrIC735b8u5T+TwNoWHLIs1L3SYS1FsAzMY3Q0j1CIo=;
 b=Saf5trrazSXCow+HJphbEIPdEuilc+rTDQa9JR2PzcZz5EgMqK9wQtCKihRngsxQaHu1spwdPNTljkKG32OBYPQd1mza1/9YaBQEhQSv4anADTkPiZohfycOaFJ0203ARcdA4rQvkPhHq4+EXCdULJbLPeEVti5NZY3lU2jhRlc=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB1248.namprd04.prod.outlook.com (10.174.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 16:57:46 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 16:57:46 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: linux-next: Tree for Aug 1
Thread-Topic: linux-next: Tree for Aug 1
Thread-Index: AQHUKeplC62Adp/s7EWpMcTZnFWHbKSrkCyAgAAC74CAAAGHgIAAUnqAgABuzgCAABkqAIAAOGGAgAADqYCAAAMAgIAAAeuA
Date:   Thu, 2 Aug 2018 16:57:46 +0000
Message-ID: <e54984699a0e9fc1c7f2629730ee8fecc1251f70.camel@wdc.com>
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
         <9329f50c734eec5fa994ea652890f017a88625c2.camel@wdc.com>
         <CACVXFVNi_R3Xecwm7weqEv5Lqy+F-Nxmbq4-i3089Ge2qHFD_g@mail.gmail.com>
In-Reply-To: <CACVXFVNi_R3Xecwm7weqEv5Lqy+F-Nxmbq4-i3089Ge2qHFD_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1248;20:kCFEvROigGizzlwyWMcdI1TyI/nkWNIdn58YShuDn4z2smdn4tH4+4HTWVjDDzcDD+rPCMdJVVBWZcChhy+KJ5JiN9dUCEWCgJRYVAZbO1VTsUUtnr2GI/2HHyPns64uw5YmYkRP76FAIQzjWRdGbzKN4gT08Zy//MJlTNmtR3E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1faa4136-d49a-466b-d858-08d5f899129e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1248;
x-ms-traffictypediagnostic: MWHPR04MB1248:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB12489411B6E247BCEFFD4233982C0@MWHPR04MB1248.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB1248;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1248;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(36756003)(5640700003)(53546011)(6506007)(102836004)(7736002)(5660300001)(6436002)(54906003)(305945005)(66066001)(476003)(2616005)(76176011)(486006)(68736007)(1361003)(6486002)(6916009)(93886005)(3846002)(229853002)(7416002)(316002)(6116002)(8676002)(81156014)(86362001)(26005)(97736004)(6306002)(81166006)(53936002)(6512007)(118296001)(186003)(5250100002)(6246003)(2501003)(256004)(14444005)(8936002)(14454004)(2900100001)(99286004)(105586002)(11346002)(446003)(106356001)(72206003)(966005)(25786009)(478600001)(39060400002)(2351001)(4326008)(2906002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1248;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EYD0LBeeinK4cPYLuQeq51zehiV6lciTShv6wA/90uu+e7MB5TbJ3zZojxyg+l+ORbt2yipkN/4T4Ccf5PX7SBa8I0mpJOzU/ItTx3gYQKHsrKn/du2t+djnnpDK1+H1Z4p9DX3yZgKa1HV5MN1mQV7sfyerNLedRLXcDZTIgvaPoIE/+OOeCqkKfIIZtNzPAc3v/GxNcQRxf785wK0AMVhQ73Vr0MZsc7fKtkx6wNhBOCUV5wrNnjjdYc6vQ72K+Ty7CWnNe8x+4lSvNyESA2UFMud5eQ/eBIfaMVq6xk6UsN6soZE61QDJyGpLRRIOSbPLfwov833xUI0ZmaG9J4aeq1hfRPhmfhYFwMRJXes=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <05C4C245F90B1E4C846554FD3297D211@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1faa4136-d49a-466b-d858-08d5f899129e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 16:57:46.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-03 at 00:50 +-0800, Ming Lei wrote:
+AD4- On Fri, Aug 3, 2018 at 12:40 AM, Bart Van Assche +ADw-Bart.VanAssche+=
AEA-wdc.com+AD4- wrote:
+AD4- +AD4- On Fri, 2018-08-03 at 00:27 +-0800, Ming Lei wrote:
+AD4- +AD4- +AD4- This issue can be fixed by reverting d250bf4e776ff09d5 (+=
ACI-blk-mq: only iterate over
+AD4- +AD4- +AD4- inflight requests in blk+AF8-mq+AF8-tagset+AF8-busy+AF8-i=
ter+ACI-).
+AD4- +AD4- +AD4-=20
+AD4- +AD4- +AD4- This patch looks wrong, because 'blk+AF8-mq+AF8-rq+AF8-st=
ate(rq) +AD0APQ- MQ+AF8-RQ+AF8-IN+AF8-FLIGHT'
+AD4- +AD4- +AD4- isn't completely same with 'blk+AF8-mq+AF8-request+AF8-st=
arted(req)'.
+AD4- +AD4-=20
+AD4- +AD4- Please test the following change instead of reverting the commi=
t mentioned
+AD4- +AD4- above:
+AD4- +AD4-=20
+AD4- +AD4- diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
+AD4- +AD4- index 09b2ee6694fb..25a0583d8b4c 100644
+AD4- +AD4- --- a/block/blk-mq-tag.c
+AD4- +AD4- +-+-+- b/block/blk-mq-tag.c
+AD4- +AD4- +AEAAQA- -271,7 +-271,7 +AEAAQA- static bool bt+AF8-tags+AF8-it=
er(struct sbitmap +ACo-bitmap, unsigned int bitnr, void +ACo-data)
+AD4- +AD4-          +ACo- test and set the bit before assining -+AD4-rqs+A=
FsAXQ-.
+AD4- +AD4-          +ACo-/
+AD4- +AD4-         rq +AD0- tags-+AD4-rqs+AFs-bitnr+AF0AOw-
+AD4- +AD4- -       if (rq +ACYAJg- blk+AF8-mq+AF8-rq+AF8-state(rq) +AD0APQ=
- MQ+AF8-RQ+AF8-IN+AF8-FLIGHT)
+AD4- +AD4- +-       if (rq +ACYAJg- blk+AF8-mq+AF8-rq+AF8-state(rq) +ACEAP=
Q- MQ+AF8-RQ+AF8-IDLE)
+AD4- +AD4-                 iter+AF8-data-+AD4-fn(rq, iter+AF8-data-+AD4-da=
ta, reserved)+ADs-
+AD4- +AD4-=20
+AD4- +AD4-         return true+ADs-
+AD4- +AD4-=20
+AD4-=20
+AD4- I just sent out a similar patch on list, but use blk+AF8-mq+AF8-reque=
st+AF8-started()
+AD4- instead.
+AD4-=20
+AD4- https://marc.info/?l+AD0-linux-scsi+ACY-m+AD0-153322823307754+ACY-w+A=
D0-2

Hello Ming,

Since both patches are functionally equivalent, I'm fine with either versio=
n.

Bart.

