Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E9C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598EF208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+4cKioB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598EF208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754410AbeFQXR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 19:17:56 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45896 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754281AbeFQXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 19:17:54 -0400
Received: by mail-qt0-f196.google.com with SMTP id i18-v6so13681847qtp.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 16:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7LkQLRRmoaRlU9u70vKz9wnlRX9lLJG0LtR8nVurD88=;
        b=T+4cKioBVgV1ahkDAWVf0zsAxti0IzxzFaTIIu3o0k3q5DlZYvozDlgfzirH1RUZD2
         Vq6nfRURGjfPDiwJphLoKUP2JL12+0fZFhZf0T2qsbIbXMn9h+JaawnMtHCJbJeNqU4n
         XDQ9iljfww7DpnhEf6/2wa9uZB5Ey7fmU+V/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7LkQLRRmoaRlU9u70vKz9wnlRX9lLJG0LtR8nVurD88=;
        b=MpPbXydep0/EAYMbg7jRYBL04O8hBgWwSnN+Wum2jLsAQUjWfEv+DbvWFC9QaP3vZd
         erb8W6hzog384U90mJuHRbU+zEzs0L/C9uOhx6ntsKbwQKcqcKx2KFz7i6F9ogk95t15
         i0hbXlqx1KzV67A5ZG9gbN7JXJ8qpnO1qMqnKD22mcEaSPFw5v7U06m6glGdUH/85A2x
         8P8lhkA9vSrWeeeWwXQPihNSAM9noNxZE3Fi5HBOGhvsYwaMZLUUIvrqOSAcygwjWv8o
         tNmRucPhSnsWDyQH058VTlfm3I0sgAZcq2grPiPWilcYbbIdZYmxQka+ul9uAI8Gh27a
         MZ+Q==
X-Gm-Message-State: APt69E00jqWMr1STpqrxqWGBIafi+DW4O5mChCgvrIQ2mPXKPs0sIQ5t
        bwtiCPwn8yVPlMWCqzfCUZpAJxMpaqc=
X-Google-Smtp-Source: ADUXVKIXgayQnwDpjUxmPBaHHrPAldpPoeIRZbe92ctaCI6lmvXlw50ErIYPzLPprxUxi9xME5IPqA==
X-Received: by 2002:a0c:f3c2:: with SMTP id f2-v6mr8707481qvm.230.1529277473421;
        Sun, 17 Jun 2018 16:17:53 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id z12-v6sm7324406qkf.66.2018.06.17.16.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 16:17:52 -0700 (PDT)
Date:   Sun, 17 Jun 2018 19:17:51 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     valdis.kletnieks@vt.edu
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] vt: preserve unicode values corresponding to
 screen characters
In-Reply-To: <117799.1529276384@turing-police.cc.vt.edu>
Message-ID: <nycvar.YSQ.7.76.1806171909250.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org> <20180617190706.14614-2-nicolas.pitre@linaro.org> <117799.1529276384@turing-police.cc.vt.edu>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2018, valdis.kletnieks@vt.edu wrote:

> On Sun, 17 Jun 2018 15:07:03 -0400, Nicolas Pitre said:
> 
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 1eb1a376a0..7b636638b3 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -317,6 +317,171 @@ void schedule_console_callback(void)
> >  	schedule_work(&console_work);
> >  }
> >
> > +/*
> > + * Code to manage unicode-based screen buffers
> > + */
> > +
> > +#ifdef NO_VC_UNI_SCREEN
> 
> This preprocessor variable seems to be dangling in the breeze, with
> no way for it to get set?  As a result, we pick up the #else define by
> default.

That's actually what's intended here.

If vc_screen.c ever becomes configurable then this could be used to 
compile out this code. Or if someone wants to disable it for some 
debugging reasons. For now it is just a self-explanatory placeholder 
with very little chance of being set by mistake for any other purpose.


Nicolas
