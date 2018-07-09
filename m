Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45567C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BC12084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="AWUEmBXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BC12084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754490AbeGIIen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:34:43 -0400
Received: from mail-sn1nam01on0084.outbound.protection.outlook.com ([104.47.32.84]:20352
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751691AbeGIIek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tub+3hMXu7NFqT61n0VaLw9iWbm7nStWlIfxv8Mhlw=;
 b=AWUEmBXzwlxaf1HE0QaSuGCWJKO2eX9NH5eL7DkOhw07KgSxmzi4cxYoTMaVOidGksvQJjT5F+XzzxL+9FzQvRchorL2OGQUMYzjhfay6YI0OAMrbznzXzIPP0vRulaJuWY8EJNY7QMRGsXFauM84HGZBX8xx7BvIGa3EB8Zwyc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BN6PR03MB2625.namprd03.prod.outlook.com (2603:10b6:404:59::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 08:34:36 +0000
Date:   Mon, 9 Jul 2018 16:32:41 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180709163241.4d4ee343@xhacker.debian>
In-Reply-To: <20180709162315.7f53eb9a@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
        <20180709162315.7f53eb9a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0144.jpnprd01.prod.outlook.com
 (2603:1096:402:1::20) To BN6PR03MB2625.namprd03.prod.outlook.com
 (2603:10b6:404:59::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b3539dd-6f60-413f-9a66-08d5e576cf21
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;3:ckbI1OzT0HMMC2t+4HEveB0+4QQCmKK9t9HZqFvpY6futSk3rvpaNii8KwJsFuEnLVZ9FwfYtNTI3ImSyFn9ZLxysgaOY48fUTBOYENkgF/rqyxWYDSmC/dC24iii27m7YRp2emPdIL6dUZV2b05PFvh+oayFSRHoZae3K9f5Z+E+kT/HSs7RNbgDvgchAMOhoG7mrKwSqmZy9yDNAlM9/o5lj8ta4xtwNzvaAeIgTDfU9s4lcrhax0c/gzQpHrT;25:zaE/V0Kfu9HDYn4f6wownD9S8uf/B5NiSfksHBZkXeR25vhyXbWhWXk/euQUv50pH8PhGsj2QFgpYgtv5mP+0ZEwmuaYTbPnkh8AWOE3X/S14h9mcPxBt3AMsal7PqxZQiiUcl0Ny/eB3FjyF/+zIkPiFp94qV+WurNlDInK/MMXIjYqm4CDJtPY0k0zybcMm7rACLegX4J9nrXui67IHqGwt2s+Nyn7FK1MxGoMuFiNApMDQWW6Q0wc50yUNK6P4uHRyD96vmGpoF1IAj+QdMhM8VhG4mDQWLgzr8PmM/jPXebMUjeZNYeYJTDS9n4t3WAJw6iJGNyg3NlUCzAZWg==;31:8gsazCs59A8YyUIRyBxrNBjgy+VDT5zZGQhu4OTc5qkMzDGbBfvHnOgCB4GC/Sm1uQpIzFP0+lfjK6bhnxyxV2IlE22poEuCR883dXN96GKzYrwpBd2rGHrJ/7pNq91TALV2RJztlR7lCtJYw8+t4HkGqzXUo3/lyA0f5o6Eb0u8YObJGjO0XmcRdu09gBsPQOf6YhCHahA13sao/V9MYweTZiOWXidiNUDhAVsnhAw=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;20:GuG/HV7lXuAC0a5nmhMaiIaOtnRLmnzKEO7Vn+FimpKPBiS9lu1zMHXFnYLTseYPyUmlmjJY8zQ4CiJx6S6++DPvfD4Jn+ftshVqKnIUyT3ZFzLD9vepb/gGgPMPXEdjTvewhzv4P2MgIvVVwttU12LgeEuZSIB7ETYD1ju8JSDj1LieqPUoR53i69KsSt1kg64gkoz41vCDaeCOPQokQGhbngbGDlpx+0Ao45+MX8vrb3dlzmIPmuAte07Df2w5JO4gu8P3CDrvqcYMldLNOw0XVwl/Ega8LAymWbpHb2YzLEVPfvrDGwVyKNqF4fW7oWUwQETySdWL71JUie+wqd3/u0ESI+19wWUf+3vu1YSgEYKst0Y/KhYF5WV7J9NrAWbpln1mClK4bbszCNd2u+leje8DC9c9d8NlWHm1TOF4qufE3woBrbuPDrGAM3fQ58TMJ9v6b1H36ACQgfW9UVp5WI/aMzviU9iAoRdFcnK7A9yxvbYEjrGBaOmwr62j;4:5mobtD8ejeG1NTutuefQtpHxHQ2alcebz5B96xe47cxbpJe9P7sVezampaLPE4eT73cMCw148uIdhYfWeNw8BRAur99i9NYHGh8bSsvBR/+U2Y/UIUZE0zBHQ6T4p326tV26jpioWND2ib5GiHYSY9HcwanPmO4WYIUKVnA9mcLxjvumPJ6fMtc82+lQVpoCBf+ZjRV9glsi5uAulhYzMWOIF9BQ8GFDCeNFzfE16O3jaGP+C+Apevt80xcC9azO70Se8zbJCjLuPjgYMOBSrg==
X-Microsoft-Antispam-PRVS: <BN6PR03MB26257199CC2F1A7D82792133ED440@BN6PR03MB2625.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB2625;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2625;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(51874003)(189003)(199004)(2906002)(316002)(50226002)(26005)(106356001)(68736007)(478600001)(72206003)(4326008)(66066001)(6116002)(7696005)(47776003)(25786009)(186003)(16526019)(52116002)(3846002)(23726003)(1076002)(956004)(476003)(486006)(105586002)(230700001)(8936002)(305945005)(54906003)(110136005)(6666003)(81166006)(33896004)(76176011)(97736004)(50466002)(86362001)(5660300001)(6246003)(53936002)(9686003)(229853002)(55016002)(7736002)(386003)(6506007)(446003)(81156014)(8676002)(11346002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2625;23:wIrMYln6RGyDfdHlPTxULX+sqyzRrcv0741vOHSJp?=
 =?us-ascii?Q?NtdbHYA7p2UH2yetCZnTLjEBer+IJQxb+nkLa/CsF6eUIQXEbjVbJ3HlrtOH?=
 =?us-ascii?Q?H4ofS6GfyY2+X2epXT9oUnymTqH+OVukPur9j4v9K36HbYQUbg9RkZGeDw1w?=
 =?us-ascii?Q?3EMm/BnJBI24ZxToMXC7dPPKcgX0psBxIN1Wh3EK+m6Vvxho/satVDY733T2?=
 =?us-ascii?Q?bnsWATW5/geC0NdHc42dRUWOLoimqrBe8kWFOZYjCqO9w9fprAOfNh6P+OcJ?=
 =?us-ascii?Q?929/jDJxPXaF5u77gWpJFMlNuspN+05yJh7rZ075DO5wUrQHPTzi/TVb4xsr?=
 =?us-ascii?Q?3hRvafg82Z9WdxEBrW3FHYkrr2XCPh8feUiX5ftqr0efEWfxZRwWGDXlAMEV?=
 =?us-ascii?Q?mCRlhCjq6D8doEvfxwDVYHcrnAjWMvUEEFqIT6oKwH2Y28TFxqhS8if3OBGs?=
 =?us-ascii?Q?FL46ND1giiOyA0BaaYUoznQW/WfyCENSg5r3XCloeSg46x456BuAthsLTqkH?=
 =?us-ascii?Q?qtucElnRFhcv7Gj66lL5GIJOx0LHI6ew6RMDoqdGROi+QljYSxC0DJSa9mNg?=
 =?us-ascii?Q?mms5u74Ism10IE6rOePm/zosIbXy7EFhwldsKAVjAjcGFCQ/UZHrXlf55fQc?=
 =?us-ascii?Q?wGF5v917LoRBnNOho7Pna6LC7Xx5kWoNzlWaDaAxvmhJq2522bfXXWr2IXnf?=
 =?us-ascii?Q?3xQdAl8Ilhkm/ugnXGMqdHveHHOhvMYCBQTZxd4RzVVbN0yRuqtzf1RBY5C/?=
 =?us-ascii?Q?OpVM0u1wZpALe58O/CiaPbpJaiymNof0xNCjWwT4v7HMuIblCDi+inZvTl9b?=
 =?us-ascii?Q?8KRpZ31tjD1adXOmXjSB1KRYaxWgMdkyNOf73ngGPNvbnQF+C/er5aEjiS1g?=
 =?us-ascii?Q?vlWShY6LxE3INwCvU1uxnF/xfFGhG6jZuwxm8NS0wxaUylUP7SuazwhaqlOC?=
 =?us-ascii?Q?Mmiaj5Nf5kJI3TkTy6Tswx6apKTrP1+0jQcXd3evJueB5RI7MT/xrZgGEIBh?=
 =?us-ascii?Q?pOXg2/eScVENfVBJ1nkH9a73vfPaX4RNsukgBVXCOVjIiL+p7//CpI00MXr/?=
 =?us-ascii?Q?L8ZynXjPQtj98ZheFu8He2m9YeisMwaq4XUXvG3sGci102QiZXfEql0oT+qw?=
 =?us-ascii?Q?vd17BLDdk41crUarmq1KiatH1/9YPaBaBxUtQ6FHTsLf5zOSmPfCwJ6Glfhi?=
 =?us-ascii?Q?y0FOMPvuriCV9KJuReiHhjaOUp82rLBcAFIXA0PQEK19huLqQ7biXgsjk353?=
 =?us-ascii?Q?SkHwLpWlqMVruDAskV2Wxs8fJjCFX+ENVF9u7sdbTbekS84DHg0kETJJqvqq?=
 =?us-ascii?Q?//R4bbqPnUV+lN4MB6GZ/8=3D?=
X-Microsoft-Antispam-Message-Info: 65ylbxIvT0n3x0/M9YbbAZVg3JFADmyRl9omSVU+NnupbPZA5wNRI5TElNzPxA2GbvYbg3+9cnQm9VsY38sp1RzW6KdouPrhH2nSq9ri88wu2gQ2y+sT3wORKkoA3kLop5aALm5Bo5AE/LNMT69unS9u/4bVD9AGUbN/SbJ61ldmUH+qcGz4CmyNaX3tL5bJ5x5NTDMf635nLyJXs8jq2jaxR9F6zn7NE39347w4GBQXo6g0tmySAsy8+OHqAlRwc2TAElYn9vGqTFzQLvCCt7RQX4hRMGw5ArmTr2wy4CkEJ8bNTcNq4W79uC0jQjuiL9mvp3SvELVRcNC9ttxlSHrtLBUdsl3JBUKogYP9u34=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;6:BIZEDdHJZLd17vqbtcog82Zrh+KwMcdQRvlye8aSI2eWYCi5nuWjscbU31BX6emnECnvBBQekZob3h6kvP8LEzsKLASH6kTwCu1mFC8ukncb/AH6dZMrgjRSNrun2zKo6ALOyganQpTPvsu6Nc7BsJrxHfT++vWOnvsjw2M6rcNfZNHVEhTkk3hDKt3NRpGRRyYeqJxCTFdKJdWU8AnpH/xEpovyzVrTVltsXHCFIVUejSXBBzx0rECevzKmpQVRf//DcFlbfNwN7wzgVY1rxglrh2WjE2fbAccjrcOaDSLTnML5B3sTiwgsAHBxrOh6jZlEiNNoKjW0B0eSS89klyEo4zuncanLVrSL+6K7hJy1MDKv6fz2kQgAPYyOl5swrZbUEdkzfNFfchTBLpstmW2HzvNgdj6+NOgLuvUdbLae6uBU2U39iu3XHSLYzjwLhJzOFVZB5Xmiz5z8fSgOIA==;5:yQow8hwZ82wQ7sEUq+B6O25EYomXCaknSDf6z0tOqsX8bOTpvTOoCD7XwRbHBnSvi7Iehcvq4PywFZpFuF8fbPMbphgr8sxih2ATwybUrnNfIkl1X3LReJNX9SsbSdvtV48UW3nfQ5CdqYHkY51u7ll74Kl64cjs3XayahsAlLw=;24:JDHPPbahHk+CetN9zZYQZJKDiLLcnJY9M52OMYfwjj6btSsF5fO5EgX9akKEdpVYFfUCebYRaHPplwnDrpKcRGQArzD0aZkHf4Dm/CELy+0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;7:nV7iNwKrleBKXoTE3Jz09vrOy+R+wby+QUnGIFTtlK2fHbOBU564vm8TWWyLJJlhWsw2YqbKCWp6lpZeT+902HaVvd9L/ErFKNZgg+LDS1VYuS6dZbLfJEcuq8gC11ttq88llHYbmTU2o9UKVn2L6vU8IIa6r5uXyKuMeJm9zJm5X9Ns23YutqqdF0deHwCJeEkjxKcbCYei57+pimzElpIch3SQenYp1K2LLl+g8+ioOHwG6agUrDg43I+AWU8V
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:34:36.4892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3539dd-6f60-413f-9a66-08d5e576cf21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, 9 Jul 2018 16:23:15 +0800 Jisheng Zhang wrote:

> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register. The fractional divisor width is
> 4bits ~ 6bits.
> 
> Now the preparation is done, it's easy to add the feature support.
> This patch firstly tries to get the fractional divisor width during
> probe, then setups dw specific get_divisor() and set_divisor() hook.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index fa8a00e8c9c6..e90c3d229f00 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -31,6 +31,7 @@
>  
>  /* Offsets for the DesignWare specific registers */
>  #define DW_UART_USR	0x1f /* UART Status Register */
> +#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
>  #define DW_UART_CPR	0xf4 /* Component Parameter Register */
>  #define DW_UART_UCV	0xf8 /* UART Component Version */
>  
> @@ -55,6 +56,7 @@
>  
>  struct dw8250_data {
>  	u8			usr_reg;
> +	u8			dlf_size;
>  	int			line;
>  	int			msr_mask_on;
>  	int			msr_mask_off;
> @@ -366,6 +368,37 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
>  	return param == chan->device->dev->parent;
>  }
>  
> +/*
> + * divisor = clk / (16 * baud) = div(I) + div(F)
> + * "I" means integer, "F" means fractional
> + *
> + * 2^dlf_size * clk / (16 * baud) = 2^dlf_size * (div(I) + div(F))
> + * so, (clk << (dlf_siz - 4)) / baud = (div(I) + div(F)) << dlf_size
> + *
> + * let quot = DIV_ROUND_CLOSEST(clk << (dlf_size - 4), baud), we get
> + * div(I) = quot >> dlf_size
> + * div(F) = quot & dlf_mask, where dlf_mask = GENMASK(dlf_size - 1, 0)
> + */
> +static unsigned int dw8250_get_divisor(struct uart_port *p,
> +				       unsigned int baud,
> +				       unsigned int *frac)
> +{
> +	unsigned int quot;
> +	struct dw8250_data *d = p->private_data;
> +
> +	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud);
> +	*frac = quot & GENMASK(d->dlf_size - 1, 0);
> +
> +	return quot >> d->dlf_size;

After more consideration, I sent out this version for the following two
points:

1. the max frac divisor width is 6bits now, but we dunno whether future IP
extends it or not. This patch version can still support > 6bits width except
the overflow concern. But fixing overflow(if there is) is as simple as using\
the DIV_ROUND_CLOSEST_ULL macro.

2. this version makes use of well implemented GENMASK to get the dlf_mask,
the micro is well understood, I think. so the code is simplified as well.

3. the magic "4" is explained in the comments, I hope it could help the
code.

what do you think?

Thanks in advance,
Jisheng

> +}
> +
> +static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
> +			       unsigned int quot, unsigned int quot_frac)
> +{
> +	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
> +	serial8250_do_set_divisor(p, baud, quot, quot_frac);
> +}
> +
>  static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  {
>  	if (p->dev->of_node) {
> @@ -426,6 +459,18 @@ static void dw8250_setup_port(struct uart_port *p)
>  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
>  
> +	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
> +	reg = dw8250_readl_ext(p, DW_UART_DLF);
> +	dw8250_writel_ext(p, DW_UART_DLF, 0);
> +
> +	if (reg) {
> +		struct dw8250_data *d = p->private_data;
> +
> +		d->dlf_size = fls(reg);
> +		p->get_divisor = dw8250_get_divisor;
> +		p->set_divisor = dw8250_set_divisor;
> +	}
> +
>  	reg = dw8250_readl_ext(p, DW_UART_CPR);
>  	if (!reg)
>  		return;

