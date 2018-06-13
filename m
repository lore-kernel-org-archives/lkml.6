Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B80D5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA232086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA232086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934942AbeFMASa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:18:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:37284 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933126AbeFMAS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:18:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5D0IOiX018643;
        Tue, 12 Jun 2018 19:18:25 -0500
Message-ID: <ddc9a616517f8c4255efe2f57d13d3b3ba81ee89.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 13 Jun 2018 10:18:24 +1000
In-Reply-To: <CAHp75VfV7actoXkMUbh9KwAXR1FKR_VZ5RAuaL-pKLSynFi-3g@mail.gmail.com>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
         <CAHp75VfJNrviiiam9p49+6_oSjW+YH8vwjcZ2hn5Ux5mHgDCQw@mail.gmail.com>
         <53ef03b26a17738dc1465ce85562c9611ad415f8.camel@kernel.crashing.org>
         <CAHp75Vcdaejn=eq740YNdscSv9zX9xj3RzYp=AFs8HFprw34_Q@mail.gmail.com>
         <5d932502d9985cdfa6540480ea5ce6b0730502a1.camel@kernel.crashing.org>
         <CAHp75VfV7actoXkMUbh9KwAXR1FKR_VZ5RAuaL-pKLSynFi-3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-13 at 02:16 +0300, Andy Shevchenko wrote:
> On Wed, Jun 13, 2018 at 1:58 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2018-06-12 at 19:53 +0300, Andy Shevchenko wrote:
> > > 
> > > > > It feels like a wrong approach.
> > > > > Can OF graph help here? Would it be better approach?
> > > > 
> > > > I don't quite understand what your objection is nor what "OF graph"
> > > > is...
> > > 
> > > There is no objection per se, just a doubt that this is a right thing to do.
> > > I might be wrong, of course.
> > > 
> > > OF graph nodes is a special API that allows you to access like you
> > > said "different node of device-tree".
> > > https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/graph.txt
> > 
> > So I had a look and this is just an example on how to use phandles to
> > link ports and endpoints... I fail to see how that relates to what this
> > patch does.
> 
> Because your patch does nothing except another layring of the existing APIs.

I'm really having a hard time understanding what you are going on
about..

Yes, it's a helper that combines two existing API functions, the goal
being to generally replace the use of the existing of_iomap whenever
possible. It makes sense and makes callers simpler and less bug prone.

> 
> > In the driver I'm doing for example, I do use a similar technique to
> > "point" to the other node. In this case, this is a coprocessor in the
> > SoC and I'm linking to the node that represent its interrupt controller
> > (and its not a full fledged OS running there so we don't have a full
> > interrupt tree for it).
> 
> Hmm... So, you are trying to solve problem with other methods which
> might be not so suitable at all?

Again, I cannot understand what you are going on about, what is "not
suitable" to what purpose ?

It's fairly common for nodes to point to each other. We've been doing
that since the dawn of the device-tree.

In this case, we have a coprocessor bound to a device and pointing to
its interrupt controller, and we need to get to that and map it, I fail
to see what the issue is and in what way this is "not suitable".

But there are many other uses of things like of_iomap() which could
benefit from switching to devm_of_iomap() and thus getting the
automated cleanup on exit and appropriate request of the memory
resource.

(hint: I wrote of_iomap and a good bulk of what's in
drivers/of/address.c...

Ben.

