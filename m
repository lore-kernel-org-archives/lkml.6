Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 04:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB74D2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 04:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RdKqUKwt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KiGeLqwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB74D2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbeGOE3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 00:29:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46335 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeGOE3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 00:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531627663; x=1563163663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ac63GzVZHkZKUuWsdgYFbKw+ihL2d0+645HnYL9QvnU=;
  b=RdKqUKwttxPnBVhNWo5xgnphu3eDJuKkQ0JlUBVnSqIa716Ifx9VlN2p
   hXpWFp0nDXzIX6Oo1E9T2mvuuYgMdrFyDhlzHfHrSfDkJ+jTjvRJRJ70j
   ovceDVCKUt9gppQkXD6xsn5fv1k8U09hXtWGzaZZUwcNfmO9xB40vX3jt
   t9BYA6QD1ZD3XXSl9ZVVvkPcdwoR2HEDMWYnxdu9MKUZguGxT/tCgnOzs
   u7k57GrCsPn/h4pHhw6eGCoKYEMu9s+U/wqfQ0xAiG6btRDqdMZZt87n0
   bFkC1n5wXcmnCJ2UYbGm9MR6IVbj9QfgCQmKs3N8qIwu6t4uGH4WY7Qro
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,355,1526313600"; 
   d="scan'208";a="84756181"
Received: from mail-co1nam05lp0080.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([216.32.181.80])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2018 12:07:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmBt/8rHVEiWwGxhp6J9jBrFwPYFQFO8DmSoQgBEIPs=;
 b=KiGeLqwXqMWEDl+SJebdHR0KQstfwDpu4v1NGVoOmY5EnMIGnmAlVLwUy7+P9ShBHjwI1uxbWNX3C94v2cXkev8NuSdLMyiEJAy26szwf+hhLf3/y//pghKuO/CV4UQw6kb8xI+ihG8g9cyqhVGytPb0vlqmub3sN67jcmPFjmk=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0479.namprd04.prod.outlook.com (10.173.48.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Sun, 15 Jul 2018 04:07:39 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Sun, 15 Jul 2018
 04:07:39 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luc.vanoostenryck@gmail.com" <luc.vanoostenryck@gmail.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Martin.Uecker@med.uni-goettingen.de" 
        <Martin.Uecker@med.uni-goettingen.de>,
        "miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "konstantin@linuxfoundation.org" <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] kernel.h: Avoid that sparse complains about using
 sizeof(void)
Thread-Topic: [PATCH] kernel.h: Avoid that sparse complains about using
 sizeof(void)
Thread-Index: AQHUFHulYJ4VJGGnCUWDyLkAZDmdA6SPkyUAgAACZICAAABgAIAAI9sA
Date:   Sun, 15 Jul 2018 04:07:39 +0000
Message-ID: <480382ffffcb3008bc317b0c6cec68078e797e27.camel@wdc.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0479;7:JeKxxQvLjCGoXu7BacvKPyXLEyC8R1r4ZVYe7mOBWEGvC8js8pe9AyvlY8qPhPdwNhfJyelJaVhU1Eg2plMH5is6WN0eWlrF2aM1i1B4izxR+z7XUdsGEJfQvg591jtPbd+cC+g3PdNnOkQMrrvujySCFb9UjHsKsU7dSuN1kpdADr7kCoVMaThRSTZXQilkwE7h3na01IcHpsG5rQwWORgsFhM5gfctUNnFLChgE2LhNqJDtWZSB7dybOuElWUR;20:+pf0SME4tFIdXNy2VRvNF4vIXH5pPHIlTvnQ9p3dNBhE+hrz7hzaswJVR5l9Ccq88pO3sNh+zSj5nSRU85WY2FMdbrFJyuySpOHkXXvXEtr6gmJVlgQGHlArR6s2UiXb3fouD1GQggoP846l0w5t8ZoRjd7fwSVzvSew92ER2m8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5c153cb0-0b39-4f7f-92ef-08d5ea08815b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0479;
x-ms-traffictypediagnostic: MWHPR04MB0479:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB04791324B769B4F60C97F8EC985E0@MWHPR04MB0479.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0479;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0479;
x-forefront-prvs: 07349BFAD2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(229853002)(25786009)(66066001)(5250100002)(81156014)(81166006)(106356001)(446003)(14454004)(16799955002)(476003)(68736007)(11346002)(2616005)(39060400002)(86362001)(72206003)(105586002)(4326008)(8936002)(2501003)(478600001)(347745004)(5660300001)(966005)(8676002)(26005)(2906002)(76176011)(6306002)(36756003)(186003)(6486002)(6436002)(2900100001)(53936002)(6512007)(99286004)(305945005)(7736002)(14444005)(97736004)(110136005)(93886005)(3846002)(6116002)(118296001)(256004)(316002)(54906003)(6246003)(6506007)(2201001)(53546011)(486006)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0479;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: LdR8kDcKT+0tklxwT3cTkTRrM/d8OHiTcAIu/L/xr4WDYNdb5WRC5EwVHpyI6p9po5MrbpbFdrUwytoWDpZ1t3yAfL5m0ITmgQZ2Q7f8z304PvWhDrRX0DdHPDHyLHjk7HwwEkyqOg/y3rI6g5LvHIosXZnAPap8EKMXSHqvCt2DOSLrDapZgKdFJC/nxtbmx8W1gvlHg2+bTd20iGC36ZuoBlx1lkb63cek0C1EGaAeWN7P+sg8bLtXU9KfMd0/3leaRMQ+32jgaaAfUMExAEBd9UtHEYk/dO9scrp/kc0YT6ko5ZN4p/ckMhqeMiMJGpPzLyV3hqepGW8iExIqsR7MXnMOdVBTsBKOIpxYo5Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <D80C7E69E85E0D49BDEDEB647A57ADC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c153cb0-0b39-4f7f-92ef-08d5ea08815b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2018 04:07:39.2732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-14 at 18:59 -0700, Linus Torvalds wrote:
+AD4- On Sat, Jul 14, 2018 at 6:57 PM Linus Torvalds +ADw-torvalds+AEA-linu=
x-foundation.org+AD4- wrote:
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
+AD4-=20
+AD4- Oh,
+AD4-  and I meant to cc Luc on that email, but then forgot. So here he is =
cc'd now.

(+- Konstantin)

Something that is confusing for kernel developers is that the sparse wiki
(https://sparse.wiki.kernel.org/index.php/Main+AF8-Page) refers kernel deve=
lopers
to an outdated sparse tree. Should something be done about this inconsisten=
cy?
Should the sparse wiki point at one of Luc's sparse trees or should perhaps
Luc be granted access to the tree that wiki points at
(https://git.kernel.org/pub/scm/devel/sparse/sparse.git)?

Thanks,

Bart.





