Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeEGWjP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:39:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:47447 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752929AbeEGWjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:39:13 -0400
Date: Mon, 7 May 2018 22:39:10 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v7 1/4] ipc: IPCMNI limit check for msgmni and shmmni
Message-ID: <20180507223910.GW27853@wotan.suse.de>
References: <1525726752-29281-1-git-send-email-longman@redhat.com>
 <1525726752-29281-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525726752-29281-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 04:59:09PM -0400, Waiman Long wrote:
> A user can write arbitrary integer values to msgmni and shmmni sysctl
> parameters without getting error, but the actual limit is really
> IPCMNI (32k). This can mislead users as they think they can get a
> value that is not real.
> 
> The right limits are now set for msgmni and shmmni so that the users
> will become aware if they set a value outside of the acceptable range.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  ipc/ipc_sysctl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 8ad93c2..f87cb29 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -99,6 +99,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>  static int zero;
>  static int one = 1;
>  static int int_max = INT_MAX;
> +static int ipc_mni = IPCMNI;
>  
>  static struct ctl_table ipc_kern_table[] = {
>  	{
> @@ -120,7 +121,9 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>  		.data		= &init_ipc_ns.shm_ctlmni,
>  		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
>  		.mode		= 0644,
> -		.proc_handler	= proc_ipc_dointvec,
> +		.proc_handler	= proc_ipc_dointvec_minmax,
> +		.extra1		= &zero,
> +		.extra2		= &ipc_mni,
>  	},
>  	{
>  		.procname	= "shm_rmid_forced",
> @@ -147,7 +150,7 @@ static int proc_ipc_auto_msgmni(struct ctl_table *table, int write,
>  		.mode		= 0644,
>  		.proc_handler	= proc_ipc_dointvec_minmax,
>  		.extra1		= &zero,
> -		.extra2		= &int_max,
> +		.extra2		= &ipc_mni,
>  	},
>  	{
>  		.procname	= "auto_msgmni",
> -- 
> 1.8.3.1

It seems negative values are not allowed, if true then having
a caller to use proc_douintvec_minmax() would help with ensuring
no invalid negative input values are used as well.

  Luis
