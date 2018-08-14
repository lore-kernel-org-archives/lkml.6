Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20AEC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD692146E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD692146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbeHNNzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:55:00 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40402 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeHNNy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:54:59 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so20603231qtj.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 04:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ln+PyCX7h6hV9VxQYm9jReV/nbyk3bXdJwMgsNeXCjE=;
        b=cCAmEY31fHN1AgVNNMAE30nX2GddnF3yxh+SIzMRIzlaiCb1oeiMs79suthQlJEmJH
         7lwdj6Q09Xzr6GD+Q1usQ9y6oi0QOW3gXFw0EONS10TMEx/tOF91XcasJD7QfzP3vS1i
         KdKwg9fVYcHEoiRexRuyu8iM6blsgltZiSow22xr8u985g6nWOq1rb5HhBXgN5VcTeax
         PSu5dAcevWViLj2kS6oXF2yTAcBpx3vNml5KllqI/n+ZeT5W8O7bOYTHvZBuI7cCjbb9
         qGb0aEiP4gRziRDPW/TQrv9Tq9HaqyVaBjMW3txRhvBgdTnRyZxESK5pwPXDZb/baKBL
         z+kA==
X-Gm-Message-State: AOUpUlEh7gsbICTVNUbcUXlii3y0CPoQQ+cS0Lp/FyCtUn9hDfq8Nocy
        l58e7bsqkzDvwvb58GZp9L8hg39ni+ck/FYVYHI=
X-Google-Smtp-Source: AA+uWPzyw0i2mWyH5QCmHRCTgyQnypoOTzWTbsnPQZEeCIkpYZYDO58O5PTqsMIj7DwLkVxda8LYywpABxyKwMFVW4w=
X-Received: by 2002:ac8:18eb:: with SMTP id o40-v6mr20721540qtk.163.1534244897692;
 Tue, 14 Aug 2018 04:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180813220950.194841-1-arnd@arndb.de> <CAK7LNASVE-vZhGyAsWg8YmPb8P-sucwPVOUt5qsfVwZQuHg9gw@mail.gmail.com>
 <1534233405.3547.4.camel@sipsolutions.net> <74bd14d45d2b47978218517093ae9de1@AcuMS.aculab.com>
In-Reply-To: <74bd14d45d2b47978218517093ae9de1@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Aug 2018 13:08:01 +0200
Message-ID: <CAK8P3a2-rQ2wp77dHJv9sKg+0oZrnNqMxGGJmyMWxBSfL03LKA@mail.gmail.com>
Subject: Re: [PATCH] bitfield: avoid gcc-8 -Wint-in-bool-context warning
To:     David Laight <David.Laight@aculab.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 12:04 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Johannes Berg
> > Sent: 14 August 2018 08:57
> ...
> > > How about fixing the root cause
> > > in drivers/net/wireless/intel/iwlwifi/fw/api/rx.h ?
> > >
> > >
> > > #define IWL_RX_HE_PHY_SIBG_SYM_OR_USER_NUM_MASK   0x1e00000000ULL
> > >
> > >
> > > enum iwl_rx_he_phy looks really strange.
> >
> > Why? I don't think this is a problem, the enum is used here to get
> > constants so that we can also have documentation for them. That's a
> > common and accepted technique.
>
> It would be much more useful to indicate where the values are used.
> Such a field/parameter could (probably) have the type of the enum.
> But, at some point, the compiler might start barfing at that at well.

I think the compiler warning here only happens because one uses
a compile-time constant expression that is not a numeric literal value
into a boolean operator. That doesn't mean that there is something
wrong with the enum in particular, or that enums cause a lot of
issues elsewhere.

I would also argue that generally speaking the BUILD_BUG_ON_MSG()
should try to either produce the specific build failure it was designed
for, or not produce any output at all, rather than something
that is more confusing to developers. If we want to enforce
passing in number literals here, we should make that an explicit
check, or otherwise allow any compile-time constant values.

> There are also a whole load of crappy __packed in that header file.
> There might be one or two 64bit items on 32bit boundaries but
> that can be solved without using __packed.

Agreed, this likely causes problems on architectures without unaligned
load/store instructions that end up doing byte accesses to the descriptor
fields, which in turn can confuse the hardware, and can become very
slow when they live in dma_alloc_coherent() memory. That looks
like a completely unrelated issue though.

      Arnd
