Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0560A208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0560A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeH0UZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:25:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbeH0UZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:25:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15E174021FC6;
        Mon, 27 Aug 2018 16:38:15 +0000 (UTC)
Received: from x2.localnet (ovpn-124-39.rdu2.redhat.com [10.10.124.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73C4463532;
        Mon, 27 Aug 2018 16:38:10 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
Date:   Mon, 27 Aug 2018 12:38:09 -0400
Message-ID: <4819575.TSNxuEWROA@x2>
Organization: Red Hat
In-Reply-To: <CAFqZXNvADB-E_fjEaQpUymSVvfP-vXQXtk3K+nJ9DqrScHL8bQ@mail.gmail.com>
References: <20180824120001.20771-1-omosnace@redhat.com> <20180827075020.GL27091@localhost> <CAFqZXNvADB-E_fjEaQpUymSVvfP-vXQXtk3K+nJ9DqrScHL8bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 16:38:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 27 Aug 2018 16:38:15 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgrubb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 27, 2018 5:13:17 AM EDT Ondrej Mosnacek wrote:
> On Mon, Aug 27, 2018 at 9:50 AM Miroslav Lichvar <mlichvar@redhat.com> 
wrote:
> > On Fri, Aug 24, 2018 at 02:00:00PM +0200, Ondrej Mosnacek wrote:
> > > This patch adds two auxiliary record types that will be used to
> > > annotate
> > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > been changed.
> > 
> > It seems the "adjust" function intentionally logs also calls/modes
> > that don't actually change anything. Can you please explain it a bit
> > in the message?
> > 
> > NTP/PTP daemons typically don't read the adjtimex values in a normal
> > operation and overwrite them on each update, even if they don't
> > change. If the audit function checked that oldval != newval, the
> > number of messages would be reduced and it might be easier to follow.
> 
> We actually want to log any attempt to change a value, as even an
> intention to set/change something could be a hint that the process is
> trying to do something bad (see discussion at [1]).

One of the problems is that these applications can flood the logs very 
quickly. An attempt to change is not needed unless it fails for permissions 
reasons. So, limiting to actual changes is probably a good thing.

-Steve

> There are valid
> arguments both for and against this choice, but we have to pick one in
> the end... Anyway, I should explain the reasoning in the commit
> message better, right now it just states the fact without explanation
> (in the second patch), thank you for pointing my attention to it.
> 
> [1] https://www.redhat.com/archives/linux-audit/2018-July/msg00061.html
> 
> --
> Ondrej Mosnacek <omosnace at redhat dot com>
> Associate Software Engineer, Security Technologies
> Red Hat, Inc.




