Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbeEUWHE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:07:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752742AbeEUWG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:06:58 -0400
Date: Tue, 22 May 2018 01:06:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] tuntap: raise EPOLLOUT on device up
Message-ID: <20180522010618-mutt-send-email-mst@kernel.org>
References: <1526648443-24128-1-git-send-email-jasowang@redhat.com>
 <20180518161253-mutt-send-email-mst@kernel.org>
 <e1ecf6b0-c751-52ad-a52e-0e29c3328196@redhat.com>
 <6159b23e-eeda-1d4b-6a30-63b1a30666eb@redhat.com>
 <20180518170155-mutt-send-email-mst@kernel.org>
 <ac404f5e-22ea-00e7-8415-63116ce4881e@redhat.com>
 <20180518172932-mutt-send-email-mst@kernel.org>
 <e178f169-43c4-8ac4-8334-bc3eba1bd10e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e178f169-43c4-8ac4-8334-bc3eba1bd10e@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 09:09:11AM +0800, Jason Wang wrote:
> 
> 
> On 2018年05月18日 22:46, Michael S. Tsirkin wrote:
> > On Fri, May 18, 2018 at 10:11:54PM +0800, Jason Wang wrote:
> > > 
> > > On 2018年05月18日 22:06, Michael S. Tsirkin wrote:
> > > > On Fri, May 18, 2018 at 10:00:31PM +0800, Jason Wang wrote:
> > > > > On 2018年05月18日 21:26, Jason Wang wrote:
> > > > > > On 2018年05月18日 21:13, Michael S. Tsirkin wrote:
> > > > > > > On Fri, May 18, 2018 at 09:00:43PM +0800, Jason Wang wrote:
> > > > > > > > We return -EIO on device down but can not raise EPOLLOUT after it was
> > > > > > > > up. This may confuse user like vhost which expects tuntap to raise
> > > > > > > > EPOLLOUT to re-enable its TX routine after tuntap is down. This could
> > > > > > > > be easily reproduced by transmitting packets from VM while down and up
> > > > > > > > the tap device. Fixing this by set SOCKWQ_ASYNC_NOSPACE on -EIO.
> > > > > > > > 
> > > > > > > > Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
> > > > > > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > > > > > Fixes: 1bd4978a88ac2 ("tun: honor IFF_UP in tun_get_user()")
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > ---
> > > > > > > >     drivers/net/tun.c | 4 +++-
> > > > > > > >     1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > > > > > index d45ac37..1b29761 100644
> > > > > > > > --- a/drivers/net/tun.c
> > > > > > > > +++ b/drivers/net/tun.c
> > > > > > > > @@ -1734,8 +1734,10 @@ static ssize_t tun_get_user(struct
> > > > > > > > tun_struct *tun, struct tun_file *tfile,
> > > > > > > >         int skb_xdp = 1;
> > > > > > > >         bool frags = tun_napi_frags_enabled(tun);
> > > > > > > >     -    if (!(tun->dev->flags & IFF_UP))
> > > > > > > > +    if (!(tun->dev->flags & IFF_UP)) {
> > > > > > > Isn't this racy?  What if flag is cleared at this point?
> > > > > > I think you mean "set at this point"? Then yes, so we probably need to
> > > > > > set the bit during tun_net_close().
> > > > > > 
> > > > > > Thanks
> > > > > Looks no need, vhost will poll socket after it see EIO. So we are ok here?
> > > > > 
> > > > > Thanks
> > > > In fact I don't even understand why does this help any longer.
> > > > 
> > > We disable tx polling and only enable it on demand for a better rx
> > > performance. You may want to have a look at :
> > > 
> > > commit feb8892cb441c742d4220cf7ced001e7fa070731
> > > Author: Jason Wang <jasowang@redhat.com>
> > > Date:   Mon Nov 13 11:45:34 2017 +0800
> > > 
> > >      vhost_net: conditionally enable tx polling
> > > 
> > > Thanks
> > 
> > Question is, what looks at SOCKWQ_ASYNC_NOSPACE.
> > I think it's tested when packet is transmitted,
> > but there is no guarantee here any packet will
> > ever be transmitted.
> > 
> 
> Well, actually, I do plan to disable vq polling from the beginning. But
> looks like you do not want this:
> 
> See https://patchwork.kernel.org/patch/10034025/
> 
> Thanks

Not sure I understand what you are saying, it's enabling polling we are
talking about.

-- 
MST
