Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC83C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654EF2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YISzfON8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654EF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeK1Tbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:31:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38986 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeK1Tbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:31:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id n133so1611195wmd.4;
        Wed, 28 Nov 2018 00:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NS8j9FrTVdWYku83q3c/NqGgj6+3GZEWOAxQuUEHrsI=;
        b=YISzfON8r/nJdCEjALfTr9tNJZZV+10jaS606WHWNWcW5CkbTIp3Vmo3HXQwLUt4ko
         3B+yU2Luzp02EwM0tb4MTuCG3dIJ5r4wwFyb4VVkIvAo00I8sqMu3Gj9/fN9Hc/zE8o1
         h0yQpXyk33rGZPzDjstbHnVY8mCqd7Pcaj50jW5aRic98W9qMJuYrNKe+PWMcPIO/bxS
         35dci8/+lfV22TuKd+5mOclxmmXre2FN8ZfigOtUWkmgJ7o6OCv/tvaIsezIUZer5mJ8
         kjLH4jmCfAOO5ExLeuhuNrCiXanezpKcuURMRGMXctelppw4djutz0GSNNublFDcQkJv
         xcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NS8j9FrTVdWYku83q3c/NqGgj6+3GZEWOAxQuUEHrsI=;
        b=iT1qdboVPo7W+7alRk2F7gO5U+44H87jBhTjNfrMu2h1StSlBpRhuuwszi0cqPMbq+
         q17xUV9R7MA5OpHRRCLnt+LRKJ4h9U+MnE1qgbMCkiQC0ocPfW7Je6+RPK0vep9CpZrg
         w+5CVqMXTr5E6M889fCS41mP8enGV3bHKyiMy8FewOd62NbuN3JxSaUovgTIfR9sLOhG
         Lmi/74kAHTzGDhR9eUI9C0O2Wq8mRNOUK+AXP8u5x3d9b+2InOcuABrvfQkdv5O8Cuf2
         Smvpx/HF0SYtq7nThzVEDNPEfTI6xbw03iYav0apOt9ePz/rcEaRTPrZtvNAemCPBU0l
         TO0Q==
X-Gm-Message-State: AA+aEWbDfEeqseNgXDrwKK8urEQ875vXpPLJ8jQTpMrlupJblw56tng6
        5XgYjWp9+7NqSxTK9n1/ptA=
X-Google-Smtp-Source: AFSGD/Ug3h7sKFsRFcv2BudXPSZAAogCTn8KHaq5Q7IdFHHTKTig9GqmY6EU0jCg2p8J8rWyJWuQSg==
X-Received: by 2002:a1c:d988:: with SMTP id q130mr1883884wmg.41.1543393861120;
        Wed, 28 Nov 2018 00:31:01 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q125sm1177385wme.33.2018.11.28.00.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 00:31:00 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:30:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, will.deacon@arm.com,
        linux-tip-commits@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [tip:locking/core] locking/atomics: Check generated headers are
 up-to-date
Message-ID: <20181128083057.GA7879@gmail.com>
References: <20180904104830.2975-6-mark.rutland@arm.com>
 <tip-8d32588077bdc390420cfa6946f407033a20d7a8@git.kernel.org>
 <20181121080258.GA56691@gmail.com>
 <20181121114028.iiuleuwuayednvut@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121114028.iiuleuwuayednvut@salmiak>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> > Could we please get this fixed so that proper dependencies are checked 
> > and it's only regenerated when needed? This slowdown makes additive-build 
> > kernel development quite painful, as ~5 seconds is in the 'too long' 
> > category already, while 1.2 seconds is basically instantaneous.
> 
> Just to check, are we happy to eat the full cost for the first build of a
> pristine tree?

No, not happy to add 3-4 seconds to a full build that usually takes less 
than 60 seconds. This stuff isn't parallelized nor particularly well 
optimized it appears.

This *must* get faster.

> One reason we do the check rather than (re-)generating the headers is 
> that Linus requested [1] the generated header be committed so that they 
> show up in git grep, but it looks like he was happy to be flexible on 
> that.

I think the generated headers should be part of the commit space, the 
grepping is important.

> If we're happy to not commit in the generated headers, and if we're happy to
> pay the cost for a pristine tree, that's fairly straightforward to do.
> Otherwise, this has to be an optional check.

Or faster code, or a different concept!

Thanks,

	Ingo
