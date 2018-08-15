Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730CCC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214F12154E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ePCaItHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214F12154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeHOXu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:50:27 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38907 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeHOXu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:50:26 -0400
Received: by mail-yw1-f67.google.com with SMTP id r3-v6so1875826ywc.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bTNVJAMjXkljxYvMVSkLhToG62VWlCP5thIWKqOyyXo=;
        b=ePCaItHs6r6oGKMj8tA/fIx5+X4bvZ0Yj9N9nlB1veat0b2PcBZXnOUuzg5ACUm6Te
         FcNFigx/6Duv0qCsAfbwi37LnEt0923DsiyHU5R3K87WxE5sOKvSPL3U88B7Mob613nZ
         MzFb4qhD04m0yB79qSK20pWxhKbgSd9RStVXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bTNVJAMjXkljxYvMVSkLhToG62VWlCP5thIWKqOyyXo=;
        b=o7CtutY2uDPaEQ2jip0Y6/3gc/wGRsuLA7XGqyVd7FjBBovGdDICKoazKOsD6JTIDn
         Hp8sw1GtUp00PS4pP4wZnuz6tQ4HevJf+jqFA80V1IW/U74yR70/2OzjvtRxm8+G29xe
         8lUaZhMxjpGQe5SknyKOzmUPrMly7m2JASuoYfd47aTPo74JBMIvrbOJcvdESsEklGmz
         vV0/LJamHOvyJxDjSpBUhzvRtTSHcCaZbu22X6p+dOY4Ybly6MeVJ1zQmnRtaWXEHA26
         5kQuM66B7qYe64k36l6ZgTHVreplR1yTUf3U4qV/1H9b607OBVZH2olbKedEphe5co/n
         aLlw==
X-Gm-Message-State: AOUpUlEsHQzfYQ42Rp4wFcR2Sp0btF5j/uS40aJ8hC2GbVKVJlCW/YUX
        TEG9hteT3NPKC+QBSxvH/onBCIkhcC0=
X-Google-Smtp-Source: AA+uWPyDRYwguMu2+anovD78trwzhNkmnuhTwy5lAQhi9ya4m+OPk1qzZ7xnOuuIcrlIhfmf8C8yZQ==
X-Received: by 2002:a25:9705:: with SMTP id d5-v6mr12335782ybo.77.1534366597257;
        Wed, 15 Aug 2018 13:56:37 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id h10-v6sm5923723ywa.35.2018.08.15.13.56.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 13:56:35 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id z143-v6so1869044ywa.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:56:35 -0700 (PDT)
X-Received: by 2002:a25:15ca:: with SMTP id 193-v6mr16169286ybv.484.1534366594557;
 Wed, 15 Aug 2018 13:56:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5092:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 13:56:33
 -0700 (PDT)
In-Reply-To: <CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com>
References: <20180813214328.GA15137@beast> <CA+55aFw5Tkn6DgkAZS-UGOjJpYp2R4rFAm9ixu_=FONeqRyofg@mail.gmail.com>
 <CAGXu5jK_w7JRywdQ78FfQxeLSMmXbvyDDnaYzj27=y8wnAzKxQ@mail.gmail.com>
 <CA+55aFyFCWH3YJnRUKtSzs9Mvny0eU+=QANxoPTE+9B9CkUWDw@mail.gmail.com>
 <CAGXu5jJ1JNSxJABUTAO85z_hXjSkjD=nWEho7KrYJTqqVGivig@mail.gmail.com> <CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 15 Aug 2018 13:56:33 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Yv9Bu4mJPOfkpxrom91kSKaUESHR-Tn1CAJCTTZy_8w@mail.gmail.com>
Message-ID: <CAGXu5j+Yv9Bu4mJPOfkpxrom91kSKaUESHR-Tn1CAJCTTZy_8w@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugin updates for v4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 1:18 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I absolutely refuse to take any hardening patches at all that have
> BUG() or panic() or similar machine-killing in it.

Okay, mental model adjusted. :) It was only "strong discouraged" until now.

> I thought VLA's were mostly gone.

Yes. Out of the ~115 instances we counted when we started with v4.16,
we've chipped away at them pretty steadily. Right now there are two
"one-off"s that haven't been picked up by maintainers:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=vla/leftovers

and the remaining series against crypto, for which I am waiting on
further review for Herbert. All the really odd-ball crypto cases have
been handled (and are up for the merge window for v4.19), but there's
still some minor changes that Herbert is examining:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=vla/crypto

And after that, there's a single patch to move -Wvla up into the
top-level Makefile:

https://patchwork.kernel.org/patch/10489873/

So, we're basically done, but the timing with the merge window wasn't
great since crypto continues to get tweaked and has taken much longer
than I had expected.

-Kees

-- 
Kees Cook
Pixel Security
