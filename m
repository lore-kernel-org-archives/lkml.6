Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BD2C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E6F20834
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="x4Ok1xWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E6F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbeJHADd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:03:33 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38625 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbeJHADd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:03:33 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 41abba6d;
        Sun, 7 Oct 2018 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Xatvoj2BDzUzcRdW2SLC5IWV5rc=; b=x4Ok1x
        WoCvQfXD8pvTmUajw7i2qmGhOx6zJTP0ibvDz661zSCR1vuNgFaCZd64n7TThZdf
        ByqwX19QntsYjHercBD65q+t+42D9s9OjUJXY8p4zu1jFC+2+ukbeaCaD9SPDIVA
        3EFOs284YYhlXzJ563CRWlqZlK8MhekYqwYQKAKaUq+FrVQ1SB5EY+lQVSQDst/g
        QQmIMiaa4dzr2nfLYl+3Y22B+yekcL9px+5uGlZBOorWfkfKkLWRL9ej4fMKAAWa
        cvcO6pXpGyBcA3KNKqCIbrfCoe3+hrd9+PFKnMt869/um90Ze6Dtm9aFilji2jaP
        fVhq2Hr+wGQahfwg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 50c9e5d4 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 7 Oct 2018 16:54:57 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id l58so2513029otd.6;
        Sun, 07 Oct 2018 09:55:38 -0700 (PDT)
X-Gm-Message-State: ABuFfohVs7dZh2AZNTYIgQC+ASp+oL/35+AHNU1AEdnSiup5Bd7gD5RO
        MqYLyJ0SQjy5COFFULXUiF0fIwNN9ymgLfWe07I=
X-Google-Smtp-Source: ACcGV62Vzir/bv7kT+Mhjt9JoAGsbJxRR4CRGABA7dTYqZrOFVf4XlHAke9j6QIKqvMqPUl06es0V0gYOtDb+HHaokk=
X-Received: by 2002:a9d:f9b:: with SMTP id d27mr10000490otd.225.1538931337440;
 Sun, 07 Oct 2018 09:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181006025709.4019-1-Jason@zx2c4.com> <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006235414.GA11773@lunn.ch> <CAHmME9ocMekP+jauihMGKq04to0_jQTjhv=r2wVEcqmLtKJu2A@mail.gmail.com>
 <20181007164807.GA21302@lunn.ch>
In-Reply-To: <20181007164807.GA21302@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 7 Oct 2018 18:55:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9ocfZuoXYxyw2q7f_Lo1yQOw1Y43LeexmS6BJAgeaST3A@mail.gmail.com>
Message-ID: <CAHmME9ocfZuoXYxyw2q7f_Lo1yQOw1Y43LeexmS6BJAgeaST3A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Oct 7, 2018 at 6:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Jason
>
> This is the sort of thing you should state in the patchset version
> history. It is O.K. to say i will address this later, but you need to
> communicate that. Otherwise reviewers just get frustrated that
> comments are getting repeatedly ignored and why should they bother
> reviewing it. And without reviewers willing to review your code, it
> will never get into mainline.

Understood. Sorry about that.

Jason
