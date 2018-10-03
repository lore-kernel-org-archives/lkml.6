Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EB5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57404213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57404213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeJCRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:34:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59183 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeJCRem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:34:42 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1g7eg7-0002LF-ME
        for linux-kernel@vger.kernel.org; Wed, 03 Oct 2018 10:46:51 +0000
Received: by mail-wr1-f72.google.com with SMTP id v30-v6so262351wra.19
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 03:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEcH9bK4V8Z1xS23RxMjsKT/xRkkcAazXgIp4vJ2x9I=;
        b=AZBd8fNCsvRSdkjmQ5jXiupMV48utNMlVq5pYKadJAKeqvrKghjW3G6iIXIZxnZN8F
         pQO95nDLxvHC6yUMQ4XFpvP0p6ZDQU3nzwAwc8OVOAcjX0oFF98XoI8JaEd8bXHAhElI
         jFFFr7ZbB1YJHI1Zb1t1Gl55QHS30sdHx8qPmgHuZczEOI02K48uW+bt3qql9TUroizW
         7hRt0tQC7hkPv6aqXU1z5WzswF/kxcrJmE7EN20TGTijIarRoctkjcEKwv2mjTPAGU2c
         xl0ht3zI4KAlVsCuVzGcwqCBVSQQlhIxW5twHi7Km1Qy2CQvDrrjLysAl3/REX8vPczh
         4jIw==
X-Gm-Message-State: ABuFfojZRsDjiKsOGzrwigKX5McUVJOaZxN3PGONw8gl3svzj3Rt1lyP
        qv2Jf77YsoqteUoErvPEzfwb4RhwyjA7kokU4pcAJR6K1HyAZcwTlyt+E1E8C97PiHAwKjqUGbK
        rOGaA7e398sLSoVXmJdQXsibOEzwf346SedYT4g84XF/f/qGw1Hy6kRdZ0g==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr803683wrd.253.1538563611379;
        Wed, 03 Oct 2018 03:46:51 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63lqDKF6UnoPVV0a2ZcbBrzJ9ILUGuVieQ4m55nnNJDUT5BwZxWXqhcfC9+jE9LD68KIkiUaIqSyil8giTOAF8=
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr803665wrd.253.1538563611080;
 Wed, 03 Oct 2018 03:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <8c61fd04-969a-cb09-6595-7ee23d214ab1@canonical.com>
 <99f1353a-e1a0-5ade-4aad-3eb62ea42a66@canonical.com> <1538515983.4348.93.camel@arista.com>
In-Reply-To: <1538515983.4348.93.camel@arista.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Wed, 3 Oct 2018 07:46:14 -0300
Message-ID: <CAHD1Q_xv4PSsJ3AcKd5i+QZ8On9jqPZsa+p46bCiKubhzVJerQ@mail.gmail.com>
Subject: Re: [PATCHv5 3/7] tty: Hold tty_ldisc_lock() during tty_reopen()
To:     dima@arista.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 6:33 PM Dmitry Safonov <dima@arista.com> wrote:
> [...]
> Well, v5 passes 0day, so all previous reports are fixed.
> But there is a new one about reboot on parisc platform which takes ~3
> mins after the patch with ldisc locked on tty_reopen().
>
> I believe it's related to holding read side for too long..
> So, the patches still need another fix, heh.
>
> Unfortunately, I was a bit busy with other bugs hitting more in Arista.

Hi Dmitry, thank you! Yeah, I saw that reading the whole thread after
sending this email heheh
That's a bummer =/

Unfortunately, I don't have a reproducer to exercise your patch. Do you
have some recipe on how to reproduce it easily?
I'll try more, in order I can validate the reboot behavior here.


> > > I'd like to ask you if you did respin the patch with Greg's
> > > suggestion
> > > for the tag - I couldn't find it in LKML heheh
> > >
> > > Oh, if you can CC me in future spins of this patch (in case there
> > > any),
> > > I'd really be glad.
>
> Sure, will enlarge Cc list ;)
>

Thanks again!
Cheers,


Guilherme
