Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D123DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB8D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RB3Ykfa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB8D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeFUF0O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:26:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39210 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932465AbeFUF0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:26:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 826308EE1DB;
        Wed, 20 Jun 2018 22:26:12 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IwOpI50e4AEZ; Wed, 20 Jun 2018 22:26:12 -0700 (PDT)
Received: from jarvis (161.21.149.210.rev.iijmobile.jp [210.149.21.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B1B1C8EE01C;
        Wed, 20 Jun 2018 22:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1529558772;
        bh=nEicptZxq2GEAOPsCisFzNo/8PRq3UtmbgKeSZ0PIOc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RB3Ykfa1LxRUS5XrDjTZGpguXK3E9LFINaQyIToeXjgafQBPafouq/ejLhIhehWMT
         uk/cVQQ/G4VyRPZ/GIw43HIfvKXHj6lsUU44QGe7cFj3bEf71QeVLwK4tUbzJtGHuO
         YbdoQ3nLWrjk/J/sJKjV9Q1QwI1z7yMB7uOt6ne0=
Message-ID: <1529558767.3118.1.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 0/2] tpm: add support for nonblocking operation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tstruk@gmail.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, philip.b.tricca@intel.com,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
Date:   Thu, 21 Jun 2018 14:26:07 +0900
In-Reply-To: <0e46c2e9-af2b-550f-2b3d-98cbc1840bc1@gmail.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
         <20180619131046.GC5609@linux.intel.com>
         <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
         <1529539176.4163.2.camel@HansenPartnership.com>
         <0e46c2e9-af2b-550f-2b3d-98cbc1840bc1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 18:24 -0700, Tadeusz Struk wrote:
> On 06/20/2018 04:59 PM, James Bottomley wrote:
> > I'm slightly surprised by this statement.  I thought IoT Node.js
> > runtimes (of which there are far too many, so I haven't looked at
> > all of them) use libuv or one of the forks:
> > 
> > http://libuv.org/
> > 
> > As the basis for their I/O handling?  While libuv can do polling
> > for event driven interfaces it also support the worker thread model
> > just as easily:
> > 
> > http://docs.libuv.org/en/v1.x/threadpool.html
> 
> Yes, it does polling:
> http://docs.libuv.org/en/v1.x/design.html#the-i-o-loop

But that's for networking.  You'll be talking to the TPM RM over the
file descriptor so that follows the thread pool model in

http://docs.libuv.org/en/v1.x/design.html#file-i-o

This precisely describes the current file descriptor abstraction we'd
use for the TPM.

> > > Similarly embedded applications, which are basically just a
> > > single threaded event loop, quite often don't use threads because
> > > of resources constrains.
> > 
> > It's hard for me, as a kernel developer, to imagine any embedded
> > scenario using the Linux kernel that would not allow threads unless
> > the writers simply didn't bother with synchronization: The kernel
> > schedules at the threads level and can't be configured not to use
> > them plus threads are inherently more lightweight than processes so
> > they're a natural fit for resource constrained scenarios.
> > 
> > That's still not to say we shouldn't do this, but I've got to say I
> > think the only consumers would be old fashioned C code: the code we
> > used to write before we had thread libraries that did use signals
> > and poll() for a single threaded event driven monolith (think green
> > threads), because all the new webby languages use threading either
> > explicitly or at the core of their operation.
> 
> Regardless of how it actually might be used, I'm happy that we agree
> on that this *is* the right thing to do.

I didn't say that.  I think using a single worker thread queue is the
correct abstraction for the TPM.  If there's a legacy use case for
poll(), I don't see why not since the code seems to be fairly small and
self contained, but I don't really see it as correct or necessary to do
it that way.

James

