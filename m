Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeB1Ar5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:47:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:46874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751463AbeB1Ar4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:47:56 -0500
Date: Wed, 28 Feb 2018 00:47:53 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/5] sysctl: Add flags to support min/max range
 clamping
Message-ID: <20180228004753.GY14069@wotan.suse.de>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
 <1519764591-27456-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519764591-27456-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 03:49:48PM -0500, Waiman Long wrote:
> When minimum/maximum values are specified for a sysctl parameter in
> the ctl_table structure with proc_dointvec_minmax() handler,

an

> update
> to that parameter will fail with error if the given value is outside
> of the required range.
> 
> There are use cases where it may be better to clamp the value of
> the sysctl parameter to the given range without failing the update,
> especially if the users are not aware of the actual range limits.

Makes me wonder if we should add something which does let one query
for the ranges. Then scripts can fetch that as well.

> Reading the value back after the update will now be a good practice
> to see if the provided value exceeds the range limits.
> 
> To provide this less restrictive form of range checking, a new flags
> field is added to the ctl_table structure. The new field is a 16-bit
> value that just fits into the hole left by the 16-bit umode_t field
> without increasing the size of the structure.
> 
> When the CTL_FLAGS_CLAMP_RANGE flag is set in the ctl_table entry,
> any update from the userspace will be clamped to the given range
> without error.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sysctl.h |  6 ++++++
>  kernel/sysctl.c        | 58 ++++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index b769ecf..eceeaee 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -116,6 +116,7 @@ struct ctl_table
>  	void *data;
>  	int maxlen;
>  	umode_t mode;
> +	uint16_t flags;
>  	struct ctl_table *child;	/* Deprecated */
>  	proc_handler *proc_handler;	/* Callback for text formatting */
>  	struct ctl_table_poll *poll;
> @@ -123,6 +124,11 @@ struct ctl_table
>  	void *extra2;
>  } __randomize_layout;
>  
> +/*
> + * ctl_table flags (16 different flags, at most)
> + */
> +#define CTL_FLAGS_CLAMP_RANGE	(1 << 0) /* Clamp to min/max range */

Since its only 16 best we kdocify, we can do so with

/**                                                                             
 * enum ctl_table_flags - flags for the ctl table
 *
 * @CTL_FLAGS_CLAMP_RANGE: If set this indicates that the entry should be
 *	flexibly clamp to min/max range in case the user provided an incorrect
 *	value.
 */
enum ctl_table_flags {
	CTL_FLAGS_CLAMP_RANGE		= BIT(0),
}

This lets us document this nicely.

> +
>  struct ctl_node {
>  	struct rb_node node;
>  	struct ctl_table_header *header;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 52b647a..2b2b30c 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2505,15 +2505,21 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>   *
>   * The do_proc_dointvec_minmax_conv_param structure provides the
>   * minimum and maximum values for doing range checking for those sysctl
> - * parameters that use the proc_dointvec_minmax() handler. The error
> - * code -EINVAL will be returned if the range check fails.
> + * parameters that use the proc_dointvec_minmax() handler.
> + *
> + * The error code -EINVAL will be returned if the range check fails
> + * and the CTL_FLAGS_CLAMP_RANGE bit is not set in the given flags.
> + * If that flag is set, the new sysctl value will be clamped to the
> + * given range without returning any error.

This last part seems odd, we silently set the value to a limit if the
user set an invalid value?

Since this is actually not really undefined documenting that we set it
to the max value if the input value is greater than the max allowed would
be good. Likewise for the minimum.

  Luis
