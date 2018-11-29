Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDCAC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CDB2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGW8cI6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CDB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeK3JUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeK3JUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:20:10 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D9C2145D;
        Thu, 29 Nov 2018 22:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543529592;
        bh=AgMlONgVYeT/0apqrzf5OGDaDt6Gba6MEhi+gGjOvGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XGW8cI6Bl8yrix9pPxGUSNMKSuJoNMRI2xg1cWcAdr1tgBADofj/d6tRKMs54+d1T
         ZyCVx4mhKmT+y6g1CEfY6g+iAj3V5oU7hsISbyuG2/APYQply8PfCDvx5nIabS35pg
         MIBmcFHYfxbjp4rHAYuiJEFDjIBdX0Qa08VU51O0=
Date:   Fri, 30 Nov 2018 07:13:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: ftrace: Fix to enable syscall events on arm64
Message-Id: <20181130071309.dfa552d2bcd7283788e5563e@kernel.org>
In-Reply-To: <20181129165329.GC22027@arrakis.emea.arm.com>
References: <20181128195921.GA32668@arm.com>
        <154346997347.21404.9819884326251206341.stgit@devbox>
        <20181129165329.GC22027@arrakis.emea.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 16:53:30 +0000
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Thu, Nov 29, 2018 at 02:39:33PM +0900, Masami Hiramatsu wrote:
> > Since commit 4378a7d4be30 ("arm64: implement syscall wrappers")
> > introduced "__arm64_" prefix to all syscall wrapper symbols in
> > sys_call_table, syscall tracer can not find corresponding
> > metadata from syscall name. In the result, we have no syscall
> > ftrace events on arm64 kernel, and some bpf testcases are failed
> > on arm64.
> > 
> > To fix this issue, this introduces custom
> > arch_syscall_match_sym_name() which skips first 8 bytes when
> > comparing the syscall and symbol names.
> > 
> > Fixes: 4378a7d4be30 ("arm64: implement syscall wrappers")
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: stable@vger.kernel.org
> 
> Queued for 4.20. Thanks.

Thank you Catalin!

> 
> -- 
> Catalin


-- 
Masami Hiramatsu <mhiramat@kernel.org>
