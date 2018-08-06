Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36FCC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816E021A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816E021A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbeHFRjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:39:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbeHFRjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:39:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C0B07DAC6;
        Mon,  6 Aug 2018 15:29:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2A4932166BA0;
        Mon,  6 Aug 2018 15:29:32 +0000 (UTC)
Date:   Mon, 6 Aug 2018 17:29:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>, kernel-team@lge.com
Subject: Re: [PATCH 14/20] perf annotate: Pass struct annotation_options to
 map_symbol__annotation_dump
Message-ID: <20180806152931.GE16446@krava>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-15-jolsa@kernel.org>
 <20180806134507.GA6983@danjae.aot.lge.com>
 <20180806142447.GB16446@krava>
 <20180806152219.GA14525@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806152219.GA14525@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 15:29:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 06 Aug 2018 15:29:34 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 12:22:19PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > > > -				 ops->set_jumps_percent_color, ops->printf,
> > > > -				 ops->write_graph);
> > > > +	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
> > > > +				 wops->change_color, wops->width, wops->obj,
> > > > +				 opts->percent_type,
> > > > +				 wops->set_color, wops->set_percent_color,
> > > > +				 wops->set_jumps_percent_color, wops->printf,
> > > > +				 wops->write_graph);
> > > 
> > > This doesn't look good.  Why not just passing a pointer to wops
> > > instead of each fields separately?
> > 
> > yep, my thoughts exactly when I saw this ;-) we probably had some
> 
> But then, while this is a valid observation, it is not related to this
> patchkit, that is just adding an extra config variable, percent_type, at
> some point one can try to shorten that function signature, looking at
> why it was done this way originally to see if there was any reason or if
> its just something to improve by shortening the function signature.
> 
> Applying Jiri's patch,
> 
> > other caller..  however I only wanted to add one more param ;-)
> 
> Right
>  
> > I'll check what we can do with this in v2
> 
> I'm going thru v2 already, so far its an uncontrovertial, trivial, so
> I think you better just wait a teeny bit for this to be applied and then
> get on over with followup patches, ok?

sure, np

jirka
