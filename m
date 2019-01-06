Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6605C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 15:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970D720665
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 15:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfAFP5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 10:57:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfAFP5w (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 10:57:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5242199D2C;
        Sun,  6 Jan 2019 15:57:52 +0000 (UTC)
Received: from krava (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id D41955D9CB;
        Sun,  6 Jan 2019 15:57:49 +0000 (UTC)
Date:   Sun, 6 Jan 2019 16:57:48 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Poll for monitored tasks being alive in fork
 mode
Message-ID: <20190106155748.GD31228@krava>
References: <1546568897-16123-1-git-send-email-yao.jin@linux.intel.com>
 <20190104125441.GF5481@krava>
 <ec011f77-e08e-4471-4479-0cb0281fa79b@linux.intel.com>
 <20190106132509.GA31228@krava>
 <3ccf2565-c271-1cba-e5dc-7c33302cf417@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ccf2565-c271-1cba-e5dc-7c33302cf417@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 06 Jan 2019 15:57:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 10:02:18PM +0800, Jin, Yao wrote:

SNIP

> > ---
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index acfd48db52dd..c322cb271180 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -583,6 +583,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >   		if (interval || timeout) {
> >   			while (!waitpid(child_pid, &status, WNOHANG)) {
> > +				if (!is_target_alive(&target, evsel_list->threads)) {
> > +					int pid = child_pid;
> > +
> > +					if (pid != -1)
> > +						kill(pid, SIGTERM);
> > +					break;
> > +				}
> > +
> >   				nanosleep(&ts, NULL);
> >   				if (timeout)
> >   					break;
> > 
> 
> Hi Jiri,
> 
> I think your patch is good. At least, we can avoid the case of kill(-1,
> SIGTERM).
> 
> BTW, you post this patch or I re-post it, both fine for me. :)

please post it

thanks,
jirka
