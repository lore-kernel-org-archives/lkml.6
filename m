Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D294F208E8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D294F208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeGKAI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:08:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:51911 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732262AbeGKAI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:08:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6B07Ees015568;
        Tue, 10 Jul 2018 19:07:15 -0500
Message-ID: <12f49dfa50ea32039194d5e91861ebef8c9b0565.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] drivers: core: Don't try to use a dead glue_dir
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Jul 2018 10:07:14 +1000
In-Reply-To: <CA+55aFwWq1pMzKbkgTN9f9srSHubq+tKKPHwZazqt8ODD3btNQ@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
         <CA+55aFwg+j60ZFi7t7kVXbobCT4XHoiZP_w6+Cbm+AeU1ytfNQ@mail.gmail.com>
         <20180707164838.GC16279@kroah.com>
         <c105fb1ff12533b4980098ecd411089e0630b6bf.camel@kernel.crashing.org>
         <20180710145549.GB11703@kroah.com>
         <c9e513337a1792af7e86b0646b218a1f0a3c379f.camel@kernel.crashing.org>
         <CA+55aFwWq1pMzKbkgTN9f9srSHubq+tKKPHwZazqt8ODD3btNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 16:55 -0700, Linus Torvalds wrote:
> On Tue, Jul 10, 2018 at 4:32 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > > I like that fix, which should make this patch obsolete, right?
> > 
> > Yes, for that specific issue, but Linus seemed to think patch 1 was the
> > "right thing to do" regardless...
> 
> I would definitely prefer either a kobject_get_unless_zero() or a
> warning if it is ever zero.
> 
> The fact that right now it silently can do known bad things, and then
> causes odd corruption _later_, is not good.

Maybe we should make the existing warning in refcount unconditional ? 

This is whe warning that allowed me to pull that string with the
gluedirs and fix what ended up very weird crashes caused by the
resulting use-after-free. So it's definitely valuable.

As for whether we should generalize kobject_get_unless_zero() vs avoid
using it alltogether, this is a debate for you to have with Greg ;-)

He seems to think nothing should ever try to get a zeroed object (which
I tend to agree with, it's close to my opinion that visibility and
lifetime should be disconnected).

That being said, there are existing constructs such as the "late
removal from sysfs from kobject_release" that mean that zero-reference
objects *can* still be visible, via either sysfs or ksets, as far as I
can tell.

So it's a bit of a mess... but if we chose to go Greg's way we should
probably put a WARN'ing in kobject_release() for late-removal from
sysfs since this exposes 0-ref objects to outside visibility.

Cheers,
Ben.

