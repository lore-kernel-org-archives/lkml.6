Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B2FECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C100208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C100208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeIXBeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:34:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeIXBeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:34:00 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2C9430832C1;
        Sun, 23 Sep 2018 19:35:25 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6A6EB94C83;
        Sun, 23 Sep 2018 19:35:23 +0000 (UTC)
Date:   Sun, 23 Sep 2018 21:35:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 38/48] perf record: Read record thread's mmaps
Message-ID: <20180923193522.GF30923@krava>
References: <20180913125450.21342-1-jolsa@kernel.org>
 <20180913125450.21342-39-jolsa@kernel.org>
 <20180917112837.GC18395@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917112837.GC18395@sejong>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 23 Sep 2018 19:35:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 08:28:37PM +0900, Namhyung Kim wrote:

SNIP

> > -
> > -		if (track_map && track_map->base) {
> > -			if (perf_mmap__push(track_map, rec, record__pushfn) != 0) {
> > -				rc = -1;
> > -				goto out;
> > -			}
> > -		}
> >  	}
> >  
> >  	/*
> >  	 * Mark the round finished in case we wrote
> >  	 * at least one event.
> >  	 */
> > -	if (bytes_written != rec->bytes_written)
> > -		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
> > +	if (bytes_written != rec->bytes_written) {
> > +		/*
> > +		 * All maps of the threads point to a single file,
> > +		 * so we can just pick first one.
> > +		 */
> > +		rc = record__write(rec, thread->mmap[0], &finished_round_event,
> 
> Shouldn't it be maps[0] ?

yep, overwrite wouldn't work..

thanks,
jirka
