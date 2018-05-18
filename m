Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeEROG2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:06:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752573AbeEROGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:06:25 -0400
Date: Fri, 18 May 2018 17:06:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] tuntap: raise EPOLLOUT on device up
Message-ID: <20180518170155-mutt-send-email-mst@kernel.org>
References: <1526648443-24128-1-git-send-email-jasowang@redhat.com>
 <20180518161253-mutt-send-email-mst@kernel.org>
 <e1ecf6b0-c751-52ad-a52e-0e29c3328196@redhat.com>
 <6159b23e-eeda-1d4b-6a30-63b1a30666eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6159b23e-eeda-1d4b-6a30-63b1a30666eb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:00:31PM +0800, Jason Wang wrote:
> 
> 
> On 2018年05月18日 21:26, Jason Wang wrote:
> > 
> > 
> > On 2018年05月18日 21:13, Michael S. Tsirkin wrote:
> > > On Fri, May 18, 2018 at 09:00:43PM +0800, Jason Wang wrote:
> > > > We return -EIO on device down but can not raise EPOLLOUT after it was
> > > > up. This may confuse user like vhost which expects tuntap to raise
> > > > EPOLLOUT to re-enable its TX routine after tuntap is down. This could
> > > > be easily reproduced by transmitting packets from VM while down and up
> > > > the tap device. Fixing this by set SOCKWQ_ASYNC_NOSPACE on -EIO.
> > > > 
> > > > Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
> > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > Fixes: 1bd4978a88ac2 ("tun: honor IFF_UP in tun_get_user()")
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >   drivers/net/tun.c | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > index d45ac37..1b29761 100644
> > > > --- a/drivers/net/tun.c
> > > > +++ b/drivers/net/tun.c
> > > > @@ -1734,8 +1734,10 @@ static ssize_t tun_get_user(struct
> > > > tun_struct *tun, struct tun_file *tfile,
> > > >       int skb_xdp = 1;
> > > >       bool frags = tun_napi_frags_enabled(tun);
> > > >   -    if (!(tun->dev->flags & IFF_UP))
> > > > +    if (!(tun->dev->flags & IFF_UP)) {
> > > Isn't this racy?  What if flag is cleared at this point?
> > 
> > I think you mean "set at this point"? Then yes, so we probably need to
> > set the bit during tun_net_close().
> > 
> > Thanks
> 
> Looks no need, vhost will poll socket after it see EIO. So we are ok here?
> 
> Thanks

In fact I don't even understand why does this help any longer.

-- 
MST
