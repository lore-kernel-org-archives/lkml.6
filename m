Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B703FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B97D2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="rRNzkRct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B97D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJZIWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:22:16 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55895 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbeJZIWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:22:16 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id ff0e72cb;
        Thu, 25 Oct 2018 23:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=BEu0OXWROrhgpKepYbS9Fa2VBeE=; b=rRNzkR
        ctdkI3GiOWt3llRVPNHQVPSck7FU8oZXg2fhx+SUx7ZNc0r9Ns6bvbMxLZ5Z0R26
        C6qgN6AV7xYXOYNO3jvGLciSZOezYvzFgXlmC9drCgKUCR+YY2Q/QSPBhnxa+NfJ
        zCTG/VBXyyhOukny644WrRKY+GwHfLmOfa84vApQEIXbViOAn4XW1nrtKB7KkkBZ
        ROxiWHbjUl3EvkgDNAcC7/eBGMQJ8pbRs/xtIpuDJ6CN+1L6iD90isoDspeRflvy
        IW9dkU6WQA9DR0rWh9CzaKgdZkvLOO2cfn0XO0A7HX8p/8Z2mFAwlx4UlsWyBHbV
        40ghekN2PGk/QB0g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 19a1484b (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 25 Oct 2018 23:44:38 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id p125-v6so8261918oic.3;
        Thu, 25 Oct 2018 16:47:34 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIUmjriAmCajYixtZ03/P3wR219IMyQrVjk5g0MMVfrsMIuC4Pd
        FI2J8vCEbOozXMwu4uvNdlfJ70MbMchb3Zml7b8=
X-Google-Smtp-Source: AJdET5e64P6ZYLyfQja4U+JXoB3rqa4WVAazcGOkA74VV8MAOoKTojmpNFxpnuELqbPN5AzbX5UUk2udhMQGHDWMZhA=
X-Received: by 2002:aca:d944:: with SMTP id q65-v6mr837273oig.190.1540511253211;
 Thu, 25 Oct 2018 16:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181018145712.7538-1-Jason@zx2c4.com> <20181018145712.7538-29-Jason@zx2c4.com>
 <20181020224706.GC14816@lunn.ch> <CAHmME9qMf=n7mnE-bsx86SVFBs1LrvHoc+nWrpr12vtYAgze+g@mail.gmail.com>
 <20181025224426.GC6276@lunn.ch>
In-Reply-To: <20181025224426.GC6276@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 26 Oct 2018 01:47:21 +0200
X-Gmail-Original-Message-ID: <CAHmME9pf=tCd=RKPTCpYuHLPkYqQwwr3LXEHP+_WXJ7DNjueZQ@mail.gmail.com>
Message-ID: <CAHmME9pf=tCd=RKPTCpYuHLPkYqQwwr3LXEHP+_WXJ7DNjueZQ@mail.gmail.com>
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

On Fri, Oct 26, 2018 at 12:44 AM Andrew Lunn <andrew@lunn.ch> wrote:
> Out of tree is important here. To some degree, mainline does not care
> about out of tree drivers. Putting in a bandaid for them does not help
> get them fixed.
>
> I would drop this bandaid. If the Android community decides to move
> wireguard from mainline into their fork, they can put the bandaid back
> in again, or get the driver fixed.

No out-of-tree is really not important here, and sorry if mentioning
that in my explanation was distracting and caused you to
misunderstand. The issue isn't the crazy wireless driver; the issue is
that suspend on Android happens all the time, and the entire Android
way of using Linux is centered around non-stop suspending, with
triggers to wake up (wifi drivers, for example, like the out-of-tree
qcacld one, but presumably in tree ones too), and ways of controlling
when it goes to sleep (screen blanking, wakelocks, etc). The Android
model of Linux revolves around this, and hence the suspend semantics
for WireGuard respect this model and adjust accordingly, using the
appropriate CONFIG_ANDROID to determine which model we're operating
under. This is not a bandaid, and it doesn't have to do with forks of
the Linux kernel.

Jason
