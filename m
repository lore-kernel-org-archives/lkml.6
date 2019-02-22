Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D150C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230482077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wk4JXx6V";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="A1r2tk/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfBVAl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:41:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27969 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBVAlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550796085; x=1582332085;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MeZN3Be0iAjee6mJhtWLFkboTjQdlzGDFhsgDhcc060=;
  b=Wk4JXx6V1uUFUyto7LMo/79gWVvWTQ3oUj1Dv24c9RCGjEzbyqATQ2uz
   O2r6R9KM7jhmPLh1SW63CMs+XLeY4OGo1EPiz+WqlqC/yCgqkTy+N51yP
   JV7A9Y587gygqZtkVYP5WbeVlApsnj8xk+0P9XGD1BjPMmIcGiydOzvQa
   ctwLjTM945o/pXZ3gcVHM1YajDfVG18PljhV30j07x/ftX6MGkoNVEcbn
   eax5GnWOlE9SaHaGlMGf3E0e1h7A8W22HCtXvCzNHN8bKSgtPjfuJIljl
   2QbDndSTvtdfHHBRIx9YROkJiGh0wERba/TONrFr9dL/VdBtFVE+hVS89
   A==;
X-IronPort-AV: E=Sophos;i="5.58,397,1544457600"; 
   d="scan'208";a="101891472"
