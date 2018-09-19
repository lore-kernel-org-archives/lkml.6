Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C60ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524142151D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pUBlOf5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524142151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbeISFwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:52:31 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:50591 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeISFwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:52:31 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5e160600;
        Tue, 18 Sep 2018 23:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=uJfxrvGcRqOX2qdPTO8bsB3qGW4=; b=pUBlOf
        5JJhNBOmd5kepEBWtotrJUYMwjEpQcqwAB0THyFA+mSKL/vW0QzDtdbSY6Efjaoa
        AWbova6S6r5CZbE052sXhaHWe8bmSgEWDHtMYEAVwisbxuLzHrNeqYpu0PSEqrm6
        30hz5Z/VkT6JlV0l1qLQZKJAaHiaIiIgDkqV/XIz0Qi0ihzPzSmEe0zh4vK9WnAg
        Htcji14UqxXO7dx2iYj+13au2Sclcjd8mZkn/0AUWuC+IKtP6NA8kW7/iD2PlIlP
        QsfUrLoDJoou484qpmlGsTxzBzeu0+Yet1Hpnrl36M1fvV6zjXPBtnCixFmVaER/
        CmR+rAi+N94OF9jQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id acbf6ca5 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 18 Sep 2018 23:59:45 +0000 (UTC)
Received: by mail-oi0-f50.google.com with SMTP id 8-v6so3510944oip.0;
        Tue, 18 Sep 2018 17:17:22 -0700 (PDT)
X-Gm-Message-State: APzg51C/SJ3G4gxZr4X5ONMaoWt2xbviOla0PuAc82nKEwcMNsIRRZc0
        sHrw9N28qW9uGaoyLhnsjL6x+yTGdFk+7mdeqbU=
X-Google-Smtp-Source: ANB0Vdb8dYReJR6KHdAwpq5m+cWIqXYrfvY490HkVg6vq/LvoDvLUaCwCUUZeWj3jTrFHp4A0d8ZB3u4TvzjOvgCN2Y=
X-Received: by 2002:aca:ce02:: with SMTP id e2-v6mr135684oig.225.1537316241844;
 Tue, 18 Sep 2018 17:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-10-Jason@zx2c4.com>
 <20180918225552.GA74746@gmail.com>
In-Reply-To: <20180918225552.GA74746@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 02:17:10 +0200
X-Gmail-Original-Message-ID: <CAHmME9r_qbbYo=sxOvUauXDetJ3uA2A=WdpvjzQwMgqYF3=h1A@mail.gmail.com>
Message-ID: <CAHmME9r_qbbYo=sxOvUauXDetJ3uA2A=WdpvjzQwMgqYF3=h1A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/20] zinc: Poly1305 ARM and ARM64 implementations
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, Sep 19, 2018 at 12:55 AM Eric Biggers <ebiggers@kernel.org> wrote:
> This will compute the wrong digest if called with simd_context=HAVE_FULL_SIMD
> and then later with simd_context=HAVE_NO_SIMD, since poly1305_blocks_neon()
> converts the accumulator from base 32 to base 26, whereas poly1305_blocks_arm()
> assumes it is still in base 32.  Is that intentional?  I'm sure this is a rare
> case, but my understanding is that the existing crypto API doesn't preclude
> calling successive steps in different contexts.  And I'm concerned that it could
> be relevant in some cases, e.g. especially if people are importing a hash state
> that was exported earlier.  Handling it by silently computing the wrong digest
> is not a great idea...

Indeed you're right; Samuel and I were just discussing that recently.
I'd rather handle this correctly even if the contexts change, so I'll
see if I can fix this up properly for that unlikely case in the next
revision.

Jason
