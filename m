Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F811C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAB820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAB820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbeGXV6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbeGXV6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:58:17 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC5620856;
        Tue, 24 Jul 2018 20:50:01 +0000 (UTC)
Date:   Tue, 24 Jul 2018 16:49:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] [BUGFIX] tracing: Fix double free of
 event_trigger_data
Message-ID: <20180724164959.3cbc1422@gandalf.local.home>
In-Reply-To: <20180725000909.6c8b2f3881ee75c4f6bd466b@kernel.org>
References: <153149923649.11274.14970833360963898112.stgit@devbox>
        <153149926702.11274.12489440326560729788.stgit@devbox>
        <20180723221006.60cc7aa9@vmware.local.home>
        <20180725000909.6c8b2f3881ee75c4f6bd466b@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 00:09:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hmm, your patch seems to leak a memory since event_trigger_init() will
> be called twice on same trigger_data (Note that event_trigger_init()
> does not init ref counter, but increment it.) So we should decrement
> it when we find it is succeeded. Moreover, if register_trigger()

Good catch, and easily fixed.

> fails before calling data->ops->init() (see -EEXIST case), the ref
> counter will be 0 (-1 +1). But if it fails after data->ops->init(),
> the ref counter will be 1 (-1 +1 +1). It still be unstable.
> (Ah, that means we may have another trouble...)

I'm not sure there's a problem here. I now have:

 out_reg:
	/* Up the trigger_data count to make sure reg doesn't free it on failuer */
	event_trigger_init(trigger_ops, trigger_data);
	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
	/*
	 * The above returns on success the # of functions enabled,
	 * but if it didn't find any functions it returns zero.
	 * Consider no functions a failure too.
	 */
	if (!ret) {
		ret = -ENOENT;
	} else if (ret > 0)
		ret = 0;

	/* Down the counter of trigger_data or free it if not used anymore */
	event_trigger_free(trigger_ops, trigger_data);
 out:
	return ret;

Thus we increment trigger_data before calling reg, and free it
afterward. But if reg() did an init too, then the event_trigger_free()
just decs the ref counter.

As for register_trigger()


> 
> > 
> > P.S. This brings up another minor bug. The failure should return ENOMEM
> > not ENOENT.  
> 
> Hmm it seems we should review the register_trigger() implementation.
> It should return the return value of trace_event_trigger_enable_disable(),
> shouldn't it?
>

Yeah, that's not done well. I'll fix it up.

Thanks for pointing it out.

-- Steve
