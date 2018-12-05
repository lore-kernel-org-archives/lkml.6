Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1620C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0C120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0C120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeLEMJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:09:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:41648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727339AbeLEMJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:09:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DB19B671;
        Wed,  5 Dec 2018 12:09:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C9E551E0DBB; Wed,  5 Dec 2018 13:09:21 +0100 (CET)
Date:   Wed, 5 Dec 2018 13:09:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jan Kara <jack@suse.cz>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: Make sure to check event_len when copying
Message-ID: <20181205120921.GA30615@quack2.suse.cz>
References: <20181204234446.GA4676@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204234446.GA4676@beast>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 15:44:46, Kees Cook wrote:
> As a precaution, make sure we check event_len when copying to userspace.
> Based on old feedback: https://lkml.kernel.org/r/542D9FE5.3010009@gmx.de
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks for the patch, I've added it to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index e03be5071362..d9484a0ac6b3 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -206,7 +206,7 @@ static int process_access_response(struct fsnotify_group *group,
>  
>  static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  				  struct fsnotify_event *event,
> -				  char __user *buf)
> +				  char __user *buf, size_t count)
>  {
>  	struct fanotify_event_metadata fanotify_event_metadata;
>  	struct file *f;
> @@ -220,6 +220,12 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  
>  	fd = fanotify_event_metadata.fd;
>  	ret = -EFAULT;
> +	/*
> +	 * Sanity check copy size in case get_one_event() and
> +	 * fill_event_metadata() event_len sizes ever get out of sync.
> +	 */
> +	if (WARN_ON_ONCE(fanotify_event_metadata.event_len > count))
> +		goto out_close_fd;
>  	if (copy_to_user(buf, &fanotify_event_metadata,
>  			 fanotify_event_metadata.event_len))
>  		goto out_close_fd;
> @@ -295,7 +301,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
>  			continue;
>  		}
>  
> -		ret = copy_event_to_user(group, kevent, buf);
> +		ret = copy_event_to_user(group, kevent, buf, count);
>  		if (unlikely(ret == -EOPENSTALE)) {
>  			/*
>  			 * We cannot report events with stale fd so drop it.
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
