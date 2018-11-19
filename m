Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DC5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A1220817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A1220817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeKSTgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:36:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeKSTgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:36:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7B193084242;
        Mon, 19 Nov 2018 09:13:00 +0000 (UTC)
Received: from krava (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id 456CB19490;
        Mon, 19 Nov 2018 09:12:58 +0000 (UTC)
Date:   Mon, 19 Nov 2018 10:12:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     David Miller <davem@davemloft.net>, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181119091257.GA8967@krava>
References: <20181105203447.GA25674@krava>
 <20181105.194542.476367332910923203.davem@davemloft.net>
 <20181105.200321.1569039579935458312.davem@davemloft.net>
 <20181105.205342.1568518551892125916.davem@davemloft.net>
 <20181106115436.GE3164@krava>
 <20181119052603.GA20153@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119052603.GA20153@sejong>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 19 Nov 2018 09:13:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:26:03PM +0900, Namhyung Kim wrote:
> Hi Jirka
> 
> Sorry for late!
> 
> On Tue, Nov 06, 2018 at 12:54:36PM +0100, Jiri Olsa wrote:
> > On Mon, Nov 05, 2018 at 08:53:42PM -0800, David Miller wrote:
> > > 
> > > Jiri,
> > > 
> > > Because you now run queued_events__queue() lockless with that condvar
> > > trick, it is possible for top->qe.in to be seen as one past the data[]
> > > array, this is because the rotate_queues() code goes:
> > > 
> > > 	if (++top->qe.in > &top->qe.data[1])
> > > 		top->qe.in = &top->qe.data[0];
> > > 
> > > So for a brief moment top->qe.in is out of range and thus
> > > perf_top__mmap_read_idx() can try to enqueue to top->qe.data[2]
> > > 
> > > We can just do:
> > > 
> > > 	if (top->qe.in == &top->qe.data[1])
> > > 		top->qe.in = &top->qe.data[0];
> > > 	else
> > > 		top->qe.in = &top->qe.data[1];
> > > 
> > > Or, make top->qe.in an index, and simply go:
> > > 
> > > 	top->qe.in ^= 1;
> > > 
> > > Either way will fix the bug.
> > 
> > ah right.. I had originaly full mutex around that,
> > then I switched it off in the last patch and did
> > not realize this implication.. nice ;-)
> 
> I like the rotate_queues() using cond-variable.  Have you tried to use
> the same for hists->lock in hists__get_rotate_entries_in() too?
> 
> Eventually it'd be nice to avoid locks when a single thread processes
> all the events.

yep, I thought we could use it there as well, but it could
be more tricky because we use hists->lock for that, which
is used on other places as well.. will check

thanks,
jirka
