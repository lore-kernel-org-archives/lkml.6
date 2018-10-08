Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620DEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF16214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUaNTzJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF16214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeJIBDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJIBDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:03:09 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7B6F2145D;
        Mon,  8 Oct 2018 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539021018;
        bh=3Wauq6xlfHvu3uPPzdIv/fgqWncjfqtiYgdvmoAFii8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUaNTzJbLn+VgiSQC3uefCGNgFmdHzHGVz3nT+sozU44lPm8lUKBfHrJ1M22+CXub
         ppRDYQ7QAkNsAhvJArHKe4LnAIaIWxKDJfsVGkuoqnmb5JRxJPbh0iVhuSu4qL52xQ
         aAULvLSyqh3+CwXF9s/Ro77XhZV77NmiMEekRgQ0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 67418141DDC; Mon,  8 Oct 2018 14:50:14 -0300 (-03)
Date:   Mon, 8 Oct 2018 14:50:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 1/5] tools, perf, script: Add --insn-trace for
 instruction decoding
Message-ID: <20181008175014.GS3541@kernel.org>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920180540.14039-2-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 20, 2018 at 11:05:36AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a --insn-trace short hand option for decoding and disassembling
> instruction streams for intel_pt. This automatically pipes the
> output into the xed disassembler to generate disassembled instructions.
> This just makes this use model much nicer to use
> 
> Before
> 
> % perf record -e intel_pt// ...
> % perf script --itrace=i0ns --ns -F +insn,-event,-period | xed -F insn: -A -64
>    swapper     0 [000] 117276.429606186:  ffffffff81010486 pt_config ([kernel.kallsyms])          nopl  %eax, (%rax,%rax,1)
>    swapper     0 [000] 117276.429606186:  ffffffff8101048b pt_config ([kernel.kallsyms])          add $0x10, %rsp
>    swapper     0 [000] 117276.429606186:  ffffffff8101048f pt_config ([kernel.kallsyms])          popq  %rbx
>    swapper     0 [000] 117276.429606186:  ffffffff81010490 pt_config ([kernel.kallsyms])          popq  %rbp
>    swapper     0 [000] 117276.429606186:  ffffffff81010491 pt_config ([kernel.kallsyms])          popq  %r12
>    swapper     0 [000] 117276.429606186:  ffffffff81010493 pt_config ([kernel.kallsyms])          popq  %r13
>    swapper     0 [000] 117276.429606186:  ffffffff81010495 pt_config ([kernel.kallsyms])          popq  %r14
>    swapper     0 [000] 117276.429606186:  ffffffff81010497 pt_config ([kernel.kallsyms])          popq  %r15
>    swapper     0 [000] 117276.429606186:  ffffffff81010499 pt_config ([kernel.kallsyms])          retq
>    swapper     0 [000] 117276.429606186:  ffffffff8101063e pt_event_add ([kernel.kallsyms])               cmpl  $0x1, 0x1b0(%rbx)
>    swapper     0 [000] 117276.429606186:  ffffffff81010645 pt_event_add ([kernel.kallsyms])               mov $0xffffffea, %eax
>    swapper     0 [000] 117276.429606186:  ffffffff8101064a pt_event_add ([kernel.kallsyms])               mov $0x0, %edx
>    swapper     0 [000] 117276.429606186:  ffffffff8101064f pt_event_add ([kernel.kallsyms])               popq  %rbx
>    swapper     0 [000] 117276.429606186:  ffffffff81010650 pt_event_add ([kernel.kallsyms])               cmovnz %edx, %eax
>    swapper     0 [000] 117276.429606186:  ffffffff81010653 pt_event_add ([kernel.kallsyms])               jmp 0xffffffff81010635
>    swapper     0 [000] 117276.429606186:  ffffffff81010635 pt_event_add ([kernel.kallsyms])               retq
>    swapper     0 [000] 117276.429606186:  ffffffff8115e687 event_sched_in.isra.107 ([kernel.kallsyms])            test %eax, %eax
> 
> Now
> 
> % perf record -e intel_pt// ...
> % perf script --insn-trace --xed
> ... same output ...
> 
> XED needs to be installed with:
> 
> > git clone https://github.com/intelxed/mbuild.git mbuild
> > git clone https://github.com/intelxed/xed
> > cd xed
> > mkdir obj
> > cd obj
> > ../mfile.py
> > sudo ../mfile.py --prefix=/usr/local install
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Fixed up whitespace damage in the Documentation for building xed,
applied.

- Arnaldo
