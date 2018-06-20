Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D30C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2E120872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="AXypA/fH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2E120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933202AbeFTX7n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:59:43 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37124 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932571AbeFTX7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:59:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5CD678EE1DB;
        Wed, 20 Jun 2018 16:59:40 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J0Fb7OXRQbF8; Wed, 20 Jun 2018 16:59:40 -0700 (PDT)
Received: from jarvis (179.21.149.210.rev.iijmobile.jp [210.149.21.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9283A8EE01C;
        Wed, 20 Jun 2018 16:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1529539180;
        bh=HDhEPSPTqcCtT6Qo0jk7tszfkl8nNg5KZ0F+VJYoUjc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AXypA/fHi8JJbIq/LPh4k3UQnfyy484w3zsQ0bUYC+HwI/Q/YfKcuS4we4wxruXQ6
         rzVQXiXBVPx+pQKHOW2mJhDl4ci4e0yGyG6KTZFN9Tu74LC0GhQSS2TQlHGnLlG1A0
         hQZlk78V65uB8kHPXDpFtUUAgUETTf+0PEkjRnF0=
Message-ID: <1529539176.4163.2.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 0/2] tpm: add support for nonblocking operation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, philip.b.tricca@intel.com,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
Date:   Thu, 21 Jun 2018 08:59:36 +0900
In-Reply-To: <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
         <20180619131046.GC5609@linux.intel.com>
         <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 17:45 -0700, Tadeusz Struk wrote:
> On 06/19/2018 06:10 AM, Jarkko Sakkinen wrote:
> > On Tue, Jun 12, 2018 at 10:58:26AM -0700, Tadeusz Struk wrote:
> > > The TCG SAPI specification [1] defines a set of functions, which
> > > allows applications to use the TPM device in either blocking or
> > > non-blocking fashion. Each command defined by the specification
> > > has a corresponding Tss2_Sys_<COMMAND>_Prepare() and
> > > Tss2_Sys_<COMMAND>_Complete() call, which together with
> > > Tss2_Sys_ExecuteAsync() is designed to allow asynchronous
> > > mode of operation. Currently the TPM driver supports only
> > > blocking calls, which doesn't allow asynchronous IO operations.
> > > This patch changes it and adds support for nonblocking write and
> > > a new poll function to enable applications, which want to take
> > > advantage of this feature. The new functionality can be tested
> > > using standard TPM tools implemented in [2], together with
> > > modified TCTI from [3].
> > > 
> > > [1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_SAPI
> > > _Version-1.1_Revision-22_review_030918.pdf
> > > [2] https://github.com/tpm2-software/tpm2-tools
> > > [3] https://github.com/tstruk/tpm2-tss/tree/async
> > 
> > For me the value is still a bit questionable. The benchmark looks a
> > bit flakky to give much figures how this would work with real world
> > workloads.
> > 
> > I read James response and I also have to question why not just a
> > worker thread in user space? TPM does only one command at a time
> > anyways.
> > 
> > Cannot take this in before I know that user space will (1) adapt to
> > this and (2) gain value compared to a worker thread.
> > 
> 
> Hi Jarkko,
> Thanks for reviewing the patch.
> There are applications/frameworks where a worker thread is not an
> option.
> Take for example the IoT use-cases and frameworks like IoT.js, or
> "Node.js for IoT".
> They are all single threaded, event-driven frameworks, using non-
> blocking I/O as the base of their processing model.

I'm slightly surprised by this statement.  I thought IoT Node.js
runtimes (of which there are far too many, so I haven't looked at all
of them) use libuv or one of the forks:

http://libuv.org/

As the basis for their I/O handling?  While libuv can do polling for
event driven interfaces it also support the worker thread model just as
easily:

http://docs.libuv.org/en/v1.x/threadpool.html

> Similarly embedded applications, which are basically just a single
> threaded event loop, quite often don't use threads because of
> resources constrains.

It's hard for me, as a kernel developer, to imagine any embedded
scenario using the Linux kernel that would not allow threads unless the
writers simply didn't bother with synchronization: The kernel schedules
at the threads level and can't be configured not to use them plus
threads are inherently more lightweight than processes so they're a
natural fit for resource constrained scenarios.

That's still not to say we shouldn't do this, but I've got to say I
think the only consumers would be old fashioned C code: the code we
used to write before we had thread libraries that did use signals and
poll() for a single threaded event driven monolith (think green
threads), because all the new webby languages use threading either
explicitly or at the core of their operation.

James

