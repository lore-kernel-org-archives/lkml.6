Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D1C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C6720647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="PBjRzUUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C6720647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeGZEwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 00:52:17 -0400
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:52672
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbeGZEwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 00:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKFh23V5Gh46gNkF6kQFc04AMRzeS3oSChwthvRXc3k=;
 b=PBjRzUUopYsuC/1kkXNlrIWGiIy/Z42TpUBcwaf40tCKAxLWh4PrjcAVNvFTEa/H4OMmzjMrt9t74lLQwBSMAW6PsocdVml8uhFYvp20YKkReY/scNtPX1IFMTOF0EZFThuSl+5Nn2yO9YXBrQImk3zb40+OzRmQrFs2uHjXrk8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1573.namprd03.prod.outlook.com (2a01:111:e400:526e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Thu, 26 Jul
 2018 03:37:27 +0000
Date:   Thu, 26 Jul 2018 11:34:25 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH mmc-next 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Message-ID: <20180726113425.722240bc@xhacker.debian>
In-Reply-To: <20180725174749.6fc97d4d@xhacker.debian>
References: <20180725174235.1ca764cf@xhacker.debian>
        <20180725174749.6fc97d4d@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0164.jpnprd01.prod.outlook.com (2603:1096:402::16)
 To BY2PR0301MB1573.namprd03.prod.outlook.com (2a01:111:e400:526e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da58d06e-9012-4d93-0036-08d5f2a91cd1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1573;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;3:bffKkZX/Qi2gk8iPoD8WwJ6/LGaPRJbQQiKlhEhm0Rz3yVwAccVygZBM0K0jSB2ogZll9ANfJiCGuz4oUwjJJeiAv+SfqGI3/XV/X1C31QMfaxLAEp7ZKzBIWUHN9lsCevkd/9pM8wfQZMi9XINM9afb1VSnDnxIRh+ktSjVHCXy3U2Qybv03r0OgmhYW65n5fZ5bT8ZeyOKJhkqhI9RwDyHismCbFxdn12DNfp5nfcDq43ppq9ewCu/69QA1Hel;25:u1Qe4aB8tAHrxb/HxZyzgcc27bN7agnsU3U3hYbxnLlab9UPFcCzWOrwSCH8NPgK/MoEIenRyAC1heaa63ozdOXI0FvTJITOcLKAplMBEcljIvwl346S/g/dALmlZVljq3fmGQO0pROwzUPMfNGGE+2VZYW6y24b6sqepIDWvNjzJNRhhRLcxW9EpqchUjXM5cX0RZj29yAZh17VhwpSW1vLCjx+xt6Ppl6KgeXuEyRpT/H35srlQVvXgLpW7n7QyapM/X8OOVj6y9tKYRx5qbHyRYt52VQavc+nMQ5qy9OisgTFRh8Oz7Yu3JEiHqdEvFZ03HgwR2eBTeRRaRXoTg==;31:mQbqf9wD8/wrH5vNIwitbR+V7ERWibC9al8lovIMlXQWR2CDuoDXJX7RiIYod0aSNsFuvZrpAHxto5YAZwHO1r9Kdf4Vf4bBOvClDniFX7wGIfW0G1FtH8EWTRE4N4rOsLKmb1z+FYpRiMUaQJ51q0aHf1VDD0X+fCXbSYzPvYg7fC/JFcMgaK07mlV/ieDjvph0mYSTWAGnQgOMBumzQbyR6Q1iI4BllYIuEzjbhRE=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1573:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;20:N8DPik1jFkE7/7Be3er2nstR5fWMY1NJTXyJDwznc2SIW9QYBX4iQ5oJbnCDzR90oCoIEC9nCgDd6XUeCbXr/2ZkL1Rf5H+c3pbrQIUdZUwDzVAp+FMWYwlW9Pu1TW1b/hFKZJZmDQJFbrcn+pzcIra0Cf8ZvC9SR9WxcMDPFXKa4K7NBK+1q7fX06c7qSGEYFpod4ZQMaWda7vwEExi4rJxQ7absDmSp8TQb73EncSrYLIDocXDjO6XXZXz9TkwXoLYzAs28iOSPYpvEVyiudwrEBWPDKYaMJkgNi3XigXz3mcnCw6odJSTTjJVpgbMDQWo7eYeANuiCovfhaIlBmAHc1hmhh6a4QAxCt8vF00O5CUit8m2RBDfcU102Kg8dQvIub3mw/0BjVdnpC7aFrOMMZocAy2vfXb3yQSL66bufc+pHTVhr8tgPcitybat98ddMZ5asAqlHK2QMAa+M3JfqpmYgDFI+bkJhitm/P9SF9nwpPar8gt5Ruce5DXc;4:bmjFRVZaTQw5hcOVTUnOJP8Uph+vGSsLxWp13xgE6/ybgTcxi13guTjfdnB4MiM9jr08SHY2P1uxAm4xRTnrVo3OMOKpQsLSfnQVJREb9OV4xSbh3I9qDZk2ok9AKSHa+sEGTy1cWDWSlSq556YIzUa8zQwoLn98D+VD9es5nPFH0lSxhtZEFu4ijFwE2avxkKVWogJsCLaM/VIkc0umMmUh6Nfnu0iImtp7daOJIFvmx52+Ivkl26jTNybCAcGpWLoooeuLPQTIGlqO2x+Epg==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB15735840E37F1D7DD0E191BCED2B0@BY2PR0301MB1573.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR0301MB1573;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1573;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(366004)(376002)(189003)(199004)(33896004)(6506007)(76176011)(25786009)(47776003)(186003)(50226002)(386003)(446003)(11346002)(81156014)(50466002)(16526019)(9686003)(7736002)(66066001)(8936002)(229853002)(81166006)(105586002)(55016002)(106356001)(52116002)(68736007)(26005)(6116002)(956004)(23726003)(476003)(8676002)(110136005)(230700001)(305945005)(86362001)(14444005)(7696005)(6246003)(316002)(5660300001)(478600001)(53936002)(3846002)(1076002)(2906002)(4326008)(486006)(72206003)(97736004)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1573;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1573;23:1VA91tuKhZwLlHJ90gq4vYKwYrEklfS9xSY6GPO?=
 =?us-ascii?Q?xGfE5b1QCfwjM6zgpJjyIMVrKar4p5DvnnbSwvizONbsakL8jHHlkMzsuAKl?=
 =?us-ascii?Q?b6owcH7VMT/tUTUpc96wxBXOy18a0tZZwdVeGOLpQ5IgsnUUVQ8vvxFEgnKp?=
 =?us-ascii?Q?9s8XrveMYfkSb8MiCPpACYVn5lJeyFRyNkS7D3hAoum09h3dETJxD9xvyr69?=
 =?us-ascii?Q?ds7Nk8U0mRZLxgJo/TukRq01NrK37YOMtmVpw9aCoeIneHL82vioDaX4+xM5?=
 =?us-ascii?Q?J8aXniSe4wqsJprCVgQVYsXVl+W8KCtV+t41iGG+Z25iZ14MhFsxARNTxTDf?=
 =?us-ascii?Q?QrT90Adygk8Jk/X1/+QOIRs/avlIk0uYcq/rRlCl8RLBMXRtm0ASavFvLZ7o?=
 =?us-ascii?Q?j03cpHeN5A+IwMQkImESggq58p2qXWbk5jf0vghvWUviWnUJS2Idj67GV9gB?=
 =?us-ascii?Q?Y0RS4hI0hLGqxgl/dxPlvazy+wwL4elD0WhS8ZoUjopYzexO2UaTnaiNLdDc?=
 =?us-ascii?Q?mRtGFjBssPzJRnRQWJPR5xu78u1PLWLiYRefIeolWknEcf2hTpPUZeMaBgf5?=
 =?us-ascii?Q?kPzpTxe6DhI7n9/8tH+/+rbh7146YbNiDPp+GO6/lNVoO9TA8FXfxGlIPWZl?=
 =?us-ascii?Q?0HUfXl6Wwse8Dzr2wm4mGYufL51axzLD+jUg9EwRkNPRwNWX31VK05gQwXJi?=
 =?us-ascii?Q?ddchnvLZLUQUQCQNfo2vgtUPIUi8jjI9cRrnyPJUIKicQ6+x7w4Lr/hXEpKe?=
 =?us-ascii?Q?PHhxqqdMyneTp6kFh0tinJlqjbiCYS2ksSRWOr5n7aybS7kyqoUq8i0B4BUv?=
 =?us-ascii?Q?N23FMrA5NEddGyJW8EKA6kkbH5g6d50xh9RAIjsQya2Iu1aE/ya9jqZjonUT?=
 =?us-ascii?Q?s0nbSntKP/bJuHUodIjksG0upK7WSjitjwiEXfap19U/P0JglayoX9JsKGfv?=
 =?us-ascii?Q?Yix/zy3erOsJcuUniqqsn6xUu8Lgz+/q+CfZyHbbikpXQdt+Me3JUeaOYvg4?=
 =?us-ascii?Q?bui02lhQaHs9s5eKslHrXekOKLtkKUi/VTJl/wFCRegrV9yHJEO2n173GtFw?=
 =?us-ascii?Q?90r1x+u7NoY/NQiueHhUCmxYZF8E54V/tntvSbAI/9bIEfzrLqfwzhgWmkiJ?=
 =?us-ascii?Q?eJmSxKHj98dD+6JkjJvJRXI1I9LVQSxR16VfBabI1PbQg/Z1pe7lsnwbAlBP?=
 =?us-ascii?Q?Z5QXyPdLKy+LCEav0GBsLGa0LZhmuIq1I5QdJN9kD13n8Q9EzlYvmGonBM/x?=
 =?us-ascii?Q?+jWaNzl7YNDReRNThCSJE46XEzP+PIW5tkNOe4N8wNEABeckLa6ym3F2H/k/?=
 =?us-ascii?Q?nGA=3D=3D?=
X-Microsoft-Antispam-Message-Info: zd5qDNBJfxU6KklXqO6HgFr21ELwsopkzOksBErbqN3KJerzZnMJ1BA9CtoYE7CYz3rgjNq5rcMvF0B7hgBQ9oSiCX3cKJo40USl1GwrRvL4GJOwN0PHiZg23m20YLZ9FjbaSWGwy6CuE3h/yZw0vSzaB41PBe/4cg95ramoH/5SnZ4WOQJ3RET03INuuv7o3Jg4N5NtluNS5c7TZgj2BtHoiy/vIHmvOY+E718ndkx4q2QBVrZcL/4PYhfryE8K8aP5krZ9b3FxzDNV7jSjHZdPf7j0Ge0aWUinHf3SSSPwCotfBipDLwQCq3ZGThBc6gG95kIcP9jitRfmNEQdwXWKv/Zivow5XdB4WI7ajdE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1573;6:OKJfVoPvfzaeNXTcRcuFlPhAMTA9noQZAFpAwjEMvDpjDvyGIzhwHSyuP+tIT5HAvjzS1iWPr7jMCiD8DwaKH4tJjzNG83zt+YxC2Fx1nLsJZ4zXLfJgZ3SyVCzXX95aNUBqeAUOLAtJumA0RoSDTrrF+kcBNw2xetApKP1VRD52oQE7fMMeGaNI9RKz2SX8GIc4avHYqElX0F6kAb+w+g8LflmZyJyZe9vIo1KLdfHRimhPlugMSdnXXqo1nKSVOYe+V2BxTmPHbEsqxPmDdR2eE0YWU+DDNazzj1Fb2NLCaGGNUyY+I942DcQrU/VkUw6szrAzBzmKMWZiJvCdaOk39TDLI27uQHM2rO/ud3pWW1N2AeqXpuZ89Em55PPcod2Ks9maFalC2la9SQuJnegu8CvhmXIRgqKpRyB7zmRsP6OP/9fXC3NXJrbuEU5k3g+itjjbkW7Iu/EIPvSNlQ==;5:xTPa0pXUw5sqDGOieQ/hLO0JMNU3ZozFqH3am3WSAxmwogzVzi9f/vMJi5xBFvY7Bme6SZfmGIoBs8hX+HxiP+++UNsoqcwvO6QVI/pQEwXcIuDEtA4WsdwsoJZypds3l+dgM5zuN7NCNk1k6GyLkKdZiA8H/R0p/E+2g0eIDYI=;7:eusF+DvtTFdpgAPlkI3bwPsyrTYWrtsEt9sEOur/oWgIpc/d2J9swW8hlY/x/ib4b31nXwbFea55ceN3umuVlNN8Dk8urlCh5r3ySrX2KYV2DnxB2bpt2Fga1WQfjHx3tSb2UzZ3bvP20uWbHcxok3w8WtiIBylCC0Q8O/01HBFs82l1/tTwQI5KN2XnVQilA6NzlKhG2WwEYrUki+iZRxU7I9K46zVqo0ijIFCWbnAPer5u/YUJQXgqw+7XCZaD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 03:37:27.6208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da58d06e-9012-4d93-0036-08d5f2a91cd1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 17:47:49 +0800 Jisheng Zhang wrote:

> When using DMA, if the DMA addr spans 128MB boundary, we have to split
> the DMA transfer into two so that each one doesn't exceed the boundary.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 1b7cd144fb01..01b5cb772554 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -13,16 +13,45 @@
>  
>  #include "sdhci-pltfm.h"
>  
> +#define BOUNDARY_OK(addr, len) \
> +	((addr | (SZ_128M - 1)) == ((addr + len) | (SZ_128M - 1)))

this should be
((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))

> +
>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
>  };
>  
> +/*
> + * if DMA addr spans 128MB boundary, we split the DMA transfer into two
> + * so that the DMA transfer doesn't exceed the boundary.
> + */
> +static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
> +					    void *desc, dma_addr_t addr,
> +					    int len, unsigned int cmd)
> +{
> +	int tmplen, offset;
> +
> +	if (BOUNDARY_OK(addr, len))
> +		return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +
> +	offset = addr & (SZ_128M - 1);
> +	tmplen = SZ_128M - offset;
> +	_sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> +
> +	addr += tmplen;
> +	len -= tmplen;
> +	desc += host->desc_sz;
> +	_sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +
> +	return host->desc_sz * 2;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
>  	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
>  	.reset			= sdhci_reset,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> @@ -36,12 +65,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct dwcmshc_priv *priv;
>  	int err;
> +	u32 extra;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
>  				sizeof(struct dwcmshc_priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> +	/*
> +	 * The DMA descriptor table number is calculated as the maximum
> +	 * number of segments times 2, to allow for an alignment
> +	 * descriptor for each segment, plus 1 for a nop end descriptor,
> +	 * plus extra number for cross 128M boundary handling.
> +	 */
> +	extra = totalram_pages / (SZ_128M / PAGE_SIZE) + 1;

will use DIV_ROUND_UP instead.

> +	if (extra > SDHCI_MAX_SEGS)
> +		extra = SDHCI_MAX_SEGS;
> +	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
> +
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
>  

