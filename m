Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17658C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4388214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tBxJiac4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4388214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeHUKuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:50:15 -0400
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:4224
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbeHUKuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGhmxwlxvn8WZk5bKSOnYBAbESSrJsKaibNiSI/oEic=;
 b=tBxJiac49844trRI3w9yJ29NvdD3jNUsHlQhNwAkrhnWMpFn3psy+0Qojq7Z6bmDWV8kIYiaDsWMwWrmmG5XR8BNzYRIcWrshJMSddVZBIcJHVCIMkQWKXAJ7m6vbAWIvjOkWDSnvldHnmrkpReY9yo+ORUp7DiGfo2HL/y4Tvk=
Received: from DM5PR02MB2187.namprd02.prod.outlook.com (10.168.173.137) by
 DM5PR02MB3640.namprd02.prod.outlook.com (52.132.138.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Tue, 21 Aug 2018 07:31:11 +0000
Received: from DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::6563:f45:f28a:df2e]) by DM5PR02MB2187.namprd02.prod.outlook.com
 ([fe80::6563:f45:f28a:df2e%5]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 07:31:11 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        Radhey Shyam Pandey <radheys@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] dmaengine: xilinx_dma: Refactor axidma channel
 allocation
Thread-Topic: [PATCH 1/3] dmaengine: xilinx_dma: Refactor axidma channel
 allocation
