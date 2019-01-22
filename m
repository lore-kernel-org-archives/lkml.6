Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F19C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5620823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfAVQIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:08:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfAVQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:08:02 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1glyal-0000Lm-O2; Tue, 22 Jan 2019 17:07:59 +0100
Date:   Tue, 22 Jan 2019 17:07:59 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] backing-dev: no need to check return value of
 debugfs_create functions
Message-ID: <20190122160759.mx3h7gjc23zmrvxc@linutronix.de>
References: <20190122152151.16139-8-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-8-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-22 16:21:07 [+0100], Greg Kroah-Hartman wrote:
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 8a8bb8796c6c..85ef344a9c67 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -102,39 +102,25 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
>  }
>  DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
>  
> -static int bdi_debug_register(struct backing_dev_info *bdi, const char *name)
> +static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
>  {
> -	if (!bdi_debug_root)
> -		return -ENOMEM;
> -
>  	bdi->debug_dir = debugfs_create_dir(name, bdi_debug_root);

If this fails then ->debug_dir is NULL 

> -	if (!bdi->debug_dir)
> -		return -ENOMEM;
> -
> -	bdi->debug_stats = debugfs_create_file("stats", 0444, bdi->debug_dir,
> -					       bdi, &bdi_debug_stats_fops);
> -	if (!bdi->debug_stats) {
> -		debugfs_remove(bdi->debug_dir);
> -		bdi->debug_dir = NULL;
> -		return -ENOMEM;
> -	}
>  
> -	return 0;
> +	debugfs_create_file("stats", 0444, bdi->debug_dir, bdi,
> +			    &bdi_debug_stats_fops);

then this creates the stats file in the root folder and

>  }
>  
>  static void bdi_debug_unregister(struct backing_dev_info *bdi)
>  {
> -	debugfs_remove(bdi->debug_stats);
> -	debugfs_remove(bdi->debug_dir);
> +	debugfs_remove_recursive(bdi->debug_dir);

this won't remove it.

If you return for "debug_dir == NULL" then it is a nice cleanup.

Sebastian
