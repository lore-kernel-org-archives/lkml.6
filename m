Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F23ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5DE2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="04ZyHqxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5DE2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeISSEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:04:35 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:41421 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbeISSEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:04:34 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e6af9933;
        Wed, 19 Sep 2018 12:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=4qfqBAAM8rP4GnrmCYyNp/gpMrc=; b=04ZyHq
        xW3lTQhH0YL3Cx43+kCtG8/fdUfc3DUo+kuaj/sgxotc/VJkXTD3l8CwNP23QT/s
        hK3DXv4u6cY3S3QVahiPLW/3YJuqlFF0RtSkEF+SRI4sMkHBjPyPRTrEojsi3kLN
        GnbT2vnCFzBHCAXM6P95INmhN9QNy6rtMBpH8ZNVd1rJJb3m6ukZNxq9qYdSaeeU
        AWjJ6LLrJ/r2WxB9GMC10H7vxBvE2Zt5E9NQXcuQvxEMgpyziOdKRMsBiU1N/GOq
        jHIoY/RrV359l+RiM6RZ5YveXRTVjngH5wbHgQKJj9rKUfjPFDxYBmyEKvo2lyRd
        2kl3jtSoV/lAfi6Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3540a8f9 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 12:09:09 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id v44-v6so5504956ote.13;
        Wed, 19 Sep 2018 05:26:50 -0700 (PDT)
X-Gm-Message-State: APzg51DUczaAxS5IgfmihhjAt3oz7mALbyvY8A8TDlbe0zBSy8aQJ4x7
        FMbwtHi4UMJ2X/3K+9F7Ufp9B9IMxV0WXWeTBSI=
X-Google-Smtp-Source: ANB0Vdb5psyQ3p8QjGwPWZF3riC9Qzfc6iY0rlNfmyZOb5Ytq56Lf4Eeef9dbVZB8Sey0Cr749II036YcUF9OlOP89A=
X-Received: by 2002:a9d:522d:: with SMTP id e45-v6mr17627413oth.250.1537360009775;
 Wed, 19 Sep 2018 05:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-8-Jason@zx2c4.com>
 <20180919005054.GC74746@gmail.com> <CAHmME9oL98adRp6xXqaXxA0E4Oa4ecPW+JHChCS3hTgH7RLPjA@mail.gmail.com>
 <BF781C43-52C2-410A-A6D0-AAD0AC998C2D@amacapital.net> <CAHmME9oERxpgxavBjoHEGwPCCq+O20eiDAXPvDSKgB4D+TRcDQ@mail.gmail.com>
In-Reply-To: <CAHmME9oERxpgxavBjoHEGwPCCq+O20eiDAXPvDSKgB4D+TRcDQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 14:26:38 +0200
X-Gmail-Original-Message-ID: <CAHmME9rsXFG6oUnc3e57Q9LY0R39eoTODZdyKk6OqJe7ssEY3g@mail.gmail.com>
Message-ID: <CAHmME9rsXFG6oUnc3e57Q9LY0R39eoTODZdyKk6OqJe7ssEY3g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/20] zinc: Poly1305 generic C
 implementations and selftest
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 1:50 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Sep 19, 2018 at 6:19 AM Andy Lutomirski <luto@amacapital.net> wrote:
> > Can you not uglify the code a bit by using normal (non-compound) liberals as described in the response to that email?
>
> I can define a bunch of variables, and then string them all together
> in an array at the end. This is a bit ugly and less maintainable, but
> would be the best of both worlds.

Alright, I wrote a little program to do this for me in a way that
actually doesn't look half bad. Thanks for suggesting.

Jason
