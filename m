Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CF6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E102054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E102054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeH3M6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:58:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbeH3M6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:58:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA3D487A70;
        Thu, 30 Aug 2018 08:56:59 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id C4379202704E;
        Thu, 30 Aug 2018 08:56:58 +0000 (UTC)
Date:   Thu, 30 Aug 2018 10:56:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 03/10] tools, perf, script: Add --insn-trace for
 instruction decoding
Message-ID: <20180830085658.GE16691@krava>
References: <20180829171834.6590-1-andi@firstfloor.org>
 <20180829171834.6590-4-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829171834.6590-4-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 08:56:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 08:56:59 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:18:27AM -0700, Andi Kleen wrote:
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
> % perf script --insn-trace
> ... same output ...

which version of xed?

[jolsa@krava perf]$ ./perf script --insn-trace
Unknown option -F
[jolsa@krava perf]$ xed --version
xed - Version 1.8.3

could you please check on this, and warn if the xed output
is not available for this option

thanks,
jirka
