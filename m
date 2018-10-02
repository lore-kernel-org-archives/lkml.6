Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F633C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9D82083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RSnx5yMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9D82083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbeJBKMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:12:53 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45245 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbeJBKMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:12:53 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id cf0a2c62;
        Tue, 2 Oct 2018 03:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=fYAcjMZps57+KOGwlbb7IWoHMvE=; b=RSnx5y
        Mc0P0EU99CbLn5ZSp6I02xkVQ3oDMPdEF6XQ7XKp5GvS4A2ACeCoeaVst5hbZpgN
        FnfzajiQpe60X24say5OyMZjMqkyXQ+6u8dm1buegdc0gh8EQAS5LbJDi2xMySZC
        HbtxQ88iZOcz08cmKtwWTYDm3nzHhkiGsy+0aqnbdg7EB/12iIKdN8efH0vfGWBh
        bXe9y+EaNzRqDWiaxKk/0sfgqW6ihaXlNpLPm4RWlNAdJrOljxE5UiDKj+Vm0O8o
        34J5OaIG/Xk3mJ9LMGlpCMGebdw3HBzVqNoH1S9LBmpnhDXfZCS93aBPqEyLo3k9
        3WdD8ctG1sux9EYg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fddd901f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 2 Oct 2018 03:31:48 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id 36-v6so499048oth.11;
        Mon, 01 Oct 2018 20:31:48 -0700 (PDT)
X-Gm-Message-State: ABuFfoiShLX6fJKKiJHMj0hgJ0YgBLcp5AM2IC3oVP45upLyIWFMXS3M
        Bhb/nr6nc46O6wZ+OImczObMc0QkupRnzy5V2hs=
X-Google-Smtp-Source: ACcGV60ajnlhlyt54kSrjdXaL4GFO//K0P+FtX1vv1MAwzoLESJFpGkaHSxC7GjPO8lFmT6a0qZYHuw7G+kpRAOat2g=
X-Received: by 2002:a9d:11f7:: with SMTP id y52-v6mr7916484oty.143.1538451107980;
 Mon, 01 Oct 2018 20:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-22-Jason@zx2c4.com> <20181002032609.o5i2hmphuqtkqgc4@gondor.apana.org.au>
In-Reply-To: <20181002032609.o5i2hmphuqtkqgc4@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 05:31:36 +0200
X-Gmail-Original-Message-ID: <CAHmME9rfd9wFOFNxaC23nAtGtjOUZGOYUwJKHS35iFwT8DYuwg@mail.gmail.com>
Message-ID: <CAHmME9rfd9wFOFNxaC23nAtGtjOUZGOYUwJKHS35iFwT8DYuwg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 21/23] crypto: port ChaCha20 to Zinc
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Tue, Oct 2, 2018 at 5:26 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Oh nice, so you did the conversion of the existing crypto code.
>
> I presume someone has done the numbers and verified that there
> is no performance regression?
>
> If so it would be good to include those numbers somewhere in this
> submission (within a patch description so that it goes into git).

Indeed I've done a pretty ridiculous amount of benchmarking, and the
x86_64 numbers are included in those commits because they're pretty
straightforward to show. The performance is also better on
arm1176,cortex-a7,8,9,15,53,73. On mips, as well, performance is
better, since there wasn't any optimized code there at all. Early
versions of this patchset included a regression on cortex-a7, which
was particularly problematic because Eric Biggers recent fscrypt work
requires fast chacha on that hardware, but this v6 (and the future v7)
contain code that is faster on all platforms across the board.

Regards,
Jason
