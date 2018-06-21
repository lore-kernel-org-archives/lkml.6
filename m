Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A4AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2566F20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nKEkQ7T6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2566F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932763AbeFUNQZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:16:25 -0400
Received: from mail-sn1nam01on0078.outbound.protection.outlook.com ([104.47.32.78]:28282
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751159AbeFUNQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JAzP4JV4NZ+C09bO2rBfWimwALPAF3/cVsCDUDmqCo=;
 b=nKEkQ7T6RyYKPmQJIs4MXzRPBmco6vVc0UUY69kv2O773blPbAuoaYL2vyrVhp39Kr2jwMZywZlMV7GPe2G2ASMWizSJjdyXvO6zpWNEQHkcPzOZ0EuV7uqgY4wQWQxlt1WDmOhfSKWKJh2oAwA5BBlf5jag7zBBo0yojo/xlgY=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB4553.namprd02.prod.outlook.com (20.176.107.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Thu, 21 Jun 2018 13:16:15 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa%2]) with mapi id 15.20.0863.021; Thu, 21 Jun 2018
 13:16:14 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Andrea Merello <andrea.merello@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
Thread-Topic: [PATCH v2 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
Thread-Index: AQHUCVcufZhOoEcSaUa8QGfKuxQC1aRqrvPw
Date:   Thu, 21 Jun 2018 13:16:14 +0000
Message-ID: <DM6PR02MB4361C0F0D4002B73B24D2F98C7760@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180621115822.20058-1-andrea.merello@gmail.com>
In-Reply-To: <20180621115822.20058-1-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4553;7:V4uOwsJQOzZXHBPvCN7D8UmFrqXwVnbymWYE6L/XJ+j3VHIXD2MletTB0skug2z+4HyCMUpIHKCSlvwsOqJiCzmBdHKMkvYypJSS8KBoUUtZlTBUqM3wO+DvJ9irCIFPJZ5tYSIhNe3dsmvRFqMNsR/5/8fPGUqa4gRRcVqJRgOxoOcH0IF4KDdPQePQDPcNa+YiRgODinXnlSzD58vFUT8OwOps8uZr/B7v21a+JW79sYVJ/i4SOAhntgNWIWDB
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(13464003)(199004)(189003)(8936002)(53936002)(8676002)(6506007)(966005)(53546011)(446003)(229853002)(55236004)(59450400001)(5660300001)(2201001)(39060400002)(14454004)(66066001)(7736002)(2501003)(86362001)(305945005)(3846002)(25786009)(6116002)(99286004)(54906003)(33656002)(3280700002)(478600001)(2900100001)(106356001)(476003)(6246003)(110136005)(68736007)(74316002)(551934003)(186003)(6306002)(55016002)(486006)(102836004)(105586002)(4326008)(7696005)(76176011)(5250100002)(9686003)(81156014)(81166006)(2906002)(26005)(3660700001)(316002)(97736004)(6436002)(11346002)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4553;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 0d2b913c-d19d-44e4-5997-08d5d7792a34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4553;
x-ms-traffictypediagnostic: DM6PR02MB4553:
x-microsoft-antispam-prvs: <DM6PR02MB4553688370739DF28D3074C9C7760@DM6PR02MB4553.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4553;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4553;
x-forefront-prvs: 07106EF9B9
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9edi/0EZkMVngexxdPcpPGD5FT7xVAJPkRoSqOcQp79mgKWHHyGNtzRflHeNxQA0sRnWMUgxPGiq/qIRIzTXyswRvQWjs4ETKsis/yqtT99AVrygtmxyvjKegfur8ai283/xdRaQQbYt7bSclLpTuV0X9IkBucQg2Pxt0vMAWBTq06S54XWDWmllOgbC0Pzq4CI5irtBJX9lf4bP+bUmUO+LtlRkuSY9Iwt5qypxEwftDzQtfNjg6W4ktTqx80VJHYrxLTAlECXQDzQAN2KXAeVzkKAJbbJXB+sW2KjhwrvDOcTPKjq9lQqMatIxxl0UoYIjY0Eb0PHXIxyl7jZWcA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2b913c-d19d-44e4-5997-08d5d7792a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2018 13:16:14.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: dmaengine-owner@vger.kernel.org [mailto:dmaengine-
> owner@vger.kernel.org] On Behalf Of Andrea Merello
> Sent: Thursday, June 21, 2018 5:28 PM
> To: vkoul@kernel.org; dan.j.williams@intel.com; Michal Simek
> <michals@xilinx.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> Andrea Merello <andrea.merello@gmail.com>
> Subject: [PATCH v2 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
> dma_cyclic mode align split descriptors
>=20
> Whenever a single or cyclic transaction is prepared, the driver
> could eventually split it over several SG descriptors in order
> to deal with the HW maximum transfer length.
>=20
> This could end up in DMA operations starting from a misaligned
> address. This seems fatal for the HW if DRE is not enabled.
>=20
> This patch eventually adjusts the transfer size in order to make sure
> all operations start from an aligned address.
>=20
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
> Changes in v2:
> 	- don't introduce copy_mask field, rather rely on already-esistent
> 	  copy_align field. Suggested by Radhey Shyam Pandey
> 	- reword title
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 27b523530c4a..22d7a6b85e65 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -1789,10 +1789,15 @@ static struct dma_async_tx_descriptor
> *xilinx_dma_prep_slave_sg(
>=20
>  			/*
>  			 * Calculate the maximum number of bytes to transfer,
> -			 * making sure it is less than the hw limit
> +			 * making sure it is less than the hw limit and that
> +			 * the next chunck start address is aligned
/s/chunck/chunk . Same for later occurrence.
>  			 */
> -			copy =3D min_t(size_t, sg_dma_len(sg) - sg_used,
> -				     XILINX_DMA_MAX_TRANS_LEN);
> +			copy =3D sg_dma_len(sg) - sg_used;
> +			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
> +			    chan->xdev->common.copy_align)
> +				copy =3D
> rounddown(XILINX_DMA_MAX_TRANS_LEN,
> +					 (1 << chan->xdev-
> >common.copy_align));
> +
If DRE is not enabled (copy_align=3D0) we are copying entire sg_dma_len=20
which is not correct i.e more than XILINX_DMA_MAX_TRANS_LEN.

>  			hw =3D &segment->hw;
>=20
>  			/* Fill in the descriptor */
> @@ -1894,10 +1899,15 @@ static struct dma_async_tx_descriptor
> *xilinx_dma_prep_dma_cyclic(
>=20
>  			/*
>  			 * Calculate the maximum number of bytes to transfer,
> -			 * making sure it is less than the hw limit
> +			 * making sure it is less than the hw limit and that
> +			 * the next chunck start address is aligned
>  			 */
> -			copy =3D min_t(size_t, period_len - sg_used,
> -				     XILINX_DMA_MAX_TRANS_LEN);
> +			copy =3D period_len - sg_used;
> +			if (copy > XILINX_DMA_MAX_TRANS_LEN &&
> +			    chan->xdev->common.copy_align)
> +				copy =3D
> rounddown(XILINX_DMA_MAX_TRANS_LEN,
> +					 (1 << chan->xdev-
> >common.copy_align));
> +
>  			hw =3D &segment->hw;
>  			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
>  					  period_len * i);
> --
> 2.17.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
