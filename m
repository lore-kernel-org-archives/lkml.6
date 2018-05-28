Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939334AbeE1OKE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:10:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49968 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162253AbeE1OHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:07:54 -0400
Date: Mon, 28 May 2018 15:07:49 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christian Brauner <christian@brauner.io>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, akpm@linux-foundation.org,
        oleg@redhat.com
Subject: Re: [PATCH 2/8] signal: make kill_as_cred_perm() return bool
Message-ID: <20180528140749.GY30522@ZenIV.linux.org.uk>
References: <20180528134916.7568-1-christian@brauner.io>
 <20180528134916.7568-3-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528134916.7568-3-christian@brauner.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 03:49:10PM +0200, Christian Brauner wrote:
> kill_as_cred_perm() already behaves like a boolean function. Let's actually
> declare it as such too.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
>  kernel/signal.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c756008d589e..81be01d193f4 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1349,14 +1349,15 @@ static int kill_proc_info(int sig, struct siginfo *info, pid_t pid)
>  	return error;
>  }
>  
> -static int kill_as_cred_perm(const struct cred *cred,
> +static bool kill_as_cred_perm(const struct cred *cred,
>  			     struct task_struct *target)
>  {
>  	const struct cred *pcred = __task_cred(target);
>  	if (!uid_eq(cred->euid, pcred->suid) && !uid_eq(cred->euid, pcred->uid) &&
>  	    !uid_eq(cred->uid,  pcred->suid) && !uid_eq(cred->uid,  pcred->uid))
> -		return 0;
> -	return 1;
> +		return false;
> +
> +	return true;

Ugh...
	if (!foo && !bar && !baz && !quux)
		return false;
	return true;

is a bloody odd way to spell

	return foo || bar || baz || quux;
