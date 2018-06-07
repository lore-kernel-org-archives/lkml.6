Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id A5iHHFSHGVtYRwAAmS7hNA
	; Thu, 07 Jun 2018 19:28:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 63D1B6074D; Thu,  7 Jun 2018 19:28:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A08406063F;
	Thu,  7 Jun 2018 19:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A08406063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeFGT2R (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:28:17 -0400
Received: from namei.org ([65.99.196.166]:58522 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbeFGT2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:28:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w57JS1dr007551;
        Thu, 7 Jun 2018 19:28:01 GMT
Date: Fri, 8 Jun 2018 05:28:01 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Kees Cook <keescook@chromium.org>
cc: Eric Biggers <ebiggers3@gmail.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Tycho Andersen <tycho@tycho.ws>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] dh key: fix rounding up KDF output length
In-Reply-To: <CAGXu5jJf-cW8WkwMoPZT8zM2aUoO6P-EQs7MK6_uUTneZr0ehA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1806080527570.7465@namei.org>
References: <0000000000009c221d056e0cf53a@google.com> <20180607191201.97080-1-ebiggers3@gmail.com> <CAGXu5jJf-cW8WkwMoPZT8zM2aUoO6P-EQs7MK6_uUTneZr0ehA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018, Kees Cook wrote:

> On Thu, Jun 7, 2018 at 12:12 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Commit 383203eff718 ("dh key: get rid of stack allocated array") changed
> > kdf_ctr() to assume that the length of key material to derive is a
> > multiple of the digest size.  The length was supposed to be rounded up
> > accordingly.  However, the round_up() macro was used which only gives
> > the correct result on power-of-2 arguments, whereas not all hash
> > algorithms have power-of-2 digest sizes.  In some cases this resulted in
> > a write past the end of the 'outbuf' buffer.
> >
> > Fix it by switching to roundup(), which works for non-power-of-2 inputs.
> 
> round_up() vs roundup(). Wow, that's not confusing. :( I wonder if we
> should rename the former to roundup_pow2() or something?

Good idea, in a separate patch(set).

-- 
James Morris
<jmorris@namei.org>
