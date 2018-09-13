Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9019C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EF120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="xAgadjPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EF120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeIMTCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:02:12 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44283 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbeIMTCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:02:11 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 83f960ba;
        Thu, 13 Sep 2018 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=HVtgmTjepFQpsbnrlNn210uyvC4=; b=xAgadj
        PEP6dkcRLdtamfJdIG+EB80RZhYGweC1qtxkl0zhMX6mfuheTkGBdAtUZlX/l4jF
        DBO+XponjWms25gDNOlCDA1HZ1bvt2n6WQggLE2abaGrLLMzAQAtkfMwI9u+27Tm
        OfiuTjG3ds9IxrLhVbZuOxt7YBP8jsuZEMos3yeH8eI9mM83yMkR0AhHAvinfFxH
        TpohsiWncx3bgpNbkv7WoGk8gOdr/RimpzclItAzWpaazVIReYY1k3e0CxupS6Ls
        Rb7m/99huGlMUZ60hrImv3NNo6ifbdGzx0IgqXgGgUTlR2NxFFSQ3ZCLISMyW/4G
        AMTXTL894omaJDDw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e75e1bbc (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 13 Sep 2018 13:35:39 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id x197-v6so9473428oix.5;
        Thu, 13 Sep 2018 06:52:34 -0700 (PDT)
X-Gm-Message-State: APzg51D0Xy3aN1b7QgY9zb7tTmXFt8SL8laUuvyxsaTNLnELUSydRkNf
        +g8b0og3bRO0+B0yXjTbzuGBcdtnL65mP5KtwXY=
X-Google-Smtp-Source: ANB0VdYb/Eff09pnZ9EP0hQ9vzDJWKr/rfcFStefrJRVFMjL9LDF4VgZ8Ug9sVbRMGzZwIqaqVmRh6oE0iKeeQfv/8o=
X-Received: by 2002:aca:310b:: with SMTP id x11-v6mr6581223oix.74.1536846753360;
 Thu, 13 Sep 2018 06:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
 <20180913050301.GA26367@ip-172-31-15-78>
In-Reply-To: <20180913050301.GA26367@ip-172-31-15-78>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Sep 2018 15:52:21 +0200
X-Gmail-Original-Message-ID: <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
Message-ID: <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
To:     kevin@guarana.org, Andrew Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 7:03 AM Kevin Easton <kevin@guarana.org> wrote:
> Yes.  It's also how most get/put APIs already work in the kernel, eg
> kref_get/put (mostly because they tend to be 'getting/putting' an
> already-initialized object, though).

Right; in this case the object wouldn't be initialized yet, which
might defeat the purpose, since one advantage of the & way you
mentioned is _put modifies the context.

Andy - any opinions on this? The tl;dr is:

1) what we have now:

simd_context_t simd_context = simd_get();
for (item in items) {
    do_something(item);
    simd_context = simd_relax(simd_context);
}
simd_put();

2) what kevin is proposing:

simd_context_t simd_context;

simd_get(&simd_context);
for (item in items) {
    do_something(item);
    simd_relax(&simd_context);
}
simd_put(&simd_context);

I can see pros and cons of each approach.
