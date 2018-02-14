Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161768AbeBNSNW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161664AbeBNSNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:13:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E882177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Wed, 14 Feb 2018 10:13:20 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Juergen Gross <jgross@suse.com>
cc: Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Stefano Stabellini <stefano@aporeto.com>
Subject: Re: [PATCH v2 1/2] pvcalls-front: introduce a per sock_mapping
 refcount
In-Reply-To: <5e34f4f5-faa5-1983-7e7e-a71d4aec80ca@suse.com>
Message-ID: <alpine.DEB.2.10.1802141001580.5392@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1802121812500.3704@sstabellini-ThinkPad-X260> <1518488027-22386-1-git-send-email-sstabellini@kernel.org> <5e34f4f5-faa5-1983-7e7e-a71d4aec80ca@suse.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, Juergen Gross wrote:
> On 13/02/18 03:13, Stefano Stabellini wrote:
> > Introduce a per sock_mapping refcount, in addition to the existing
> > global refcount. Thanks to the sock_mapping refcount, we can safely wait
> > for it to be 1 in pvcalls_front_release before freeing an active socket,
> > instead of waiting for the global refcount to be 1.
> > 
> > Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> > 
> > ---
> > Changes in v2:
> > - fix code style
> > - nicer checks in pvcalls_front_release
> > - fix check in pvcalls_enter_sock
> > ---
> >  drivers/xen/pvcalls-front.c | 193 +++++++++++++++++++-------------------------
> >  1 file changed, 81 insertions(+), 112 deletions(-)
> > 
> > diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> > index 4c789e6..163bf8c 100644
> > --- a/drivers/xen/pvcalls-front.c
> > +++ b/drivers/xen/pvcalls-front.c
> > @@ -60,6 +60,7 @@ struct sock_mapping {
> >  	bool active_socket;
> >  	struct list_head list;
> >  	struct socket *sock;
> > +	atomic_t refcount;
> >  	union {
> >  		struct {
> >  			int irq;
> > @@ -93,6 +94,34 @@ struct sock_mapping {
> >  	};
> >  };
> >  
> > +static inline struct sock_mapping *pvcalls_enter_sock(struct socket *sock)
> > +{
> > +	struct sock_mapping *map = NULL;
> 
> Pointless initializer.

I'll fix


> > +
> > +	if (!pvcalls_front_dev ||
> > +		dev_get_drvdata(&pvcalls_front_dev->dev) == NULL)
> > +		return ERR_PTR(-ENOTCONN);
> > +
> > +	pvcalls_enter();
> > +	map = (struct sock_mapping *)sock->sk->sk_send_head;
> > +	if (map == NULL) {
> > +		pvcalls_exit()
> > +		return ERR_PTR(-ENOTSOCK);
> > +	}
> 
> Sorry for noticing this only now: any reason you don't call
> pvcalls_enter() only here instead? This would remove the need of
> calling pvcalls_exit() if map == NULL.
> 
> I can't see pvcalls_enter() protecting sock->sk->sk_send_head in any
> way.

You are right. I'll move it down a couple of lines.


> > +
> > +	atomic_inc(&map->refcount);
> > +	return map;
> > +}
> > +
> > +static inline void pvcalls_exit_sock(struct socket *sock)
> > +{
> > +	struct sock_mapping *map = NULL;
> 
> Pointless initializer again.

I'll fix
