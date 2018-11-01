Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F71DC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4819B2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X0kCR/tI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4819B2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbeKBBbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:31:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42284 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeKBBbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:31:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id q6-v6so14606567lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0Eis5kZeCYTKiKrzatZwcHwlUp0InGER0lXLFHN+a0=;
        b=X0kCR/tI7UpHrnmpFGB5BhwPRD0u4O2KvoyBZV+HLWEP89Mf9K31ggGk5wyPwr3fxv
         x/DTtA6Hy+XM5HIQtRlnZYUPgLNwd52xAlDWu2UqtaQL0aNnsodW9T3ZSrmz/bp7LOx5
         te2dRPkr1vOmZKyQ5vhw1dikBXwEKUN7YFEjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0Eis5kZeCYTKiKrzatZwcHwlUp0InGER0lXLFHN+a0=;
        b=ptVn3PIEeu4LF51kXyB+JU8kLaETj/VGgmcKSVLx/DN7aLFaN6vNQWTl1S/sQo/QW2
         qyn4ochgacoKBrkemkFg6Hb2rWELfiiT/TPHgFlSQi+IqVEy8cPR1CKVz8aB07GRTHr2
         10FHqxMlSg5SsnaDX8cOawxXQTPbUBsDdkFZBHSLFqcwEgQwwBt10JlHtRiJK9jAdB+F
         MXbVpDbkNz5XZEbbN3n+ze9zCj8IWIVH61QpnhE25/CS12kNeIcqLvbBozX0XddBwvcD
         amfr0YK/r0JkDBupNR9CoD6c4If2xMjceKSINezMnL7doMyVJ/CEuXZPPrbCTQIISu2o
         HmRA==
X-Gm-Message-State: AGRZ1gJhn4xvxxLx7IifvcVQUX7+kSZFjEVAWFCrNrvgEUvP387u8/lI
        QepIK4moOwHCl7pT1Th0EQ3vetIpl2JeVA==
X-Google-Smtp-Source: AJdET5f7uRbsnRrO4kRx6XII9uW9nxSLbSMu6+H8oSJxQmh8zer8Na42WmFD5kY7k8f/9vtY+2c/hQ==
X-Received: by 2002:a19:9209:: with SMTP id u9-v6mr5075338lfd.26.1541089658670;
        Thu, 01 Nov 2018 09:27:38 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t15-v6sm4605982lji.75.2018.11.01.09.27.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:27:38 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id k19-v6so10071678lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:27:36 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr5434532ljh.118.1541089655958;
 Thu, 01 Nov 2018 09:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181101063523.26bdbe28@bbrezillon>
In-Reply-To: <20181101063523.26bdbe28@bbrezillon>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 09:27:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3r8QmJGKep9PK-8o3HM1-4aJJqQKsGaZJAk93Ad1pNw@mail.gmail.com>
Message-ID: <CAHk-=wg3r8QmJGKep9PK-8o3HM1-4aJJqQKsGaZJAk93Ad1pNw@mail.gmail.com>
Subject: Re: [GIT PULL] Addition of the I3C subsystem in 4.20 (5.0)?
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, wsa@the-dreams.de,
        Vitor.Soares@synopsys.com, pgaj@cadence.com, rafalc@cadence.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:35 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Greg, I didn't get your feedback on v10 of the i3c patchset [1] where I
> was asking if you'd agree to have this framework merged in 4.20 (I know
> you were busy with the 4.19 release and after that the Kernel Summit, so
> that's not a surprise), so I'm sending this PR. It's really not an attempt
> to bypass you, more like a ping that, if positively acknowledged, might
> lead to inclusion of the I3C framework in 4.20 (5.0?) :-).

Regardless of any other issues, this is now too late in the merge
window for me to accept.

Yes, the merge window is two weeks, but that's not because people
should send me pull requests for two weeks. A large part of it is that
it takes time to merge stuff, and I want to have time in the later
part of the merge window for things I have to look at and ponder.

So that's why I want new stuff to be ready *before* the merge window,
and I want to see the actual pull requests early. The two weeks is not
for development and to let people delay things a bit, it's to make it
possible to synchronize and to work out issues.

                  Linus
