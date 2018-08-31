Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40D6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B88020845
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="QZGMewEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B88020845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeIAAVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:21:05 -0400
Received: from mail-cys01nam02on0133.outbound.protection.outlook.com ([104.47.37.133]:31648
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727281AbeIAAVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ4RrIHgbxnePD2AJuVmNdHU3cRAMelTuiz/bLEblaY=;
 b=QZGMewEQrR23Cvr3vy6YM20eJ+z91tkmUKE04PZ7ftYw2Ok4Xa9BCKgG/ZcY+GmOt8oiIrwzB08GnXCRGFjke/32S8n7JMCIwf96hgeBdszMxh2b/OpTNGiXo7MkhZc+9351YG7OfsLU/ej4SresKb2P4e8dAqBBBBWGuBTtogo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Fri, 31 Aug 2018 20:11:58 +0000
Date:   Fri, 31 Aug 2018 13:11:55 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Message-ID: <20180831201155.vqhrmn5fdlqv3fpr@pburton-laptop>
References: <20180827145032.9522-1-hch@lst.de>
 <20180827145032.9522-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827145032.9522-3-hch@lst.de>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:3:c0::23) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d1059f-9ddd-4227-7172-08d60f7e016b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:Kav8+lA9d0wJ65W4WfcI5oIJbeftJ2ViboY+AXseOkZiojTOS+TmC5V8GkbWGlsXNxIGQMtGFsfSiXftluOJlXaPsMy06Guj3sqU/H4OaGAQXqgxxKsaAWCDgbuUoT2xKzuMdSZCI28IR4nx9wpDZIKh8Z4grXZcMbXjIPDPwBUevtkqydZEQP2vd7eoOQTVtuVnvsqx6TCdfaIi12QMUdY7yWb+/74Xw/OY/py4lXhqmnUXW2IkxD4pr7XbP9r9;25:RMT6pdQPlnzz6UBHIEoM3X63PjMNUvN5vPtl7jeh5GxianJmUK5xtAjKJxicx6xbuvRCEnkMd6HzNARMjGOdlPZ6Wli6rWyO3WoukHzNdY2IsGgakU0ftMMPMRZJjJLU+saanIwCZVHV2r7fqfTQ1Bxc/a0I92EpFm+mLTv8Oen7r7SUQ3VhiaV3KLv2efaUjRSkZF/j3eVH16SbVK012A46ORLdjecG0lvwIYjvHFnIj5yq60ur559yskU+kLFM9DKCojvnY9kXaMmMYkh+s+RxrYv2fq3VhZ3puUYspJJgt0YXDJUbnhbG7n99lvmm9hImUPwx9T3gc2KswunUZw==;31:DEMg+3/kM/2A4IluAHvg1PjE6TRcHXZferskoXgQqd3XTzbfkMNoRI/0XJisPgl+fy+jhi/h5jgpNat9kcYQBGByGJkzq+EORu+Az3LprUN7VcJFN5z/sL10R9IAnygHFrkylqj0b4dNsvwlxT4rNs67lpV012G2tTea3Wc5L4k4ut7LrIT31Wb7BqC9mtTOp5LRHbwsyDlZzj9+I+mQAzxyjM9kHAQAHQs/6xOXcNM=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:AypoGAYr1wpnlZqf9ujYd4WxIfpkJTQQbfm2nfqfEwJI+ZJoAkvGgJrDgp7jhjvwMKXv3XEocU9E3Jcc3pRy7d9xF5s63WtchDPRbI601xWGk7vcVcaCUkoUPKiV8B4wioYfUnH/+i27oQtjaQAL3eamXuelY2CyjuAdGA85qk9b9TCEx+cFhuzithF4NqQAQ8MMwtWr9FFTmvrVU7oW2pohrXpj38hLIkIk5b40ZeoC7QQ9TttHXUiWpICRo0a2;4:kY6FB+fjJBYAhTEq1dOECPgf1IZ+/shEyWfLZNjlUdgIAemXiIa0+W7aNFWVqFdDsl9QTT+8yX1wuw8diPBzCanMIRaDpUjkj40qWO0jmcDq/8BhzPktAJ5WTizJDkB6a8iJ/kOCYVf4UogGilqeAYSxD6+3Qq6dIq7pFILq/KEalPOTzUUOKBwpKSnl79YNZ+Ka107AAgrI3S98XDAtYq0kNgDu0X53fsQtB6+W4pJu+xx2J4R9HDJq58483bgRjm9WzxA4s+SEDE9/oO78Zw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934A4AF90E32B09904D6877C10F0@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(396003)(39840400004)(136003)(346002)(366004)(189003)(199004)(26005)(186003)(486006)(16526019)(97736004)(42882007)(446003)(476003)(11346002)(956004)(50466002)(33716001)(76176011)(316002)(54906003)(58126008)(386003)(16586007)(7736002)(6496006)(6246003)(33896004)(4326008)(25786009)(81166006)(52116002)(6486002)(305945005)(8676002)(81156014)(229853002)(53936002)(9686003)(44832011)(1076002)(23726003)(47776003)(6116002)(3846002)(2906002)(66066001)(106356001)(478600001)(76506005)(68736007)(8936002)(105586002)(6666003)(5660300001)(6916009)(575784001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:xxioBq4lSwjXQUs/r9fwssQJ8AhhJPuB/0aJ0r9iR?=
 =?us-ascii?Q?eqGMRiE6O6wuhvrCTG3qvmQ3b/e7red94HcDqBA9mzxFlhWmKFEc4LD/UAUG?=
 =?us-ascii?Q?MCWROkGkQiySyh3RIMq4Oco0gdNL8Mm1QSy2koRBGQ8P3RQcyxcODrIv0tJ7?=
 =?us-ascii?Q?DjlHkpWfjcx4kLAhBASxuL1I2D9wkWWDdtegYBOZLZUrrFh4hVUv1+1KYNRw?=
 =?us-ascii?Q?oji2fLE6xz03FxuXoRdRYw9HKI/BlEj9OEZJIRR8T+C5V9mh9AJFaWa+8LXq?=
 =?us-ascii?Q?HHThvHoHe7kufybefg1JCRpQ5L+lcTpWc6D6dEoVgIGqxIyFkHTQcGJFfRw7?=
 =?us-ascii?Q?KuKYPeGamUPK3a/E2naSgR/VpyIiee+qQog+aW44HUumKfZjM3VOpHaR1qjN?=
 =?us-ascii?Q?KXRCbP07VUHwP/DXg5Sw3ZT7lfuQmG7RkgHKQyYJDW87RBioyoskrw74NxlA?=
 =?us-ascii?Q?mCJpw/n4NrZSARf8fAHfb6m/oq87zmisydK1VJaiS9vfpEFKIdbwJV8nBpVu?=
 =?us-ascii?Q?lGaXNcYUXP1v4ZGLZlth21aqMz7Sk383bVhTbH3r6orhfWpKx99ggxCU26fO?=
 =?us-ascii?Q?qg6bvwVIrZrXc7OY2tbI97n8a8rodvxLDVazVhdQ68Cb7D+v4AfA9Z/eRYjg?=
 =?us-ascii?Q?r18Ub6Pxjyz9YLz9VqKMaFiE1+0MqUvv8MYwtX0fSo95T3JoUrgo8HEgJpG8?=
 =?us-ascii?Q?6Xjq6qn85TXXaFvrNQMSNBPDZ+FoY5lh9FCOQgao65voW0E1ENYe6CUzvoRJ?=
 =?us-ascii?Q?tvR2ETF8dnxF1ZeaSWuGGcxQiQyxQP9tiDiFc/hRsd+hlfqpPqdvSSrTn9OB?=
 =?us-ascii?Q?jwcuT9k2VaUyFNpFofh0q/1cBQiznoBexOjX3SvbW//U+XP5G+IiMVGKAsGq?=
 =?us-ascii?Q?tU2enYvipiejj41pxXHjSob//By58UuUTfbzik+qfec7+9HIq0bvFsF2hz9T?=
 =?us-ascii?Q?wvyfJVqLQgV93PPSLw9CdguPkb1Fl8LIZRwx4jgCmOTZmRKxz3fT0+xKansW?=
 =?us-ascii?Q?lUvKCq31520AhqwLI4OV/G5lkVoE3cazOin9iDlr3hFC7Aam7uTaIe++P2oj?=
 =?us-ascii?Q?JJOSZxvNarxvjvvk3Refmw1hg4iTLrEiyDt0JwZwDkrzJkpeltCaYoutHbwI?=
 =?us-ascii?Q?1UmPavmIibbb+Ywl44kyX7AviRh12ygq0MtaI9Y3s0ql7xqs1FCR5DIQBdQk?=
 =?us-ascii?Q?TcVDFqLzUpJmPYZoDtYuF2fPDPGtHL9lN7AUHxAksxOsB/dXAiLZWc/jRPp8?=
 =?us-ascii?Q?LG59BZuA5n0Dgn0B3v8HbKJKI2Yt+74BM8g1cCroRdxw0Ems0ThkvpJBft4p?=
 =?us-ascii?Q?ToztY365SxBKDqyy0ILQiwBmvBFO7KLJfpktT+0Cdst?=
X-Microsoft-Antispam-Message-Info: dCd6eHJvwk2KVpLYNnq+nIpXtb84ubt911jJtShLkkcVLL7lK6fQdzw5tdmKex8cGjn02UV/Aq6s78s1l4wMatSy/ZCnr/0dFi3L84GjwmHjhQYT+p0H0zRZaHRJNQGf6v6AM2JbehrfTOudTzm7gIqp7D3aYBYdo6/4ANr8qmDKR8uWw7iKL0PNT/euT80pL4Y6/x8LV9W+d15oDDwVfWhBeLguUejxNRBQO1+IBvg+e9vFPXDtXZmlxhksCl5iVOzaQxQXYzZ9C2A+/CRZtfp+2bna+doxpZzcUIOrzNqngN4tx5EaYxueyZNwfgeppizZOqe5psR7Cv2t4Tl51qjD+5U8o1Lg8XBCuxQ4Bs0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:dr0bN4mt0NrWEIKH/5hPiVGkaprIb8Dr8oSBUz0m0JhQzIdlpCQREd9D3RIhehgMhyJEh6KDcWSQKdK2tCRYTbX6QUIpAkJGWKdxcb1fjWxaTJPDI9AoM4+w2BKFC16jPDbOym36qeWb8MmJpFm3pWNCukVNvE0wBBVYIQ7Q0He9B1Hy/+waS3XMavFmzHx5Yi9Qt31Xs/6tv08nkM/QBv7srJYA6o8f57+U7USlSKjDEXlBOMso70SZJeRjIrIFL4B7ThXXOpzO51wtqjJd3EajZ1EDCr0+0T69a1/Hnnxwd5if+I8onF25GzTVIecQq+hhXsDnc2kf/U/8t5m3Ly15kjMOi0IfxWTG5VPZ1y0jMPds0NkGv+UfPopFexhDHBThVIBSWZN3TLb9hKPPDvrFP25F2U8hJ55ksaDYreI+x4+72vI+MKbMoh1CngKihApC/DTlJTKSpkfKfu9VEg==;5:wocePqKEmTHXjg4LCkaolpEQ1BGEgEDUnTUkSxbjBaMNI5wJj8usKX6Z/yG0hzIadR91POUQJ81a8Vc2p+zA3K04j/BBSOOXF4tUSIwq9voSUYGTamiRQNZeErwQVxJ6X9IB4pqe343P8FEbFBO7cuaNNMTQ6xLzOJvSkTlccc4=;7:Q7my2mWCPfXMLPIOrzppdO2yLAzvTC42qtWPjGkg28jklk7CxVSQOT2Tc4MGPLCSfpHYp1bq+tPf+3grGLv45LPPHy87yH5JxCOaDX51NKo+rhmzsPj+OpxMFfz2vOUOy6ZWJtFCasafWkU1iLLpmtWuiLFR9wFfO1md0F94iEc/V8ivP2yy6LanHTLuqGdhq0T3h1Mu80V3IHVjHcCYSkC8g/XZp7qeSrm/lOX0ElhP26geH0xOWEFsRNvqELiW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 20:11:58.1416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d1059f-9ddd-4227-7172-08d60f7e016b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Aug 27, 2018 at 04:50:29PM +0200, Christoph Hellwig wrote:
> Various architectures support both coherent and non-coherent dma on
> a per-device basis.  Move the dma_noncoherent flag from mips the
> mips archdata field to struct device proper to prepare the
> infrastructure for reuse on other architectures.

"mips the mips"

> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index a0aa00cc909d..f99748e9c08e 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -4,6 +4,24 @@
>  
>  #include <linux/dma-mapping.h>
>  
> +#ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
> +#include <asm/dma-coherence.h>
> +#else
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)

#elif ?

Thanks,
    Paul
