Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76208C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2657F20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2657F20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeGYRVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbeGYRVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:21:53 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB3D20843;
        Wed, 25 Jul 2018 16:09:32 +0000 (UTC)
Date:   Wed, 25 Jul 2018 12:09:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] [BUGFIX] tracing: Fix double free of
 event_trigger_data
Message-ID: <20180725120930.10218ffa@gandalf.local.home>
In-Reply-To: <b952513e-90d9-bf8f-bdbc-abc22d843218@linux.intel.com>
References: <153149923649.11274.14970833360963898112.stgit@devbox>
        <153149926702.11274.12489440326560729788.stgit@devbox>
        <20180723221006.60cc7aa9@vmware.local.home>
        <20180725000909.6c8b2f3881ee75c4f6bd466b@kernel.org>
        <20180724164959.3cbc1422@gandalf.local.home>
        <20180724173008.454cdf10@gandalf.local.home>
        <b952513e-90d9-bf8f-bdbc-abc22d843218@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 11:01:22 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> > First we have this:
> > 
> > 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> > 	/*
> > 	 * The above returns on success the # of functions enabled,
> > 	 * but if it didn't find any functions it returns zero.
> > 	 * Consider no functions a failure too.
> > 	 */
> > 
> > Which looks to be total BS.  
> 
> Yes, it is BS in the case of event triggers.  This was taken from the 
> ftrace function trigger code, where it does make sense.  I think I left 
> it in thinking the code would at some point later converge.

OK, that makes a little more sense.

> 
> > 
> > As we have this:
> > 
> > /**
> >   * register_trigger - Generic event_command @reg implementation
> >   * @glob: The raw string used to register the trigger
> >   * @ops: The trigger ops associated with the trigger
> >   * @data: Trigger-specific data to associate with the trigger
> >   * @file: The trace_event_file associated with the event
> >   *
> >   * Common implementation for event trigger registration.
> >   *
> >   * Usually used directly as the @reg method in event command
> >   * implementations.
> >   *
> >   * Return: 0 on success, errno otherwise  
> 
> And this is how it should work.
> 
> >   */
> > static int register_trigger(char *glob, struct event_trigger_ops *ops,
> > 			    struct event_trigger_data *data,
> > 			    struct trace_event_file *file)
> > {
> > 	struct event_trigger_data *test;
> > 	int ret = 0;
> > 
> > 	list_for_each_entry_rcu(test, &file->triggers, list) {
> > 		if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type) {
> > 			ret = -EEXIST;
> > 			goto out;
> > 		}
> > 	}
> > 
> > 	if (data->ops->init) {
> > 		ret = data->ops->init(data->ops, data);
> > 		if (ret < 0)
> > 			goto out;
> > 	}
> > 
> > 	list_add_rcu(&data->list, &file->triggers);
> > 	ret++;
> > 
> > 	update_cond_flag(file);
> > 	if (trace_event_trigger_enable_disable(file, 1) < 0) {
> > 		list_del_rcu(&data->list);
> > 		update_cond_flag(file);
> > 		ret--;
> > 	}
> > out:
> > 	return ret;
> > }
> > 
> > Where the comment is total wrong. It doesn't return 0 on success, it
> > returns 1. And if trace_event_trigger_enable_disable() fails it returns
> > zero.
> > 
> > And that can fail with the call->class->reg() return value, which could
> > fail for various strange reasons. I don't know why we would want to
> > return 0 when it fails?
> > 
> > I don't see where ->reg() would return anything but 1 on success. Maybe
> > I'm missing something. I'll look some more, but I'm thinking of changing  
> > ->reg() to return zero on all success, and negative on all errors and  
> > just check those results.
> >   
> 
> Right, in the case of event triggers, we only register one at a time, 
> whereas with the trace function triggers, with globbing multiple 
> functions can register triggers at the same time, so it makes sense 
> there to have reg() return a count and the more convoluted error handling.

OK, reg in function probes will be handled differently.

> 
> So I agree, simplifying things here by using the standard error handling 
> would be an improvement.

I'll start working on something for 4.19 to simplify it.

Thanks for confirming!

-- Steve
