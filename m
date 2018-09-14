Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F3ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDA620853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDA620853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeINRBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:01:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbeINRBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B599C30833C4;
        Fri, 14 Sep 2018 11:47:28 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6F2082010D07;
        Fri, 14 Sep 2018 11:47:26 +0000 (UTC)
Date:   Fri, 14 Sep 2018 13:47:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>, kernel-team@lge.com
Subject: Re: [RFCv2 00/48] perf tools: Add threads to record command
Message-ID: <20180914114725.GB17042@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <cba27d6a-a97b-cbb7-4be8-d1c14fb7dea5@linux.intel.com>
 <20180914022910.GA15146@sejong>
 <20180914082307.GF24224@krava>
 <20180914094022.GB96351@gmail.com>
 <20180914111528.GH24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914111528.GH24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 14 Sep 2018 11:47:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 01:15:28PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 14, 2018 at 11:40:22AM +0200, Ingo Molnar wrote:
> > In fact keeping the files separate has scalability advantages for 'perf report' and similar 
> > parsing tools: they could read all the streams in a per-CPU fashion already, from the very 
> > beginning.
> 
> Also writing to different files from different CPUs is good for record,
> less contention on the inode state (which include pagecache).

maybe I should explain a little bit more on this

we write to different (per-cpu) files during the record,
and at the end of the session, we take them and store
them inside perf.data

I don't mind having the directory instead, however we are
talking about small amount of code allowing us to keep the
data in single file.. we can always leave it to a special
command line option ;-)

jirka
