Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D77C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D87206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfBVViq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:38:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:58590 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVViq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:38:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EFB5614ABC727;
        Fri, 22 Feb 2019 13:38:44 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:38:42 -0800 (PST)
Message-Id: <20190222.133842.1637029078039923178.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     alexei.starovoitov@gmail.com, mhiramat@kernel.org,
        rostedt@goodmis.org, luto@amacapital.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, stable@vger.kernel.org,
        changbin.du@gmail.com, jannh@google.com, keescook@chromium.org,
        luto@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
        <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
        <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Feb 2019 13:38:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Feb 2019 13:20:58 -0800

> On Fri, Feb 22, 2019 at 11:27 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
>> and users pass both user and kernel addresses into it and expect
>> that the helper will actually try to read from that address.
> 
> As mentioned earlier in the thread, that's actually fundamentally broken.
> 
> There are architectures that have physically separate address spaces,
> with the same pointer value in both kernel and user space.
> 
> They are rare, but they exist. At least sparc32 and the old 4G:4G split x86.

And sparc64.

> So a pointer really should always unambiguously always be explicitly
> _either_ a kernel pointer, or a user pointer. You can't have "this is
> a pointer", and then try to figure it out by looking at the value.
> That may happen to work on x86-64, but it's literally a "happen to
> work on the most common architectures", not a design thing.

Don't be surprised if we see more separation like this in the future too.

So it's not a smart thing to code against even if you can discount all of
the examples Linus gives above.
