Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F0ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BFF208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BFF208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeGMJrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:47:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbeGMJrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:47:40 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B326FF52861AC;
        Fri, 13 Jul 2018 17:33:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Fri, 13 Jul 2018
 17:33:32 +0800
Subject: Re: [PATCH] isdn/capi: hide unused procfs helpers
To:     <isdn@linux-pingi.de>
References: <20180713041114.16112-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <keescook@chromium.org>, <viro@zeniv.linux.org.uk>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <73c5ff9a-1da9-d42a-6b68-ae90fcf77f49@huawei.com>
Date:   Fri, 13 Jul 2018 17:33:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180713041114.16112-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pls ignore this,there has a fix from Randy.

On 2018/7/13 12:11, YueHaibing wrote:
> When CONFIG_PROC_FS isn't set, gcc warning this:
> 
> drivers/isdn/capi/capi.c:1324:12: warning: ‘capi20_proc_show’ defined but not used [-Wunused-function]
>  static int capi20_proc_show(struct seq_file *m, void *v)
>             ^
> drivers/isdn/capi/capi.c:1347:12: warning: ‘capi20ncci_proc_show’ defined but not used [-Wunused-function]
>  static int capi20ncci_proc_show(struct seq_file *m, void *v)
>             ^
> drivers/isdn/capi/capidrv.c:2454:12: warning: ‘capidrv_proc_show’ defined but not used [-Wunused-function]
>  static int capidrv_proc_show(struct seq_file *m, void *v)
>             ^
> 
> We can fix the warning by adding the same #ifdef around them.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/isdn/capi/capi.c    | 2 ++
>  drivers/isdn/capi/capidrv.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
> index 6e0c281..594f767 100644
> --- a/drivers/isdn/capi/capi.c
> +++ b/drivers/isdn/capi/capi.c
> @@ -1317,6 +1317,7 @@ static inline void capinc_tty_exit(void) { }
>  
>  /* -------- /proc functions ----------------------------------------- */
>  
> +#ifdef CONFIG_PROC_FS
>  /*
>   * /proc/capi/capi20:
>   *  minor applid nrecvctlpkt nrecvdatapkt nsendctlpkt nsenddatapkt
> @@ -1359,6 +1360,7 @@ static int capi20ncci_proc_show(struct seq_file *m, void *v)
>  	mutex_unlock(&capidev_list_lock);
>  	return 0;
>  }
> +#endif
>  
>  static void __init proc_init(void)
>  {
> diff --git a/drivers/isdn/capi/capidrv.c b/drivers/isdn/capi/capidrv.c
> index ee510f9..c6f45d7 100644
> --- a/drivers/isdn/capi/capidrv.c
> +++ b/drivers/isdn/capi/capidrv.c
> @@ -2447,6 +2447,7 @@ lower_callback(struct notifier_block *nb, unsigned long val, void *v)
>  	return NOTIFY_OK;
>  }
>  
> +#ifdef CONFIG_PROC_FS
>  /*
>   * /proc/capi/capidrv:
>   * nrecvctlpkt nrecvdatapkt nsendctlpkt nsenddatapkt
> @@ -2460,6 +2461,7 @@ static int capidrv_proc_show(struct seq_file *m, void *v)
>  		   global.ap.nsentdatapkt);
>  	return 0;
>  }
> +#endif
>  
>  static void __init proc_init(void)
>  {
> 