Received: from mail-by2nam01lp2052.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2019 08:41:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFfNpuvYMD/pZB1rcr9ANtSA/MxGV+CXPXheXTQEoX8=;
 b=A1r2tk/CnA8BsZhMCXhwXhRPHYnTpMIV0nb6EhaZe/UFW2tbMRLgoNFm0qeKhmaXn727Zw3xEQizCl0xvTfW1EMDgPlHlGcOGHbCtzXmifj69mNf1+38rPG2W2jae3tGrr2w+V0L9ApVtLDbJfcO69i+ExuzdWYcUWxK80/pe8E=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4717.namprd04.prod.outlook.com (52.135.122.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 22 Feb 2019 00:41:10 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Fri, 22 Feb 2019
 00:41:10 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>
CC:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: disable direct I/O when unavailable
Thread-Topic: [PATCH] nvmet: disable direct I/O when unavailable
Thread-Index: AQHUyhJ6d8gGSTBblkStjTf6aoWyPA==
Date:   Fri, 22 Feb 2019 00:41:10 +0000
Message-ID: <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190221182234.22345-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 544ba4f4-2edd-462b-33f0-08d6985e70d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4717;
x-ms-traffictypediagnostic: SN6PR04MB4717:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB4717;23:6mnsay3iJ1jrg5lkykVeEVskNkspbwtFtkS3YaP5U?=
 =?us-ascii?Q?F5zRG+1PQ87uQBzym0wF23kZ/rH8xzezzhLs8o4RQ8ZSjWA5oed9g0D/CwWY?=
 =?us-ascii?Q?c7ftcpvVU5vpvzApKOxEW9kQImN1aEOZP43oPmi7He0Gr4s49UbQdZAOsaY4?=
 =?us-ascii?Q?kpbwGav5udLJkLpc0JXboDLitxjJXOtO+i9/5+aR1IbF3y8koTg0iJMOHiTr?=
 =?us-ascii?Q?hvPPDNkMLH5xSbtvT6Btcox25kikDcvThAWTvjVI+PRLLv39rvaMcodLYjj0?=
 =?us-ascii?Q?ebgTT6z0LdktSYhALLnvvn1y9bc1QSrJdJqKJgNTzt2PLHXP43nwCVcXbslE?=
 =?us-ascii?Q?LV9XlFKSL+SJ/x0BgIkTH11w2F0pAZRU1aR/Ej8/Ph6WRTl4Fyjt3J57adFY?=
 =?us-ascii?Q?rZMCw8OhYxcJIy8LNCSu6OOYvNUM2bcKsuI+FWZ/BH23DZpff7PJUjtLdarI?=
 =?us-ascii?Q?n2rItNYSTfvR5C0KbY3ITcPHBbmKf2D6oqiYaTuLTZYFJ795x9CoIG9wyJtX?=
 =?us-ascii?Q?b7eyeh8L8i2OdW8LconRiITmaBynUackIQOYEZ00Ep8lGgNgSXW7retCqNyy?=
 =?us-ascii?Q?aT5T7OzGwXfxYqDftYt1hZG64zUO8yNyQ3ZueKCmmfE0dOLcp/R5/35XRqjS?=
 =?us-ascii?Q?DDIncwVWPqPxE4RSFw0XlyFsmgMjYXQvzqMAkFpfrvQdCDtPyTeql4oo0NGg?=
 =?us-ascii?Q?UiUCq/R7KRdsSyy5MvvfO5CtopVv1vAiVDn8MLZa1ZvmhGjzDOjP03whIm7s?=
 =?us-ascii?Q?PZuSYbYoPzEEIehJsh6uxQEwHPZx3YwxNfSFWLwx2Ri/ADRMvRkqo9uGw/v+?=
 =?us-ascii?Q?JyDqKlzOe0+aew1uHoDerG9nROsc+62mKLd0hAufqjA0rAI42tW7O9mHpPdE?=
 =?us-ascii?Q?l/mvaDFjkmquHvOCJzva27cOcPThZoRcXTwxiPIMDrURRnPPvYR0gYcWPqD7?=
 =?us-ascii?Q?Pmk4/fqXM+K9+KP/cTWVk/k9MCtzEYRvhmGeRD+xKQuEvLoZFs6O4JpYpNWO?=
 =?us-ascii?Q?AfES4jrQofBUXHaUVuz+RGo9DhiOiE+WfwnUl6Mx3emhOKhZdruia4ecPs5E?=
 =?us-ascii?Q?36SMAdNIuMunT0XJHfk5zf72VN6REu1Ht4JQpw53uHhaciMarEv2k+eciwbe?=
 =?us-ascii?Q?utZ6A9wqLkxNaMEkxgpLiiSyScYf05tyZ7bwhDGfoxCx8IrOq52Qwsv3q2Vy?=
 =?us-ascii?Q?lhwXp7KK0c+56UiKy8trIZV/2Laf+fn9VBlszKxTBABem0aWXFvU90O7w=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <SN6PR04MB4717089C69BFEBC13B993840867F0@SN6PR04MB4717.namprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(316002)(8676002)(81156014)(81166006)(2906002)(55016002)(6116002)(76176011)(99286004)(110136005)(68736007)(33656002)(476003)(446003)(8936002)(486006)(9686003)(74316002)(7736002)(186003)(305945005)(54906003)(105586002)(14454004)(7696005)(25786009)(256004)(106356001)(86362001)(97736004)(6436002)(5660300002)(71190400001)(71200400001)(66066001)(26005)(53546011)(102836004)(72206003)(53936002)(6506007)(3846002)(478600001)(229853002)(4326008)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4717;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5sgBAoEXvYQu12SJeWMjrp07rRCtl6J6bxCcQe5Wh+IdCaNCYAS9qJJ+3wvte1+qJYH8ilCZp6h0FBOa8XwKaXxVpNVjhbw/idzS5ECaJiIPobhEDXwyUDOIvyulAY/OsmgNzQQAbm+nJowyRAj0EXHzdYJtJoMFlMiP7SR/8UScCjR4RfuMLYRd/lpiQMimOAlFoSwjVwKqeC2LnIayVNeT2Flg1DkuAfThFQvJ2oppcq0BaNuaI5PPnUWXGDk1+jcEP2qw5MN+jurKrpvoAC1MQjmTKxusLS85WOyhguXsYEZOIQEBvhTHHcpLiW4lv62zs+ujyQNAJxIsuWaSKoOMtR3dgvLrxZ5dUS6TvZPhM//nInuHOdWhMs00oj3T7RQafSLsW9ERgpjnQdYYo9jmsXw5vkZK85i57mu9vls=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544ba4f4-2edd-462b-33f0-08d6985e70d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 00:41:10.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2019 10:23 AM, Johannes Thumshirn wrote:=0A=
> Some file-systems, like tmpfs, do not support direct IO, but file-backed=
=0A=
> namespaces default to using direct IO. If direct IO is unavailable fall=
=0A=
> back to using buffered IO for the file-backed namespace.=0A=
>=0A=
> This might not ultimately be a solution for production environments but=
=0A=
> for test environments it sometimes is feasible to use tmpfs.=0A=
>=0A=
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>=0A=
> ---=0A=
>   drivers/nvme/target/io-cmd-file.c | 10 ++++++++++=0A=
>   1 file changed, 10 insertions(+)=0A=
>=0A=
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c=0A=
> index 517522305e5c..8a861cc0160e 100644=0A=
> --- a/drivers/nvme/target/io-cmd-file.c=0A=
> +++ b/drivers/nvme/target/io-cmd-file.c=0A=
> @@ -38,11 +38,21 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)=0A=
>=0A=
>   	ns->file =3D filp_open(ns->device_path, flags, 0);=0A=
>   	if (IS_ERR(ns->file)) {=0A=
> +		if (ns->file =3D=3D ERR_PTR(-EINVAL) && (flags & O_DIRECT)) {=0A=
> +			flags &=3D ~O_DIRECT;=0A=
> +			ns->buffered_io =3D 0;=0A=
This needs to be set to 1 when we enable buffered I/O.=0A=
> +			ns->file =3D filp_open(ns->device_path, flags, 0);=0A=
> +			if (!IS_ERR(ns->file)) {=0A=
> +				pr_info("direct I/O unavailable, falling back to buffered I/O\n");=
=0A=
> +				goto getattr;=0A=
> +			}=0A=
> +		}=0A=
>   		pr_err("failed to open file %s: (%ld)\n",=0A=
>   				ns->device_path, PTR_ERR(ns->file));=0A=
>   		return PTR_ERR(ns->file);=0A=
>   	}=0A=
>=0A=
> +getattr:=0A=
>   	ret =3D vfs_getattr(&ns->file->f_path,=0A=
>   			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);=0A=
>   	if (ret)=0A=
> kk=0A=
=0A=
As per specified in the patch, this is only useful for testing, then we =0A=
should modify the test scripts so that on creation of the ctrl we switch =
=0A=
to the buffered I/O before running fio.=0A=
=0A=
OR=0A=
=0A=
Similar result can be achieved by setting buffered I/O flag=0A=
buffered_io=3D1 before enabling the name-space in the test script.=0A=
=0A=
=0A=
