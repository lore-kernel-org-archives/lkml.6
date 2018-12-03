Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4101F20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/3eolcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4101F20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLCWWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:22:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbeLCWWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:22:06 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20303206B7;
        Mon,  3 Dec 2018 22:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543875725;
        bh=i5kIsTco3f7d8sJ5mtxdBuTZ2QsDbdd07RTHJeaE+aA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A/3eolcVuLrT1dMTTgA0ATXfjOaXpD7h6qqM6H1YP3kNRyixitZQbWSg3P5TioKjq
         506l1Js7WJpOSVstZq6HBvHwMG0QyAixMFlITQsH7HnM8JQdBglz6SG7/BbjlcQp39
         Ec0a88lg4jyCmtdZrrm2C6nQK1EVnOLuftRYoU+o=
Message-ID: <1543875722.2018.22.camel@kernel.org>
Subject: Re: [PATCH v7 05/16] tracing: Generalize hist trigger onmax and
 save action
From:   Tom Zanussi <zanussi@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Date:   Mon, 03 Dec 2018 16:22:02 -0600
In-Reply-To: <20181123025000.GC25952@sejong>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
         <9baa2b4a9b708791b39f176e3b63c207163d8c3b.1542221863.git.tom.zanussi@linux.intel.com>
         <20181123025000.GC25952@sejong>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Fri, 2018-11-23 at 11:50 +0900, Namhyung Kim wrote:
> Hi Tom,
> 
> On Wed, Nov 14, 2018 at 02:18:02PM -0600, Tom Zanussi wrote:
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 

[snip]

> > 
 enum handler_id {
> >  	HANDLER_ONMATCH = 1,
> >  	HANDLER_ONMAX,
> > @@ -349,14 +358,18 @@ struct action_data {
> >  
> >  		struct {
> >  			char			*var_str;
> > -			unsigned int		max_var_ref_id
> > x;
> > -			struct hist_field	*max_var;
> > -			struct hist_field	*var;
> > -		} onmax;
> > +			struct hist_field	*var_ref;
> > +			unsigned int		var_ref_idx;
> 
> I have a question.  It's confusing for me there are many indexes for
> a
> variable (ref).  The hist_field already has var.idx, var_idx and
> var_ref_idx in it.  But you also added an external var_ref_idx along
> with the var_ref.  Also I see another var_ref_idx in the action data.
> Is all that really needed?  Could you please add some comment then?
> 

Below is a patch with some comments I'll merge into the next version
that I hope will help make things more clear.  Basically, the
hist_field.var_idx isn't used so I've removed it and therefore that
source of confusion, while var.idx is the variable's unique 'handle' in
the tracing_map, used when getting and setting the variable.  And then
there are the several versions of var_ref_idx used for different
purposes depending on the context, but all of them are indices into the
array of variable values collected when a trigger is hit.  For example,
the var_ref_idx defined inside track_data is the index that points to
the tracked var value, which the action can use directly, and the
var_ref_idx alongside the synth fields in action_data is the index of
the first param used when generating a synthetic event, and so on.

Tom 

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 818944391d97..5310ef73f023 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -39,6 +39,16 @@ enum field_op_id {
 	FIELD_OP_UNARY_MINUS,
 };
 
+/*
+ * A hist_var (histogram variable) contains variable information for
+ * hist_fields having the HIST_FIELD_FL_VAR or HIST_FIELD_FL_VAR_REF
+ * flag set.  A hist_var has a variable name e.g. ts0, and is
+ * associated with a given histogram trigger, as specified by
+ * hist_data.  The hist_var idx is the unique index assigned to the
+ * variable by the hist trigger's tracing_map.  The idx is what is
+ * used to set a variable's value and, by a variable reference, to
+ * retrieve it.
+ */
 struct hist_var {
 	char				*name;
 	struct hist_trigger_data	*hist_data;
@@ -60,7 +70,15 @@ struct hist_field {
 	char				*system;
 	char				*event_name;
 	char				*name;
-	unsigned int			var_idx;
+
+	/*
+	 * When a histogram trigger is hit, if it has any references
+	 * to variables, the values of those variables are collected
+	 * into a var_ref_vals array by resolve_var_refs().  The
+	 * current value of each variable is read from the tracing_map
+	 * using the hist field's hist_var.idx and entered into the
+	 * var_ref_idx entry i.e. var_ref_vals[var_ref_idx].
+	 */
 	unsigned int			var_ref_idx;
 	bool                            read_once;
 };
@@ -350,6 +368,14 @@ struct action_data {
 	unsigned int		n_params;
 	char			*params[SYNTH_FIELDS_MAX];
 
+	/*
+	 * When a histogram trigger is hit, the values of any
+	 * references to variables, including variables being passed
+	 * as parameters to synthetic events, are collected into a
+	 * var_ref_vals array.  This var_ref_idx is the index of the
+	 * first param in the array to be passed to the synthetic
+	 * event invocation.
+	 */
 	unsigned int		var_ref_idx;
 	struct synth_event	*synth_event;
 	bool			use_trace_keyword;
@@ -362,10 +388,29 @@ struct action_data {
 		} match_data;
 
 		struct {
+			/*
+			 * var_str and var_ref refer to the variable
+			 * being tracked e.g onmax($var).
+			 */
 			char			*var_str;
 			struct hist_field	*var_ref;
+
+			/*
+			 * When a histogram trigger is hit, the values
+			 * of any references to variables, including
+			 * variables being tracked e.g. onmax($var),
+			 * are collected into a var_ref_vals array.
+			 * This var_ref_idx is the index of the
+			 * tracked var value in var_ref_vals, which
+			 * the action can make use of directly.
+			 */
 			unsigned int		var_ref_idx;
 
+			/*
+			 * This track_var contains the 'invisible'
+			 * tracking variable created to keep the
+			 * current e.g. max value.
+			 */
 			struct hist_field	*track_var;
 
 			check_track_val_fn_t	check_val;
