Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3ACC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBC221A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zHe2AClU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBC221A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbeHFRb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeHFRb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:31:59 -0400
Received: from jouet.infradead.org (unknown [177.79.84.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C117A21A50;
        Mon,  6 Aug 2018 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533568943;
        bh=YZPxcQI9u5yKnJnQspVCg1JNuOBTszi4L+qLoTRBB9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zHe2AClU2bLkZn/Kzz0aqzkQf31Jti2EeeNBSbQohggfxVEFSrPT4x/sliQfenKxs
         9N/XGvpW2eNBx3VtFuUppFmZTuDUF64G1bfBOmzhYLKL59BQiqODl5ltWD6XITit1m
         cIw9jP7MLNxvDZesX3xm2MvaoD7DDqBVoAg6MIxI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 778C3140A1C; Mon,  6 Aug 2018 12:22:19 -0300 (-03)
Date:   Mon, 6 Aug 2018 12:22:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>, kernel-team@lge.com
Subject: Re: [PATCH 14/20] perf annotate: Pass struct annotation_options to
 map_symbol__annotation_dump
Message-ID: <20180806152219.GA14525@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-15-jolsa@kernel.org>
 <20180806134507.GA6983@danjae.aot.lge.com>
 <20180806142447.GB16446@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806142447.GB16446@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 06, 2018 at 04:24:47PM +0200, Jiri Olsa escreveu:
> On Mon, Aug 06, 2018 at 10:45:07PM +0900, Namhyung Kim wrote:
> > Hi Jiri,
> > 
> > On Sat, Aug 04, 2018 at 03:05:15PM +0200, Jiri Olsa wrote:
> > > Passing struct annotation_options to map_symbol__annotation_dump,
> > > to carry on and pass the percent_type value.
> > > 
> > > Link: http://lkml.kernel.org/n/tip-5toohgdkgpk3vn6zebusr3bb@git.kernel.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > 
> > [SNIP]
> > > @@ -2523,7 +2526,7 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
> > >  
> > >  static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
> > >  				     bool first_line, bool current_entry, bool change_color, int width,
> > > -				     void *obj,
> > > +				     void *obj, unsigned int percent_type,
> > >  				     int  (*obj__set_color)(void *obj, int color),
> > >  				     void (*obj__set_percent_color)(void *obj, double percent, bool current),
> > >  				     int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
> > > @@ -2531,7 +2534,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> > >  				     void (*obj__write_graph)(void *obj, int graph))
> > >  
> > >  {
> > > -	double percent_max = annotation_line__max_percent(al, notes);
> > > +	double percent_max = annotation_line__max_percent(al, notes, percent_type);
> > >  	int pcnt_width = annotation__pcnt_width(notes),
> > >  	    cycles_width = annotation__cycles_width(notes);
> > >  	bool show_title = false;
> > > @@ -2552,8 +2555,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> > >  		for (i = 0; i < notes->nr_events; i++) {
> > >  			double percent;
> > >  
> > > -			percent = annotation_data__percent(&al->data[i],
> > > -							   PERCENT_HITS_LOCAL);
> > > +			percent = annotation_data__percent(&al->data[i], percent_type);
> > >  
> > >  			obj__set_percent_color(obj, percent, current_entry);
> > >  			if (notes->options->show_total_period) {
> > > @@ -2680,13 +2682,15 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> > >  }
> > >  
> > >  void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> > > -			    struct annotation_write_ops *ops)
> > > +			    struct annotation_write_ops *wops,
> > > +			    struct annotation_options *opts)
> > >  {
> > > -	__annotation_line__write(al, notes, ops->first_line, ops->current_entry,
> > > -				 ops->change_color, ops->width, ops->obj,
> > > -				 ops->set_color, ops->set_percent_color,
> > > -				 ops->set_jumps_percent_color, ops->printf,
> > > -				 ops->write_graph);
> > > +	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
> > > +				 wops->change_color, wops->width, wops->obj,
> > > +				 opts->percent_type,
> > > +				 wops->set_color, wops->set_percent_color,
> > > +				 wops->set_jumps_percent_color, wops->printf,
> > > +				 wops->write_graph);
> > 
> > This doesn't look good.  Why not just passing a pointer to wops
> > instead of each fields separately?
> 
> yep, my thoughts exactly when I saw this ;-) we probably had some

But then, while this is a valid observation, it is not related to this
patchkit, that is just adding an extra config variable, percent_type, at
some point one can try to shorten that function signature, looking at
why it was done this way originally to see if there was any reason or if
its just something to improve by shortening the function signature.

Applying Jiri's patch,

> other caller..  however I only wanted to add one more param ;-)

Right
 
> I'll check what we can do with this in v2

I'm going thru v2 already, so far its an uncontrovertial, trivial, so
I think you better just wait a teeny bit for this to be applied and then
get on over with followup patches, ok?

- Arnaldo
