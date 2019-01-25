Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A27CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AAC218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="E8qdPnL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfAYVfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:35:11 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:6304 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYVfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4656; q=dns/txt; s=iport;
  t=1548452109; x=1549661709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cRqa1T/Ewe+3TO5TxxqOglPKe+QuzmOhEprUeQhKTdE=;
  b=E8qdPnL9kYW0tEecbNmxGwN3GEs5xSNfcmramGQM5kAHmQnhOL2cM2Nq
   PQD6MbYrDXnK66ILO3EOAAWIu+kk2u4ERIsDpg86bfzme5KHtXZhZ4y7c
   N6Oxzwbnso7wuQ1GsX2BGf7NrX51WWJnf93qtyPFTvSQiAfX+FafzsZel
   4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ADAABxgEtc/5NdJa1kGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBggNngQMnCowRi3WCDZgHgXsLAQEjhEk?=
 =?us-ascii?q?CgwoiNAkNAQMBAQIBAQJtHAyFSgEBAQECATo/BQsCAQgYHhAyJQIEDgWDIgG?=
 =?us-ascii?q?BeQgPq3+ELgGFegWMQReBQD+BEScfgkyFAYM6giYCi2iWUAkChyqKfhiSJ48?=
 =?us-ascii?q?4i2YCERSBJx84gVZwFWUBgkGCJxeIX4U/QTGKD4EfAQE?=
X-IronPort-AV: E=Sophos;i="5.56,523,1539648000"; 
   d="scan'208";a="509406597"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 21:35:08 +0000
Received: from XCH-RCD-019.cisco.com (xch-rcd-019.cisco.com [173.37.102.29])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id x0PLZ8jY017682
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 25 Jan 2019 21:35:08 GMT
Received: from xch-rcd-018.cisco.com (173.37.102.28) by XCH-RCD-019.cisco.com
 (173.37.102.29) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 15:35:07 -0600
Received: from xch-rcd-018.cisco.com ([173.37.102.28]) by
 XCH-RCD-018.cisco.com ([173.37.102.28]) with mapi id 15.00.1395.000; Fri, 25
 Jan 2019 15:35:07 -0600
From:   "Parvi Kaustubhi (pkaustub)" <pkaustub@cisco.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        "Christian Benvenuti (benve)" <benve@cisco.com>,
        "Nelson Escobar (neescoba)" <neescoba@cisco.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve Wise <swise@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH 2/2] infiniband: prefix header search paths with
 $(srctree)/
Thread-Topic: [PATCH 2/2] infiniband: prefix header search paths with
 $(srctree)/
Thread-Index: AQHUtGgSCOujeGpWYkaYGC5agdeb/6XA53OA
Date:   Fri, 25 Jan 2019 21:35:07 +0000
Message-ID: <DAD82200-BFAE-43C7-B668-7D1AED5D5C15@cisco.com>
References: <1548391171-6407-1-git-send-email-yamada.masahiro@socionext.com>
 <1548391171-6407-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548391171-6407-3-git-send-email-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.155.161.57]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC49761C65E12C43B53365F6DEFC97CA@emea.cisco.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Outbound-SMTP-Client: 173.37.102.29, xch-rcd-019.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

Acked-by: Parvi Kaustubhi <pkaustub@cisco.com>

