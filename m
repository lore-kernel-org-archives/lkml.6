Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D27C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE61420833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AaUkoPfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE61420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeKDDIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:08:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40090 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeKDDIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:08:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so3403841lfe.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrZtMHdrDvnXUqKLglgrLGHNN9aMjkD1blLdzjP31rc=;
        b=AaUkoPfCVTC2Y/0g7huesZ8c4Sm5QGly5UHcTFvHSdiUPabHyKQYk+gdY+jZpux/8x
         IQNZJKeveItI5bLXK1yr4bL2OmhL7aIHqqbPdvXKVrqOwhtLnKO77APnLvCK9KAhtJYA
         GulG2YO7s1iHwqNgR9/VuMq4SHqE501D/tUu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrZtMHdrDvnXUqKLglgrLGHNN9aMjkD1blLdzjP31rc=;
        b=hq2ae0Q0WUInUHYTGWOqTQDyQmeesHbGQ4yErti3meTI3r8l4r1VTW0f2v8jvrlHMu
         iuxglaix8Rgnu9HT1yDxPQlw6FX5GmnecI2q0EyouAiYpl+63T7KTGSfI8+fG1D6zlIH
         YGeNzjH4y0fqBPGl7tkuQJ1rkRRNnec6q0qAS7M2nIVnFF/BDU55FSe5ptDjXNISAvtI
         UhdjbGi8cs0uaDQNQtCOS+DdvPSUYcxJm9WCc8WSRJWvb224jRIwvE27gtD8o/1Y3Pl9
         dU5yxAC8pLzkiiiZ7gZ8vq7YpgBErG7FzE6GWJAeSdTDmdeM/xfzpFKJaAaGg87cIlCg
         DGDg==
X-Gm-Message-State: AGRZ1gI31JD+YWhAWNB8MrqB53hT0rLq0U5xT6hJKZe/+2uQcRQUaYlQ
        97oGo9CbwJvUA5wzPv66rBBJraNi4PyP2g==
X-Google-Smtp-Source: AJdET5epOMzXAVGW6qf0yipMeTDUp6Xi9oYdqGmSP+MtTdQOkujc95qdtoXVCXgeBDzt2J6Ap8qsdA==
X-Received: by 2002:a19:5611:: with SMTP id k17-v6mr8980007lfb.78.1541267811762;
        Sat, 03 Nov 2018 10:56:51 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id s20sm3062250lfb.51.2018.11.03.10.56.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 10:56:51 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id j4-v6so4438774ljc.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:56:50 -0700 (PDT)
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr7582465ljj.120.1541267810407;
 Sat, 03 Nov 2018 10:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181103104115.7imtevbiauvd3qls@mbp>
In-Reply-To: <20181103104115.7imtevbiauvd3qls@mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 10:56:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=JRdXtuJfRaZ66zPZ2Mb-9NyfSXVtJ5ZY-SHbojekKw@mail.gmail.com>
Message-ID: <CAHk-=wg=JRdXtuJfRaZ66zPZ2Mb-9NyfSXVtJ5ZY-SHbojekKw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 2nd round of updates for 4.20
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 3:41 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> arm64 2nd round of updates for 4.20:

Pulled,

                Linus
