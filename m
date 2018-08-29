Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAECFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDB420652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDB420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeH2WLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:11:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50882 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeH2WLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:11:14 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fv4xn-0003ML-Rx
        for linux-kernel@vger.kernel.org; Wed, 29 Aug 2018 18:13:08 +0000
Received: by mail-pl1-f200.google.com with SMTP id b93-v6so2583030plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 11:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e8mWiGGVMlLOBJ7Rs6pxY5j05s/5ZmVcy2tG+VXbbPM=;
        b=Jbvqo+XuDc/pdqcLbyzKhziK2Oc4Lq4KwPbXnK4Okq/OV7e2eklkkaocre64B9cfHJ
         exQKBFV5cd7+2PVccROYs3KKN/C44LOBPTWb9EeWqhhFu7i/X6ClzSbBDmxTDWDsvx5f
         EyKZajYtKlw4x8BjTl/2x0WgWOga7urVI1cCLDVYUdJUV+Sy3dS8RNOf8xyui4vrnJrq
         IJ0tnFSu+dLAUu1qPlvg+tobbf0ofigMMHzlbE2vNruGnS1F25aJtNKL6O5IMZyfASZV
         wQn6dnBU0MsAMykpxKo58RpNYPzKljzhcL7n1XVIlyw5dyRKHvjcF93OOYhhMsA/sLBU
         xJ6A==
X-Gm-Message-State: APzg51Aydwjao1sXJu8OP1HbJT65fE/JNFcQqrYnZTtRRQXDTWrD03l1
        W98PSd3/ENi3juYPodunHsnZb9CSvJUzMIdNYf8J0xvzn2E8AM+4CVDn/f5dEqubpqCqQEIeXOy
        OWU9qdORQOeqsa1Ew0Rl+hAmHJgRmlYbmRBY9bptRkQ==
X-Received: by 2002:a63:28c7:: with SMTP id o190-v6mr6664334pgo.84.1535566386426;
        Wed, 29 Aug 2018 11:13:06 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdY0rZ81sAA5IX7fRh6U68wlzaQoIc+qYuuh9sha1CRT0NatIkSqYQ0SzQ9kazjb6uFkWWs0kQ==
X-Received: by 2002:a63:28c7:: with SMTP id o190-v6mr6664310pgo.84.1535566386086;
        Wed, 29 Aug 2018 11:13:06 -0700 (PDT)
Received: from gmail.com ([72.28.92.217])
        by smtp.gmail.com with ESMTPSA id 143-v6sm6705410pfy.156.2018.08.29.11.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 11:13:05 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Wed, 29 Aug 2018 20:13:04 +0200
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
Message-ID: <20180829181303.4sacopk7y3p5xyou@gmail.com>
References: <20180828231859.29758-1-christian@brauner.io>
 <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

Thanks for the question!

On Wed, Aug 29, 2018 at 11:30:37AM +0300, Kirill Tkhai wrote:
> Hi, Christian,
> 
> On 29.08.2018 02:18, Christian Brauner wrote:
> > From: Christian Brauner <christian@brauner.io>
> > 
> > Hey,
> > 
> > A while back we introduced and enabled IFLA_IF_NETNSID in
> > RTM_{DEL,GET,NEW}LINK requests (cf. [1], [2], [3], [4], [5]). This has led
> > to signficant performance increases since it allows userspace to avoid
> > taking the hit of a setns(netns_fd, CLONE_NEWNET), then getting the
> > interfaces from the netns associated with the netns_fd. Especially when a
> > lot of network namespaces are in use, using setns() becomes increasingly
> > problematic when performance matters.
> 
> could you please give a real example, when setns()+socket(AF_NETLINK) cause
> problems with the performance? You should do this only once on application
> startup, and then you have created netlink sockets in any net namespaces you
> need. What is the problem here?

So we have a daemon (LXD) that is often running thousands of containers.
When users issue a lxc list request against the daemon it returns a list
of all containers including all of the interfaces and addresses for each
container. To retrieve those addresses we currently rely on setns() +
getifaddrs() for each of those containers. That has horrible
performance.
The problem with what you're proposing is that the daemon would need to
cache a socket file descriptor for each container which is something
that we unfortunately cannot do since we can't excessively cache file
descriptors because we can easily hit the open file limit. We also
refrain from caching file descriptors for a long time for security
reasons.

For the case where users just request a list of the interfaces we
can already use RTM_GETLINK + IFLA_IF_NETNS which has way better
performance. But we can't do the same with RTM_GETADDR requests which
was an oversight on my part when I wrote the original patchset for the
RTM_*LINK requests. This just rectifies this and aligns RTM_GETLINK +
RTM_GETADDR.
Based on this patchset I have written a userspace POC that is basically
a netns namespace aware getifaddr() or - as I like to call it -
netns_getifaddr().

> 
> > Usually, RTML_GETLINK requests are followed by RTM_GETADDR requests (cf.
> > getifaddrs() style functions and friends). But currently, RTM_GETADDR
> > requests do not support a similar property like IFLA_IF_NETNSID for
> > RTM_*LINK requests.
> > This is problematic since userspace can retrieve interfaces from another
> > network namespace by sending a IFLA_IF_NETNSID property along but
> > RTM_GETLINK request but is still forced to use the legacy setns() style of
> > retrieving interfaces in RTM_GETADDR requests.
> > 
> > The goal of this series is to make it possible to perform RTM_GETADDR
> > requests on different network namespaces. To this end a new IFA_IF_NETNSID
> > property for RTM_*ADDR requests is introduced. It can be used to send a
> > network namespace identifier along in RTM_*ADDR requests.  The network
> > namespace identifier will be used to retrieve the target network namespace
> > in which the request is supposed to be fulfilled.  This aligns the behavior
> > of RTM_*ADDR requests with the behavior of RTM_*LINK requests.
> > 
> > Security:
> > - The caller must have assigned a valid network namespace identifier for
> >   the target network namespace.
> > - The caller must have CAP_NET_ADMIN in the owning user namespace of the
> >   target network namespace.
> > 
> > Thanks!
> > Christian
> > 
> > [1]: commit 7973bfd8758d ("rtnetlink: remove check for IFLA_IF_NETNSID")
> > [2]: commit 5bb8ed075428 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_NEWLINK")
> > [3]: commit b61ad68a9fe8 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_DELLINK")
> > [4]: commit c310bfcb6e1b ("rtnetlink: enable IFLA_IF_NETNSID for RTM_SETLINK")
> > [5]: commit 7c4f63ba8243 ("rtnetlink: enable IFLA_IF_NETNSID in do_setlink()")
> > 
> > Christian Brauner (5):
> >   rtnetlink: add rtnl_get_net_ns_capable()
> >   if_addr: add IFA_IF_NETNSID
> >   ipv4: enable IFA_IF_NETNSID for RTM_GETADDR
> >   ipv6: enable IFA_IF_NETNSID for RTM_GETADDR
> >   rtnetlink: move type calculation out of loop
> > 
> >  include/net/rtnetlink.h      |  1 +
> >  include/uapi/linux/if_addr.h |  1 +
> >  net/core/rtnetlink.c         | 15 +++++---
> >  net/ipv4/devinet.c           | 38 +++++++++++++++-----
> >  net/ipv6/addrconf.c          | 70 ++++++++++++++++++++++++++++--------
> >  5 files changed, 97 insertions(+), 28 deletions(-)
> > 
