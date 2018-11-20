Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F41C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0321C20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0321C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbeKTLjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:39:52 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:37764 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726119AbeKTLjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:39:52 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.53 with ESMTP; 20 Nov 2018 10:13:21 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.127 with ESMTP; 20 Nov 2018 10:13:21 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Tue, 20 Nov 2018 10:13:21 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     David Miller <davem@davemloft.net>, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181120011321.GD20153@sejong>
References: <20181105203447.GA25674@krava>
 <20181105.194542.476367332910923203.davem@davemloft.net>
 <20181105.200321.1569039579935458312.davem@davemloft.net>
 <20181105.205342.1568518551892125916.davem@davemloft.net>
 <20181106115436.GE3164@krava>
 <20181119052603.GA20153@sejong>
 <20181119091257.GA8967@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119091257.GA8967@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:12:57AM +0100, Jiri Olsa wrote:
> On Mon, Nov 19, 2018 at 02:26:03PM +0900, Namhyung Kim wrote:
> > Hi Jirka
> > 
> > Sorry for late!
> > 
> > On Tue, Nov 06, 2018 at 12:54:36PM +0100, Jiri Olsa wrote:
> > > On Mon, Nov 05, 2018 at 08:53:42PM -0800, David Miller wrote:
> > > > 
> > > > Jiri,
> > > > 
> > > > Because you now run queued_events__queue() lockless with that condvar
> > > > trick, it is possible for top->qe.in to be seen as one past the data[]
> > > > array, this is because the rotate_queues() code goes:
> > > > 
> > > > 	if (++top->qe.in > &top->qe.data[1])
> > > > 		top->qe.in = &top->qe.data[0];
> > > > 
> > > > So for a brief moment top->qe.in is out of range and thus
> > > > perf_top__mmap_read_idx() can try to enqueue to top->qe.data[2]
> > > > 
> > > > We can just do:
> > > > 
> > > > 	if (top->qe.in == &top->qe.data[1])
> > > > 		top->qe.in = &top->qe.data[0];
> > > > 	else
> > > > 		top->qe.in = &top->qe.data[1];
> > > > 
> > > > Or, make top->qe.in an index, and simply go:
> > > > 
> > > > 	top->qe.in ^= 1;
> > > > 
> > > > Either way will fix the bug.
> > > 
> > > ah right.. I had originaly full mutex around that,
> > > then I switched it off in the last patch and did
> > > not realize this implication.. nice ;-)
> > 
> > I like the rotate_queues() using cond-variable.  Have you tried to use
> > the same for hists->lock in hists__get_rotate_entries_in() too?
> > 
> > Eventually it'd be nice to avoid locks when a single thread processes
> > all the events.
> 
> yep, I thought we could use it there as well, but it could
> be more tricky because we use hists->lock for that, which
> is used on other places as well.. will check

I found hists->lock used only 3 places - hists__get_rotate_entries_in()
and perf_event__process_sample() to protect rotating.  The other place
is perf_top__record_precise_ip() which is called during the sample
processing before going to sleep.

Hmm.. I think processing thread should not go to sleep anyway.  It's
the responsibility of display thread show warning (and waiting for
user input or timeout).  I'll try to do something..

Thanks,
Namhyung
