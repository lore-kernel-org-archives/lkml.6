Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4771AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4AC20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="odngJEHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4AC20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbeFTLhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:37:35 -0400
Received: from mail-eopbgr690045.outbound.protection.outlook.com ([40.107.69.45]:32640
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751841AbeFTLhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oApZY4R00fDX4j5yZqp3vLT+vlx08qumetWNRBMF/go=;
 b=odngJEHRQwwKpuv16wI6TL0FHBZeZISxbN1ysA/vkPd6em/5e8M3IH02b8xyhrQ1jZHnojBcYS0gT/cS8yPBAhxQwfgYVX4o6zTQ2G/mRvBCit/c3IsngJ/PWDcpelYAfVN2/1IVt8T47S/mwitMyId//948jEIJa4U3o02kt3w=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB5131.namprd02.prod.outlook.com (20.176.114.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 20 Jun 2018 11:37:28 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa%2]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 11:37:27 +0000
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
Subject: RE: [PATCH 1/6] dmaengine: xilinx_dma: fix splitting transfer causes
 misalignments
Thread-Topic: [PATCH 1/6] dmaengine: xilinx_dma: fix splitting transfer causes
 misalignments
Thread-Index: AQHUCHX23SyVRK+QPEaCA274go6uOqRo+8cA
Date:   Wed, 20 Jun 2018 11:37:27 +0000
Message-ID: <DM6PR02MB4361458180616B591C6742E2C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
In-Reply-To: <20180620083653.17010-1-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB5131;7:Xjs99qmbm74GJBGBCq9xKlo6VlCIXO2byZ+aK9LCMPOq3n1DocvVFNpH1x/LAJymyjjWSHJBNam+1uTRBMx8wIjjRdCCVokErhm2lpNsFEHp1AELCAyePZDXcA8zN7ME/sJRPvIvfsj2GkRqKcd4SAyM9G5hACXxFR+yv4mEsk01oErPU0V+0MMSbxNjkfOi+xI785WX0smpn7sUaRSFBWqSqDP8PpcIEGg9o9YtvBQvar14YwCZ8N6zE8AezQLS
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(376002)(346002)(366004)(189003)(199004)(13464003)(99286004)(53936002)(229853002)(11346002)(6246003)(2201001)(316002)(66066001)(476003)(106356001)(305945005)(7736002)(446003)(74316002)(68736007)(105586002)(3280700002)(76176011)(186003)(26005)(2900100001)(4326008)(39060400002)(2501003)(25786009)(54906003)(486006)(110136005)(86362001)(8676002)(81156014)(8936002)(81166006)(7696005)(3660700001)(478600001)(5250100002)(2906002)(6306002)(6436002)(6506007)(33656002)(551934003)(5660300001)(53546011)(102836004)(59450400001)(55016002)(3846002)(97736004)(55236004)(14454004)(6116002)(9686003)(966005)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5131;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13c49055-a882-40cb-cf8b-08d5d6a2336b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB5131;
x-ms-traffictypediagnostic: DM6PR02MB5131:
x-microsoft-antispam-prvs: <DM6PR02MB51313FA592B940FB0021CEF6C7770@DM6PR02MB5131.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB5131;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5131;
x-forefront-prvs: 070912876F
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tK2FfUxEkH2MfjlvVPWjHtTk7aI75YJ9lhicJNl3otUDTnmjupX0yZ81xvZ18UT0MROjlpA2xNc4a2lZxjlLI75NDDK8lewz+vxdML/6lUG8Eq4Ioeb7X/5BUvtMzlwChn2fwdNQhiWJBjbsHZS1NM0sDMrTKDNDaBVE1DBB714DVi8cbVF6SG12lbG0wcTK70aoFGKeNDZYU5LRbzRqwpI7aMHeV+uX++ahTIBz2ZdeREEpD5FcHD4CVmvbpXimx2rGR0OdaOOLr+nk/wfy5aZDV+nEA8Wwya9laRMWMBcfkHKByHGdaI4OqNOqzFNp/OLYsD9Xw/iQ0vTbdBoOCg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c49055-a882-40cb-cf8b-08d5d6a2336b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 11:37:27.7917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5131
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
> Subject: [PATCH 1/6] dmaengine: xilinx_dma: fix splitting transfer causes
> misalignments

We should rephrase commit message to something like "In axidma
slave_sg and dma_cylic mode align split descriptors"=20

>=20
> Whenever a single or cyclic transaction is prepared, the driver
> could eventually split it over several SG descriptors in order
> to deal with the HW maximum transfer length.
>=20
> This could end up in DMA operations starting from a misaligned
> address. This seems fatal for the HW.
This seems fatal for the HW if DRE is not enabled.

>=20
> This patch eventually adjusts the transfer size in order to make sure
> all operations start from an aligned address.
>=20
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index 27b523530c4a..a516e7ffef21 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -376,6 +376,7 @@ struct xilinx_dma_chan {
>  	void (*start_transfer)(struct xilinx_dma_chan *chan);
>  	int (*stop_transfer)(struct xilinx_dma_chan *chan);
>  	u16 tdest;
> +	u32 copy_mask;
We can reuse copy_align itself.  See below.

>  };
>=20
>  /**
> @@ -1789,10 +1790,14 @@ static struct dma_async_tx_descriptor
> *xilinx_dma_prep_slave_sg(
>=20
>  			/*
>  			 * Calculate the maximum number of bytes to transfer,
> -			 * making sure it is less than the hw limit
> +			 * making sure it is less than the hw limit and that
> +			 * the next chuck start address is aligned

/s/chuck/chunk
>  			 */
> -			copy =3D min_t(size_t, sg_dma_len(sg) - sg_used,
> -				     XILINX_DMA_MAX_TRANS_LEN);
> +			copy =3D sg_dma_len(sg) - sg_used;
> +			if (copy > XILINX_DMA_MAX_TRANS_LEN)
> +				copy =3D XILINX_DMA_MAX_TRANS_LEN &
> +					chan->copy_mask;
> +


In below implementation, we can reuse copy_align.
Same for dma_cyclic.

if ((copy + sg_used  < sg_dma_len(sg)) &&
	chan->xdev->common.copy_align) {
	/* If this is not the last descriptor, make sure
	  * the next one will be properly aligned
	 */
	copy =3D rounddown(copy,
               (1 << chan->xdev->common.copy_align));
     }

>  			hw =3D &segment->hw;
>=20
>  			/* Fill in the descriptor */
> @@ -1894,10 +1899,14 @@ static struct dma_async_tx_descriptor
> *xilinx_dma_prep_dma_cyclic(
>=20
>  			/*
>  			 * Calculate the maximum number of bytes to transfer,
> -			 * making sure it is less than the hw limit
> +			 * making sure it is less than the hw limit and that
> +			 * the next chuck start address is aligned
>  			 */
> -			copy =3D min_t(size_t, period_len - sg_used,
> -				     XILINX_DMA_MAX_TRANS_LEN);
> +			copy =3D period_len - sg_used;
> +			if (copy > XILINX_DMA_MAX_TRANS_LEN)
> +				copy =3D XILINX_DMA_MAX_TRANS_LEN &
> +					chan->copy_mask;
> +
>  			hw =3D &segment->hw;
>  			xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
>  					  period_len * i);
> @@ -2402,8 +2411,12 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev,
>  	if (width > 8)
>  		has_dre =3D false;
>=20
> -	if (!has_dre)
> +	if (has_dre) {
> +		chan->copy_mask =3D ~0;
> +	} else {
>  		xdev->common.copy_align =3D fls(width - 1);
> +		chan->copy_mask =3D ~(width - 1);
> +	}

As mentioned above we don't need this additional field.

>=20
>  	if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
>  	    of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
> --
> 2.17.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
