Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030567AbeBNNqP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:46:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:58738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030289AbeBNNqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:46:14 -0500
Subject: Re: [PATCH v2 1/2] pvcalls-front: introduce a per sock_mapping
 refcount
To: Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano@aporeto.com>
References: <alpine.DEB.2.10.1802121812500.3704@sstabellini-ThinkPad-X260>
 <1518488027-22386-1-git-send-email-sstabellini@kernel.org>
From: Juergen Gross <jgross@suse.com>
Message-ID: <5e34f4f5-faa5-1983-7e7e-a71d4aec80ca@suse.com>
Date: Wed, 14 Feb 2018 14:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518488027-22386-1-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/18 03:13, Stefano Stabellini wrote:
> Introduce a per sock_mapping refcount, in addition to the existing
> global refcount. Thanks to the sock_mapping refcount, we can safely wait
> for it to be 1 in pvcalls_front_release before freeing an active socket,
> instead of waiting for the global refcount to be 1.
> 
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> 
> ---
> Changes in v2:
> - fix code style
> - nicer checks in pvcalls_front_release
> - fix check in pvcalls_enter_sock
> ---
>  drivers/xen/pvcalls-front.c | 193 +++++++++++++++++++-------------------------
>  1 file changed, 81 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> index 4c789e6..163bf8c 100644
> --- a/drivers/xen/pvcalls-front.c
> +++ b/drivers/xen/pvcalls-front.c
> @@ -60,6 +60,7 @@ struct sock_mapping {
>  	bool active_socket;
>  	struct list_head list;
>  	struct socket *sock;
> +	atomic_t refcount;
>  	union {
>  		struct {
>  			int irq;
> @@ -93,6 +94,34 @@ struct sock_mapping {
>  	};
>  };
>  
> +static inline struct sock_mapping *pvcalls_enter_sock(struct socket *sock)
> +{
> +	struct sock_mapping *map = NULL;

Pointless initializer.

> +
> +	if (!pvcalls_front_dev ||
> +		dev_get_drvdata(&pvcalls_front_dev->dev) == NULL)
> +		return ERR_PTR(-ENOTCONN);
> +
> +	pvcalls_enter();
> +	map = (struct sock_mapping *)sock->sk->sk_send_head;
> +	if (map == NULL) {
> +		pvcalls_exit()
> +		return ERR_PTR(-ENOTSOCK);
> +	}

Sorry for noticing this only now: any reason you don't call
pvcalls_enter() only here instead? This would remove the need of
calling pvcalls_exit() if map == NULL.

I can't see pvcalls_enter() protecting sock->sk->sk_send_head in any
way.

> +
> +	atomic_inc(&map->refcount);
> +	return map;
> +}
> +
> +static inline void pvcalls_exit_sock(struct socket *sock)
> +{
> +	struct sock_mapping *map = NULL;

Pointless initializer again.


Juergen
