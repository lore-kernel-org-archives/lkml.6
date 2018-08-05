Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128C6C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE522145D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE522145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeHEQHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:07:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeHEQHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:07:48 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9A2DA40B;
        Sun,  5 Aug 2018 14:03:05 +0000 (UTC)
Date:   Sun, 5 Aug 2018 16:03:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org, Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
Message-ID: <20180805140301.GA17056@kroah.com>
References: <20180804082702.434482435@linuxfoundation.org>
 <20180804082706.427556290@linuxfoundation.org>
 <20180804180734.GA25546@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804180734.GA25546@flashbox>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 11:07:34AM -0700, Nathan Chancellor wrote:
> On Sat, Aug 04, 2018 at 11:01:35AM +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Dmitry Safonov <dima@arista.com>
> > 
> > [ Upstream commit 7acf9d4237c46894e0fa0492dd96314a41742e84 ]
> > 
> > Make ABI more strict about subscribing to group > ngroups.
> > Code doesn't check for that and it looks bogus.
> > (one can subscribe to non-existing group)
> > Still, it's possible to bind() to all possible groups with (-1)
> > 
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Steffen Klassert <steffen.klassert@secunet.com>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  net/netlink/af_netlink.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -983,6 +983,7 @@ static int netlink_bind(struct socket *s
> >  		if (err)
> >  			return err;
> >  	}
> > +	groups &= (1UL << nlk->ngroups) - 1;
> >  
> >  	bound = nlk->bound;
> >  	if (bound) {
> > 
> > 
> 
> Hi Greg,
> 
> I am so sorry I didn't catch this in my initial report but this commit
> along with ba7aaf93ef2f ("netlink: Don't shift with UB on nlk->ngroups")
> breaks mobile data on both the Pixel 2 XL and OnePlus 6. There is signal
> but it just never connects to 3G/LTE. Reverting those two commits fixes
> the issue.
> 
> Nothing stands out to me in dmesg unfortunately and iven neither device
> is running a vanilla kernel, I cannot say if this is a problem in mainline
> or not but I just wanted to make you aware of it.

Many thanks for catching this.  I'll go drop this patch from the trees
for now, and will queue it up later with the fixup patch when that lands
in Linus's tree.

thanks,

greg k-h
