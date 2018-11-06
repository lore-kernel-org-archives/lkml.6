Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE67C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2916B2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2916B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbeKFSEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:04:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbeKFSEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:04:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D82EAC05E75A;
        Tue,  6 Nov 2018 08:40:02 +0000 (UTC)
Received: from krava (unknown [10.40.205.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id D780A4138;
        Tue,  6 Nov 2018 08:39:58 +0000 (UTC)
Date:   Tue, 6 Nov 2018 09:39:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Message-ID: <20181106083957.GB8081@krava>
References: <2335309.gnWok9HYb4@agathebauer>
 <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava>
 <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106001037.GQ6218@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 06 Nov 2018 08:40:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 04:10:37PM -0800, Andi Kleen wrote:
> > > > - PMU triggers interrupt and PEBS stores RIP etc.
> > > > - code continous to execute, possibly changing the stack
> > > 
> > > I dont think the code continues to execute.. the stack is ok
> > 
> > Are you sure about this? I mean, isn't that the whole reason why we need PEBS? 
> > Generally, if you are sure about this, can you point me to some documentation 
> > on this to allow me to understand it better?
> 
> Milian is right.
> 
> There is a execution window from PEBS capturing registers to actually triggering
> the PMU, and if there is stack manipulation in that window
> the PEBS state might be out of sync with the real stack.

hum, is this about having 'large pebs' or there's this window
if there's also only single pebs record allowed? which should
be case for dwarf unwind

> The right RIP/RSP to use for the stack unwinding is always the data
> in the PMI's exception frame on the stack.
> 
> Probably would need to modify perf to report those too in addition
> to the PEBS registers.

ok, should not be that hard

> 
> Of course it would still mean that the stack unwinding may not exactly
> match the sample RIP, but at least it should be consistent.

jirka
