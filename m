Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985D2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607F7218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545231708;
	bh=aKeryUb/ze8FXfAyctBB+08ZW5kZcbuFRQY6MKI4RyU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=wv56RkvwJ9BKyhC9m/ydpzh2T5kN9RmJtIvZ0QAVuLQEpl7eSQBw8p+aGcgt2H54D
	 TAYXQsTvMaglGGU8bddW96xPRZNQmBSbVNhc8OI1MGMQMOVlppBLnmkzfRvnj5tDJM
	 2FU3ItGs9MHYYH+Q57bEDkhbQtGZBv7od8QPf2aQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeLSPBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeLSPBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:01:47 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E6CC218D2;
        Wed, 19 Dec 2018 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545231705;
        bh=aKeryUb/ze8FXfAyctBB+08ZW5kZcbuFRQY6MKI4RyU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eDebnAT/QnqmTi8wu2aNpVJi31lQ2QKbQyywpPCcd7tYvw1WTtTCfFOSyBPXaKuVs
         EsTcydJOfhf6Cm/UtydlRHdWwJslDy787hu9QIOuYdVuebSv8GIhRJWko3+EdtMcdR
         +iMj9qtNd7Fptg+NU1bdt/MGcuRun+U45/j9bjc8=
Message-ID: <1545231703.4491.2.camel@kernel.org>
Subject: Re: [PATCH 3/7] tracing: Use var_refs[] for hist trigger reference
 checking
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 19 Dec 2018 09:01:43 -0600
In-Reply-To: <20181219212224.968ee0ad61aada5a8a3f634f@kernel.org>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
         <20181219212224.968ee0ad61aada5a8a3f634f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, 2018-12-19 at 21:22 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Tue, 18 Dec 2018 14:33:22 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Since all the variable reference hist_fields are collected into
> > hist_data->var_refs[] array, there's no need to go through all the
> > fields looking for them, or in separate arrays like
> > synth_var_refs[],
> > which will be going away soon anyway.
> > 
> > This also allows us to get rid of some unnecessary code and
> > functions
> > currently used for the same purpose.
> 
> I just have a nitpick. 
> 
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 57 +++++-----------------------
> > ------------
> >  1 file changed, 7 insertions(+), 50 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> > index 25d06b3ae1f6..ee839c52bd3f 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -1299,45 +1299,11 @@ check_field_for_var_ref(struct hist_field
> > *hist_field,
> >  {
> >  	struct hist_field *found = NULL;
> >  
> > -	if (hist_field && hist_field->flags &
> > HIST_FIELD_FL_VAR_REF) {
> > -		if (hist_field->var.idx == var_idx &&
> > -		    hist_field->var.hist_data == var_data) {
> > -			found = hist_field;
> > -		}
> > -	}
> > -
> > -	return found;
> > -}
> > -
> > -static struct hist_field *
> > -check_field_for_var_refs(struct hist_trigger_data *hist_data,
> > -			 struct hist_field *hist_field,
> > -			 struct hist_trigger_data *var_data,
> > -			 unsigned int var_idx,
> > -			 unsigned int level)
> > -{
> > -	struct hist_field *found = NULL;
> > -	unsigned int i;
> > -
> > -	if (level > 3)
> > -		return found;
> > -
> > -	if (!hist_field)
> > -		return found;
> > +	WARN_ON(!(hist_field && hist_field->flags &
> > HIST_FIELD_FL_VAR_REF));
> >  
> > -	found = check_field_for_var_ref(hist_field, var_data,
> > var_idx);
> > -	if (found)
> > -		return found;
> > -
> > -	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++) {
> > -		struct hist_field *operand;
> > -
> > -		operand = hist_field->operands[i];
> > -		found = check_field_for_var_refs(hist_data,
> > operand, var_data,
> > -						 var_idx, level +
> > 1);
> > -		if (found)
> > -			return found;
> > -	}
> > +	if (hist_field && hist_field->var.idx == var_idx &&
> > +	    hist_field->var.hist_data == var_data)
> > +		found = hist_field;
> >  
> >  	return found;
> 
> It seems we don't need "found" var here. Just return hist_field or
> NULL.
> 

OK, will change these and resubmit shortly.

Thanks,

Tom