Thread-Index: AQHUJZfFdQXKFYvCaUeNekG/BTJM7KTJ9l3w
Date:   Tue, 21 Aug 2018 07:31:11 +0000
Message-ID: <DM5PR02MB21872434D0054888E8CA1EC5DC310@DM5PR02MB2187.namprd02.prod.outlook.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1532688639-32230-2-git-send-email-radhey.shyam.pandey@xilinx.com>
In-Reply-To: <1532688639-32230-2-git-send-email-radhey.shyam.pandey@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR02MB3640;6:DjL56yMnF4XWL4IFiyGDXPBugeM6/U8zX2/ZVhzttaRA0RENHhkUXPYjlxUi3bXJ1k7iYnlayWwavG3GyqV6IqZb4GT9XgS/9mX7WumqFmVFBLUbOypPgoGaxawZnLQsi0YftV+MFFgekWSVPM0c1IN7kTg3nOlelsNLIPKXUbvD2I1dDrHnR6O8/uq/5YdHz5fLevKLGFbA0KSFtXmBhz23AqnZ9Hb4SZG6+KTnOALV4JTg9t65A0a8n+xu115t7nWoRmMs3SyZ4txaEx5YB/amGBWli4hv+xJpVafgSHzPqB5oh86ux+GGL5oNzVNeNhNKunyAgxHLEgYTGJknzxHnNqowe3mOvix9K7gZbTvDycTynpOuG88pmLjgbbp8RBevCAlyzwKDpa31R3BgvuhIp25lY7AIgkdMGANmBWJ5EszjQuGyX1pvV0Qoi5aCNOf8ksOydLENGP/Vbv+0Fw==;5:HH4XrXV5Rmy3Z8yJAawpzYqvoh8P18GT4WWAynv4P46v/6S4RuTYHHlaE6B+3uKgS7gNPxSkKMARFBUErQChgIpTnVlAku1Zmk+9AZLKjyHhaQQRZ4GJ4Lk5HrOIpkT6KzW8sXlqDKBBsj5OJnEUkp/WGvikBJppqTUZuu3FUuc=;7:xs0NoFN5DrnSaYdD1lkX1UFKMV8sdKxzRs6zmp5oKoO1mn8538HV/+5lOPV2Mbva8duJOQgeWd9XUz3siBsnMpPt1eMa6UQBLIZgJSBwEyOg8OAMLU+Zrr8dWHS9FYI6lR2Z3Fn8+UFRWLATvvugUCiKud/0kUDqKFfwdOB0wzJwFY9lRw7Pm8HvAf5g9N8gPFZpeNRlBpPMDJWaUAi4XHCJNem/KqjgYztU81p8z9C1pUhQat1QY0QkcufX+l7Q
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: b31708fc-5619-4915-a0fc-08d607381180
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR02MB3640;
x-ms-traffictypediagnostic: DM5PR02MB3640:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB36405A659323A4A451FEFCBDDC310@DM5PR02MB3640.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DM5PR02MB3640;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB3640;
x-forefront-prvs: 0771670921
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(51914003)(199004)(189003)(476003)(446003)(11346002)(256004)(97736004)(478600001)(8676002)(81156014)(33656002)(81166006)(74316002)(2900100001)(7696005)(76176011)(5660300001)(55016002)(105586002)(106356001)(6636002)(8936002)(6436002)(9686003)(66066001)(53936002)(25786009)(102836004)(6506007)(3846002)(6116002)(2501003)(316002)(86362001)(14454004)(2906002)(5250100002)(486006)(26005)(7736002)(54906003)(229853002)(99286004)(4326008)(110136005)(305945005)(68736007)(2201001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3640;H:DM5PR02MB2187.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: a3umnZbeIChcTmdn6uRq0SAcl5P6T33rD7T/vNOblw60IVdMJ4+TwMX5as6e4AEe/GV4izVNta8zi783483u5XrnyY7fo1Dp6PrrQBAzBc3AyegYz6Z/TAoTLwbVozxe4RDL7frMnVnEyx20xk7hx15EmFqxRyh9PoZb1Jjeeb643L0WkJEV0HuY5UPrczXKashvow1QG45BZQa5DL1H/qmCTm7VlVPSLt/jXQouD6Cf04JJSRtgBtB8DqJiDaCHXC2J87Jg8zAISudMu50PAQNTtXgz9QcxeuYHYdRvk4tGzB6qlXxTxw2sNTUEJHouQhr7QJ76ZqWXiI20xvYbSK4m890gSm9A96KsnLhuBr0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31708fc-5619-4915-a0fc-08d607381180
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 07:31:11.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Thanks for the patch...=20
>=20
> In axidma alloc_chan_resources merge BD and cyclic BD allocation.
>=20
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-for-series: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com=
>

Regards,
Kedar.

> ---
>  drivers/dma/xilinx/xilinx_dma.c |   36 ++++++++++++++++++---------------=
---
>  1 files changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/dma/xilinx/xilinx_dma.c
> b/drivers/dma/xilinx/xilinx_dma.c index c124423..06d1632 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -887,6 +887,24 @@ static int xilinx_dma_alloc_chan_resources(struct
> dma_chan *dchan)
>  				chan->id);
>  			return -ENOMEM;
>  		}
> +		/*
> +		 * For cyclic DMA mode we need to program the tail
> Descriptor
> +		 * register with a value which is not a part of the BD chain
> +		 * so allocating a desc segment during channel allocation for
> +		 * programming tail descriptor.
> +		 */
> +		chan->cyclic_seg_v =3D dma_zalloc_coherent(chan->dev,
> +					sizeof(*chan->cyclic_seg_v),
> +					&chan->cyclic_seg_p, GFP_KERNEL);
> +		if (!chan->cyclic_seg_v) {
> +			dev_err(chan->dev,
> +				"unable to allocate desc segment for cyclic
> DMA\n");
> +			dma_free_coherent(chan->dev, sizeof(*chan->seg_v)
> *
> +				XILINX_DMA_NUM_DESCS, chan->seg_v,
> +				chan->seg_p);
> +			return -ENOMEM;
> +		}
> +		chan->cyclic_seg_v->phys =3D chan->cyclic_seg_p;
>=20
>  		for (i =3D 0; i < XILINX_DMA_NUM_DESCS; i++) {
>  			chan->seg_v[i].hw.next_desc =3D
> @@ -922,24 +940,6 @@ static int xilinx_dma_alloc_chan_resources(struct
> dma_chan *dchan)
>  		return -ENOMEM;
>  	}
>=20
> -	if (chan->xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
> -		/*
> -		 * For cyclic DMA mode we need to program the tail
> Descriptor
> -		 * register with a value which is not a part of the BD chain
> -		 * so allocating a desc segment during channel allocation for
> -		 * programming tail descriptor.
> -		 */
> -		chan->cyclic_seg_v =3D dma_zalloc_coherent(chan->dev,
> -					sizeof(*chan->cyclic_seg_v),
> -					&chan->cyclic_seg_p, GFP_KERNEL);
> -		if (!chan->cyclic_seg_v) {
> -			dev_err(chan->dev,
> -				"unable to allocate desc segment for cyclic
> DMA\n");
> -			return -ENOMEM;
> -		}
> -		chan->cyclic_seg_v->phys =3D chan->cyclic_seg_p;
> -	}
> -
>  	dma_cookie_init(dchan);
>=20
>  	if (chan->xdev->dma_config->dmatype =3D=3D XDMA_TYPE_AXIDMA) {
> --
> 1.7.1

