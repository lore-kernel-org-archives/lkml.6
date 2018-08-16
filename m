Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15AEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4492146E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D3RcgBFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4492146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbeHPEz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:55:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33070 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeHPEz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:55:59 -0400
Received: by mail-it0-f67.google.com with SMTP id d16-v6so18953565itj.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 19:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiNmAvCtRpyeJ2hKAEQYbwN+moJUTVeGxN7BE1021cE=;
        b=D3RcgBFHHKBzJT4918KQLGt6Y5Zo6Gcn+1SHm0cpqoq2kvBzsosu/zuvNcT7IRkBZ6
         DNmwe9Z8wpTq99G01S5Z2zHqx6Lr04FKyiH4ReiWRkNhTID9g2aK6/zrtcb3NIGiu9TB
         5HIXl40KkCLlLW4jrZv+0jWNtt5dIHbMzxyGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiNmAvCtRpyeJ2hKAEQYbwN+moJUTVeGxN7BE1021cE=;
        b=DKXhMAVIVjG0BBvC0mdUCfoTOrhi2x8dFRy9wihUtvrCvHGYyjn2jVMTVsBU/lC6Pf
         trrva2nbFZk2fPEwTDV1lHlAFIofU8uZiVLDPaLsNJgC8MQN2f0LX03vJQ2p2GgNDs0v
         t9qTcQsci/5CU9X0DvYipNui3S8FwuOjwIDCmfIQ3HnqOdW6TGIZXvcLkESeYm9YIwEy
         eI9+PovDZeMLeLpwVvHMJ+RWdmMrFE+qbNH/9c9J87Mv24dkahmRXXFJG77O/hU1+0gK
         fT3+WnRSYnbNByZ27oj6JadEcYucHpc43bhuxcpSnP+q5QSdgsdb+Q8T30hQEGi2s/bh
         3JTg==
X-Gm-Message-State: AOUpUlEHX9CCQbGbdWTOe9Fz7DTqD4XsyzoNLSaSO1kwQha/UcJk3GrV
        qb4cGx+aiT0ukULPU/FDskDlA118Nrzj/aBXVHE=
X-Google-Smtp-Source: AA+uWPxxP89p67qA3/qRswOofrCeT0eWxrvuutvbu+k+JRd6WO5vcKQZP3+VucyUxaB+bDVpsrDu0Rbow8pYNXSMC4w=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr19540622ite.1.1534384859296;
 Wed, 15 Aug 2018 19:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <s5h36vhazyp.wl-tiwai@suse.de> <CA+55aFx_ZgBBGoFCqQDCBTs6jq7t4SmVpzc1zzvd-B2E65mJEw@mail.gmail.com>
 <CA+55aFy5GGpyxQCZoWxOooGu+i5psz7OogvzGpWmuEJ1g7OYgA@mail.gmail.com>
In-Reply-To: <CA+55aFy5GGpyxQCZoWxOooGu+i5psz7OogvzGpWmuEJ1g7OYgA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 19:00:48 -0700
Message-ID: <CA+55aFxZDYTFKM4-e89_2SKHjHh_8RCZe7whKa2kCWRFk4mAdg@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.19-rc1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 6:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I have no idea _why_, but it's consistent, and it bisects down to
>
>   c647f806b8c2 "ALSA: hda - Allow multiple ADCs for mic mute LED controls"
>
> where the previous commit works fine, but that commit definitely
> causes the problem.

Hmm.

That commit changes the return value of the
snd_hda_gen_add_micmute_led(), but doesn't change any of the callers.

Now, almost no caller actually checks the return value.

Almost.

There is *one* caller that does, though:

sound/pci/hda/dell_wmi_helper.c:
  alc_fixup_dell_wmi()

And yes, the laptop that breaks is a Dell. An XPS13.

I bet that instead of reverting, I can just change that

                        (snd_hda_gen_add_micmute_led(codec,
                                                     dell_micmute_update) <= 0);

to test for "< 0" instead of "<= 0".

                Linus
