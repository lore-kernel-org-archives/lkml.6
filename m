Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C4EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873C321532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="We8XySgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873C321532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbeIUJIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:08:15 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45751 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeIUJIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:08:14 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d6414b89;
        Fri, 21 Sep 2018 03:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=qdBZm+bCMXbqziUyqMAN82K9JXU=; b=We8XyS
        gKQsKJkfNwAdgVm2wsJlboESXdrjvxmmpL19RZnWTSOdubJd7bigD/z2Q64YitkO
        0aBMT6S2qlhHJ0Jbkf9gSqVggt8/GS9elCRDTqhRQH4AREYzPSylqu068gKx0VeL
        xTgmdBxB9GnrMTGWo5EnQyC7i2N3cbUvuaoz9OySLcnm1AFa0WlHWr05T6SM2mdF
        gD8fVXgk6iFRfM9yUyTCIrReY9VunAu6Nvtp+iEMn0QjlclBqMgz9eXB8hFc0qnI
        PZeNWCUwl4pbFNFNQgrf4tkyJHitdjOIVNMj/oZnppNTTs5yO2KcBHWTd0YiiCaI
        93rEChnNX2G+ZXEg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4c14d2ab (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 21 Sep 2018 03:03:33 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id j9-v6so11657737otl.2;
        Thu, 20 Sep 2018 20:21:26 -0700 (PDT)
X-Gm-Message-State: APzg51CgJZpau8iP9YvfzjKZA1FezmrDuVv+6MmOnRfnDEwI/QVxBpci
        yMpVxCdFVrUOge+uIBfl0Kjx9bEsIDWISdENxFA=
X-Google-Smtp-Source: ANB0VdavM5TENL1YAnHQE/rZ3576FwEhKFj8UVn+1qMLmZr7pnT4ZZKXj/FHE8OKyThAEuf8bvZlb9g5nEFHaJM0jXY=
X-Received: by 2002:a9d:6554:: with SMTP id q20-v6mr24751122otl.209.1537499783441;
 Thu, 20 Sep 2018 20:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
 <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
 <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com> <20180921031255.GB11109@lunn.ch>
In-Reply-To: <20180921031255.GB11109@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Sep 2018 05:16:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9p-abAV-depcb+8wjAayv8WaGRqPXBswseH+ovsRbfJ-Q@mail.gmail.com>
Message-ID: <CAHmME9p-abAV-depcb+8wjAayv8WaGRqPXBswseH+ovsRbfJ-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
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

Hi Andrew,

On Fri, Sep 21, 2018 at 5:13 AM Andrew Lunn <andrew@lunn.ch> wrote:
> Do you any stack usage information?
>
> A VPN can be at the bottom of some deep stack calls. Swap on NFS over
> the VPN? If you have one frame of 1K, you might be O.K. But if you
> have a few of these, i can see there might be issues of overflowing
> the stack.

It's pretty small, and most of the work is punted onto workqueues
pretty early, so the depth isn't as much of an issue as it would be if
I did everything from ndo_start_xmit. I've done some stack tracking
using the debug option for that, and it's generally far from the
deepest thing running.

Jason
