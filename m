Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57952C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A30217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLREWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:22:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:65344 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeLREWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 23:22:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2018 20:22:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,367,1539673200"; 
   d="scan'208";a="128721522"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2018 20:22:07 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 05071300B49; Mon, 17 Dec 2018 20:22:07 -0800 (PST)
Date:   Mon, 17 Dec 2018 20:22:06 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: objtool warnings for kernel/trace/trace_selftest_dynamic.o
Message-ID: <20181218042206.GC25620@tassilo.jf.intel.com>
References: <CAK8P3a2K1K21ePBFbApaTKPCk+=Bqj0LyWoK1MdFb1s9ZwjfPg@mail.gmail.com>
 <20181217173900.ygifx7khwmzn2gv2@treble>
 <20181217180434.GS25620@tassilo.jf.intel.com>
 <20181217181638.dfexg6mkmbfyzfli@treble>
 <20181217192938.GF2218@hirez.programming.kicks-ass.net>
 <20181217213126.lsqhyszoulel6uq6@treble>
 <20181217173644.391c2070@gandalf.local.home>
 <20181218000618.GA25620@tassilo.jf.intel.com>
 <20181218024916.vmfnyqzouhfxhyvc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218024916.vmfnyqzouhfxhyvc@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The plugin is only used for older versions of GCC.  Newer versions have
> the same functionality builtin with -fsanitize-coverage=trace-pc.

Ok and the frame pointer issue is with the older version only?

> 
> So the problem is GCC.  We're using a function attribute which at least
> oneGCC developer doesn't recommend.  If you want to keep the LTO support
> then '__used' seems like a much better choice.

I guess __used will work for now.

Still would be better to root cause it properly, but I guess that's
ok for now. The lack of understanding may eventually come back
to bite you later.

FWIW i did some tests and I don't see noclone affecting frame pointer
with gcc 8. The only thing I saw was that empty functions ended up
without frame pointer.

I suspect you'll need to fix up the other users of noclone too.

-Andi
