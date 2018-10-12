Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237DFC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FD820835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="ZxItNO8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FD820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeJLWCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:02:00 -0400
Received: from imap.thunk.org ([74.207.234.97]:38744 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeJLWB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zi31qG3qH9AZyZHEVqdwHwXbr9/mGY3toZbBL2IPqwk=; b=ZxItNO8Ix2rX4Vv7qKG5V4v/WX
        yXr12xS9h/i1RzkB47+Xd4/pDqf2ot0tR18Q2sFU+iQWNsCxeonHpxnHXy5xxbWpFeE9/fMRethy2
        bbC1hqmyagzGScWVdTevH6Z44ko68pvfIhscroNV9fFCuk8zqN8DON9jouxYkUgA5GnQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gAyR5-0007iN-A3; Fri, 12 Oct 2018 14:29:03 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 40DD77A519B; Fri, 12 Oct 2018 10:29:02 -0400 (EDT)
Date:   Fri, 12 Oct 2018 10:29:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Move rand_initialize() earlier
Message-ID: <20181012142902.GD2420@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181011225421.GA21093@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011225421.GA21093@beast>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 03:54:21PM -0700, Kees Cook wrote:
> Right now rand_initialize() is run as an early_initcall(), but it only
> depends on timekeeping_init() (for mixing ktime_get_real() into the
> pools). However, the call to boot_init_stack_canary() for stack canary
> initialization runs earlier, which triggers a warning at boot:
> 
> random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0
> 
> Instead, this moves rand_initialize() to after timekeeping_init(), and moves
> canary initialization here as well.
> 
> Note that this warning may still remain for machines that do not have
> UEFI RNG support (which initializes the RNG pools durting setup_arch()),
> or for x86 machines without RDRAND (or booting without "random.trust=on"
> or CONFIG_RANDOM_TRUST_CPU=y).
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

This seems reasonable to me.  Were you hoping to get this in for -rc8?
It looks sane, and I don't see any _obvious_ unintended consequences
of such a change, but it's rather late in the development cycle, and
it isn't regression fix.

My druthers would be wait until -rc2, as a minor low-risk improvement
that goes in after the merge window, although some people are of the
belief that -rc2 should be a strict feature freeze delimiter.  My
personal opinion is no major feature changes except during the merge
window, and we go into bug-fix only mode after -rc4, and by -rc6 it's
regression and major security fixes only.  (This is however not a
universally held opinion; see the "bug-introducing patches" thread
which Sasha started on the ksummit-discuss thread.)

					- Ted
