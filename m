Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9767C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF0B20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 04:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Qpwn7Vmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF0B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJBKta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:49:30 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:43395 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJBKta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:49:30 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 56a72259
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 04:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=GgBGaEmWzs+3fO5Vk2ZRUxKVTGs=; b=Qpwn7V
        mfj2VVw0GZTyFZ9KAVJa4zzRdHHBiqlLP4Ow7HmPOVPnkUEkMqw37lsRjdBNeDL8
        yWS659y+dPsmKdd8i4ucXgmB0oqjA8bit3nQdJhEmEKWFA+guWTzoUvWw9hptoe8
        U3b3TVuApoPePdfHk3qygu0QxrEWQtodGoxY88P3epTL0TOqqek1lT8+56/H6Mm7
        zg2jRw3/SZjUlmroorX7ni009QlpAHGrNogn0k3HehCUK+dVXh3ZCS0trYRR6rWp
        gjO8p9fFWlMrY6a8GUGp701fPGqsv6jiJlNDewRM7YkcGQcA6OyZoanrexOW+J8z
        0FH6IstwVhQhPq/A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dcd2865d (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 04:08:19 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id 36-v6so556767oth.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 21:08:19 -0700 (PDT)
X-Gm-Message-State: ABuFfohJ6+kf2bz0nj/HAwYJXWsdkp9HNVWnnRpx+2zbapcA1zDjaG1x
        uDcF84wTZ2kljynERshpa3+CjQNEuKgwgHubDFs=
X-Google-Smtp-Source: ACcGV61wflQJkFljG162xUXQlZ5XyjJL+dmc9TWEoGo4QtHiSPdt60e4IS027Nuqcg6mNQ5cPw5fBJy3z09xD0nQ/fA=
X-Received: by 2002:a9d:17d0:: with SMTP id j74-v6mr2632857otj.268.1538453299002;
 Mon, 01 Oct 2018 21:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180930024904.14240-1-Jason@zx2c4.com> <20181001175622.GT30658@n2100.armlinux.org.uk>
 <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 06:08:07 +0200
X-Gmail-Original-Message-ID: <CAHmME9q96VvYVkUUvq8CCihhs24AdJRRn_JMnJ42k2tyLK1WAQ@mail.gmail.com>
Message-ID: <CAHmME9q96VvYVkUUvq8CCihhs24AdJRRn_JMnJ42k2tyLK1WAQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, arm@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> On 1 October 2018 at 19:56, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> We could argue that the ARMv3 assembly files are now stable, so the
> chances of ldrh/strh being introduced is low, which would make this
> change tolerable, but the commit message needs to spell out that
> we lose this protection.

Actually I don't think that argument really holds too well. We very
well could introduce some new ARMv4 assembly -- an optimized crypto
routine, for example -- and it could use ldrh/strh. That isn't the
case now, but it might be the case later. For that reason, I suspect
the proper solution is just not building new cryptography assembly
that's written for ARMv4 in mind on CPU_32v3 systems. This way there's
never a mismatch of expectations.

Jason
