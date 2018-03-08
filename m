Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754809AbeCHSOI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:14:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:45909 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751642AbeCHSOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:14:06 -0500
Date: Thu, 8 Mar 2018 18:14:04 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 5/6] ipc: Clamp msgmni and shmmni to the real IPCMNI
 limit
Message-ID: <20180308181404.GF4449@wotan.suse.de>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
 <1519926220-7453-6-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519926220-7453-6-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 12:43:39PM -0500, Waiman Long wrote:
> A user can write arbitrary integer values to msgmni and shmmni sysctl
> parameters without getting error, but the actual limit is really
> IPCMNI (32k). This can mislead users as they think they can get a
> value that is not real.
> 
> Enforcing the limit by failing the sysctl parameter write, however,
> can break existing user applications. Instead, the range clamping flag
> is set to enforce the limit without failing existing user code. Users
> can easily figure out if the sysctl parameter value is out of range
> by either reading back the parameter value or checking the kernel
> ring buffer for warning.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  ipc/ipc_sysctl.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 8ad93c2..8eb7268 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -41,12 +41,21 @@ static int proc_ipc_dointvec(struct ctl_table *table, int write,
>  static int proc_ipc_dointvec_minmax(struct ctl_table *table, int write,
>  	void __user *buffer, size_t *lenp, loff_t *ppos)
>  {
> +	int ret;
>  	struct ctl_table ipc_table;
>  
>  	memcpy(&ipc_table, table, sizeof(ipc_table));
>  	ipc_table.data = get_ipc(table);
>  
> -	return proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
> +	ret = proc_dointvec_minmax(&ipc_table, write, buffer, lenp, ppos);
> +
> +	/*
> +	 * Copy back the CTL_FLAGS_OOR_WARNED flag which may be set in
> +	 * the temporary ctl_table entry.
> +	 */
> +	table->flags |= (ipc_table.flags & CTL_FLAGS_OOR_WARNED);

Again, why is this needed? Cant' we do this for the developer somehow?
Seems fragile, and if we can do it why not?

  Luis
