Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A457CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719C920866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719C920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393472AbeKVUIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:08:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387669AbeKVUIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:08:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA07746233;
        Thu, 22 Nov 2018 09:30:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id B3CBC282CE;
        Thu, 22 Nov 2018 09:30:07 +0000 (UTC)
Date:   Thu, 22 Nov 2018 10:30:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCHv2 01/10] tools lib traceevent: Use LDFLAGS in the build
 commands
Message-ID: <20181122093006.GD15953@krava>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <20181016150614.21260-2-jolsa@kernel.org>
 <20181016112136.3a72a452@gandalf.local.home>
 <20181016154526.GC6631@krava>
 <20181017102341.53412998@gandalf.local.home>
 <20181116130158.GA30583@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116130158.GA30583@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 22 Nov 2018 09:30:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 02:01:58PM +0100, Jiri Olsa wrote:
> On Wed, Oct 17, 2018 at 10:23:41AM -0400, Steven Rostedt wrote:
> > On Tue, 16 Oct 2018 17:45:26 +0200
> > Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > > On Tue, Oct 16, 2018 at 11:21:36AM -0400, Steven Rostedt wrote:
> > > > On Tue, 16 Oct 2018 17:06:06 +0200
> > > > Jiri Olsa <jolsa@kernel.org> wrote:
> > > >   
> > > > > So user could specify outside LDFLAGS values.
> > > > > 
> > > > > Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  tools/lib/traceevent/Makefile | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
> > > > > index 0b4e833088a4..e535073c94ce 100644
> > > > > --- a/tools/lib/traceevent/Makefile
> > > > > +++ b/tools/lib/traceevent/Makefile
> > > > > @@ -174,7 +174,7 @@ $(TE_IN): force
> > > > >  	$(Q)$(MAKE) $(build)=libtraceevent
> > > > >  
> > > > >  $(OUTPUT)libtraceevent.so.$(EVENT_PARSE_VERSION): $(TE_IN)
> > > > > -	$(QUIET_LINK)$(CC) --shared $^ -Wl,-soname,libtraceevent.so.$(EP_VERSION) -o $@
> > > > > +	$(QUIET_LINK)$(CC) --shared $(LDFLAGS) $^ -Wl,-soname,libtraceevent.so.$(EP_VERSION) -o $@
> > > > >  	@ln -sf $(@F) $(OUTPUT)libtraceevent.so
> > > > >  	@ln -sf $(@F) $(OUTPUT)libtraceevent.so.$(EP_VERSION)
> > > > >  
> > > > > @@ -193,7 +193,7 @@ $(PLUGINS_IN): force
> > > > >  	$(Q)$(MAKE) $(build)=$(plugin_obj)
> > > > >  
> > > > >  $(OUTPUT)%.so: $(OUTPUT)%-in.o
> > > > > -	$(QUIET_LINK)$(CC) $(CFLAGS) -shared -nostartfiles -o $@ $^
> > > > > +	$(QUIET_LINK)$(CC) -shared $(LDFLAGS) -nostartfiles -o $@ $^  
> > > > 
> > > > 
> > > > I'm guessing that the CFLAGS are not needed here, but shouldn't that
> > > > also be mentioned in the change log?  
> > > 
> > > yep, sry.. v2 attached
> > > 
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Arnaldo,
> could you pull in this one?

ping, thanks

jirka
