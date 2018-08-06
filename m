Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D69C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA56D215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA56D215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbeHFRSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:18:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727541AbeHFRSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:18:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D70F24015A45;
        Mon,  6 Aug 2018 15:08:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id B32C92026D74;
        Mon,  6 Aug 2018 15:08:36 +0000 (UTC)
Date:   Mon, 6 Aug 2018 17:08:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/2] perf/hw_breakpoint: Remove superfluous bp->attr.disabled
 = 0 new attr has disabled set
Message-ID: <20180806150836.GD16446@krava>
References: <20180806101241.6444-1-jolsa@kernel.org>
 <20180806101241.6444-3-jolsa@kernel.org>
 <20180806124839.GC7840@redhat.com>
 <20180806132353.GA7463@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806132353.GA7463@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 06 Aug 2018 15:08:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 06 Aug 2018 15:08:38 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 03:23:53PM +0200, Jiri Olsa wrote:
> On Mon, Aug 06, 2018 at 02:48:40PM +0200, Oleg Nesterov wrote:
> > On 08/06, Jiri Olsa wrote:
> > >
> > > We need to change the breakpoint even if the attr with
> > > new fields has disabled set to true.
> > 
> > Agreed... The patch looks fine to me, but I have a question
> > 
> > >  int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *attr)
> > >  {
> > > +	int err;
> > > +
> > >  	/*
> > >  	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
> > >  	 * will not be possible to raise IPIs that invoke __perf_event_disable.
> > > @@ -520,11 +522,11 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
> > >  	else
> > >  		perf_event_disable(bp);
> > >  
> > > -	if (!attr->disabled) {
> > > -		int err = modify_user_hw_breakpoint_check(bp, attr, false);
> > > +	err = modify_user_hw_breakpoint_check(bp, attr, false);
> > > +	if (err)
> > > +		return err;
> > >  
> > > -		if (err)
> > > -			return err;
> > > +	if (!attr->disabled) {
> > >  		perf_event_enable(bp);
> > >  		bp->attr.disabled = 0;
> > 
> > Afaics you do not need to clear attr.disabled, modify_user_hw_breakpoint_check()
> > updates it if err = 0. So I think
> > 
> > 	if (!bp->attr.disabled)
> > 		perf_event_enable(bp);
> > 
> > will look a bit better.
> > 
> > 
> > But, with or without this fix, shouldn't we set .disabled = 1 if modify_() fails?
> > IIUC this doesn't matter, bp->attr.disabled is not really used anyway, but looks a
> > bit confusing.
> > 
> 
> yea, I was looking on that, but as u said it makes no difference
> and I wanted to keep the patch as simple as possible ;-)
> 
> I'll send something on top of this patch

like this ;-)

jirka


---
Once the breakpoint was succesfully modified, the attr->disabled
value is in bp->attr.disabled. So there's no reason to set it
again, removing that.

Link: http://lkml.kernel.org/n/tip-v5oaellzsmyszv3rfucuxkp0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/hw_breakpoint.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index fb229d9c7f3c..3e560d7609fd 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -526,10 +526,9 @@ int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_attr *att
 	if (err)
 		return err;
 
-	if (!attr->disabled) {
+	if (!attr->disabled)
 		perf_event_enable(bp);
-		bp->attr.disabled = 0;
-	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
-- 
2.17.1

