Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCCDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4187220827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4187220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeKFGMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:12:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeKFGMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:12:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 119D62D7F5;
        Mon,  5 Nov 2018 20:51:23 +0000 (UTC)
Received: from krava (ovpn-204-79.brq.redhat.com [10.40.204.79])
        by smtp.corp.redhat.com (Postfix) with SMTP id EBCD55D73F;
        Mon,  5 Nov 2018 20:51:20 +0000 (UTC)
Date:   Mon, 5 Nov 2018 21:51:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Message-ID: <20181105205119.GC25674@krava>
References: <2335309.gnWok9HYb4@agathebauer>
 <13521319.OzbRBoFVZM@agathebauer>
 <20181102112635.GD5458@krava>
 <3227038.olIWmsCzzY@agathebauer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3227038.olIWmsCzzY@agathebauer>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 05 Nov 2018 20:51:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 06:56:50PM +0100, Milian Wolff wrote:

SNIP

> > > 
> > > Note how precise levels 0 and 1 do not produce any samples where unwinding
> > > fails. But precise level 2 produces some, and precise level 3 increases
> > > the
> > > amount (by ca. ~2x).
> > > 
> > > I can reproduce this pattern on two separate Intel CPUs and kernel
> > > versions
> > > currently:
> > > 
> > > Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz with 4.18.16-arch1-1-ARCH
> > > Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 4.14.78-1-lts
> > > 
> > > Could someone else try this? What about AMD and IBS - is it also affected?
> > > What about newer/different Intel CPUs?
> > 
> > I tried on intel and can't actualy see that.. how do the failed samples
> > look like? like is there the stack dump attached, what's in the regs?
> > 
> > could you please paste the 'perf report -D' output for some of the
> > failed samples?
> 
> See here for one case: https://paste.kde.org/prryvdilq

we should really print some helpfull debug output
for this.. like to show some markers where the stack
data starts

> 
> What Intel CPU did you use? What microcode version? Which kernel version?
> 
> Generally, isn't what I'm seeing actually a neccessary evil of the ustack 
> based unwinding in perf? I mean, the general procedure is as follows if I'm 
> not mistaken:
> 
> - PMU triggers interrupt and PEBS stores RIP etc.
> - code continous to execute, possibly changing the stack

I dont think the code continues to execute.. the stack is ok

the problem I saw in past is that the copy from user is not
100% and sometimes you might not get full stack data you
asked for

have you tried with libdw unwinder? if one of the unwinder
shows more callchains, we need to fix the other one ;-)

jirka
