Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245A6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9902173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAJIIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:08:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbfAJIIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:08:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1BBB73A71;
        Thu, 10 Jan 2019 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B80060C45;
        Thu, 10 Jan 2019 08:08:08 +0000 (UTC)
Message-ID: <6d6297de1fc895f8e589f9ab9140709a0874cbfd.camel@redhat.com>
Subject: Re: [BUG] v4.20 - bridge not getting DHCP responses? (works in
 4.19.13)
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        jeffrey.t.kirsher@intel.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        nikolay@cumulusnetworks.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Date:   Thu, 10 Jan 2019 09:08:07 +0100
In-Reply-To: <CAA85sZtG4cQd5-SrhZWJ-4wXx5f=0b=C0=_Yc0p1Tvxwpg6Oxw@mail.gmail.com>
References: <CAA85sZsiifWTKq=Mw30f-UVyrzywnYYX7GvyqG+O+ndSYBML9A@mail.gmail.com>
         <CAA85sZsj5PxZeiXSVK92QXi93fc+Ch2x2KHqzzPcT2OffaKsEQ@mail.gmail.com>
         <CAA85sZsyEnkmwO2grp3H5pXErrNV=prOjEfPy=odoQ8iSHox4Q@mail.gmail.com>
         <20190108145112.65fc554f@hermes.lan>
         <CAA85sZt=mrqprwkKLGbv2UMy6vQb0XSc58YrWvqxzK4yhdbpGQ@mail.gmail.com>
         <02fbd1e8-8ad1-3a47-c3e1-86adbb73185d@gmail.com>
         <CAA85sZvVHCYFRXp5cYzSDNpesNMtCZOB+Gnb+N+SmraD6eke1A@mail.gmail.com>
         <CAA85sZsF53oFBVzrbuj6wrM43QutKy52S-77PqNZdTChJKOyWQ@mail.gmail.com>
         <CAA85sZtG4cQd5-SrhZWJ-4wXx5f=0b=C0=_Yc0p1Tvxwpg6Oxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 10 Jan 2019 08:08:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 01:38 +0100, Ian Kumlien wrote:
> Confirmed, sending a new mail with summary etc
> 
> On Thu, Jan 10, 2019 at 1:16 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > On Wed, Jan 9, 2019 at 12:17 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > On Wed, Jan 9, 2019, 00:09 Florian Fainelli <f.fainelli@gmail.com wrote:
> > 
> >  [--8<---]
> > 
> > > > > when looking at "git log v4.19...v4.20
> > > > > drivers/net/ethernet/intel/ixgbe/" nothing else really stands out...
> > > > > The machine is also running NAT for my home network and all of that
> > > > > works just fine...
> > > > > 
> > > > > I started with tcpdump, prooving that packets reached all the way
> > > > > outside but replies never made it, reboorting
> > > > > with 4.19.13 resulted in replies appearing in the tcpdump.
> > > > > 
> > > > > I don't quite know where to look - and what can i do to test - i tried
> > > > > disabling all offloading (due to the UDP
> > > > > offloading changes) but nothing helped...
> > > > > 
> > > > > Ideas? Patches? ;)
> > > > 
> > > > Running a bisection would certainly help find the offending commit if
> > > > that is something that you can do?
> > > 
> > > I was hoping for a likely suspect but this was on my "Todo" for Friday night anyway... (And I already started testing with some patches reversed)
> > 
> > So after lengthy git bisect sections, both from the latest stable i
> > was using (not the best of ideas)
> > and from 4.19.
> > 
> > The latest stable yielded 72b0094f918294e6cb8cf5c3b4520d928fbb1a57 -
> > which is incorrect...
> > 
> > However, the proper bisect gave me this:
> > fb420d5d91c1274d5966917725e71f27ed092a85 is the first bad commit
> > commit fb420d5d91c1274d5966917725e71f27ed092a85
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Fri Sep 28 10:28:44 2018 -0700
> > 
> >     tcp/fq: move back to CLOCK_MONOTONIC

Thank you for bisecting. 

Should be solve by:

https://marc.info/?l=linux-netdev&m=154696956604748&w=2

Can you test with the above applied?

Thanks,

Paolo

