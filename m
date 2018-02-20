Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeBTUMf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:12:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751245AbeBTUMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:12:34 -0500
Date: Tue, 20 Feb 2018 21:13:28 +0100
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 2/2] ptrace, seccomp: add support for retrieving
 seccomp metadata
Message-ID: <20180220201328.GR4439@asgard.redhat.com>
References: <20171115020019.13517-1-tycho@tycho.ws>
 <20171115020019.13517-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171115020019.13517-2-tycho@tycho.ws>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2017 at 07:00:19PM -0700, Tycho Andersen wrote:
> With the new SECCOMP_FILTER_FLAG_LOG, we need to be able to extract these
> flags for checkpoint restore, since they describe the state of a filter.
> 
> So, let's add PTRACE_SECCOMP_GET_METADATA, similar to ..._GET_FILTER, which
> returns the metadata of the nth filter (right now, just the flags).
> Hopefully this will be future proof, and new per-filter metadata can be
> added to this struct.
> 
> v3: * use GET_METADATA instead of GET_FLAGS
> v4: * resend
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Oleg Nesterov <oleg@redhat.com>
> ---
>  include/linux/seccomp.h     |  8 ++++++++
>  include/uapi/linux/ptrace.h |  6 ++++++
>  kernel/ptrace.c             |  4 ++++
>  kernel/seccomp.c            | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 10f25f7e4304..c723a5c4e3ff 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -95,11 +95,19 @@ static inline void get_seccomp_filter(struct task_struct *tsk)
>  #if defined(CONFIG_SECCOMP_FILTER) && defined(CONFIG_CHECKPOINT_RESTORE)
>  extern long seccomp_get_filter(struct task_struct *task,
>  			       unsigned long filter_off, void __user *data);
> +extern long seccomp_get_metadata(struct task_struct *task,
> +				 unsigned long filter_off, void __user *data);
>  #else
>  static inline long seccomp_get_filter(struct task_struct *task,
>  				      unsigned long n, void __user *data)
>  {
>  	return -EINVAL;
>  }
> +static inline long seccomp_get_metadata(struct task_struct *task,
> +					unsigned long filter_off,
> +					void __user *data)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_SECCOMP_FILTER && CONFIG_CHECKPOINT_RESTORE */
>  #endif /* _LINUX_SECCOMP_H */
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index e3939e00980b..e46d82b91166 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -66,6 +66,12 @@ struct ptrace_peeksiginfo_args {
>  #define PTRACE_SETSIGMASK	0x420b
>  
>  #define PTRACE_SECCOMP_GET_FILTER	0x420c
> +#define PTRACE_SECCOMP_GET_METADATA	0x420d
> +
> +struct seccomp_metadata {
> +	unsigned long filter_off;	/* Input: which filter */
> +	unsigned int flags;		/* Output: filter's flags */
> +};
>  
>  /* Read signals from a shared (process wide) queue */
>  #define PTRACE_PEEKSIGINFO_SHARED	(1 << 0)
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 84b1367935e4..58291e9f3276 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -1092,6 +1092,10 @@ int ptrace_request(struct task_struct *child, long request,
>  		ret = seccomp_get_filter(child, addr, datavp);
>  		break;
>  
> +	case PTRACE_SECCOMP_GET_METADATA:
> +		ret = seccomp_get_metadata(child, addr, datavp);
> +		break;
> +
>  	default:
>  		break;
>  	}
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index bad457862ee0..7f1f2f3ea549 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1061,6 +1061,40 @@ long seccomp_get_filter(struct task_struct *task, unsigned long filter_off,
>  	__put_seccomp_filter(filter);
>  	return ret;
>  }
> +
> +long seccomp_get_metadata(struct task_struct *task,
> +			  unsigned long size, void __user *data)
> +{
> +	long ret;
> +	struct seccomp_filter *filter;
> +	struct seccomp_metadata kmd = {};
> +
> +	if (!capable(CAP_SYS_ADMIN) ||
> +	    current->seccomp.mode != SECCOMP_MODE_DISABLED) {
> +		return -EACCES;
> +	}
> +

> +	size = min_t(unsigned long, size, sizeof(kmd));
> +
> +	if (copy_from_user(&kmd, data, size))
> +		return -EFAULT;

This will work kinda funny if size is less than sizeof(kmd.filter_off).
And I see no reason for copying the whole structure when only filter_off
is needed.

> +
> +	filter = get_nth_filter(task, kmd.filter_off);
> +	if (IS_ERR(filter))
> +		return PTR_ERR(filter);
> +
> +	memset(&kmd, 0, sizeof(kmd));

Is rewriting the filter_off field to 0 intentional?

> +	if (filter->log)
> +		kmd.flags |= SECCOMP_FILTER_FLAG_LOG;
> +
> +	ret = size;
> +	if (copy_to_user(data, &kmd, size))
> +		ret = -EFAULT;
> +
> +	__put_seccomp_filter(filter);
> +	return ret;
> +
> +}
>  #endif
>  
>  #ifdef CONFIG_SYSCTL
> -- 
> 2.14.1
> 
