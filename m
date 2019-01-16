Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F7FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B7320657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404846AbfAPPux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:50:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:59242 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfAPPux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:50:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 07:50:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,486,1539673200"; 
   d="scan'208";a="126520213"
Received: from gregmoor-mobl.amr.corp.intel.com ([10.254.11.196])
  by orsmga002.jf.intel.com with ESMTP; 16 Jan 2019 07:50:50 -0800
Message-ID: <cf937c481afc125e52cd44e0cfe8a54c89d3407f.camel@linux.intel.com>
Subject: Re: [PATCH v12 01/16] tracing: Use str_has_prefix() in
 synth_event_create()
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Joe Perches <joe@perches.com>, Tom Zanussi <zanussi@kernel.org>,
        rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 16 Jan 2019 09:50:49 -0600
In-Reply-To: <7c07519607d08c0afe448a03fb2010bce13cd77f.camel@perches.com>
References: <cover.1547589128.git.tom.zanussi@linux.intel.com>
         <aa6e33335e1ff99c7ac3d00fa5e27faaad04f981.1547589128.git.tom.zanussi@linux.intel.com>
         <7c07519607d08c0afe448a03fb2010bce13cd77f.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, 2019-01-15 at 20:59 -0800, Joe Perches wrote:
> On Tue, 2019-01-15 at 16:05 -0600, Tom Zanussi wrote:
> > Since we now have a str_has_prefix() that returns the length, we
> > can
> > use that instead of explicitly calculating it.
> 
> []
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> 
> []
> > @@ -1200,8 +1200,7 @@ static int synth_event_create(int argc, const
> > char **argv)
> >  
> >  	/* This interface accepts group name prefix */
> >  	if (strchr(name, '/')) {
> > -		len = sizeof(SYNTH_SYSTEM "/") - 1;
> > -		if (strncmp(name, SYNTH_SYSTEM "/", len))
> > +		if ((len = str_has_prefix(name, SYNTH_SYSTEM "/")) ==
> > 0)
> 
> Since this is a single test, and not multiple if/else if
> blocks, I believe this would read better on two lines
> 
> 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
> 		if (len == 0)
> 
> >  			return -EINVAL;
> >  		name += len;
> >  	}
> 

And I was so happy to have finally found a legitimate reason to put an
assignment inside an if statement, sigh.  OK, I'll change it.  ;-)

Thanks,

Tom

