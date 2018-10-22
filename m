Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C9DC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AE720663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CquypuoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AE720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeJWBpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbeJWBpX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:45:23 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E99205F4;
        Mon, 22 Oct 2018 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540229159;
        bh=00TLTxYsiS6SF2sposIFtTi7S4BybskN4ob96wGHzHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CquypuoYtoLWgyTw6PpR0XB3zgDuiqg+3x/lxBkCf6D8rVwMgUN5WVRs2vMyWZXSd
         XCw6UIzw5uAg3EjP7so90VER5eQ5i5PqMPhiPYDxR+2ouIUvF3O8WDBDTyMbx+E0aT
         Mj9GjbWlW3mZ06PjvpimRu0SMb73Qka9S9bkdE+w=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id BA828142C5E; Mon, 22 Oct 2018 14:25:56 -0300 (-03)
Date:   Mon, 22 Oct 2018 14:25:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf script: flush output stream after events in
 verbose mode
Message-ID: <20181022172556.GM3849@kernel.org>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
 <4444017.LnbBPIbh24@agathebauer>
 <20181022101618.GH2452@krava>
 <1755624.MxyOU8z0WO@agathebauer>
 <20181022135430.GA2945@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022135430.GA2945@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 22, 2018 at 03:54:30PM +0200, Jiri Olsa escreveu:
> On Mon, Oct 22, 2018 at 12:38:57PM +0200, Milian Wolff wrote:
> 
> SNIP
> 
> > > > > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > > > > index bd468b90801b..ca09b7d2adb7 100644
> > > > > > --- a/tools/perf/builtin-script.c
> > > > > > +++ b/tools/perf/builtin-script.c
> > > > > > @@ -1737,6 +1737,9 @@ static void process_event(struct perf_script
> > > > > > *script,
> > > > > > 
> > > > > >  	if (PRINT_FIELD(METRIC))
> > > > > >  	
> > > > > >  		perf_sample__fprint_metric(script, thread, evsel, 
> > sample, fp);
> > > > > > 
> > > > > > +
> > > > > > +	if (verbose)
> > > > > > +		fflush(fp);
> > > > > 
> > > > > should we call fflush(NULL) to dump all the streams?
> > > > > 
> > > > > the verbose goes to stderr and fp seems to be stdout byt default
> > > > 
> > > > stderr isn't buffered, so we don't need to flush it. So personally, I
> > > > don't
> > > > see a need to dump all streams - fp should be enough? Can you maybe
> > > > explain
> > > > where it would be required to flush more buffers?
> > > 
> > > hum, did not know stderr wasn't buffer
> > >
> > > I think there's perf script feature to store the events data to
> > > separate files per each event.. but I guess we don't need to
> > > flush them.. we just need to have stdout and stderr in sync IIUC
> > 
> > Exactly, and that's achieved with this patch form what I see :) Or should we 
> > maybe instead call 
> > 
> > setbuf(fp, NULL);
> > 
> > in verbose mode?
> 
> I think your solution is ok
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
