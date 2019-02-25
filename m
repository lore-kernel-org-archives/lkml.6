Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBFF2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfBYT1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:27:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfBYT1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:27:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3232A768;
        Mon, 25 Feb 2019 19:27:03 +0000 (UTC)
Received: from carbon (ovpn-200-42.brq.redhat.com [10.40.200.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0050F19492;
        Mon, 25 Feb 2019 19:26:54 +0000 (UTC)
Date:   Mon, 25 Feb 2019 20:26:53 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        syzbot <syzbot+8218a8a0ff60c19b8eae@syzkaller.appspotmail.com>,
        ast@kernel.org, christian@brauner.io, davem@davemloft.net,
        dsahern@gmail.com, hawk@kernel.org, idosch@mellanox.com,
        john.fastabend@gmail.com, kafai@fb.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        petrm@mellanox.com, roopa@cumulusnetworks.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        xdp-newbies@vger.kernel.org, yhs@fb.com, brouer@redhat.com
Subject: Re: INFO: task hung in rtnetlink_rcv_msg
Message-ID: <20190225202653.4dbe00c2@carbon>
In-Reply-To: <57807dca3bf554d0a07356ba1e53fae4d58cfb51.camel@perches.com>
References: <000000000000c07a5805827e85d5@google.com>
        <20190222120129.1f2f1c17@cakuba.netronome.com>
        <e049375f676938b5ad64898ac928b27cd783dc2a.camel@perches.com>
        <20190222134511.13eb7a82@cakuba.netronome.com>
        <279c5bae-0b18-b03a-2858-4749e18afa26@iogearbox.net>
        <20190225093933.748ceab4@carbon>
        <57807dca3bf554d0a07356ba1e53fae4d58cfb51.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 25 Feb 2019 19:27:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 08:55:40 -0800
Joe Perches <joe@perches.com> wrote:

> On Mon, 2019-02-25 at 09:39 +0100, Jesper Dangaard Brouer wrote:
> > On Sat, 23 Feb 2019 01:47:00 +0100
> > Daniel Borkmann <daniel@iogearbox.net> wrote:
> >   
> > > On 02/22/2019 10:45 PM, Jakub Kicinski wrote:  
> > > > On Fri, 22 Feb 2019 12:14:57 -0800, Joe Perches wrote:    
> > > > > On Fri, 2019-02-22 at 12:01 -0800, Jakub Kicinski wrote:    
> > > > > > Hi!
> > > > > > 
> > > > > > Seems like something funny is going on with get_maintainer.pl since XDP
> > > > > > entry got added.  We seem to have been CCed on:      
> > > > > 
> > > > > I suggest removing the MAINTAINERS line with
> > > > > 
> > > > > 	K:	xdp
> > > > > 
> > > > > as xdp is a pretty generic file/patch content
> > > > > regex match for the K: type
> > > > > 
> > > > > $ git grep --name-only xdp | wc -l
> > > > > 236  
> > 
> > I'm unsure how K: works, but you grep definitely selects some wrong files.
> > 
> > I tried with "xdp_":
> >  git grep --name-only xdp_
> > 
> > That does catch all the driver that have XDP support, which is the
> > point of the exercise (to catch drivers).
> > 
> > It does contain a couple of false-positives:
> >   drivers/net/ethernet/neterion/vxge/vxge-traffic.c
> >   drivers/thunderbolt/tb_msgs.h
> >   drivers/thunderbolt/xdomain.c
> >   sound/soc/codecs/rt5670.c
> > 
> > Via the pattern '[^a-z]xdp_' I'm only left with the thunderbolt
> > false-positive, as it have a data struct's called tb_xdp_*.  
> 
> Then it's probably better to use
> 
> K:	\Wxdp_
> 
> and if XDP_ is also to be matched, maybe
> 
> K:	(?i:\Wxdp_)
> 

The last one seems to be the best at matching the relevant files :-)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
