Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AFCC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B120920651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm0KLMMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B120920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeJXDwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeJXDwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:52:38 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA13120651;
        Tue, 23 Oct 2018 19:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540322872;
        bh=CO5Wozb6bKk7bN3jfhKDCP2in90zXgHtCEmYScyJPzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qm0KLMMqV/tZhDicztLSpe9DrTs5ts12Mx/q7+q0odocxw1jdMkFnxGGOJDK38bnb
         AbJnfwFdGPUGERwKQ0h7uhJbNSfTF9fvpVMcLoaeZ7iqg1qhLxdSijuimcRvWvShwL
         ZBzu+TYWnUhbu4+rbSezFBaCkg5OP8w8mmOSSuCA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 268A1142C5E; Tue, 23 Oct 2018 16:27:50 -0300 (-03)
Date:   Tue, 23 Oct 2018 16:27:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     jolsa@redhat.com, dzickus@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: perf overlapping maps...
Message-ID: <20181023192750.GC6114@kernel.org>
References: <20181023063452.GB20075@krava>
 <20181023.105405.364015687995752826.davem@davemloft.net>
 <20181023180503.GA6114@kernel.org>
 <20181023.111503.1978409398989251135.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023.111503.1978409398989251135.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 23, 2018 at 11:15:03AM -0700, David Miller escreveu:
> From: Arnaldo Carvalho de Melo <acme@kernel.org>
> Date: Tue, 23 Oct 2018 15:05:03 -0300
> > IIRC this was first done for 'perf record', where we have to stash those
> > events in the perf.data file, to then, later, 'perf report' to process
> > those, so when working on 'perf top', it just reuses that machinery.

> > Sure, with some love and care 'perf top' could do better and update all
> > the data structures directly :-)
 
> Thanks for the history, it is useful information :)
 
> > Anyway, have you guys considered tweaking using event->header.misc |=
> > PERF_RECORD_MISC_USER? The kernel leaves that as zero for the
> > PERF_RECORD_FORK it emits:
 
> I really would like to steer the approach away from using UAPI
> perf_event fields in an internal way.
 
> I am really very sorry for suggesting such a scheme myself in the
> first place.  It really was a bad idea upon much consideration.
 
> The synthetic fork is not really a fork, it's more like a "create".
 
> And this fundamental semantic difference is why we have all of these
> issues wrt. handling COMM and parent map inheritance.
 
> There is also a bunch of non-trivial code to deal with whether we
> synthetically create the child or the parent first, wrt. finding
> thread leaders and parent threads.

> What I'm trying to say is that there is a clean design based solution
> hiding somewhere in here and I'd like to find it :-)

So, this is all because we're trying to recreate things that happened in
the past, for threads we're interested in but couldn't catch the
PERF_RECORD_{FORK,COMM,MMAP} when they originally take place.

Ideally we would recreate them in the exact same order and with the
exact same details, which was kinda what was intended, but as you're
seeing is failing at that in various cases.

Also if we keep using this abstraction, i.e. synthesize in userspace
what the kernel does, generating PERF_RECORD__{FORK,COMM,MMAP}, then
older tools will continue working with perf.data files generated by
a new, fixed up 'perf record'.

And nowadays there are other tools that read perf.data files:

  http://code.qt.io/cgit/qt-creator/perfparser.git/
  https://doc.qt.io/qtcreator/creator-cpu-usage-analyzer.html

Or do you think we should introduce new record types that deal better
with pre-existing threads/maps?

- Arnaldo
