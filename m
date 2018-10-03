Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9194C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE9F20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Otbf8Q+D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aiAxUkxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE9F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJCO3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:29:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61951 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeJCO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538552563; x=1570088563;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=md9NwOnOWsdnz7QbVkPitFxqLS4VZksiTZWTfkyk6qQ=;
  b=Otbf8Q+D3Du8oFx5OR6gQk90zG7QNlOg9Pdd7Kn2KYzUiY9fGfSos2dM
   9NLyKWxY29KKOROiPwXlgXWUtd//bykqy/jwKTemcmkjGLrWCZ4yaQJbZ
   GeESX5F4qwbJ1+8hRf+vCl5bE8/KFFTYjop+CsFvJkxVjz/pTKffoapLT
   r14p/KFW2UmtXM2YXHzuLF4amNCDm2rUalbEr/Tf7hG2p6nfBkdbHqtGv
   DFUyJaHPpzhN+HE/E/e92FFc9NocJQvm9C1miZZZkdhwqQDvC2S/Y4cQ+
   mwAdjxHz7KdS/7kdHJcn8moGVDULZDL60ECttF5Lia0S56430WQmy3f/B
   A==;
X-IronPort-AV: E=Sophos;i="5.54,335,1534780800"; 
   d="scan'208";a="188760851"
Received: from mail-co1nam03lp0022.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([216.32.181.22])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 15:42:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md9NwOnOWsdnz7QbVkPitFxqLS4VZksiTZWTfkyk6qQ=;
 b=aiAxUkxex7U0ZTi0fEcEF09tZYE1QlAViYbhJT7fkJTjQIQ9I0MwMkRgjXzEqZdk7Ue+Jng86F1yfMdlxE0yeqtzvlrgJPX/jpOq5KJHvZ3VNEiWbup1uLaLTFvGhoSyfYkCrPkyVlh2l8Ii++d5MSfCRQ/eiqiu3MYVP0v2lcU=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1283.namprd04.prod.outlook.com (10.160.157.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Wed, 3 Oct 2018 07:42:15 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::a81d:7688:be04:a661]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::a81d:7688:be04:a661%4]) with mapi id 15.20.1185.026; Wed, 3 Oct 2018
 07:42:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
