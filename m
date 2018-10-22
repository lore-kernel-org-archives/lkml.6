Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD845C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0382E20651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0382E20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeJVWNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbeJVWNN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:13:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2DC95F74A;
        Mon, 22 Oct 2018 13:54:32 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id B62BE608F3;
        Mon, 22 Oct 2018 13:54:31 +0000 (UTC)
Date:   Mon, 22 Oct 2018 15:54:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     acme@kernel.org, jolsa@kernel.org, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf script: flush output stream after events in
 verbose mode
Message-ID: <20181022135430.GA2945@krava>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
 <4444017.LnbBPIbh24@agathebauer>
 <20181022101618.GH2452@krava>
 <1755624.MxyOU8z0WO@agathebauer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1755624.MxyOU8z0WO@agathebauer>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 22 Oct 2018 13:54:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 12:38:57PM +0200, Milian Wolff wrote:

SNIP

> > > > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > > > index bd468b90801b..ca09b7d2adb7 100644
> > > > > --- a/tools/perf/builtin-script.c
> > > > > +++ b/tools/perf/builtin-script.c
> > > > > @@ -1737,6 +1737,9 @@ static void process_event(struct perf_script
> > > > > *script,
> > > > > 
> > > > >  	if (PRINT_FIELD(METRIC))
> > > > >  	
> > > > >  		perf_sample__fprint_metric(script, thread, evsel, 
> sample, fp);
> > > > > 
> > > > > +
> > > > > +	if (verbose)
> > > > > +		fflush(fp);
> > > > 
> > > > should we call fflush(NULL) to dump all the streams?
> > > > 
> > > > the verbose goes to stderr and fp seems to be stdout byt default
> > > 
> > > stderr isn't buffered, so we don't need to flush it. So personally, I
> > > don't
> > > see a need to dump all streams - fp should be enough? Can you maybe
> > > explain
> > > where it would be required to flush more buffers?
> > 
> > hum, did not know stderr wasn't buffer
> >
> > I think there's perf script feature to store the events data to
> > separate files per each event.. but I guess we don't need to
> > flush them.. we just need to have stdout and stderr in sync IIUC
> 
> Exactly, and that's achieved with this patch form what I see :) Or should we 
> maybe instead call 
> 
> setbuf(fp, NULL);
> 
> in verbose mode?

I think your solution is ok

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
