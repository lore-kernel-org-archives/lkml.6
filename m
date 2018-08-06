Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D05C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EAC21A38
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EAC21A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbeHFQeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:34:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbeHFQeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E08D040241F3;
        Mon,  6 Aug 2018 14:24:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE9001C4E7;
        Mon,  6 Aug 2018 14:24:48 +0000 (UTC)
Date:   Mon, 6 Aug 2018 16:24:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>, kernel-team@lge.com
Subject: Re: [PATCH 14/20] perf annotate: Pass struct annotation_options to
 map_symbol__annotation_dump
Message-ID: <20180806142447.GB16446@krava>
References: <20180804130521.11408-1-jolsa@kernel.org>
 <20180804130521.11408-15-jolsa@kernel.org>
 <20180806134507.GA6983@danjae.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806134507.GA6983@danjae.aot.lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 14:24:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 06 Aug 2018 14:24:50 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:45:07PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Sat, Aug 04, 2018 at 03:05:15PM +0200, Jiri Olsa wrote:
> > Passing struct annotation_options to map_symbol__annotation_dump,
> > to carry on and pass the percent_type value.
> > 
> > Link: http://lkml.kernel.org/n/tip-5toohgdkgpk3vn6zebusr3bb@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> [SNIP]
> > @@ -2523,7 +2526,7 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
> >  
> >  static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
> >  				     bool first_line, bool current_entry, bool change_color, int width,
> > -				     void *obj,
> > +				     void *obj, unsigned int percent_type,
> >  				     int  (*obj__set_color)(void *obj, int color),
> >  				     void (*obj__set_percent_color)(void *obj, double percent, bool current),
> >  				     int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
> > @@ -2531,7 +2534,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >  				     void (*obj__write_graph)(void *obj, int graph))
> >  
> >  {
> > -	double percent_max = annotation_line__max_percent(al, notes);
> > +	double percent_max = annotation_line__max_percent(al, notes, percent_type);
> >  	int pcnt_width = annotation__pcnt_width(notes),
> >  	    cycles_width = annotation__cycles_width(notes);
> >  	bool show_title = false;
> > @@ -2552,8 +2555,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >  		for (i = 0; i < notes->nr_events; i++) {
> >  			double percent;
> >  
> > -			percent = annotation_data__percent(&al->data[i],
> > -							   PERCENT_HITS_LOCAL);
> > +			percent = annotation_data__percent(&al->data[i], percent_type);
> >  
> >  			obj__set_percent_color(obj, percent, current_entry);
> >  			if (notes->options->show_total_period) {
> > @@ -2680,13 +2682,15 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
> >  }
> >  
> >  void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> > -			    struct annotation_write_ops *ops)
> > +			    struct annotation_write_ops *wops,
> > +			    struct annotation_options *opts)
> >  {
> > -	__annotation_line__write(al, notes, ops->first_line, ops->current_entry,
> > -				 ops->change_color, ops->width, ops->obj,
> > -				 ops->set_color, ops->set_percent_color,
> > -				 ops->set_jumps_percent_color, ops->printf,
> > -				 ops->write_graph);
> > +	__annotation_line__write(al, notes, wops->first_line, wops->current_entry,
> > +				 wops->change_color, wops->width, wops->obj,
> > +				 opts->percent_type,
> > +				 wops->set_color, wops->set_percent_color,
> > +				 wops->set_jumps_percent_color, wops->printf,
> > +				 wops->write_graph);
> 
> This doesn't look good.  Why not just passing a pointer to wops
> instead of each fields separately?

yep, my thoughts exactly when I saw this ;-) we probably had some
other caller..  however I only wanted to add one more param ;-)

I'll check what we can do with this in v2

jirka
