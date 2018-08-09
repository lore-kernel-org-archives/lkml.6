Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F86C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C5221E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gxb5N9aO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="guO5zd5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C5221E5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeHIXS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:18:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25092 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533847913; x=1565383913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9k3evhAj3sgr0rJHjey1HC369bGnFt/jXKI0Z6WYx90=;
  b=gxb5N9aOuf4uMOFSwq6Yut6gfkoYvEy72nkv+pE0Ew8Y4f4I6D22xB0f
   iiEPqzVymx8y0KYrInh5KHlUdQTzyy2sj8P2Z+B67tVOTI0ZdhjiR/hZP
   PYu4wqPxCaBi5b/n0ztKCHqNgfcy96grgJalIzVnRYAfCB0Bk3dnyJNs0
   QbuADZjfciItwDEpz8IMHu28Ti0o52TydBQnP/dXcFJmqdrp78z3ve3/V
   OiqU5JT1CexGsQWFp1XjU+sKsCrAxVazPLf+4gIBOgJ2aG1iJKNoN49WL
   O3W5KWDrTqvlyw948tTGJisk/TA2nQKYtBL8hmUXecBaKYf9zr+0QDiRo
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,215,1531756800"; 
   d="scan'208";a="88710892"
Received: from mail-co1nam04lp0047.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([216.32.181.47])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2018 04:51:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9k3evhAj3sgr0rJHjey1HC369bGnFt/jXKI0Z6WYx90=;
 b=guO5zd5TcSLz5oy6IFCodozxbkzz30TeHJ8pXKbns92vshk9kz9FU55DjneKto23QGAxXou4flIjnBE8W4n5pznFOrAgYXMXI8iqU14GwVXI6zfrZvXalX6tr9OzPT1VuFcGBkuePt9cWf2NkuwHoUatG3SFYWkLvIxXKUKRBQE=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0799.namprd04.prod.outlook.com (10.172.168.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Thu, 9 Aug 2018 20:51:51 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::855a:8758:5f65:f8ee%9]) with mapi id 15.20.1038.023; Thu, 9 Aug 2018
 20:51:51 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "mb@lightnvm.io" <mb@lightnvm.io>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "loberman@redhat.com" <loberman@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: Zoned block device support for fio (was: [PATCH 0/2] null_blk:
 zone support)
Thread-Topic: Zoned block device support for fio (was: [PATCH 0/2] null_blk:
 zone support)
Thread-Index: AQHUMCLL/N47X1PiGU2A2Qofx+wgBA==
Date:   Thu, 9 Aug 2018 20:51:50 +0000
Message-ID: <8d1946fb8f46c66b572a7643d47f9762154d1e8b.camel@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
         <1530899118.31977.1.camel@redhat.com>
         <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
         <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
         <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
         <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
         <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
         <9225abd8-35de-641d-2d2b-7ed566fb9956@kernel.dk>
         <ba99bc66928277b73cdbeb8579d739db0cf58639.camel@wdc.com>
         <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
In-Reply-To: <be88923a-b960-0786-bd21-a4107cccd834@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [174.62.111.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0799;20:4SLI0u9tJM5JjuJzr4na5wYipH7fmohRVt+iP8PpiTiHt/0R3uQAi11HzQ9UhUc1koEv4XWNxZ4oo/gozJ+xPfA0imgMpQs9Ot4iWChVf5PatTlv/474tQw8bb37CkaBK0iTycHKl8lPwMu5oHGPd01F/eer6VG97XRc9gDNUCo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 2cc37787-806b-4357-3730-08d5fe39ee78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0799;
x-ms-traffictypediagnostic: MWHPR04MB0799:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB07997B78FE2E5F514B1B649498250@MWHPR04MB0799.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0799;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0799;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(8676002)(7736002)(14444005)(3846002)(86362001)(229853002)(2201001)(72206003)(6116002)(97736004)(256004)(6486002)(66066001)(316002)(486006)(446003)(36756003)(6246003)(476003)(93886005)(118296001)(53936002)(106356001)(8936002)(99286004)(105586002)(11346002)(6436002)(5250100002)(2501003)(305945005)(2616005)(110136005)(54906003)(76176011)(81166006)(81156014)(6512007)(4326008)(26005)(5660300001)(186003)(102836004)(25786009)(68736007)(53546011)(6506007)(478600001)(2906002)(14454004)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0799;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 5KJU4bpilIrzfqiWy60OyuJFaC+DOTPjR2vCOCAUqh74SptMi50+4Hc4VINVPueHRumAOtmQp0tOi3eJ8Z0pNk8Ij3GXWDLFq89n3rtkFPSUrD7jBwXYUqEt8foF2qnlwkeVjoa4L6HYD5MOqUUx3S5DmKUX+ULLRT1wYPkhSUi8o1r9EO/el29H8UnkjJiGKonSHosWcpw5HLCeTV6sA9WhpsHrGsq8yL2zQomN6C0vQGD1ekRSFwV1Y0IoyoCyV4JosEhS8Xben/YMVQnvlDCVE9EKdKr2PpYpQwafVnUeHNONaR1Fq0dsvBFC4hfkguwEEpFbSWW7jmTPjAL4A3dwNFmuwgUyiDHm3hdgGx4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-7"
Content-ID: <DA0BF53397359E43B220681AA2EDF8CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc37787-806b-4357-3730-08d5fe39ee78
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 20:51:50.9079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 12:51 -0600, Jens Axboe wrote:
+AD4- On 7/10/18 12:49 PM, Bart Van Assche wrote:
+AD4- +AD4- On Tue, 2018-07-10 at 12:45 -0600, Jens Axboe wrote:
+AD4- +AD4- +AD4- The difference between the job file and the
+AD4- +AD4- +AD4- workload run can be huge. Consider something really basic=
:
+AD4- +AD4- +AD4-=20
+AD4- +AD4- +AD4- +AFs-randwrites+AF0-
+AD4- +AD4- +AD4- bs+AD0-4k
+AD4- +AD4- +AD4- rw+AD0-randwrite
+AD4- +AD4- +AD4-=20
+AD4- +AD4- +AD4- which would be 100+ACU- random 4k writes. If I run this o=
n a zoned device,
+AD4- +AD4- +AD4- then that'd turn into 100+ACU- sequential writes.
+AD4- +AD4-=20
+AD4- +AD4- That's not correct. The ZBD code in the github pull request ser=
ializes writes
+AD4- +AD4- per zone, not globally.
+AD4-=20
+AD4- That's a totally minor detail. If all my random writes fall within a =
single
+AD4- zone, then they'd be 100+ACU- sequential. For N open zones, you'd be =
100+ACU-
+AD4- sequential within the zone. The point is that the workload as defined=
 and
+AD4- the workload as run are two totally different things, and THAT is the
+AD4- problem.

Hello Jens,

What you proposed in a previous e-mail, namely to use the existing fio zone
concept for zoned block devices sounds interesting to me. This is something=
 I
will definitely look further into. This will help to make a given workload
that is suited for zoned block devices to behave (almost) identical when ru=
n
against a regular block device. Since fio users expect that no zones are
reset before e.g. a random write test is started, there will always be a sm=
all
difference in behavior between a workload run against a zoned block device =
and
a workload run against a regular device if some zones already contain data.

It's not clear to me how close you want the behavior of fio to be for zoned
and regular block devices. Do you e.g. want me to introduce a new I/O patte=
rn
(--rw+AD0-...) that causes fio to write sequentially inside a zone and for =
which
zones are selected randomly? I don't see any other approach that allows to
make sure that the same workload definition behaves identically against zon=
ed
and regular block devices.

Thanks,

Bart.

