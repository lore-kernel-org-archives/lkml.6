Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E744FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA3E208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r4MuYObY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA3E208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbeGKFgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:36:54 -0400
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:20896
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbeGKFgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJDkInYJ+fiIM7W030jC7CdTTSoEPjXaA3jOKyfBJqg=;
 b=r4MuYObY7ceXieLjLAbhOqh7Si5UNXwNvCXWbi3BM+ITqVS68JURxFKnqa4KA02C2YERLPit8l9rFxkaN6tNlzXR2of5Lo5oKDe9UazmB0QGTPl3m+kIxnNU8Eqp3jsTPx7clUFD4YlpfQOjDA/cmq6jJnFZTzTKptKFoBVO+JA=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB2967.eurprd04.prod.outlook.com (10.170.213.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Wed, 11 Jul 2018 05:34:19 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0930.022; Wed, 11 Jul 2018
 05:34:19 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Vinod <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Thread-Topic: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Thread-Index: AQHUGCdnmbVt1awXk0GOfzs3jCNhZKSIlTIAgAClFCA=
Date:   Wed, 11 Jul 2018 05:34:19 +0000
Message-ID: <DB6PR04MB32234F1EE6F457E0D8D12385895A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
 <20180710152912.GE3219@vkoul-mobl>
In-Reply-To: <20180710152912.GE3219@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB2967;7:oQiai6wWRZSBkqTRTdRzNcG5j2fCaY2SU1L/uq88SsZaDiT9huWi/uxNlR6SCviAReoy5d+D6Wg5iIgu5z5dkjIgADRBMUfE+1V8uadvxQbi3DLHS/af8sXVEaSwpVSDLVt2rZRNQnxM34/IJ4h+wLxn8ThTmyVt1honA+hpkcpcgs5aY71Fid6Q31W9J+DHCt6wgzJL8VkoOPAAbhlSHsJMbRpq+Fmi3YgWUXkWCT3qsQSXrlCqKepAPvoWCLlv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d5f19716-81fb-4d72-0fba-08d5e6eff332
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB2967;
x-ms-traffictypediagnostic: DB6PR04MB2967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-microsoft-antispam-prvs: <DB6PR04MB29676593E012588BEAF74D9B895A0@DB6PR04MB2967.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB2967;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB2967;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(6246003)(4326008)(55016002)(53546011)(9686003)(6506007)(33656002)(86362001)(99286004)(229853002)(5250100002)(53936002)(2906002)(25786009)(105586002)(106356001)(2900100001)(6436002)(3846002)(6116002)(486006)(14444005)(476003)(11346002)(68736007)(8936002)(81156014)(81166006)(446003)(8676002)(6916009)(256004)(5660300001)(26005)(186003)(76176011)(14454004)(66066001)(102836004)(97736004)(7696005)(7736002)(74316002)(478600001)(316002)(54906003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB2967;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q1BY/KbOXWKT4zuRD8WFdem2ezBebUQhy13ftkG4LQ0N87YCN4VLTlr7dV2tjGXcU/LUr0T4EVxrnEPgzK5zCl0D1r/bMQkBUoC8PrGAkRCbNgbJq3IWQT6JRbsCLGxk1tP+w6eyk4SLSayh0qBWuElMu/BbVzUksquN6USwrpLDeGxrkwMKOiNVv+E58XQfCm5ZFAh7ii3yMOOmRTdRjSzgtYDJbm3lHXOfaVDDkd6z8ZtIp0gxro1h3P743/oGBLDqBTOmoXwMUN865yBj4jd8kUT6JgjGiBY6J5HAm0dUtOmmda8IbYsY+QiItpwErwxMo9v021mBkSJh9c7fj1VGG0TffjuRmIirPd+GzN8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f19716-81fb-4d72-0fba-08d5e6eff332
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 05:34:19.3909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Robin,
>=20
> On 11-07-18, 00:23, Robin Gong wrote:
> > Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead of
> > '0xffff'.
>=20
> latter part should be its own patch. Never mix things
Okay, I will split it even for this minor change.
>=20
> > +static struct dma_async_tx_descriptor *sdma_prep_memcpy(
> > +		struct dma_chan *chan, dma_addr_t dma_dst,
> > +		dma_addr_t dma_src, size_t len, unsigned long flags) {
> > +	struct sdma_channel *sdmac =3D to_sdma_chan(chan);
> > +	struct sdma_engine *sdma =3D sdmac->sdma;
> > +	int channel =3D sdmac->channel;
> > +	size_t count;
> > +	int i =3D 0, param;
> > +	struct sdma_buffer_descriptor *bd;
> > +	struct sdma_desc *desc;
> > +
> > +	if (!chan || !len)
> > +		return NULL;
> > +
> > +	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=3D%zu, channel=3D%d.\n",
> > +		&dma_src, &dma_dst, len, channel);
> > +
> > +	desc =3D sdma_transfer_init(sdmac, DMA_MEM_TO_MEM, len /
> SDMA_BD_MAX_CNT
> > +					+ 1);
>=20
> this looks quite odd to read consider:
>=20
>         esc =3D sdma_transfer_init(sdmac, DMA_MEM_TO_MEM,
>                                  len / SDMA_BD_MAX_CNT + 1);
>=20
Okay, will fix on v2.
> > +	if (!desc)
> > +		goto err_out;
> > +
> > +	do {
> > +		count =3D min_t(size_t, len, SDMA_BD_MAX_CNT);
> > +		bd =3D &desc->bd[i];
> > +		bd->buffer_addr =3D dma_src;
> > +		bd->ext_buffer_addr =3D dma_dst;
> > +		bd->mode.count =3D count;
> > +		desc->chn_count +=3D count;
> > +
> > +		switch (sdmac->word_size) {
> > +		case DMA_SLAVE_BUSWIDTH_4_BYTES:
>=20
> This looks wrong, we are in memcpy, there is no SLAVE so no SLAVE widths.=
.
>=20
Okay, will remove check bus width.
> >  static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
> >  		struct dma_chan *chan, struct scatterlist *sgl,
> >  		unsigned int sg_len, enum dma_transfer_direction direction, @@
> > -1344,9 +1431,9 @@ static struct dma_async_tx_descriptor
> > *sdma_prep_slave_sg(
> >
> >  		count =3D sg_dma_len(sg);
> >
> > -		if (count > 0xffff) {
> > +		if (count > SDMA_BD_MAX_CNT) {
> >  			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg
> entry exceeded: %d > %d\n",
> > -					channel, count, 0xffff);
> > +					channel, count, SDMA_BD_MAX_CNT);
>=20
> these changes dont belong to this patch
Will split in v2.
>=20
> > @@ -1486,6 +1573,8 @@ static int sdma_config(struct dma_chan *chan,
> >  		sdmac->watermark_level |=3D (dmaengine_cfg->dst_maxburst << 16)
> &
> >  			SDMA_WATERMARK_LEVEL_HWML;
> >  		sdmac->word_size =3D dmaengine_cfg->dst_addr_width;
> > +	} else if (dmaengine_cfg->direction =3D=3D DMA_MEM_TO_MEM) {
> > +		sdmac->word_size =3D dmaengine_cfg->dst_addr_width;
>=20
> same here too, we are in .device_config which deals with slave. Not memcp=
y!
Will remove it.
>=20
> >  	} else {
> >  		sdmac->per_address =3D dmaengine_cfg->dst_addr;
> >  		sdmac->watermark_level =3D dmaengine_cfg->dst_maxburst * @@
> -1902,6
> > +1991,7 @@ static int sdma_probe(struct platform_device *pdev)
> >
> >  	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
> >  	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
> > +	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
> >
> >  	INIT_LIST_HEAD(&sdma->dma_device.channels);
> >  	/* Initialize channel parameters */
> > @@ -1968,9 +2058,11 @@ static int sdma_probe(struct platform_device
> *pdev)
> >  	sdma->dma_device.dst_addr_widths =3D SDMA_DMA_BUSWIDTHS;
> >  	sdma->dma_device.directions =3D SDMA_DMA_DIRECTIONS;
> >  	sdma->dma_device.residue_granularity =3D
> > DMA_RESIDUE_GRANULARITY_SEGMENT;
> > +	sdma->dma_device.device_prep_dma_memcpy =3D sdma_prep_memcpy;
> >  	sdma->dma_device.device_issue_pending =3D sdma_issue_pending;
> >  	sdma->dma_device.dev->dma_parms =3D &sdma->dma_parms;
> > -	dma_set_max_seg_size(sdma->dma_device.dev, 65535);
> > +	sdma->dma_device.copy_align =3D DMAENGINE_ALIGN_4_BYTES;
> > +	dma_set_max_seg_size(sdma->dma_device.dev, SDMA_BD_MAX_CNT);
>=20
> this line should not be part of this patch
>=20
> --
> ~Vinod
