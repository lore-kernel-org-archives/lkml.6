Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A8ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA9D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VhkMLEas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA9D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeIRJ5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 05:57:09 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42257 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeIRJ5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 05:57:09 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 9605ed8c;
        Tue, 18 Sep 2018 04:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=D7Uzhp+5+NKP4ThN6D5+3feNz0k=; b=VhkMLE
        asnUT/haZcry4+BDDECLpTYYkmB/UkhmjWRF685z3qlldHGwtZiKOvj17Yos81G7
        Fn/GKcHA6JLFexNStqF2W9bFCxG0IhryXzx7s0yL5+nFztu/7xTDKq1AI9a8tpRf
        7TmxVwhsQq/VzAbONZeLI5x5I5W3pkz1bFU0z2fE/d7m/rlycnrDIMSCQ8Av8bvC
        vXwnSS2FwATuf2wwZL6XWDY9g/6dA6TQkNCNjqLkOuSQZ4rJmLRQ2u5Gy29NM0pX
        ffZ4CfNcv0IB43L0epzDe9a7SEk9XzmorDDV9fLBWd1E1tcdDhDSQ6EHCfLaKmJm
        yfW7CGiUcrD8VREw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 86493a8b (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 18 Sep 2018 04:08:53 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id e18-v6so587436oti.8;
        Mon, 17 Sep 2018 21:26:24 -0700 (PDT)
X-Gm-Message-State: APzg51C/yQbL1M4q8c4csjNbr9c5tadS1Wfi8/yozIwuu3+SAuxcj6nK
        XLcmoeQM9Km6cPod6zr+OXTRp40BnU9/e+i9t64=
X-Google-Smtp-Source: ANB0VdaY7ZO02Ix7FZNB44wEvng6/9X9F7GqQEFmoZAKvewSjSdWHxkA95sdxA/HRs4fWM9GpDLKAwTLjO9d4UJwXT8=
X-Received: by 2002:a9d:51d0:: with SMTP id d16-v6mr15361829oth.384.1537244783640;
 Mon, 17 Sep 2018 21:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qwRzuoo-3Hxahwu=Li2LCz06Uowaq1GFmkts6tsffM7w@mail.gmail.com>
 <20180918042133.4ybztgdooxkoyiru@gondor.apana.org.au>
In-Reply-To: <20180918042133.4ybztgdooxkoyiru@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 Sep 2018 06:26:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9rthEDfL7=xNsafZfcL_N0SrB-VKrBWiZMWTQ2bd=gUvw@mail.gmail.com>
Message-ID: <CAHmME9rthEDfL7=xNsafZfcL_N0SrB-VKrBWiZMWTQ2bd=gUvw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Tue, Sep 18, 2018 at 6:21 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> That may be your view but from what I've read Ard has been very
> constructive in pointing out issues in your submission.
> Please keep in mind that this is a large project that has to support
> multiple users on one hand (not just WireGuard) and complex hardware
> acceleration drivers on the other.  Ard has been one of the most
> prolific contributors to the crypto code and his review should be
> taken seriously.

I'm well aware, which is why I also wrote:

"I do sincerely hope these are only fears and not what actually is
going on. I'll do my best to take into serious consideration what you
say -- many are indeed extremely helpful"

Worry not, I've been working around the clock to implement suggestions
from Ard and from others.

I'll be submitting v5 fairly soon, which will probably be a good spot
for you to review as well, if you're interested. I'm just going to
give kbuild testbot a few more hours on it first.

Regards,
Jason
