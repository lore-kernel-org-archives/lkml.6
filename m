Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94CCC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2120866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF2120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=guarana.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIMKKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:10:54 -0400
Received: from aws.guarana.org ([13.237.110.252]:49608 "EHLO aws.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbeIMKKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:10:54 -0400
Received: by aws.guarana.org (Postfix, from userid 1006)
        id BFD2BA146F; Thu, 13 Sep 2018 05:03:01 +0000 (UTC)
Date:   Thu, 13 Sep 2018 05:03:01 +0000
From:   Kevin Easton <kevin@guarana.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
Message-ID: <20180913050301.GA26367@ip-172-31-15-78>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78>
 <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 08:10:41PM +0200, Jason A. Donenfeld wrote:
> On Wed, Sep 12, 2018 at 8:14 AM Kevin Easton <kevin@guarana.org> wrote:
> > Given that it's always supposed to be used like that, mightn't it be
> > better if simd_relax() took a pointer to the context, so the call is
> > just
> >
> >     simd_relax(&simd_context);
> >
> > ?
> >
> > The inlining means that there won't actually be a pointer dereference in
> > the emitted code.
> >
> > If simd_put() also took a pointer then it could set the context back to
> > HAVE_NO_SIMD as well?
> 
> That's sort of a neat idea. I guess in this scheme, you'd envision:
> 
>    simd_context_t simd_context;
> 
>    simd_get(&simd_context);
>    simd_relax(&simd_context);
>    simd_put(&simd_context);
> 
> And this way, if simd_context ever becomes a heavier struct, it can be
> modified in place rather than returned by value from the function. On
> the other hand, it's a little bit more annoying to type and makes it
> harder to do declaration and initialization on the same line.

Yes.  It's also how most get/put APIs already work in the kernel, eg
kref_get/put (mostly because they tend to be 'getting/putting' an
already-initialized object, though).

    - Kevin
