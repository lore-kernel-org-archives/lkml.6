Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D04C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5112B2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VJOibp+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5112B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeKCDhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:37:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46885 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCDhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:37:17 -0400
Received: by mail-lf1-f65.google.com with SMTP id o2-v6so1947070lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaIwNjBE+rDKni9amWBasY1LkRgPcQYr40JqDmsjOEI=;
        b=VJOibp+noxy+lHfw7qrbpRLJ1B5cSnp3puF46qov6VVL3pliJscNto2rF7QqrDEEav
         dC6cbvSjy5iD6qZ433J5PQUeKo1v6ADryXlSG0f1w0RqAaP1pKu8w/i0IWZz+AfdHrqo
         fYHmGRsGXyhWXqQKjvhtOQFPU6U+17vSxJHSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaIwNjBE+rDKni9amWBasY1LkRgPcQYr40JqDmsjOEI=;
        b=hFz0kBRTRJnWBHiRXdEhp9248nEXK12AxtY/fjMUQDVkoYgfZD6tPs8HiQwSAJHhkG
         aTDU418qYofbnNdBJh8jGAxsE81OlW6rphweXc/DJR+l5PKBgILGMZ7oZbHzJ6TpbPSz
         SqZZCDmzklnm5ZtXMnEbmnLxOfTbww4Uk1D/fQjjd/rTzQX778jQn2Oo5iHkA8kJw/5K
         IkXybhnJhPICXnzIX/9y3qE6M8f7xgVssFMAMJMW0J0CuoxgcvTRPLkaNQ7QIBQXksbn
         oDDYLuJYHyUksXZY384iaviiSqVBz7dSFaVUoeF2E98+7p+6xSMHKpxZoycBllpcrt/9
         W9gw==
X-Gm-Message-State: AGRZ1gJFPpXPoUoN1+ASxazyCRsRRbb6GvxXcGthKOpDjLoTau3vpikJ
        Gh5uA9w57H08Z32LQ5ZhCfXBVM0uMOtVvQ==
X-Google-Smtp-Source: AJdET5ePJ3zmjQfF8LH2O+v6PzdO4QIXRBpJ/jsds32zY8LJEi1G/ChdmxpAdIk6UInunvK/eRum0A==
X-Received: by 2002:a19:5510:: with SMTP id n16mr7391501lfe.68.1541183347024;
        Fri, 02 Nov 2018 11:29:07 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id g72-v6sm5359927lfl.21.2018.11.02.11.29.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 11:29:06 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id x85-v6so2580253ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:29:06 -0700 (PDT)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr9012045lji.133.1541183345442;
 Fri, 02 Nov 2018 11:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <db97d76a-fad0-2a26-297a-06dbf8f8380b@canonical.com>
In-Reply-To: <db97d76a-fad0-2a26-297a-06dbf8f8380b@canonical.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 11:28:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOO_hJ1SL2jGVg3jGuPaGiuroxJa=-c=3LaJZBwME6VQ@mail.gmail.com>
Message-ID: <CAHk-=wjOO_hJ1SL2jGVg3jGuPaGiuroxJa=-c=3LaJZBwME6VQ@mail.gmail.com>
Subject: Re: [GIT PULL] apparmor updates for v4.20
To:     john.johansen@canonical.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 11:22 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> Please pull these apparmor changes for v4.20.

Pulled. Although I really wish these had come in earlier (like the
other security layer pulls did)

                   Linus
