Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F3EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92F52084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfAVKfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:35:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:43502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbfAVKfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:35:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 685E9AE58;
        Tue, 22 Jan 2019 10:35:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A789F1E3E1E; Tue, 22 Jan 2019 11:35:29 +0100 (CET)
Date:   Tue, 22 Jan 2019 11:35:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Albert Vaca Cintora <albertvaka@gmail.com>
Cc:     jack@suse.cz, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        nsaenzjulienne@suse.de
Subject: Re: [PATCH 1/1] kernel/ucounts: expose current inotify watch count
Message-ID: <20190122103529.GB13149@quack2.suse.cz>
References: <20190121164511.10822-1-albertvaka@gmail.com>
 <20190121164511.10822-2-albertvaka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121164511.10822-2-albertvaka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-01-19 17:45:11, Albert Vaca Cintora wrote:
> Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
> The handler for this entry is a custom function that ends calling
> proc_dointvec.
> 
> Signed-off-by: Albert Vaca Cintora <albertvaka@gmail.com>

FWIW this makes sense to me. I'd just copy a lot of the rationale from the
cover latter to this commit log so that it gets preseved in git history.
Other than that feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  kernel/ucount.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index f48d1b6376a4..afa3b89e3373 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -57,6 +57,11 @@ static struct ctl_table_root set_root = {
>  	.permissions = set_permissions,
>  };
> 
> +#ifdef CONFIG_INOTIFY_USER
> +int proc_read_inotify_watches(struct ctl_table *table, int write,
> +		     void __user *buffer, size_t *lenp, loff_t *ppos);
> +#endif
> +
>  static int zero = 0;
>  static int int_max = INT_MAX;
>  #define UCOUNT_ENTRY(name)				\
> @@ -79,6 +84,12 @@ static struct ctl_table user_table[] = {
>  #ifdef CONFIG_INOTIFY_USER
>  	UCOUNT_ENTRY("max_inotify_instances"),
>  	UCOUNT_ENTRY("max_inotify_watches"),
> +	{
> +		.procname	= "current_inotify_watches",
> +		.maxlen		= sizeof(int),
> +		.mode		= 0444,
> +		.proc_handler	= proc_read_inotify_watches,
> +	},
>  #endif
>  	{ }
>  };
> @@ -226,6 +237,24 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
>  	put_ucounts(ucounts);
>  }
> 
> +#ifdef CONFIG_INOTIFY_USER
> +int proc_read_inotify_watches(struct ctl_table *table, int write,
> +		     void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct ucounts *ucounts;
> +	struct ctl_table fake_table;
> +	int count;
> +
> +	ucounts = get_ucounts(current_user_ns(), current_euid());
> +	count = atomic_read(&ucounts->ucount[UCOUNT_INOTIFY_WATCHES]);
> +	put_ucounts(ucounts);
> +
> +	fake_table.data = &count;
> +	fake_table.maxlen = sizeof(count);
> +	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
> +}
> +#endif
> +
>  static __init int user_namespace_sysctl_init(void)
>  {
>  #ifdef CONFIG_SYSCTL
> --
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
