Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924B5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 16:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B051204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 16:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aPM6y3O7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B051204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeHZTnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 15:43:09 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:33729 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbeHZTnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 15:43:09 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id dea68e77;
        Sun, 26 Aug 2018 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=FYqttKa+cBWye59lIz1X/tB8LzA=; b=aPM6y3
        O73EvhWqo8QZU3/0cAjR6uM1g1ou8ZBqH3cUfKxjUoz+WvNiDbkWwstX++rLe5Rs
        b+DF67TNUr3bhq9A92mB3VlN7Dy7T15m7qf9C0v7C0Rv6N/eW9aE2si+SEMMMlZ6
        ukyGlVJL8VnznW/DC7B+u1/Sa4+/qedX36/QZhTkjEsssui664G7zKcpJsy0JYQt
        8SBX6qsPKARHfkrIFXC7Fq+jxBQ6sR8pJH7MgTUn77eEdRIvq/PXBwUSWmb6QQlb
        hAG9YTT3DKRJa3LQjhYGvoJnxpJVIxRC1T9qbK992luk67jiRNx7JXfnACoYIahc
        gwKauhK8JeEAhG8Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b9e95c65 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 26 Aug 2018 15:45:31 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id l82-v6so17629007oih.11;
        Sun, 26 Aug 2018 09:00:10 -0700 (PDT)
X-Gm-Message-State: APzg51DC+uQE+XvvzbSTI/trpJx0prdNL6GCRE/6E2WKl5ktlXoQBRXh
        BOqUGLPJr+HWTE+vaKjubyRb0aOHgBywB+Ty96U=
X-Google-Smtp-Source: ANB0VdYOWS/ExyADX2Z1+bbwEudJi+2ZS0VeyPcPstyw2kTX7Wa3xlF7svigDGe/xa+U725N+gTgRbWvFZL6VxzW/ss=
X-Received: by 2002:aca:e795:: with SMTP id e143-v6mr9463168oih.252.1535299210066;
 Sun, 26 Aug 2018 09:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-3-Jason@zx2c4.com>
 <20180825062951.GC726@sol.localdomain>
In-Reply-To: <20180825062951.GC726@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 26 Aug 2018 09:59:58 -0600
X-Gmail-Original-Message-ID: <CAHmME9pRVmjLHzaU7X3DZAihMUHORQfr8VPXv0Rt7SfZG=K4FQ@mail.gmail.com>
Message-ID: <CAHmME9pRVmjLHzaU7X3DZAihMUHORQfr8VPXv0Rt7SfZG=K4FQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] zinc: introduce minimal cryptography library
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 12:29 AM Eric Biggers <ebiggers@kernel.org> wrote:
> I thought you were going to wrap lines at 80 characters?  It's hard to read the
> extremely long lines, and they encourage deep nesting.

> There are still some alignment bugs where integers are loaded from byte arrays
> without using the unaligned access macros, e.g. in chacha20_init(),
> hchacha20_generic(), and fe_frombytes_impl().

These fixes are now completed in the development tree.
