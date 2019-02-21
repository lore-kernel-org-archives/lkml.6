Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D0420818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550737393;
	bh=k886G0coLwNJLzQEYcUJRYBE1YXiO5YzJdHHYlJnHgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=agmjSrHUcXLmezkRRAg8hv3mb/IZ79LLOX8ACw9lbn4seoyGwtu1moUbNZiixhGFv
	 yjE7LWfWWF5gI8Uav7HO2l9Q6QMUs3ZvSrzzitvVoQai32/A1KjPE8RMFa8UsAu116
	 Vue0ZJZ9cEFO0qfcycZy7ETCezTD6VTZ1EUfDhhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfBUIXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:23:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:40940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbfBUIXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:23:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49AE2AD95;
        Thu, 21 Feb 2019 08:23:10 +0000 (UTC)
Date:   Thu, 21 Feb 2019 09:23:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com, joe@perches.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm/cma_debug: Check for null tmp in cma_debugfs_add_one()
Message-ID: <20190221082309.GG4525@dhcp22.suse.cz>
References: <20190221040130.8940-1-zbestahu@gmail.com>
 <20190221040130.8940-2-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221040130.8940-2-zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-02-19 12:01:30, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> If debugfs_create_dir() failed, the following debugfs_create_file()
> will be meanless since it depends on non-NULL tmp dentry and it will
> only waste CPU resource.

The file will be created in the debugfs root. But, more importantly.
Greg (CCed now) is working on removing the failure paths because he
believes they do not really matter for debugfs and they make code more
ugly. More importantly a check for NULL is not correct because you
get ERR_PTR after recent changes IIRC.

> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  mm/cma_debug.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index 2c2c869..3e9d984 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -169,6 +169,8 @@ static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
>  	scnprintf(name, sizeof(name), "cma-%s", cma->name);
>  
>  	tmp = debugfs_create_dir(name, root_dentry);
> +	if (!tmp)
> +		return;
>  
>  	debugfs_create_file("alloc", 0200, tmp, cma, &cma_alloc_fops);
>  	debugfs_create_file("free", 0200, tmp, cma, &cma_free_fops);
> -- 
> 1.9.1
> 

-- 
Michal Hocko
SUSE Labs
