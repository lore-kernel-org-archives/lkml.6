Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B74AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F5A2190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfBGOwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:52:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfBGOwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:52:01 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C2B521872;
        Thu,  7 Feb 2019 14:51:59 +0000 (UTC)
Date:   Thu, 7 Feb 2019 09:51:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v7 2/3] arm64: implement ftrace with regs
Message-ID: <20190207095157.3dea1086@gandalf.local.home>
In-Reply-To: <198550d8-78d4-6e30-0179-b5e07dd140f8@arm.com>
References: <20190118163736.6A99268CEB@newverein.lst.de>
        <20190118163908.E338E68D93@newverein.lst.de>
        <e206e229-7813-2d37-d5c6-7a9785e311c9@arm.com>
        <20190206150524.GA28892@lst.de>
        <198550d8-78d4-6e30-0179-b5e07dd140f8@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2019 10:33:50 +0000
Julien Thierry <julien.thierry@arm.com> wrote:

> I don't see really much documentation on that function. As far as I can
> tell it is only called once for each site (and if it didn't, we'd always
> be placing the same instruction, but I agree it wouldn't be nice). It
> could depend on how far you can expand the notion of "adjusting" :) .
> 
> Steven, do you have an opinion on whether it would be acceptable to
> modify function entry code in ftrace_call_adjust() ?

Just to make sure I'm on the same page as you are. You want to modify
the function entry code at the time of the ftrace_call_adjust()?

I would update the rec->ip to the offset you want at
ftrace_call_adjust() but not do any modifications. It really isn't safe
to do it there. But right after that is called, you will have the arch
specific call of ftrace_make_nop() called with MCOUNT_ADDR as the
second parameter to let you know that this is the first time the call
is made at this address. This is where you can do that initial
modifications.

-- Steve
