Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE65C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC2621841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545246542;
	bh=FlBUy2HEKaQ16AcHoqQhFlJEKipg9lH6Y23r3HI9CRE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=DObBrJ9wh8nqsI7mINzRFt3GO3uqCYZpCY1TY+qVyfCv0k64o6SpEnFet7o35LmwE
	 rX50MwCxKeq9DIm8qrTiK8X1nE4Da1JV52f1i8UvtHrt+jrnRCX3E8tu+gxA5OlaDy
	 SNBG7cWDqwBjvX3R7Of/W7F63pyob7C6G2E0QCU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeLSTJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:09:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbeLSTJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:09:00 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FAD22080D;
        Wed, 19 Dec 2018 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545246539;
        bh=FlBUy2HEKaQ16AcHoqQhFlJEKipg9lH6Y23r3HI9CRE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SlqwR5jUTqCNPbbhQFSA0PstGwrg2Dq32nWLVKhfzWXHaehIu4KuYC0osoxFPrQnJ
         wsmb2x/3ABCDcU+UR1Ck5ZUQUxw9isMpu0yEuYjtIZd8V3NmnG9EQFtsOJKpKy9moK
         lnBDzexufG83BMhzi4XhSd7OKQH8ctl4k7lIZA8c=
Message-ID: <1545246538.4239.6.camel@kernel.org>
Subject: Re: [PATCH 3/7] tracing: Use var_refs[] for hist trigger reference
 checking
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, tglx@linutronix.de,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 19 Dec 2018 13:08:58 -0600
In-Reply-To: <20181219103647.18c61a6a@gandalf.local.home>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219212224.968ee0ad61aada5a8a3f634f@kernel.org>
         <1545231703.4491.2.camel@kernel.org>
         <20181219103647.18c61a6a@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2018-12-19 at 10:36 -0500, Steven Rostedt wrote:
> On Wed, 19 Dec 2018 09:01:43 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > > > +	if (hist_field && hist_field->var.idx == var_idx &&
> > > > +	    hist_field->var.hist_data == var_data)
> > > > +		found = hist_field;
> > > >  
> > > >  	return found;  
> > > 
> > > It seems we don't need "found" var here. Just return hist_field
> > > or
> > > NULL.
> > >   
> > 
> > OK, will change these and resubmit shortly.
> 
> Tom,
> 
> If this is the only patch in the series that needs updating, can you
> just reply to this patch with the v2 of 3/7? That is have a subject
> of:
> 
> [PATCH v2 3/7] tracing: Use var_refs[] for hist trigger reference
> checking
> 
> and reply to the [PATCH 3/7]
> 
> 
> This isn't the normal way of updates, but I want to start taking this
> patches in ASAP, and I figured this may be the easiest for both of
> us.
> 
> It's fine to send a v2 of the entire patch series (which other
> maintainers require), so I'll leave it up to you.
> 
> If there's any other patch that needs changing, then a full v2 series
> is required. But if this is the only change and you want to send just
> this patch, then I'll take that as well.
> 

Sorry for the delay - had an emergency appointment for the dog at the
vet this morning..

Anyway, yeah, I'll reply with the patch - it's the only one that needs
updating in this series.

Thanks,

Tom

> -- Steve
