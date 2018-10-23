Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF6C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A669820652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V/YE+4WT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A669820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeJWRi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:38:27 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33728 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJWRi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:38:26 -0400
Received: by mail-lj1-f182.google.com with SMTP id z21-v6so666228ljz.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cdq61X5ZIPSZJQikfcCgj7KrFc7nzI1sgBymX6lrKM=;
        b=V/YE+4WTmkIShIh7qMI7dTEyOaRL/6zeDrkeKbQpJAwrphT9/3DcgICd/RZH8j6XEb
         aNl+9W2CtF9ALChgQd3D2iH/vvtsl+vUCKOxLtEQBnKFGVNtHSnRRxibdWmt5KOVa6ES
         xwl9zlUT+C/wsoo9gK0BrbYrl8WVlv/DW6cuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cdq61X5ZIPSZJQikfcCgj7KrFc7nzI1sgBymX6lrKM=;
        b=NHrFt6i6cuN1aAWcCaVvH2J16hk8LTmVKkT33/DE/B+Kfaa8vAjRLe/eTnTrg9stQW
         sPO8q0F2CWg43KP9pg1TdvX/yHiXgTD0fnRHbNGsIUqS5LDQ4pDB05epGI0X3YdkWqqE
         zNiogs/m1XycV5XFJTdMMZ//RSRZk43bsdMZCJuR0prcAKU/f22h7FYqwQiJsaK/xIIy
         1nU0XdTca7RB3IfndiuSezGjHoeli7qkZv0azterKeiTTvhQAEbHQInr9rSGLuDio4IV
         8vLxqWAKtKXN1TZS2/SPEdku2CWed1E2abKI795x7cPgFlnvAqMsLmfybVMkt3cJ9uZb
         Ohpg==
X-Gm-Message-State: ABuFfogAJPc1llJPXXX6p/b1oK2AtIk/jWqv80SMa0xL68dQqKq/DitT
        LlPZ+s40Mg1cBy496rRBh7KOTEVgHQHl2v1d
X-Google-Smtp-Source: ACcGV62JqleStk10XIOeYiYli24Vd0sQQBUj6JDpxg49JI4YjEBuTRAfSv/GhqmyPzWTcZCsFLHemA==
X-Received: by 2002:a2e:7e07:: with SMTP id z7-v6mr13416946ljc.84.1540286153153;
        Tue, 23 Oct 2018 02:15:53 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id g79-v6sm128652lfg.56.2018.10.23.02.15.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 02:15:52 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id r8-v6so634289ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:15:52 -0700 (PDT)
X-Received: by 2002:a2e:9e56:: with SMTP id g22-v6mr12370664ljk.120.1540286151727;
 Tue, 23 Oct 2018 02:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <20181023090245.GC23341@1wt.eu>
In-Reply-To: <20181023090245.GC23341@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 10:15:36 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgMCXxVuc72tA7kWJDpnZXdk-TrWfaRy1i_BdcBrAN70Q@mail.gmail.com>
Message-ID: <CAHk-=wgMCXxVuc72tA7kWJDpnZXdk-TrWfaRy1i_BdcBrAN70Q@mail.gmail.com>
Subject: Re: Git pull ack emails..
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:03 AM Willy Tarreau <w@1wt.eu> wrote:
>
> On Tue, Oct 23, 2018 at 09:41:32AM +0100, Linus Torvalds wrote:
> > Because yes, the second option likely works fine in most cases, but my
> > pull might not actually be final *if* something goes bad (where  bad
> > might be just "oops, my tests showed a semantic conflict, I'll need to
> > fix up my merge" to "I'm going to have to look more closely at that
> > warning" to "uhhuh, I'm going to just undo the pull entirely because
> > it ended up being broken").
>
> Is that a big problem ? I mean probably those who need an ACK just want
> to be sure their PR was not lost between them and you.

That second case is what I personally suspect is the best balance
between convenience and "works most of the time".

And the "tentative pull" is almost always the final one. In fact, my
previous flow was to only send out emails in the (rare)  situation
where it wasn't - letting people know that I _tried_ to pull, but
there was some issue that resulted in me unpulling after the fact.

And that email wouldn't go away, so if I first send a "Pulled" ack
message, and then something bad happens and I unpull it, I would send
a second email anyway saying "oh, oops, not pulled after all".

I'm actually slightly hoping that people will just say they don't even
care, but I suspect people _did_ like getting the ack emails.

                           Linus
