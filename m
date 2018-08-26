Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB177C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB05208B8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 20:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hnCWAwEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB05208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeH0AZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 20:25:57 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53304 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeH0AZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 20:25:57 -0400
Received: by mail-it0-f68.google.com with SMTP id k188-v6so8483737itk.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 13:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kvu7hnZmWJ1jX9rwMY1hPch2+Q8n2NkfnVb/SqCZ66w=;
        b=hnCWAwEqCvzLxkyxdsZfdVN/6QCbLqXzVv6lVt+waEsFHZA/8DtOkB57c8BF5p/Xu4
         Ik2nNOuADhfKnTNbtp8jO+c7TpsWBc5yw8tQiGZEnILW2GYPTTkIlvX30cdzwaU9qWfu
         nIk2v3HIed3pMdVVqJr18zDM/GmrN6KnJdVIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kvu7hnZmWJ1jX9rwMY1hPch2+Q8n2NkfnVb/SqCZ66w=;
        b=JkiOlWvt7tDPBeWIVeg5XFHEIa8Ln/sZSR7hj8Zaxz2mDgdzTONJmfIljvQwUVPJSd
         GbjMkpLVFcXkn1s+qhtzbcgEX22RJk1gSR1kHTkvZFQZbpzHdc29F7Sr2eXEYFM7bwG8
         HEkmSKo+ZWI3E1C/L/726W0imB90s+LSUi8rBStcT3kgRwfk/P1OIHr4X4ZFhuclzjIv
         DiNhDjgoYTvyPaWi3JQgOA0rfQNo+L8cNlGPuTJv0x4uGu4dLRmyTP97HaZpKIrpkBbA
         8/Y3jAL3mzXNMFdC17E2taW9UQ4a+IogELF9QEWCBU+5PDZjf2mY+57KNgrQMeloiiIL
         SZ2g==
X-Gm-Message-State: APzg51CzVrBtBcyYmmF+ZnaofN/bVTTjf/0o34jo/1PhNxi+rV3K4Qz5
        Nds3tZb4gfA43Ehv76wsCBuVe9FryHOuwB9wAzY=
X-Google-Smtp-Source: ANB0Vdab+Cg0r4EVGVLTUNlfiEqeeDxAt/oyYH8Sy8nLcSXzSET49Xz/NUuKAh1htTgFvp3/ssi0I8/fBrd92ObfMfU=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr8455697jaf.70.1535316138930;
 Sun, 26 Aug 2018 13:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <153527451522.1785.1711099585239615812.tglx@nanos.tec.linutronix.de>
 <153527451524.1785.7684129956167424331.tglx@nanos.tec.linutronix.de>
 <CA+55aFwBRzrWDsyzQLLurET_cfD4JNRPddNmFnJJodtLdLpL4w@mail.gmail.com> <alpine.DEB.2.21.1808262206010.1195@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808262206010.1195@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Aug 2018 13:42:07 -0700
Message-ID: <CA+55aFyVem+o7PbEH_0EDpTHt=H4C=oUQC1p+jWTOktxeEV44g@mail.gmail.com>
Subject: Re: [GIT pull] timer updates for 4.19
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 1:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> We still have compat interfaces for 32bit on 64bit even with the new 2038
> safe timespec/val variants because pointer size is different. And for the
> old style timespec/val interfaces we need yet another 'compat' interface
> for both 32bit native and 32bit on 64bit.

Ok, that pointer size argument makes sense, I guess. Ugh. Pulled.

               Linus
