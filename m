Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC89FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1352083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DUGyfcHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1352083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeJZIVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:21:21 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:39542 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeJZIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:21:21 -0400
Received: by mail-lj1-f174.google.com with SMTP id p1-v6so9851621ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaE+WDOzv4WXWUGrKprQcmyJAyt+hKYsSovPpJkDOYk=;
        b=DUGyfcHGE4jhLM1seTtAtQQnFp5BP3b8NL6j8n/atW66tk8GS7GkZmr8QQ0mucZl8N
         zbya7sEIoZEwwavXTZTHZfnZRZxw2GUtMftjqpr7jfqh9gcV9RXnWNP9ARNRsGdj0aHl
         sFQ7IQCmEZiuLtG2b1/hbnWa0m4X5DpIofIJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaE+WDOzv4WXWUGrKprQcmyJAyt+hKYsSovPpJkDOYk=;
        b=Xho337xVLCfUG6P914WzwN6hoB+3YaR7WPw/SgOvgSkF8nFhT1vp7IosEUVRtPgOHD
         FUbV8kSAiMsBn7ZbZMqmYIpnvFw4c8Rie/Pz0CJS3YN4YCPVnDMBpOcFlSP+ZMG8Z1oI
         8/+bGAmAek6Q/XtYuUUo/o/r7K8BBbt9H89anAREIC0nP+kTVVDPp4Nw8a8J0lIhPZBS
         Ry9HR8eZDhgykTZPMNpxKhJKaO/oiWZSSTPQ5lczTCsQ79Dlo64UHXuI3Syh2bYDVzbp
         +Ri5j7AfSsnbZ4rWkY+yD88k94svEFQke6/DCU+Qwy9ylvJMTEfBN8Q+4tTXHcOXRCbG
         iiFg==
X-Gm-Message-State: AGRZ1gK4NPF4jN9cnyRQbRxYssHeL1ayZcpaU80X5F9SBOGwzIRHv0XM
        F+MpAwSTtxAISfITn/hwI7FFBKj3XRdt8Q==
X-Google-Smtp-Source: AJdET5djZtRSbDB1GQWCC3vil6U9o4ui7cHpw0Oeys/caNcbL9dyN6QT3+E7ji+cfuzCksatHthkLA==
X-Received: by 2002:a2e:93ca:: with SMTP id p10-v6mr831610ljh.158.1540511199641;
        Thu, 25 Oct 2018 16:46:39 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id d199-v6sm1672159lfd.20.2018.10.25.16.46.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 16:46:38 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id u21-v6so9844751lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:46:38 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr746693ljh.59.1540511198078;
 Thu, 25 Oct 2018 16:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20161119102748.GA4277@gondor.apana.org.au> <20161213132414.GA7898@gondor.apana.org.au>
 <20170223125141.GA17400@gondor.apana.org.au> <20170904101225.GA12613@gondor.apana.org.au>
 <20171113074346.GA20245@gondor.apana.org.au> <20181023100958.GA11991@gondor.apana.org.au>
In-Reply-To: <20181023100958.GA11991@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 16:46:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrfStPeB=5_HoaYraL8XnS5qfbGMDdLOw7sxDF4FKgHg@mail.gmail.com>
Message-ID: <CAHk-=whrfStPeB=5_HoaYraL8XnS5qfbGMDdLOw7sxDF4FKgHg@mail.gmail.com>
Subject: Re: Crypto Update for 4.20
To:     herbert@gondor.apana.org.au
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 3:10 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Here is the crypto update for 4.20:

Pulled.

> Please note that there is a conflict with the compiler-attributes
> tree as one of the lines that was removed by a patch in the crypto
> tree was moved to a different file in the compiler-attributes tree.
> The fix is to remove that line from the moved file.

Thanks for noting that. I haven't pulled the compiler-attributes tree
yet, but I will hopefully remember this note when I do.

The lib80211 conflicts looked trivial, but I'm building the tree to
verify that I didn't screw something up..

               Linus
