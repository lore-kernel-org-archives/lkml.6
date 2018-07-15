Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D82EECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0DD2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 03:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="af15CIgg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y1vmMbG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0DD2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbeGODt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 23:49:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51276 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733104AbeGODt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 23:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531625288; x=1563161288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QYB4XU7Lo8mdjvgvIgBdQXqVfxcglTKARVVdzcbNPnM=;
  b=af15CIggPlGntaixvDzM3PwwNlK9X6oAyfUm2IMcYY6y5EJYzhOZ+NH1
   ez3KEghmQZo81W6FePQRV3EhFFnDaKHZtrpfEX/W2RknV1zCXqUEhQpUl
   CxIhKgcua41bKZtdk6U1f7c+cO0vXWwYFoB0sLTbvHBlniUFWcSPM7ICu
   vmMpNGvcsowf278qWnJdUDA+D73gOmsNP1nrPf6xRh0K+FwlZmNBVYvdG
   vyNVj6NWDhMITSkHQrEFlBHEHrydX6IDYyewOHLeCdv1t6IOHeY8IIOso
   ICSL5CIV8meS2QWCKUevLB2qc5iH5CGS99Mba+Rbfzd7Jl78ppAgMrE/g
   g==;
X-IronPort-AV: E=Sophos;i="5.51,354,1526313600"; 
   d="scan'208";a="85338634"
