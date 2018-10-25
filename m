Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C40C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC21B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hDP1Spl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC21B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJZId7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:33:59 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42791 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeJZId7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:33:59 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3ec22a79;
        Thu, 25 Oct 2018 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=cdwoZslFnVC2siYSh7tLNloFktE=; b=hDP1Sp
        l6SgFGl3uHs71ecn20l/3bbyawtKQpHUyU33gKDCc/34doj/XVKaDeqMRaiXOHB4
        kDhJm6j7AwDuhf+xoYBkVw+v8WMsqeN77FQh7IHI7Ktws2ACpG+AQbrDPpiBWDtv
        JrwI1rv5Tr5dyrqLdzmrdYIHNc+b2gmoTKzGXml+P6286EK/mOywZ69uvro1qav6
        /noRCb585FUbdPdLSifafiSle8RfDwMG0hWdqkNZLMLbjYmhb3dqf4u/jtPfzm15
        Kj5V3MxBXmQDhfdYptMTlBq0q83y/F4oB+U0OsO8kELqbWL2JWEGLHzbbXx0L7c7
        +7ZkqwaOqSuKCPSQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b100a2dc (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 25 Oct 2018 23:56:20 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 22-v6so8277277oiz.2;
        Thu, 25 Oct 2018 16:59:16 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJUlOr6t+40xBAIl0z8OMUMJ2jEbl/sPsyVAFUKVKSpXd6jRey8
        YahcSzX9CeQuwCE1wiXHkwlX0I5PQUs09dSwoRY=
X-Google-Smtp-Source: AJdET5cph03FpE9HFbUSToJT09/ExV5aWFVxkDwRjXviphR4894HrovSriWG50SXjgxeS3mcfpTXd4M1DmOpXYnaKrU=
X-Received: by 2002:aca:d944:: with SMTP id q65-v6mr852256oig.190.1540511955428;
 Thu, 25 Oct 2018 16:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181018145712.7538-1-Jason@zx2c4.com> <20181018145712.7538-29-Jason@zx2c4.com>
 <20181020224706.GC14816@lunn.ch> <CAHmME9qMf=n7mnE-bsx86SVFBs1LrvHoc+nWrpr12vtYAgze+g@mail.gmail.com>
 <20181025223746.GB6276@lunn.ch>
In-Reply-To: <20181025223746.GB6276@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 26 Oct 2018 01:59:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9pZ7qn6nas5=voYcUOrOPPOyo_PS0G=3tTjHgXKn1YujQ@mail.gmail.com>
Message-ID: <CAHmME9pZ7qn6nas5=voYcUOrOPPOyo_PS0G=3tTjHgXKn1YujQ@mail.gmail.com>
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

On Fri, Oct 26, 2018 at 12:37 AM Andrew Lunn <andrew@lunn.ch> wrote:
> I can understand that. But on the flip side, CAKE reached something
> like version 19 before it got merged. Wireguard is looking similar.
> An addition like the above, is not controversial. You could submit
> such a single patch in a weeks time when net-next reopens, and
> probably version 1 or 2 will get accepted.

Alright, maybe I'll give it a try that way. Previously, every time I
wanted to send things upstream for WireGuard, I'd be sure to find
other users in the tree of what I was adding, since WireGuard wasn't
ready for patchsets yet. But I guess now that some series have begun,
it's more acceptable to add APIs here and there as you described.

Jason
