Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D04260764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeFFNCc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:02:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50111 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeFFNCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:02:31 -0400
Date: Wed, 6 Jun 2018 15:02:20 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Tobin C. Harding" <me@tobin.cc>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] enable early printing of hashed pointers
In-Reply-To: <1527472002-11571-1-git-send-email-me@tobin.cc>
Message-ID: <alpine.DEB.2.21.1806061501130.1579@nanos.tec.linutronix.de>
References: <1527472002-11571-1-git-send-email-me@tobin.cc>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018, Tobin C. Harding wrote:

> Currently printing pointers early in the boot sequence can result in a
> dummy string '(____ptrval____)' being printed.  While resolving this
> issue it was noticed that we can use the hw RNG if available for hashing
> pointers.
> 
> Patch one and two do the ground work to be able to use hw RNG removing
> from get_random_bytes_arch() the call to get_random_bytes() and
> returning the number of bytes of random material successfully returned. 
> 
> Patch three uses the hw RNG to get keying material if it is available.
> 
> Patch four further assists debugging early in the boot sequence for
> machines that do not have a hw RNG by adding a command line option
> 'debug_boot_weak_hash'.  If enabled, non-cryptographically secure hashing
> is used instead of siphash so we can hash at any time. 
> 
> During the versions of this set I have been totally confused about which
> patches go through which tree.  This version again puts all 4 patches
> together in the hope they will go through Andrew's tree.
> 
> 
> Steve,
> 
> Could you please take a quick squiz at the final 2 patches if you get a
> chance.  I assumed we are in preemptible context during early_init based
> on your code (and code comment) and called static_branch_disable()
> directly if hw RNG returned keying material.  It's a pretty simple
> change but I'd love to get someone else to check I've not noob'ed it.

early_initcalls() are not that early :) They run in thread context fully
preemtible so calling static_branch_disable() is perfectly fine.

Thanks,

	tglx
