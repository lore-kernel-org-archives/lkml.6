Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FB7C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C172083E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e30uiPJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C172083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJZIfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:35:02 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45253 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeJZIfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:35:02 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3da5c330;
        Thu, 25 Oct 2018 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ptx6hnpwuXjAydDn+1gV23n8QPQ=; b=e30uiP
        JIkG/zqlesZIbuc3pG/wBXh5PRvYV8lfxH1GU0fDrkdjPHv1pvr7cMX0XsNJ9s2o
        DtCu4af6o+muwFSYz3a7emSwhS8Y4DH+m+QJfJaA5eLkab0i08egSi05RuZler02
        pbNhScFYc2kPogeAgVPGpB7uWxSdANii7uyZhOklay91jTIkAhWB28dDzK6PBV7Z
        nEFlM6pezavIqknyppfe34Xi0Sdb49992/FCHYgxbWHuFVYOP4Q2dDj3iqtZR/pD
        N9SGgol8tUh/JVC16CyUSrl98ArROR3XQw7aw7M8bVoIUMO8ThRDyocNPtHSmkgg
        x74l5gl9O5bw1Q+g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cb1962f3 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 25 Oct 2018 23:57:22 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id k19-v6so2244177oic.11;
        Thu, 25 Oct 2018 17:00:17 -0700 (PDT)
X-Gm-Message-State: AGRZ1gL9w9L6qEK8pUj66pJTSlwCq8g1HMF9MLIEsWOmsg/KNMKgGWSS
        GHi79X/7yWqwA9q7WKJ20uG+odgzI6bo8Gg0kmE=
X-Google-Smtp-Source: AJdET5e0ibPSs7HvWc6ccteazf5/lmT/ep1qWthXfR09xTnPG6Fnfjro8rBe2A/yhE1T2XI924qWuDcVwa55NIx5Osc=
X-Received: by 2002:aca:c656:: with SMTP id w83-v6mr744149oif.122.1540512016897;
 Thu, 25 Oct 2018 17:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181018145712.7538-1-Jason@zx2c4.com> <20181018145712.7538-29-Jason@zx2c4.com>
 <20181020224706.GC14816@lunn.ch> <CAHmME9qMf=n7mnE-bsx86SVFBs1LrvHoc+nWrpr12vtYAgze+g@mail.gmail.com>
 <20181025225344.GD6276@lunn.ch>
In-Reply-To: <20181025225344.GD6276@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 26 Oct 2018 02:00:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9ocqh0CGv2Gnj7k148Pe7nk8rEn2eo47rVZ4d_44RRfCA@mail.gmail.com>
Message-ID: <CAHmME9ocqh0CGv2Gnj7k148Pe7nk8rEn2eo47rVZ4d_44RRfCA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 28/28] net: WireGuard secure network tunnel
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, Oct 26, 2018 at 12:53 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > This is on the hot path, actually. Well, it's not on path of data
> > packets, but I do consider handshake packets to be fairly "warm".
>
> So for me, hot path is something called 10 million timers per
> second. How often do handshake packets happen?

I can actually imagine situations in which this rate might happen.
Handshake performance is important.

Jason
