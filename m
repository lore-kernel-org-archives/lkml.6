Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A54C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8A42064D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="laX6RIAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8A42064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeI1V2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:28:54 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38959 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeI1V2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:28:54 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 07ac8fb4;
        Fri, 28 Sep 2018 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=5rp1MwXteIuTE/7eUbC7U7Zjikk=; b=laX6RI
        AEZt6XzuwRc8OEGUUy09nb6BjsKp/Ex2/K77xC8/AMR8Cqj1wpRhGtUFIJQRoews
        mUmiG9vRabsBVzJzryHAYXSaO2mtW1FR6P58KipQz2sZ4LoKIT3TPIr0WKkgijnT
        owzmS9eGwOU6N2TMm6vwzU6K8p4gVKv+egDu1i3dCSV4yFo15atsmqIysghVVe5h
        Y6ewXPmnCCJJ+oWI0sH+1RTrkOhqEJEH0Z/8blLmzk2xNaOMdbIKpdqXQVX+gYRf
        dbY22iQjsbVLFQ1KSGbIiGz3XwZS3E11C1NV7KpXiBQfvy42lYXL3/tfPLKV1CsP
        MByhWhhaoGpV8TeA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 528f6beb (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 28 Sep 2018 14:45:53 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id e17-v6so4795411oib.4;
        Fri, 28 Sep 2018 08:04:41 -0700 (PDT)
X-Gm-Message-State: ABuFfogYN++Ob47a60gnJRcJbVcPIS4Q7Y17ll3LiA8zgK6ciadXh9qS
        qBSgoplxgutaGWnFP9MnAXxL5zIV/WPHDKafWfo=
X-Google-Smtp-Source: ACcGV63y9ruAok7m50vlu9jkP94UmTPYHdCwvfhtc0Qie9mLs+t0IlNe6/7i8yhwtEWtwEmNYQSKdL7NNhYGKYsSGew=
X-Received: by 2002:aca:d489:: with SMTP id l131-v6mr697817oig.15.1538147080610;
 Fri, 28 Sep 2018 08:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <20180927011526.GB1193@lunn.ch> <CAHmME9q7WRGF3TTRhhy0i_EB4ad2DaSD=tnHM92zfV4Cckyw=A@mail.gmail.com>
 <20180928150117.GA19396@lunn.ch>
In-Reply-To: <20180928150117.GA19396@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Sep 2018 17:04:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9oO1kYP7e1RMz5xm8-bKBJY4vutQ3NROBqhb_GzOJaVBw@mail.gmail.com>
Message-ID: <CAHmME9oO1kYP7e1RMz5xm8-bKBJY4vutQ3NROBqhb_GzOJaVBw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
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

On Fri, Sep 28, 2018 at 5:01 PM Andrew Lunn <andrew@lunn.ch> wrote:
> The namespace is more than just about the linker. I see an Opps stack
> trace with wg_ symbols, i know i need to talk to Jason. Without any
> prefix, i have to go digging into the code to find out who i need to
> talk to. This is one reason why often every symbol has the prefix, not
> just the global scope ones.

Good point. I'll see what the wg_ prefixing looks like for all the
static functions too.
