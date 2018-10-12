Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9BBC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818472098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="nwLXll9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818472098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeJLWQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:16:50 -0400
Received: from imap.thunk.org ([74.207.234.97]:39144 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeJLWQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zML860ItB0gqPneybYVOtnk0sNr+MmFOXzCyTREAjPE=; b=nwLXll9Z+oIsBaKR66cIS1kG5O
        Qh1rNwl3EK71YQgAwD/v+0k3uxK3v2Fm7+PvsD/YVwTcO0MwR+7j9DpBzxRPRjXYCW93kfUvC9xDi
        ORdqFgjeHXe81Kc9CFP19og0H+JSIvJ16G0ehQ7BiRNZe1oqM1rWTWdwVx5ruBlbpRfI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gAyfR-0007m4-SG; Fri, 12 Oct 2018 14:43:53 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AA7107A519B; Fri, 12 Oct 2018 10:43:52 -0400 (EDT)
Date:   Fri, 12 Oct 2018 10:43:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        tcharding <me@tobin.cc>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] random: Move rand_initialize() earlier
Message-ID: <20181012144352.GE2420@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, tcharding <me@tobin.cc>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
References: <20181011225421.GA21093@beast>
 <CAK8P3a3N6txZf8tzTdLvLwByrsWQvN_JSabV2TGe+zZenMWWxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3N6txZf8tzTdLvLwByrsWQvN_JSabV2TGe+zZenMWWxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:42:39AM +0200, Arnd Bergmann wrote:
> I wonder if mixing in ktime_get_real() is flawed to start with:
> This depends on read_persistent_clock64() actually returning
> a meaningful time, but in many cases it does not; x86 being
> a notable exception.
> 
> We have three ways of setting the initial time:
> 
> * At early boot using read_persistent_clock64(). This may read
>   the time from the hypervisor (if any), and on some older
>   architectures that have a custom RTC abstraction, it
>   reads from the RTC directly. We generally move away from
>   the RTC method in favor of the proper rtc class interfaces
>   (see below)
> 
> * At late_initcall time, in rtc_hctosys(). If an RTC driver has
>   been loaded successfully at this time, it will be read from
>   there. We also move away from this.
> 
> * From user space, which reads the RTC time or NTP,
>   and then sets the system time from that.
> 
> The latter two end up in do_settimeofday64(), but there
> is no mixing in of the time into the random seed that I can
> see, and it's not clear whether there should be (it
> can be called with arbitrary times from user space,
> provided CAP_SYS_TIME permissions).

I think it adds some real value (although perhaps small) in the first
two cases.  In all of the cases, though, since we don't add any
entropy credit, it doesn't hurt to mix it in --- this is the same
argument why it's fine that /dev/[u]random can be world-writeable.
Mixing in user-controlled data is harmless, and if it's not visible to
a remote attacker, it can be helpful.

						- Ted
