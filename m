Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46155C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E037020874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SimeQTK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E037020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754027AbeFTMgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:36:13 -0400
Received: from mail-sn1nam01on0060.outbound.protection.outlook.com ([104.47.32.60]:6752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753880AbeFTMgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8lCOmxiz1Qnt5FFHpJoXlH1+4OUMEzUOj2mBCzshIA=;
 b=SimeQTK5UjGFp9CwO24/oqbwFl3BCp6NiYw9U1BFOacc/8Eut6Q0975pCjxd64RaxoMDNRaFofubAx+zmWXnroIYhBujX16IDGouw0dTW3V4xDbayrdpKm8q3m29TGmh5YP4aC8VmtLZ+gyDd9GOdR0AgqS1iwsNVJ75S/gAKds=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 12:36:09 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa%2]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 12:36:08 +0000
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
Subject: RE: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is not
 invoked for each DMA operation
Thread-Topic: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is
 not invoked for each DMA operation
Thread-Index: AQHUCHIQrPud7LE+Xk2xdT54xDVLUqRpD8yQ
Date:   Wed, 20 Jun 2018 12:36:07 +0000
Message-ID: <DM6PR02MB43615ED0221189B6B8D9017EC7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <20180620083653.17010-2-andrea.merello@gmail.com>
In-Reply-To: <20180620083653.17010-2-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4361;7:X3PoiQn4vLor0siu2GZwjFEnSv79IlZcKT5A4HQ/W25muCWPjI0rRu45VN46Mx6tJcX2R4ocVSWLfRbvC44Op2OTiQy1HmQt9u4RDozYrlR3QKTOQLrA3oZar80tuPuR+106O4DfMhvCb4Sf5Bxyl/NJOll1KsRsx4ERSnDUU1q4bjXrLZH6bjknXWNjMQsRQNt8BtHkvr9mGbUHB70VKMRtEEuWDEQMeFWLJRxabOAf3DlypIn/M7eVIu8PWVbk
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(376002)(346002)(396003)(13464003)(189003)(199004)(5660300001)(26005)(2900100001)(53936002)(446003)(25786009)(74316002)(305945005)(33656002)(110136005)(486006)(7736002)(81156014)(8676002)(81166006)(105586002)(476003)(8936002)(106356001)(11346002)(54906003)(39060400002)(6246003)(186003)(4326008)(97736004)(316002)(3660700001)(76176011)(3280700002)(68736007)(102836004)(2906002)(59450400001)(66066001)(55236004)(14454004)(6436002)(7696005)(229853002)(99286004)(6306002)(55016002)(478600001)(9686003)(2201001)(2501003)(6116002)(5250100002)(966005)(53546011)(86362001)(6506007)(3846002)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4361;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 5b6bf4bc-3d57-43fe-70cc-08d5d6aa659b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4361;
x-ms-traffictypediagnostic: DM6PR02MB4361:
x-microsoft-antispam-prvs: <DM6PR02MB4361DB4950A2BB4054F49DD4C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4361;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4361;
x-forefront-prvs: 070912876F
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zpGsCkxh8C7BAJtGnnd5vboEg1ai4047JsP6pssI+BWbP5AbmcvdqCp46vPGWV73zKZEn3tRfBKusSgUjebiblzt/sH9JJMk+gvb6K3nUlYxW9xPJvli2GWMh/SDVcd/1o8n2Urwt6uAWnkpKXL35yom/TPHKy+PKDMJDvv3RDonbVNRupk3Ihi1xMcVLI5bpnDKKXwUWAJRkYPdRGgB9Wfub5meX7irAF2afyAaVsQghHwu1Mio03W6xFko9lhYogWVGy6d4hclMEcyZyCTCSYPqlbtpNXTtSAZONMzMPjPg3NDU+7LVSmNxZ298Z0Oh1sY21HV+D3CgBV/Vn623w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6bf4bc-3d57-43fe-70cc-08d5d6aa659b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 12:36:07.9482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: dmaengine-owner@vger.kernel.org [mailto:dmaengine-
> owner@vger.kernel.org] On Behalf Of Andrea Merello
> Sent: Wednesday, June 20, 2018 2:07 PM
> To: vkoul@kernel.org; dan.j.williams@intel.com; Michal Simek
> <michals@xilinx.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; dmaengine@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> Andrea Merello <andrea.merello@gmail.com>
> Subject: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is no=
t
> invoked for each DMA operation
>=20
> API specification says: "On completion of each DMA operation, the next in
> queue is started and a tasklet triggered. The tasklet will then call the
> client driver completion callback routine for notification, if set."
>=20
> Currently the driver keeps a "desc_pendingcount" counter of the total
> descriptor pending, and it uses as IRQ coalesce threshold, as result it
> only calls the CBs after ALL pending operations are completed, which is
> wrong.
I think IRQ coalescing enable/disable should be configurable.=20
Performance related usecases will need this support.

