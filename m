Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeCLUoQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:44:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbeCLUoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:44:15 -0400
Date: Mon, 12 Mar 2018 20:44:13 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/6] sysctl: Add flags to support min/max range
 clamping
Message-ID: <20180312204413.GY4449@wotan.suse.de>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520885744-1546-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 04:15:39PM -0400, Waiman Long wrote:
> When minimum/maximum values are specified for a sysctl parameter in
> the ctl_table structure with proc_dointvec_minmax() handler, update
> to that parameter will fail with error if the given value is outside
> of the required range.
> 
> There are use cases where it may be better to clamp the value of
> the sysctl parameter to the given range without failing the update,
> especially if the users are not aware of the actual range limits.
> Reading the value back after the update will now be a good practice
> to see if the provided value exceeds the range limits.
> 
> To provide this less restrictive form of range checking, a new flags
> field is added to the ctl_table structure.
> 
> When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table
> entry, any update from the userspace will be clamped to the given
> range without error if either the proc_dointvec_minmax() or the
> proc_douintvec_minmax() handlers is used.

You keep missing to document both on commit log and kdoc which
end on the range is selected if you happen to go over. To be clear
it is unclear from reading the commit log if a default is set if
you go over if you pick another value. In this case it is conditional
if you go over we pick the high range max, and if you go below the
lower range minimum set allowed.

What happens if no low range is set and that is what the issue in
terms of range triggers?

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sysctl.h | 15 +++++++++++++++
>  kernel/sysctl.c        | 48 +++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index b769ecf..963e363 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -116,6 +116,7 @@ struct ctl_table
>  	void *data;
>  	int maxlen;
>  	umode_t mode;
> +	unsigned int flags;
>  	struct ctl_table *child;	/* Deprecated */
>  	proc_handler *proc_handler;	/* Callback for text formatting */
>  	struct ctl_table_poll *poll;
> @@ -123,6 +124,20 @@ struct ctl_table
>  	void *extra2;
>  } __randomize_layout;
>  
> +/**
> + * enum ctl_table_flags - flags for the ctl table (struct ctl_table.flags)
> + *
> + * @CTL_FLAGS_CLAMP_RANGE: Set to indicate that the entry should be
> + *	flexibly clamped to min/max range in case the user provided
> + *	an incorrect value.

It should be documented clearly here.

So NACK for now.

  Luis
