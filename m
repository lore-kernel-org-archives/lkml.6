Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC65C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4502054F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uin98mL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4502054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeIDTAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeIDTAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:00:37 -0400
Received: from jouet.infradead.org (unknown [189.40.103.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A1D2054F;
        Tue,  4 Sep 2018 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536071716;
        bh=pakRd+YKndDimLBtEKAIazubNZfD7ZBMtJfTLqYOWEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uin98mL6aR1Gxg0cwsBZhQ9VvvIKDTxk7WwG6TcK6/DYnZzVo3I/M8jPRpQ4xgmhZ
         xlqLSJ2RuCqTSsc2p1YjKYCVFz56RODn8JmKCfDs9iOqRunND7uA+preeVjJIHIkt/
         8sGQb5laB+7Ww3wg2d8fe7GpvI6v5IrMWDd7jZb8=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 61D3E141FFC; Tue,  4 Sep 2018 11:35:07 -0300 (-03)
Date:   Tue, 4 Sep 2018 11:35:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] perf tool improvement requests
Message-ID: <20180904143507.GC5364@kernel.org>
References: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
 <20180904071049.GY24124@hirez.programming.kicks-ass.net>
 <20180904134218.GA5364@kernel.org>
 <20180904141724.GJ24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904141724.GJ24124@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 04, 2018 at 04:17:24PM +0200, Peter Zijlstra escreveu:
> On Tue, Sep 04, 2018 at 10:42:18AM -0300, Arnaldo Carvalho de Melo wrote:
> > 	Then I need to get the DW_AT_location stuff parsed in pahole, so
> > that with those offsets (second column, ending with :) with hits (first
> > column, there its local period, but we can ask for some specific metric
> > [1]), I'll be able to figure out what DW_TAG_variable or
> > DW_TAG_formal_parameter is living there at that time, get the offset
> > from the decoded instruction, say that xor, 0x138 offset from the type
> > for %r15 at that offset (85) from kmem_cache_alloc, right?
> 
> I'm not sure how the DWARF location stuff works; it could be it already
> includes the offset and decoding the instruction is not needed.
> 
> But yes, that's the basic idea; get DWARF to tell you what variable is
> used at a certain IP.
> 
> > In a first milestone we'd have something like:
> > 
> > 	perf annotate --hits function | pahole --annotate -C task_struct
> > 
> > 	perf annotate --hits | pahole --annotate
> 
> Not sure keeping it two proglets makes sense, but whatever :-)

This is just a start, trying to take advantage of existing codebases.
 
> The alternative I suppose is making perf do the IP->struct::member
> mapping and freed that to pahole, which then only uses it to annotate
> the output.

So, what I'm trying to do now is to make perf get the samples associated
with functions/offsets + decoded instructions.

Pahole, that already touches DWARF info, will just use the
DW_AT_location, look at its description, from
https://blog.tartanllama.xyz/writing-a-linux-debugger-variables/:


-------------------
    Simple location descriptions describe the location of one contiguous
piece (usually all) of an object. A simple location description may
describe a location in addressable memory, or in a register, or the lack
of a location (with or without a known value).

        Example:

            DW_OP_fbreg -32

	    A variable which is entirely stored -32 bytes from the stack
            frame base.

  Composite location descriptions describe an object in terms of pieces,
each of which may be contained in part of a register or stored in a
memory location unrelated to other pieces.

        Example:

            DW_OP_reg3 DW_OP_piece 4 DW_OP_reg10 DW_OP_piece 2

	    A variable whose first four bytes reside in register 3 and
            whose next two bytes reside in register 10.

   Location lists describe objects which have a limited lifetime or change
location during their lifetime.

        Example:
            <loclist with 3 entries follows>
                [ 0]<lowpc=0x2e00><highpc=0x2e19>DW_OP_reg0
                [ 1]<lowpc=0x2e19><highpc=0x2e3f>DW_OP_reg3
                [ 2]<lowpc=0x2ec4><highpc=0x2ec7>DW_OP_reg2

	    A variable whose location moves between registers depending
            on the current value of the program counter
-------------------


So I have a list of DW_TAG_formal_parameter (function parameters) and
DW_TAG_variable, and the above location lists/descriptions, stating in
what registers and what IP ranges the variables are in, and in the
DW_TAG_{formal_parameter,variable} I have DW_AT_type, that points to the
type of that variable, couple that with the offset taken from the
decoded instruction we get from 'perf annotate --hits' and we should
have all we need, no?

Then pahole can have all this painted on structs (like 'perf annotate')
for the whole workload, or for specific callchains, etc.

> Or, munge the entirety of pahole into perf..

That may be interesting at some point, yes.

- Arnaldo
