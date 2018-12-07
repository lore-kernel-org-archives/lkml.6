Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26049C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D678B20659
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544149202;
	bh=fvuvgh6qsiQiaM3aPqZPIsSGap6K6+PEn2229Ovp0rE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TKFufuXttckheLlraB4n8vOf5JinqzrJXcuswTq1I9SPbr8Fj7gs2DieCgaftndmB
	 bRGi9UEvEIXmDDfz+VpZkHonJOlTcSjbQzlTUVWyb5LnSaZ3PAGlNZQcw0YfX6VxmH
	 aQhcrEIHHRvcU1SIExWE9YGjWXjxsRLOJEMqeYHI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D678B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLGCUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGCUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:20:00 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2290020659;
        Fri,  7 Dec 2018 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544149200;
        bh=fvuvgh6qsiQiaM3aPqZPIsSGap6K6+PEn2229Ovp0rE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VUBg8pL3uNp2rocbCocVUa/OyRgoZZ9uEMTZoEi7N4pOKqoDkqkhoTxZWbSoccQ8r
         XT6KqRF70k1isdfLoNvBettdENR8GduxEXPGhEozXku6WbAEW6ha7pLXLCXL2KnAvV
         CuL/0BfkhK/8N0dTEb+IOUekMdH63IO16xbsN788=
Date:   Fri, 7 Dec 2018 11:19:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 01/12] tracing/uprobes: Add busy check when cleanup
 all uprobes
Message-Id: <20181207111957.b3889ecdca0e0b296c18787d@kernel.org>
In-Reply-To: <20181204124333.00f4c5ee@vmware.local.home>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
        <154140841557.17322.12653952888762532401.stgit@devbox>
        <20181204124333.00f4c5ee@vmware.local.home>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 12:43:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon,  5 Nov 2018 18:00:15 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add a busy check loop in cleanup_all_probes() before
> > trying to remove all events in uprobe_events as same as
> > kprobe_events does.
> > 
> > Without this change, writing null to uprobe_events will
> > try to remove events but if one of them is enabled, it
> > stopped there but some of events are already cleared.
> > 
> > With this change, writing null to uprobe_events make
> > sure all events are not enabled before removing events.
> > So, it clears all events, or return an error (-EBUSY)
> > with keeping all events.
> > 
> 
> Hmm, should this patch be marked as stable?

Hmm, OK, let this go to stable. Since anyway, this will cause
a wired result on uprobe_events from user point of view.

Thank you!

> 
> -- Steve
> 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_uprobe.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 31ea48eceda1..b708e4ff7ea7 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -587,12 +587,19 @@ static int cleanup_all_probes(void)
> >  	int ret = 0;
> >  
> >  	mutex_lock(&uprobe_lock);
> > +	/* Ensure no probe is in use. */
> > +	list_for_each_entry(tu, &uprobe_list, list)
> > +		if (trace_probe_is_enabled(&tu->tp)) {
> > +			ret = -EBUSY;
> > +			goto end;
> > +		}
> >  	while (!list_empty(&uprobe_list)) {
> >  		tu = list_entry(uprobe_list.next, struct trace_uprobe, list);
> >  		ret = unregister_trace_uprobe(tu);
> >  		if (ret)
> >  			break;
> >  	}
> > +end:
> >  	mutex_unlock(&uprobe_lock);
> >  	return ret;
> >  }
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
