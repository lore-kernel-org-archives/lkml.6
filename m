Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7BFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD38214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mJ6FPQ8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeLRAoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:44:25 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:33442 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbeLRAoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:44:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3D2358EE1CB;
        Mon, 17 Dec 2018 16:44:24 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F7V6TdXFDJAB; Mon, 17 Dec 2018 16:44:24 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 83AE58EE0A4;
        Mon, 17 Dec 2018 16:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1545093863;
        bh=UXoCsqDxGMQ26kVNzeM3o73fRnhRn/iTedhRTINLL5k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mJ6FPQ8ltN+n5tWXUmoj2Kr+fNzy9Rwrh39zjRKUB1uT+hiXfUkolxRr8my7hrt6u
         w9U7/EMJ1U2oOLsOjMBSWx8Do0T0OH0xoyprtlzOcUqMTtSpzBBQ8iwFpO+rJZh45c
         JAO7m9jTLMkDsvhueFcbsCZpd+mXb3XA6/eNthbw=
Message-ID: <1545093862.2878.34.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Date:   Mon, 17 Dec 2018 16:44:22 -0800
In-Reply-To: <CAHk-=wjPhKNKRq24wXL3wvqUgfyriDjYNXUPCumbH=64ZMXrSw@mail.gmail.com>
References: <20181128232019.GC131170@gmail.com>
         <20181217181244.220052-1-ebiggers@kernel.org>
         <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
         <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
         <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
         <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
         <1545076260.2878.15.camel@HansenPartnership.com>
         <CAHk-=wjPhKNKRq24wXL3wvqUgfyriDjYNXUPCumbH=64ZMXrSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 12:02 -0800, Linus Torvalds wrote:
> On Mon, Dec 17, 2018 at 11:51 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > If this is to replace Eric's patch, didn't you want to set
> > token_mask to (1<<Opt_err)?
> 
> No, let's not add any extra code that is trying to be subtle. Subtle
> interactions was where the bug came from.

Sure; I suppose liking the TPM gives me a taste for subtlety.

> The code already checks the actual Opt_xyz for errors in a switch
> statement. The token_mask should be _purely_ about duplicate options
> (or conflicting ones).
> 
> Talking about the conflicting ones: Opt_hash checks that
> Opt_policydigest isn't set. But Opt_policydigest doesn't check that
> Opt_hash isn't set, so you can mix the two if you just do it in the
> right order.
>
> But that's a separate bug, and doesn't seem to be a huge deal.

Actually, I'm afraid it's not a bug, it's a command line ordering
thing.  To check the policy digest length, we need to know which hash
algorithm you're using, so if you're specifying a hash algorithm, it
has to appear *before* a policydigest as a command input.

I take it this is another subtlety you'd like documenting ...?

> But it *is* an example of how bogus all of this stuff is. Clearly
> people weren't really paying attention when writing any of this code.

Hey, not going to argue here.  The whole policy session passed in is
questionable because some of the actions the kernel takes on the key
have to depend on what was in the policy (which you don't know and
can't deduce from the hash).  The only way to get it to work
universally is to pass the actual policy in and have the kernel
construct the policy session itself.  Fortunately fixing it can be low
priority because we don't seem to have any users.

James

