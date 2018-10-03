Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A355C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83D0213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MAoTuq54";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="AAp/DZZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83D0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJCPkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:40:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5434 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbeJCPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538556790; x=1570092790;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=V39shX21TJNKOUaUsXuuqAv3fs6kUm6PVzMsf5PQf4w=;
  b=MAoTuq54m8Jo08IGXiXWLgcdlCNVo5yCz7jHj0lxmjCV0/QsLOBhPAs2
   CU606lzYFTNFhU0BNjJW/QsQbUARFZYOyKn4vGmPZWjfn77CtMsllXBkw
   8kiQS3XW9pnjeiiRdm5hJeGy0dn8UHyPKzntVjLhpvId9L+FVvwvjLv8q
   b7TcI9vPtrnuM0E9nIEBFuXwZmUjeVsYA1fMuCDOlN95BTrd8aNhf5JBA
   hSzDmvZg8Oxu6hvVs0QhOkg6iMDdFXeFCXR5JYDJQ0/FFZnnOM8zemEeA
   6BwX7TLKleSOXhvdiAlcPMjPdfGq8OB3EYq2wPipo/m6HoXSIVlvFVd0i
   Q==;
X-IronPort-AV: E=Sophos;i="5.54,335,1534780800"; 
   d="scan'208";a="92778560"
Received: from mail-co1nam03lp0016.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([216.32.181.16])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 16:53:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V39shX21TJNKOUaUsXuuqAv3fs6kUm6PVzMsf5PQf4w=;
 b=AAp/DZZQD4eM+N/FkoHFrqkfIriYDEWFJKcc5tveWpTubPEfz1hYDBzCuqrbk3P6l3Qd9dFw02JyE0o1D/aZzWoUTK6teys3JEBVGEnl5iB9pgAJnk77gaiuvOH/T/OniLQIxLATgcgfwhXsl9zr9nwWkymL8iy3n9CjKSAQGF0=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1185.namprd04.prod.outlook.com (10.160.155.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Wed, 3 Oct 2018 08:53:03 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::a81d:7688:be04:a661]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::a81d:7688:be04:a661%4]) with mapi id 15.20.1185.026; Wed, 3 Oct 2018
 08:53:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Artem Bityutskiy <dedekind1@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>,
        "aherrmann@suse.com" <aherrmann@suse.com>,
        "mgorman@suse.com" <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Thread-Topic: [PATCH] block: BFQ default for single queue devices
Thread-Index: AQHUWk2QDMBQjA6xOUmaZJha2EJuQQ==
Date:   Wed, 3 Oct 2018 08:53:03 +0000
Message-ID: <BN3PR0401MB1640A32A9464999E7E28689EE7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1185;6:uU2sIgtDuOYw3xLrbRxaWjr4pUD+Yam/EGVDcb+mfZ/J28N6/cKvVUSuCBnnju++gESiVruk7N3k+4a3FYvaRzRPIikYUlAtuU8d3/i1lHJhM19g4eB5o4Qx4y3xwz9xBQxOqowS7TIU2w/cYcc6QGCM62UK7ZakoKjH6QojO1jRh0RRqRXnLNFpBFYsSLOnMrNfC+DdHVdBgUqtD0+IuECeRcdRx7pgFxDu1XSTDGxamSM03cALGLrKkiewa3wf/fs00CV9b13WTgfdHuHoe2SAIMAx5a3NTKb50ae1Z0SYU4rW4+Uu6ePRKYh3+lRblu9fX7nC1D7kOBRgttkElRuKHgIK9HXFpSE2ISb0w9f+eb22f9+/C3cEHFsnHK3JDohkziWlFlR4IbupxJPpM/W5QGCMQk920kCq04g/FHBgUC9zdYo5IqM9VrRsXMa2b5mUHKF7DT/WZx3DK3RbDQ==;5:zoMF+wWySzh5gHgLGKjpIka4CgmTUVGpvwMfnbyDLo8Y/oGLwKLbkJ0u7Lz3BEdw53vrmPkZJwvI0JRaNX1O3DzhfDb+xSY4iSZYdz4W/BS1yEvTHJNxlKA2m9VQI9aw/uXO0TkRkzhL89fwvEQ72coBTauZgCXG+rzH0aM3dZE=;7:qCKnBiZCKYdK/QgEoKbvbC8p/7VJB1KA9FMPfntSkNTKOubj4ahLIrjWjV5V0FUYiSnut3IZSnoX1++4LuMu5CebAql7bW79YVU0uYDUiSoQb3/1/nF20V6TKi2EXWu+T1yqcU4zPDepFEPk2PBhUQZqjoHBYRqSvGCIAOemWcRQr5ObaLHXxP7dl2XyHc/Yt0FX2kT3mvuU3RHv6oQIWTQHJ+a4RancRZ7sfybotZX6QVim5iJtrr+nR6jJgthw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9951b25e-d4d5-4fdc-0064-08d6290da151
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1185;
x-ms-traffictypediagnostic: BN3PR0401MB1185:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1185AF495D350F6438B1D731E7E90@BN3PR0401MB1185.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991048);SRVR:BN3PR0401MB1185;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1185;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(7736002)(7416002)(305945005)(229853002)(74316002)(68736007)(2906002)(14444005)(6436002)(256004)(86362001)(9686003)(55016002)(53546011)(6506007)(102836004)(8936002)(6916009)(33656002)(5660300001)(6246003)(97736004)(71190400001)(71200400001)(81166006)(8676002)(81156014)(3846002)(6116002)(476003)(26005)(486006)(14454004)(93886005)(72206003)(54906003)(99286004)(39060400002)(53936002)(2900100001)(478600001)(66066001)(316002)(4326008)(446003)(105586002)(7696005)(76176011)(186003)(25786009)(5250100002)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1185;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xCuf1aNCAxrD30VQky8sVOw8qQ8nTC/JcklzlenM9Ef+TKrLqGIsh+qc6s2rY5tSPcZ+aWyQA05J+qQEattLils+0sl2ruV44wyBRvK6LvojZOmC0DGc1FEns99r2wAqqLEELa8PlkdYnfIM3cBrPbs0DTmLJwdvyrNoJOYH2iPBCQQq2zlSiNjVFWycxFrA/WQnch/uuUKXqLbI0Zah9EEJlTMJgHVP4Z5UP+38MpB1KLN+w+SC7PwyMbynTCydlOLPcNVmbiWauPb7M4mg7ERxuFxIWjqIjU65KU+uZdUi7vhu2um2cFHi+mnRAIiheVRLIYv3aOMuaeRPPSq4lG+biAPJawzG3fqaTvF3j8Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9951b25e-d4d5-4fdc-0064-08d6290da151
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 08:53:03.6046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,=0A=
=0A=
On 2018/10/03 17:28, Linus Walleij wrote:=0A=
> On Wed, Oct 3, 2018 at 9:42 AM Damien Le Moal <Damien.LeMoal@wdc.com> wro=
te:=0A=
> =0A=
>> There is another class of outliers: host-managed SMR disks (SATA and SCS=
I,=0A=
>> definitely single hw queue). For these, using mq-deadline is mandatory i=
n many=0A=
>> cases in order to guarantee sequential write command delivery to the dev=
ice=0A=
>> driver. Having the default changed to bfq, which as far as I know is not=
 SMR=0A=
