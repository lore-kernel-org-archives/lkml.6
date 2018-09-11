Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F18C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD15020866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TyCGuwGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD15020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeIKGO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:14:27 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45409 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbeIKGO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:14:27 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d5e54306;
        Tue, 11 Sep 2018 01:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=U+8pp9a8wDXaTpvSop7mDuilnrQ=; b=TyCGuw
        GecdbsVlyMNRyeY43Oe/e5ucd/9eOTh6HE3uwgA/uZ7eUPaabH3WNtgxSm6UQ2Hh
        mg747uQRciZGpnAil62NY35tWjNGSyBJ6cC9rcSWpnIhr+2VhkawL4gnnfy/KIRV
        SmgrXodq9PPVzro0dO22taVvsGv9mpcIVjAz/9uom9SgzhePulwfcFJon8ToNBJt
        gczoAEzThifLj7xHTQN6c3wGRKxbAMOrl6gIHaT6P7gBjiwpn5o3aNlAxj60XVKx
        VH6JDPQMcF9gXJJXLi2OaKU2PUkTp01Dys8FdGd/1kEq4rzJZoDR0rYzuy+ENR0Q
        Dd7u/goVkmVdW+IA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f4433da8 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 01:01:05 +0000 (UTC)
Received: by mail-oi0-f41.google.com with SMTP id t68-v6so44008485oie.12;
        Mon, 10 Sep 2018 18:17:42 -0700 (PDT)
X-Gm-Message-State: APzg51B/y46wv6dMvPp7BWl5I80sASpcu44GQQEK/2ss94Lw0UeeLQ6O
        7zZoYDX8A2QNUyGg9gCWpl7R/f0Z95Xf1W0VE4g=
X-Google-Smtp-Source: ANB0VdZXCer3Sp38JiJQxRJfQEnPZAUNG894hh7yimlUY5ATzF1ZyyLzzpqBfRowuZfLjbZDzzT7jbKKRuCdSnXUxYM=
X-Received: by 2002:aca:2e86:: with SMTP id u128-v6mr23077827oiu.132.1536628661538;
 Mon, 10 Sep 2018 18:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-8-Jason@zx2c4.com>
In-Reply-To: <20180911010838.8818-8-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 10 Sep 2018 19:17:30 -0600
X-Gmail-Original-Message-ID: <CAHmME9rQbHCrs4yupk03nY2WOaKsyO2iSd=SrDqxhwYcswiRcw@mail.gmail.com>
Message-ID: <CAHmME9rQbHCrs4yupk03nY2WOaKsyO2iSd=SrDqxhwYcswiRcw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/17] zinc: Poly1305 generic C implementation
 and selftest
To:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this 07/17 is old cruft that was erroneously sitting around in
my v3 directory. Please look only at the real 07/17 instead:
https://patchwork.ozlabs.org/patch/968359/
My scripts have been adjusted so that this kind of clash doesn't happen again.
