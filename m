Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E847EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D0D215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="05+UOThj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D0D215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeI1Bbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbeI1Bbk (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:31:40 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16EC521708;
        Thu, 27 Sep 2018 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538075516;
        bh=A2LfzO8EWAvQ3lENhfz9vmkJrPo0CzxvjZomrYMhduk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05+UOThjbOhZ2bNPwQ79yrVbc0NPC5Jclyf97wTkl+3Fz1rHmYQFcz9X0K3BFbJUV
         P6tt+fJJ8rlWw/cfQTIKiNpMMF62zjF//QtHTVKD4tiVluWx+pufEthTdjty/F0mgG
         YF0ZpluTdyossZqOnIAMq/olUHqdVZeLRrR2mY6k=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 004E21401A1; Thu, 27 Sep 2018 16:11:53 -0300 (-03)
Date:   Thu, 27 Sep 2018 16:11:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org,
        yao.jin@linux.intel.com, namhyung@kernel.org,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf report: don't try to map ip to invalid map
Message-ID: <20180927191153.GH25764@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <30c8b8d9-4d0f-ec28-907b-899edd632fb1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30c8b8d9-4d0f-ec28-907b-899edd632fb1@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 27, 2018 at 02:18:47PM +0530, Sandipan Das escreveu:
> 
> 
> On 26/09/18 7:22 PM, Milian Wolff wrote:
> > Fixes a crash when the report encounters an address that
> > could not be associated with an mmaped region:
> > 
> > #0  0x00005555557bdc4a in callchain_srcline (ip=<error reading variable: Cannot access memory at address 0x38>, sym=0x0, map=0x0) at util/machine.c:2329
> > #1  unwind_entry (entry=entry@entry=0x7fffffff9180, arg=arg@entry=0x7ffff5642498) at util/machine.c:2329
> > #2  0x00005555558370af in entry (arg=0x7ffff5642498, cb=0x5555557bdb50 <unwind_entry>, thread=<optimized out>, ip=18446744073709551615) at util/unwind-libunwind-local.c:586
> > #3  get_entries (ui=ui@entry=0x7fffffff9620, cb=0x5555557bdb50 <unwind_entry>, arg=0x7ffff5642498, max_stack=<optimized out>) at util/unwind-libunwind-local.c:703
> > #4  0x0000555555837192 in _unwind__get_entries (cb=<optimized out>, arg=<optimized out>, thread=<optimized out>, data=<optimized out>, max_stack=<optimized out>) at util/unwind-libunwind-local.c:725
> > #5  0x00005555557c310f in thread__resolve_callchain_unwind (max_stack=127, sample=0x7fffffff9830, evsel=0x555555c7b3b0, cursor=0x7ffff5642498, thread=0x555555c7f6f0) at util/machine.c:2351
> > #6  thread__resolve_callchain (thread=0x555555c7f6f0, cursor=0x7ffff5642498, evsel=0x555555c7b3b0, sample=0x7fffffff9830, parent=0x7fffffff97b8, root_al=0x7fffffff9750, max_stack=127) at util/machine.c:2378
> > #7  0x00005555557ba4ee in sample__resolve_callchain (sample=<optimized out>, cursor=<optimized out>, parent=parent@entry=0x7fffffff97b8, evsel=<optimized out>, al=al@entry=0x7fffffff9750,
> >     max_stack=<optimized out>) at util/callchain.c:1085
> > 
> 
> Tested-by: Sandipan Das <sandipan@linux.ibm.com>

Thanks, applied.

- Arnaldo
