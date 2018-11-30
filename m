Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F52D2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw7Ry8Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F52D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeK3SvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbeK3SvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:51:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFEAB20868;
        Fri, 30 Nov 2018 07:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543563775;
        bh=6mf5NLGJPILHK2ex3/bXGnH1jbYfEcSoI9g1pWcZUNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uw7Ry8EzTZPVX61RQrfG8FfUbh6S47Yn9k7Fdt2AuG9afQMjmRiEu5GmcglxmMQzV
         1evLjQvHuZWx4TYcbdGiTllY/vKTb6oi3Uw7ldl86TeFdS0wKWzCRCykG41ys5GDac
         mIaQdb2UZK7NFDOtek6/wP03RSZIij3+HRhVkyzw=
Date:   Fri, 30 Nov 2018 08:42:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        hpa@zytor.com, suzuki.poulosi@arm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/6] coresight: Use PMU driver configuration for sink
 selection
Message-ID: <20181130074253.GA3314@kroah.com>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
 <20181129074936.GE12347@kroah.com>
 <20181129230915.GA8881@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129230915.GA8881@xps15>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:09:15PM -0700, Mathieu Poirier wrote:
> Hi Greg,
> 
> On Thu, Nov 29, 2018 at 08:49:36AM +0100, Greg KH wrote:
> > On Wed, Nov 28, 2018 at 03:01:16PM -0700, Mathieu Poirier wrote:
> > > This patch uses the PMU driver configuration held in event::hw::drv_config
> > > to select a sink for each event that is created (the old sysFS way of
> > > working is kept around for backward compatibility).
> > 
> > It is "sysfs", no InterCaps please, I've never called it that in the
> > past.
> > 
> > And just use sysfs, if that does not work properly, then fix that, don't
> > create yet-another-way-to-configure-this-thing to just confuse people.
> 
> Thanks for the review, you've provided usefull comments.
> 
> Regarding the "char *" argument for the ioctl, I followed an example that
> currently exist but I can proceed differently.  

What driver currently uses a char * on an ioctl to parse arbritrary
userspace information to set its configuration?  That should be fixed...

> My goal with this patchset was specifically to fix what is wrong with sysfs and
> completely take it out of the equation.  The only reason to keep the kernel 
> interface alive was to prevent braking older user space perf tools currently
> using it.  

That's fine, just don't create a new syscall that takes arbritrary data
and parses it in the kernel, that's not ok.

> I chose to use an ioctl() because it is flexible and well suited for the dynamic
> nature of perf events.  It is also currently used to set various event specific 
> configuration so doing the same adds to the established pattern and avoids
> creating a new way of doing things, something the perf crew would have been
> quick to point out.
> 
> Was my approach wrong?

I don't know how the perf interface works, so perhaps work with those
developers to sync up and match what they use today?

But step back, what exactly are you trying to do here?  You have an
implementation of a solution but I don't see the problem stated anywhere
here.

thanks,

greg k-h
