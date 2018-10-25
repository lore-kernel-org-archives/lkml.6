Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A099C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6E22082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6E22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJYSB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:01:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbeJYSB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:01:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F417AFFE;
        Thu, 25 Oct 2018 09:29:31 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 1DEBDE0093; Thu, 25 Oct 2018 11:29:30 +0200 (CEST)
Date:   Thu, 25 Oct 2018 11:29:30 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Manish Kumar Singh <mk.singh@oracle.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Mahesh Bandewar
         =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
         =?utf-8?B?4KSwKQ==?= <maheshb@google.com>,
        linux-netdev <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bonding:avoid repeated display of same link status change
Message-ID: <20181025092930.GC22291@unicorn.suse.cz>
References: <20181023152924.24033-1-mk.singh@oracle.com>
 <CAF2d9jjM+5twGtwnB-JvOaaFbU9-n1oNyMXF6wx=s-0fVn9-6w@mail.gmail.com>
 <65f98009-1ce0-d6fd-06dc-233aa115abc9@gmail.com>
 <20181023162613.GA22291@unicorn.suse.cz>
 <20181023163825.GB22291@unicorn.suse.cz>
 <bee18dd4-0012-44d0-9508-2987bfe521e5@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee18dd4-0012-44d0-9508-2987bfe521e5@default>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 02:21:05AM -0700, Manish Kumar Singh wrote:
> > From: Michal Kubecek [mailto:mkubecek@suse.cz]
> > IMHO it does not. AFAICS multiple instances of bond_mii_monitor() cannot
> > run simultaneously for the same bond so that there doesn't seem to be
> > anything to collide with. (And if they could, we would need to test and
> > set the flag atomically in bond_miimon_inspect().)
> > 
> Yes, Michal, we are inline with your understanding.
> when the -original- patch was posted to upstream there was no
> -synchronization- nor -racing- addressing code was in read/write of this
> added filed, as we -never- saw need for either.
> 
> -only- writer of the added field is bond_mii_monitor.
> -only- reader of the added field is bond_miimon_inspect.
> -this writer & reader -never- can run concurrently.
> -writer invokes the reader.
> 
> hence, imo uint_8 rtnl_needed is all what is needed; with bond_mii_monitor doing rtnl_needed = 1; and bond_miimon_inspect doing if rtnl_needed.
> 
> here is the gravity of the situation with multiple customers whose names including machine names redacted:
> 
>  4353 May 31 02:38:57 hostname kernel: ixgbe 0000:03:00.0: removed PHC on p2p1
>  4354 May 31 02:38:57 hostname kernel: public: link status down for active interface p2p1, disabling it in 100 ms
>  4355 May 31 02:38:57 hostname kernel: public: link status down for active interface p2p1, disabling it in 100 ms
>  4356 May 31 02:38:57 hostname kernel: public: link status definitely down for interface p2p1, disabling it
>  4357 May 31 02:38:57 hostname kernel: public: making interface p2p2 the new active one
>  4358 May 31 02:38:59 hostname kernel: ixgbe 0000:03:00.0: registered PHC device on p2p1
>  4359 May 31 02:39:00 hostname kernel: ixgbe 0000:03:00.0 p2p1: NIC Link is Up 10 Gbps, Flow Control: RX/TX
>  4360 May 31 02:39:00 hostname kernel: public: link status up for interface p2p1, enabling it in 200 ms
>  4361 May 31 02:39:00 hostname kernel: public: link status definitely up for interface p2p1, 10000 Mbps full duplex
>  4362 May 31 02:45:37 hostname journal: Missed 217723 kernel messages
>  4363 May 31 02:45:37 hostname kernel: public: link status down for active interface p2p2, disabling it in 100 ms
>  	---------------------
>                       11000+ APPROX SAME REPEATED MESSAGES in second
> 	---------------------
> 15877 May 31 02:45:37 hostname kernel: public: link status down for active interface p2p2, disabling it in 100 ms
> 15878 May 31 02:45:37 hostname kernel: public: link status definitely down for interface p2p2, disabling it
> 15879 May 31 02:45:37 hostname kernel: public: making interface p2p1 the new active one

When I was replying, I didn't know this was a v2 and I haven't seen the
v1 discussion. I have read it since and I think I understand Eric's
point now. The thing is that just adding e.g. u8 is OK as it is now.
However, someone could later add another u8 next to it which would also
be perfectly OK on its own but reads/writes to these two could collide
between each other.

And as pointed out by a colleague, even having atomic_t and u8 flag in
one 64-bit word could be a problem on architectures which cannot do an
atomic read/write from/to a 32-bit word (sparc seems to be one).

Michal Kubecek
