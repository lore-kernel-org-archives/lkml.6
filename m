Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C548AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922F72133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="vrgs7plJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbeLQTvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:51:03 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59466 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbeLQTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:51:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4F6638EE1CB;
        Mon, 17 Dec 2018 11:51:02 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sErl1WIs9q2o; Mon, 17 Dec 2018 11:51:02 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 95B018EE0A4;
        Mon, 17 Dec 2018 11:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1545076262;
        bh=rbySyw3boEay55iMh/GbYF6swfAoUMJlbxA/55um2TI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vrgs7plJ0OGRACpVETeumGyQZndoFvPcMRM2UnH6HxO1l/qnXCGrJyVJlGUX8bEKR
         bkH/yvZy4Gt6cNCjugXmblwpXYHn+7SsMKvausj9WRvzUnB1f6kaeK6DinFKugyaQO
         ft8nuNttpte1qWyZ3eZ6g1LvfW8cVA4zOgiZgqg8=
Message-ID: <1545076260.2878.15.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Date:   Mon, 17 Dec 2018 11:51:00 -0800
In-Reply-To: <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
References: <20181128232019.GC131170@gmail.com>
         <20181217181244.220052-1-ebiggers@kernel.org>
         <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
         <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
         <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
         <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 11:39 -0800, Linus Torvalds wrote:
> On Mon, Dec 17, 2018 at 11:06 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > Honestly, for being about "security", all of this code seems to be
> > doing some really questionable things with all those Opt_xyz enums.
> 
> Yeah, at least security/keys/trusted.c ends up mixing that enum and
> just using "int" completely randomly, and you have datablob_parse()
> returning either a negative integer _or_ an "Opt_xyz" value, so
> having Opt_err be -1 is doubly confusing there (it would also be "-
> EPERM" depending on how you treat it).
> 
> There doesn't seem to be any _actual_ confusion (because Opt_err is
> always turned into an actual real error code), but it's  just another
> sign of "those enums should not be negative".
> 
> So on the whole, I think that the "Opt_err = -1" is a serious
> mistake, but at least for now, ima_policy.c clearly has (bogus) code
> that relies on it.
> 
> But the two cases that use "test_and_set_bit()" do not seem to have
> any reason to use that -1 enum, so while we can't do the "just remove
> -1" in general, I do think the proper fix is to just do it for those
> two files.
> 
> Eric, mind testing a patch like that? Untested patch attached just
> for completeness..

If this is to replace Eric's patch, didn't you want to set token_mask
to (1<<Opt_err)?

James

