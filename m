Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E970C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21934208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKstPcLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21934208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbeH1Ecp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725744AbeH1Ecp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:32:45 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1A320868;
        Tue, 28 Aug 2018 00:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535417024;
        bh=Co5jvck9HvsRJt4rw28A8+S0pIUDXNme10fJ94ACR7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rKstPcLeuVvwCqJR7ARAEQulgpz0CW83WIqi4Kb4/Fi7MTXR50LuzGgZr1KQma3CO
         gHrtety+721WdtQ705RJnYZYrMCxDXilb5FTKo8AM2uORw5H+qeBVrhI0OjyCGEQgF
         OxHsaeLmqC9oj+I/w11qF/PdcvZ4a5WZQ9aPpnyg=
Date:   Tue, 28 Aug 2018 09:43:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnd@arndb.de
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-Id: <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
In-Reply-To: <20180828072333.36af4d5d@canb.auug.org.au>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
        <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
        <20180828072333.36af4d5d@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 28 Aug 2018 07:23:33 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Masami,
> 
> On Sun, 26 Aug 2018 17:10:58 +0900 Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hmm, unfortunately, I couldn't reproduce the ".data..LPBX1" error with
> > my gcc-8.1.0 + ld-2.30 distributed at https://cdn.kernel.org/pub/tools/crosstool/.
> > Could you also try to enable CONFIG_GCOV_PROFILE_ALL=y and build the kernel?
> > If it causes similar error, it should be caused by gcov support.
> 
> Using the allyesconfig as a base and disabling CONFIG_COMPILE_TESTING
> allowed me to enable COMFIG_GCOV_PROFILE_ALL, but that just generated a
> lot more messages.  Some about data..Lusan sections (I think).

OK, so it sounds like GCOV kernel itself is broken with your toolchain
(native gcc-8.2.0 on ppc64?) as same as arm32.

I added Peter in loop, he is the maintainer of GCOV kernel.

Hi Peter,
I recently added a gcov profiling for ftrace, following Documentation/dev-tools/gcov.rst.
6b7dca401cb1 ("tracing: Allow gcov profiling on only ftrace subsystem")

and it caused may orphan section warnings/errors on arm and powerpc64.
We also found same error happens when CONFIG_GCOV_PROFILE_ALL=y.
So I guess GCOV kernel subsystem broken in some environment.

(cross build)
gcc-7.3.0 + ld-2.30 => arm:NG, arm64:OK, powerpc64:OK
gcc-8.1.0 + ld-2.30 => arm:NG, arm64:OK, powerpc64:OK
(native build?)
gcc-8.2.0 + ld 2.31.1 => powerpc64:NG
gcc-7.2.1 + ld 2.27 => x86-64: OK

ppc64 NG report:
https://lkml.org/lkml/2018/8/24/72

arm NG report:
https://lkml.org/lkml/2018/8/24/345

Would you know how we can fix this issue?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
