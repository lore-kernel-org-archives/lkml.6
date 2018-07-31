Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5386FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9FC2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="S87NHGp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9FC2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeGaFKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:10:16 -0400
Received: from mail-eopbgr730051.outbound.protection.outlook.com ([40.107.73.51]:35968
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbeGaFKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti7gZNL1dzo2d3AaBNzOC+7zVotVGooMXIavdR4GORU=;
 b=S87NHGp+bdJvfmDHdNy6QL2sGTo2sCUEU+97hxqg7WJvbdY968xrFK7G3BxGbPj0L6vzxmxVc+oymV3d3xopk79YT/Ahq/LRs7SkLFz91BsnNNLUSWFyRWKiQuwZyGpTvc83abqjcc1wBdz2bRy3hBvJmnjjwkQrnt/r1XOn8Og=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1584.namprd03.prod.outlook.com (2a01:111:e400:5232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Tue, 31 Jul
 2018 03:31:59 +0000
Date:   Tue, 31 Jul 2018 11:29:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH mmc-next v2 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Message-ID: <20180731112924.6a1e8388@xhacker.debian>
In-Reply-To: <edaa7605-e0e0-b17a-8403-c3d7d60d7989@arm.com>
References: <20180726151017.4da1e336@xhacker.debian>
        <20180726151424.4bcecf41@xhacker.debian>
        <edaa7605-e0e0-b17a-8403-c3d7d60d7989@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::25) To SN1PR0301MB1584.namprd03.prod.outlook.com
 (2a01:111:e400:5232::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4172da32-2722-4a2c-4e97-08d5f6962dbe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1584;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;3:I4fKLy/dnlz1NZ1o3btGVRl3kNf6K8RRkrtPb54JhFGmfe0r4RjbfGIZlqOYNP1XVrIACfPjlWNKlXp0Dj8hI+G95Fy98S/lYX0iXJKjLifASSe9b8bjtkDOe0cyXzRdD0514bCPFCritbhzRzUY8juv7ODCXk+F/HNr+OWnW9KXL97S7LH4MkRmuBzu1+mrdOyjyeyoRl3K4OCxXF9fgikxAmzNeMay7E6QBQ1hLC0/8c/Xq3dhNxtvIxlccxZx;25:V3oU5llvxp7orKMd3KU+kEadkVHKN2nBoKi1zMGKTeIuSHDfoWzKkI5EB9fN4UReZYVSQfVbKWQaezyoWjl3B0PXFwdAIa0rAmlhiRG2Iz5b7V9dbqldUvNVGnLy3lx/wYV/ZjU/bhHK1r9+XcbNYn6MY9Ibbp0iJS2fvN1PXUD0+38xGIbqxnacLgP12+j0Q6vfNzkyrD7yllUpGqhvJcwzOq/pclfNUuXmC+BvcevCFDkizsQBvy2jEmUkdPc2B+2dW5fU3UQXOxC4VeZ9Mf2zuDfgvSIZwzsPK6vWGReCpmW/ZdJZa1FkHOrSR8sh9YCgDdtkpM28u73oII4AuA==;31:A7i+hwthlNKSlmSFCEXk5eYaB1g3yu4SUeIg8IJtzHrFIN2WNJDcfHWVd9iC/0qLUVIBcBKyxKw0t7+82Z5yoKODGfCG8vXHUK+th8kDBGT1XHKaEj07oC2ydIn3qX3Rfx8SHX/mU86dwT+XTZI1UaXCgYU9kkSQuGQfD/mZxkAyo3EvFn/Swz2XvOZvZdeGjWyOg7BpaYdPjDWXIcTPJm9FXM+UFOcAMPhmysWjUGE=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1584:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;20:5Vo27ftRtbRP3FTcLI8k/9u9hzh9rLAyB3ZTurlibTQo18b/plM63vqTUmFcYVDZSnb9wc6VgzmfSo6ZAL/DQMN3scB99CeixOw8IzqteOLucg9MlrKFPLd+gvKDJCHDDMbeRVfV0qojw6SbkvmGGLaVxtcWBWgE/nR1sRs3P7LQfIV4mLEusmbNowdItXAIU1Zio79nEaRDo+i4uXrCWq5N0cJTKsds2HUa+czZIPYavTXsWLfnmy9yqov7WBI6zmQOm2nTVUqynx1CnXd9WpdGBpijlDZfruEl0gRa+TyrdlbxnTazqQkJPb4k4fvuzLgNQJ+MAhEjLxKRYDnqE/wcnYPBJP/XCPR6TWtRUWYGRmqxh57NL0ZHjf4xe8Ga3u+BJ+10869tVZoVkom4qTmkxDm9f4fbB/yx8ftGcatYFIrcSrUcQrV3KN2i261Jx6asVDB4hh/uLPNpGNJm+kkBNL6FFORN/qu7HxZb0/02HEzJ9CMzCB/hutR05pGV;4:nTYzxYvZDPDXdvFTf80jq5UJMQd65Cj/S0wxnBQwGD6XZ2iuieyQ2v/VLvScGu0GIFUJP5ler71takmhMVpeC5cxtOtV5PJNxEhvBBafAjNUEUxBKHzGbYudgtpTfzUCORJ6YTqdKeCq8wPChVNq3WzxvZgGZlHXaOlE+h/Xe3A3+Kdk+X8xjFUX9ZiNMiLwC9G/2IBULhoDMsSQiGBvo/wBrolXtmsjxWXOIi2ydahuEiyzi74sszHPOSlglvKXQp/d0UYogAHvrFON66qmiA==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1584D716DDB3F3CF982E29D5ED2E0@SN1PR0301MB1584.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR0301MB1584;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1584;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(396003)(366004)(376002)(51914003)(189003)(199004)(105586002)(23726003)(106356001)(3846002)(8936002)(230700001)(6666003)(53546011)(386003)(6506007)(52116002)(6916009)(68736007)(6116002)(186003)(81166006)(26005)(16526019)(2906002)(7696005)(81156014)(8676002)(53936002)(1076002)(478600001)(76176011)(4326008)(72206003)(50226002)(7736002)(97736004)(33896004)(47776003)(25786009)(6246003)(11346002)(316002)(956004)(476003)(305945005)(5660300001)(54906003)(486006)(50466002)(229853002)(446003)(66066001)(55016002)(14444005)(9686003)(86362001)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1584;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1584;23:T/sed5Sukxk5nZueX6WeQg8MkUS96QWduP6S6Jf?=
 =?us-ascii?Q?0IapeUtf/c8JkAztYUVwmv6bP+xbYKW+I0LGj/Z2gqG85IIbqCwJX1uTc7B1?=
 =?us-ascii?Q?eqGxruraZAjeZDLnUe4W5HdlZNoA9gkkCO1/i8ic0USfBdDxGrM/e0nmCKBg?=
 =?us-ascii?Q?GBpDKfxDi9fUmmrGqN3/4WQEDefaQixgsye8sMCObT8SdP1OIsBN9DPrAojV?=
 =?us-ascii?Q?KKjCTNJfOzVpRiePJxNTab9pX0pgj3Dc5XVzrQDVCdxVy+QC9EdXiqZVnTO0?=
 =?us-ascii?Q?jCQVySa2YXNXXdj2wOtbG/SB9cyz6NBY9MzJ6SE7q7Vo0bmWQbPjURjZutij?=
 =?us-ascii?Q?EAluCnGmgQpj+c4Sfh4jVhby5kyf0o62kL8kIHebhY7jotkd+V6pjVcjz+Ti?=
 =?us-ascii?Q?Xps7BuDNXrutYUMGUwqQ7JTRxaAGhO210gpTiT3d0KsNDPpcMxd9UuhpaRWC?=
 =?us-ascii?Q?/EyDRx2AGZXz2Ig9vVkFFTbpdeULJSK6OiPif1ENp6XIaVb7dLEAK+O4ne5N?=
 =?us-ascii?Q?a0q7BBM2UIj2wONGkITgLOuu407FrBCn9Wl0I3jPtPpzU2rMN4/t3HlsduXM?=
 =?us-ascii?Q?eoRUAXPkl1jPxwy2mOL6UQNx+prPPWIErUTOnL7W5uekK9i5nRPXVI4aVlo6?=
 =?us-ascii?Q?z6Jhgid3kv1xZsUa/ex+bFSPi15RNbWYaUrtDzd/t8Q+YD8HrPw3/kgGcSDB?=
 =?us-ascii?Q?avdFWps2helOwpKEoxcuaVGrA6pPac/LO91xBP9tjgFW73ylBnUZGmJVrvob?=
 =?us-ascii?Q?zvH+4cvyy9lJhU2z4LhdTEQwFdJyBENgWkxwyS6JcwsTRZzvmFdFhAR4U9+0?=
 =?us-ascii?Q?wa3ExCm+jccEVspocoUPkDeiPDg45JD4J98hiNZ8UozttGbYJJMPSdkaPwyz?=
 =?us-ascii?Q?vrEsWOUQvmMfxlFEmy/VDIc+SgACh15ihL/ll64tewasGsz7F7cx7wVrgGDO?=
 =?us-ascii?Q?biS4zZTfjPepK2sDAjyZ/e28zWhH6tfgLxPbIqB3045Ycwiwh5A7duSm7DYM?=
 =?us-ascii?Q?k6oufyRUTjVLU6jDSoDsO8wBdNp1QpYQ+JCE7B8UIlwZUs+X/L8hgbNDlvwE?=
 =?us-ascii?Q?2gbMm3UwCI4gFAklGLUrf9YdQa60gCzw+hkNv56iTn1AcopOt5Zymig7i6vt?=
 =?us-ascii?Q?7Jl23JOwu2gPTabvICgJ3Bd1BrdlwmUU/nmtttg1kOEg01uSAFq+AXtHTCjZ?=
 =?us-ascii?Q?cpOOsW/LTUs/Y4Hy4n9CXtKS1FoAocKBX3hetBrbqeqOQJgjPfXbySnMGyFJ?=
 =?us-ascii?Q?u42LCln5hP5tMMlTFEI/uERVC7B/XS1w5amsx8RKCDMjYbknC3q0FSbgZr1a?=
 =?us-ascii?Q?wAL8469vMaWEAWDBww387mbH8EPdrYtLjeklSOdZqCDNhU8MgR/gP80DtBaS?=
 =?us-ascii?Q?9Gah4dg=3D=3D?=
X-Microsoft-Antispam-Message-Info: UwwAWHc16/zdBfOTIVwCzcPkzPGSDRvhNppa6hDjuMdPiKaL1b6Hb7Mw0FauAmaCfL3mcpFreAeNkdhPsoBADol73km+IRlHSLAc4ncWGr6S5M+x27Xz/cqDksvTYha6DbhgPvdhheaOEvC7Wa8sgNES67f00q1v6wIV7sYyPDSu+79PnZAsCnil9Xgky8Dsu9eYyXtWIign87rGmQuMuVPee3EN9PuDIQikIgPJpApzoh8/nKR96/Xiz0hmFvVn8vxfprYYww5Uz6tMaCoIUWPtl30C9QTrkZ5yItCQt0z2eO4L7yAf3OKsPhV+vH00NsJrYozi4YYfNX3Tcv7yn9/jcrUYrcX0Eof1pmwHZkE=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1584;6:BPxwCgGnEnGx3ABmmzB2Tw/Vk9k7ApsJYaPn1Ko2OLekEL7t1/FS7pikyqYynMHLP0hc+iUyVdfGiaWt/HPzNzTeVfnnmg9NxBUP5ywaeEer7mU4HNprgI3gz0oIOB6pltl9WfJxM85KwHJzivK24/IhkcFgIV1ORpVRLqvfUyzNDA54a1ljaVPAFtTPf3f5Ver4hTnvfiQWGZp616GtWME0Ko2WVezH8n/Vr/cB9NKkyqlFQ/UaOMarlCIhAczqxHWsL9NIh2T2YrhzVZ/ql+uAjA0ltgL7I1ZX54pyElQ7DGaTsgUoel9jHTgm+Z3lZKnwub1XyL/b/MV+eVW9Am+Dw6T1Fw5ocwiyOmmceej3SHXd94MMFvTXQdZ3WjzSf1FWWoXnQ8Dr5hqpsSmn6loZvy3u8AtJwV3duKlK0XrKm6rtPGQL+IYUuzJK7BChaaa/nkYj7cfapX4+26TlFg==;5:9iDxt0RFw9Z1EkbbmA4tlgyajJuK0ikbLY7h1xYRnQ82EGyAQy9kfIWXAwmDBg5miTjU52NO+1V9iXNgqUVUm9zIVKQM3OouNcvcmF58+7f5Q7NwPfhN1zxjUNKNUS9oZrwXEMKE7Vqh9oH1onievJoF54aSaU/1WZhg1utzQgw=;7:c7I10BS5TBYPkAeFez0S+SMdGJYnFTfYMrvXkMQ+g6HpYJEpws/U572Iow7s1o1rSSncf2UwcZTip0FB3KLIbRj7QoJxx7Gl5DYeKXPgHAswie8q7rkFvrRVQeQUoDMB/1zNIuTg8vHnv1ws44Qly0cHa1xhMvFo66w1NMZKxmBODi3nlml1GGttt2u8dFm/B1zf1X9ZwxW2/LP65UjXUjpKM0BjbyiLNXZeIC5kVRoOoNQ5qNFoKxdiDnNqQH9c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 03:31:59.9623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4172da32-2722-4a2c-4e97-08d5f6962dbe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, 30 Jul 2018 12:06:08 +0100 Robin Murphy wrote:

> Hi Jisheng,
> 
> On 26/07/18 08:14, Jisheng Zhang wrote:
> > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > the DMA transfer into two so that each one doesn't exceed the boundary.  
> 
> Out of interest, is the driver already setting its segment boundary mask 
> appropriately? This sounds like the exact kind of hardware restriction 
> that dma_parms is intended to describe, which scatterlist-generating 
> code is *supposed* to already respect.

Thanks for the nice input. It may provide an elegant solution for this
limitation. 

To simplify the situation, let's assume no iommu, only swiotlb. And
the DDR is less than 4GB so swiotlb on arm64 doesn't init.

There's no dma range limitation with the HW, the only limitation
is boundary, while dma_capable() doesn't check the boundary mask, so if
we taking this solution, we need to teach dma_capable() about the boundary
mask, I'm not sure whether this is acceptable.

Another problem is swiotlb initialization. When to init swiotlb, we dunno
there's such boundary limitation HW. Is there any elegant solution for
this problem?

Thanks

> 
> Robin.
> 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >   drivers/mmc/host/sdhci-of-dwcmshc.c | 42 +++++++++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 1b7cd144fb01..7e189514bc83 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -8,21 +8,51 @@
> >    */
> >   
> >   #include <linux/clk.h>
> > +#include <linux/mm.h>
> >   #include <linux/module.h>
> >   #include <linux/of.h>
> >   
> >   #include "sdhci-pltfm.h"
> >   
> > +#define BOUNDARY_OK(addr, len) \
> > +	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> > +
> >   struct dwcmshc_priv {
> >   	struct clk	*bus_clk;
> >   };
> >   
> > +/*
> > + * if DMA addr spans 128MB boundary, we split the DMA transfer into two
> > + * so that the DMA transfer doesn't exceed the boundary.
> > + */
> > +static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
> > +					    void *desc, dma_addr_t addr,
> > +					    int len, unsigned int cmd)
> > +{
> > +	int tmplen, offset;
> > +
> > +	if (BOUNDARY_OK(addr, len) || !len)
> > +		return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +
> > +	offset = addr & (SZ_128M - 1);
> > +	tmplen = SZ_128M - offset;
> > +	_sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> > +
> > +	addr += tmplen;
> > +	len -= tmplen;
> > +	desc += host->desc_sz;
> > +	_sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +
> > +	return host->desc_sz * 2;
> > +}
> > +
> >   static const struct sdhci_ops sdhci_dwcmshc_ops = {
> >   	.set_clock		= sdhci_set_clock,
> >   	.set_bus_width		= sdhci_set_bus_width,
> >   	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> >   	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> >   	.reset			= sdhci_reset,
> > +	.adma_write_desc	= dwcmshc_adma_write_desc,
> >   };
> >   
> >   static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> > @@ -36,12 +66,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >   	struct sdhci_host *host;
> >   	struct dwcmshc_priv *priv;
> >   	int err;
> > +	u32 extra;
> >   
> >   	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> >   				sizeof(struct dwcmshc_priv));
> >   	if (IS_ERR(host))
> >   		return PTR_ERR(host);
> >   
> > +	/*
> > +	 * The DMA descriptor table number is calculated as the maximum
> > +	 * number of segments times 2, to allow for an alignment
> > +	 * descriptor for each segment, plus 1 for a nop end descriptor,
> > +	 * plus extra number for cross 128M boundary handling.
> > +	 */
> > +	extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
> > +	if (extra > SDHCI_MAX_SEGS)
> > +		extra = SDHCI_MAX_SEGS;
> > +	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
> > +
> >   	pltfm_host = sdhci_priv(host);
> >   	priv = sdhci_pltfm_priv(pltfm_host);
> >   
> >   

