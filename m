Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAEEC282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10042080A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OF8F3KCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfBDTPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:15:24 -0500
Received: from mail.efficios.com ([167.114.142.138]:47726 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfBDTPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:15:23 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4221D18CC9A;
        Mon,  4 Feb 2019 14:15:22 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 5MuDvasrYX9p; Mon,  4 Feb 2019 14:15:21 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CC99E18CC90;
        Mon,  4 Feb 2019 14:15:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CC99E18CC90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1549307721;
        bh=R5wiJcLQVshtnZ4ahmDAWz0Z1ZbZ4eCuEV0pu+0nPIo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=OF8F3KCLpn3LeEDVMjZCohWpipfWmAYahBrM9WPeDDf8fR6ZMx4PcL3fSkSUEqL6b
         BxbOcxGs3c2nV3W6ZEsGS6/TXFAwwwTWv63DdP7K1mU/kaiExzVDdxerYD1+nBMz07
         TQlO5te+Ifb7z2Xt+Wf07GKl69xslsE5fMsjmExsT/kqSduNKulIlOi6RUlAO7Adq0
         dN03I8EbIRRH565tMk8l9ZXJR1q7v7kiXshEy3o8r3OGVUqiqgKXLbEFuRzoJW3kx3
         sVh7InEAov5PR4mTjZOlWSWxmK2K93AS9gNeNl7yMDyZlvmpcVp1PNElHj8o8eKwZN
         lrJZL1hfw5Mvg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id fv-6b6W5Rnct; Mon,  4 Feb 2019 14:15:21 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B214018CC89;
        Mon,  4 Feb 2019 14:15:21 -0500 (EST)
Date:   Mon, 4 Feb 2019 14:15:21 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     William Cohen <wcohen@redhat.com>, stable@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng@reliableembeddedsystems.com,
        lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
Subject: BUG: optimized kprobes illegal instructions in v4.19 stable kernels
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF65 (Linux)/8.8.10_GA_3745)
Thread-Index: uNOV8VWHr5waCHmElfrlM0lcat7kcg==
Thread-Topic: optimized kprobes illegal instructions in v4.19 stable kernels
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice this commit as a possible culprit of the illegal instructions my lttng
users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
in a Yocto environment [1]. They were able to reproduce the issue with perf
as well.

commit e46daee53bb50bde38805f1823a182979724c229
Author: Kees Cook <keescook@chromium.org>
Date:   Tue Oct 30 22:12:56 2018 +0100

    ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE

I *think* the intent there was to do

-       memcpy(code, &optprobe_template_entry,
+       memcpy(code, (unsigned long *)&optprobe_template_entry,

But if you look at the commit, the "&" seems to have been stripped away,
which happens to change the behavior significantly.

Has this change ever been runtime-tested ?

It has been backported to:
- 4.19 stable as commit 3fe0c68aea21
- 4.14 stable as commit f9e0bc710347

Thanks,

Mathieu

[1] https://bugs.lttng.org/issues/1174

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
