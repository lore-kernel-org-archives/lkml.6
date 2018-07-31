Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC643C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E9D20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CJfGf/gB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E9D20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbeGaDFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:05:08 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:25510
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731288AbeGaDFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pFJIEOIr5OKJEQgQQat2nVj00o7ySdiagG5qHmMO1g=;
 b=CJfGf/gBckKDKGVOP6DljN/digsaBXHZxBlPNysnGy9H5X1BrBFC81F/y3AkLcUiHZb0gwYJa23q7+y6f1Z9SFK+pJ6psV+3H9Zgb0VLClhLN5JJTZS7Ns43BOo+ynsyxv59pOIzjCeEOEJENsuGpZ2byIdq0DYC/V+Z7PKV6M0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.20; Tue, 31 Jul 2018 01:27:22 +0000
Date:   Mon, 30 Jul 2018 18:27:18 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     RAGHU Halharvi <raghuhack78@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        jhogan@kernel.org, ralf@linux-mips.org
Subject: Re: [PATCH] mips:sgi-ip22:Check return value from kzalloc
Message-ID: <20180731012718.bnct37fdtiaezdyd@pburton-laptop>
References: <20180717114145.21856-1-raghuhack78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717114145.21856-1-raghuhack78@gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR1201CA0017.namprd12.prod.outlook.com
 (2603:10b6:301:4a::27) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf47eca8-24ed-4baa-2f39-08d5f684c3b9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:UN2ABsV7bhJl3EdxfnamUdMHoAIkH/FfxFXYpS3qaa53n1cLKXMw79vuZrKtOoo4xXLnOyJ8XPoFonJddJ7UOttHPqwej4QVG0c7uBJTbtW1diA0vmyvzatJ65vWrrRTBQsx/D/oARFG0ZR8T/LqYWaaFq+mUBCZFcnEV/4Vr+lGBFi5zpoUl13Yl24wY8wg2LjHuGqN0a0yxE/5CbhCUR6POtNfe4ZPnlPnXsiJHhiPZyaIWeCon3mg7L6vnVS4;25:50+8jxX4MROGJ6tiD2VUz0wrKj17L4KqIR4sBAdOb5xGKTjqD9a7L6G4NOKmKF5Mx8CYpPVf4D9WlpJO4EFvoyX3bXW8gxIq+HQ1PG9bgl4GC62oTExf69sBEuYmnd57HL8ddXUCoImfVeVHqLHHbARb3RDuuUQCuG3vXAg6RWxEBa4wx19QED4NABQPNS8MMG5jfs6YxI/94Uy71H3aH4rG9YkGz/KL4Y1rYL08AIZ6YCTjeIHoA6B/Jeatn0TJWaa8on8CU3EJ9jF8B5Zej0501A5DA0YRGWmgqj0s7tWhLGdWSBcFTUmr/l+GifyK5YrVA2MXJQLOKA3xzNmsJQ==;31:NYbdOLZPM/GO7mfbAkwx8CLVAMLSfNJmd5ihh78QZzhA7TofMw0CrOxNZB7fHDGxB2WmAK5VVFKGscjsDT0ll7VvhTdpfKHw8DCs3nobpDllIYpMXa1Kng2w4FPaWmblzIM6qHbSalQFipKAiqJ3Evf495audQ5y6mp90d0FjKNW9fZiLVMfRxBdL8SNyvVrkX53FtAMajBlmRFiNU6uDV8qf9YcnLysQbNTzjf4nq4=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:M64OoPbfMzZ4WawXepre2IXcjSIVpsuxNFA1Lyb2WrY5uThS6cSeJ6Vx9DLtzHFdq5NphH4T8wJcBCsDrnVhNyGGIgiXHdH3ls2XzNAd35gzs2Yl/Zw9lcqxCQvvo4J+zfCGnGRj5jqdIxBvEMSUu+jZH7ojwNWkZST0TuzyLXwe7pDXb961DzDS2oZ+6cjiJmwoghBTtHQ1CeDDqcfbAtMfM2zgfmGM0aE1iFKtzQSr2wsE7+Kfbf7R64aBHt8I;4:ZocxZMiREFWvksLDK5vt2HkBtYggXLLeOm6xDf2tIWXlT53xxpTAalmBX6AXiOjOLsmClqoFToatZwcW1imDOJYNF3NoV5tIxefa7wVj63gqEoGiuAZx3lf5M31n7/fl7mloz9xBK6yGrampfw1BdZKDhkNmNPCnAdnJ5+Xnwm7/LaMxfaz9WcxBdli+B6eXbVWQKAhs8eT0APl6hfmJexhxFziEQ7t2pp9dRTnmtxhv5VgfA9rHk96nW9BkCfOB+fcPYySEW3JMEHfpK3IpGYMF2X70+LIYDv4Fcxj+FHW/KEvZ+cz27EJWocfQ+MP6
