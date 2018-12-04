Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1A6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7083E20878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqiJxuEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7083E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLDT7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbeLDT7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:59:23 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F389B20834;
        Tue,  4 Dec 2018 19:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543953562;
        bh=1vmp2ToQyahIGEvTswIegzsyCqoix5IjMu/aDtQxNWk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YqiJxuEbKJWBtccZGdI+DW+uJDLulA6puniZVMjTqEsE96KwPNIvn9mPJoh3pALAS
         pl8DExX33RqcoQehLqFx2JoCnBzAHT6OfElZgFtThOpaIoObBqZHXbDmsOIn+1dqUJ
         XzmmW8bV/6IQplYFQfz6tg5CijkcCLwBRnRlf2rE=
Message-ID: <1543953560.2790.18.camel@kernel.org>
Subject: Re: [PATCH v7 09/16] tracing: Add hist trigger snapshot() action
 test case
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Tue, 04 Dec 2018 13:59:20 -0600
In-Reply-To: <20181126220332.215b461779d1d57f37b46e20@kernel.org>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
         <a40dadf6ffa267a1a573b62bb1c9b4db9d91f744.1542221863.git.tom.zanussi@linux.intel.com>
         <20181126220332.215b461779d1d57f37b46e20@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Mon, 2018-11-26 at 22:03 +0900, Masami Hiramatsu wrote:
> On Wed, 14 Nov 2018 14:18:06 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add a test case verifying the basic functionality of the
> > hist:snapshot() action.
> > 
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  .../inter-event/trigger-snapshot-action-hist.tc    | 43
> > ++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > snapshot-action-hist.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-snapshot-action-hist.tc
> > b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-snapshot-action-hist.tc
> > new file mode 100644
> > index 000000000000..a0a51e6a6a0c
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-snapshot-action-hist.tc
> > @@ -0,0 +1,43 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test inter-event histogram trigger
> > snapshot action
> > +
> > +fail() { #msg
> > +    echo $1
> > +    exit_fail
> > +}
> > +
> > +if [ ! -f set_event ]; then
> > +    echo "event tracing is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +if [ ! -f snapshot ]; then
> > +    echo "snapshot is not supported"
> > +    exit_unsupported
> > +fi
> > +
> > +grep -q "onchange(var)" README > /dev/null || exit_unsupported #
> > version issue
> > +
> > +grep -q "snapshot()" README > /dev/null || exit_unsupported #
> > version issue
> 
> "grep -q ... > /dev/null" is redundant, since -q doesn't show
> anything.
> please drop "> /dev/null" redirection.
> 
> > +
> > +echo "Test snapshot action"
> > +
> > +echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> > +
> > +echo
> > 'hist:keys=comm:newprio=prio:onchange($newprio).save(comm,prio):onc
> > hange($newprio).snapshot() if comm=="ping"' >>
> > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> 
> This tests onchange().snapshot(), but document change only describes
> onmax().snapshot().
> Maybe we should improve document too.
> 

Actually, onchange().snapshot() is documented in '[PATCH v7 11/16]
tracing: Add hist trigger onchange() handler Documentation'.  I can
change the order of the patches if it matters.

Thanks,

Tom

