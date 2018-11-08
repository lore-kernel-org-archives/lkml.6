Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A074ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72920827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcP8JVbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A72920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeKIEt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeKIEt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:49:27 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 540AC2081C;
        Thu,  8 Nov 2018 19:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541704355;
        bh=QcfVRWCZh4nlKSHF8OVZoojwVIVpt9jpp+8VUQcZhrI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YcP8JVbTBhB4uDqHArwFNNTMHia2fp6j+TEiFSrenaN+NWy8ROT2uQu3lvczC8DLg
         I2OQXby9F7c1/hZCvnejydkf/ja2G3VMafHVHd/885PhQRi7rxysHVSXW9lO775coD
         0+ZOSp1dJtP8XyKPgJVOyCSC7LnwntjjOFDxbZFM=
Message-ID: <1541704353.10405.8.camel@kernel.org>
Subject: Re: [PATCH 0/2] tracing: Fix NULL pointer bug in hist key
 expressions
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     vincent@bernat.ch, linux-kernel@vger.kernel.org
Date:   Thu, 08 Nov 2018 13:12:33 -0600
In-Reply-To: <20181108134507.2c343e6b@gandalf.local.home>
References: <cover.1541687121.git.tom.zanussi@linux.intel.com>
         <20181108134507.2c343e6b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2018-11-08 at 13:45 -0500, Steven Rostedt wrote:
> On Thu,  8 Nov 2018 08:41:47 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Hi Steve,
> > 
> > This is a fix for a user-reported bug in the hist triggers, where
> > if a
> > variable reference is used in an expression in a histogram key, it
> > results in a NULL pointer dereference and subsequent Oops.
> 
> How does one add a variable reference as an expression in a
> histogram key?
> 
> Can you show an example?
> 

Sure, here's the example that showed the problem, and which the patch
fixes:

echo 'r:fib_table_lookup_ret fib_table_lookup $retval' > /sys/kernel/debug/tracing/kprobe_events

echo 'hist:keys=cpu:ts0=common_timestamp' > /sys/kernel/debug/tracing/events/fib/fib_table_lookup/trigger
echo 'hist:keys=cpu,common_timestamp-$ts0' > /sys/kernel/debug/tracing/events/kprobes/fib_table_lookup_ret/trigger

The following is also a variable reference in an expression, but in
this case the expression is the variable reference alone, which the
existing code handles properly and returns -EINVAL.

echo 'hist:keys=cpu,$ts0' > /sys/kernel/debug/tracing/events/kprobes/fib_table_lookup_ret/trigger

Tom

> -- Steve
> 
> > 
> > I separated the fix into two small patches, the first preventing
> > the
> > immediate problem bu disallowing a var_ref from ever accessing a
> > NULL
> > element, and the second disallowing a user from ever constructing
> > such
> > a key.
> > 
> > Thanks,
> > 
> > Tom
> > 
> > The following changes since commit
> > ee474b81fe5aa5dc0faae920bf66240fbf55f891:
> > 
> >   tracing/kprobes: Fix strpbrk() argument order (2018-11-05
> > 09:47:14 -0500)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-
> > trace.git ftrace/key-ref-fix
> > 
> > Tom Zanussi (2):
> >   tracing: Prevent hist_field_var_ref() from accessing NULL
> >     tracing_map_elts
> >   tracing: Check keys for variable references in expressions too
> > 
> >  kernel/trace/trace_events_hist.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> 
> 
