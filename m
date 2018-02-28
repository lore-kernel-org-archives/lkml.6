Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeB1BBD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 20:01:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:47397 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeB1BBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 20:01:02 -0500
Date: Wed, 28 Feb 2018 01:01:00 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 4/5] ipc: Clamp msgmni and shmmni to the real IPCMNI
 limit
Message-ID: <20180228010100.GA14069@wotan.suse.de>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
 <1519764591-27456-5-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519764591-27456-5-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 03:49:50PM -0500, Waiman Long wrote:
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 8ad93c2..e4ab272 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -41,12 +41,17 @@ static int proc_ipc_dointvec(struct ctl_table *table, int write,
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
> +	table->flags |= ipc_table.flags; /* Copy back any change in flags */

This seems fragile, why are we requiring this to be done by the users of
CTL_FLAGS_CLAMP_RANGE ?

  Luis
