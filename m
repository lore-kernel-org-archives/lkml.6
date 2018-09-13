Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B729EC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6192120861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fgr032y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6192120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeIMToq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:44:46 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35161 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMToq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:44:46 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0cea1fbc;
        Thu, 13 Sep 2018 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Tc+Os4+4Tgycx3VIz2WPOIELyH8=; b=fgr032
        y/FM2y0/jliT1yw6g8XPuQLtialL6WO3uqFtUvFfUNWX+55TfaxRn3nwIfH34x9a
        L9g6grMXVxDV8h/bO9QZOqFP8gSjEF9RQ0ZfYmniO+nk7VEm0rBbX7+FaEGqRPVS
        8NHyhQViYdCt2LSITkpJ4I76mJYOTcpYw28zBE91EPEDd/dtyAQ2Rx0ipQSOTP11
        tNBEBgZztVa6+qNXSI8GAEZ8dfbeZtFsR4GYtVoekpUFP3ovqsCsPHoRAKGXEzRg
        Gy538kFSKLwZ9F+5DqpOu9hZdTPS3z8prAzs0BjjnthI8a0hoA4yC218iV8K4+sk
        jZrB7uoZxmmFluzw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fc8236b1 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 13 Sep 2018 14:18:01 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id v10-v6so1429899otk.7;
        Thu, 13 Sep 2018 07:34:56 -0700 (PDT)
X-Gm-Message-State: APzg51Cp9V/7gwB+jLn3k3XkQarlSwk354xguXT7vKCfg5oQTHP2lVyZ
        JlSDJvN//+RsdnCPJdrwLw002UakVqJMVPtMi8I=
X-Google-Smtp-Source: ANB0VdYgqTmowutDl48wTcq0pqx89SR7ShdqCXAQ3F2DlNbRswCFjSzMeJk3Y4aV29fhBIyKhiSjFGbLTYy2Xql92NU=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15-v6mr1464367otf.138.1536849295926;
 Thu, 13 Sep 2018 07:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
 <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com> <c5855aa4-1561-8387-aebb-0a7587ac6d4f@gmail.com>
In-Reply-To: <c5855aa4-1561-8387-aebb-0a7587ac6d4f@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Sep 2018 16:34:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9oXXHZQXuvum1x69tojsRwXtBM32VXsL2SXbBuq2JCVeg@mail.gmail.com>
Message-ID: <CAHmME9oXXHZQXuvum1x69tojsRwXtBM32VXsL2SXbBuq2JCVeg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     gmazyland@gmail.com
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milan,

On Thu, Sep 13, 2018 at 8:40 AM Milan Broz <gmazyland@gmail.com> wrote:
> Please note, that dm-crypt now uses not only block ciphers and modes,
> but also authenticated encryption and hashes (for ESSIV and HMAC
> in authenticated composed modes) and RNG (for random IV).
> We use crypto API, including async variants (I hope correctly :)
>
> There is a long time battle to move initialization vectors generators
> from dm-crypt to crypto API. If there are any plans to use a new library,
> this issue should be discussed as well.
> (Some dm-crypt IV generators are disk encryption specific, some do more
> that just IV so porting is not straightforward etc).
>
> Related problem here is an optimization of chain of sectors encryption -
> if we have new crypto API, it would be nice if can take chain of sectors
> so possible implementation can process this chain in one batch
> (every sector need to be tweaked by differently generated IV - and we
> are back in problem above).
> I think filesystem encryption uses the same pattern.
>
> And btw, we use the same algorithms through AF_ALG in userspace (cryptsetup).
>
> So please, if you mention dm-crypt, note that it is very complex
> crypto API consumer :) And everything is dynamic, configurable through
> dm-crypt options.
>
> That said, I would be more than happy to help in experiments to porting dm-crypt
> to any other crypto library, but if it doesn't not help with problems
> mentioned above, I do not see any compelling reason for the new library for dm-crypt...

dm-crypt is probably a good consumer of the existing crypto API and
won't be impacted by the introduction of Zinc, which is really just
the exposure of a couple low level simple crypto functions, and not a
fancy API like the crypto API which dm-crypt happily uses.

Jason
