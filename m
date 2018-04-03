Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755617AbeDCW4b convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753356AbeDCW4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:56:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48AE20CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 3 Apr 2018 18:56:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180403185627.6bf9ea9b@gandalf.local.home>
In-Reply-To: <20180403161119.GE5501@dhcp22.suse.cz>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
        <20180330102038.2378925b@gandalf.local.home>
        <20180403110612.GM5501@dhcp22.suse.cz>
        <20180403075158.0c0a2795@gandalf.local.home>
        <20180403121614.GV5501@dhcp22.suse.cz>
        <20180403082348.28cd3c1c@gandalf.local.home>
        <20180403123514.GX5501@dhcp22.suse.cz>
        <20180403093245.43e7e77c@gandalf.local.home>
        <20180403135607.GC5501@dhcp22.suse.cz>
        <20180403101753.3391a639@gandalf.local.home>
        <20180403161119.GE5501@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018 18:11:19 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> You can do so, of course. In fact it would have some advantages over
> single pages because you would fragment the memory less but this is not
> a reliable prevention from OOM killing and the complete memory
> depletion if you allow arbitrary trace buffer sizes.

You are right that this doesn't prevent OOM killing. I tried various
methods, and the only thing that currently "works" the way I'm happy
with, is this original patch.

>From your earlier email:

> Except that it doesn't work. si_mem_available is not really suitable for
> any allocation estimations. Its only purpose is to provide a very rough
> estimation for userspace. Any other use is basically abuse. The
> situation can change really quickly. Really it is really hard to be
> clever here with the volatility the memory allocations can cause.

Now can you please explain to me why si_mem_available is not suitable
for my purpose. If it's wrong and states there is less memory than
actually exists, we simply fail to increase the buffer.

If it is wrong and states that there is more memory than actually
exists, then we do nothing different than what we do today, and trigger
an OOM.

But for the ring buffer use case, it is "good enough". Can you
please explain to me what issues you see that can happen if we apply
this patch?

-- Steve
