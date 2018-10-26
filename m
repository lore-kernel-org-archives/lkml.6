Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9303ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0672086C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bXh0gvzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0672086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJZXxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:53:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44940 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeJZXxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:53:43 -0400
Received: by mail-lf1-f66.google.com with SMTP id m18-v6so1176254lfl.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0JurHmWRCkvazyhY435NKNKM8MbNu1uMXK0p1yYqYc=;
        b=bXh0gvzmPcBlE4+rnv6aaH+5xIAIZ63/93TsFEus0Bc8/ntXltNd6m5l+u0SleWiRF
         H2fBCrIcxjPzNrXSKQ8VkW2JS0N2Mj54e65N4TIDoFgqwxfAmPFTYPXXyk0GDKebQNMj
         AEXk0f2LFFOsCAPc8hsAuX7D9rDzmHIHBueEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0JurHmWRCkvazyhY435NKNKM8MbNu1uMXK0p1yYqYc=;
        b=D2EyGSnLbT2CEG9DH4aH3q8iso2cUDr/1Gh3DXQ1du1kqcPUCTTPWUfAU4R5uG6l+S
         UZgVb+sKHhjMmoDfExgnfoAkRXZdpVJwj2vDx0KF8H8sNRvMZQt1dWTLQRqfnLQBuwON
         KClquFPNH9oD4hCZbS+n74X5ugANntGjp5H1XbfD77mcamI3/7MSr1oQqZyQM+1ulkQJ
         6nayqyXGcOoJ7wlEBi6T1JDd8pZGrY7Za83Z7MEOUy4vUJeCGbuoQGepBjJTz8bR7V9h
         uQ9cUTZXiNbsuMoT3H7XMEk6RXplES9pi8SEvXco2h+JqQ59c+TdqOYYotgLgphmevqz
         o42A==
X-Gm-Message-State: AGRZ1gJN4QNeGu8u5R+WAmYmhxjvlgtUFE0NvvzctThc+jRjbJ3bAlFY
        icIpzRM6CxLTx0kGO0+5G5zeMYpzB3kM2w==
X-Google-Smtp-Source: AJdET5d5D14o0GUOIKWqnq5ZKyoDmkIhwDa6UDYbdpyoNiuj2GJ/182GKNAKtFXZ8gFX67IHQ0rlPA==
X-Received: by 2002:a19:9904:: with SMTP id b4mr1399222lfe.95.1540566974014;
        Fri, 26 Oct 2018 08:16:14 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id d17-v6sm1808213lfg.97.2018.10.26.08.16.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 08:16:12 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id d7-v6so1202165lfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 08:16:12 -0700 (PDT)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr2593429lfg.117.1540566971561;
 Fri, 26 Oct 2018 08:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181026100224.GA13038@kroah.com>
In-Reply-To: <20181026100224.GA13038@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 08:15:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0BWJrbhSwkMYHMQ7B=Rz9udBXneEmAH7ewNd1bwLz6g@mail.gmail.com>
Message-ID: <CAHk-=wh0BWJrbhSwkMYHMQ7B=Rz9udBXneEmAH7ewNd1bwLz6g@mail.gmail.com>
Subject: Re: [GIT PULL] USB driver patches for 4.20-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 3:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Here is the big USB/PHY driver patches for 4.20-rc1

Pulled,

              Linus
