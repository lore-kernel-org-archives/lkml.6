Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C9BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F62C2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hD0XyUca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F62C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeJZFFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:05:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43165 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZFFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:05:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id y22-v6so2851483lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ubu7hiIXp/Cf6M28prv4hk/vUOl9HoBHNpLAI80hflk=;
        b=hD0XyUcaGfWNSl6iBi87qv+OBvn5MN0p6OAAm0vvFAd8wiH0zqJj+6DKQ3nFAcsLq4
         yfsU2OQDanDEokJA9o3r93bR2EI9GDCSJDPL57evETouJk9D/DCk+n19ApFkbLVx0ICL
         Kvzy+8YWEejbVXg79Ur37NAxgG6Vqq6KsLzNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ubu7hiIXp/Cf6M28prv4hk/vUOl9HoBHNpLAI80hflk=;
        b=b683LSdqtn4wi+PXPPyGLPmF4ht5u1jJt1a1cYHX5dol4hqNPkmw9V8KTcp4+Cmj4/
         zuU2e+KwyaLP5KgSVaDoKjh752KqksUMbi+niuPYBkcrnMu0nEaq6g/At80n8tSchORk
         O5G2at4BXPfwBYYZeHiW6KjqVKv5dKSCdD8gS5vvexP9wE/uhiUk3lxbWSkul6rSNzVq
         2Xr1liT/IJL3fjrCBmiJisbm38KoTbVJ6GaJU11gTkCLB+7oC7L80o7Dq/DmTAYbasGP
         a+wUrL+VGMTSRBVInPEtN+op+Opltgbh79I0bl4IBBKACQjTZrcVigIp+eKfPrd6FiWz
         zkHQ==
X-Gm-Message-State: AGRZ1gJ8/wU22kF9/RkD24Z9Xg95NJCemlCWmKgfVgX8SIWq+TAADHOe
        98kf1K0fl4qKzG8Ss7+h5whmzpaQNywC8A==
X-Google-Smtp-Source: AJdET5fvDcndjjdC2Hub8GaXany5mUOnVPEZxvIbiF870SNZbDHiAicKfTaTC+/PIBMM2aAYwiW+YA==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr520210ljc.14.1540499469736;
        Thu, 25 Oct 2018 13:31:09 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id y30-v6sm603562ljd.78.2018.10.25.13.31.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:31:09 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id j4-v6so9466281ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:31:08 -0700 (PDT)
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr530691ljj.6.1540499468327;
 Thu, 25 Oct 2018 13:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810252035220.30470@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810252035220.30470@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 13:30:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwjHF9NrHY6Vii3gSz8aKVgjPZwAvA78R+t3t6iq+L3A@mail.gmail.com>
Message-ID: <CAHk-=wgwjHF9NrHY6Vii3gSz8aKVgjPZwAvA78R+t3t6iq+L3A@mail.gmail.com>
Subject: Re: [GIT PULL] security: Smack updates for v4.20
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:37 AM James Morris <jmorris@namei.org> wrote:
>
> From Casey: "Here are three patches for Smack for 4.20. Two clean up
> warnings and one is a rarely encountered ptrace capability check."

Pulled,

                 Linus
