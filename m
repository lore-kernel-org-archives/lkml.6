Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4316C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861B920862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu76JVPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861B920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeHBCvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbeHBCvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:51:15 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56DD720862;
        Thu,  2 Aug 2018 01:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533171763;
        bh=YCz8h15hG/NNhJPp4Q4f7/XSkFqGrRwIhiDXft1zxWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mu76JVPTW1Zq2OfY0xOPNpCc8wRm/DIF5RK2GuC7aar+/1EweByso6LAMyhaf3i/A
         dN/3uIYXuvIXMBBX5T7B8o13tDhQHH7BJgeseJWvka7iFCqyW0DwC1zsVmvuwQ/5pq
         +IJAujuMDJ4l81bJpbM5mPcGlFzqGrf3jIxalLrw=
Date:   Thu, 2 Aug 2018 10:02:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/25] selftests/ftrace: Improve kprobe on module
 testcase to load/unload module
Message-Id: <20180802100240.a27b72abe375c5817d970a0c@kernel.org>
In-Reply-To: <153269370853.3084.10985190108092225790.stgit@devbox>
References: <153269339575.3084.16279591141931053689.stgit@devbox>
        <153269370853.3084.10985190108092225790.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 21:15:08 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> @@ -4,11 +4,18 @@
>  
>  [ -f kprobe_events ] || exit_unsupported # this is configurable
>  
> +rmmod trace-printk ||:
> +if ! modprobe trace-printk.ko ; then
> +  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
> +m"
> +  exit_unresolved;
> +fi
> +
> +MOD=trace_printk
> +FUNC=trace_printk_irq_work

Hmm, this caused a problem with CONFIG_KPROBE_EVENTS_ON_NOTRACE=n.
However, as far as I can see, the trace_printk_irq_work() is not
marked as notrace...

Anyway, I'll find another better module to test.

Thanks,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
