Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943DEECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D6020847
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D6020847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJYGA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:00:29 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41690 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeJYGA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:00:29 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AC5BC1454A8DA;
        Wed, 24 Oct 2018 14:30:45 -0700 (PDT)
Date:   Wed, 24 Oct 2018 14:30:45 -0700 (PDT)
Message-Id: <20181024.143045.1124161066942465584.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, dzickus@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: perf overlapping maps...
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181024113416.GA26027@krava>
References: <20181023180503.GA6114@kernel.org>
        <20181023.111503.1978409398989251135.davem@davemloft.net>
        <20181024113416.GA26027@krava>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Oct 2018 14:30:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Wed, 24 Oct 2018 13:34:16 +0200

> On Tue, Oct 23, 2018 at 11:15:03AM -0700, David Miller wrote:
>> From: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Date: Tue, 23 Oct 2018 15:05:03 -0300
>> 
>> > IIRC this was first done for 'perf record', where we have to stash those
>> > events in the perf.data file, to then, later, 'perf report' to process
>> > those, so when working on 'perf top', it just reuses that machinery.
>> > 
>> > Sure, with some love and care 'perf top' could do better and update all
>> > the data structures directly :-)
>> 
>> Thanks for the history, it is useful information :)
>> 
>> > Anyway, have you guys considered tweaking using event->header.misc |=
>> > PERF_RECORD_MISC_USER? The kernel leaves that as zero for the
>> > PERF_RECORD_FORK it emits:
>> 
>> I really would like to steer the approach away from using UAPI
>> perf_event fields in an internal way.
>> 
>> I am really very sorry for suggesting such a scheme myself in the
>> first place.  It really was a bad idea upon much consideration.
>> 
>> The synthetic fork is not really a fork, it's more like a "create".
>> 
>> And this fundamental semantic difference is why we have all of these
>> issues wrt. handling COMM and parent map inheritance.
>> 
>> There is also a bunch of non-trivial code to deal with whether we
>> synthetically create the child or the parent first, wrt. finding
>> thread leaders and parent threads.
>> 
>> What I'm trying to say is that there is a clean design based solution
>> hiding somewhere in here and I'd like to find it :-)
> 
> how about adding a data file marker/event when the synthesized
> portion of data is over
> 
> attached patch adds an 'SYNTHESIZE_END' event and prevents
> parent's maps cloning on fork until that event is found
> 
> we would need more code to stay backward compatible, which
> I did not include.. just to cleanly outline the solution

I appreciate everyone reiterating the ABI issue.  Wherein, perf record
stashes these events into a file and later analysis tools need to
interpret them.

Considering this specifically, it is very tempting to make a new event
representing this thread "CREATE" operation.

But, if we make a new event then existing tools will break because
they will see this unrecognizable event and not create the threads.

From this perspective setting a misc flag in the FORK event might in
fact be the best compromise.

Existing tools will still create the thread, in exactly the same
existing way.  This keeps things working as well as they do currently.

So my vote returns to emitting FORK with the special COMM flag set in
the misc flags.  And we document this properly of course.

Any objections?  I'll cook up a formal patch meanwhile in case we do
agree.
