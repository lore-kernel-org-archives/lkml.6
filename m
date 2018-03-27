Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbeC0N7C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:59:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752590AbeC0N7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:59:00 -0400
Date: Tue, 27 Mar 2018 16:58:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: correctly remove wait queue during poll
 failure
Message-ID: <20180327165330-mutt-send-email-mst@kernel.org>
References: <1522122442-30317-1-git-send-email-jasowang@redhat.com>
 <20180327092811.ikvssyxgb74nucb4@dhcp-10-175-199-170.vpn.oracle.com>
 <b1576bcf-652a-7c1a-9d77-db54931ab979@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1576bcf-652a-7c1a-9d77-db54931ab979@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 05:43:14PM +0800, Jason Wang wrote:
> 
> 
> On 2018年03月27日 17:28, Darren Kenny wrote:
> > Hi Jason,
> > 
> > On Tue, Mar 27, 2018 at 11:47:22AM +0800, Jason Wang wrote:
> > > We tried to remove vq poll from wait queue, but do not check whether
> > > or not it was in a list before. This will lead double free. Fixing
> > > this by checking poll->wqh to make sure it was in a list.
> > 
> > This text seems at odds with the code below, instead of checking
> > poll-whq, you are removing that check...
> > 
> > Maybe the text needs rewording?
> 
> Yes, I admit it's bad, thanks for pointing out.
> 
> How about:
> 
> "Fixing this by switching to use vhost_poll_stop() which zeros poll->wqh
> after removing poll from waitqueue to make sure it won't be freed twice."
> 
> Thanks

Let's be a bit more specific about the problem maybe?

when vhost's attempt to start polling a descriptor fails, we remove the
poll->wqh entry from wait queue but do not clear it, so the following
cleanup (e.g. on release) will attempt to remove it again.

To fix, switch to vhost_poll_stop() which zeros poll->wqh
after removing poll from waitqueue to make sure it won't be freed twice."


the patch itself is fine though:


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> > 
> > Thanks,
> > 
> > Darren.
> > 
> > > 
> > > Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
> > > Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting
> > > backend")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > drivers/vhost/vhost.c | 3 +--
> > > 1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 1b3e8d2d..5d5a9d9 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -212,8 +212,7 @@ int vhost_poll_start(struct vhost_poll *poll,
> > > struct file *file)
> > >     if (mask)
> > >         vhost_poll_wakeup(&poll->wait, 0, 0, poll_to_key(mask));
> > >     if (mask & EPOLLERR) {
> > > -        if (poll->wqh)
> > > -            remove_wait_queue(poll->wqh, &poll->wait);
> > > +        vhost_poll_stop(poll);
> > >         ret = -EINVAL;
> > >     }
> > > 
> > > -- 
> > > 2.7.4
> > > 
