Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9DEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238F32084A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P/tBeEbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238F32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbeKAIXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:23:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40002 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeKAIXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:23:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id n3-v6so12950495lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpZdpokKvQSVfTqMIaCufFICb5MDl6qqXhiKEYYMWuY=;
        b=P/tBeEbvhGu0l4waNQPHovipcFXGFY+kLh2+4HNONcRjajDsJAuA35GEw4jCfS/XUm
         I4lieDosGjPBJUC9Ya+dfyPOe232EEBu6KOxd+tk79zTDRkNMU5Xl8i5PMhJGWf8T8l3
         SqzooMkan8ToIoayRLiveS6VLLG+ia2ncEzeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpZdpokKvQSVfTqMIaCufFICb5MDl6qqXhiKEYYMWuY=;
        b=K0o2ND+sC+BS3Qz9+MrPSyjlXTKTEjWKCXsgByo3ZhL4/V1gUlcE+tYhvSK2SlLds7
         tE3TRxanD1VQAEmj2GXS92aJ0E0Mb06B2TArdud2iirLifxC/KjWlGhV+S5bkR+tMrym
         09ftIfWfeXN2vwCjpz6JpgRYIhAT9OZb+yxJMatyHP4SnjUZdfDAsGBXp/9b0fUq09ey
         aR4c5V8hIr9Ygw+RqzVb+GpWn653Emc8RH44vkowF6WGiVjCxpfsVMXJFR4svUzN1LHe
         TNWZYgZKEkATsDqcr47tJd/y3NJAlstWYOmTSa9E6YzdcpmhAyOC4m8yX4g34N1YEpla
         0sqg==
X-Gm-Message-State: AGRZ1gLon+4Ld2rFBapdCo49Ktg39HxWrKOwWxZ47k4+GHeZ81mThKj4
        WXUCbyWK5A5qSih/zSgMwiiRzkUR50mtBw==
X-Google-Smtp-Source: AJdET5dzlxCnFOOqAZD18G2vMrDX9qsqT+4HC18ZQnVEmfPDo/VoD69BnmhzS4vVYI4VZ7Nu2xHAWw==
X-Received: by 2002:a19:cd8e:: with SMTP id d136mr3215330lfg.3.1541028196775;
        Wed, 31 Oct 2018 16:23:16 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e73-v6sm4357183lji.55.2018.10.31.16.23.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 16:23:16 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id n3-v6so12950463lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 16:23:15 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr3193250lfc.147.1541028195354;
 Wed, 31 Oct 2018 16:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-ddfcf75a-ffa5-43b1-a785-23da232023ad@palmer-si-x1c4>
In-Reply-To: <mhng-ddfcf75a-ffa5-43b1-a785-23da232023ad@palmer-si-x1c4>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 16:22:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2DtKSLDUCAzOpUsxuuSjzVyi3XyhJ1KqH9bX1_rLsoQ@mail.gmail.com>
Message-ID: <CAHk-=wj2DtKSLDUCAzOpUsxuuSjzVyi3XyhJ1KqH9bX1_rLsoQ@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 4.20 Merge Window, Part 2 v2
To:     palmer@sifive.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 4:07 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> RISC-V Patches for the 4.20 Merge Window, Part 2 v2

Pulled.

                Linus
