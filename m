Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205A8C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1820882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ciHfx49j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C1820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeILXQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:16:38 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:59191 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeILXQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:16:37 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4a288542;
        Wed, 12 Sep 2018 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=igtVAF2uD/ncDpDQqQFjvsShAL0=; b=ciHfx4
        9jNb0M/l8EzlXJ9FOBv3pYAQiUv8LLTbmYyjnT/XkDv3O+iLKbuZ7bMkf5ePBt0G
        0hH00dWS7UMB3iD4an+VRkRlm3pOaMrJfvJAxySKGf/T32yLqy5SYCqk5nCTNXqx
        1IACtWej68L3uO2WT9pIDSk8YjPQmuA22qdcbABarJhYk3vtkv/oSVI2HX5Ecv0X
        mhfu6Qo9DRolbTATV9uogfir2zjsXZMLfKqnw6asxgWQ6VMrDOiKyWF2k8dErcgH
        cTy8iRv3zmDAZalTXSVunpb1zuc6S9Tu6maFXokiaTLVekB/bMur9Xn0qKc4yJfr
        45OMc1093DfWHR/w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 067a8df1 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 12 Sep 2018 17:54:05 +0000 (UTC)
Received: by mail-oi0-f47.google.com with SMTP id m11-v6so5630088oic.2;
        Wed, 12 Sep 2018 11:10:54 -0700 (PDT)
X-Gm-Message-State: APzg51CAo8flBVOOlEvMyym/9o+URfyswi77Gm73dxqPLzRmG5hHP15l
        6b3xWjb858MXKAgNJ8c836hypU7/F95kaus8h7w=
X-Google-Smtp-Source: ANB0VdY0r9OzSbHGQWusjKOx6E722Ksnx9c4hYMfbyPY8zgbhrqNCevUuLC3dKirJ7vzZledjftje6FEyrGIUeYH/hs=
X-Received: by 2002:aca:dc82:: with SMTP id t124-v6mr3115948oig.189.1536775853221;
 Wed, 12 Sep 2018 11:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78>
In-Reply-To: <20180912061433.GA8484@ip-172-31-15-78>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Sep 2018 20:10:41 +0200
X-Gmail-Original-Message-ID: <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
Message-ID: <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
To:     kevin@guarana.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:14 AM Kevin Easton <kevin@guarana.org> wrote:
> Given that it's always supposed to be used like that, mightn't it be
> better if simd_relax() took a pointer to the context, so the call is
> just
>
>     simd_relax(&simd_context);
>
> ?
>
> The inlining means that there won't actually be a pointer dereference in
> the emitted code.
>
> If simd_put() also took a pointer then it could set the context back to
> HAVE_NO_SIMD as well?

That's sort of a neat idea. I guess in this scheme, you'd envision:

   simd_context_t simd_context;

   simd_get(&simd_context);
   simd_relax(&simd_context);
   simd_put(&simd_context);

And this way, if simd_context ever becomes a heavier struct, it can be
modified in place rather than returned by value from the function. On
the other hand, it's a little bit more annoying to type and makes it
harder to do declaration and initialization on the same line.
