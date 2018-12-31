Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA4AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4C521019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 22:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546296351;
	bh=K0f2TV4mk9Hwn6iw+w10KgqmpadwSQ60ON7zVh6vN8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PXsw3W8OBQs9WO4/LdO/51KApMFj9eIdd4C0y45d9LD41em3RRhTu7AFHw9zlKGpj
	 OUHDZfUCeRdpgbMHGItK/FSoq7/i7m9hzsf/VQaZcygdyA79ClvZIg92Ps6TKO0DSK
	 rtiVbMp2NhyF5N7Ef5SuKspUI/9gV6ooRbr7pxlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeLaWpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbeLaWpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 17:45:36 -0500
Received: from zzz.localdomain (h184-61-154-48.mdsnwi.dsl.dynamic.tds.net [184.61.154.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3134621019;
        Mon, 31 Dec 2018 22:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546296335;
        bh=K0f2TV4mk9Hwn6iw+w10KgqmpadwSQ60ON7zVh6vN8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGlTin3LD+bBgIYfuY8hFzElOjpmFIQs0bpc3jUL3kn8i3qfm1NT9eEm7zL8+3Mvy
         BFs61DNBH3J6lowQ8JcSnHgqHizDN/eptcaSv4IiOqaOuh4HDmjWMbjLzV1j/KQfKE
         UbDcQaYxytjENW0T6Kv9an97bEAiQJs9s0atkv/M=
Date:   Mon, 31 Dec 2018 16:45:31 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
Message-ID: <20181231224530.GA12425@zzz.localdomain>
References: <20181128232019.GC131170@gmail.com>
 <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
 <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
 <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
 <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
 <1545076260.2878.15.camel@HansenPartnership.com>
 <CAHk-=wjPhKNKRq24wXL3wvqUgfyriDjYNXUPCumbH=64ZMXrSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjPhKNKRq24wXL3wvqUgfyriDjYNXUPCumbH=64ZMXrSw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David and Linus,

On Mon, Dec 17, 2018 at 12:02:01PM -0800, Linus Torvalds wrote:
> On Mon, Dec 17, 2018 at 11:51 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > If this is to replace Eric's patch, didn't you want to set token_mask
> > to (1<<Opt_err)?
> 
> No, let's not add any extra code that is trying to be subtle. Subtle
> interactions was where the bug came from.
> 
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
> 
> But it *is* an example of how bogus all of this stuff is. Clearly
> people weren't really paying attention when writing any of this code.
> 
>                         Linus

KEYCTL_PKEY_QUERY is still failing basic fuzzing even after Linus' fix that
changed Opt_err from -1 to 0.  The crash is still in keyctl_pkey_params_parse():

		token = match_token(p, param_keys, args);
		if (__test_and_set_bit(token, &token_mask))
			return -EINVAL;
		q = args[0].from;
		if (!q[0])
			return -EINVAL;

Now it crashes on '!q[0]' because 'args[0].from' is uninitialized when
token == Opt_err.  args[0] is only initialized when the parsed token had a
pattern that set it.

David, where are the tests for these new keyctls?

- Eric
