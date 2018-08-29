Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFDEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B712D205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B712D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeH2XG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:06:26 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:52354 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbeH2XG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:06:26 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 4339841BEE;
        Wed, 29 Aug 2018 21:08:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id sn-eZz0ta-hb; Wed, 29 Aug 2018 21:08:04 +0200 (CEST)
Date:   Wed, 29 Aug 2018 21:07:59 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 2/5] seccomp: make get_nth_filter available outside of
 CHECKPOINT_RESTORE
Message-ID: <20180829190758.ajmmfdugq6xdoqdh@mailbox.org>
References: <20180828143603.8127-1-tycho@tycho.ws>
 <20180828143603.8127-3-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828143603.8127-3-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 08:36:00AM -0600, Tycho Andersen wrote:
> In the next commit we'll use this same mnemonic to get a listener for the
> nth filter, so we need it available outside of CHECKPOINT_RESTORE in the
> USER_NOTIFICATION case as well.
> 
> v2: new in v2
> v3: no changes
> v4: no changes
> v5: switch to CHECKPOINT_RESTORE || USER_NOTIFICATION to avoid warning when
>     only CONFIG_SECCOMP_FILTER is enabled.
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Christian Brauner <christian.brauner@ubuntu.com>
> CC: Tyler Hicks <tyhicks@canonical.com>
> CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> ---
>  kernel/seccomp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

(Putting Serge and Jann in Cc. They seem to have been left out on
accident. :))

Acked-by: Christian Brauner <christian@brauner.io>

> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index a09eb5c05f68..ed786655186d 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1188,7 +1188,8 @@ long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
>  	return do_seccomp(op, 0, uargs);
>  }
>  
> -#if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
> +#if defined(CONFIG_CHECKPOINT_RESTORE) || \
> +	defined(CONFIG_SECCOMP_USER_NOTIFICATION)
>  static struct seccomp_filter *get_nth_filter(struct task_struct *task,
>  					     unsigned long filter_off)
>  {
> @@ -1235,6 +1236,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
>  	return filter;
>  }
>  
> +#if defined(CONFIG_CHECKPOINT_RESTORE)
>  long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
>  			void __user *data)
>  {
> @@ -1307,7 +1309,8 @@ long seccomp_get_metadata(struct task_struct *task,
>  	__put_seccomp_filter(filter);
>  	return ret;
>  }
> -#endif
> +#endif /* CONFIG_CHECKPOINT_RESTORE */
> +#endif /* CONFIG_SECCOMP_FILTER */
>  
>  #ifdef CONFIG_SYSCTL
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