> On Jan 24, 2019, at 8:39 PM, Masahiro Yamada <yamada.masahiro@socionext.c=
om> wrote:
>=20
> Currently, the Kbuild core manipulates header search paths in a crazy
> way [1].
>=20
> To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> the search paths in the srctree. Some Makefiles are already written in
> that way, but not all. The goal of this work is to make the notation
> consistent, and finally get rid of the gross hacks.
>=20
> Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> ("kbuild: do not drop -I without parameter").
>=20
> [1]: https://patchwork.kernel.org/patch/9632347/
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
> drivers/infiniband/hw/bnxt_re/Makefile | 2 +-
> drivers/infiniband/hw/cxgb3/Makefile   | 2 +-
> drivers/infiniband/hw/cxgb4/Makefile   | 4 ++--
> drivers/infiniband/hw/hns/Makefile     | 2 +-
> drivers/infiniband/hw/i40iw/Makefile   | 2 +-
> drivers/infiniband/hw/ocrdma/Makefile  | 2 +-
> drivers/infiniband/hw/usnic/Makefile   | 2 +-
> 7 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/bnxt_re/Makefile b/drivers/infiniband/=
hw/bnxt_re/Makefile
> index 6e3bc25..ee9bb1b 100644
> --- a/drivers/infiniband/hw/bnxt_re/Makefile
> +++ b/drivers/infiniband/hw/bnxt_re/Makefile
> @@ -1,6 +1,6 @@
> # SPDX-License-Identifier: GPL-2.0
>=20
> -ccflags-y :=3D -Idrivers/net/ethernet/broadcom/bnxt
> +ccflags-y :=3D -I $(srctree)/drivers/net/ethernet/broadcom/bnxt
> obj-$(CONFIG_INFINIBAND_BNXT_RE) +=3D bnxt_re.o
> bnxt_re-y :=3D main.o ib_verbs.o \
> 	     qplib_res.o qplib_rcfw.o	\
> diff --git a/drivers/infiniband/hw/cxgb3/Makefile b/drivers/infiniband/hw=
/cxgb3/Makefile
> index 66fe091..34bb86a 100644
> --- a/drivers/infiniband/hw/cxgb3/Makefile
> +++ b/drivers/infiniband/hw/cxgb3/Makefile
> @@ -1,5 +1,5 @@
> # SPDX-License-Identifier: GPL-2.0
> -ccflags-y :=3D -Idrivers/net/ethernet/chelsio/cxgb3
> +ccflags-y :=3D -I $(srctree)/drivers/net/ethernet/chelsio/cxgb3
>=20
> obj-$(CONFIG_INFINIBAND_CXGB3) +=3D iw_cxgb3.o
>=20
> diff --git a/drivers/infiniband/hw/cxgb4/Makefile b/drivers/infiniband/hw=
/cxgb4/Makefile
> index 9edd920..31a87d9 100644
> --- a/drivers/infiniband/hw/cxgb4/Makefile
> +++ b/drivers/infiniband/hw/cxgb4/Makefile
> @@ -1,5 +1,5 @@
> -ccflags-y :=3D -Idrivers/net/ethernet/chelsio/cxgb4
> -ccflags-y +=3D -Idrivers/net/ethernet/chelsio/libcxgb
> +ccflags-y :=3D -I $(srctree)/drivers/net/ethernet/chelsio/cxgb4
> +ccflags-y +=3D -I $(srctree)/drivers/net/ethernet/chelsio/libcxgb
>=20
> obj-$(CONFIG_INFINIBAND_CXGB4) +=3D iw_cxgb4.o
>=20
> diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/h=
ns/Makefile
> index 004c88b..e2a7f14 100644
> --- a/drivers/infiniband/hw/hns/Makefile
> +++ b/drivers/infiniband/hw/hns/Makefile
> @@ -2,7 +2,7 @@
> # Makefile for the Hisilicon RoCE drivers.
> #
>=20
> -ccflags-y :=3D  -Idrivers/net/ethernet/hisilicon/hns3
> +ccflags-y :=3D  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
>=20
> obj-$(CONFIG_INFINIBAND_HNS) +=3D hns-roce.o
> hns-roce-objs :=3D hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
> diff --git a/drivers/infiniband/hw/i40iw/Makefile b/drivers/infiniband/hw=
/i40iw/Makefile
> index 5a8a7a3..8942f82 100644
> --- a/drivers/infiniband/hw/i40iw/Makefile
> +++ b/drivers/infiniband/hw/i40iw/Makefile
> @@ -1,5 +1,5 @@
> # SPDX-License-Identifier: GPL-2.0
> -ccflags-y :=3D  -Idrivers/net/ethernet/intel/i40e
> +ccflags-y :=3D  -I $(srctree)/drivers/net/ethernet/intel/i40e
>=20
> obj-$(CONFIG_INFINIBAND_I40IW) +=3D i40iw.o
>=20
> diff --git a/drivers/infiniband/hw/ocrdma/Makefile b/drivers/infiniband/h=
w/ocrdma/Makefile
> index d1bfd4f..e3f20ca 100644
> --- a/drivers/infiniband/hw/ocrdma/Makefile
> +++ b/drivers/infiniband/hw/ocrdma/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y :=3D -Idrivers/net/ethernet/emulex/benet
> +ccflags-y :=3D -I $(srctree)/drivers/net/ethernet/emulex/benet
>=20
> obj-$(CONFIG_INFINIBAND_OCRDMA)	+=3D ocrdma.o
>=20
> diff --git a/drivers/infiniband/hw/usnic/Makefile b/drivers/infiniband/hw=
/usnic/Makefile
> index 94ae7a1..f12a493 100644
> --- a/drivers/infiniband/hw/usnic/Makefile
> +++ b/drivers/infiniband/hw/usnic/Makefile
> @@ -1,5 +1,5 @@
> # SPDX-License-Identifier: GPL-2.0
> -ccflags-y :=3D -Idrivers/net/ethernet/cisco/enic
> +ccflags-y :=3D -I $(srctree)/drivers/net/ethernet/cisco/enic
>=20
> obj-$(CONFIG_INFINIBAND_USNIC)+=3D usnic_verbs.o
>=20
> --=20
> 2.7.4
>=20

