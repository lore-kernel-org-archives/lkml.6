Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E960AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7A920870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGMBl+US"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7A920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJJUQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJJUQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:16:21 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BB3220870;
        Wed, 10 Oct 2018 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539176058;
        bh=o96/5jiP/BKu9E3KyAAWWGjtpyi4QHKfj/60dZgy6M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGMBl+US7jImTMox3Wgxz4DzkufLTkgo/83MZkouiJTa9mHoajR72EM5Y07smqJ/0
         BjP1gD0FZjFrLAGiSPVflEhi1wz8E5flaX3G4o4pUm+rf+5CFESoUILJealuqREfIh
         amXAmeBU/zY8rhs4CYBxHHGjm9vyEp13wmaLb3f8=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B8524142C5E; Wed, 10 Oct 2018 09:54:15 -0300 (-03)
Date:   Wed, 10 Oct 2018 09:54:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Anthony LaTorre <tlatorre9@gmail.com>,
        andipan Das <sandipan@linux.ibm.com>, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: perf report segfault
Message-ID: <20181010125415.GG10775@kernel.org>
References: <CAO49afLqUGuBi_R7BKyojqnkHrMGqXquy-FdVFscOu6Ez0cVFw@mail.gmail.com>
 <20181009164743.GA22886@krava>
 <CAO49af+zxxVh9HGfjKxS=vQcD5po7-oLU87Zp0F21M-C64nWUA@mail.gmail.com>
 <CAO49afJVHsywYdosSqceQiMzFdaYivm4kiNnC_+WKq15jsA7Dg@mail.gmail.com>
 <20181009214158.GB31206@krava>
 <CAO49af+5TaWrdYeM3XyHoti0obH--0txq9_a6_9ZPMuB-J=hjg@mail.gmail.com>
 <20181009222004.GA19295@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009222004.GA19295@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 10, 2018 at 12:20:04AM +0200, Jiri Olsa escreveu:
> On Tue, Oct 09, 2018 at 04:47:31PM -0500, Anthony LaTorre wrote:
> > I can try building perf from the latest sources. I've attached the
> > perf.data and perf.data.tar.bz2 from the test program I sent earlier.
> 
> cool, reproduced.. it seems to get introduced by:
>   2a9d5050dc84 perf script: Show correct offsets for DWARF-based unwinding
> 
> reverting that patch fixes the issue for me, but looks like
> we could just make th attached check and prevent the crash
> 
> adding Sandipan Das to the loop, the author of that commit, any idea?

commit ff4ce2885af8f9e8e99864d78dbeb4673f089c76
Author: Milian Wolff <milian.wolff@kdab.com>
Date:   Wed Sep 26 15:52:05 2018 +0200

    perf report: Don't try to map ip to invalid map
    
    Fixes a crash when the report encounters an address that could not be
    associated with an mmaped region:
    
      #0  0x00005555557bdc4a in callchain_srcline (ip=<error reading variable: Cannot access memory at address 0x38>, sym=0x0, map=0x0) at util/machine.c:2329
      #1  unwind_entry (entry=entry@entry=0x7fffffff9180, arg=arg@entry=0x7ffff5642498) at util/machine.c:2329
      #2  0x00005555558370af in entry (arg=0x7ffff5642498, cb=0x5555557bdb50 <unwind_entry>, thread=<optimized out>, ip=18446744073709551615) at util/unwind-libunwind-local.c:586
      #3  get_entries (ui=ui@entry=0x7fffffff9620, cb=0x5555557bdb50 <unwind_entry>, arg=0x7ffff5642498, max_stack=<optimized out>) at util/unwind-libunwind-local.c:703
      #4  0x0000555555837192 in _unwind__get_entries (cb=<optimized out>, arg=<optimized out>, thread=<optimized out>, data=<optimized out>, max_stack=<optimized out>) at util/unwind-libunwind-
local.c:725
      #5  0x00005555557c310f in thread__resolve_callchain_unwind (max_stack=127, sample=0x7fffffff9830, evsel=0x555555c7b3b0, cursor=0x7ffff5642498, thread=0x555555c7f6f0) at util/machine.c:235
1
      #6  thread__resolve_callchain (thread=0x555555c7f6f0, cursor=0x7ffff5642498, evsel=0x555555c7b3b0, sample=0x7fffffff9830, parent=0x7fffffff97b8, root_al=0x7fffffff9750, max_stack=127) at 
util/machine.c:2378
      #7  0x00005555557ba4ee in sample__resolve_callchain (sample=<optimized out>, cursor=<optimized out>, parent=parent@entry=0x7fffffff97b8, evsel=<optimized out>, al=al@entry=0x7fffffff9750,
          max_stack=<optimized out>) at util/callchain.c:1085
    
    Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
    Tested-by: Sandipan Das <sandipan@linux.ibm.com>
    Acked-by: Jiri Olsa <jolsa@kernel.org>
    Cc: Jin Yao <yao.jin@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Fixes: 2a9d5050dc84 ("perf script: Show correct offsets for DWARF-based unwinding")
    Link: http://lkml.kernel.org/r/20180926135207.30263-1-milian.wolff@kdab.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

