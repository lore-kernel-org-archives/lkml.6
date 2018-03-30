Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbeC3OHi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 10:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbeC3OHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 10:07:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AAC217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 30 Mar 2018 10:07:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180330100734.7aa872f5@gandalf.local.home>
In-Reply-To: <CAGWkznGH96VcMujvep5VtwO6M42YOmXtV=M+QZM+xWH_5DPcEA@mail.gmail.com>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
        <20180329120528.337bf6cb@gandalf.local.home>
        <CAGWkznGH96VcMujvep5VtwO6M42YOmXtV=M+QZM+xWH_5DPcEA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018 11:32:22 +0800
Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> Steve, thanks for your quick feedback. The original purpose is to
> avoid such kind
> of OOM as kernel can not define the behavior of the application. I
> think it is no need
> to do the alloc->free process if we have known the number of pages
> difinitly lead to failure.
> Furthermore,  the app which screw up the thing usually escape the OOM and cause
> the innocent to be sacrificed.

A couple of things. Your patch goes way too deep into coupling with the
memory management subsystem. If I were to accept this patch, Linus
would have a fit. That get_available_mem() does not belong in the
tracing code. If you want that feature, you need to get the mm folks to
accept it, and then tracing could call it.

Next, this may be an issue with the GPF_RETRY_MAYFAIL should not
trigger OOM (although, when it fails, other allocations that happen at
that time and before the ring buffer can clean up, will cause an OOM).
I'll send an email to folks about this.

-- Steve
