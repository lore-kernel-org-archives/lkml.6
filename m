Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D6DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90F52073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="dLBP64m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90F52073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeH3R1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:27:19 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:26068 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbeH3R1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:27:19 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2018 13:27:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1535635510;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Bp8LPyM3QG2bBLxMXMdwxk8KlDypKG82bRB3LqKfNvg=;
        b=dLBP64m6X4CYl2EyFfDchRv33Gt4TA9o9T/BYScwwds30EogqGBWORwbV4AN+V4twZ
        +cEkC0xOJmc0SAArlKAiw7IPjSAkkpapR17gZsvDixC7C6mMzwlFK0db4sT5TURcaEVQ
        iHNxhGB5J5iGjPb+VSY8kVZVZUNhRQ6VaQipFwNi2DO31EJNa5QkacZ1QJKg38Yat1DI
        9MD7B/0dfKioyD1fvvE/p8VrBtFdDygP/mfCe0GzJBeji31ff7mkOHZ54XY7zUXREudi
        LmD+fKYMn4cSYa0khMO6wzFrSFSECba8LESWXj5wSdUP4q0Bd+Ei3FCZ20w67GJqAkZ+
        EduQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIfSfABn3"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.21 DYNA|AUTH)
        with ESMTPSA id e08f60u7UDJ9Hdi
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 30 Aug 2018 15:19:09 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Locking for HW crypto accelerators
Date:   Thu, 30 Aug 2018 15:19:09 +0200
Message-ID: <2002208.sm9qV7UXju@tauon.chronox.de>
In-Reply-To: <CAJKOXPd7JdzM2_PiHkS1ix1yU9hZmMbGDZaL07vbON0XzORH=w@mail.gmail.com>
References: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com> <3053033.se6UkFii4W@tauon.chronox.de> <CAJKOXPd7JdzM2_PiHkS1ix1yU9hZmMbGDZaL07vbON0XzORH=w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 30. August 2018, 15:09:05 CEST schrieb Krzysztof Kozlowski:

Hi Krzysztof,

> Thanks Stephan for hints. Let's assume the each of init, update and
> final are atomic... but how about the relation between update and
> final? I have two concurrent users in user-space but only one HW:
> 
> Process A:             Process B:
> init() and set_key()
>                        init() and different key
> update(some_data)
>                        update(different_data)
> final()
>                        final()
> 
> The final() from process A will now produce the result of hashing/CRC
> of some_data and different_data (and even maybe mixed with init() for
> different key). All because in the meantime process B added its own
> data to the HW.

The question is where is the state of the cipher operation kept that is 
produced with each of the init/update/final calls. Your answer implies that 
this state is kept in hardware.

But commonly the state is kept in software. Look at ahash_request for example, 
the __ctx pointer is intended to point to the memory the driver needs to store 
its state.

Pick a random driver implementation and search for ahash_request_ctx, for 
example.
> 
> Best regards,
> Krzysztof



Ciao
Stephan


