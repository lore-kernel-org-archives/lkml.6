Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC7FC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5528620893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBlsHWqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5528620893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeG1PIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbeG1PIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:08:52 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F92120841;
        Sat, 28 Jul 2018 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532785338;
        bh=w3bKiOWZGMn8RXvMIlVcwlbv38LMRx6QMYJg7iiHRQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nBlsHWqy94vKd9DYvNbUzWLgl2Aj0DPQ2RVtFDDHFSiVesl6jnO8ZcyVmnzYgiHl8
         2VZzuMy7ydVGBraPvO/PLHDo4ok17MdnJ08VTAhKKG1n1X+OT86EgQeiw7iRr3hmwK
         iCJY+HKTxawQ4zzIZsciBRbzP2SxzkqQ5o0gqVHE=
Date:   Sat, 28 Jul 2018 22:42:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing: kprobes: Prohibit probing on notrace
 function
Message-Id: <20180728224214.0dbe837304776c1aa2a198c9@kernel.org>
In-Reply-To: <201807281639.dEpwGLj8%fengguang.wu@intel.com>
References: <153258440707.11602.3706182300882155086.stgit@devbox>
        <201807281639.dEpwGLj8%fengguang.wu@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, thanks!

I've missed CONFIG_FUNCTION_TRACER=n case...

On Sat, 28 Jul 2018 16:11:34 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on v4.18-rc6 next-20180727]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/tracing-kprobes-Prohibit-probing-on-notrace-functions/20180728-145919
> config: x86_64-randconfig-x018-201829 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    kernel//trace/trace_kprobe.c: In function 'within_notrace_func':
> >> kernel//trace/trace_kprobe.c:503:10: error: implicit declaration of function 'ftrace_location_range'; did you mean 'ftrace_location'? [-Werror=implicit-function-declaration]
>      return !ftrace_location_range(addr - offset, addr - offset + size);
>              ^~~~~~~~~~~~~~~~~~~~~
>              ftrace_location
>    cc1: some warnings being treated as errors
> 
> vim +503 kernel//trace/trace_kprobe.c
> 
>    489	
>    490	#ifdef CONFIG_KPROBE_EVENTS_ON_NOTRACE
>    491	#define within_notrace_func(tk)	(false)
>    492	#else
>    493	static bool within_notrace_func(struct trace_kprobe *tk)
>    494	{
>    495		unsigned long offset, size, addr;
>    496	
>    497		addr = kallsyms_lookup_name(trace_kprobe_symbol(tk));
>    498		addr += trace_kprobe_offset(tk);
>    499	
>    500		if (!kallsyms_lookup_size_offset(addr, &size, &offset))
>    501			return true;	/* Out of range. */
>    502	
>  > 503		return !ftrace_location_range(addr - offset, addr - offset + size);
>    504	}
>    505	#endif
>    506	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


-- 
Masami Hiramatsu <mhiramat@kernel.org>
