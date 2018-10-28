Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA699C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9264220665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZZjoqpOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9264220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJ2Hbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:31:39 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:39485 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJ2Hbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:31:39 -0400
Received: by mail-lf1-f51.google.com with SMTP id p11-v6so4622321lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeMRQi738ZCHUx/1tyCBXynyhyxwGolNQtAJkoNB4Iw=;
        b=ZZjoqpOuqJW3xe1cQbVtDnDQ2n7l5n/9SpXcFy3Ytpn6r2xv8S9275lGxjWJe0F7eo
         oUpQv1kA+U/PgLBcg7Xb0XfEkGFb4KRN4JlgtNYCNRQbMBeix30znoa8Uz5Xy3ePaZZi
         u9Ai0Js1EWPjmEY5KUkANudpXFFk5fCcyw+4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeMRQi738ZCHUx/1tyCBXynyhyxwGolNQtAJkoNB4Iw=;
        b=QDQqtIyK7U9tCuzQGXtd72xeIA2GXV1R+wpP18qH64WXSNQQ6oLucU6eAAQLH9LWhE
         FV58SU5efz/JXFrqI9+bype1+1D8Bcq4YctYUeeG2Q/ly8qxoqXdjS7jePtsShDuXjjW
         0Lt0D0S8L0IqZE+yM9aIe5rCkGgMPAbrZihtifL3knMkVctXpPOkxNFXnP7PG1MEgJpQ
         a5QN3+yySgZuMiEpPDoJofpyW4v44NiUJKRON1SbsFUCdMc+Li98J/2JFcQylROVZjnu
         m/QdDCOUkvEcRtzHucXMRBcqEWaHAffAILhF4p1yuTYLL9yU1Fwr548kz5HggYrS5Glb
         HLKQ==
X-Gm-Message-State: AGRZ1gKQGk+UABsouY0EDYRQSlkwUu/02eVq93DROHBQrgwpY/65GlSz
        ubuAyqGG6SDp1dyDrcT87ZMKH3Aptv4jjw==
X-Google-Smtp-Source: AJdET5c8+2d7rbilBEK1lWnsh6zh4ohMlpgS1LByN76eclGvkfQma8oRbJMe10KleyQKYIAPZb75UA==
X-Received: by 2002:a19:5154:: with SMTP id f81mr7075091lfb.96.1540766734505;
        Sun, 28 Oct 2018 15:45:34 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id d21-v6sm967385lja.86.2018.10.28.15.45.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 15:45:33 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id v6-v6so5942617ljc.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 15:45:33 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr1958316ljj.6.1540766732844;
 Sun, 28 Oct 2018 15:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181029093532.38a3888e@canb.auug.org.au>
In-Reply-To: <20181029093532.38a3888e@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 15:45:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi475eRvUDctiWdBWsEB7UYgr8OrpPzrd=xkevUpTSCuA@mail.gmail.com>
Message-ID: <CAHk-=wi475eRvUDctiWdBWsEB7UYgr8OrpPzrd=xkevUpTSCuA@mail.gmail.com>
Subject: Re: linux-next: build failure in Linus' tree
To:     sfr@canb.auug.org.au
Cc:     linux-next@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        liuhangbin@gmail.com, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 3:35 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> After merging the origin tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:

linux-next is back! Wheee..

>   5a2de63fd1a5 ("bridge: do not add port to router list when receives query with source 0.0.0.0")

David?

                 Linus
