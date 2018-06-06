Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F07D606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bfs.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeFFJKF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:10:05 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:28319 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932260AbeFFJKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:10:01 -0400
Date: Wed, 6 Jun 2018 11:01:44 +0200 (CEST)
From: Walter Harms <wharms@bfs.de>
To: linux-ppp@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>,
        Paul Mackerras <paulus@samba.org>
Cc: syzkaller-bugs@googlegroups.com,
        Guillaume Nault <g.nault@alphalink.fr>,
        Eric Biggers <ebiggers@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <909200487.17769.1528275705881@ox-groupware.bfs.de>
In-Reply-To: <20180523213738.146911-1-ebiggers3@gmail.com>
References: <20180523035952.25768-1-ebiggers3@gmail.com>
 <20180523213738.146911-1-ebiggers3@gmail.com>
Subject: Re: [PATCH v2] ppp: remove the PPPIOCDETACH ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev31
X-Originating-Client: com.openexchange.ox.gui.dhtml
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Eric Biggers <ebiggers3@gmail.com> hat am 23. Mai 2018 um 23:37 geschrieben:
> 
> 
> From: Eric Biggers <ebiggers@google.com>
> 
> The PPPIOCDETACH ioctl effectively tries to "close" the given ppp file
> before f_count has reached 0, which is fundamentally a bad idea.  It
> does check 'f_count < 2', which excludes concurrent operations on the
> file since they would only be possible with a shared fd table, in which
> case each fdget() would take a file reference.  However, it fails to
> account for the fact that even with 'f_count == 1' the file can still be
> linked into epoll instances.  As reported by syzbot, this can trivially
> be used to cause a use-after-free.
> 
> Yet, the only known user of PPPIOCDETACH is pppd versions older than
> ppp-2.4.2, which was released almost 15 years ago (November 2003).
> Also, PPPIOCDETACH apparently stopped working reliably at around the
> same time, when the f_count check was added to the kernel, e.g. see
> https://lkml.org/lkml/2002/12/31/83.  Also, the current 'f_count < 2'
> check makes PPPIOCDETACH only work in single-threaded applications; it
> always fails if called from a multithreaded application.
> 
> All pppd versions released in the last 15 years just close() the file
> descriptor instead.
> 
> Therefore, instead of hacking around this bug by exporting epoll
> internals to modules, and probably missing other related bugs, just
> remove the PPPIOCDETACH ioctl and see if anyone actually notices.  Leave
> a stub in place that prints a one-time warning and returns EINVAL.
> 
> Reported-by: syzbot+16363c99d4134717c05b@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: leave a stub in place, rather than removing the ioctl completely.
> 
>  Documentation/networking/ppp_generic.txt |  6 ------
>  drivers/net/ppp/ppp_generic.c            | 27 +++++-------------------
>  include/uapi/linux/ppp-ioctl.h           |  2 +-
>  3 files changed, 6 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/networking/ppp_generic.txt
> b/Documentation/networking/ppp_generic.txt
> index 091d20273dcb..61daf4b39600 100644
> --- a/Documentation/networking/ppp_generic.txt
> +++ b/Documentation/networking/ppp_generic.txt
> @@ -300,12 +300,6 @@ unattached instance are:
>  The ioctl calls available on an instance of /dev/ppp attached to a
>  channel are:
>  
> -* PPPIOCDETACH detaches the instance from the channel.  This ioctl is
> -  deprecated since the same effect can be achieved by closing the
> -  instance.  In order to prevent possible races this ioctl will fail
> -  with an EINVAL error if more than one file descriptor refers to this
> -  instance (i.e. as a result of dup(), dup2() or fork()).
> -
>  * PPPIOCCONNECT connects this channel to a PPP interface.  The
>    argument should point to an int containing the interface unit
>    number.  It will return an EINVAL error if the channel is already
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index dc7c7ec43202..02ad03a2fab7 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -605,30 +605,13 @@ static long ppp_ioctl(struct file *file, unsigned int
> cmd, unsigned long arg)
>  
>  	if (cmd == PPPIOCDETACH) {
>  		/*
> -		 * We have to be careful here... if the file descriptor
> -		 * has been dup'd, we could have another process in the
> -		 * middle of a poll using the same file *, so we had
> -		 * better not free the interface data structures -
> -		 * instead we fail the ioctl.  Even in this case, we
> -		 * shut down the interface if we are the owner of it.
> -		 * Actually, we should get rid of PPPIOCDETACH, userland
> -		 * (i.e. pppd) could achieve the same effect by closing
> -		 * this fd and reopening /dev/ppp.
> +		 * PPPIOCDETACH is no longer supported as it was heavily broken,
> +		 * and is only known to have been used by pppd older than
> +		 * ppp-2.4.2 (released November 2003).
>  		 */
> +		pr_warn_once("%s (%d) used obsolete PPPIOCDETACH ioctl\n",
> +			     current->comm, current->pid);
>  		err = -EINVAL;
> -		if (pf->kind == INTERFACE) {
> -			ppp = PF_TO_PPP(pf);
> -			rtnl_lock();
> -			if (file == ppp->owner)
> -				unregister_netdevice(ppp->dev);
> -			rtnl_unlock();
> -		}
> -		if (atomic_long_read(&file->f_count) < 2) {
> -			ppp_release(NULL, file);
> -			err = 0;
> -		} else
> -			pr_warn("PPPIOCDETACH file->f_count=%ld\n",
> -				atomic_long_read(&file->f_count));
>  		goto out;
>  	}
>  
> diff --git a/include/uapi/linux/ppp-ioctl.h b/include/uapi/linux/ppp-ioctl.h
> index b19a9c249b15..784c2e3e572e 100644
> --- a/include/uapi/linux/ppp-ioctl.h
> +++ b/include/uapi/linux/ppp-ioctl.h
> @@ -106,7 +106,7 @@ struct pppol2tp_ioc_stats {
>  #define PPPIOCGIDLE	_IOR('t', 63, struct ppp_idle) /* get idle time */
>  #define PPPIOCNEWUNIT	_IOWR('t', 62, int)	/* create new ppp unit */
>  #define PPPIOCATTACH	_IOW('t', 61, int)	/* attach to ppp unit */
> -#define PPPIOCDETACH	_IOW('t', 60, int)	/* detach from ppp unit/chan */
> +#define PPPIOCDETACH	_IOW('t', 60, int)	/* obsolete, do not use */

It's a bit late but ...
i would suggest a stronger wording here. like /* removed 2003 */ 
for me "obsolete" sounds like "maybe it will be removed in a distant future"

just my 2 cents,

re,
 wh

>  #define PPPIOCSMRRU	_IOW('t', 59, int)	/* set multilink MRU */
>  #define PPPIOCCONNECT	_IOW('t', 58, int)	/* connect channel to unit */
>  #define PPPIOCDISCONN	_IO('t', 57)		/* disconnect channel */
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ppp" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
