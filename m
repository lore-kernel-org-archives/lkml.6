Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C047AC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8196420825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZqOy4QyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8196420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeKIXoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 18:44:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37880 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeKIXoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 18:44:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so1684356lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDEFGJ/MX0qhAkqCTbcmHAnDUaOKQz3uVxWvtRXNOA0=;
        b=ZqOy4QyYil2OfdUDm8Q6hHrzPc8a6xntTHnqAT0RiZwe5lSvR5yV/HtRuuIk6LGmBy
         M+gwLVg48jAFC1OvtjZO/LsEfusgfzdJDENlNw1poKb9FjipnNS7hgIZBGMeU1mwbizi
         Qzsq3DV7kPCLGuks0Czxbs3hsdKvrNP5Kz3VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDEFGJ/MX0qhAkqCTbcmHAnDUaOKQz3uVxWvtRXNOA0=;
        b=oZa0D9zLLhx+2xguuhhRhJYBZEeA3wC4kV1BxbY4F2moz+uhUqHr1A68jX6JJ9YzFY
         8OkWkIMi/pythp7Y2rfdrLX2zd4Aof07giDvzvcEINGaHAuWstr+/FO95ByL7fBgIiOU
         WuyWofwVLY5dxo0vvvv+hDWXLg25hr/WNAuCrB/33CbF8RkpfvrDp/67hZUVmlaT801B
         EtzRXOmsIycbaYRG59ie6cgRzsIBP5ji+8FoyEqiYfbs7fSpqZotDZBU9Hz00o5Zyfth
         NcS1iyyAeo/NkWTdg/avr9a6CfSmIs+9+FABx263NIfnGYv/gKJoqFYsSQHQZZBVe0l4
         dVfw==
X-Gm-Message-State: AGRZ1gI5e/aREtxL+YaQfGLnL3A1bYstPru9HNlgOBx/NSIJYUH7KIo4
        H4HS3xZWfmtezndcV33LHZmfcKdDJTs=
X-Google-Smtp-Source: AJdET5dqCSA7WCzqI1qZSZkYtqI8XQqCkwnInQOwB8zPwleWI3L4e9IdM5pofWiXyV5GY2Xh8thYBw==
X-Received: by 2002:a2e:8187:: with SMTP id e7-v6mr5754897ljg.50.1541772195565;
        Fri, 09 Nov 2018 06:03:15 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y80-v6sm1350980lfd.78.2018.11.09.06.03.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 06:03:14 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id f3-v6so1667963ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 06:03:14 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr6203892ljj.6.1541772193811;
 Fri, 09 Nov 2018 06:03:13 -0800 (PST)
MIME-Version: 1.0
References: <CAEbi=3dou8JWKYq9FpRBtPKRRu4ahhsh=+kHKcF8vg5hyO2ZGQ@mail.gmail.com>
 <CAEbi=3dCGmCzM7td_-hdsgfpHOVeB_Bc_tFtvWnn1AJqzMbiUw@mail.gmail.com>
In-Reply-To: <CAEbi=3dCGmCzM7td_-hdsgfpHOVeB_Bc_tFtvWnn1AJqzMbiUw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Nov 2018 08:02:57 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgsG7vFfjMU8A3cuOq1KgH7C01tkYtUo+2=fN8qFM+9Bw@mail.gmail.com>
Message-ID: <CAHk-=wgsG7vFfjMU8A3cuOq1KgH7C01tkYtUo+2=fN8qFM+9Bw@mail.gmail.com>
Subject: Re: [GIT PULL] nds32 new features and bug fix for 4.20
To:     green.hu@gmail.com
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 4:01 AM Greentime Hu <green.hu@gmail.com> wrote:
>
> nds32 patches for 4.20

Much much too late for 4.20.

Send these the next merge window please.

                 Linus
