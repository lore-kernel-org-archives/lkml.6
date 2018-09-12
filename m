Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A2CC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BD320882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="vUU4Lau7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BD320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeILFEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:04:12 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44339 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeILFEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:04:11 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e131e7a4;
        Tue, 11 Sep 2018 23:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=GoCYk7i41uIEhsvGpPVreJ0jjs4=; b=vUU4La
        u7ECrFGXDsSdrB8LaLx5X6GIXe897tzUOmp3u8yl3ngbX+opVME5O36E/+TBbnYW
        6Bx/GxdJHqv3S20mZUlH7WV7MRj0s5MEF9lxkGv6F7PYEljQ33kAVVu1X+61RSVr
        0KZcFoov+n8xLsDBxFzfszxEiFyrrhdVj4CjBueICRfKin9pGDilsBgTjYomph81
        H6j6S9WFmSAKO5/FLWSmyrN+WILpwtKuAbqGMwjmTTG58ODhK0QJ4pUE68M/vxlU
        1pu6w2fD2Zkmq5hSLrLQlj8+gcEAW7ocLGPj7QcdoMXycSaXYin4xv67IFAXNfDo
        OfiT3qlQh8Z8W+jA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0528a5d2 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 23:45:45 +0000 (UTC)
Received: by mail-oi0-f53.google.com with SMTP id r69-v6so219913oie.3;
        Tue, 11 Sep 2018 17:02:28 -0700 (PDT)
X-Gm-Message-State: APzg51BIjfR6XdltxeC8fOB/CGVzXKD79kdGkKXYWNKIa38XArPmThgL
        MLAcpfNWtrOWhrqU71pKWQj35RpG1cXdKnk0UZ0=
X-Google-Smtp-Source: ANB0VdadGDrhiMyWB+GgL4B2NzTDI0i+G7Q7UGWN7/ObjG7IbX9qWTGtfbrnb1vctDhtQjBP82mjCfYUgKhfWKObaN4=
X-Received: by 2002:aca:e795:: with SMTP id e143-v6mr29701244oih.252.1536710547395;
 Tue, 11 Sep 2018 17:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
In-Reply-To: <20180911.165739.2032677219588723041.davem@davemloft.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 18:02:15 -0600
X-Gmail-Original-Message-ID: <CAHmME9rSRn5z16B9Ck3+PK_Zmj0LdiJAVmmT+7La6_mht8tMUA@mail.gmail.com>
Message-ID: <CAHmME9rSRn5z16B9Ck3+PK_Zmj0LdiJAVmmT+7La6_mht8tMUA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 5:57 PM David Miller <davem@davemloft.net> wrote:
> Both of Andrew's statements are completely true.
>
> I'm not looking at any of the networking bits until the crypto stuff
> is fully sorted and fully supported and Ack'd by crypto folks.

Seems reasonable to me.

Jason
