Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8908C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBFA2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fN6GyVV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbfAaQlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:41:10 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4687 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfAaQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:41:09 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5324f90001>; Thu, 31 Jan 2019 08:40:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 08:41:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 31 Jan 2019 08:41:06 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 16:41:06 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 16:41:05 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 31 Jan 2019 16:41:05 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2901.namprd12.prod.outlook.com (20.179.91.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:41:03 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:41:03 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuSyS8D4y2PEYbkigLw9+iOz1C6XJUwmAgAA8ATA=
Date:   Thu, 31 Jan 2019 16:41:03 +0000
Message-ID: <BYAPR12MB3398734126428AC5881D0B28C2910@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
 <20190131124423.GG23438@ulmo>
In-Reply-To: <20190131124423.GG23438@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2901;6:jqRQkW1HmvmhCHmmK7BU1JVQ4iK5YgUMpm4SWKktZqQqiqo5bqKQT5pzi71+LdpIoGAAzgseJ+W/ac9jJIIEffv8wtxLR0fgqnhb4oncp1X4HxZCANHjvhRcbKpSpYMu6OUn3lN0m+WNQkiyCteMTX4REthjCRzUnnRxGNzuD7DhswAVlOQNEaV2vpWR5rB+heK/7d5Q40nUx0CMh9sHfgIka7E6zuOsSBP/v66PwvOc/vrI3wKFFyO3N6mYifvpUOK5bXgNwnSWKDrboVKeFN6z0LRp5UchUrwnfxuIm51yQqPgDH3wiQyFGptX6/rrL6FuJ+0z709IzVquw58bHIuAQdCpWBSPCuhN5leiOJ1DOHqHtO9865+TAe+fjoVnhOCCiM9sEhHphoAtuaGZdhvOla98dcTPPlIMNCzpkBRlxkcIHjOHsg5WcueEZPchxYELALqan5RTKQPQ2GLu9w==;5:TYItYJI2eIYww+Xw7sH2sYcuOoazFFaOapkLBxQsxX1BzvfKOGIEXiOfQASt+sRwiJMV369PIAnjPEEY67Mv91LI19itj4UPW7kHrGAri7hxGhBmPL6MoHBMvHsoUIq4XSR6H6Qfc1YtYz8tc6cinze2FlppRpoQRzvaSXLcdSstOAHfNCQIDV7BGF8Yg/nMr7hq/4cWAkwYwU0O3qZjhw==;7:zGV0LEyQJwSayESK7MhV3691q7SXIJVqx+bg89y/xif06VIdr1KH0cJ1Kvs81Y/fphAo16M2+K+PRqOE1VU+d9LnmMbtDNjGAzw27PKAqKG30a5tKOfKpnEu/d8cAlA7S+nz7TARmU0br30xbTpu7Q==
x-ms-office365-filtering-correlation-id: edcfacf7-ce41-4f4d-3cf8-08d6879ae3ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2901;
x-ms-traffictypediagnostic: BYAPR12MB2901:
x-microsoft-antispam-prvs: <BYAPR12MB29016E6369E48686ABD51D42C2910@BYAPR12MB2901.namprd12.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39860400002)(376002)(189003)(199004)(256004)(2906002)(39060400002)(102836004)(9686003)(14444005)(6506007)(26005)(186003)(68736007)(7696005)(33656002)(55016002)(76176011)(6436002)(25786009)(86362001)(74316002)(6916009)(476003)(486006)(4326008)(229853002)(53936002)(446003)(3846002)(6116002)(6246003)(97736004)(8936002)(105586002)(478600001)(99286004)(7736002)(81156014)(81166006)(8676002)(316002)(54906003)(66066001)(14454004)(305945005)(106356001)(71200400001)(71190400001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2901;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BNhxSjtdBzZMTovKFGEx9gcMyD1C7as6Eqh/CAcv9J08eyhAN4XPMzNJHo1rS0e2d8VFIlGA+myZi8JkMCOGeM8JN2Pm1Cgyxy3bEOf/NEUTKJmc1DrTmxgN/ZeAqeogxzalOpohp1zn7NR7C1ZCt9TwycJE/OHAeXpBHq9zk9CK0AtEujDSz47P4OBn8lYWtYrHIYdlXokWz3qvBSXDWmmGYB/ssOC/vu3GRp15RTH/a44QmcjabOqQPoJgrjF54tZJbkz8A4UB5uj+lbYJGml/XleXn+66ifhHkxOtXA3/RBpLIBbWWCzdbbiuO2MC8nUgT+nRiMwF9x7kXEOdeFMQClTXV7PLKuSz9JJ/9tAMZVlk5WpxvhxdUiIhz47ZugnxCnseapzCUsYmz0/ROyJ7WtvtEd5OpV5eAipu8Ok=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: edcfacf7-ce41-4f4d-3cf8-08d6879ae3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:41:03.1891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2901
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548952825; bh=GK1wOCIOo9sC4N5FUdRhnkrybeH2vaDtQnbsPtaZbBk=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=fN6GyVV07QMVmkapyu8lFtQB9RFIhndIeAoELRZoXNDylsnzFNhczHGX5Zfhd261n
         F9WKzxZhPAWB7c+mpIEzMG7epnCsD4FTe7g/E+3fxP6wo2WY7M9CbSQdcL0bvuK+a7
         Mpavix+LM+TCG0dczmUMPt5QxzKQFTek5j6r3qJ6A/8IXs3hO8gAuvvUI5RsD95mww
         1PkuCHnaKh2LdPzeVYFRw38/w/giLR/ZIf0/kuxkksgYh5abDpqHShf8MOeR7YsNAe
         4sD6AzwJsHSsa9nYDcEmzKtKLSVBQQDAnFZEFftosQUnOKNjtypJO/N3lOQnDxV8Oo
         bfuAlgHbNW/7w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev) {
> > +	struct dma_chan *dma_chan;
> > +	u32 *dma_buf;
> > +	dma_addr_t dma_phys;
> > +
> > +	if (!i2c_dev->has_dma)
> > +		return -EINVAL;
> > +
> > +	if (!i2c_dev->rx_dma_chan) {
> > +		dma_chan =3D dma_request_slave_channel_reason(i2c_dev->dev, "rx");
> > +		if (IS_ERR(dma_chan))
> > +			return PTR_ERR(dma_chan);
>
> I think we want to fallback to PIO here if dma_chan is -ENODEV.

Checking if dmas property is in device tree before channel requests. So ENO=
DEV will not be returned.
Incase if dmas property is not there in device tree, we fall back to PIO as=
 init_dma_params returns invalid

> Although, I'm not exactly sure I understand what you're trying to achieve=
 here. Shouldn't we move the channel request parts into probe and remove th=
em from here? Otherwise it seems like we could get into a state where we ke=
ep trying to get the slave channels everytime we set up a DMA transfer, eve=
n if we already failed to do so during probe.
>

This patch tries to get channel request during probe but buffer allocation =
will not happen till xfer is needed in dma mode.
During xfer message, this function is called again for dma buffer allocatio=
n only for dma mode.

> > +
> > +	if (!i2c_dev->dma_buf && i2c_dev->msg_buf_remaining) {
> > +		dma_buf =3D dma_alloc_coherent(i2c_dev->dev,
> > +					     i2c_dev->dma_buf_size,
> > +					     &dma_phys, GFP_KERNEL);
> > +
> > +		if (!dma_buf) {
> > +			dev_err(i2c_dev->dev,
> > +				"failed to allocate the DMA buffer\n");
> > +			dma_release_channel(i2c_dev->tx_dma_chan);
> > +			dma_release_channel(i2c_dev->rx_dma_chan);
> > +			i2c_dev->tx_dma_chan =3D NULL;
> > +			i2c_dev->rx_dma_chan =3D NULL;
> > +			return -ENOMEM;
> > +		}
> > +
> > +		i2c_dev->dma_buf =3D dma_buf;
> > +		i2c_dev->dma_phys =3D dma_phys;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
>
>
> > @@ -749,19 +939,69 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_de=
v *i2c_dev,
> >  	i2c_dev->msg_read =3D (msg->flags & I2C_M_RD);
> >  	reinit_completion(&i2c_dev->msg_complete);
> > =20
> > +	if (i2c_dev->msg_read)
> > +		xfer_size =3D msg->len;
> > +	else
> > +		xfer_size =3D msg->len + I2C_PACKET_HEADER_SIZE;
> > +
> > +	xfer_size =3D ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> > +	dma =3D (xfer_size > I2C_PIO_MODE_MAX_LEN);
> > +	if (dma) {
> > +		err =3D tegra_i2c_init_dma_param(i2c_dev);
> > +		if (err < 0) {
> > +			dev_dbg(i2c_dev->dev, "switching to PIO transfer\n");
> > +			dma =3D false;
> > +		}
>
>
> If we successfully got DMA channels at probe time, doesn't this turn into=
 an error condition that is worth reporting? It seems to me like the only r=
eason it could fail is if we fail the allocation, but then again, why don't=
 we move the DMA buffer allocation into probe()? We already use a fixed siz=
e for that allocation, so there's no reason it couldn't be allocated at pro=
be time.
>
> Seems like maybe you just overlooked that as you were moving around the c=
ode pieces.

Checking for dmas property is inside init_dma_param and if dmas property do=
esn't exist init_dma_param returns err EINVAL
Also init_dma_param fails for if buffer allocation fails. In both of those =
cases it will switch to PIO Mode
As per review feedback, performing channel request allocation during probe =
and buffer allocation is postponed till there is need for DMA and buffer al=
location happens during 1st DMA mode xfer if it is not already allocated

>
>
>
> >  static const struct i2c_algorithm tegra_i2c_algo =3D { @@ -1002,11=20
> > +1293,13 @@ static int tegra_i2c_probe(struct platform_device *pdev)
> >  	struct clk *div_clk;
> >  	struct clk *fast_clk;
> >  	void __iomem *base;
> > +	phys_addr_t base_phys;
> >  	int irq;
> >  	int ret =3D 0;
> >  	int clk_multiplier =3D I2C_CLK_MULTIPLIER_STD_FAST_MODE;
> > =20
> >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	base_phys =3D res->start;
> >  	base =3D devm_ioremap_resource(&pdev->dev, res);
> >  	if (IS_ERR(base))
> >  		return PTR_ERR(base);
> > @@ -1029,6 +1322,7 @@ static int tegra_i2c_probe(struct platform_device=
 *pdev)
> >  		return -ENOMEM;
> > =20
> >  	i2c_dev->base =3D base;
> > +	i2c_dev->base_phys =3D base_phys;
>
> We could probably do without the extra local variable by just moving the =
assignment here. res is still valid at this point.
Same res is used for both IORESOURCE_MEM ad IORESOURCE_IRQ and i2c_dev allo=
cation happens later so I had to use temp variable


