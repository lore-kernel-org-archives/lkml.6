Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6840B2177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="qaUv81LK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6840B2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeHCTrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:47:02 -0400
Received: from mail-eopbgr720119.outbound.protection.outlook.com ([40.107.72.119]:45381
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727377AbeHCTrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rjNXl71zdUOCxXysT4AlNOu/+Av7MTUvG8XQkixjiw=;
 b=qaUv81LKX8ojguZd45UTk9fwP5j1ENitd6DnQyufdLncey2xO3ypLo6D/4hI3K3JUcXUXvt9x9ZSRJymwzDN11mBgC4kJeMPi9pA7n2ThA9VPpXW6Pi6tX9eMJygMCaX4CoFWsmkHY1tUVT/LnDhJkXYgZAiksyh4a4RypENC9w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4929.namprd08.prod.outlook.com (2603:10b6:408:28::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Fri, 3 Aug 2018 17:49:27 +0000
Date:   Fri, 3 Aug 2018 10:49:24 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 01/18] MIPS: intel: Add initial support for Intel MIPS
 SoCs
Message-ID: <20180803174924.iqzmbtz5hrf5dlzu@pburton-laptop>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-2-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803030237.3366-2-songjun.wu@linux.intel.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM3PR12CA0063.namprd12.prod.outlook.com
 (2603:10b6:0:56::31) To BN7PR08MB4929.namprd08.prod.outlook.com
 (2603:10b6:408:28::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04e3d5d4-a213-488a-f705-08d5f9697580
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;3:SDD+xhSG16tdSU8YNihBazT8CyBeLyvGSUz7MmEhvcZqHW1qD0iRp5sP+w3zeT6beBBiYhjNKon4I7G5B/WgMsPTrurdyjazdbRBbZGjdEsf6Tqd4o4WzbxwljQpvkBUSv08aEpcWaPyXrJL2iIi71yokCvllbj7BwF19hnwNjESzdrR4CJkWzqIUVJFzzY/MgsqmmFYzyOMwYGnrPx3/n7HVtG07k1BaREV9jITKrAgKIYFA0aAOnr9lOeLQ1Ki;25:WGH8nD7QXUbBr4zLt7z+sMu9axjxzWiAETvU457BUrcCyxILHG03thMb+YAV+eLqqjSnnm7oHmkRQIY+hRG2evEd8RzfEeFVNHToXO8CIbbbfrI7Iwrq5uqRatY2JPnHculN0BfIFdV6LuumoAORe3J+tQ/XM07FLA7e8ESkNd7ExJLzfeBBl/HF9dh2Q8bpeeQUWV4glGWXlMfSWuFJ7BMKhHYioALuyaEHPpjgwsJzCvmO3tEVCsrgfN4JFEElYhi57dVKj/eucSIm9g026oMWVzzvIQDlqgxEhen2l+qPnPx/KZMkivYTdTITDgtCT0suq3KgmWGSiJN3tYHreA==;31:mei1vIfigCQriQiVegub042AfQK6bqo5H6eTDGtXmcM6zYhnBhdd7oh71bArQNcYJrgjR7eHyx+iSnOCUTPSkexEvM3+3qUSovlX5pEEwI9J3SUSpFGDpewTWzKR9otVCEgl0Q6QFMJvrnZQi2654uf/c5GXCCgAbfRW6c9Fns0E0PdtEixEyQlQvn9cTI1/cf/cSk1OuhX7IociPCGDJ5/6v8bulhc1OyDmDJU5CyY=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;20:LuCc34ENMOB5zq+DWWwwjmyNbK5367xdwBkMRTCQ8VKn0zlJ5+eCXfZz/RsJuYsIwxJNwjXfZmZMo74eIi54Sbj6UuBXpBo2xQYxzJ4aBV6on4QRCbVwQPWmCJxEQir3kRDr+rtuPyt05PakJl8VjVoPSm1kVYhM0hSV4OdJGt8ASF5uKpFAZiw/wH/KoCnjH8oCrqQgfKjuiji4DkwWbxYNoDub0dUwZnaUwyARo4/yh1EOjyeSj/cWQmP75ryq;4:8nHKmAQ0KypwRgf9Ukrt3pMihJpffbyQ5rKoRdZ5i94ROD2MBOmRn+dRJHyhXWncTHUvDOVoX9zf/15Ut6bInNlm9UgC2WuXKVE82OU+Dgk9x37Ht/KmtPPPLAUCWfqMwmToxj6b6UjeFrcpXJbk79He0pPPLl54ngF8h4HYvwhu/XwGQb5+siRRQA5x0tghHRfJi+2WlOkN3mL2bTiZaJr7Lf7H0PLdFXVyc5vWajXqYhIb2WmbX1r3bBpkbn2YuyMsSIEibQ8gc0+quK7SwfWsPeQkFGAMDfrdALxpdcEz554FCdnrgYU67cmaP3mL+RPg9OsDOQPuLtuO+FGA7g==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4929DE225A8FBFB5B51ADBF2C1230@BN7PR08MB4929.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4929;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4929;
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(6029001)(7916004)(39840400004)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(52314003)(6916009)(6666003)(7736002)(14444005)(7416002)(8936002)(6486002)(66066001)(97736004)(23726003)(25786009)(305945005)(68736007)(2906002)(106356001)(105586002)(5660300001)(1076002)(3846002)(6116002)(81156014)(47776003)(81166006)(8676002)(76506005)(478600001)(229853002)(9686003)(4326008)(76176011)(446003)(956004)(44832011)(186003)(11346002)(6496006)(476003)(58126008)(16526019)(16586007)(316002)(53936002)(50466002)(33896004)(386003)(26005)(52116002)(33716001)(6246003)(486006)(54906003)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4929;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4929;23:kp5wxzml9Wc3bWUIHQRH2xsfT7iWQXWETCWHOGWy6?=
 =?us-ascii?Q?yme2hYAxW4xknO2tO77H+rMjIHc5ucdG8T/0G1JhBFBX+wyPaJ076XlyoEj5?=
 =?us-ascii?Q?pFx4dqmQ0QSVHxuPzWkFWv4exDwToCEhkqHipDQs5vl9qjtWga+MyrrvP/iJ?=
 =?us-ascii?Q?3FgvHN0EEUAIuWAtDegWAoYFnkw4ADIB8xY+vspakO6nOW32l/BmjbW4QOan?=
 =?us-ascii?Q?AIABAbN/H4d86D6bfhiQqQnogOsq4nsdb1kyRCPUyrRfJWBAzpzNeKVuOt1K?=
 =?us-ascii?Q?0TzLJxyIznfxv67t4KmQSJVoLopQfUk0Kdg/AQwCHRJKmWa92nS37hSygkvx?=
 =?us-ascii?Q?53btyjWX1yfABQ5RpAi0r8Ro2H8E0N2Ls9o7EcsNIQTaVutthOwM50s57BrK?=
 =?us-ascii?Q?CoechUM0igFpw7HmSY4ymyz2MUahmcwyxjzlZgXm1N3iaVVE8D6CFnfzqUNd?=
 =?us-ascii?Q?I1FKl/a7VzWs0Lt+bIOEDY5K+bm5l/uZqY9Xb6eamhCuqGO5gTKiy1cNjrRS?=
 =?us-ascii?Q?oSxXZj3f+AUDSwLAfsMd8d/C9O3S8GVXvaa+DUmUfW63ccZBfL2YEeCkLb4X?=
 =?us-ascii?Q?sWg1rdxVt/53a13zm9uPZNSFruw10vvxL9ygXU5KhL2B3qPiIqWPMvEmJrFZ?=
 =?us-ascii?Q?H8HM5sjsmVPi8/uaAh8sQziFJFtGHNz+qqIzSGJi7vaJEOs25ATs64umI73w?=
 =?us-ascii?Q?Xm0OraNrfWi0IUtq4+WUUsjuM/2qgy4Zh/LG4jogMhSc4doYtQ1ZPVyOHIL0?=
 =?us-ascii?Q?XbuK+igbEThIaDNcMW3+D7ndb7p9+jGClW/MCp0fJXthOmRffWA/v0nlS0Hh?=
 =?us-ascii?Q?mXH1x7t5sP9jzN6laJQjXTbquzk964NQbAQ3Mc1vNi20DZZuU0pf1kn9sjE8?=
 =?us-ascii?Q?ZYCbJheZmV5oFudt6Ek5qSqffWhYceKzu22d1rrKFW9AFkhTcYGEdUVa5D04?=
 =?us-ascii?Q?SCPpOOSwDA6kqNcjiyCX802xmwn/bq7r1qNU1X51VP3yR9J1uiJUgqcUcUg5?=
 =?us-ascii?Q?nKQvv0M8XL4ASWGkEHmdSM0VbYC+fQAD43qP4AUAEjLDeFc5xpaKKiAdQmKc?=
 =?us-ascii?Q?vkTuoc8I2TOp5H4BBW9cReKx0mS7UN6J0fvk8HuIWbmkrF/u+ZlnReFScD1O?=
 =?us-ascii?Q?9tOgNEtEbDidfEM7GbWUhAOBIAX0HpL2RAvO/3HSXWHBz5I5srNP9AxCkEuH?=
 =?us-ascii?Q?Igno2adVi/F6rmR6a5RbUD292QLU9UgjJY28KQXVyfREBWXpDKEjz0HUJup+?=
 =?us-ascii?Q?orXv2qLc3n1HXSFTEYe5pDZKMGligf0QmiUQO/0ojktn2RmZBFdfuUcSdEiZ?=
 =?us-ascii?Q?cSYvEPWtTWk38Vom364tyFPuX7KUmR+HWK8gZfFAJjxIs23ZOsO0W4d2cLEB?=
 =?us-ascii?Q?Ale8SkKVxc12psMzre40yRFpMWMXaruOFij9rvxUQy6hg1Z?=
X-Microsoft-Antispam-Message-Info: gsZzhlouEmtI+17afDEaAkPmixSVeKiq1K6ZZSHxfmfDNmEn8SDUqJ6sbnfPzSWZ0oKg0xELCkLDHv4DhY6GSDB1Jmvhu3VZGErLw4G+2tI0lIZ2qyQBDV94mXGcm27j0VrcJdglKFr3SuRkK/OgcfalH2Ag82yxq//uS+w0nk8XHOyWOXqTcGYbkcfJzye6u5lFI6l1DhEuKCDDx1an9GVS1xyblKWGGTthF1FO2YSxI/lm8KB4g9Tk6j5N79C0eTMt3ur3hjpP9bNoDAgSWS9W3nLyW1Jq5CIPlmm60lGjWPlm/UbF8yPN08V/usyLoJ7PMK1GBDnjZIPqlOqxfjE2zsokx6n3eaMN0B8hWnE=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4929;6:A7d7nYSa9zxbJG01AZ3dN+lvv2l67pfvh5xImmp9fgzW7LWiVDsB4E7QHR+a01Ga9cSgU7DnaQoLTqVl+R5GZvT6ULYxrS+lEZZ+JOGBgo07KnxBm3XSLtBQNd2lhWuRGzFEMqY1cE7WGvDO6YXy1XX1XiA/CjO7+i9ZWJKhcm9quBB0epre/hgGOe1jd1VaUY/i/SdCt9uCoB2B7/KdRFIClOA9KV9q26mnkRY0oI4pUSUGh+Y1JkBq+JmSp3Xrl02kmw18O+QON9ppeVXAYTIjjbWZuEd+WLuNe1gqGICxSDWjaIXqYpH5P6LZ+1nWRzV1Cn7KaW/lkMVPi7WM8Nu09vVtXgwZDAhUbQ1A8SceFUxc/7lILlJiGsj1j82rZOBq5W8PGcYTHd5a/hOypmKe15siqa+epRgR79ItzTs011yZIYd3qvssqyiP3b6LmimMYVR2X4zmaFwTPt5D9A==;5:gO4lxq1sJDbXrnf5/RFxoFzfJwYp1xFPwVp/fRI+AiRPwpCoj9ZCW4ugMmI/xVLZ7MSyd7bsuAOUdVJHZJjxVWFPRfxNmAN6K1UwWbsj0rw0epg3JHIzokbZfNAmg5BroTuhkz6wjeXmYla3ei5eM+Db5kQNOPK5i0w8FxYerMc=;7:Vj55LMHKqrK8HW8ePSEDahrNHRG13uNBb2SZGu3Cm7pQqFGHcSFaRol9vk81MnqmnfNy5+JyDgNAP91x9aX4x0RYvHdCk/ETHXT/zKEY2dNuUthMWAY+xu/H6k9UOcY1x5V+3ZzppQgmk8yrxhWvfPfQ12kvUYyOdjIzEjKjRkchgAXqC6jNRfRzJYVVFc0BAkDoCO3wQ/EHfp/A5XF2Ft/LQXf1/WDDUOXnGkUy4qXDt6BgVsYjASHW5OM9iSAN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:49:27.9290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e3d5d4-a213-488a-f705-08d5f9697580
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Songjun / Hua,

On Fri, Aug 03, 2018 at 11:02:20AM +0800, Songjun Wu wrote:
> From: Hua Ma <hua.ma@linux.intel.com>
> 
> Add initial support for Intel MIPS interAptiv SoCs made by Intel.
> This series will add support for the grx500 family.
> 
> The series allows booting a minimal system using a initramfs.

Thanks for submitting this - I have some comments below.

> diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
> index ac7ad54f984f..bcd647060f3e 100644
> --- a/arch/mips/Kbuild.platforms
> +++ b/arch/mips/Kbuild.platforms
> @@ -12,6 +12,7 @@ platforms += cobalt
>  platforms += dec
>  platforms += emma
>  platforms += generic
> +platforms += intel-mips
>  platforms += jazz
>  platforms += jz4740
>  platforms += lantiq

Oh EVA, why must you ruin nice things... Ideally I'd be suggesting that
we use the generic platform but it doesn't yet have a nice way to deal
with non-standard EVA setups.

It would be good if we could make sure that's the only reason for your
custom platform though, so that once generic does support EVA we can
migrate your system over. Most notably, it would be good to make use of
the UHI-specified boot protocol if possible (ie. $r4==-2, $r5==&dtb).

It looks like your prom_init_cmdline() supports multiple boot protocols
- could you clarify which is actually used?

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 08c10c518f83..2d34f17f3e24 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -409,6 +409,34 @@ config LANTIQ
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select RESET_CONTROLLER
>  
> +config INTEL_MIPS
> +	bool "Intel MIPS interAptiv SoC based platforms"
> +	select BOOT_RAW
> +	select CEVT_R4K
> +	select COMMON_CLK
> +	select CPU_MIPS32_3_5_EVA
> +	select CPU_MIPS32_3_5_FEATURES
> +	select CPU_MIPSR2_IRQ_EI
> +	select CPU_MIPSR2_IRQ_VI
> +	select CSRC_R4K
> +	select DMA_NONCOHERENT
> +	select GENERIC_ISA_DMA
> +	select IRQ_MIPS_CPU
> +	select MFD_CORE
> +	select MFD_SYSCON
> +	select MIPS_CPU_SCACHE
> +	select MIPS_GIC
> +	select SYS_HAS_CPU_MIPS32_R1

For a system based on interAptiv you should never need to build a
MIPS32r1 kernel, so you should remove the above select.

> diff --git a/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h b/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
> new file mode 100644
> index 000000000000..ac5f3b943d2a
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This file was derived from: include/asm-mips/cpu-features.h
> + *	Copyright (C) 2003, 2004 Ralf Baechle
> + *	Copyright (C) 2004 Maciej W. Rozycki
> + *	Copyright (C) 2018 Intel Corporation.
> + */
> +
> +#ifndef __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H
> +#define __ASM_MACH_INTEL_MIPS_CPU_FEATURE_OVERRIDES_H
> +
> +#define cpu_has_tlb		1
> +#define cpu_has_4kex		1
> +#define cpu_has_3k_cache	0
> +#define cpu_has_4k_cache	1
> +#define cpu_has_tx39_cache	0
> +#define cpu_has_sb1_cache	0
> +#define cpu_has_fpu		0
> +#define cpu_has_32fpr		0
> +#define cpu_has_counter		1
> +#define cpu_has_watch		1
> +#define cpu_has_divec		1
> +
> +#define cpu_has_prefetch	1
> +#define cpu_has_ejtag		1
> +#define cpu_has_llsc		1
> +
> +#define cpu_has_mips16		0
> +#define cpu_has_mdmx		0
> +#define cpu_has_mips3d		0
> +#define cpu_has_smartmips	0
> +#define cpu_has_mmips		0
> +#define cpu_has_vz		0
> +
> +#define cpu_has_mips32r1	1
> +#define cpu_has_mips32r2	1
> +#define cpu_has_mips64r1	0
> +#define cpu_has_mips64r2	0
> +
> +#define cpu_has_dsp		1
> +#define cpu_has_dsp2		0
> +#define cpu_has_mipsmt		1
> +
> +#define cpu_has_vint		1
> +#define cpu_has_veic		0
> +
> +#define cpu_has_64bits		0
> +#define cpu_has_64bit_zero_reg	0
> +#define cpu_has_64bit_gp_regs	0
> +#define cpu_has_64bit_addresses	0
> +
> +#define cpu_has_cm2		1
> +#define cpu_has_cm2_l2sync	1
> +#define cpu_has_eva		1
> +#define cpu_has_tlbinv		1
> +
> +#define cpu_dcache_line_size()	32
> +#define cpu_icache_line_size()	32
> +#define cpu_scache_line_size()	32

If you rebase atop linux-next or mips-next then you should find that
many of these defines are now redundant, especially after removing the
SYS_HAS_CPU_MIPS32_R1 select which means your kernel build will always
target MIPS32r2.

Due to architectural restrictions on where various options can be
present, you should be able to remove:

  - cpu_has_4kex
  - cpu_has_3k_cache
  - cpu_has_4k_cache
  - cpu_has_32fpr
  - cpu_has_divec
  - cpu_has_prefetch
  - cpu_has_llsc

cpu_has_mmips defaults to a compile-time zero unless you select
CONFIG_SYS_SUPPORTS_MICROMIPS, so please remove that one.

cpu_has_64bit_gp_regs & cpu_has_64bit_addresses both default to zero
already for 32bit kernel builds, so please remove those.

cpu_has_cm2 & cpu_has_cm2_l2sync don't exist anywhere in-tree, so please
remove those.

Additionally cpu_has_sb1_cache is not used anywhere, or defined by
asm/cpu-features.h & seems to just be left over in some platform
override files including presumably one you based yours on. Please
remove it too.

Also you select CPU_MIPSR2_IRQ_EI but define cpu_has_veic as 0, could
you check that mismatch?

> diff --git a/arch/mips/include/asm/mach-intel-mips/irq.h b/arch/mips/include/asm/mach-intel-mips/irq.h
> new file mode 100644
> index 000000000000..12a949084856
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-intel-mips/irq.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2014 Lei Chuanhua <Chuanhua.lei@lantiq.com>
> + *  Copyright (C) 2018 Intel Corporation.
> + */
> +
> +#ifndef __INTEL_MIPS_IRQ_H
> +#define __INTEL_MIPS_IRQ_H
> +
> +#define MIPS_CPU_IRQ_BASE	0
> +#define MIPS_GIC_IRQ_BASE	(MIPS_CPU_IRQ_BASE + 8)

These 2 defines are the defaults anyway, so please remove them.

> +#define NR_IRQS 256

And if you don't actually need this then you could remove irq.h entirely
- do you actually use more than 128 IRQs?

> diff --git a/arch/mips/include/asm/mach-intel-mips/spaces.h b/arch/mips/include/asm/mach-intel-mips/spaces.h
> new file mode 100644
> index 000000000000..80e7b09f712c
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-intel-mips/spaces.h
>% >% >%
> +#define IO_SIZE			_AC(0x10000000, UL)
> +#define IO_SHIFT		_AC(0x10000000, UL)

These IO_ defines don't appear to be used anywhere?

> +/* IO space one */
> +#define __pa_symbol(x)		__pa(x)

Can you explain why you need this, rather than the default definition of
__pa_symbol()? The comment doesn't seem to describe much of anything.

> diff --git a/arch/mips/include/asm/mach-intel-mips/war.h b/arch/mips/include/asm/mach-intel-mips/war.h
> new file mode 100644
> index 000000000000..1c95553151e1
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-intel-mips/war.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MIPS_MACH_INTEL_MIPS_WAR_H
> +#define __ASM_MIPS_MACH_INTEL_MIPS_WAR_H
> +
> +#define R4600_V1_INDEX_ICACHEOP_WAR	0
> +#define R4600_V1_HIT_CACHEOP_WAR	0
> +#define R4600_V2_HIT_CACHEOP_WAR	0
> +#define R5432_CP0_INTERRUPT_WAR		0
> +#define BCM1250_M3_WAR			0
> +#define SIBYTE_1956_WAR			0
> +#define MIPS4K_ICACHE_REFILL_WAR	0
> +#define MIPS_CACHE_SYNC_WAR		0
> +#define TX49XX_ICACHE_INDEX_INV_WAR	0
> +#define ICACHE_REFILLS_WORKAROUND_WAR	0
> +#define R10000_LLSC_WAR			0
> +#define MIPS34K_MISSED_ITLB_WAR		0
> +
> +#endif /* __ASM_MIPS_MACH_INTEL_MIPS_WAR_H */

Since you need none of these workarounds, you shouldn't need war.h at
all.

> diff --git a/arch/mips/intel-mips/Kconfig b/arch/mips/intel-mips/Kconfig
> new file mode 100644
> index 000000000000..35d2ae2b5408
> --- /dev/null
> +++ b/arch/mips/intel-mips/Kconfig
> @@ -0,0 +1,22 @@
> +if INTEL_MIPS
> +
> +choice
> +	prompt "Built-in device tree"
> +	help
> +	  Legacy bootloaders do not pass a DTB pointer to the kernel, so
> +	  if a "wrapper" is not being used, the kernel will need to include
> +	  a device tree that matches the target board.
> +
> +	  The builtin DTB will only be used if the firmware does not supply
> +	  a valid DTB.
> +
> +config DTB_INTEL_MIPS_NONE
> +	bool "None"
> +
> +config DTB_INTEL_MIPS_GRX500
> +	bool "Intel MIPS GRX500 Board"
> +	select BUILTIN_DTB
> +
> +endchoice
> +
> +endif

So do you actually have both styles of bootloader?

> diff --git a/arch/mips/intel-mips/prom.c b/arch/mips/intel-mips/prom.c
> new file mode 100644
> index 000000000000..a1b1393c13bc
> --- /dev/null
> +++ b/arch/mips/intel-mips/prom.c
>% >% >%
> +static void __init prom_init_cmdline(void)
> +{
> +	int i;
> +	int argc;
> +	char **argv;
> +
> +	/*
> +	 * If u-boot pass parameters, it is ok, however, if without u-boot
> +	 * JTAG or other tool has to reset all register value before it goes
> +	 * emulation most likely belongs to this category
> +	 */
> +	if (fw_arg0 == 0 || fw_arg1 == 0)
> +		return;

I don't understand what you're trying to say here, or why this check
exists. If you boot with fw_arg0 == fw_arg1 == 0 then you'd just hit the
loop below right, and execute zero iterations of it? That seems like it
would be fine without this special case.

> +	/*
> +	 * a0: fw_arg0 - the number of string in init cmdline
> +	 * a1: fw_arg1 - the address of string in init cmdline
> +	 *
> +	 * In accordance with the MIPS UHI specification,
> +	 * the bootloader can pass the following arguments to the kernel:
> +	 * - $a0: -2.
> +	 * - $a1: KSEG0 address of the flattened device-tree blob.
> +	 */
> +	if (fw_arg0 == -2)
> +		return;
> +
> +	argc = fw_arg0;
> +	argv = (char **)KSEG1ADDR(fw_arg1);
> +
> +	arcs_cmdline[0] = '\0';
> +
> +	for (i = 0; i < argc; i++) {
> +		char *p = (char *)KSEG1ADDR(argv[i]);
> +
> +		if (argv[i] && *p) {
> +			strlcat(arcs_cmdline, p, sizeof(arcs_cmdline));
> +			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
> +		}
> +	}

Why do you need to use kseg1? Why can't the arguments be accessed
cached?

Are the arguments passed as virtual or physical addresses? If virtual &
we can access them cached then you could replace all of this with a call
to fw_init_cmdline().

> +static int __init plat_enable_iocoherency(void)
> +{
> +	if (!mips_cps_numiocu(0))
> +		return 0;
> +
> +	/* Nothing special needs to be done to enable coherency */
> +	pr_info("Coherence Manager IOCU detected\n");
> +	/* Second IOCU for MPE or other master access register */
> +	write_gcr_reg0_base(0xa0000000);
> +	write_gcr_reg0_mask(0xf8000000 | CM_GCR_REGn_MASK_CMTGT_IOCU1);
> +	return 1;
> +}
> +
> +static void __init plat_setup_iocoherency(void)
> +{
> +	if (plat_enable_iocoherency() &&
> +	    coherentio == IO_COHERENCE_DISABLED) {
> +		pr_info("Hardware DMA cache coherency disabled\n");
> +		return;
> +	}
> +	panic("This kind of IO coherency is not supported!");
> +}

Since you select CONFIG_DMA_NONCOHERENT in Kconfig, coherentio will
always equal IO_COHERENCE_DISABLED. That suggests to me that the above 2
functions are probably useless, or at least needlessly convoluted.

> +static int __init plat_publish_devices(void)
> +{
> +	if (!of_have_populated_dt())
> +		return 0;
> +	return of_platform_populate(NULL, of_default_bus_match_table, NULL,
> +				    NULL);
> +}
> +arch_initcall(plat_publish_devices);

The core DT code calls of_platform_populate() already (see
of_platform_default_populate_init()), so you can remove this function.

Thanks,
    Paul
