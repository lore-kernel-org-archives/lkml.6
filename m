Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FDCC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA2020874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZkDav4D7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA2020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFTOnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:43:43 -0400
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:24192
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753760AbeFTOnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7Y9gsrU/untNKN4nTQxmRTg+1tZfY0BpbTGrVNYLV0=;
 b=ZkDav4D7QRebVfdn5A85DWTupZyCxYE8GPMQrCuvvtf8keXGN66y8shZorOugHe1NRM74GQ8P7HD/XzYKPpSUw363+PS7HXNBe9B6cMI/QJ+A1kLVl0BCF+H2mYKeis6kGcKmcZjv7Z8rGXmC8xSPBtVmytYyKN9tAvFH+fI9/Q=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB4411.namprd02.prod.outlook.com (20.176.105.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 14:43:38 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa%2]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 14:43:37 +0000
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
Subject: RE: [PATCH 5/6] dmaengine: xilinx_dma: autodetect whether the HW
 supports scatter-gather
Thread-Topic: [PATCH 5/6] dmaengine: xilinx_dma: autodetect whether the HW
 supports scatter-gather
Thread-Index: AQHUCHKNMH0By/raCk+umS6VIopExqRpN51w
Date:   Wed, 20 Jun 2018 14:43:36 +0000
Message-ID: <DM6PR02MB436181CD5544B0FA95318077C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <20180620083653.17010-5-andrea.merello@gmail.com>
In-Reply-To: <20180620083653.17010-5-andrea.merello@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4411;7:MTEbSNOV0znXKa+a7AbvuEebxhprxuCaOk3y8LSMK4LKFlYkgViAp91/FRorJkbOylCc+81+97hWY7wIPM4l6I4yFoFRcFrEEwy+sPr4eV6I1r3S2N72CHRl6qFkGTz+kv1BdZB6Lbl7jI29D8DpxTpZpvXIxYST3gf1pg7lWxL+Hh2kwHpjiJDakKubTI7qBxdUmBB89oZNZlKVYixhY7iHpek8Wupd7AncSLnZdaGGASNEQc3F6nfB0xwfQf6G
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39380400002)(39860400002)(13464003)(189003)(199004)(229853002)(5660300001)(3660700001)(316002)(2501003)(5250100002)(105586002)(106356001)(2906002)(25786009)(76176011)(186003)(110136005)(4326008)(3280700002)(68736007)(2201001)(54906003)(305945005)(39060400002)(66066001)(26005)(6436002)(7736002)(966005)(8676002)(446003)(11346002)(486006)(476003)(81156014)(53546011)(86362001)(33656002)(74316002)(14454004)(102836004)(6506007)(8936002)(97736004)(59450400001)(81166006)(478600001)(55016002)(7696005)(2900100001)(9686003)(6246003)(6306002)(3846002)(99286004)(55236004)(53936002)(6116002)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4411;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 4fe8abc9-f49e-4a3b-4e38-08d5d6bc34ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4411;
x-ms-traffictypediagnostic: DM6PR02MB4411:
x-microsoft-antispam-prvs: <DM6PR02MB441174C2BCAC79E8AC7A5C79C7770@DM6PR02MB4411.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4411;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4411;
x-forefront-prvs: 070912876F
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0WeJxpdSwmhCgIWlSfm+gtyuF1m5PGgKtBOWQb0vpveDHcYgUoTiqw/ILsicf0hpsKjhLDi9ecPxZvartUS8To+OzUvUfoWepgLpOk14qZRuzbHdROcskMkgCtRyfyxw1BnbNMY+yVccwduE2oxKMz23mhjpn83k4qJNeXzCjOdMOzOmJsbNpazduPAE6nrHETiVjS2SxmfXTUWPVV9drz3outUq40WVJyQhP2ZcvL/Libde9B5gLmFb+weERBNuwUZfPLStNgzyBU82DBIkrMFTj0z6464tqEStcletzSsBAYgdDEPoc8sGDL+O03qxwRi6byysi6yFC7Jx7DAj4g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe8abc9-f49e-4a3b-4e38-08d5d6bc34ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 14:43:36.9099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4411
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
> Subject: [PATCH 5/6] dmaengine: xilinx_dma: autodetect whether the HW
> supports scatter-gather
>=20
> The HW can be either direct-access or scatter-gather version. These are
> SW incompatible.
>=20
> The driver can handle both version: a DT property was used to
> tell the driver whether to assume the HW is is scatter-gather mode.
>=20
> This patch makes the driver to autodetect this information. The DT
> property is not required anymore.
>=20
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_=
dma.c
> index bdbc8ba9092a..8c6e818e596f 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -86,6 +86,7 @@
>  #define XILINX_DMA_DMASR_DMA_DEC_ERR		BIT(6)
>  #define XILINX_DMA_DMASR_DMA_SLAVE_ERR		BIT(5)
>  #define XILINX_DMA_DMASR_DMA_INT_ERR		BIT(4)
> +#define XILINX_DMA_DMASR_SG_MASK		BIT(3)
>  #define XILINX_DMA_DMASR_IDLE			BIT(1)
>  #define XILINX_DMA_DMASR_HALTED		BIT(0)
>  #define XILINX_DMA_DMASR_DELAY_MASK		GENMASK(31, 24)
> @@ -407,7 +408,6 @@ struct xilinx_dma_config {
>   * @dev: Device Structure
>   * @common: DMA device structure
>   * @chan: Driver specific DMA channel
> - * @has_sg: Specifies whether Scatter-Gather is present or not
>   * @mcdma: Specifies whether Multi-Channel is present or not
>   * @flush_on_fsync: Flush on frame sync
>   * @ext_addr: Indicates 64 bit addressing is supported by dma device
> @@ -426,7 +426,6 @@ struct xilinx_dma_device {
>  	struct device *dev;
>  	struct dma_device common;
>  	struct xilinx_dma_chan
> *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
> -	bool has_sg;
>  	bool mcdma;
>  	u32 flush_on_fsync;
>  	bool ext_addr;
> @@ -2391,7 +2390,6 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev,
>=20
>  	chan->dev =3D xdev->dev;
>  	chan->xdev =3D xdev;
> -	chan->has_sg =3D xdev->has_sg;
>  	chan->desc_pendingcount =3D 0x0;
>  	chan->ext_addr =3D xdev->ext_addr;
>  	/* This variable ensures that descriptors are not
> @@ -2488,6 +2486,13 @@ static int xilinx_dma_chan_probe(struct
> xilinx_dma_device *xdev,
>  		chan->stop_transfer =3D xilinx_dma_stop_transfer;
>  	}
>=20
> +	/* check if SG is enabled */
> +	if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
> +		XILINX_DMA_DMASR_SG_MASK)
I think SGIncld mask is only applicable for AXI DMA and CDMA IP.
For VDMA IP this bit is reserved.=20
.
> +		chan->has_sg =3D true;
> +	dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
> +		chan->has_sg ? "enabled" : "disabled");
> +
>  	/* Initialize the tasklet */
>  	tasklet_init(&chan->tasklet, xilinx_dma_do_tasklet,
>  			(unsigned long)chan);
> @@ -2626,7 +2631,6 @@ static int xilinx_dma_probe(struct platform_device
> *pdev)
>  		return PTR_ERR(xdev->regs);
>=20
>  	/* Retrieve the DMA engine properties from the device tree */
> -
Unrelated change

>  	if (xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
>  		xdev->mcdma =3D of_property_read_bool(node, "xlnx,mcdma");
>  		err =3D of_property_read_u32(node, "xlnx,lengthregwidth",
> --
> 2.17.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