X-Microsoft-Antispam-PRVS: <DM6PR08MB49389D7D4E172FE36742EAC0C12E0@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(346002)(366004)(136003)(39840400004)(396003)(199004)(189003)(16526019)(2906002)(5660300001)(186003)(44832011)(42882007)(14444005)(9686003)(53936002)(229853002)(68736007)(6666003)(386003)(26005)(58126008)(6496006)(316002)(6916009)(52116002)(76176011)(33896004)(446003)(39060400002)(6116002)(1076002)(16586007)(11346002)(1411001)(50466002)(7736002)(8676002)(76506005)(305945005)(478600001)(4326008)(956004)(3846002)(486006)(476003)(8936002)(23726003)(6486002)(6246003)(81166006)(97736004)(33716001)(66066001)(25786009)(105586002)(81156014)(106356001)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:6z0W7brgtYPnw+q7plpUzQSaNosQ1wNgk/lx6EcEU?=
 =?us-ascii?Q?IyKWxnhcS3PsxmThR/mZ9J8oaGCtsRlLKCt0j2zESPF3bZ8Er5DbL1j5Pa77?=
 =?us-ascii?Q?ux6ugrv1p1oDbGSvNVUc8H6OfskqtnfhKR6t3hzJgWWwhJGQTHfRTS115eVR?=
 =?us-ascii?Q?ngBHab2GGiaRONk+3eJwHPtOVVx1O8ACxDOYUYloTHrXQv3xxARCUFRxJnfo?=
 =?us-ascii?Q?Kt8z42Emk3k8U+TgQ1dUITc4G9+1+J0dg8wgefMY7X6BLTC+JkCudTM36UDO?=
 =?us-ascii?Q?uxiEUr0LT/SK+LOfwqWFQdEAQNB261YJfJ+Bnr841YtZR/55dHW9qOAisiXx?=
 =?us-ascii?Q?cfK3hah2+e5v9B+CG5HS8uU+0d5hvFSbN4YdKfOAU2L+YFHLQ9V6swsWfMRT?=
 =?us-ascii?Q?ZWM33agwV1ogZVkzqW9KP4eeqFehZw4XLC89yw/kF5uigi1Rua42WcHwNVDA?=
 =?us-ascii?Q?0ObRcCAJIRQk1s5SPfKppugKn8wt9GbVNa3FbY4DNAD/b1VYh96Ge6Qtd3hw?=
 =?us-ascii?Q?cP9tBSkNUPwbFN9xnrAJFGl2/E3QlO15uqFIDsApLttQTG+nhrQzw3KqXre3?=
 =?us-ascii?Q?fNdYWF08wZEqNUu3SSlEUt9Qbyg8P58yPbYyaP2ozbVG6TSNXbY8gn33dl1b?=
 =?us-ascii?Q?n2ylkkG3EbjmOe6kNVws8Ij5j2HJiyOvQmWRCEqsNBEy3OzQDKKXFp2xNW2m?=
 =?us-ascii?Q?0wkQI3F8SAyI7fo78w6p5Iq17XSMl3VqfHv+dTRgdoy0WhSucuwSn7ZLgzhU?=
 =?us-ascii?Q?BaPMH+UJfyccYVz8PDuX4wcM8tg1FpBVxT/Ewx8iSUuCN+TF7o+zM4nL0j5N?=
 =?us-ascii?Q?cUy3i+hFkLGZRjrw1Go+0j8zPDlR9enI8Kdz1I6lw95UE01t1D7GGIPetrWZ?=
 =?us-ascii?Q?mdF2VXoK0MzkoKuAF3B+2ddf4wZ/PVoVOpZZkc45cAcBtCu9s7wU11RzBsyp?=
 =?us-ascii?Q?WRrGSXEmlhNIoBYIv55fqyNxS0AYP3S1ZwGtTrRoG6qYmqrTB4ODQd4s9MIw?=
 =?us-ascii?Q?cfDseMNL33rZWGK5QWOY6/DRfNwmo4Ge3I0dEYbBV5qACHBrME+fOWVDcp5H?=
 =?us-ascii?Q?0uIAWfz1UhaFjlehPFlLOosIKBnQ5vxLVPsF05gsUyq7UH3aHR7yboQbIB8z?=
 =?us-ascii?Q?/b4ylvbDUf9jPkq5ZfRcmiWGbij6VQwErnGzT3ufGDbNmIjFjcbQHhytPUQX?=
 =?us-ascii?Q?aiCgI1TJ2GSCeCZ6lH3V/gO1JS9reB7IBo+Vqfkp4Xd6iQyJaCjm3EJsdw8Y?=
 =?us-ascii?Q?wS06YI78fIV3laZQb+6ZSDzdVfK9k/oYfhYCeQ66jCighw+FWHfTylUE+YrO?=
 =?us-ascii?Q?VTpP/50GsOLdBNH9VNQ6VdLLi5/wq8IE3Q/XdjlG8yl6HOCmmirwEnjRbOLL?=
 =?us-ascii?Q?6B5MQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: uIwEjfQXoUW4rFr1OMX6Q8/7gosWUclKWl0hToyg6mdzIiWjX2ti9tcxaH5FZUD1Y16N9Gvq26V2SCIjYTzq/qjeltsq9+nmjBnDm5rk6LdbIx0oVFDO7We19ATm+hqfEV1N1KQjTwZZTvVsCXjwUlN3BEmuZDDZuiR4hvqC9OebyR79gb6mWjYffZbz0dYvmIzefvugAMHzCmP8fJU0uiRFXUUN8o3v6bhu7lecd4SCTsnox2/4kfLeGvXuNrnW0FV28DGW1XIdRZ0MBWVFOGEqxOSHhrGSFuTOIW4XO+Lfu6DBj/2ZWuDDuzk8SeIVWjX291aFNy0gDyIspH/8BH+j1ch2JpLHZj/A4Aj6cxY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:AyPm8uOMDWiQevk/S1u2+STNJXYVIiNVPXrokxsdETH8ukGcF2fZP/B05DMCbTrh3hRnYssZOS8h0Z9gokDOU8a50X82JHISeoSQeJLVrKmAVxWR+s/Fa2t3F20T4KJSHNd6pckXop71URi3WmPRbkQhiRnLdafzpaLVhXgjs/jQdBZ+DYOfTVFSO5m9R2fWDl3JeTXT367GeUVByMPDEcStAm9TWyiDRJe0zacWprrZryJ7KtDbu0/wy+cxpIPWtOWFm6AwBjn8nVQcrU5i7/3ARPQk/KREOKugBAiNJ4Mqve7/of1fp00eA9LFS87o1NQ7ZuXuOKYlY5UI/YR3OCL9YssNxii2ynpYVzCvIEWRJFgkC9Jl7rcErqYPwYxdP9Mb+ae/4Wpt98gUAAfHFJO9JR5P2mJunIRxu6q9oa+NUQp7muFDWBJfaGDuCqetqPtcapb0xQg3nssVnBbswQ==;5:hyp4vLL+mv6xzJERvsBg3XNGyZ7XGupW3fqHmUs0iagPXH2xbKz0DvuW9tW2maC3gyRouqT1haiU35YcE1hxRkA0g/XRxw8SXlr2ff77x9EHf3QXdIJeNUgh+ZETb0ppX/j1/nZuvweQxZ0VaqEjb1rp/y2ZWPXyK+n3byATpoM=;7:FOYz3JH7heBeCInpboLp6ejwnsqzRzXsY6eI0rde0K6lwAqCglk/XCY9kqSeFJZRrkByWOzB7ava8SkFmWV3TwZaM5Q6pFRNsVfkgWM9IuypHZXqxdnguP9mWEY2LKzd1AHH15ggxfI1fDc7IBoxsizmP1ELjca1Ag3LIOj6rGChShPZYhR9ourTf9/+8pZ5SXpweAKqlGRFBUg4aHnaOcP9xujnTGlpGtWOR+53S+0AvMdt9hpZWcBjn1EXaS9p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 01:27:22.1051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf47eca8-24ed-4baa-2f39-08d5f684c3b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raghu,

On Tue, Jul 17, 2018 at 05:11:45PM +0530, RAGHU Halharvi wrote:
> Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
> ---
>  arch/mips/sgi-ip22/ip22-gio.c | 2 ++
>  1 file changed, 2 insertions(+)

You should write a commit message, even for trivial patches, which
describes the motivation for the patch. For more complex patches it
should also explain how the changes being made solve a problem, or
clarify anything non-obvious about the way the patched code works.

In general, read Documentation/process/submitting-patches.rst

> diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
> index b225033aade6..5aaf40a1743b 100644
> --- a/arch/mips/sgi-ip22/ip22-gio.c
> +++ b/arch/mips/sgi-ip22/ip22-gio.c
> @@ -363,6 +363,8 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
>  		printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
>  		       slotno, name, id);
>  		gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
> +		if (!gio_dev)
> +			return -ENOMEM;

One especially important point for patches like this one is to make sure
that your code at least compiles. In this case you try to return an
error code from a function that returns void, which won't work.

Thanks,
    Paul
