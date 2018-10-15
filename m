Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBEDC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2722064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hJ9g++oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2722064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeJOVMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:12:18 -0400
Received: from mail-eopbgr50076.outbound.protection.outlook.com ([40.107.5.76]:4096
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeJOVMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtpsaaQTFY/yrJbrFuxjeYK2n1f6e5Uh4nQwkc/5fME=;
 b=hJ9g++oh6PiCUvXZxMmwJZloJDegoQdiurFid0KzVUi/smJKv/k2IEd5DQLiXeOGLK1jmg+2JVn+Dygk0YbtNjk2WU6tLaGMjqMr8QcLggtwZH5CxtRqtpn6AsrL20BWrun8VFhnocFOe7Y1y7bBk6rV4RQbB0CFTQ9imw8cawM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mark.Rutland@arm.com; 
Received: from lakrids.cambridge.arm.com (217.140.106.49) by
 DB7PR08MB2988.eurprd08.prod.outlook.com (2603:10a6:5:1c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Mon, 15 Oct 2018 13:26:55 +0000
Date:   Mon, 15 Oct 2018 14:26:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>, nd@arm.com
Subject: Re: [PATCH v2 3/6] clocksource: exynos_mct: Add arch_timer
 cooperation mode for ARM64
Message-ID: <20181015132652.3vanslay7xomtzqh@lakrids.cambridge.arm.com>
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
 <CGME20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d@eucas1p1.samsung.com>
 <20181015123112.9379-4-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015123112.9379-4-m.szyprowski@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: CWLP265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5d::24) To DB7PR08MB2988.eurprd08.prod.outlook.com
 (2603:10a6:5:1c::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 780385f7-4e0e-4920-661c-08d632a1e04f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB2988;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB2988;3:qOSRt3Bm0Uqhs1rDqN7WsPfY7ICDOTjH+rW/FZmnl7YUPFkVVuhnPwkswZxBjc6EZsKDQej3iMBwJQOaARRuiZAshqYDuemaxQzec82zPIHC2gqiqkgPuEGFiv4FcMDTex4RVMsR/TBeWJyblBfVj1RadPNcp5LX2ql0Op0wHI8HT/v1oAyb/sxrTFiDGRYrFjEhp6SS7UtgZWAKhoY9jdjbsttvGK8LsOfutg9a19Zk0Rw0HK7yXZyrgfz7hOsG;25:Y+rDx5pEPXOSl0s0QscV7/9yxYWpGTlHGBVq/bn6DhOEc495nGgGwB5EgpS1rhmN5OhJbrNneN7+tovabLDdg7e3rqW/U93xxOI3ZAQwN240KUm8CIBEMseyy8C1zaYTHUYMznVswdHBzBMHZXBY+pK/BWT6am5/AfequNH79EnpgbaqF+Z8XpE7QXvCF4wf99ZU1gxAS/nLg/Rg6ioi/GoB9nvGDEUKPmqo5AFCEG6VzDVRY64V/wiJdUs5/gmweXARR3f1z0pl3zpiusWe2l1S/V8hRbK/o9IuXmQqQ9khkRcZaOPKVi4UltLKF5HZU5KcA5MRnQTl2kZHTuxqCA==;31:gDwpvgayAv2Oc8oT+q4l7a8UD5BmE+GMcZNgn2LLxKLuoEbNchx1/Zb1K8ndfm28JZqyvPWrJBOyZrfiaj0afXL0j0zBmE5VJIDAPX05+WKwWQSPy6lrqL7vY1n2qY362SptnHucBCqeqAVHLUm1O9MsVgi2mwL3bXfLe+5SHb7G4sl9Oz81P9zqMBOfPYFiQIb9cQHe555NlfoG3Coiwin0BajFntAf8asgzkddlyU=
X-MS-TrafficTypeDiagnostic: DB7PR08MB2988:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB2988;20:4m3041nhbZM11OhFAHKDRQDLSp0zImCvkIYXZH6cDBoJqOr2w+WYypVuYdPsGVALkvwtwG12fiSpTQatzFWtmxkq4VppFBpAJNO9+TURHzS8SPvpJ1WuIIgtr23Zj5mXQXMBnEOUGoicJHcaxDPND4BhXml0KVMtkTDWuBpr/JsyRDYsZVN2YMq1/n8scrDafn0ArxjafJ8eQzQx66GEm9VvGjgiW8l1jaj6EuVnO4giW40IJ4Bv7akn+t5SmbJtEoLAg21naG4y6mv2O0u2dLGUecHLTnTndycU4Z36uy9FgxTGXIcZZTS0ufcRsFedUaXiv4FZEYNVuPhDtYCFdx4AhuzRq5xKEoQsXEYJQEeWAxqTNaF1fMBZhMSz2kxzRjLDrlAQ0xy5y/5H2/R5JyerOL7hW9YkPSX1jT5BPMs=;4:ZyCR92T7Pkzge8DemPUTlxxlH4nCnPll2ZV5EWCk6l+ok5SHlQEsxcqMePwbGVuS8hIUAoP3BQg47P2bDSTSjzTnbfAqKZwUjVgSa/RZQARL5k94u5WGRAZDhpIidMH5rOCafs81iyvV7ZaYCcrJmsUKFbZDF4RS2mg/DkfOuSP2FfIaPYbLTcO+5uqgI4CxoYDItyTnAZwLgBZk7i3xBUnF1od2zx1261JVHI6Nvk9jE2dFHXTZac2dYC0Dwbu8HvW5m/2DDZQx+7XNOpWNnQCzDptF5oe7VjsIa7lt4PtZeo6cKZbSPNlovqfZJtvQ
X-Microsoft-Antispam-PRVS: <DB7PR08MB29881EE395B61C14AA92183E84FD0@DB7PR08MB2988.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(7411616537696);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991067);SRVR:DB7PR08MB2988;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB2988;
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(376002)(136003)(346002)(199004)(189003)(58126008)(81156014)(8676002)(81166006)(8936002)(478600001)(86362001)(66066001)(6246003)(2906002)(4326008)(7416002)(25786009)(72206003)(97736004)(68736007)(5660300001)(6916009)(55016002)(7736002)(305945005)(47776003)(44832011)(1076002)(446003)(476003)(386003)(76176011)(7696005)(52116002)(105586002)(956004)(486006)(3846002)(53936002)(11346002)(106356001)(26005)(23726003)(16526019)(186003)(229853002)(6116002)(50466002)(54906003)(14444005)(316002)(6666004)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB2988;H:lakrids.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB2988;23:EuEEbtWCzpJM4UBLZzBsA75pmVVv6kX0Tg9ILv3Hx?=
 =?us-ascii?Q?bH/r6KcGOtuVLwazk34FS4LNPtoKzfH3rhU9s/d+C/EQDYK/zlgNhy6mgqBR?=
 =?us-ascii?Q?BuwDKxAAY4gQH3u70SUlRoUuWDRnEcncIFTI1kObRiOHiAiYvEmOxTVOhxje?=
 =?us-ascii?Q?6WsOfBQ8PQYk0D1DxIkNxKum7P7032qf7GxRT27C+kf4i5+Z32csZaPKoYnQ?=
 =?us-ascii?Q?O59VhMzNchHv4Z2ahnuLMImtgPjhJ6HYq+KUP0P4y6kvWrnToSBopEOdtLbA?=
 =?us-ascii?Q?VmUkHVYXMr0upBAwnfCh24Ok1rL+lGVBwUYWA9VXkjy3SDUItO4Y0y9estqV?=
 =?us-ascii?Q?5JzAwO054N5+idN84jzwjhCL1bKX0dJCzZxPYiBEZP9GtX+RHqoWm/0InAM+?=
 =?us-ascii?Q?mAwzXZEcQnnUsBatLKI64Wpz2Q0WGIAKbGilVNYU0b45LliWzhPrYwA0cyEq?=
 =?us-ascii?Q?wP4YMsrvA179pelmRiIf1Ytj5WkxNBvcIyh9y4x4MQIf3zeJMDGS8qLGxRNa?=
 =?us-ascii?Q?l1kFeIYht/skWqofkV4ZdzpALtnV1MiikCSTPCsOYJNvluOq7O4eIzKPPZI3?=
 =?us-ascii?Q?plXvkoMAPB5lSO9vbZCFLb/dz40SwFwPOm47dnoAmZnsGA1a6ojHL8hscbo+?=
 =?us-ascii?Q?XuNT1J8S2TBGZnqVCk8P8vc6uahNW1s/4tb8I9erxvuWkufFrof0iSKZgN5h?=
 =?us-ascii?Q?iHZqApSE6wIF+KTc9Z0wzOSki3uKnjmoK/G5MEDhVMe8wHgpVeZaUHykc5BM?=
 =?us-ascii?Q?nBKryJNKwlDzvHFzUv55pz9USZhkQXh9vJG0BaKROb0E20C8y9T6DKKLQXpw?=
 =?us-ascii?Q?KABmwYsr6mnNWc0mAz++FGLYNIcpnH7KeAB5XoPdxwQcoRXFYKwdlgIARcVo?=
 =?us-ascii?Q?QiDPhFmtSCKswCcJ+626bnCuPCVOLnVC8qlnDePnM2lVyoBxMBg4VsBcFw6J?=
 =?us-ascii?Q?kZ2MRDZc4hzYfFMy50qATvuiLda8Xz3GJNNMrDMp6G4kJeAco+z9NYh8bxb1?=
 =?us-ascii?Q?52OsS+DoCPkyB75ZZ2DJuOkhmII7u4KBZeO/VUpQtqifzTQXYcK3szbILXw5?=
 =?us-ascii?Q?IgVdbowp+C/tQGPWc85WoYiGtMmjqO6ziAqghHkLmaPywXgUQg8WHQQ1u6Bt?=
 =?us-ascii?Q?QCBPY2GmKyyrCkMiWtih8YlHZi3eia6Tv0McN/ZiyUOxILHZFwwTnk5J4Wsw?=
 =?us-ascii?Q?DainJjTo7Rhgtl6YABAwTWfdc5QSSg0uHLycwBfP6QUZ468bwPZS/HOJ0PWY?=
 =?us-ascii?Q?1YtlqBZhWmXkpvpfD4=3D?=
X-Microsoft-Antispam-Message-Info: qpFlMzt/8OZ2fcJ2tSouxIcM6TcZ1rMjGj9RQsXajSn19p04f7ultKKm4D6K9Z8M/DGhtugBXFyQmZlz34/J8w3kVv4HPKvmjIG34fuclTIiOfnYOd5FRlBA5us7dQtOX91TrszSltny9j0Q5V7sXS1lb1GD3BzkQpw+PztrQAe/GBXqM38pK3tp6mjGSecp4m2k5a9m9WYeBfqxbX+ruG6itfZt7tVWz43QApoAXj5dm8A6WRiquSvtkMIW0RWxH4J6U1YL0K5g61QuDKUIs9k8lmQ9zczqUZ12jL7Xh95DDJHodBXv6XWOvwvqW2hLl9lUFOSNhiciM/2HpCU5At+iop6TJYRFEMbA6JKcH2c=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB2988;6:1LNvlMCBujR22nMxbiRB1PvRK0to/uvRobqJj2cghiNnH5U4kbMQEkz5qBKZRkaFNSEoDQAHLs7DHGMlSeX1jR8Av9pr0lJiBfBo7Kpd1c0AV037M7SjFiLZpyk99i6VfyilBD/liLLtX1UjDFmc0mEJBX9rLusAOWYFwHA8jfkk31tu26sdKzjXbAiWmmsVxdBUYxf28EGBdjSUYNy5gkyUPf6plb9ZJLuFhMnXbgVtH4eDJv9cjO3zS62xtcMJPaxu0I6ErXbVoPuPgINon/4+kkgZrkcDpNhJPELtuULFpq5ZSjnb+6Hm+EJNnkxiAHZzCkA7dsc+FMhtNXGtS5VN2RPhSbY7WJOF3rSToPoOYY3yg3YMza2Kry9mDUbURM1HXODHWpUUv8yrNeI5ghtnMC9Wqm9DG/5kAOILGrZvHAoXH7EdxoCQRcJQfGmRzWxmPrC/VzgPiBahWYHFeA==;5:jCfpi8p8cEDLS5GLcDN0Ea5Z0s4sCeyFrBWmZNpZRBz8NEt7KLwR179g3B+UQIt18WpYo9i9CZEUdBOcyxuefjCu3e9Kw7pBidNByC0EalDMf1V9+k2AKi39vXtbsTiRc4zENA3Rz5JYVygaEk5CchU9Z+YcXNXhwwcM2w63UKw=;7:T0raXw+AdC+qKvIiAnikmapSZb2I+Vh5s0j6Ub/ogTUWhYIZ6kk+m6WC+W/WLaCz0NGdbKaliPKO53bRM4Na7ixaP0SP8oil73ZYnqiEfZYpGCgZo7Tpyx95CB8cejmgJB5UmgRTJpNaNZcuE16t7mJFMIJn3r8H0FezywIukSQXs8WDPLPIVYp0uK3VvUXOWWMsdv7y3BDtJ15IscQyhoOasEIAnHJvKDCHbzglrJVIteBpmIqNDRZH3yl83nTr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 13:26:55.0444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 780385f7-4e0e-4920-661c-08d632a1e04f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2988
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 02:31:09PM +0200, Marek Szyprowski wrote:
> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
> first configure and enable Exynos Multi-Core Timer, because they both
> share some common hardware blocks.

Could you please elaborate on what exactly is shared with the MCT?

Architecturally, the OS shouldn't have to do anything to put the timers
into a usable state. All instances should be fed (directly) from the
system counter, which FW is tasked with configuring and enabling, and
all other state is private to the instance.

If we have to poke things to make them usable, that means we can't
assume that it's always safe to use the timers or counters, as the
architecture lets us, and I'd like to understand what the impact is.

e.g. does this mean that there are windows where the counters don't
tick?

Are all the counters fed the same underlying counter value? ... or are
those independent?

Thanks,
Mark.

> This patch adds a mode of cooperation with arch_timer driver, so
> kernel can use CP15 based timer interface via arch_timer driver, which
> is mandatory on ARM64. In such mode driver only configures MCT
> registers and starts the timer but don't register any clocksource or
> events in the system. Those are left to be handled by arch_timer
> driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 52 +++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index a379f11fad2d..06cd30a6d59a 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -57,6 +57,7 @@
>  #define TICK_BASE_CNT	1
>  
>  enum {
> +	MCT_INT_NONE = 0,
>  	MCT_INT_SPI,
>  	MCT_INT_PPI
>  };
> @@ -238,6 +239,9 @@ static int __init exynos4_clocksource_init(void)
>  {
>  	exynos4_mct_frc_start();
>  
> +	if (!mct_int_type)
> +		return 0;
> +
>  #if defined(CONFIG_ARM)
>  	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
>  	exynos4_delay_timer.freq = clk_rate;
> @@ -343,6 +347,9 @@ static struct irqaction mct_comp_event_irq = {
>  
>  static int exynos4_clockevent_init(void)
>  {
> +	if (!mct_int_type)
> +		return 0;
> +
>  	mct_comp_device.cpumask = cpumask_of(0);
>  	clockevents_config_and_register(&mct_comp_device, clk_rate,
>  					0xf, 0xffffffff);
> @@ -476,12 +483,12 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>  
>  		irq_force_affinity(evt->irq, cpumask_of(cpu));
>  		enable_irq(evt->irq);
> -	} else {
> +	} else if (mct_int_type == MCT_INT_PPI) {
>  		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>  	}
> -	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
> -					0xf, 0x7fffffff);
> -
> +	if (mct_int_type)
> +		clockevents_config_and_register(evt,
> +			       clk_rate / (TICK_BASE_CNT + 1), 0xf, 0x7fffffff);
>  	return 0;
>  }
>  
> @@ -496,7 +503,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
>  		if (evt->irq != -1)
>  			disable_irq_nosync(evt->irq);
>  		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
> -	} else {
> +	} else if (mct_int_type == MCT_INT_PPI) {
>  		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
>  	}
>  	return 0;
> @@ -529,7 +536,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  					 &percpu_mct_tick);
>  		WARN(err, "MCT: can't request IRQ %d (%d)\n",
>  		     mct_irqs[MCT_L0_IRQ], err);
> -	} else {
> +	} else if (mct_int_type == MCT_INT_SPI) {
>  		for_each_possible_cpu(cpu) {
>  			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
>  			struct mct_clock_event_device *pcpu_mevt =
> @@ -564,7 +571,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  out_irq:
>  	if (mct_int_type == MCT_INT_PPI) {
>  		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> -	} else {
> +	} else if (mct_int_type == MCT_INT_SPI) {
>  		for_each_possible_cpu(cpu) {
>  			struct mct_clock_event_device *pcpu_mevt =
>  				per_cpu_ptr(&percpu_mct_tick, cpu);
> @@ -585,17 +592,28 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>  
>  	mct_int_type = int_type;
>  
> -	/* This driver uses only one global timer interrupt */
> -	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
> +		struct device_node *np = of_find_compatible_node(NULL, NULL,
> +							     "arm,armv8-timer");
> +		if (np) {
> +			mct_int_type = MCT_INT_NONE;
> +			of_node_put(np);
> +		}
> +	}
>  
> -	/*
> -	 * Find out the number of local irqs specified. The local
> -	 * timer irqs are specified after the four global timer
> -	 * irqs are specified.
> -	 */
> -	nr_irqs = of_irq_count(np);
> -	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> -		mct_irqs[i] = irq_of_parse_and_map(np, i);
> +	if (mct_int_type) {
> +		/* This driver uses only one global timer interrupt */
> +		mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +
> +		/*
> +		 * Find out the number of local irqs specified. The local
> +		 * timer irqs are specified after the four global timer
> +		 * irqs are specified.
> +		 */
> +		nr_irqs = of_irq_count(np);
> +		for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> +			mct_irqs[i] = irq_of_parse_and_map(np, i);
> +	}
>  
>  	ret = exynos4_timer_resources(np, of_iomap(np, 0));
>  	if (ret)
> -- 
> 2.17.1
> 