>> friendly (can sequential writes within a single zone be reordered ?) is =
asking=0A=
>> for troubles (unaligned write errors showing up).=0A=
> =0A=
> Ah, that is interesting.=0A=
> =0A=
> Which device driver files are we talking about here, specifically?=0A=
> I'd like to take a look.=0A=
=0A=
Currently, sd.c (SCSI disk) as well as null_blk can expose host-managed zon=
ed=0A=
block devices.=0A=
=0A=
> I guess what you say is not that you are looking for the deadline=0A=
> scheduling per se (as in deadline scheduling is nice), what you want is=
=0A=
> the zone locking semantics in that scheduler, is that right?=0A=
=0A=
Yes, correct. The scheduling policy in itself does not really matter, but s=
hould=0A=
not deviate from the mandatory HM write policy: "within a sequential write=
=0A=
required zone, writes must be issued sequentially". That could somewhat imp=
acts=0A=
the scheduler code itself if said scheduler think that not dispatching=0A=
sequential writes in sequence is a good idea :) No sane scheduler would tha=
t=0A=
though (at least on HDDs) so the impact on the scheduler code itself is red=
uced.=0A=
=0A=
> I.e. this business:=0A=
> blk_queue_is_zoned(q)=0A=
> blk_req_zone_write_lock(rq);=0A=
> blk_req_zone_write_unlock(rq);=0A=
> and mq-deadline solves this with a spinlock.=0A=
=0A=
Yes. These are the helper functions handling the zone write locking to simp=
lify=0A=
the task of the scheduler to limit the number of in-flight write request to=
 one=0A=
per zone at most at any time. This is the trick to avoid write reordering=
=0A=
stack-wide, since most of the time, reordering happens not because of the=
=0A=
scheduler itself, but the blk-mq (or legacy path) around it (e.g. requeue d=
ue to=0A=
resource shortage, multiple contexts running the queues, etc).=0A=
=0A=
> I will augment the patch to enforce mq-deadline=0A=
> if blk_queue_is_zoned(q) is true, as it is clear that=0A=
> any device with that characteristic must use mq-deadline.=0A=
> =0A=
> Paoly might be interested in looking into whether BFQ could=0A=
> also handle zoned devices in the future, I have no idea of how=0A=
> hard that would be.=0A=
=0A=
It was rather easy with deadline, but the scheduler code was simple to star=
t=0A=
with. Basically, the only thing needed is on dispatch to skip any write req=
uest=0A=
to a zone that is already locked (i.e. a write is already ongoing). For rea=
ds,=0A=
there are no constraints so nothing needs to be changed. Zone unlocking mus=
t be=0A=
done on completion of the write request so the scheduler completion method =
needs=0A=
to change a little too.=0A=
=0A=
> The zoned business seems a bit fragile. Should it even be=0A=
> allowed to select any other scheduler than deadline on these=0A=
> devices? Presenting all compiled in schedulers in=0A=
> /sysblock/device/queue/scheduler sounds like just giving=0A=
> sysadmins too much rope.=0A=
=0A=
Yes, that is debatable. But the above "one write per zone" trick can be als=
o=0A=
handled by an application, which makes using any other scheduler OK. Look a=
t the=0A=
recent SMR support code in fio from Bart. Some of the tests (in t/zbd) for =
some=0A=
I/O patterns are just fine with any scheduler. In fact any pattern is OK be=
cause=0A=
fio is SMR aware and never issues more than one write per zone. That is how=
ever=0A=
true only and only for I/O sizes that are small enough as to not cause the=
=0A=
kernel to generate multiple BIOs for each I/O call. Otherwise, deadline &=
=0A=
mq-deadline become necessary.=0A=
=0A=
But I agree, it is a little fragile. Application developer and sysadmins re=
ally=0A=
need to know what will be running on the disk to make the right choice. And=
=0A=
knowing that is not necessarily straightforward.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
