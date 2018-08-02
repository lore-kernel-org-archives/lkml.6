Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBCEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9137208DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="Vwc344N4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RhmBqgjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9137208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeHBGxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:53:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9731 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeHBGxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533187143; x=1564723143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VLCoBRiCXKjKQ8uCivPI8QZ7pzB31Dc5smuyubkFo+g=;
  b=Vwc344N4hQy28FZpVwVVx/NpA4kVP2GwvVThRdpaGdFDKPJKdUDmYLXu
   cfs6RZ6c72AQUR8EE20kJLDa4tDNoAQlstVNOjHnTXoScX2cSHn8jXb9X
   ScFpAowSBnWJSSgpXI08iR/BN9NQIZeNVvqubGnViYjfVOzmH4VtCb2xR
   yHvh95h5NDsTncko0ULizu6jZoiIKH2N72KXTpWctUCAaYnUzd7cEsvyc
   glpDDlouT0IW1rOunafapYEwv+2Gj2Z63puGeXl94e58M9VJiK6wlqDIh
   4TreTA3dxa24G9pCA5Z0DNYTLtbtYFUmXdkCZn7N5J8lC3OWYegurVi1/
   g==;
X-IronPort-AV: E=Sophos;i="5.51,434,1526313600"; 
   d="scan'208";a="183207139"
Received: from mail-by2nam01lp0181.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([216.32.181.181])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2018 13:19:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLCoBRiCXKjKQ8uCivPI8QZ7pzB31Dc5smuyubkFo+g=;
 b=RhmBqgjXKlOzOc0GuutwQedCYRf8ZRp5XVOypqJRK4nW6J2oV5qlbOXiFLTcl2N2cKwgv4UgMMASsdS55mPB8p1kl5BOwKLmBiizdGfBz7c0DxDkt8hFFCTo+Ni+qUtuhgy3d2JIuQBaloCU6KGQzFEkao2BZZyq5i279afhcU8=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0335.namprd04.prod.outlook.com (10.169.202.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 05:04:00 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%8]) with mapi id 15.20.1017.010; Thu, 2 Aug 2018
 05:04:00 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: Re: linux-next: Tree for Aug 1
Thread-Topic: linux-next: Tree for Aug 1
Thread-Index: AQHUKeplC62Adp/s7EWpMcTZnFWHbKSrkCyAgAAC74CAAAGHgIAAUnqAgAABgIA=
Date:   Thu, 2 Aug 2018 05:04:00 +0000
Message-ID: <e3e32fd801cb1270cddec6fc1ea3dabad4473b64.camel@wdc.com>
References: <20180801175852.36549130@canb.auug.org.au>
         <20180801224813.GA13074@roeck-us.net>
         <1533163965.3158.1.camel@HansenPartnership.com>
         <20180801234727.GA3762@roeck-us.net>
         <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
         <1533168205.3158.12.camel@HansenPartnership.com>
         <171b2cdc-2e74-2b3c-e5f5-c656a196601a@roeck-us.net>
In-Reply-To: <171b2cdc-2e74-2b3c-e5f5-c656a196601a@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0335;20:/17fW+8VAs2jGYfYfi7Y8SViqzhRXv2eIrWKyf7ar4sma9PRsVi2/x971iWV6GKO62zeFCH8uoqc/cnneTeoPaWssr8dseEAZMqSGeUr/Yh94iPCrR7P0L6neHQQaEDJ2kchyZ9zKAO80M1vXmXjBdm/OMdO7HBZiTFq29GJx1Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c94aa316-a27f-4b95-cac9-08d5f8355c50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0335;
x-ms-traffictypediagnostic: MWHPR04MB0335:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB033564F1510BC3B2B54B450E982C0@MWHPR04MB0335.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0335;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0335;
x-forefront-prvs: 07521929C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(54906003)(76176011)(2906002)(6506007)(2201001)(446003)(86362001)(72206003)(6512007)(105586002)(305945005)(486006)(8676002)(11346002)(316002)(2900100001)(106356001)(81156014)(476003)(66066001)(97736004)(99286004)(118296001)(53936002)(110136005)(7736002)(81166006)(2616005)(2501003)(8936002)(36756003)(6436002)(39060400002)(14454004)(25786009)(68736007)(5250100002)(6246003)(102836004)(5660300001)(6486002)(93886005)(26005)(3846002)(186003)(256004)(478600001)(14444005)(4326008)(229853002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0335;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QZuRmiTVlb2GfEyqwE9dtpH3ZA621pDQelLlT+JDQrc2XIOzIhxf1bm7so0KAT2jfpnwVrM9wZ11yMed3pXsITGGBAbxJ7R+0QyST+tGw/ncH3YkERnbQgVM+fTyLMRm9qpWlrAvDkcKSAoER2iX9sH6mB6nqpurA4QhKagvQrAewocorjcILqJdKjVK4jvs3LK1F/Xz+7+WhoC9Jf9T7x9ixFBY9kpbDAatvzD1XauyIB6uZ5vAyggVJXok2Y+wy8s/dwDSsxZrMz4j+TwElzUbcDZNbtotmQj5Obz44tEb8jYKVVLPUAB4nIHdkj6xLGx+vI4gzNyBczmsnD+R1zA7IedHmC0b8DtnTIC/mJw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <54378916F667384BAEA486F5C42A5B28@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94aa316-a27f-4b95-cac9-08d5f8355c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 05:04:00.7453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-01 at 21:58 -0700, Guenter Roeck wrote:
+AD4- I am running out of ideas. Any thoughts on how to track this down fur=
ther ?

Is a shell available when the hang occurs? If so, it would be helpful if yo=
u
could provide a dump of the information in /sys/kernel/debug/block. There i=
s
namely detailed information in that directory about pending commands.

Bart.