CC:     Paolo Valente <paolo.valente@linaro.org>,
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
Date:   Wed, 3 Oct 2018 07:42:15 +0000
Message-ID: <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1283;6:mlHv/6TRf8sFZ97gKALHxi/PFyl4hguQSfZqVlGdkXRtqW/ZwpEvbRxlzQ392Ou6h7G+g1DnJ2ATZ6Pi5c2vN+hP7FuScVQvFK3MRMNJhNkEXAcNh2B1yW/JwSGx2SZjeVu9vacZLpmOJ57mEOBT3BHWpxXWxxRa8waR+FQfArAGIR0nG39A3792LMGBMC0ircWL2DvPoyQbM13axqq5wp4Z4KPv1APeDTvhMZBgoYHC/CP0RW5ylbGZnGGtfqrh9l7Wuc915UXwx87wBiimfq/pEljxT2guT/zusB9M8VFhmd7xyQjEAq/J+rdSpeUn1SzRjEBsGwd3NiLoMgD9g1LHAYhM1lOPHCVyIlJ6pqI+Zzhq6vLy3h4cyCQRSQnjGnbFRZ9b/yVkrccoHqrr1XzraPrpZidvlbChDScxGkFQ6scC3ZO5EdGgeceamYtMgVEIl/cOQGJhMsTcUT6XEg==;5:HZz13Vop2BIctT2d4Lcucnm93WJHBWJt+TAKJNGJxfjgAvZ24Ik+CWdqB/zvpQzPG+OvZfVFRt2wXgT9acPY+VDFX2a0LhSzI4fDihS68J0KVrz+l7qLXb0B/STnbU4SxeblLBvjD4TVqtnIzxI2ilj+aGIwHwI53fh+iruG7NM=;7:WfiWsO44W1RM02Mb6NwPmd7B+gf1yZMaGmaU+0RQohpiMf0BKMOjZvbSAQ4fG+BXqhvlJkMr80kykkZ9lsVatTnzTV+k98jNFpC/KbAItVoTo6NUV5CsfESUKES2K8hl14fL7JbTHEZASICjFCSTR5g+2UJ6Ym1KcW4Y7iQlYiUkcgnusUzzCofCKiGdEXt/anWm1qQlfTAgw/9Z9oc8h4ZNqEiB5fuA9jcUUhwGYmnkaYIKr1xEzD61bE/sUS3U
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5dd56d5f-a00e-40dc-1db4-08d62903bd47
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1283;
x-ms-traffictypediagnostic: BN3PR0401MB1283:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1283BDEFC4F5528B46506765E7E90@BN3PR0401MB1283.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BN3PR0401MB1283;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1283;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(102836004)(6116002)(25786009)(39060400002)(561944003)(486006)(68736007)(99286004)(446003)(33656002)(105586002)(93886005)(106356001)(476003)(316002)(97736004)(66066001)(74316002)(71190400001)(256004)(5250100002)(14444005)(7416002)(305945005)(86362001)(2900100001)(71200400001)(7736002)(81166006)(53936002)(478600001)(53546011)(76176011)(6436002)(8936002)(8676002)(72206003)(2906002)(14454004)(55016002)(6506007)(229853002)(81156014)(9686003)(26005)(5660300001)(6246003)(186003)(7696005)(4326008)(54906003)(3846002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1283;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: v4nHkuNDb16e5GKheZbBFyYDmbxzscdDPo25o1GgNRsODdoxWGWRfTVlTIX21PLgUF+b6bpEQrCz0iDYGD/2Uw8rJkX9iGdyWsEmSVy9s8MAeMyO1o/Mlmkj44NxGHa8IFGJkRJ1CIRzxwSvWNzzeVJ2oWRfQt3bIjRDOlcKydd7RDv3QuKV5BX5VqjZYMXF3HD0mGe5ieJLvw9cmOQ6btqMQvy0jCqvBFyNCu5RETUjWbpTDtf/s2W5OUuGU8A2z9eFYBzfjOa8CNrWPgzTff31/b9F716THFXuV2mG7qBFXjebIYe1Orwpy3yxgIT/UqVWBuxqiSJ2wXL6Ya59olHnEMqHWphZCPf+ncZSJi0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd56d5f-a00e-40dc-1db4-08d62903bd47
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 07:42:15.3026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/03 16:18, Linus Walleij wrote:=0A=
> On Wed, Oct 3, 2018 at 9:05 AM Artem Bityutskiy <dedekind1@gmail.com> wro=
te:=0A=
>> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:=0A=
>>> So, I do understand your need for conservativeness, but, after so much=
=0A=
>>> evidence on single-queue devices, and so many years! :), what's the=0A=
>>> point in keeping Linux worse for virtually everybody, by default?=0A=
>>=0A=
>> Sounds like what we just need a mechanism for the device (ubi block in=
=0A=
>> this case) to select the I/O scheduler. I doubt enhancing the default=0A=
>> scheduler selection logic in 'elevator.c' is the right answer. Just=0A=
>> give the driver authority to override the defaults.=0A=
> =0A=
> This might be true in the wider sense (like for what scheduler to=0A=
> select for an NVME device with N channels) but $SUBJECT is just=0A=
> trying to select BFQ (if available) for devices with one and only one=0A=
> hardware queue.=0A=
> =0A=
> That is AFAICT the only reasonable choice for anything with just=0A=
> one hardware queue as things stand right now.=0A=
> =0A=
> I have a slight reservation for the weird outliers like loopdev, which=0A=
> has "one hardware queue" (.nr_hw_queues =3D=3D 1) though this=0A=
> makes no sense at all. So I would like to know what people think=0A=
> about that. Maybe we should have .nr_queues and .nr_hw_queues=0A=
> where the former is the number of logical queues and the latter=0A=
> the actual number of hardware queues.=0A=
=0A=
There is another class of outliers: host-managed SMR disks (SATA and SCSI,=
=0A=
definitely single hw queue). For these, using mq-deadline is mandatory in m=
any=0A=
cases in order to guarantee sequential write command delivery to the device=
=0A=
driver. Having the default changed to bfq, which as far as I know is not SM=
R=0A=
friendly (can sequential writes within a single zone be reordered ?) is ask=
ing=0A=
for troubles (unaligned write errors showing up).=0A=
=0A=
A while back, we already had this discussion with Jens and Christoph on the=
 list=0A=
to allow device drivers to set a sensible default I/O scheduler for devices=
 with=0A=
"special needs" (e.g. host-managed SMR). At the time, the conclusion was th=
at=0A=
udev (or something alike in userland) is better suited to set a correct sch=
eduler.=0A=
=0A=
Of note also is that host-managed like sequential zone devices are also lik=
ely=0A=
to show up soon with the work being done in the NVMe standard on the new "Z=
oned=0A=
namespace" feature proposal. These devices will also require a scheduler li=
ke=0A=
mq-deadline guaranteeing per-zone in-order delivery of sequential write=0A=
requests. Looking only at the number of queues of the device is not enough =
to=0A=
choose the best (most reasonnable/appropriate) scheduler.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
