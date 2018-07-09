Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4035C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853E320854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853E320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeGIJmC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:42:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932385AbeGIJmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:42:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E6B04067F19;
        Mon,  9 Jul 2018 09:42:01 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E27CA51E0;
        Mon,  9 Jul 2018 09:41:59 +0000 (UTC)
Date:   Mon, 9 Jul 2018 11:41:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Janne Huttunen <janne.huttunen@nokia.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf script python: Fix dict reference counting
Message-ID: <20180709094159.GA7615@krava>
References: <1530860024-12653-1-git-send-email-janne.huttunen@nokia.com>
 <20180708111707.GA7092@krava>
 <1531128333.2711.19.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531128333.2711.19.camel@nokia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 09 Jul 2018 09:42:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 09 Jul 2018 09:42:01 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 12:25:33PM +0300, Janne Huttunen wrote:
> On Sun, 2018-07-08 at 13:17 +0200, Jiri Olsa wrote:
> > On Fri, Jul 06, 2018 at 09:53:44AM +0300, Janne Huttunen wrote:
> > > 
> > > The dictionaries are attached to the parameter tuple that steals the
> > > references. The code should not decrement the reference counters
> > > explicitly. Otherwise the objects might be released while they are
> > > still in use which may cause perf crashes, assertions or just plain
> > > weird behavior like unexpected data changes in stored objects.
> > > 
> > > Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
> > > ---
> > >  tools/perf/util/scripting-engines/trace-event-python.c | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> > > index 46e9e19..60fce44 100644
> > > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > > @@ -908,14 +908,11 @@ static void python_process_tracepoint(struct perf_sample *sample,
> > >  	if (_PyTuple_Resize(&t, n) == -1)
> > >  		Py_FatalError("error resizing Python tuple");
> > >  
> > > -	if (!dict) {
> > > +	if (!dict)
> > >  		call_object(handler, t, handler_name);
> > > -	} else {
> > > +	else
> > >  		call_object(handler, t, default_handler_name);
> > > -		Py_DECREF(dict);
> > > -	}
> > >  
> > > -	Py_XDECREF(all_entries_dict);
> > >  	Py_DECREF(t);
> > >  }
> > >  
> > > @@ -1235,7 +1232,6 @@ static void python_process_general_event(struct perf_sample *sample,
> > >  
> > >  	call_object(handler, t, handler_name);
> > >  
> > > -	Py_DECREF(dict);
> > >  	Py_DECREF(t);
> >
> > so the dict is released when the tuple is released?
> 
> To the best of my knowledge, yes.
> 
> As far as I can see, there is only a single reference to each dict
> and according to the Python documentation PyTuple_SetItem() "steals"
> the reference passed to it. If so, afterwards the tuple owns the
> only reference to the dict(s) and should take care of releasing
> them when appropriate.
> 
> I even built libpython with reference debugging enabled and when I
> run perf without the fix I get this:
> 
> Fatal Python error: Objects/tupleobject.c:238 object at 0x7f10f2041b40 has negative ref count -1
> Aborted (core dumped)
> 
> With the fix I get no errors.
> 

ok, please include and mention that crash in the changelog

thanks,
jirka
