Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F4EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63A823F8E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ddih+1Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63A823F8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754127AbeFVJZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:25:59 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50511 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeFVJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:25:57 -0400
Received: by mail-it0-f66.google.com with SMTP id u4-v6so2018962itg.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yozavAgaJtd/Hy70ZPpt0J6KyJ6kBhtto8TXrqp+e0A=;
        b=Ddih+1Tig2dI3YX0fCMTchQ3QdD/FzI5jSjIe9BtIT1f7fzDKRanI/XK0sRa3Mf4VM
         im6Qfot6bHzmpV6gXaKU6r1w8O8EAfpK5cmj8UW2LfnBt+pSdd+/JRUvCa/0uPbrdzCm
         NV0wiDmA0hpKN+4SteQO7gSdB8Qs0QrnLNR9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yozavAgaJtd/Hy70ZPpt0J6KyJ6kBhtto8TXrqp+e0A=;
        b=jjCHRVnY00eZZgS6AF1t4E6z7/ef6Vu77b2/WGnbnu6rBleBv/9yUxQ0Ue1zNUPUAW
         m/aY9a3+iikm7jsG8xQeNV1fm6B2fRTb68mdR7aqWUiRTts5PIYob5QzAvc07VYLF+YY
         p6C/SV1eQW16W00ZL/Up1XWkFNKKIYBqdblnsejKH2tL3C/Hday2Q/YgrcWBVPiGMonn
         yEV0f/pnF7OyzAFomKZcDH7dQmuFroBOhDBtnMN4kXwW2C454NKG741AffVS3jXbs/tp
         rR7f8urj2hWNdeFuv15mvENkY85rRCnNIzOEU0Ws6pKan47+i54MwdeEnWmSTiuOb7Bx
         Doig==
X-Gm-Message-State: APt69E3hda4hWnwkYAfkhEbaToeWwzKmlgmhxdPrbiOJh1/SF192nMTM
        3JsBbYVXnd+NxraFawyIdQ83fl6uHTVONBvEcnQ=
X-Google-Smtp-Source: ADUXVKI9Fu/3rkyIcUlBK1ODJbs3I0MCOrAZyBLK1o8AM8yvsqCMkrkCpg1LOLnsia6DkYm6jexeSvfzOCfRu6kdoCs=
X-Received: by 2002:a02:430c:: with SMTP id s12-v6mr632228jab.72.1529659556821;
 Fri, 22 Jun 2018 02:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180622082752.GX11011@yexl-desktop>
In-Reply-To: <20180622082752.GX11011@yexl-desktop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jun 2018 18:25:45 +0900
Message-ID: <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com>
Subject: Re: [lkp-robot] [fs] 3deb642f0d: will-it-scale.per_process_ops -8.8% regression
To:     kernel test robot <xiaolong.ye@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Added Al, since this all came in through his trees. The guilty
authors were already added by the robot ]

On Fri, Jun 22, 2018 at 5:31 PM kernel test robot <xiaolong.ye@intel.com> wrote:
>
> FYI, we noticed a -8.8% regression of will-it-scale.per_process_ops due to commit:

Guys, this seems pretty big.

What was the alleged advantage of the new poll methods again? Because
it sure isn't obvious - not from the numbers, and not from the commit
messages.

The code seems to be garbage. It replaces our nice generic "you can do
anything you damn well like in your poll function" with two limited
fixed-function "just give me the poll head and the mask".

I was assuming there  was a good reason for it, but looking closer I
see absolutely nothing but negatives. The argument that keyed wake-ups
somehow make multiple wake-queues irrelevant doesn't hold water when
the code is more complex and apparently slower. It's not like anybody
ever *had* to use multiple wait-queues, but the old code was both
simpler and cleaner and *allowed* you to use multiple queues if you
wanted to.

So the old code is simpler, cleaner, and more flexible. And according
to the test robot, it also performs better.

So I'm inclined to just revert the whole mess unless I get some
serious explanations for what the supposed advantages are.

The disadvantages are obvious: every poll event now causes *two*
indirect branches to the low-level filesystem or driver - one to get
he poll head, and one to get the mask. Add to that all the new "do we
have the new-style or old sane poll interface" tests, and poll is
obviously more complicated.

Quite frankly, when I look at it, I just go "that's _stupid_". I'm
entirely  missing the point of the conversion, and it's not explained
in the messages either.

If we could get the poll head by just having a direct pointer in the
'struct file', maybe that would be one thing. As it is, this all
literally just adds overhead for no obvious reason. It replaced one
simple direct call with two dependent but separate ones.

                Linus
