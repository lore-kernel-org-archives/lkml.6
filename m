Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80948ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353752145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RKBgQm2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353752145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeJSMV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:21:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32787 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeJSMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 08:21:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so15302112plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 21:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lb9ipAF0X1qc723pxRiwYkaTJTsvnjoQaz9AFLyOAZA=;
        b=RKBgQm2OiQy/H7CBecA3mc+edR3ZXQctYAMSTHRyWoGBUUYxO4FRqn4malIDOpUj13
         3NmOjoy9RUo1CUyaMFtu3htE+efy87qPVh4oeW+4cORSH2byR6VYl6sFOJwWgpru7IUm
         fdnSooqjt4Xttxti6+qDXenJTZr/v6lhqMBQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lb9ipAF0X1qc723pxRiwYkaTJTsvnjoQaz9AFLyOAZA=;
        b=Ten9PFf1QnGilyQ/ulYpMG+7HCCaPvgy7hzUr95rTbGP0wPf6Fq5IkWn7/tONPEDVe
         j2YJsQqnmBof7LhZzJ3u3yVx3dZ8+92sHvLghPjqP6Ji3MfOh4X3P8RjyvXzdYJtp6or
         rq8BDoazTGDU+j5/4ALtbFoLB8G+jNHlzTUaOyJ19Fa78aBOCkUkuOqjfswpV1wODull
         pIVK7uzUEjPnp/P4eKmr95c2sGmZxP9BUl0w/9tDKK/JBgtTjwSjjsmgqTOWaOqMwvdD
         PQzBHemOgKZUFsOaI2NBzEMCXPfBLggvYqkZQIv0LRess+2wDtiNn3Ein+lEIW2/iq1N
         BWrQ==
X-Gm-Message-State: ABuFfogC5fhgTRlVtCDcWz76C+u5EcR2KSNCNeUdoDyXCpxsF8GerOsh
        wK4yzh+y68ui/ydc5knYPvKSSg==
X-Google-Smtp-Source: ACcGV61z6Rp3Ocm3Sq0dX8QJPRSkSUYdG0WCat4yu2dbR33yb0H29Y8yxZxvklQhDryzgO3x5Fi+7g==
X-Received: by 2002:a17:902:7109:: with SMTP id a9-v6mr32463219pll.310.1539922662831;
        Thu, 18 Oct 2018 21:17:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 189-v6sm25701022pfe.121.2018.10.18.21.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 21:17:41 -0700 (PDT)
Date:   Thu, 18 Oct 2018 21:17:40 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Message-ID: <20181019041740.GB141835@joelaf.mtv.corp.google.com>
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home>
 <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
 <20181018091706.62310b38@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018091706.62310b38@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:17:06AM -0400, Steven Rostedt wrote:
> On Thu, 18 Oct 2018 10:51:18 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
> > > So something else is causing an issue besides just msm_read.
> > > 
> > > Can you do an objdump -dr of the entire vmlinux binary and gzip it and
> > > post it somewhere. Not sure if it would be too big to email. You could
> > > try sending it to me privately. I'd like to see the binary that you are
> > > using.
> > >   
> > 
> > I have sent the objdump and dot config to you privately.
> 
> Thanks. I don't see anything that pops out, but then again, my arm asm
> foo is very rusty (it has been literally decades since I did any arm
> asm). I wonder if it could simply be a timing issue?
> 
> ffff0000086eb538 <msm_read.isra.1>:
> ffff0000086eb538:       a9be7bfd        stp     x29, x30, [sp,#-32]!
> ffff0000086eb53c:       910003fd        mov     x29, sp
> ffff0000086eb540:       a90153f3        stp     x19, x20, [sp,#16]
> ffff0000086eb544:       aa0003f4        mov     x20, x0
> ffff0000086eb548:       2a0103f3        mov     w19, w1
> ffff0000086eb54c:       aa1e03e0        mov     x0, x30
> ffff0000086eb550:       97e6bae4        bl      ffff00000809a0e0 <_mcount>
> 
> The above is changed to nop on boot, but then to:
> 
> 	bl ftrace_caller
> 
> When ftrace is enabled.
> 
> ffff0000086eb554:       8b334280        add     x0, x20, w19, uxtw
> ffff0000086eb558:       b9400000        ldr     w0, [x0]
> ffff0000086eb55c:       a94153f3        ldp     x19, x20, [sp,#16]
> ffff0000086eb560:       a8c27bfd        ldp     x29, x30, [sp],#32
> ffff0000086eb564:       d65f03c0        ret
> 
> 
> 
> ffff00000809a0e4 <ftrace_caller>:
> ffff00000809a0e4:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
> ffff00000809a0e8:       910003fd        mov     x29, sp
> ffff00000809a0ec:       d10013c0        sub     x0, x30, #0x4
> ffff00000809a0f0:       f94003a1        ldr     x1, [x29]
> ffff00000809a0f4:       f9400421        ldr     x1, [x1,#8]
> ffff00000809a0f8:       d1001021        sub     x1, x1, #0x4
> 
> ffff00000809a0fc <ftrace_call>:
> ffff00000809a0fc:       d503201f        nop
> 
> The above nop gets patched to:
> 
> 	bl ftrace_ops_no_ops
> 
> Which will iterate through all the registered functions.
> 
> 
> ffff00000809a100 <ftrace_graph_call>:
> ffff00000809a100:       d503201f        nop
> 
> The above only gets set when function graph tracer is enabled, which it
> is not in this case.
> 
> ffff00000809a104:       a8c17bfd        ldp     x29, x30, [sp],#16
> ffff00000809a108:       d65f03c0        ret
> 
> 
> Anyone see any problems here?

This seems sane to me, he says in the other thread that he put 'notrace' to
the msm serial functions (which AIUI should prevent ftrace instrumentation)
and he still sees the issue.

thanks,

 - Joel

