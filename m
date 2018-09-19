Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D61ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F1C2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iZR2CrMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F1C2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbeISR1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:27:51 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56099 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeISR1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:27:50 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d5708a18;
        Wed, 19 Sep 2018 11:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=UCiDBf3x3lFhkA7rL8SdFe2XMS8=; b=iZR2Cr
        Muhpu0+mcr9fkJOfgVQhsO9cbb9iVFBcKNfQzNfN8fa26sljQnk1yHgMYF9caLJU
        VUlHDw0pKoe9HYTx1KnqlHJzhntrOnejWr5H5nS23QF3GcTl5aZArKp4CqUfiEoz
        OCbJQTEFhhwqVwmw0oU0I/sqZeJC7HiaoVHqYMD56alH0yudAg4Z1C6dQYCbTbAE
        Y5pj9OqZ+zbvud60c72onAN1OMco4Fq8xLLBVXnobDIw0Sgm2CQMhN60f9BoAu7L
        aKWNhBp2D3SZMBzZq9/ujWDbHB0y8OgEFO0fbNuEfn7I1Ja9hi+vP6N0zMKRJgAA
        9N+jSf1tlw8x1uOQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f732a200 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 11:32:35 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id j9-v6so5452967otl.2;
        Wed, 19 Sep 2018 04:50:15 -0700 (PDT)
X-Gm-Message-State: APzg51Cye1hNmRGcwlAqwNdDQRypIPg4tQyoJN6505+nUqfot0HOO2bL
        nEEMNXamc5r4bmoi8LEQcq6ZNz2lSAVlWWut+8w=
X-Google-Smtp-Source: ANB0VdaAthMfrKIl9SHwiQgUlTUu7cfXwquYT53CGgmcbMJBgwtsaG0sPgRJFfei4U4IZyGygdmuqNt3zbPlwRczbkY=
X-Received: by 2002:a9d:51d0:: with SMTP id d16-v6mr19648183oth.384.1537357815003;
 Wed, 19 Sep 2018 04:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-8-Jason@zx2c4.com>
 <20180919005054.GC74746@gmail.com> <CAHmME9oL98adRp6xXqaXxA0E4Oa4ecPW+JHChCS3hTgH7RLPjA@mail.gmail.com>
 <BF781C43-52C2-410A-A6D0-AAD0AC998C2D@amacapital.net>
In-Reply-To: <BF781C43-52C2-410A-A6D0-AAD0AC998C2D@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 13:50:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9oERxpgxavBjoHEGwPCCq+O20eiDAXPvDSKgB4D+TRcDQ@mail.gmail.com>
Message-ID: <CAHmME9oERxpgxavBjoHEGwPCCq+O20eiDAXPvDSKgB4D+TRcDQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/20] zinc: Poly1305 generic C
 implementations and selftest
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Eric Biggers <ebiggers@kernel.org>,
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

On Wed, Sep 19, 2018 at 6:19 AM Andy Lutomirski <luto@amacapital.net> wrote:
> Can you not uglify the code a bit by using normal (non-compound) liberals as described in the response to that email?

I can define a bunch of variables, and then string them all together
in an array at the end. This is a bit ugly and less maintainable, but
would be the best of both worlds.
