Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD68C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E21B2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E21B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeJRVSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbeJRVSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:18:10 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F210F2145D;
        Thu, 18 Oct 2018 13:17:07 +0000 (UTC)
Date:   Thu, 18 Oct 2018 09:17:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Message-ID: <20181018091706.62310b38@gandalf.local.home>
In-Reply-To: <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
        <20181016112928.4b52afb5@gandalf.local.home>
        <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
        <20181016125721.236ada82@gandalf.local.home>
        <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
        <20181016134803.1b9260c1@gandalf.local.home>
        <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
        <20181016141610.639b9000@gandalf.local.home>
        <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
        <20181016144123.24c47b38@gandalf.local.home>
        <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
        <20181016150328.3450d718@gandalf.local.home>
        <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
        <20181017223334.29ca2837@vmware.local.home>
        <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 10:51:18 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> > So something else is causing an issue besides just msm_read.
> > 
> > Can you do an objdump -dr of the entire vmlinux binary and gzip it and
> > post it somewhere. Not sure if it would be too big to email. You could
> > try sending it to me privately. I'd like to see the binary that you are
> > using.
> >   
> 
> I have sent the objdump and dot config to you privately.

Thanks. I don't see anything that pops out, but then again, my arm asm
foo is very rusty (it has been literally decades since I did any arm
asm). I wonder if it could simply be a timing issue?

ffff0000086eb538 <msm_read.isra.1>:
ffff0000086eb538:       a9be7bfd        stp     x29, x30, [sp,#-32]!
ffff0000086eb53c:       910003fd        mov     x29, sp
ffff0000086eb540:       a90153f3        stp     x19, x20, [sp,#16]
ffff0000086eb544:       aa0003f4        mov     x20, x0
ffff0000086eb548:       2a0103f3        mov     w19, w1
ffff0000086eb54c:       aa1e03e0        mov     x0, x30
ffff0000086eb550:       97e6bae4        bl      ffff00000809a0e0 <_mcount>

The above is changed to nop on boot, but then to:

	bl ftrace_caller

When ftrace is enabled.

ffff0000086eb554:       8b334280        add     x0, x20, w19, uxtw
ffff0000086eb558:       b9400000        ldr     w0, [x0]
ffff0000086eb55c:       a94153f3        ldp     x19, x20, [sp,#16]
ffff0000086eb560:       a8c27bfd        ldp     x29, x30, [sp],#32
ffff0000086eb564:       d65f03c0        ret



ffff00000809a0e4 <ftrace_caller>:
ffff00000809a0e4:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
ffff00000809a0e8:       910003fd        mov     x29, sp
ffff00000809a0ec:       d10013c0        sub     x0, x30, #0x4
ffff00000809a0f0:       f94003a1        ldr     x1, [x29]
ffff00000809a0f4:       f9400421        ldr     x1, [x1,#8]
ffff00000809a0f8:       d1001021        sub     x1, x1, #0x4

ffff00000809a0fc <ftrace_call>:
ffff00000809a0fc:       d503201f        nop

The above nop gets patched to:

	bl ftrace_ops_no_ops

Which will iterate through all the registered functions.


ffff00000809a100 <ftrace_graph_call>:
ffff00000809a100:       d503201f        nop

The above only gets set when function graph tracer is enabled, which it
is not in this case.

ffff00000809a104:       a8c17bfd        ldp     x29, x30, [sp],#16
ffff00000809a108:       d65f03c0        ret


Anyone see any problems here?

-- Steve
