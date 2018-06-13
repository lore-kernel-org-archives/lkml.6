Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7BC18C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCAB20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="klgu57cX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCAB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754485AbeFMGPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:15:00 -0400
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:54112
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754466AbeFMGO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7isGW9jtXSB5voD5DeVjO7wQn5iMsYzijHMYXP03VnU=;
 b=klgu57cXq9YzJEo7hH60IlWDM6g0QEvzsP+O8WVP0DcVQkvX1dP1IzD9M562/sHQm97SVFxxWTkT2kS8xpES9epnzF1eHwAIY/oG8748J36MO2LuJ5UCnZoBrsM1WIgDwrNtKHvnUKzcSvOVRDQCF5n6yl0n8mhChkQFQzAhK48=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2936.eurprd04.prod.outlook.com (10.172.248.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Wed, 13 Jun 2018 06:14:54 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97%2]) with mapi id 15.20.0863.010; Wed, 13 Jun 2018
 06:14:54 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        David Wolfe <david.wolfe@nxp.com>, Han Xu <han.xu@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NeilBrown <neil@brown.name>
Subject: RE: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Thread-Topic: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes
Thread-Index: AQHUAWVb+ohDf/w1YUGGWHTuyV6KraRa0CAAgALoBpA=
Date:   Wed, 13 Jun 2018 06:14:54 +0000
Message-ID: <DB6PR0402MB28382277E48A9243B5C38FAF997E0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1528708694-19407-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180611114916.351ed272@bbrezillon>
In-Reply-To: <20180611114916.351ed272@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2936;7:nXB+wvXjcBHZ8cvOFAN6jKf/u655fvmjhmeL+tZH67g8HJOpVwP6Vs3GIrpji6loftlAQsPb0nLjD3jtRTkPMXFhNBv+4psDyntEH8iTM1TYmDaHWDz11nDeYq9ToVEWymnt9ouVgUxMgOs0o9ReDOCImaY+vrRbsjbJ4QIbhsP5qjtIrtmz7VjbIB3ud+NuR94LuiOk2gWK+s5KzO+WOJC5uuS64a9ZLJzYsgKrBNX6TXOZJd6zIrw7RD9RXd5U
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97d562ad-dd97-4179-2e93-08d5d0f4faf9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2936;
x-ms-traffictypediagnostic: DB6PR0402MB2936:
x-microsoft-antispam-prvs: <DB6PR0402MB2936064BBCCAF1C23BA86531997E0@DB6PR0402MB2936.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335)(58145275503218);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2936;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2936;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(346002)(366004)(396003)(13464003)(199004)(189003)(105586002)(8936002)(186003)(2900100001)(26005)(7736002)(99286004)(66066001)(478600001)(305945005)(14454004)(102836004)(966005)(6116002)(106356001)(3846002)(68736007)(81166006)(59450400001)(74316002)(53546011)(81156014)(8676002)(6506007)(316002)(54906003)(55236004)(33656002)(7696005)(76176011)(55016002)(6306002)(486006)(53936002)(476003)(6246003)(5250100002)(3280700002)(3660700001)(39060400002)(229853002)(97736004)(6916009)(5660300001)(6436002)(446003)(11346002)(25786009)(86362001)(4326008)(2906002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2936;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CAfzq68x95cHvQqylTOBLotuw+j36VNuYU8UhTS3yGVAL1rWLVkwjmIuALBumIFzkihCKoNSzo5hbKgDHJJZBXm/sk6zosuJ+eCuVP6t4GcBHQ5FmyKOCYBvCz7CpbF88xhH6xnk2Yqg8PpCV+qu3nCylJRk7wvQcH9fBfsXIDmW9TPqFSetXkU3RpEpdkF/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d562ad-dd97-4179-2e93-08d5d0f4faf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 06:14:54.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Monday, June 11, 2018 3:19 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: linux-mtd@lists.infradead.org; boris.brezillon@free-electrons.com; frie=
der.schrempf@exceet.de; computersforpeace@gmail.com; David Wolfe <david.wol=
fe@nxp.com>; Han Xu <han.xu@nxp.com>; festevam@gmail.com; marek.vasut@gmail=
.com; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; linux-spi@vger.kerne=
l.org; linux-kernel@vger.kernel.org; NeilBrown <neil@brown.name>
Subject: Re: [PATCH] mtd: spi-nor: honour max_data_size for spi-nor writes

Hi Yogesh,

Unrelated note: no need to send your patches to both boris.brezillo@free-el=
ectrons.com and boris.brezillo@bootlin.com, just use the latter.

Ok, Sure.

On Mon, 11 Jun 2018 14:48:14 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Honour max_data_size for spi-nor writes

^ This is no longer relevant.

> In new spi-mem framework, data size to be written is being calculated=20
> using spi_mem_adjust_op_size().
> This can return value less than nor->page_size.
>=20
> Add check value of data size return from API spi_mem_adjust_op_size()=20
> with the actual requested data size and write, max, only supported=20
> data size.

This part is not clear.

Also, I'd prefer to have this patch split in 2:
1/ one patch removing the check in spi_nor_write() 2/ and the second patch =
removing the while() loop in m25p80_write()

How about the following commit messages for those 2 patches:

1:
"
mtd: spi-nor: Support controllers with limited TX FIFO size

Some SPI controllers can't write nor->page_size bytes in a single step beca=
use their TX FIFO is too small.

Allow nor->write() to return a size that is smaller than the requested writ=
e size to gracefully handle this case.
"

2:
"
mtd: devices: m25p80: Make sure WRITE_EN is issued before each write

Some SPI controllers can't write nor->page_size bytes in a single step beca=
use their TX FIFO is too small, but when that happens we should make sure a=
 WRITE_EN command is issued before each write access.

The core is already taking care of that, so all we have to do here is retur=
n the actual number of bytes that were written during the
spi_mem_exec_op() operation.
"

Both patches send [1][2]

--
Regards
Yogesh Gaur.

>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  drivers/mtd/devices/m25p80.c  | 23 ++++++++--------------- =20
> drivers/mtd/spi-nor/spi-nor.c |  7 -------
>  2 files changed, 8 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/mtd/devices/m25p80.c=20
> b/drivers/mtd/devices/m25p80.c index e84563d..60224fe 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -72,7 +72,6 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t=
 to, size_t len,
>  				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
>  				   SPI_MEM_OP_DUMMY(0, 1),
>  				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
> -	size_t remaining =3D len;
>  	int ret;
> =20
>  	/* get transfer protocols. */
> @@ -84,22 +83,16 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff=
_t to, size_t len,
>  	if (nor->program_opcode =3D=3D SPINOR_OP_AAI_WP && nor->sst_write_secon=
d)
>  		op.addr.nbytes =3D 0;
> =20
> -	while (remaining) {
> -		op.data.nbytes =3D remaining < UINT_MAX ? remaining : UINT_MAX;
> -		ret =3D spi_mem_adjust_op_size(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D spi_mem_exec_op(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> +	ret =3D spi_mem_adjust_op_size(flash->spimem, &op);
> +	if (ret)
> +		return ret;
> +	op.data.nbytes =3D len < op.data.nbytes ? len : op.data.nbytes;
> =20
> -		op.addr.val +=3D op.data.nbytes;
> -		remaining -=3D op.data.nbytes;
> -		op.data.buf.out +=3D op.data.nbytes;
> -	}
> +	ret =3D spi_mem_exec_op(flash->spimem, &op);
> +	if (ret)
> +		return ret;
> =20
> -	return len;
> +	return op.data.nbytes;
>  }
> =20
>  /*
> diff --git a/drivers/mtd/spi-nor/spi-nor.c=20
> b/drivers/mtd/spi-nor/spi-nor.c index 5bfa36e..3e63543 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, lof=
f_t to, size_t len,
>  			goto write_err;
>  		*retlen +=3D written;
>  		i +=3D written;
> -		if (written !=3D page_remain) {
> -			dev_err(nor->dev,
> -				"While writing %zu bytes written %zd bytes\n",
> -				page_remain, written);
> -			ret =3D -EIO;
> -			goto write_err;
> -		}
>  	}
> =20
>  write_err:

[1] https://patchwork.ozlabs.org/patch/928677/
[2] https://patchwork.ozlabs.org/patch/928678/

