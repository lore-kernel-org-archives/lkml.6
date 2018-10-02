Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A454C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2242064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k1Ts0niw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2242064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeJBK0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:26:38 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54315 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbeJBK0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:26:37 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4752a9b0;
        Tue, 2 Oct 2018 03:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=kvJirQqERcRy8Vt3XCkTEz2E5wM=; b=k1Ts0n
        iwtPQjllP4Xt/lMpYzsSvLAAVT7X5IfaqwY3MHRv1VAQLE7rZIvY9gRAw0gpDqmT
        X4XsTDULIOAJ1U1FvdsA6LOwyvYIxHm1dXH+ju39KpS0Zc8YraT+ZBKICSto1WIh
        nYrfZjvLGLSPL16WiDFe8i4hQPXvswH2NSSjJIv8C9yXSTqSeZqe772N0JvfWlVH
        MP2NcvtaRZ7KCrFQSdSX3A3rH0faasfNksnjTiKPlin58kzrX8W1CEyi4Nsb61fb
        DN8q9dduLD6XDclLLF3NrnP5rg+SYlbA2X0Qz1axoXQ60qi+k1nIwuSNcJhoXtzS
        bzR0FFkjSs1nma7Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d4d3d37a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 2 Oct 2018 03:45:31 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id a203-v6so439943oib.0;
        Mon, 01 Oct 2018 20:45:31 -0700 (PDT)
X-Gm-Message-State: ABuFfoiFUhta5/qAUOOBv7vW0h4cm+TSXAsAM0rFwsNVbOy32CZbsBUx
        NpenYl/tWCyf4q6ojSHh9EGlt1OREGOqa6qY2W4=
X-Google-Smtp-Source: ACcGV60DJ7hunXJsVzKxvraEVLEs1Faw7lJLArWDl90ox4WbhvyU5YcujT4BU6suaqYJtc24r7IAKguoYXnO3PQrqdw=
X-Received: by 2002:aca:ce4c:: with SMTP id e73-v6mr6093474oig.225.1538451930844;
 Mon, 01 Oct 2018 20:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
 <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au>
In-Reply-To: <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 05:45:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
Message-ID: <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Tue, Oct 2, 2018 at 5:39 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > I would also strongly prefer that all crypto work is taken through
> > Herbert's tree, so we have a coherent view of it before it goes
> > upstream.
>
> I agree.  I don't have any problems with the zinc code living in
> its own git tree.  But any upstream merges should definitely go
> through the crypto tree because the inherent ties between the two
> code-base.

I can send you pull requests then if there are development cycles when
there are in fact relations between the two trees. I'll update the
commit message describing Zinc to include this.

Jason
