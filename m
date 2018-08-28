Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EA2208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Ly2Pv/JP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EA2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeH1NrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:47:18 -0400
Received: from mail-eopbgr680088.outbound.protection.outlook.com ([40.107.68.88]:60107
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbeH1NrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH5hKhqVs0j8SXPewubs8e5s93NefK1fJh86NLkM4dc=;
 b=Ly2Pv/JP5M3QrqMMXORSUgO682ogDwXUMdVYNM1Lw4jCHNiq+2W0IqS/yfX88zCWxUsRXJ5mWknyTiaqBIJSttIuedCGR9jFSXHRzl6F9Sc3S9V1eLOVIL6v99mSVAiSyAl5qDJ0zh0cIyIKuSQJQaVwWKQwaOWa2jO9tKIIyN8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1569.namprd03.prod.outlook.com (2a01:111:e400:52a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Tue, 28 Aug
 2018 09:56:20 +0000
Date:   Tue, 28 Aug 2018 17:53:19 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary
 limitation
Message-ID: <20180828175319.7ff35889@xhacker.debian>
In-Reply-To: <9739a083-cb2f-1cba-19c1-1c4e0d03eedd@intel.com>
References: <20180827162026.3901de27@xhacker.debian>
        <20180827162419.61afe238@xhacker.debian>
        <9739a083-cb2f-1cba-19c1-1c4e0d03eedd@intel.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:402:c::27) To BLUPR0301MB1569.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c516ca92-41e6-4fd1-1fc4-08d60ccc82b3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1569;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;3:e2EvRyK/VWWhKE/lC3m7GEz0r2fWuIyJHl//DAEW9iChm1dL2KuaHIZ8Lk6VKQpzx2hnbarMe5V2HT3ImFbaBCsRq5hKkhV/0Sxh0/fTY7ATjECdn5yNNoP13X+79Cu1+8fsV3F9zLXP5RGQyJEOgMApbDzjO+HmDVsPvCrhWZqqhF1fEW/ybcBrQ9vRtK1sn1TjBN/k5a9IGe6D+sLd3+fByBUF7GqbTOisDio4j5ru//seHSgEiVk3ldln2hAa;25:vAT7JQofWL7qiLRHyBRJL2pxuRmsVNS4lp7h1MeMPMOb42jYc7fC99ruc2hWA5ptJkk59qYusCtFboqY6uZGFTC5NH2tt00EEVTvEsQzvbYKIY5m99pH0QY8OdUZGMCvpyZ/LeeCE5HircjM0YU+8wwqzyhT+YWvvZ5MlcR4QZq8or3csFgbf7RDWanlaVsH4myTpEuEw36wOCaa+xkDn00FR18hdWJwlIbxfGyaWZ205oy6KPfwVHekl2tP/R8KPhpnhrr3hb/HqC178fEx+KCrjh6Ajd2bjT6nMrYlAJmQFUyc+0hbAgMlsZf1g3JYtUVxUfOy2gUy5pLNlMmCIg==;31:0cL1g6Jf/1+VqyuMII5iONZEzBCcf6zuRFm2v4VxO43k41LU3LYo8UgxEqneSq+rq3do4G0V6bq3/EToxUKu//id2wO3g4KfBMy6MWN5xns6xwDtepz7x0VC1JbeKHvDtYE+4kegkffKiSukayOCUlmpAwkzjJydgVdd2akNjmb4x2cOcbzjg/5oZMsnN1KntIQk3XJseI+25UOiig5t/0BHI5sSoJG+XpccExP68Ms=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1569:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;20:YdLn29tS9YKdT6NThMudMk8z3Iw1iw7ezYAhOF9Zq8a3aWLbRadlIHNX8o3WmDwFQ9BvjYWphgjvHwoyex0BcFG3uSbjFIzvJw5iDGY6QNuHd0pAErLhSLOofA8DUBdK3qO9EIvQwTQHg44XkU5x6BQ0o+eFlDssuXHyKKD8lKZC3cKtJgR8Qm4N2RLNE9siAOFPRNaCw3mF8aBRUquNZbh1AULI8Fp4BzyoaE/WiekNWoutWLyrUtwQmXyMUgEz6mnI8PJvEU0Pe6CSqLVV5qbSMaROkgyDcayXIhh11GnigNm4TGXmjpyfITZUGjzroftCQERF4GQIqw7pT66gJSE05c7NW750pQeuwKcLvlWsGAVrEvfKBinwhpzIGRAvE/g0EpSlPlLzinSDWe4RudadA+N5wci1xQhqJVDNdQ4FL629OhNPgYTSW5RLaxGjR/9ZUuztEYQ5fkq4Lyd9ZEw+M2qrTVrMPJxPduOE6dQqH2/N+wy7LJeOjwj6P1JT;4:cwL8WUF/1Pjomh/auFByx5ZjkDYPj1saSpP+MTKEBg98UfS/vfMHEYD/Fal92X4VYFzsYTdP2xMxg2TTM+r1I2KWFZiGq4oGVVg6ac6fMI7s1XyqeKLA90fDY30GonMtgQcKJsc7GWGK9sae52bKjqZ3vkD0HshbUeYdNSZohy2vwX6abHlEoN41X2pSmd7FEWjw1VVNaf0Sqbk2tHsw6/sEGzIt5sBUlAs7xmbbW17E+dDdgOqb1HgQKGurN5ElapFEkvlTX1DLmPZulSlgLw==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1569B5685ADEACA944CF119FED0A0@BLUPR0301MB1569.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:BLUPR0301MB1569;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1569;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(14444005)(81166006)(23726003)(66066001)(956004)(5660300001)(446003)(47776003)(11346002)(105586002)(55016002)(1076002)(9686003)(72206003)(68736007)(229853002)(476003)(305945005)(6916009)(6116002)(86362001)(3846002)(6246003)(106356001)(2906002)(4326008)(81156014)(7736002)(486006)(26005)(16526019)(54906003)(97736004)(8676002)(50466002)(53546011)(6506007)(386003)(230700001)(478600001)(33896004)(316002)(52116002)(7696005)(25786009)(8936002)(53936002)(50226002)(186003)(76176011)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1569;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1569;23:P6bjrLkmGwUP0R2ko/OKlm8jHTsKO6voqu3kYUz?=
 =?us-ascii?Q?mUw2yuA7mq3OT3/HZ/PblBO5Ntndze/d2eMhjkrjUpQhp7aG5A5AIeY+Q6uG?=
 =?us-ascii?Q?bX0l1nMsvV8+Uf929+770FFj/E9nvo3cpOlQn8KPhXNlSqYleYoaNE/NmiIB?=
 =?us-ascii?Q?d+CZZ73dlgCp6oK2NAliwvDTvS0OFDoGriS1WP9q94sApl4l7wcF9a1DWUcO?=
 =?us-ascii?Q?Q8qSDZ88tTPbfV9JfyBpCIjPQVE1WmK7VeYxOe6LAX7KyGs3oIaV1U9FVAdF?=
 =?us-ascii?Q?cWUhcvIE2TJ5SyUsfbkm1UgWTNnalyYx3sgidGLK5MQCZtBrlrazp8NpClMY?=
 =?us-ascii?Q?WMXn7tqIqxrx1NJAQRfqVa+5dk5TsDwS5pFIk3XNqs3Lv5Vg/F3Z+mUTtR0V?=
 =?us-ascii?Q?cNUza7ooi72VZ9EgLPbzSy7Rjir/qXBKL/0SUdZLVBJUyJb+bEGqE3NGrdsh?=
 =?us-ascii?Q?Q+zlvjVjNPSwSfLbwzVwyV+ByRIf6nyjbT/f1YCY0Xpbbi4gsd1N0eXAtF1K?=
 =?us-ascii?Q?lOy/eLUOp4AYiZvC3q3ekon04rPwU4M9Stc6QHj10z9mN2XX5SypbscOr72f?=
 =?us-ascii?Q?dx+CVODLlfbPlrqvWvJgziXLAzGMkYEBGa2rSCpJLzOBN5OW/VfoY73HGQi2?=
 =?us-ascii?Q?yXrJwJd6qEuTrJ7WOLUZ+wWCba9KqoJfpRHoaCUtOkfCZaRGtogqUy79QF9Q?=
 =?us-ascii?Q?aKOCQFnL5sBHUuESCWKV0WZ0shHsYATJx2w8FpXSd9ht+HAg7KARs5FZl4iV?=
 =?us-ascii?Q?Om0SFk3hOAQwQmHOOLIRKS+lDIF8kUF0ILM1iZ/FcowLmRGkdeeTCh6sgiPL?=
 =?us-ascii?Q?o/XTD7XET3Ncnsq3LkqK0Aa3z/6+4LzuvNvwtkWwEcagKEnrMAc2Q0x+AZpt?=
 =?us-ascii?Q?za3wLGbpElRDSlpE6pNhq2lzaqqstOu2aBUkKw/Qa2XZKIj2s10PtbaKs8Fa?=
 =?us-ascii?Q?8G2JW4FgO+6ucIKK0YCZuSNxwnwRoAKMh/WDIT07iB6olruPxkM6ciIpmP8P?=
 =?us-ascii?Q?0w4tNK6k6GXcnUyfqvO5V/JRNAuGRByp7Z0dlyipLiLXrTIKnDtKPbqIvBLM?=
 =?us-ascii?Q?fpkUzJ4oY5SfxE0LphoF09ddVM+ddFFxhWaHf0TedQEyydUtvoInJM+NYL15?=
 =?us-ascii?Q?OlzRbUFmO7sCH+R3z0cIaB9nKMQVO31FsfJgCQL1aSmTRIaESdOfBhx+wwre?=
 =?us-ascii?Q?lZ+5zBe1IH748Min9SwTxJbDxcG+2gsR3KcVmV4/bLyN3IPd4YIh+rwU1xHW?=
 =?us-ascii?Q?8ChavOvi5axVeexy62Xu/ZVM39ie+xZ4pJfTGQryyJtvfPUXMYbqDU1tVmoY?=
 =?us-ascii?Q?hZHfXqAUt3Pk6parlyF4ners=3D?=
X-Microsoft-Antispam-Message-Info: 73xstnSOltd7DTXgUcamEQU5EL1pYTbfJcjcJAwEJ/VU0ODoLruS7H/5kl1wHdF7k/bX63J/kkr8W8hCDPhOABB1wH+nEQ63A2bRazunx02XqVbkKJsORPl6tHiin+2q81S1xV2fHnDND9tCLg6E1O4ihPDN1Jrh3chAVBV1aD/gCkLFibYm3B98n1zW4E7BEAhB3nfaF4hIOp3JhlmmozhNUIQAfw2lsEJdBz3SKgu+JiXRDkdj3oLVtfvhcbmkTG1lNSKzs3GgO64CPcc8nYC/Bslf0J5xNhAZGlFhrPo13f/tNjLOLVBAkGbkYb+wtmGJvoFAdvvFMta6Fn7YtV4Zb+2jlCGuMGcpyxvqUQU=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;6:yiYfWYbHs9uU9PquQf5tkj9PaGQq6OS0mpQchSf20hZhHBA5fSQOBU2nFzaPK3Hqt+FPMZiMjsI7Nl8lZhM5zS7UsXGg7DAl9u40tOyT7mEFtN17+zMYnTRhvbr8t3lZStcWYBJ1mqfdVOBYGz3/elrVLFbkO3nWlvpfhzw8NZq+9pxoQ4cFIGS6Gy/TfaD/DVFvLtAf7Vj2zT2OeKdqD3FUJjDfajeVD40ioKsnq7LIsoMyIy3GYIHSunpAbl4v7c/YSn+IS6rm4I74hmNd8A317XcbQrkFzUulcb8fMM4oP5xBVoMaf3A8Ty8bUYoEk2kBOWhhnrHNuZQwoOsO0rIplabjHhxXBr0Z01010nkxUg+0JnfuvdVRxY03Ao6Q17wuAiiW7l2r3bGkaGEkKX5zTVVHaNe8ejqksz+YQRnQTdzCNHr+SeLrszT2SwYow20gP8fVeOMHBe9yaFkhdw==;5:0Ln8nh/r9hh3hSPIt7sR95IDO2WsMWpuDkd+Ajg67WgmNz59TZ1HhPALVLj0iFFk36HczlhOiQhWlpKR3CzXEVkzsJzgOgS3Ybavz8tTWRuEgvNA8Crr2ufdjhBaMhmRByF3iHBXLY0ZvUyIaxkNRHpKCCPFB0CpGgh+X/82+I8=;7:wZp6W0Lyf2thYP+j01zCkcb4HB7yXOWegoHhI4unhRX/XAB+85AKgyrXbr4a2BmwRmKHN48I9gl81reflT4MmtheN+zO6Wg6zKViZ2fssMuUAPCTReEx5RB+o3XkNf4XBtpSK+34ULf+kv1e7EDzra1jQZzpkcL1U4NcHHj7Y83OdJzXC+11y18IQaCfHYeAWZUknov7w8Hhs4GvXiMqFizgevpWDkC7G/tOKntuy2BJqn7imyZRDo9ARa3fDOSb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:56:20.8858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c516ca92-41e6-4fd1-1fc4-08d60ccc82b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 10:51:02 +0300 Adrian Hunter wrote:

> On 27/08/18 11:24, Jisheng Zhang wrote:
> > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > the DMA transfer into two so that each one doesn't exceed the boundary.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 41 +++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 1b7cd144fb01..cfbdae8703a1 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -8,21 +8,50 @@
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
> > + * so that each DMA transfer doesn't exceed the boundary.
> > + */
> > +static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
> > +				    dma_addr_t addr, int len, unsigned int cmd)
> > +{
> > +	int tmplen, offset;
> > +
> > +	if (likely(!len || BOUNDARY_OK(addr, len))) {
> > +		sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +		return;
> > +	}
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
> > @@ -36,12 +65,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
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
> The amount of RAM is not necessarily the same as the highest physical
> address.  I think what you really want is max_pfn or max_possible_pfn

oh, yeah! But these two vars are not exported, I have two solutions:

1. use the dma_get_required_mask(), this is what I did in v6

2. always let extra = SDHCI_MAX_SEGS, although we may waste, but the
waste is small -- at most we waste 128*12 = 1536 Byte.

But it seems solution 1 could do its job ;)

Thanks,
Jisheng

> 
> > +	if (extra > SDHCI_MAX_SEGS)
> > +		extra = SDHCI_MAX_SEGS;
> > +	host->adma_table_cnt += extra;
> > +
> >  	pltfm_host = sdhci_priv(host);
> >  	priv = sdhci_pltfm_priv(pltfm_host);
> >  
> >   
> 

