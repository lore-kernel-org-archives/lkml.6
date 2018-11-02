Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D978C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436CF2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DXIw6Wow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436CF2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeKCDL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:11:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43806 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeKCDL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:11:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so2490434lja.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5LxDnjaFmBi+iRVuwyVugjjC9obHk1SRgA1+I3NldI=;
        b=DXIw6Wow86XwfGdJVyepaXBhRAPjm3zi0mBtGiiDMhiHdOJZpw0Hk5OFPZBxIq/veZ
         3+kestqjfp8SBgXhpCp1py05hF5FQW5yWZ7ZyvdfDGhlynVIzbjhrUWQCd98QWXn8iVE
         vO6giMYnaEtX/E6pesezCVvXudG5N5NcDJnhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5LxDnjaFmBi+iRVuwyVugjjC9obHk1SRgA1+I3NldI=;
        b=iXw74HEXxUwihr4JJ5+bfO2QkO7IaEpsaMKahN1pO83vUYzMaQT5DisoGB1Nz1UlIS
         RKiJoIJzKI6y4ycDCUpuKQGYDiIVOnj48YNIwSrPULI3vqLb1pkeFhl3airHXtBeLksR
         hwhnt1P5DupQvenVCgs2/g7wRPUVQVC8ZXz86tmhmIfM1VS20V0mdXKcp0pxfVwguwVM
         MKmtcB41Fj7v+GE6JyY/FGYzKkm2jY4NOxGWUuIPspLWhUjIzLZ8fve0Rv+zxFHMUBm2
         ZAKfx18a0+K2Fb760v8LBv7VnWdMaopnifWNGdHoIs2YUSBmfxIzHIGlQSrOxVIVgGa2
         Qlww==
X-Gm-Message-State: AGRZ1gKVNkorkEMtVrdiQkkSIWdkPSNkLCz2aiztJnKyQe5a0Bs8rwMm
        UUU55wsAmarBTf9SlpANOayBwh0BZxQNhA==
X-Google-Smtp-Source: AJdET5cYNNEm5IIeaUlQUOyK6D33s+43byYdFErCjq+fKpUg/NEWygP0C2Caf2IM1Mrg17a+9WV6hw==
X-Received: by 2002:a2e:2f1b:: with SMTP id v27-v6mr8116825ljv.31.1541181834563;
        Fri, 02 Nov 2018 11:03:54 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id x16sm2508636lff.26.2018.11.02.11.03.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 11:03:53 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id c4-v6so2517624lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:03:53 -0700 (PDT)
X-Received: by 2002:a2e:3e06:: with SMTP id l6-v6mr5035028lja.148.1541181833084;
 Fri, 02 Nov 2018 11:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <s5h4lczix44.wl-tiwai@suse.de>
In-Reply-To: <s5h4lczix44.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 11:03:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNRvnzSrRE2Li6gwaMusLjp0AY-e9bDwAkfiuRW_4c_w@mail.gmail.com>
Message-ID: <CAHk-=wiNRvnzSrRE2Li6gwaMusLjp0AY-e9bDwAkfiuRW_4c_w@mail.gmail.com>
Subject: Re: [GIT PULL] sound fixes for 4.20-rc1
To:     tiwai@suse.de
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:37 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> A few device-specific fixes: a fix for SPDIF on old Creative PCI
> board, and two additional fixes for the recent changes in FireWire
> audio stack.

Thanks, pulled,

                     Linus
