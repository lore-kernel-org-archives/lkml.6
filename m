Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932331AbeCLUqQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:46:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932247AbeCLUqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:46:15 -0400
Date: Mon, 12 Mar 2018 20:46:14 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 2/6] proc/sysctl: Check for invalid flags bits
Message-ID: <20180312204614.GZ4449@wotan.suse.de>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520885744-1546-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 04:15:40PM -0400, Waiman Long wrote:
> Checking code is added to check for invalid flags in the ctl_table
> and return error if an unknown flag is used.

This should be merged with the first patch otherwise there are atomic
points in time on the commit log history where invalid values are allowed
and that makes no sense.

This can probably be expanded to verify semantics further. Details
below.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/proc/proc_sysctl.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 493c975..67c0c82 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1092,6 +1092,16 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
>  	return err;
>  }
>  
> +static int sysctl_check_flags(const char *path, struct ctl_table *table)
> +{
> +	int err = 0;
> +
> +	if (table->flags & ~CTL_TABLE_FLAGS_ALL)
> +		err = sysctl_err(path, table, "invalid flags");

What if a range for the upper limit is set but not the lower limit and
the user goes over the lower limit?

How about the inverse?

Do we need both ranges set?

  Luis
