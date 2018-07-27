Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D49C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255B6208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H28R7Y8n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jxxP5k1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255B6208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbeG0QZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:25:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62824 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388668AbeG0QZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1532703794; x=1564239794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h0OMyFY2tD++ypCRIrduUZ5vnnkh3Iy30mjRdf17E+Y=;
  b=H28R7Y8nVj4tm1aAuhBX6dZqUtgFtV27YPbgbFrX5vnTAw/i5MGdGpTp
   6HuDPCkFGw9ckRkjicmvd6duI1VKEQ8WNRziq3p6uvuNRCi7ymf7c1Nmt
   Jqr7kUtdlIy21T5RaNhv820YWweF7YaaVP62nO7xHPQzfySv7fu6fF3Nk
   41662kU98nESh7vltMXCLIMxTmx9BTnwjDOIN/jjFJJy9yuuX5R+oITlp
   dTzUErZifdDLFJYSQhCIOsoN0HNVlgrmWadV/zBUgglEG29Mk0XOXS5n3
   Pn+c0e8gtGjTBmiZpH42O0eheaNM7a+D8/uo0KTvdrQnlAeyUdk2iY0N2
   A==;
X-IronPort-AV: E=Sophos;i="5.51,409,1526313600"; 
   d="scan'208";a="85170583"
Received: from mail-by2nam01lp0177.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([216.32.181.177])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2018 23:03:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdUcNh9tZzLvGRHUBzcGKyplcIYXzVBN1TSv6MeJZY0=;
 b=jxxP5k1CCCVcOPaiWEfORBVfKPk7cUZIwkZHWRBhlhh5Nc1F8b+4XCJwOzw59DR7SAYbokkIdNMxS3DL+yGKwTiuEwpq5LRWc6lst4R7qAfuCAyKJhzOPtj0Whtuo4yFf1JEYnyYxVkUUlUTI7dsMuinGFb62gsXvAhuhGapuag=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0832.namprd04.prod.outlook.com (10.172.168.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Fri, 27 Jul 2018 15:03:09 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::29a0:6668:ccc3:c397%3]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 15:03:09 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "ps@pks.im" <ps@pks.im>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Thread-Topic: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Thread-Index: AQHUGq56yXYBAcJcykKCTi0snJ4SPaSgUOAAgADx6gCAAFdvgIABfQmAgAApOoA=
Date:   Fri, 27 Jul 2018 15:03:09 +0000
Message-ID: <6f00aeea242c20be1e2709bb00d27d79a8a8facf.camel@wdc.com>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
         <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
         <20180726083850.GB1674@ncase>
         <62ddc886d005b91bd6a1bd8775259bb0b5cbe2b2.camel@wdc.com>
         <20180727123533.GA1588@xps>
In-Reply-To: <20180727123533.GA1588@xps>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0832;20:dhL0UtTdwhmEKAqQr2dEY9aOZ2k3YKazPHWknUgVWcjS9tpEy9mO13IsjOTmtkIiXYvzkVRl3alx5EoRl73beQRrgBygfPcEWMpVwdnJYuyE09YBMJ+P0D57eW8bf/DMhjdZ7S9ekDa4ApIFPwhviUkv4acmfm8icrCEPjFffe4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e229d900-f63e-4661-eb78-08d5f3d210c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0832;
x-ms-traffictypediagnostic: MWHPR04MB0832:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0832A897F6B351DC23522223982A0@MWHPR04MB0832.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0832;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0832;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(8936002)(2616005)(6116002)(36756003)(6916009)(2501003)(53936002)(86362001)(2351001)(1730700003)(8676002)(81156014)(305945005)(7736002)(81166006)(11346002)(93886005)(478600001)(106356001)(72206003)(5660300001)(3846002)(105586002)(4326008)(118296001)(66066001)(76176011)(486006)(229853002)(68736007)(6436002)(316002)(97736004)(6512007)(446003)(2900100001)(6246003)(476003)(6486002)(186003)(54906003)(99286004)(256004)(5640700003)(26005)(6506007)(25786009)(5250100002)(14454004)(102836004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0832;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kjZ63Gia1wHq2HswanLTJUtddTEqP2C1KrVdxUAjhy8kV20ymSMUhhNt2xMTkJ9xGYaf6AUMDFPK0ZULtIpJrln/wAA4aleSXUJqs80BGytLTYuJzZf3rOgLVry4eVc+0mFGg0GnzKhrEhbH+OsY6Fpfc94z02/EOv9aOsN8u4aYTK7l/0kLZSpU+uAIsmHGyGKp0APBEt7xSvkrdBfTLxoTzBcNQfORLUkBiyrHbtt6KOaY8WSjhtccHuCCqkavD/TgzAsMLb1XWhdHG1jCgNWOiQhzGNwdzQ5AU98ATBWoACPlZa2Wx2Hi6sD3yGHKSRud9/rtKz01tcT7aAI95EMCd2gZgA7I84B3FGNl8P4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <6D774A8AAECFA74FAD40AE4BA8266B9C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e229d900-f63e-4661-eb78-08d5f3d210c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 15:03:09.0991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 14:35 +-0200, Patrick Steinhardt wrote:
+AD4- +ADw-1+AD4AWw-   53.411700+AF0- BUG: unable to handle kernel NULL poi=
nter dereference at 00000000000001a8
+AD4- +ADw-4+AD4AWw-   53.411733+AF0- RIP: 0010:blk+AF8-set+AF8-runtime+AF8=
-active+-0x2d/0x50

Are you sure commit 4fd41a8552af (+ACI-SCSI: Fix NULL pointer dereference i=
n
runtime PM+ACIAOw- December 2015) is in your kernel tree?

Bart.
