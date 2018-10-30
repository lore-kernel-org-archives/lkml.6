Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394FC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A8820664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="merO8jjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A8820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJaGGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:06:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40369 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaGGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:06:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id f18-v6so8224406qkm.7;
        Tue, 30 Oct 2018 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Geo1F+rcWiR1yH6tDsVfLVgB6tNCnOzh06qBDUj6Wpw=;
        b=merO8jjfclSY449GGyNc6gtmZYe754ISceV1K31uiUFYlIxBKsX4XOzF/ieVUOw6EC
         uyClrdDEs5K3WWkxEm7oOwwBgPEt3pGbSYH9Pb0Ok/Jdn6mjb7vMza/JdKwvoFLonvM0
         2KEZ2rzsKPpGjrDQ8uczOHylITpy9YxSp8K58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Geo1F+rcWiR1yH6tDsVfLVgB6tNCnOzh06qBDUj6Wpw=;
        b=uUyJJBNolhCxK1euHsRWGNxz34xp05nrUxFJosV+iwdNSZx9NJ6p5Pej5yQHLFFTf6
         KmsYP2MtAu97JNeUgkht79szYZgHLMGAXPN4wB+7cNnnHlI7AAooecTTAh78S0sAibc5
         GgXVeA3o/NuU6wkJBsAFsdWA7Z4GOvEZdEtyDgX3T7weKln79C9yDc/Jtv5d1YK600Zb
         HW6da+u85fIm6VOD4se1Rlivt/cPYsEbxGxm1gTj/rMD0Q7PMCe6ZDSZD40wkT/A8IsG
         6vRW/BzqXuuXVK5/OKS+7byEdTxdqE+Ie2B5V7mWIA1UxIGzC60wOosYwkSm85VoQLwO
         /hSA==
X-Gm-Message-State: AGRZ1gJEVFnHIdVaBXufQlDcocPlMuKDkBmc1AOPIt+gHkk/Le9q5VA9
        wuCqi9E36mLA//8pri5ZegVsePY5Y5K9uGFv47s=
X-Google-Smtp-Source: AJdET5fq9zBHJ2GMvSSou9qc8qDiQ88IpkB04UUhK5+9PcLbHPJxQrdFkeqWWLTSVgzxPmVRDzWsFfWLZfpY/nwV/rU=
X-Received: by 2002:ae9:ef8a:: with SMTP id d132mr306114qkg.11.1540933893205;
 Tue, 30 Oct 2018 14:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 Oct 2018 07:41:21 +1030
Message-ID: <CACPK8Xf4+M9Q1zC5GBC0PBJBZnim14m_s5HoQJQOn5Dc-uCDag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
        Michal Marek <michal.lkml@markovi.net>, jhogan@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ralf@linux-mips.org, paul.burton@mips.com,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 at 23:58, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Evaluating cc-name invokes the compiler every time even when you are
> not compiling anything, like 'make help'. This is not efficient.
>
> The compiler type has been already detected in the Kconfig stage.
> Use CONFIG_CC_IS_CLANG, instead.

Thanks, I didn't know about this.

>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
