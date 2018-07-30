Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEB6C46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3094620892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="k17qR0Mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3094620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeG3EfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:35:10 -0400
Received: from mail-bn3nam01on0060.outbound.protection.outlook.com ([104.47.33.60]:3768
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbeG3EfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqODxSvCxp6OypKADJ4tK4n38xgRhLNsiHX0CUOsLj0=;
 b=k17qR0Mf3xWfUHomnXV68esjm8NDkD9Af6UGNkXhLA/AEWbpGzmcAdKr8Ci247yLMYsdo7Q6c6Mm6pmBqTfUyuhqTsX2gdjc0MOPgcHuAd/Oa/bHVG7OQX666y5GOZvM/fBfk9a92QhEs10Yt6DsWfmYThkE2C45OWPdnpNIbKc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1569.namprd03.prod.outlook.com (2a01:111:e400:52a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.18; Mon, 30 Jul
 2018 03:02:15 +0000
Date:   Mon, 30 Jul 2018 10:59:54 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Matthew Leon <matthewleon@linux.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH mmc-next v3 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Message-ID: <20180730105954.6c365a7b@xhacker.debian>
In-Reply-To: <01010164e91d7bda-aa616cbf-7bb2-4fe4-85e5-a18e16433fde-000000@us-west-2.amazonses.com>
References: <20180730104228.28b58bd0@xhacker.debian>
        <20180730104636.1a3e6c81@xhacker.debian>
        <01010164e91d7bda-aa616cbf-7bb2-4fe4-85e5-a18e16433fde-000000@us-west-2.amazonses.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::23) To BLUPR0301MB1569.namprd03.prod.outlook.com
 (2a01:111:e400:52a9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e18babfe-5e2a-458d-e82a-08d5f5c8dbeb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1569;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;3:lB497oJDkjbr0jq641ADuznNuSmKRzWbX7eS1j4TSdCComuAaotrtYKTg4ztMBWuj9FnnTIhMADiNePZtpUIYWv0tkrmqlr/Y2VSyV8fKfGMc7p4Ri3H6fvpwGRfOnUVGgmvLXq5zgFAh1ZoODNvTeypnzbncb8d//I3SUQ3hcfzwn3h8mnSShIInizp5tgQoWOahy730/FrXwbK9vGnvUMO7A/DHk9/XTV6Z6hczBD4abrvMUJorgzIIYTL3Hub;25:pOOLhm2OWJjYp2A21iPREczsZAIllr94uVZC4eN/3RkCaIHyob0vHRR0yYX9ImL7O8mmf+vRajmrtx0htnlA4lw1vcsHXE+8kw33Pkr62MeZRTOcKzLBf3SmMRxkXRBybafE9vPg1yWmB8kkwhS7/WPJYK9Rj+eeUFVKdd/XQjTmm9cDcTbuLvgnepRiQpG3XuwD5YtzQNeCzfjrZFm4x3SmVYiz+D3VhT+1L8HguXobhUb4WlcWqa5l1bHzVnFCuhjWCrzioo7wlgePjbdXIoNQZjp27+9QenwBJ5UnOTJFZ4eCSG8+eLRvY1OzQUiaMkwS/spWLXNC+z1JzdMJFQ==;31:2X4agZ9tlKy57n8Gh4vc+FEqo5miD/KAYWwolAoD8hQr2oR37k+RqDWCrkDH3c180Pl+0MJ5b/t7SAbsQhx0OtFp0sbhJ2XiCEwDz3eDpH+4R/nCBZVEfgFJrYpjJOKGBP0shUP7AWw2GpS9rW0GsoIY4vkO1nyyaqMXVRL9mXPCtwflvFFTMFVQDZqOTmwnYTKfhFG2/3mgm3XJAgw3ke+DEnNcB5nPnOHwJpWAyDU=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1569:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;20:4KLgtecgZOm4juYqRoKZMvByRtRgr6vAFMFzf6y7SFxU+u8BMb2bUuogZoysA20+wTMFG8alnULTzvLKm9b0cdROj0zYpXW1LUwtRMm6+pRNaRC6YKT6O0adVdogzCnA4CyMHjvcHyrLOoan3f0Eddy7n6eRwWUxmJM8zaHZsGoKDCwr8uoySp2wzgOFigDsR1VdKgF6j4Ssayae4VIW5KHuT5vaWvgvFpNeKj9V8VcIWjrD5nrJriGezLVGp6/sS3zE6onTWsdkNRvJGSNiweZzv4MDhYUwNGcl7zTckIfqdY5im5O7TvbTJf/w5COnCtvHMiquqqx9y9pNxWyMj07VRMnS4MSc9vjFHf5gAuJTMw6IszRpPLCmCjWT1ZQWP0omEFyslPy0MZIaerSnq8BVUykUbu10enaBbaAfO5prRWRzfIv7gq4gOVmO8Jk8PTuQ23r6mIOmKHuE4ck4h5du9WipKIgwbDBO7qmHunmduES+4z6MPusGM5OWGXw/;4:2ZIp2l37vLQAVdyjuJAGsf3Qy73HWCUphe5BnaUNggA8F0NSq5UdKd7ScHz9lvu0BijfvpvrU8IM0CqZrCSl6fZxUzx0kfEcimEJt3wkywcrXlFwS1tGALAmMFq4bQg7O7upNP4UmqyoGeX0KFsS9xrbnBcyFEopv/6fBNQS8PVAvC5guqn7tyLergrvT8p0J1HKUTrisE3Zas/Tg6FVlx584k6XUICX0OqHYUpbTrub2qqrRGhti22jwRhilnpV/TTn90/kq15bVT69do8AXQ==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB1569BF995DDB42E40A01DD68ED2F0@BLUPR0301MB1569.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1569;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1569;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39850400004)(189003)(199004)(6666003)(11346002)(305945005)(316002)(26005)(50226002)(1076002)(47776003)(55016002)(6916009)(9686003)(53936002)(50466002)(8676002)(186003)(486006)(81156014)(16526019)(446003)(81166006)(72206003)(8936002)(230700001)(956004)(7736002)(476003)(68736007)(386003)(23726003)(66066001)(6116002)(106356001)(3846002)(105586002)(97736004)(229853002)(14444005)(478600001)(76176011)(52116002)(2906002)(7696005)(33896004)(6506007)(53546011)(25786009)(54906003)(4326008)(6246003)(86362001)(5660300001)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1569;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1569;23:N+j7Q62RaPNw7bqzEZeizc686TpzHn89ikj2PGe?=
 =?us-ascii?Q?wZDYPhNZ79choaGwcSrPawkWzxmz4qanrxpHO0kQBWrOW1eGGJuW3Hst0vtI?=
 =?us-ascii?Q?E8Yu27RrJkoqOg5LLDvk9mEeUyj6SxkfQWF2Og0/fEpabe7bk78D0lM8PFBG?=
 =?us-ascii?Q?q7qad1GlYxmNTrQ5e5PspziwLAnN/c4qbndEWG6aQnxYN3i67DRnbfu3X/Vj?=
 =?us-ascii?Q?llmNTVjbJEqI5b5nfGT0TeTLT6kmITNdnGjR23vPo+0WzACQz0xD5uXNRZSV?=
 =?us-ascii?Q?c/LIOytF4AF0ZvXacUixZzsoaea7QKhFVLUKjch8D70dEf6mqLskCqAhhwfc?=
 =?us-ascii?Q?w/g1yAQx32S6toJj0IR5wfjfYVQv+E34TTGrsKvmR35BCsNIL3Bju2QF9fnG?=
 =?us-ascii?Q?1f0L3y+MHx9aU6NzxkMoUZMMeWcMA72n6Q6nCTKizm+Efxd9wuPRtQwpU9JB?=
 =?us-ascii?Q?wbq4TCZt5auAjazhaduuQy9GR8tbOIDrF/iCPgsVXSRb7ecueotwpuigyJiM?=
 =?us-ascii?Q?VJRA5QK3T+Nh7i2fJuiQG9qPrwikHmfSXeiSvYqN4GkMiI0FyUpCUrmr6w20?=
 =?us-ascii?Q?TsRhnnadfZB4C+5F49RBHgbB2DponHmuakaKxAYEPvSOFGpCz0oL4Bjx9gnG?=
 =?us-ascii?Q?qesiD2V5l6QfwOZfsAfnhkhvSiQmHI/adDLBzVkuIwvZjU1tCVCVoGG8UdBO?=
 =?us-ascii?Q?5aK4rM5/WikJHhRpxs2vOZcO33Gbi17AhfLUjcdAiWvR2UqHNlqDt1LQSB89?=
 =?us-ascii?Q?rlI4ZetteHhIYOPQWdnRFUpYAKarY1vQpyo8Gvq8A5ut0OT+nz7adqvR2B4p?=
 =?us-ascii?Q?+bstl9QUdzSUNt+86YLo8cRhTL5bx1mTz8Ws6wUOdB9lMIM5/EJ3fqi5WeYa?=
 =?us-ascii?Q?EllVx4z4qM5q81dUNC7wLkGZWFid8LTdDetRWJVKRK/sLJdtBsXANuJefM90?=
 =?us-ascii?Q?cGbA254PbUhBY5dXR00WJBplnTgsciOGPOOpEMpuV/5xowO6YLIt8wKrGoao?=
 =?us-ascii?Q?LSiTa9uHJ+Ks16NsEbuCdt4wQvqnwMLbVebMXH/Eg8RWGk73Yejtu2k/TRZa?=
 =?us-ascii?Q?pdz34w8c/SqKQ6iUmw5PhQHHnCi7BEFidREHMrGhAyIbPmy3YQBPMZz1c5Mu?=
 =?us-ascii?Q?kbzvYHzp/EA7/L2umFn5NrcCUtDAxLh0ZTT9tw2+dUjTz1ZnjMtvBzhshpy0?=
 =?us-ascii?Q?L36uvB8O8nJzOfmSvBUEBPvJqxidFjpnvUiIvWsca+c+uDnDrWlH1fVZre7Q?=
 =?us-ascii?Q?PpAkwXUixhVIdctunw4nKOHZPN6NfUwT1kS2+nedP4Vi7THtSgrHmszTmdiP?=
 =?us-ascii?Q?Sp2Ocx+27qSLaBgu4EHFh5bUoafUu7BLJQaDNw/9RJz4r?=
X-Microsoft-Antispam-Message-Info: ywk+o4c0hj7LzG/0o4UyfFQf64OOPYdJXSiQKQpEdzpHq0vGW0ID6aI/WrmuiJ5vVJCK+wD2064qZ5O5S6c8fazGdLqoDyX1vxT5HSLQA9ScDWFzZfylvPXNFDlfuKbyUhS7Jo4mAx2ck+iEzf5LDsgWaotXFZRdDS/RpFgwVkV9jvsWSASM1AJMAETlPqoHzC4DFCldoX6a5OQtJlJnmotzy3ePP9f0ze81A63J2noAxJt48DmLW5888SK6pArfVjeHdBWu2foxmuu0THZTVgUhwiD44LSSLRwJo93YTKLrZtRRF2Buzx24TOp0637z/LF6GVWrDMO/eR9tnxgnZ2Whe/4uOk7L81j8AGEwl6o=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1569;6:1eiQ539Eye6iuBq0TmS1VDK9RaDVSs5wP9kBVLoE7bugxVYL+iU54109bfMx0BogAZBI0E90h+oaN4KVwpPe9bnu2K2WnkEo4oh9+qElH4M0fDWHIxAuMzwEON/4cA740PK8DyGFWSLi6u1c7MyultRsIzFCR7qobfPD8izecXdRoCa1vsuLCZJV/J8wYUY3o18nqdYR55/AxNcqWmYpqHM6VMyjLyINFwe2hx+twNDomCzAXinWLkeJngQp8a64MZRKrTR1E0/GlcXrcCEc1opKpwCAm4QQPR5Ali+rxWp2UbutBjekYBKjn1h+rNJLbFLmwDmwnvyKHzXcG0Hw3dn4x+Q2aeo+bmqgdspE3B4U0jrzX5qcp6sinf1Iu9n0FvEaG0YnrJMdek8TMhQdVkrjPMJl0Rf6yrb0HiLCk6xuZsZETkTa9DLQawTfuCy9+cO3Ko4FRgHUenE+Q5/7yQ==;5:M4DxMoM6wmHxBlxHKi6u5L32zKmVBX4FD8ONYcb6tdCaTqjBg+TinaBzHlDlJRDjBaVW0yz86NBEljFkx972RnrwxEKTWPBNN6/HHGuzOAMQlTBEwkrt+k2B8igVmfLlJZIkeY/1M740kC7mjKoRlJFNZpmXxpd098vqgXnKGqY=;7:H9Ofo6lHmBuQT4xMjsrlkqeq3MmwZydJ8zbqIv+RgxVt9K9zM5ZZZqPZHPQSeAMUL4jexRQlOsa4F7u8DlrkBqcUBizqUMq9joaH+nqUMJzBDYTiVjZMxaepCb7Gr68X9M2JQ1A8vfewmNxYmNWI4GNx49KlLdyFDVHYXsw416Q3UpA/mCzOzQFVAeLI0hVkm6LSg/qo5A2eaSktunTSGS+oRpVdYbcqrlwTlFybEXwqUclew+0C2aYm4utqQ6dD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 03:02:15.6121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e18babfe-5e2a-458d-e82a-08d5f5c8dbeb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 02:56:20 +0000 Matthew Leon <matthewleon@linux.com> wrote:

> Hey Jisheng,

Hi,

> 

In LKML, we'd better not top post.

> Shouldn't we be splitting until all DMA blocks are less than 128M boundary?
> I am a noob, but I think we should be prepared for boundaries that when
> split in two, will still be greater than 128M. Feel free to disagree but
> please explain why I may be wrong. Thank-you.

the limitation is "DMA addr can't span 128MB boundary" rather than "must be
less than 128MB", they are different.

And the max transfer size of one DMA desc is 64KB.

thanks

> 
> Sincerely,
> Matthew Leon
> 
> On Sun, Jul 29, 2018 at 10:46 PM, Jisheng Zhang <Jisheng.Zhang@synaptics.com
> > wrote:  
> 
> > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > the DMA transfer into two so that each one doesn't exceed the boundary.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 43 +++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 1b7cd144fb01..e890fc8f5284 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -8,21 +8,52 @@
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
> > +       ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> > +
> >  struct dwcmshc_priv {
> >         struct clk      *bus_clk;
> >  };
> >
> > +/*
> > + * if DMA addr spans 128MB boundary, we split the DMA transfer into two
> > + * so that the DMA transfer doesn't exceed the boundary.
> > + */
> > +static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
> > +                                           void *desc, dma_addr_t addr,
> > +                                           int len, unsigned int cmd)
> > +{
> > +       int tmplen, offset;
> > +
> > +       if (likely(!len || BOUNDARY_OK(addr, len)))
> > +               return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +
> > +       offset = addr & (SZ_128M - 1);
> > +       tmplen = SZ_128M - offset;
> > +       _sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> > +
> > +       addr += tmplen;
> > +       len -= tmplen;
> > +       desc += host->desc_sz;
> > +       _sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +
> > +       return host->desc_sz * 2;
> > +}
> > +
> >  static const struct sdhci_ops sdhci_dwcmshc_ops = {
> >         .set_clock              = sdhci_set_clock,
> >         .set_bus_width          = sdhci_set_bus_width,
> >         .set_uhs_signaling      = sdhci_set_uhs_signaling,
> >         .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> >         .reset                  = sdhci_reset,
> > +       .adma_write_desc        = dwcmshc_adma_write_desc,
> >  };
> >
> >  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> > @@ -36,12 +67,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >         struct sdhci_host *host;
> >         struct dwcmshc_priv *priv;
> >         int err;
> > +       u32 extra;
> >
> >         host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> >                                 sizeof(struct dwcmshc_priv));
> >         if (IS_ERR(host))
> >                 return PTR_ERR(host);
> >
> > +       /*
> > +        * The DMA descriptor table number is calculated as the maximum
> > +        * number of segments times 2, to allow for an alignment
> > +        * descriptor for each segment, plus 1 for a nop end descriptor,
> > +        * plus extra number for cross 128M boundary handling.
> > +        */
> > +       extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
> > +       if (extra > SDHCI_MAX_SEGS)
> > +               extra = SDHCI_MAX_SEGS;
> > +       host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
> > +
> >         pltfm_host = sdhci_priv(host);
> >         priv = sdhci_pltfm_priv(pltfm_host);
> >
> > --
> > 2.18.0
> >
> >  

