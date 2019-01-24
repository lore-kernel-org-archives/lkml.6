Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F78AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606EE218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfAXKnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:43:47 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47467 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfAXKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:43:47 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id be03aa87e1fdeec5; Thu, 24 Jan 2019 11:43:45 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: qos: no need to check return value of debugfs_create functions
Date:   Thu, 24 Jan 2019 11:42:45 +0100
Message-ID: <7412175.ooW4tQdR9c@aspire.rjw.lan>
In-Reply-To: <20190122152151.16139-48-gregkh@linuxfoundation.org>
References: <20190122152151.16139-48-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 22, 2019 4:21:47 PM CET Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/power/qos.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index b7a82502857a..9d22131afc1e 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -582,10 +582,8 @@ static int register_pm_qos_misc(struct pm_qos_object *qos, struct dentry *d)
>  	qos->pm_qos_power_miscdev.name = qos->name;
>  	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
>  
> -	if (d) {
> -		(void)debugfs_create_file(qos->name, S_IRUGO, d,
> -					  (void *)qos, &pm_qos_debug_fops);
> -	}
> +	debugfs_create_file(qos->name, S_IRUGO, d, (void *)qos,
> +			    &pm_qos_debug_fops);
>  
>  	return misc_register(&qos->pm_qos_power_miscdev);
>  }
> @@ -685,8 +683,6 @@ static int __init pm_qos_power_init(void)
>  	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
>  
>  	d = debugfs_create_dir("pm_qos", NULL);
> -	if (IS_ERR_OR_NULL(d))
> -		d = NULL;
>  
>  	for (i = PM_QOS_CPU_DMA_LATENCY; i < PM_QOS_NUM_CLASSES; i++) {
>  		ret = register_pm_qos_misc(pm_qos_array[i], d);
> 

Applied, thanks!


