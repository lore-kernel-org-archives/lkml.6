Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5BCADC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3AD208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3AD208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933804AbeFLK3D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:29:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:48331 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933088AbeFLK27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:28:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5CASmvB028006;
        Tue, 12 Jun 2018 05:28:49 -0500
Message-ID: <53ef03b26a17738dc1465ce85562c9611ad415f8.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 12 Jun 2018 20:28:48 +1000
In-Reply-To: <CAHp75VfJNrviiiam9p49+6_oSjW+YH8vwjcZ2hn5Ux5mHgDCQw@mail.gmail.com>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
         <CAHp75VfJNrviiiam9p49+6_oSjW+YH8vwjcZ2hn5Ux5mHgDCQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 11:35 +0300, Andy Shevchenko wrote:
> On Tue, Jun 12, 2018 at 3:01 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > There are still quite a few cases where a device might want to get to a
> > different node of the device-tree, obtain the resources and map them.
> > 
> > Drivers doing that currently open code the whole thing, which is error
> > proe.
> 
> prone
> 
> > 
> > We have of_iomap() and of_io_request_and_map() but they both have shortcomings,
> > such as not returning the size of the resource found (which can be necessary)
> > and not being "managed".
> > 
> > This adds a devm_of_iomap() that provides all of these and should probably
> > replace uses of the above in most drivers.
> 
> It feels like a wrong approach.
> Can OF graph help here? Would it be better approach?

I don't quite understand what your objection is nor what "OF graph"
is...

This is a direct replacement for the open coded equivalent that a
number of drivers do, almost always without using devm_* or forgetting
to request the resources etc... Ie, a less bug-prone tool in the
toolbox.

So there's a real use case here.

In fact a driver I'm going to submit soon uses it, which is why I wrote
it in the first place, rather than adding yet another open-coded case.

And to reply to the inevitable next reaction, NO this is not a case for
creating yet another 237 layers of abstractions. Sometimes, a driver
needs to directly access (no regmap overhead please) some regions
represented by a specific DT node (it could be a child of the device
for example representing a portion of its register space, or it could
be a separate piece of HW that needs to be used by the device but
doesn't fit in any abstract model and shouldn't).

Ben.

