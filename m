Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABBCC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E87220673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MF5REKcF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mBcBa+8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E87220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeGZPIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:08:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30534 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532613110; x=1564149110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q0FG7zw7FcnIzJCCRuIH6Uj1Npx3bO24hdTpbwVcHrs=;
  b=MF5REKcFdqUJj41aSc/YS9KOQJZ5Q43BPz1NaWOfmBd9xRFDMEv1Oinf
   yE6W4NmQfWSDjI9w3AporYQWSHNZU0pA9hD3z26JvgP6ADz7ex26ra3H9
   FfRWwHqhLi68B2k948mZ+VVlC5HGqLxh0K5mjcK8QAXsKt34Ji7e25jZR
   D1LCjAAniLWIHn/7qiYjLh3ln+XtJt0kliCgXcxqMPJWaM+oZJyQlvxB8
   mxZTcKedCuwSXDSkisbx6dbvbkXvYztN5XeBKWv9vok2itV3GpkgT87RZ
   xOHFBuJKWrWaUuj9NFoC0Mtk+Gk4TtiHVCxbM6fWL9erDt7y2X10PIJPf
   w==;
X-IronPort-AV: E=Sophos;i="5.51,405,1526313600"; 
   d="scan'208";a="88507045"
Received: from mail-by2nam01lp0181.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([216.32.181.181])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2018 21:51:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0FG7zw7FcnIzJCCRuIH6Uj1Npx3bO24hdTpbwVcHrs=;
 b=mBcBa+8WV51jf6V5Rn+YuMDEyO5AZPQHRPh8VkP8Z3r6hcQRq3esxvmdWlS/vWBHbDVK0JpC5MT2sqKiLkJZaUZW9D5zQ0lN+Dg6wvBTUJRaG6h1t84EB/zg9Dgz1mHHx3WcK7Dar8twPKskRnwN1v9koE51VAz/FY2WuvSIbws=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB3775.namprd04.prod.outlook.com (10.172.169.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Thu, 26 Jul 2018 13:51:48 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397%3]) with mapi id 15.20.0973.022; Thu, 26 Jul 2018
 13:51:48 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "ps@pks.im" <ps@pks.im>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Thread-Topic: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Thread-Index: AQHUGq56yXYBAcJcykKCTi0snJ4SPaSgUOAAgADx6gCAAFdvgA==
Date:   Thu, 26 Jul 2018 13:51:48 +0000
Message-ID: <62ddc886d005b91bd6a1bd8775259bb0b5cbe2b2.camel@wdc.com>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
         <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
         <20180726083850.GB1674@ncase>
In-Reply-To: <20180726083850.GB1674@ncase>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB3775;20:BAVUGt3eJ/yFSiRFPQVN7j/hrfKFIllG26STo2SKLkYpw4aMDxHjwZWyKRk7c3Kgw8E3OZrYVnfTYLYY8B/k90BokqJ6UECxTFF8JYi7EBaGx2FJmMQ+7wmm+54XGEcVxnezdItx/iPx0dK73hKpXJIVRFjjVoACKHamVc/P3vM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 26acad5e-4d2f-4859-ad1c-08d5f2feeee8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB3775;
x-ms-traffictypediagnostic: MWHPR04MB3775:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB377587A02D79C45B7132A22D982B0@MWHPR04MB3775.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB3775;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB3775;
x-forefront-prvs: 07459438AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(396003)(376002)(136003)(189003)(199004)(68736007)(8676002)(5640700003)(6486002)(81166006)(81156014)(8936002)(1730700003)(229853002)(54906003)(99286004)(2906002)(5660300001)(36756003)(11346002)(446003)(6512007)(105586002)(14444005)(256004)(6436002)(2501003)(186003)(26005)(5250100002)(2900100001)(118296001)(2351001)(486006)(7736002)(102836004)(6246003)(25786009)(316002)(14454004)(86362001)(76176011)(6506007)(478600001)(2616005)(3846002)(476003)(6116002)(305945005)(6916009)(72206003)(66066001)(97736004)(53936002)(4326008)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB3775;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +qxKaQl0EKZhQIWL5xwIRXz7WfPry4Hp46JoilKkmfook3IOaeoMKDGFEl0cYWj/YvRhuwvAQEhta3ReQUazuqRXE4bvLvGropkDQ+TmkBxm1/WdwlsSMzqUd/1SUm0g7lJ8Uhiyy9dl0s/xb8MFerNuL7rZ8ZyGxBPqwiRCh6i03M5zI3ixgvQCus98G++KFCCOqIe+uPiPEAp9wbJcubyYZR08dkpp882RdwcnoTqmCys+b7kB7UD1s0SfPTg4IfntzugU0W1xywVxLQbr4cT0G6bqNysmfhwk6EnPn6KTfwUzjdGjUXfjr0wYgCeCKPf0ALgXe4IZ4Y91Ax6PNMWBg0SOuP1xaSP37QDs8hU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <B16526BAC0CEBE45A6FF46CB7F248ECC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26acad5e-4d2f-4859-ad1c-08d5f2feeee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2018 13:51:48.5228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB3775
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 10:38 +-0200, Patrick Steinhardt wrote:
+AD4- That still leaves the other problem of broken suspend. I've just
+AD4- checked with v4.17.10, and it's still there: as soon as I resume
+AD4- from suspend, the kernel oopses and reboots the machine. I guess
+AD4- I'll have to do another debugging session and see where it fails
+AD4- exactly (and no, this time there are no more changes to the
+AD4- kernel tree).

Can you share the kernel oops details before you start running a bisect?

Thanks,

Bart.
