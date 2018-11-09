Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45EDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948852089A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BjaxNKuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948852089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeKJI2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:28:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34552 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeKJI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:28:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so2943146ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdfO4xh7M+wD/7ij/a8svs0Pjmu4cW2IR1UClEyU0HQ=;
        b=BjaxNKuZuRYcR6QEFSJuyxdx9nu6dJqH13niYYldfUb/oQPKWoaGp3cYOHzgu29rv7
         xreMYTTvgI7DlV/HPlzs7AYkiczg7SPvzMrCZLm0JkboIGL/EFTG/KX29hymgKm52Ptq
         HjrqW2PzX2Va7NJdbD+FIkpxkxp28OMAJm9tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdfO4xh7M+wD/7ij/a8svs0Pjmu4cW2IR1UClEyU0HQ=;
        b=QbzDyFdg7CURB5Dd5ftGKqvxHXoJq8u8rWn5Sq9bpBC6gE9iTufaw+SS5D1xxSEvwQ
         6YqPaUw++vkJTCj6EsLyw7vI4Jm+f/J8U7lPDNE+zPPQltC+ojoltBvjqEaCts3kXZnE
         Dhb7ryKw89AFhkWv8/SBZjsEBBB7aZS1/gRMTM66+Tzn7o5xyKsgE7bKdRdfBfHArtVA
         D/A2aQWxL4PLeTYm/c+JDUo0UuZcGj+dnQH8AJ/Bqcexq4UP5inmhb+sS0OAklKmDH9m
         4dcqnC0QwilJ2Dyv/rri1fuMXdcsd22Xdq4Fpfww8NohCHYhZXXsVQ7+v6wWQZNWdHTs
         a64g==
X-Gm-Message-State: AGRZ1gL3BO+yZOBuFpY09URO4MAl2rCRm7hrj456Ni3TndxaNPRdz3ub
        MgA5uE79ixD/aXz8vMQyEvlUI0quOm4=
X-Google-Smtp-Source: AJdET5drH75mgHojL4GEnP4RSMLO6LlRj40gMEBbYlswf4bqD4rslCSo0Urp2sMOCS1jDLB2fWxlzg==
X-Received: by 2002:a2e:8845:: with SMTP id z5-v6mr6444903ljj.98.1541803518197;
        Fri, 09 Nov 2018 14:45:18 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k1-v6sm1577653lja.59.2018.11.09.14.45.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:45:17 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id v5so2462674lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:45:17 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr6667437lfg.117.1541803516565;
 Fri, 09 Nov 2018 14:45:16 -0800 (PST)
MIME-Version: 1.0
References: <CAL_JsqLOqQ3p7mScZVfusQkrEvNCKzCWL+u1Jfe_d91Eh_krwQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLOqQ3p7mScZVfusQkrEvNCKzCWL+u1Jfe_d91Eh_krwQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Nov 2018 16:45:00 -0600
X-Gmail-Original-Message-ID: <CAHk-=wjarC=h1cB5HaNjO3-gWKtq2nanRt2dLxkqHB=HdMRm6w@mail.gmail.com>
Message-ID: <CAHk-=wjarC=h1cB5HaNjO3-gWKtq2nanRt2dLxkqHB=HdMRm6w@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree fixes for 4.20-rc, round 2
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 3:39 PM Rob Herring <robherring2@gmail.com> wrote:
>
> Devicetree fixes for 4.20-rc:

This pull request should be getting an automated reply once I've
pushed my merge out (soon), so I won't be doing the manual "pulled"
ack emails any more.

If you don't see the automated reply, or you have any issues with it,
let me know (or just cut out the middle man and talk to Konstantin
directly, he's the mind behind the machine).

                Linus