Received: from mail-bl2nam02lp0086.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([207.46.163.86])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2018 11:28:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9PRWHaPdiEFaIZVtxXNs71JWINv/oCGypFPhY56JRc=;
 b=Y1vmMbG17DlmRAJRn57+bs5IHj1Bm6Yj71v9ON1DqnzOqMNY2LNp+sRvYsUiOu+Al/FkhP6oHxZu8ifWRto2nk8scNYRTb8WERKyJT1exX+jhYjBBdQ074bruuL2FatdwlsVPOP6ua79TaIVs7aJoILCobwiAeBnY/7afmHSZmI=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0782.namprd04.prod.outlook.com (10.172.168.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Sun, 15 Jul 2018 03:28:04 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Sun, 15 Jul 2018
 03:28:04 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Martin.Uecker@med.uni-goettingen.de" 
        <Martin.Uecker@med.uni-goettingen.de>,
        "miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] kernel.h: Avoid that sparse complains about using
 sizeof(void)
Thread-Topic: [PATCH] kernel.h: Avoid that sparse complains about using
 sizeof(void)
Thread-Index: AQHUFHulYJ4VJGGnCUWDyLkAZDmdA6SPkyUAgAACZICAAABgAIAAGMyA
Date:   Sun, 15 Jul 2018 03:28:03 +0000
Message-ID: <efdfce609aebc2f583eb843acad2438dfdf9ec9f.camel@wdc.com>
References: <20180705161709.17028-1-bart.vanassche@wdc.com>
         <CAGXu5jJJLh+oMcZ94nkrwCvyJzk6MzOATvt66WC-rHfxGTJh0Q@mail.gmail.com>
         <CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com>
         <CA+55aFynusYJ8OCS_jnQhOEEjrfVhYV5PLxi_XF8ritsWEcP0A@mail.gmail.com>
In-Reply-To: <CA+55aFynusYJ8OCS_jnQhOEEjrfVhYV5PLxi_XF8ritsWEcP0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0782;7:hYlRKiutyIuZvZTERcvSYfFNqCndeHl891m9g/g/2zEHP0OX1g5skUwwr86GNmMdDJ0dYKidDWEQwSigeU2LYyXUYcgz2fucdmH/Pl6vL0vCvG/DYAwjdQ6SlrQmqH8l5ral2nsJtp5XBU3pfa7Sk76dJmOA8Gf64OXyHgf+0kYurAX+SOdpX35kXKhthrTpNQxN3UZxXzc5S52KL0DaFYM4hJeIKF07dRHu/Gm5ug7P0SN23IGlYHcric+ZTyNN;20:m8m+vkh/UNUfVkOywJt698srUx137uLk4cxb3qwAA47SgGZ3NfT+2Vki57Li5VYsiKQTtZgLMkl95QgG1mePKoTZCE9lmkVk7NPhCUcsb4g5vufpnRw8C9LKSOLIY516ylPeiPt7Cd4/h4TCiocTMcbpPW2G57Ve7I2zsP2qte0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2bacdf4b-cbd9-4603-002c-08d5ea02f98a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0782;
x-ms-traffictypediagnostic: MWHPR04MB0782:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB07820365DF40A456E065EAD9985E0@MWHPR04MB0782.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0782;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0782;
x-forefront-prvs: 07349BFAD2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(39860400002)(366004)(53754006)(199004)(189003)(186003)(76176011)(478600001)(6116002)(345774005)(26005)(102836004)(6506007)(53546011)(6246003)(39060400002)(97736004)(53936002)(3846002)(118296001)(4326008)(25786009)(66066001)(5660300001)(2501003)(5250100002)(93886005)(7736002)(305945005)(86362001)(36756003)(966005)(2201001)(2906002)(72206003)(105586002)(106356001)(8676002)(14454004)(8936002)(81156014)(486006)(476003)(2616005)(81166006)(11346002)(446003)(6306002)(6512007)(316002)(6486002)(68736007)(229853002)(99286004)(6436002)(2900100001)(54906003)(14444005)(256004)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0782;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: m2LonI6OaGEqNV4trdi2z9rZsbruifh6IuMeyYCE6mFS8kot7+NFDn3oq8r6SLcBHjJ816DIYIZppN5R1NMPt7SQnfzIohdzCVC3vjtzXsMGhp8SwxgHqRKqelxb9vsyQCei8Gl/aa5CdVNSzF/V040QrK5lRlnioRmILMZpaRQq7OxzPXiB6Qze4Ww6xE9YthcOu0Wgt9mpg4ww0c916wC5XTBInQ53s4FU67a5+CtJ+pjJQFZvKOiRCIMmlGxN98JLChf8te3Bk48i8WxQOEnb68q0XpUaMI4H3xff7N1z9aAxytO0YznL+6F6QKM/o6gzkcf8wTHU6Uqg44qHGkeDhPQWHy2XbTrMaSFHRJs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <DDB02D99CE1C3545A9ACDE89FF30EEC6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bacdf4b-cbd9-4603-002c-08d5ea02f98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2018 03:28:03.9387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-14 at 18:59 -0700, Linus Torvalds wrote:
+AD4- On Sat, Jul 14, 2018 at 6:57 PM Linus Torvalds
+AD4- +ADw-torvalds+AEA-linux-foundation.org+AD4- wrote:
+AD4- +AD4-=20
+AD4- +AD4- Honestly, I'd like to just encourage people to get the sparse u=
pdate
+AD4- +AD4- from Luc Van Oostenryck instead.
+AD4- +AD4-=20
+AD4- +AD4- For a while there it looked like Chris Li would just pull from =
Luc,
+AD4- +AD4- and we'd have timely releases, but that really doesn't seem to =
have
+AD4- +AD4- ended up happening after all. So right now it's probably just b=
est to
+AD4- +AD4- get Luc's tree instead from
+AD4- +AD4-=20
+AD4- +AD4-     https://github.com/lucvoo/sparse-dev
+AD4- +AD4-=20
+AD4- +AD4- which also ends up fixing a lot of other issues.
+AD4- +AD4-=20
+AD4- +AD4-                 Linus
+AD4-
+AD4- Oh,
+AD4-  and I meant to cc Luc on that email, but then forgot. So here he is =
cc'd now.
+AD4-=20
+AD4-             Linus

Hello everyone,

I will switch to Luc's sparse tree.

Thank you for the feedback.

Bart.







