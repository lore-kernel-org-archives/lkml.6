Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB2FC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C9720651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C9720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeJVW0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbeJVW0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:26:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AED6A307D84F;
        Mon, 22 Oct 2018 14:07:39 +0000 (UTC)
Received: from redhat.com (dhcp-17-21.bos.redhat.com [10.18.17.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2C8AB1057048;
        Mon, 22 Oct 2018 14:07:39 +0000 (UTC)
Date:   Mon, 22 Oct 2018 10:07:38 -0400
From:   Don Zickus <dzickus@redhat.com>
To:     David Miller <davem@davemloft.net>, jolsa@redhat.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: perf overlapping maps...
Message-ID: <20181022140738.jvutwmstgm2f65et@redhat.com>
References: <20181019.210549.1285253275146712779.davem@davemloft.net>
 <20181019.214401.2045294780943844999.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019.214401.2045294780943844999.davem@davemloft.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 22 Oct 2018 14:07:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Jiri)

On Fri, Oct 19, 2018 at 09:44:01PM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Fri, 19 Oct 2018 21:05:49 -0700 (PDT)
> 
> > One solution I've come up with is:
> > 
> > 1) When synthesizing a fork event, set PERF_RECORD_MISC_COMM_EXEC in
> >    header->misc.
> > 
> > 2) Use this to elide the map groups clone in
> >    thread__clone_map_groups().
> 
> Looking into code history, I notice:
> 
> commit 363b785f3805a2632eb09a8b430842461c21a640
> Author: Don Zickus <dzickus@redhat.com>
> Date:   Fri Mar 14 10:43:44 2014 -0400
> 
>     perf tools: Speed up thread map generation
> 
> and the subsequent:
> 
> commit 4aa5f4f7bb8bc41cba15bcd0d80c4fb085027d6b
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri Feb 27 19:52:10 2015 -0300
> 
>     perf tools: Fix FORK after COMM when synthesizing records for pre-existing threads
> 
> If Don wanted to have the map cloning to happen for processes without
> CLONE_VM, I'm not sure that's right.
> 
> For real threads, we just take a reference to the map group from
> the parent.
> 
> Don, a quick summary.  If we synthesize a fork event, let's say for an
> emacs process.  perf will clone the map groups of the parent bash
> shell which invoked emacs.  Via:
> 
> thread__fork(thread, parent, timestamp)
> {
>  ...
>  thread__clone_map_groups(thread, parent)
>  {
>    ...
>    map_groups__clone(thread, parent->mg)
> 
> Which is completely bogus.  It brings all of the bash process maps
> into the emacs thread map group.  Then we process the emacs mmap2
> events, which overlap the bash process maps already cloned into the
> emacs map group.  And this make all kinds of erroneous things happen.
> 
> I'm suggesting to elide the map groups clone in this situation where
> we are synthesizing the fork.

Hi David,

Honestly, I remember very little of this change other than we ran specjbb
which created thousands of threads and we wanted a better way to handle that
situation (waiting 15 minutes seemed wrong).

Jiri Olsa is probably more knowledgable about this then I am these days and
can work with Joe to re-do the test to verify any suggested changes does not
break our intended use case.

Thinking about it more, I am wondering if we did this because we ran the
test and it takes about 20 minutes to 'warm up' then we attached perf to the
test.  This implies we had to handle the situation where 10K threads already
existed hence our optimization.  But I can be wrong.

Your suggestion is probably right and I am sure we can reproduce the
scenario to verify things didn't regress.

Cheers,
Don
