Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeC2EUg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 00:20:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750707AbeC2EUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 00:20:34 -0400
Date: Thu, 29 Mar 2018 07:20:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH net V2] vhost: correctly remove wait queue during poll
 failure
Message-ID: <20180329071801-mutt-send-email-mst@kernel.org>
References: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 08:50:52PM +0800, Jason Wang wrote:
> We tried to remove vq poll from wait queue, but do not check whether
> or not it was in a list before. This will lead double free. Fixing
> this by switching to use vhost_poll_stop() which zeros poll->wqh after
> removing poll from waitqueue to make sure it won't be freed twice.
> 
> Cc: Darren Kenny <darren.kenny@oracle.com>
> Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
> Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

OK with this the only bug we have is where get user pages returns 0
(Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com)



> ---
> Changes from V1:
> - tweak the commit log for to match the code
> ---
>  drivers/vhost/vhost.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 1b3e8d2d..5d5a9d9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -212,8 +212,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file)
>  	if (mask)
>  		vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
>  	if (mask & EPOLLERR) {
> -		if (poll->wqh)
> -			remove_wait_queue(poll->wqh, &poll->wait);
> +		vhost_poll_stop(poll);
>  		ret = -EINVAL;
>  	}
>  
> -- 
> 2.7.4
