Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3481020870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gVvjCSqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3481020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeJ3DXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41570 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbeJ3DXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so2754546ljb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEnflDjnHG1+HuE9+T+AV5GVwUWj49fcaDumUkxer3E=;
        b=gVvjCSqX43+ykDmkUbl4jX/ayBvNcN4eXXtOEVuM3LmW6h9fRR5TS/eE8wLwH3oHPz
         jmhd8fnobipYX8T28hcv0vqtvRbtYlFRHirlZapp5Ct45jzxDgi8lPFKzecu9/AQW0gE
         SxV/zSRCDCnDtgcS9/+Q0kmvOlsldNPmXvoLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEnflDjnHG1+HuE9+T+AV5GVwUWj49fcaDumUkxer3E=;
        b=KPkC0rfr70zY98aJSmS5K7cAl/eq9EoZypbRllVacyvqz/hzcQ4ym2SBdz57wkZ6Ff
         A8IZB5Q3t13CUBNo80A6p8dnvV/rMandJQr/X80YEOadbyntNek4gWldOdg1KFvyX/nC
         MbyS2wQYQSHkhsqrgmSGrqps/5ZJHVLsvjm72UOPGM+v5yNowiM4zTngS3B/UVVTvOfO
         9eZrad1c2RaQ5TIXBjne/YyL7827JDTOp9DbCiUqaEkV6WfClIe+ZJ8a4cMQtRrOuRBs
         9Y4LEzgMq6W4QXKiiuIk5lfBkDxix2D/hubbqFR8aI07+LpIr0kKOchdVa9bLPmTLNOI
         v4yQ==
X-Gm-Message-State: AGRZ1gLaNgMkRpa6jUNgXhgli2a6a6DF7Jw2uq4BWXPggMh/pi0hVPn1
        o69HLkpa4BCF29ErBD+2mhhz7oGJBKsmbQ==
X-Google-Smtp-Source: AJdET5e6FT8a1se9U9uSDX1YIo2MYP+A9OouFwW7KY9rtCNv+nNGMPKoWIlBk5wdhve4iVj51CCQgA==
X-Received: by 2002:a2e:320c:: with SMTP id y12-v6mr6509622ljy.163.1540837995073;
        Mon, 29 Oct 2018 11:33:15 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k18-v6sm3169711ljk.58.2018.10.29.11.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:33:13 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id n3-v6so6851366lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:33:13 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr8718858lfa.106.1540837992908;
 Mon, 29 Oct 2018 11:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 11:32:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
Message-ID: <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
Subject: Re: Logitech high-resolution scrolling..
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Harry Cutts <hcutts@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        peter.hutterer@who-t.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 8:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Patch I'm using attached. I'm inclined to just commit it, but if
> somebody has a better idea, I can test alternatives too.

I committed my patch, as it at least makes the scroll wheel usable.

I'm more than open to further improvements, but I wasn't willing to
live with the status quo, and carrying this around in my tree as a
patch kept confusing me while doing merges whenever a conflict
happened (because the "git diff" that I use to see the conflicts
obviously also showed my own local modifications).

                 Linus
