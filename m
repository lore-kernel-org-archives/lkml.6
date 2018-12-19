Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F3DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15ADC20869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeLSWFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:05:37 -0500
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:47097 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727151AbeLSWFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:05:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 409FE100E86C0;
        Wed, 19 Dec 2018 22:05:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thumb00_1378c82edb526
X-Filterd-Recvd-Size: 1932
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Dec 2018 22:05:33 +0000 (UTC)
Message-ID: <a5a26ed80402a0abdc83dffc2e7fb28b0b96450f.camel@perches.com>
Subject: Re: [RFC][PATCH] string.h: Add strncmp_prefix() helper macro
From:   Joe Perches <joe@perches.com>
To:     Bryana Rostedt <bryana@home.goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date:   Wed, 19 Dec 2018 14:05:32 -0800
In-Reply-To: <20181219163207.792e0f97@gandalf.local.home>
References: <20181219163207.792e0f97@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 16:32 -0500, Bryana Rostedt wrote:
> a quick grep in the kernel tree found several
> (thousands!) of cases that use this construct. A quick grep also
> revealed that there's probably several bugs in that use case. Some are
> that people forgot the "- 1" (which I found) and others could be that
> the constant for the sizeof is different than the constant (although, I
> haven't found any of those, but I also didn't look hard).

Several dozen cases exist like strncmp(foo, "bar", 4)
where it might as well use strcmp instead.

And a few mismatches exist like:

drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c:2285:		if (!strncmp(opt, "eee_timer:", 6)) {
tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c:318:	if (!strncmp(s, "power", 9))
tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c:321:	if (!strncmp(s, "balance-power", 17))
j

