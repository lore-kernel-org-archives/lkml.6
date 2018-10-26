Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85457C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1E620868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dn4hHPSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1E620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJ0AxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:53:01 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:42055 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeJ0AxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:53:01 -0400
Received: by mail-lf1-f52.google.com with SMTP id q6-v6so1325067lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5gXg+gzvLr6ZKO4XCtuSRE9lpQDdLukcIL+pqZv3AU=;
        b=Dn4hHPSOV0NGTVbcVYEeYKFwdJIv+n3SaWYXSDYYETsNyjpvdnUYYNX/QimW+X+12x
         Mj/XHntuIFNPWiaqdV9ZXhUV7Qe1vaGAz8xnTd2t8DYFs08d3aH7m818InX+4T/qYPG7
         AUH5KjcRsTXhUALlnkKrerQwG0u4/fh6cuYVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5gXg+gzvLr6ZKO4XCtuSRE9lpQDdLukcIL+pqZv3AU=;
        b=SM5ceHxiT/eQ+D9EhMokZMUhph5EyOYCqFoMyKJBEGAx5P/bjp/rSv2q0INAj/yR8Q
         snfKmc66qhOgMZG8PVTarpr+PEADwdcHajLgv3U0H3yaZ02mpGDMRtRayWatdD5kfeJ9
         D2moday+Bn0sPEUJ9MXNpnDB8JnHJboNaU1yt6nqRscbMyUO1g8cTHj+X7GC4+bmlZl+
         URbbRirByzuhz89LhP2JD5l3pVs1s8YfxJfFVtEKlRqGUdyxYUwIvCSB2nvIdauyVka7
         5kgiFqRCA+MDdm2Z4cBbA2PP7olJ0JtTmGtw7xNat/92iHhPWiH26xdHDURYKDy1RW9W
         ZQ+Q==
X-Gm-Message-State: AGRZ1gLloQCQZmdcVezNwb4KKVheCBWkB+jV6FDshmtOi1+9PVjlLMC1
        /YyZVNonLRsb3nKSXhJOPqAYU7RNX1WMtg==
X-Google-Smtp-Source: AJdET5fd8ozNi+oc1PfimCFi0mWJCuIv1SSdhCacYla/H9QyB8jNYmytYpx2877W6nXT9fcmCJ550A==
X-Received: by 2002:a19:5059:: with SMTP id z25mr2642087lfj.120.1540570520906;
        Fri, 26 Oct 2018 09:15:20 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a63-v6sm1641226ljf.54.2018.10.26.09.15.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 09:15:20 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u18so1323143lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:15:19 -0700 (PDT)
X-Received: by 2002:a19:4287:: with SMTP id p129mr1626732lfa.135.1540570519341;
 Fri, 26 Oct 2018 09:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181026100333.GA13268@kroah.com>
In-Reply-To: <20181026100333.GA13268@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 09:15:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjQ7JX-vDAJHy80Her3EO+KeYJqjuBvhQw-=F=hn3T0w@mail.gmail.com>
Message-ID: <CAHk-=wjjQ7JX-vDAJHy80Her3EO+KeYJqjuBvhQw-=F=hn3T0w@mail.gmail.com>
Subject: Re: [GIT PULL] Char/Misc driver patches for 4.20-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 3:03 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Here is the big set of char/misc patches for 4.20-rc1.

Thanks, pulled,

             Linus