>=20
> This patch uses disable IRQ coalesce and checks for the completion flag
> for the descriptors (which is further divided in segments).
>=20
> Possibly a better optimization could be using proper IRQ coalesce
> threshold to get an IRQ after all segments of the descriptors are done.
> But we don't do that yet..
>=20
> NOTE: for now we do this only for AXI DMA, other DMA flavors are
> untested/untouched.
> This is loosely based on
> commit 65df81a6dc74 ("xilinx_dma: IrqThreshold set incorrectly, unreliabl=
e.")
> in my linux-4.6-zynq tree
NOTE description doesn't help much. =20

>=20
> From: Jeremy Trimble [original patch]
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 39 +++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index a516e7ffef21..cf12f7147f07 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -164,6 +164,7 @@
>  #define XILINX_DMA_CR_COALESCE_SHIFT	16
>  #define XILINX_DMA_BD_SOP		BIT(27)
>  #define XILINX_DMA_BD_EOP		BIT(26)
> +#define XILINX_DMA_BD_CMPLT		BIT(31)
>  #define XILINX_DMA_COALESCE_MAX		255
>  #define XILINX_DMA_NUM_DESCS		255
>  #define XILINX_DMA_NUM_APP_WORDS	5
> @@ -1274,12 +1275,9 @@ static void xilinx_dma_start_transfer(struct
> xilinx_dma_chan *chan)
>=20
>  	reg =3D dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
>=20
> -	if (chan->desc_pendingcount <=3D XILINX_DMA_COALESCE_MAX) {
> -		reg &=3D ~XILINX_DMA_CR_COALESCE_MAX;
> -		reg |=3D chan->desc_pendingcount <<
> -				  XILINX_DMA_CR_COALESCE_SHIFT;
> -		dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
> -	}
> +	reg &=3D ~XILINX_DMA_CR_COALESCE_MAX;
> +	reg |=3D 1 << XILINX_DMA_CR_COALESCE_SHIFT;
> +	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>=20
>  	if (chan->has_sg && !chan->xdev->mcdma)
>  		xilinx_write(chan, XILINX_DMA_REG_CURDESC,
> @@ -1378,6 +1376,20 @@ static void xilinx_dma_complete_descriptor(struct
> xilinx_dma_chan *chan)
>  		return;
>=20
>  	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
> +		if (chan->xdev->dma_config->dmatype =3D=3D
> XDMA_TYPE_AXIDMA) {
> +			/*
> +			 * Check whether the last segment in this descriptor
> +			 * has been completed.
> +			 */
> +			const struct xilinx_axidma_tx_segment *const tail_seg
> =3D
> +				list_last_entry(&desc->segments,
> +						struct
> xilinx_axidma_tx_segment,
> +						node);
> +
> +			/* we've processed all the completed descriptors */
> +			if (!(tail_seg->hw.status & XILINX_DMA_BD_CMPLT))
> +				break;
> +		}
>  		list_del(&desc->node);
>  		if (!desc->cyclic)
>  			dma_cookie_complete(&desc->async_tx);
> @@ -1826,14 +1838,13 @@ static struct dma_async_tx_descriptor
> *xilinx_dma_prep_slave_sg(
>  				   struct xilinx_axidma_tx_segment, node);
>  	desc->async_tx.phys =3D segment->phys;
>=20
> -	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
> -	if (chan->direction =3D=3D DMA_MEM_TO_DEV) {
> -		segment->hw.control |=3D XILINX_DMA_BD_SOP;
> -		segment =3D list_last_entry(&desc->segments,
> -					  struct xilinx_axidma_tx_segment,
> -					  node);
> -		segment->hw.control |=3D XILINX_DMA_BD_EOP;
> -	}
> +	/* For the first transfer, set SOP */
> +	segment->hw.control |=3D XILINX_DMA_BD_SOP;
> +	/* For the last transfer, set EOP */
> +	segment =3D list_last_entry(&desc->segments,
> +				  struct xilinx_axidma_tx_segment,
> +				  node);
> +	segment->hw.control |=3D XILINX_DMA_BD_EOP;
>=20
>  	return &desc->async_tx;
>=20
> --
> 2.17.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
