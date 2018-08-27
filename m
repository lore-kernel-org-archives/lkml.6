Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C493F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="nKIxbFmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C493F2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeH0L2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:28:10 -0400
Received: from mail-eopbgr700062.outbound.protection.outlook.com ([40.107.70.62]:2784
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbeH0L2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdqa3PzfRkR6UiJWPHs9UyAFe5vW1SBMZGLp0L/ykIo=;
 b=nKIxbFmhvztQau2jZrOe16r/j7yKl8qloJ+4wu5Ldbz9KjYNN5//tHAh4D2S6+ZeSpWT11AM8NNpDkQltyFMV7yZ5ndFgUFuqs/cZm7Egnp5HqrhOTF0fzFGPcQEvM8PMeQJHI6Hms0JwnLbSf/MlXbuCzibsybcHwgGjMUhPlg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1573.namprd03.prod.outlook.com (2a01:111:e400:526e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Mon, 27 Aug
 2018 07:42:35 +0000
Date:   Mon, 27 Aug 2018 15:39:36 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary
 limitation
Message-ID: <20180827153936.7481ae13@xhacker.debian>
In-Reply-To: <6302a5a4-35cf-3d8f-fcac-a15141fcf1d0@intel.com>
References: <20180823180549.78e508db@xhacker.debian>
        <20180823180926.444b34b5@xhacker.debian>
        <6302a5a4-35cf-3d8f-fcac-a15141fcf1d0@intel.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To BY2PR0301MB1573.namprd03.prod.outlook.com
 (2a01:111:e400:526e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca2ccfe8-08fa-4ec3-0c95-08d60bf0a88a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1573;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;3:aynm/3Wd8sTkmP8a1RflAHUFd8zMb3DU9RfZm033eXLmWVZJBS5SsU2j7s43PRxuMIKSo5GBsSElUycH43K29KS+kbEg62h/PJ+t17HNoiryt/E5g7ZnmaiddmC3PPAzsEy1TEss0CEV0dvqkjjF60e4QsOethOkw+9kIczrtiY/jHP/VmkBGwUQzNbxzVlSiodj2b1h2clEn4JGygGm3Sx4YtrGKI6M3FmciUX/lTutTj5YVZOiL/neX+TBvben;25:TIPCuEABEKmwKDzex+xeAWwdQ8gVxhsOzUpym/p54/+kaDsMLgzrRnqM4gmF3jfR6ljlI1AVi5SdmFA5bv+nBhGIevTKeDcRZSp/OHb9OoJahFBW1p8U3OkrpCK2m839+3ywLZAxiB2eM+K1CuTtxRaCf6TFxXmNARiXS/WuBlzMmIS0oAJEOp9f42FagJ8i0UBo/8ff3f23xOPNZNgwOC/bsvq7/yW/VXHsomVhYMNlQcksPMx+BTs7qLUN434W7dyJal4Dj1BH4KyZ8o78P11GycwxFII7/WIXGJ59ic/mkDTnyWqBlczI2/cs3x3zrMrL/d4H5m1Rnep7zVS28g==;31:qLFnW99rfGS9H7vZ8LRTNZWJaa3cwybqRQzFYjsz/VIdX3vXkcKhQl5R0GsnH6WQYUcca/kDW6WM8dGWuXzjuvhuU1fGx+iJ5eLqRb62o73xrHRfbqHJWaAx1uuzWoyxAZ/Ivb7X3Ijr85/bhgD10ZoE8/iawNX54UXWuBnbhDoicoJ6tHyw/GKBKnWhamlsVnCpiTeGdFXvVUrRnaFSHIbu8BGvzji7kTsoqpQkRZo=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1573:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;20:cNYXJhFdnTvMJ3o3gzYKxUnxu6SjzflEQS13IEW4+f7RuIw9XcrjkKlYJo1KRxpMyKRqJn+8Kn0Fhk1WUrhcpULNzzIC2xczLvTOiWmGDFoKibtcXJW+Ah1X/S//Ux5lO+8cXHnF/mEpB9URhGsmPR6pRBveSXB2ATk0oF/79TFWmBxIA8r1XFl5EpWTZOpMRoasNxx2z7k4Y7T4YT4ZR++PvTrW9+9OWysko9yQUI3F53Q8BlEI9FFTFzRIOT0oO5hiarGhxxJK5S0cX9nxBx9kkTSX1xi8tfb/uSZhETXW43B6cUNKPYredGBwOf6nD9SMWNYoDzhiAeTyP0u6hsMpYwRyG+kQ+HDYebEM8eZtfguEXv0mXqlQNU73YL9zwC7hQMk0O0lPAybRvV6BY7wNPM6mNjxHmu3v7BccO5gqYEQTki5mVnhXdKqMJ5eB5oaj1wcE9NxsZIQ1cmoFobm4CiI2aANo9E0marWs0V3d3i2H7IBe8kaqNfAE5Lgw;4:BWNcpZVSrgz1acOleO0GU+QbG6vtiSna1kf3YdN5LEgeRlzce8lq23g5tciBfQG/tA1r3vdnmeKL1XfjyTs0ZXucQGbMi7jOCBnFvG+Q1PSk9ypbn3AovAivv3QboKVlVYS4jyR3ubO03+zovrKkuFC9ZlgRpcbwem+hnTr90wlzEFwCNcJLFj2vOcqlXX/jm9QWTf9HVOTAPiUzhJOZRCYSjB8OTPuKxMH8Xs5l9rlbRABa7MxasArQ72q+jgOedl2CqIgm2DJm4dxytMZ5yw==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB15734A87C1457FA849960826ED0B0@BY2PR0301MB1573.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:BY2PR0301MB1573;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1573;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(50466002)(54906003)(26005)(25786009)(76176011)(476003)(956004)(7696005)(11346002)(52116002)(230700001)(486006)(50226002)(6916009)(4326008)(6506007)(16526019)(186003)(6116002)(53546011)(386003)(3846002)(47776003)(5660300001)(86362001)(66066001)(575784001)(97736004)(23726003)(8936002)(446003)(6246003)(316002)(1076002)(478600001)(81156014)(55016002)(9686003)(7736002)(305945005)(14444005)(229853002)(8676002)(53936002)(81166006)(106356001)(33896004)(68736007)(72206003)(105586002)(2906002)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1573;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1573;23:ZXAQ3KA7zUsxjIRxgmnG9NwOgIofpt4buHDgis6?=
 =?us-ascii?Q?91EtMnuZIhiYmSpi1L3YbzgwoJegmzo5nNt9vmq9wU70Nwy9a+leBLhQqeJZ?=
 =?us-ascii?Q?EuAEoi8cpUu8RFIYxEGkereRJz+UsnIKaUya8di/YnPpaBKsNrbpmSLhKNWg?=
 =?us-ascii?Q?lvB0tuHCAk7lyBxUudpzgCWPx33/pvr5POaam03m8fA1iBRbebkJDtNAtyc6?=
 =?us-ascii?Q?rhJDry4MdKvXrtZQxkpKBYc2dwt/CWNaeqYxktHeWESSEWxjeJ4m0Nhu5/Rv?=
 =?us-ascii?Q?4CpjBVZkT2XNz5jw9C0icsl2bT2VxanZLsju2gpAXRCxWT7r3si7R+ygYYCJ?=
 =?us-ascii?Q?QrQoYi4TMLXyrcRFhXKB7wSOGC56volZs898QAaKyQgX272mXuAcE7UqsiY2?=
 =?us-ascii?Q?I5D0pd2FeW+Bi+b+cWeHEe4WzhNOEVtHNMUnws7PGGJJQ4bVlE221HLGmtbB?=
 =?us-ascii?Q?XfBnm5qxgMziQvcnGmJ0UF4gmCRz8KfKc1kD05nEf5rGrPBwsnJwZG9s9uJd?=
 =?us-ascii?Q?szvHzL5Ht3T9gT8mtD4efvRR6YZjmALXaxX8TIDOmztWoburKwx+YKicHUVf?=
 =?us-ascii?Q?3B3kPuhoithFDGOEgx8gX5BGctco5Ias+owNvSbopmhencA8jSHJidzwleMg?=
 =?us-ascii?Q?ByekM9ajEFAE+hHsqE0ZGfZ1QDQmjw4WwI3zPaigMEWjHPKEr6tnqlEbsl6V?=
 =?us-ascii?Q?Ag8ciMOD/Hl4ZFfXoct53xFzENk6ohFpQk/iINHHxUdRk0W5DS1QRGAdzs5d?=
 =?us-ascii?Q?D8QBn8isLT+E3F5IAD94sMHM70U+TN79SkSvk0lD1q/69/En1DDSWI6gyjJ/?=
 =?us-ascii?Q?kXo5Rzs20RJ5scVoLpwpexSSSy8s2aflccTYs9KD90vIpQz0s0tyqQ07dhYw?=
 =?us-ascii?Q?YKy1xj/yAhSSkB81mM3GybhSNfQWbTAcLzQNLrJ0qAQzDUnthV+++oP2Wils?=
 =?us-ascii?Q?YxHBnVAVEXFwKXMOza96LtRHNxijns++Y0Cm3txPMJkKkl+gbO+E47fL+LCc?=
 =?us-ascii?Q?FE55nq+niL2iICupXSy6a5h1G7JvMbqGVao0xu+UI/N044W9N0cKay/r37Rq?=
 =?us-ascii?Q?nrenziygckTAMCyllskdm+C5AXlTW+ivtz3FeR2Iq8sI/nwvh1nEd9Wawizn?=
 =?us-ascii?Q?oa7JeCiDurPyxl2L1hinozHd+9cJjvx8DdlFYQpdeVNrPcA+vY4sELn4Ai9O?=
 =?us-ascii?Q?FXkavYiFt8dYZjsv2ofHTsI4gkA7UcBOY8Dur4RMVF/hZK6XF1XTzKM4gXiz?=
 =?us-ascii?Q?tVw+Ppxa+scHlsJYyRAvCksOiWxXSX4HcKkC7Quob9aHcOWgfSIbhtdk2dLV?=
 =?us-ascii?Q?n992oo4YHkonUfRuirSJ6dMcnbI4Uw+kBj+0+R1gnZX9WtWWZS19bdo0V9gc?=
 =?us-ascii?Q?G8/NeMQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: JRxw90sVufKR/MQbHprKEm6KF44be7trbgj3+nBIZcfs5x4KecgZHC6/9yQxQn+RQacypPvgXZ09jR9fv8+dOfMlyxSbnlcTNsjR+CQuMd1kqSYDW/eUWUg4aKg71dnJBdPtowl94zI6ypdvrX80kHEUoW9/7J4VAnTvzDD0BtuCPBmv8gNpkVyevIxzCVPPd2r2NW9+vqBdgkHZaDWuYoYlY/EC3wM8VM4znKOkN7+1K5b3gV9XR8iu1S2KeRNOTlxDTbBrAj1BEiNlQSEYsQPuCgqTFx2dUbI6OwnWIevAQx+LIh4cc1eUT+kqK1VB65HytsW/LWdBORynCrbCijZUGcLS7hlVJhv1E3tKr74=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;6:BhJd4D90LCi7bjzRHj1nbnexzVnQrW0lWML+C6OoTYaRkwVrIUhoGJUtPuY2xh2NabXQE15Og2jXCDXLznpenS+3CHrC9oTDOrv+6LmIn211iqA/Ss+TKHFWQgHyoyhx+SKZWUZIdJHEK//j45wR+tnYb3od5MdX14IwUcimzX/52RE35EXx/xBj53BboefL6aMZVwZZsPxnsgQxFhHa4TqeZat2BFal93dmCLEXMZUsTvydjd0fYqOkwkLndg66OiGkAWLbSK6SgAtVohL4PCTY2ZnTpmZLycULzIYX7VXyXp2/HuX1eAntUFJ7zz1KVnzjPQAeuVuu/QsYt0rBxuIrCYuszKYXEkm7IgaCGGJYBEf3BM4YQJ/h7NnEr3Zc3WhQtlaKkrAUr67JdaDyGMu3YFRT2Yu4KUT1NpaCNiRaxoyOX7ikNvrSpomUVYhYBKeTLb55r1yKlLZSnnMsKw==;5:T53rkAc/NoD5GGleaSY1T2YdF6FouNZ1ThROAdOHscGXGdXhBOOWtFCqUwmS2x4XyRI/kdaLyC4qodZSVeAiXB7SCveb53FdCIohsz3OYfYpUOeqddKEYdpqZwwv3GDxEjexSD/G9IVhBkNFWAQ0DUJ2zX+nhOZw5CdkPqC6yGM=;7:lDjSnhiIIOrYwXFp+AxrHTSkqm4PRIIerI33LmBOcnK3p8vY3fgMs0+SO59jVyEkuSLLgxu+WRH+BLylbGIgrZ5GSCVjC+OQbW0RUgpVrse5i2YDA9kfizxeYse5+tVDg60nhxMyyAAyE3olBAF+wLD2sE7/p7HQch1WUuil+5fb/7BtfdrXFU35CfZw4EtkvWYtcdmms1jlYmY/Bk/ZrUyjOVsd17dxz8CjYgO9Dv+u/VDrkFP8KbbEBIaVAfQ/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 07:42:35.3669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2ccfe8-08fa-4ec3-0c95-08d60bf0a88a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 14:51:26 +0300 Adrian Hunter wrote:

> On 23/08/18 13:09, Jisheng Zhang wrote:
> > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > the DMA transfer into two so that each one doesn't exceed the boundary.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 1b7cd144fb01..df0a3aeabe19 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -8,21 +8,48 @@
> >   */
> >  
> >  #include <linux/clk.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/sizes.h>
> >  
> >  #include "sdhci-pltfm.h"
> >  
> > +#define BOUNDARY_OK(addr, len) \
> > +	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> > +
> >  struct dwcmshc_priv {
> >  	struct clk	*bus_clk;
> >  };
> >  
> > +/*
> > + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
> > + * so that the DMA transfer doesn't exceed the boundary.
> > + */
> > +static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
> > +				    dma_addr_t addr, int len, unsigned int cmd)
> > +{
> > +	int tmplen, offset;
> > +
> > +	if (likely(!len || BOUNDARY_OK(addr, len)))
> > +		sdhci_adma_write_desc(host, desc, addr, len, cmd);  
> 
> Doesn't this need a return? i.e.
> 
> 		return;

oops, I made a mistake here. Pre v4, there's a return...
Thanks so much.


> 	}
> 
> > +
> > +	offset = addr & (SZ_128M - 1);
> > +	tmplen = SZ_128M - offset;
> > +	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> > +
> > +	addr += tmplen;
> > +	len -= tmplen;
> > +	sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +}
> > +
> >  static const struct sdhci_ops sdhci_dwcmshc_ops = {
> >  	.set_clock		= sdhci_set_clock,
> >  	.set_bus_width		= sdhci_set_bus_width,
> >  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> >  	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> >  	.reset			= sdhci_reset,
> > +	.adma_write_desc	= dwcmshc_adma_write_desc,
> >  };
> >  
> >  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> > @@ -36,12 +63,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >  	struct sdhci_host *host;
> >  	struct dwcmshc_priv *priv;
> >  	int err;
> > +	u32 extra;
> >  
> >  	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> >  				sizeof(struct dwcmshc_priv));
> >  	if (IS_ERR(host))
> >  		return PTR_ERR(host);
> >  
> > +	/*
> > +	 * The DMA table descriptor count is calculated as the maximum
> > +	 * number of segments times 2, to allow for an alignment
> > +	 * descriptor for each segment, plus 1 for a nop end descriptor,
> > +	 * plus extra number for cross 128M boundary handling.
> > +	 */
> > +	extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);  
> 
> You are assuming here that totalram_pages gives you the highest physical
> page number.  Is that true?

Per my understanding, it's true. What I need is the MemTotal/PAGE_SIZE where
Memtotal is from /proc/meminfo. After reading the code, I found this is
totalram_pages as shown in si_meminfo()

> 
> > +	if (extra > SDHCI_MAX_SEGS)
> > +		extra = SDHCI_MAX_SEGS;
> > +	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1 + extra;  
> 
> That should be:
> 
> 	host->adma_table_cnt += extra;

yep, will do in v5

> 
> > +
> >  	pltfm_host = sdhci_priv(host);
> >  	priv = sdhci_pltfm_priv(pltfm_host);
> >  
> >   
> 

