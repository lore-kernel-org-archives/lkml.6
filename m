Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12058C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7552064E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGDxoumR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7552064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeI1WP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:15:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41168 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbeI1WP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:15:28 -0400
Received: by mail-io1-f66.google.com with SMTP id q4-v6so4506058iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vzDt74SW5SLJ2Hrz9xihYP6PDW3zkRrLZERI7r7ojYk=;
        b=fGDxoumR0N/ltlf32da+rBZSM4+4nFXJGJErexdp4YiV8vIiHwwzsLhm1IhtjsGj/I
         HMCnOPTRe+Mbv85b8rgVRU3oLMC7YWGDtLIGTr2YA7fthQafEDrQGj94DGtwJwbhXYHU
         IQ0KlS/u0OIR0X/4qfq4W+qroeonnK8UpR2ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vzDt74SW5SLJ2Hrz9xihYP6PDW3zkRrLZERI7r7ojYk=;
        b=jeJcccDbWRyTdCDeFNCeoTnZwMyFvo1x3W0h5WDJ9VZ8a/Mg3m3ZkMOkqGCzRNXdxE
         B2nyt01SS/Nai+jsHzvMyoIRu9JPYyJQo1Ggoqb14T4W7XouvAf3ElwYgbLCFkp39S90
         EpT5BbQpRSffRDvArU52LsNcjR4m4vtrUl3e7+VhH49sIAy4i3wraZY2gjZs8sHJFh4y
         8AOWJh+2lkRT/F3b7MyjZUjPqu2fr1uUF2vFXnNI9igEVucrUCUm3mjIPl/9vB1TAxj0
         afD4+aIO7Ks15GrnZaE8lqWgv7wl70ztVeQjzFa23z1s+8XXCDT1IZU6+rWxQAymgIsK
         VZBQ==
X-Gm-Message-State: ABuFfohtHNvh6kp1luqY7a2gosmtecktmfeLnQGmvwgLhzI0z24jRPwN
        eSasFZcNBGJMjZrgC5p/5Y3PYiLHpRsEHOBclf4JnA==
X-Google-Smtp-Source: ACcGV61Q5+ISEtGHPgoBeuEuvulSAmuY52hW9kYISohvcR2NjfxYF9geBTsXT5XjMt6/M+EomBPvNxTN61BbageTd1M=
X-Received: by 2002:a6b:3787:: with SMTP id e129-v6mr12946858ioa.60.1538149865991;
 Fri, 28 Sep 2018 08:51:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 08:51:05
 -0700 (PDT)
In-Reply-To: <CAKv+Gu8-EwxFhQSUPxjEvTA5ZPz34RieMokM6CUqwURDr74jtg@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-6-Jason@zx2c4.com>
 <CAKv+Gu8-EwxFhQSUPxjEvTA5ZPz34RieMokM6CUqwURDr74jtg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 17:51:05 +0200
Message-ID: <CAKv+Gu8Pej+hKV7=RbwUkE4PtXjqHewRMfE7mYJLu+xnS+HFQw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/23] zinc: import Andy Polyakov's ChaCha20
 ARM and ARM64 implementations
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 September 2018 at 17:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 25 September 2018 at 16:56, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> These NEON and non-NEON implementations come from Andy Polyakov's
>> implementation, and are included here in raw form without modification,
>> so that subsequent commits that fix these up for the kernel can see how
>> it has changed. This awkward commit splitting has been requested for the
>> ARM[64] implementations in particular.
>>
>> While this is CRYPTOGAMS code, the originating code for this happens to
>> be the same as OpenSSL's commit 87cc649f30aaf69b351701875b9dac07c29ce8a2
>>
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> Based-on-code-from: Andy Polyakov <appro@openssl.org>
>> Cc: Samuel Neves <sneves@dei.uc.pt>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Greg KH <gregkh@linuxfoundation.org>
>> Cc: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
>> Cc: Andy Polyakov <appro@openssl.org>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: linux-arm-kernel@lists.infradead.org
>
> As I mentioned before, I'd prefer this to be based on the original .pl
> but if I am the only one objecting to this, I guess I can live with
> it.
>

Note that I am getting bounces from LAKML because the patch is too big.
