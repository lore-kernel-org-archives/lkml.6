Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9738ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA5920883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pRv2S9Oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA5920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeIQVwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:52:43 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:58297 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728651AbeIQVwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:52:43 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d03fb3fe;
        Mon, 17 Sep 2018 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=BpjsQp01BXptT5siBTjgG3N+CzQ=; b=pRv2S9
        OiFdDqmSDqEf60dLvwWb2b6j2ggvWMOv0iyWnQV7dSilBXGm5ZFS1Fg58Rsi2DN9
        BXukY9xBqdCtk6YrFYzu7XxNsgTe4tUEhqfOVcx/buFFMkslNeUsrUIys/Cp48Kp
        oMQx2jLxYudujxguN+jq+5DkQgU8D99O310LryTgXflI3zqgvnPgMtxLdZqXB9c6
        K1zXeQiT/e2H7Ob4Fw8GnQcxSyQDideuyEtC/sqcnT0rqT5EKFQ1rmNAqLpjxZnl
        1MPyHSZ5hpjTw6f+6dBz/xTEHii5WFPs1VnMIXayyJNiohDZCvxDDGB7ROwRCKVw
        h9RFIi21vzRNwT7w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27fb152c (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 16:07:08 +0000 (UTC)
Received: by mail-oi0-f42.google.com with SMTP id c190-v6so19446982oig.6;
        Mon, 17 Sep 2018 09:24:35 -0700 (PDT)
X-Gm-Message-State: APzg51AUDyyM9l8hCPEdSHx/TrFlMD6tXTFLtwW1g1FePtEJL7D5aQYR
        ZLcd7B/uwfp7EmCpQmtuumVg4jbtIfX0x9dUTRE=
X-Google-Smtp-Source: ANB0VdbsDObbjDw7qMaEVgkrNNUG8F5jezOZyU5eWTyP1F5XLf5Q3vO8I4CtiYNPIjU4mXbjIaTZMdBWx9cZhgmRlyA=
X-Received: by 2002:aca:d4cd:: with SMTP id l196-v6mr18196235oig.15.1537201474116;
 Mon, 17 Sep 2018 09:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAHmME9ohGPTX-fkhP6zaWdx3SbkiqO5kWkWE-bDk=pm-nUqYvw@mail.gmail.com> <8937D6B1-D21C-4C47-8A89-A466CDB6FB04@amacapital.net>
In-Reply-To: <8937D6B1-D21C-4C47-8A89-A466CDB6FB04@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 18:24:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9pKGyATJQSnKCzmjn5rAUG6pNAAeuwwBr4TequweNd24Q@mail.gmail.com>
Message-ID: <CAHmME9pKGyATJQSnKCzmjn5rAUG6pNAAeuwwBr4TequweNd24Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:54 PM Andy Lutomirski <luto@amacapital.net> wrote:
> be nice, but if the authors of that assembly are convinced it should be replaced, then this step is optional IMO.

I think this actually makes the patchset and maintenance of it a lot
more confusing, so I'm going to abort doing this. I'd rather make the
convincing argument for the assembly anyway.
