Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F489C65C2F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 01:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0A6205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 01:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iGsOx0M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0A6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJGJDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 05:03:22 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:40005 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeJGJDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 05:03:21 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c3f4c4e7;
        Sun, 7 Oct 2018 01:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=w8fMCU7hDKsNZbRJpYnAWz9D0ng=; b=iGsOx0
        M10cR8pGkoDaGS+n14YU3eJaDRqew7+NnqqLy1eCkSzd1YVA6IacaWb8Uzfup3+u
        CB8g8MS19Vwdn09khQcjjWDs/7U76/KhTnZmkc8bLpnBKW5AB4aVBz18MjPDDTOp
        9umbZ9rKCR1ik7hlRO6yXtGZ7+t+GP8/PfTY8ZoXkfNzibDvwhtK8yq4Wc8ce5jK
        5D4/xUTU8KQkoaWlQVWawS2RCLebBmo0TrhZNGbeDnciGWk6za9YJ78PUz8f3rEA
        JDHptU4n+GWeq/yneOA+rrFTIB7S1bH48oV8w5hYa2QrO27eoikf2POqlIoVt6NS
        6RO4gf9khdHhOabA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1fd957be (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 7 Oct 2018 01:57:15 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id o21so16092848otb.13;
        Sat, 06 Oct 2018 18:57:51 -0700 (PDT)
X-Gm-Message-State: ABuFfojA/k6mW+vJMx3vGdEWLd0B1NDkVLWLBk+6T5Uy0PFKiaR3swUJ
        gPWZjMsXQX9EkN0UBivizsphCzmKAJn+frY2Xo0=
X-Google-Smtp-Source: ACcGV63gTyQrBnlJlfAxXCiH6yV3a0koItJDGBTwox6NKKP0nNBHM9L9ieKi0qXkl/i6qOL/Byy8WdtRqNR+4cj0mEg=
X-Received: by 2002:a9d:17d0:: with SMTP id j74-v6mr9654669otj.268.1538877470789;
 Sat, 06 Oct 2018 18:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181006025709.4019-1-Jason@zx2c4.com> <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006235414.GA11773@lunn.ch>
In-Reply-To: <20181006235414.GA11773@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 7 Oct 2018 03:57:38 +0200
X-Gmail-Original-Message-ID: <CAHmME9ocMekP+jauihMGKq04to0_jQTjhv=r2wVEcqmLtKJu2A@mail.gmail.com>
Message-ID: <CAHmME9ocMekP+jauihMGKq04to0_jQTjhv=r2wVEcqmLtKJu2A@mail.gmail.com>
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

Hey Andrew,

On Sun, Oct 7, 2018 at 2:01 AM Andrew Lunn <andrew@lunn.ch> wrote:
> The BUG() statements all seemed to be removed. Thanks.
>
> We still have 1 errors, 193 warnings, 7529 lines checked from
> checkpatch. There are still some Macros flow control statements in
> them, despite me pointed them out multiple times.
>
> Im not reviewing this version any further. Until you get the very
> basics right, i doubt this patch is going to make much progress
> towards inclusion.

Dave mentioned he wanted the Zinc stuff to be all set before looking
at this, so I've been focusing my efforts mostly on that. But I
haven't forgotten about your reviews, and seeing as you're actually
interested in looking at this now, I'll be sure to address everything
you've mentioned for v8. When I'm reasonably sure that's all done,
I'll let you know, so that you're not disappointed again.

Jason
