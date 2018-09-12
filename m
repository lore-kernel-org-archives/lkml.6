Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C1FC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1EE2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="22FfCOBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1EE2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeILXWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:22:34 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35837 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeILXWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:22:33 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3997b760;
        Wed, 12 Sep 2018 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=pW2l5eTCxfnepjG4/hTF5qZPeOE=; b=22FfCO
        Bb+PEH2F1fuqj5SJ08xg/fJ9EykgvmBxYujQWjelosRXvTCX48BjJLI0E58dHMyO
        qJv+QrEUcldsQcP1M8qHOQAgdKjBiBryv8PEtRxCORGgP5W2+JtvzjRnimP0sK5A
        wRo61rr5nqvIr+cWaLgz8NN6VCU/GknjgQezsei5X7O+jaAdhteusS1xBipzUK3O
        P9lqZDURjLQtiu4AhHCHzBU7BtKlGKNaFbzItBXf9hl95JVyTeS1kMQJUO5ZunM6
        8TcQI/sZROaX1woY4Kfx2W9wthP/kgqoHZcUHK2PSHDi31wmnkx7u3och8cFwF8K
        jyZandUNDk36Z+bw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 097019e3 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 12 Sep 2018 18:00:00 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id v198-v6so5611258oif.9;
        Wed, 12 Sep 2018 11:16:49 -0700 (PDT)
X-Gm-Message-State: APzg51DL6V4PNGTQaGx+ZusMBo1qiuf687PCs9Z1+vrzfpqa/5JrSNXm
        idooQF8XcjMrGewH99sDd1O3UAwVyPfTHrbTjSk=
X-Google-Smtp-Source: ANB0VdYU3IJ9xz7iCAT02NTixJMgE8Fc/CM1lDIeRx8aCbHgxDfoMy0+axTq3wVNwQra+KBPiYjFWfvULkIBlurkbaw=
X-Received: by 2002:aca:dc82:: with SMTP id t124-v6mr3138934oig.189.1536776208737;
 Wed, 12 Sep 2018 11:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com> <20180911220849.GC81235@gmail.com>
In-Reply-To: <20180911220849.GC81235@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Sep 2018 20:16:37 +0200
X-Gmail-Original-Message-ID: <CAHmME9rxrC+CAR-xoXd-bZO1HYZ+TjvT_K4xgQwWXE53zi61xQ@mail.gmail.com>
Message-ID: <CAHmME9rxrC+CAR-xoXd-bZO1HYZ+TjvT_K4xgQwWXE53zi61xQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, Sep 12, 2018 at 12:08 AM Eric Biggers <ebiggers@kernel.org> wrote:
> I'd strongly prefer the assembly to be readable too.  Jason, I'm not sure if
> you've actually read through the asm from the OpenSSL implementations, but the
> generated .S files actually do lose a lot of semantic information that was in
> the original .pl scripts.

The thing to keep in mind is that the .S was not directly and blindly
generated from the .pl. We started with the output of the .pl, and
then, particularly in the case of x86_64, worked with it a lot, and
now it's something a bit different. We've definitely spent a lot of
time reading that assembly.

I'll see if I can improve the readability with some register name
remapping on ARM. No guarantees, but I'll play a bit and see if I can
make it a bit better.

Jason
