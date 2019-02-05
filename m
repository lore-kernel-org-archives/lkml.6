Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226F6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9FC20811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549392241;
	bh=efIApx4917Iza3mL9mRxqSTNdRRyvX7xbsA4PuiXWJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pg1WsX5Ygq1aIa2M0jgHDb+Ztt0VCipSTL0cJNfNM81p1OjBfdyLsI/65F2a6qVLb
	 QKz3fQJQb+ovCKb8zg0iH4RRY37ui7hVXvqm40oh4ACR8sUWfRqTROElFSh2IquvlA
	 4s4DEaUUgFE2OS2GMcMaRDeLF0Cy+5iMIjzhzySQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfBESn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfBESn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:43:59 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A303420811;
        Tue,  5 Feb 2019 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549392238;
        bh=efIApx4917Iza3mL9mRxqSTNdRRyvX7xbsA4PuiXWJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lcqk6mwS6fNyrrtkM5Sd0+4iuQWg+jK3+pTMeCNd2SBr8YKP290630hwBoyvf6Bv7
         JAfV8IrpqKFg63B7cW9d8Z/pryxL8DOlzBoua2ouIZ1o6gtyb242wdSN6siJS46Z9g
         T81UCQmfczNzMjfdAma+zHu9dRMqsEo33yh6IDgI=
Date:   Tue, 5 Feb 2019 19:43:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
Message-ID: <20190205184355.GC22198@kroah.com>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUsq55EUKa0rYCeQ62VanhwNUxs-pfkJxUwqd4HO3m-Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiUsq55EUKa0rYCeQ62VanhwNUxs-pfkJxUwqd4HO3m-Lg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:22:50AM -0500, Sven Van Asbroeck wrote:
> On Tue, Feb 5, 2019 at 9:57 AM Kees Cook <keescook@chromium.org> wrote:
> >
> >
> > Can a Coccinelle script get written to find module-use of the non-devm
> > work init?
> 
> My thoughts exactly ! But sadly I'm not a Coccinelle expert. I did
> look briefly at
> its syntax, but I didn't immediately "get" how Cocci could find this class of
> errors, without a huge false positive rate (which would make it worse than
> useless).
> 
> >
> > It seems like finding these in __init functions should be relatively
> > easy? (Or can we add runtime detection in the existing INIT_*WORK()
> > code to see if it is running from the wrong place?)
> >
> 
> IMHO the problem isn't that they're called from __init functions.
> Also, nothing is
> wrong with the location of INIT_*WORK per se.
> 
> The real problem is that developers overlook calling cancel_work_sync()
> on unload. I'm not sure how we could bolt on runtime detection to catch
> a *missing* function. Again, without causing tons of false positives.

It really should happen when the device is removed (if it is a driver
that binds to a device.)  If this is not a driver, then there should be
some way to scan that cancel_work_sync() is never called or not, right?

thanks,

greg k-h
