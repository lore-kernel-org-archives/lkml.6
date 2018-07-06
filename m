Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FDDC6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3E92406B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 00:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="PzVORhHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3E92406B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeGFAT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 20:19:56 -0400
Received: from mail-eopbgr720045.outbound.protection.outlook.com ([40.107.72.45]:27680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753404AbeGFATz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 20:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tT06e5lFq7YAO8etPh1ezCuLQrPeDfi/XCiNCiPuKY=;
 b=PzVORhHdnn63D86XLuLgtaZ2sFoLYVNuvUrcBc7YZMppmLsYMxO4LE9XMw/oXyYpWULZfuEyvdTk71lxQinmnSqgDNBOB9Aw7r2lCIXHbqpPdRS6VmVVg1THK743+xD6JvHK+Rz+bgbKpJDH8J6Ko7Bp3lnxyhqruC6fdLCK2mg=
Received: from BN7PR07MB4673.namprd07.prod.outlook.com (52.135.249.147) by
 BN7PR07MB4820.namprd07.prod.outlook.com (52.133.223.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Fri, 6 Jul 2018 00:19:52 +0000
Received: from BN7PR07MB4673.namprd07.prod.outlook.com
 ([fe80::7462:ed58:fdc0:7f64]) by BN7PR07MB4673.namprd07.prod.outlook.com
 ([fe80::7462:ed58:fdc0:7f64%3]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 00:19:51 +0000
From:   "Chickles, Derek" <Derek.Chickles@cavium.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
CC:     "Burla, Satananda" <Satananda.Burla@cavium.com>,
        "Manlunas, Felix" <Felix.Manlunas@cavium.com>,
        "Vatsavayi, Raghu" <Raghu.Vatsavayi@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] liquidio: make timeout HZ independent and readable
Thread-Topic: [PATCH] liquidio: make timeout HZ independent and readable
Thread-Index: AQHUEjB5BSwymCaRV0C8SF6BPe5+SqSBWPZg
Date:   Fri, 6 Jul 2018 00:19:51 +0000
Message-ID: <BN7PR07MB46733C753AD60F8FA58A7D79F3470@BN7PR07MB4673.namprd07.prod.outlook.com>
References: <1530555195-28129-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1530555195-28129-1-git-send-email-hofrat@osadl.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Derek.Chickles@cavium.com; 
x-originating-ip: [50.233.148.155]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR07MB4820;7:mHD/KHo7Nkcfsw1krpaLiJRHdh7iFlttuHay5bYLDJF3DjH+z2BF5TtQBzwidmS5DLQhgvPKJJnom8u3SBrfLOAeTad3ZNvIw0Xr5FUJq9G9Cu/ofHyK+GaCwxzeAbyGz+XfpVi4JF54Vvv3SorLTHNcWpA+NC/AHdKGLQN1xOEyCazJzRUGZGB0m7RuGX3o+6ofGH/3T435NGSmu1KJz+lbq/gz2cX9wCmRxske3WVHKbwq5LkkSgX5wgEeAEtD
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(14444005)(72206003)(256004)(53936002)(6246003)(6436002)(25786009)(6916009)(33656002)(6116002)(7736002)(74316002)(305945005)(66066001)(3846002)(229853002)(316002)(99286004)(2906002)(8936002)(54906003)(476003)(11346002)(86362001)(478600001)(5660300001)(26005)(2900100001)(76176011)(446003)(6506007)(14454004)(102836004)(486006)(105586002)(4326008)(68736007)(5250100002)(53546011)(81166006)(55016002)(97736004)(186003)(7696005)(9686003)(81156014)(8676002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4820;H:BN7PR07MB4673.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: d014454b-0847-416f-a5cd-08d5e2d630f8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4820;
x-ms-traffictypediagnostic: BN7PR07MB4820:
x-microsoft-antispam-prvs: <BN7PR07MB4820886AF6EA3375F48BF546F3470@BN7PR07MB4820.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4820;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4820;
x-forefront-prvs: 0725D9E8D0
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t7sdDG1QQAXUEJ4YdyniAvQ4D6bByQ/pft771PY4Z7Hjth+86tXQtxrXty44IixVaNDWqxJE8AH1tqVbfwZaRhEp98sUW14z0ul9WGSa+JTD9yGYL/m/rMIjfMzdRRZxeXm5tidIE3Veg11VGTyhJutBmIC3JJa9GOPqA6yafK+u//ctQNNLrt/vBIQV4pEj0E642ceagtPUBUwRhCY/wgIBy5wfckg+92ZEYzmIs456PavKityYO83CxB/ZnesE9hqR5371pqJiQM147jJnVD6XXxD0dRa1XCipEpfHogLi5xg82r/lPpBxs/dHgHrMFiiFrPXZk4Zz5LVbImsyRnXk+vu+jrvqs4G8oj9Xl4o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d014454b-0847-416f-a5cd-08d5e2d630f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 00:19:51.3867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicholas Mc Guire [mailto:hofrat@osadl.org]
> Sent: Monday, July 02, 2018 11:13 AM
> Subject: [PATCH] liquidio: make timeout HZ independent and readable
>=20
> schedule_timeout_* takes a timeout in jiffies but the code currently is p=
assing in
> a constant which makes this timeout HZ dependent. So define a constant wi=
th
> (hopefully) meaningful name and pass it through
> msecs_to_jiffies() to fix the HZ dependency.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org> commit f21fb3ed364b
> ("Add support of Cavium Liquidio ethernet adapters")
> ---
>=20
> Problem found by experimental coccinelle script
>=20
> The current wait time can vary by a factor 10 depending on the HZ setting=
 chose,
> which does not seem reasonable here.
>=20
> The below patch sets the timeout to 1s - which is the current duration as=
suming
> a setting of HZ=3D=3D 100. It is though not clear if this is the intent o=
r if it should be
> shorter as it is not clear what HZ setting was assumed during design and =
used for
> testing.
>=20
> This needs an ack by someone who knows the device and can confirm that
> waiting 1s for in-flight requests on device removal is reasonable.
>=20
> Patch was compile tested with: x86_64_defconfig (implies
> CONFIG_NET_VENDOR_CAVIUM=3Dy)
> (with a large number of sparse warnings though unrelated to the proposed
> change)
>=20
> Patch is against 4.18-rc2 (localversion-next is -next-20180702)
>=20
>  drivers/net/ethernet/cavium/liquidio/lio_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 7cb4e75..b2d0598 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -91,6 +91,9 @@ static int octeon_console_debug_enabled(u32 console)
>   */
>  #define LIO_SYNC_OCTEON_TIME_INTERVAL_MS 60000
>=20
> +/* time to wait for possible in-flight requests in milliseconds */
> +#define WAIT_INFLIGHT_REQUEST  msecs_to_jiffies(1000)
> +
>  struct lio_trusted_vf_ctx {
>         struct completion complete;
>         int status;
> @@ -259,7 +262,7 @@ static inline void pcierror_quiesce_device(struct
> octeon_device *oct)
>         force_io_queues_off(oct);
>=20
>         /* To allow for in-flight requests */
> -       schedule_timeout_uninterruptible(100);
> +       schedule_timeout_uninterruptible(WAIT_INFLIGHT_REQUEST);
>=20
>         if (wait_for_pending_requests(oct))
>                 dev_err(&oct->pci_dev->dev, "There were pending requests\=
n");
> --
> 2.1.4

Looks fine.

Acked-by: Derek Chickles <derek.chickles@caviumnetworks.com>
