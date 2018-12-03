Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC919C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35562087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fLRVKzuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35562087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeLCQuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:50:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45299 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeLCQt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:49:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so12022505ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckKTYj8os6C0SnRTgb0UJBdry5aI4TuybA26h+N17BA=;
        b=fLRVKzuEW6L6vp+CLAbARpmwGypmdwBAxrG4wCtb+1WeSgngaAPRHybWYJoyDVnqAm
         2ek77moz6yV4TltaoUUOjxFPj5ToJw2GYRqktYRzQbIjg5PjFwwd4eh9hDqLyLCYkqaR
         WrKmFl92Ry9GHNPAOKxCKzgr3vRERVt7V47Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckKTYj8os6C0SnRTgb0UJBdry5aI4TuybA26h+N17BA=;
        b=WdXlnZEodUpA6swIagnBuqOhkrbLKpIbfof17CeeEq8cRacCcuYdLY/6Ei/geOoI+9
         IEbVzYzHn0wgcM1yYupeYFOz+dGESwOyWqEC9+DxHhOD32ShCbTbVj/GBd08Taei0nqj
         0IBfqMpP5HacKDftyXAES9z0DGnctP1qJgRdEIoh6C8YuoUiA0k62BRLBYJNqUqLbIoN
         GNaTKq8WdVnnkKV+AUxKbz5zHlskubMXilxR14e4iC1kne5Ajwt3h/Avu80g3h9BZ7Pc
         4EdG5oNhZNaep5JFB7XBPH1vl5zOWgm55XTiGZNIGQSBpTRRLV+FNwPeCmrVyac1LVHp
         pakQ==
X-Gm-Message-State: AA+aEWb2C/aqIX3Wqckild2gGlFk3mAyjF02RSkyLzltQygNsPu2f/e+
        q58aig3eO3lls+5nJDKkTMW+/g0+vhw=
X-Google-Smtp-Source: AFSGD/U6z00lLFE19pZS8XYUF2293J8oBJ6+4Tl9Lh0PH1O65RhTlEJKSoebn+MFrdm91H/Eybo0Nw==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr10732031lja.44.1543855796509;
        Mon, 03 Dec 2018 08:49:56 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id v10-v6sm2792476ljh.72.2018.12.03.08.49.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 08:49:55 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id l15-v6so12043889lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 08:49:55 -0800 (PST)
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr9333860ljj.120.1543855794955;
 Mon, 03 Dec 2018 08:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20181202093257.3918-1-geert@linux-m68k.org> <20181203110506.GA7485@kroah.com>
 <20181203121519.GA7478@amd>
In-Reply-To: <20181203121519.GA7478@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Dec 2018 08:49:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiDeCY_ENy9S-6DjPgzzF=1UucJGrKo_K98jYA-yR1jJg@mail.gmail.com>
Message-ID: <CAHk-=wiDeCY_ENy9S-6DjPgzzF=1UucJGrKo_K98jYA-yR1jJg@mail.gmail.com>
Subject: Re: [PATCH v3] code-of-conduct: Remove explicit list of
 discrimination factors
To:     pavel@ucw.cz
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>, acme@kernel.org,
        tomi.valkeinen@iki.fi, bvanassche@acm.org,
        linux-doc@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 4:15 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Linus, I don't think Greg is doing good job maintaining this. Can you
> take the patch? (Or explain what is going on here, because I don't
> think public has full story).

I think Greg is doing a fine job, and I personally will not take
patches to the CoC without *much* stronger reasons than just some
random opinion.

This is an area where everybody has opinions, and there is no inherent
technical agreement (ie no "look, numbers: this makes code 5%
faster"), so my policy wrt the CoC is that changes to it have to have
very concrete reasons for them. IOW, actual problems caused by real
issues, not "in my opinion".

Honestly, the list of discrimination factors looks fine to me, and if
it is shown to be insufficient or problematic, there's the documented
link to the Code of Conduct Committee. That sounds to me like the
right way to bring up problematic behavior - and if the review then
shows that "yes, the CoC should cover this too", then at that point we
have a real and present example and reason to modify the CoC.

             Linus
