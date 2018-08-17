Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B243F2188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWO5D9sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B243F2188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeHQRbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbeHQRbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:31:04 -0400
Received: from localhost (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01D021878;
        Fri, 17 Aug 2018 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534516050;
        bh=J74AFXir4zCC7EBGikGy6+ZhtIWDZmylvVb08kM8epY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWO5D9sxi/xGesOw4F821RNY11D/e2VluRoctgb+OGDNcfL4v8drI4OpQ0+MEsrAt
         Zm8paLgUZVSbMVtqPLMi54MZcFiAQiMULoW9G4++auR8Ho9G4PwXdVAWh1DE9HwcjP
         2cE0PB6HTGg1brBi/E/6PnYXT7g/X8f/VZIDOAM4=
Date:   Fri, 17 Aug 2018 16:27:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/5] perf/hw_breakpoint: Modify breakpoint even if the
 new attr has disabled set
Message-ID: <20180817142725.GB12426@lerouge>
References: <20180810104730.3293-1-jolsa@kernel.org>
 <20180810104730.3293-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810104730.3293-3-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 12:47:27PM +0200, Jiri Olsa wrote:
> We need to change the breakpoint even if the attr with
> new fields has disabled set to true.
> 
> Current code prevents following user code to change
> the breakpoint address:
> 
>   ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), addr_1)
>   ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[0]), addr_2)
>   ptrace(PTRACE_POKEUSER, child, offsetof(struct user, u_debugreg[7]), dr7)
> 
> The first PTRACE_POKEUSER creates the breakpoint with
> attr.disabled set to true:
> 
>   ptrace_set_breakpoint_addr(nr = 0)
>     struct perf_event *bp = t->ptrace_bps[nr];
> 
>     ptrace_register_breakpoint(..., disabled = true)
>       ptrace_fill_bp_fields(..., disabled)
>       register_user_hw_breakpoint
> 
> So the second PTRACE_POKEUSER will be omitted:
> 
>   ptrace_set_breakpoint_addr(nr = 0)
>     struct perf_event *bp = t->ptrace_bps[nr];
>     struct perf_event_attr attr = bp->attr;
> 
>     modify_user_hw_breakpoint(bp, &attr)
>       if (!attr->disabled)
>         modify_user_hw_breakpoint_check
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Reported-by: Milind Chabbi <chabbi.milind@gmail.com>
> Link: http://lkml.kernel.org/n/tip-yjhgplc28gk5gfzt7ceooe6z@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Right, now that we fixed the breakpoint modification arch code, it should
be safe to do that.

Thanks!

Acked-by: Frederic Weisbecker <frederic@kernel.org>
