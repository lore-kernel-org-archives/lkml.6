Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A6C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0F920840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfAPDil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 22:38:41 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:56960 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730481AbfAPDil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 22:38:41 -0500
X-Greylist: delayed 4074 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 22:38:40 EST
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0G2QA3P029498;
        Wed, 16 Jan 2019 02:30:25 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 2q1qvj9dn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jan 2019 02:30:25 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 9DD0957;
        Wed, 16 Jan 2019 02:30:23 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id CCBF458;
        Wed, 16 Jan 2019 02:30:22 +0000 (UTC)
Date:   Tue, 15 Jan 2019 19:30:22 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 4/4] watchdog: hpwdt: Make panic behaviour
 configurable
Message-ID: <20190116023022.GE18342@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
 <20190114023617.10656-5-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114023617.10656-5-mironov.ivan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 07:36:17AM +0500, Ivan Mironov wrote:
> This adds an option to not panic on NMI even if it was caused by iLO.
> 
> Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> ---
>  drivers/watchdog/hpwdt.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 95d002b5b120..b12858491189 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -37,6 +37,10 @@ static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  static bool pretimeout = IS_ENABLED(CONFIG_HPWDT_NMI_DECODING);
>  
> +#ifdef CONFIG_HPWDT_NMI_DECODING
> +static bool panic_on_nmi = true;
> +#endif /* CONFIG_HPWDT_NMI_DECODING */
> +
>  static void __iomem *pci_mem_addr;		/* the PCI-memory address */
>  static unsigned long __iomem *hpwdt_nmistat;
>  static unsigned long __iomem *hpwdt_timer_reg;
> @@ -146,7 +150,10 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
>  
>  static int hpwdt_my_nmi(void)
>  {
> -	return ioread8(hpwdt_nmistat) & 0x6;
> +	int nmistat = ioread8(hpwdt_nmistat);
> +
> +	iowrite8(nmistat & ~0x6, hpwdt_nmistat);
> +	return nmistat & 0x6;


This is a read only register.


>  }
>  
>  /*
> @@ -168,7 +175,10 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  		 "4. iLO Event Log\n",
>  		 mynmi, ulReason, smp_processor_id());
>  
> -	nmi_panic(regs, "hpwdt: NMI: Not continuing");
> +	if (panic_on_nmi)
> +		nmi_panic(regs, "hpwdt: NMI: Not continuing");
> +
> +	pr_emerg("Dazed and confused, but trying to continue\n");
>  


The watchdog core provides a way to enable/disable the NMI pretimeout dynamically
via ioctl.  The pretimeout NMI can also be disabled via module parameter to hpwdt.
This adds complexity without really adding functionality.


BTW, don't reuse error messages.  Makes it difficult to tell where the error
originated from.


>  	return NMI_HANDLED;
>  }
> @@ -376,6 +386,9 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  #ifdef CONFIG_HPWDT_NMI_DECODING
>  module_param(pretimeout, bool, 0);
>  MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
> -#endif
> +
> +module_param(panic_on_nmi, bool, 0);
> +MODULE_PARM_DESC(panic_on_nmi, "Cause panic on NMI induced by iLO (default=1)");
> +#endif /* CONFIG_HPWDT_NMI_DECODING */
>  
>  module_pci_driver(hpwdt_driver);
> -- 
> 2.20.1

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
