Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682DFC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC4F21EFA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EfjUTFNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC4F21EFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbeHITln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:41:43 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52900 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHITln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:41:43 -0400
Received: by mail-it0-f66.google.com with SMTP id d9-v6so1259836itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=la1oX93GBn15PIkbBPiUsj6AGZNnQ+90mcVLY2Zz2DE=;
        b=EfjUTFNxpT1mak+/0l69RIhVbzKFXd7jMtGwyeRBj1CoWGqNysML26Rhef9ZaPc/lc
         J7CP1ldJe54VzyRmPLcdcWiS7cwL20HMM+ohy34txFbhFASSOSxZWl0EszWE9EUcBwR1
         YNWar9ehdEbE5c/kv/xCqfsCE0+fEHizc4+ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=la1oX93GBn15PIkbBPiUsj6AGZNnQ+90mcVLY2Zz2DE=;
        b=RtTTS52IG6dlkr2J+Kh7focdwRLJoLqlNA1PMdqCnV+XwHkaCu3JMoo2Ztqfj632+l
         putdcpT9BISRmezSweMFYwGC6Ku9/yTJFPb+pdmLhTbktnCmOLgB7Tlz0y6Qwi1IDVOc
         qESrCZxdoXoCQZa5+HmTPv/ZViy3iGub5y5uqyhHvU/1uNcwvAuEoinT/sUOJJbU6Psk
         HyiU3pc0EcnPSQN+1jVOsvLvpzyJR/4L9NVcYRZUwWPJKAXV5IsMFxmXMxgh6ykfIar0
         DLPb4/tyan6Y0qLygssTpV2ecRr9S2STEtP6V1jcGFqlasHtj8f0CiXqI2GlgacVrBZB
         Vr3A==
X-Gm-Message-State: AOUpUlGEGoTlqrI/0uze3tBXyGOP8XGZIe3XlM57ZqZ54UDo82jG5hHE
        U0DBbVsLZOScBiAOGwXPi7GL9IV77P3FK7vuPEGtZSYt
X-Google-Smtp-Source: AA+uWPxddvnpBw6zUmhhrc5EIdnIfWCBFn8lqMDrFhH2HSq/u0oh64CZnLc9FBQFkBul+EkhrZtB5xglY4ruIRMX+Do=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr2636407ite.1.1533834954327;
 Thu, 09 Aug 2018 10:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <87wot0yqsx.fsf_-_@xmission.com> <20180809065605.32345-6-ebiederm@xmission.com>
In-Reply-To: <20180809065605.32345-6-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Aug 2018 10:15:43 -0700
Message-ID: <CA+55aFyuJHWW__t_Pq+AqVhiGOVnbd7wKKdX8AH8YUzfzb0=YA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] signal: Don't restart fork when signals come in.
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 11:57 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The code was being overly pesimistic.

Pessimistic.

> +       if (type > PIDTYPE_TGID) {
> +               struct multiprocess_signals *delayed;
> +               hlist_for_each_entry(delayed, &t->signal->multiprocess, node) {
> +                       sigset_t *signal = &delayed->signal;
> +                       /* Can't queue both a stop and a continue signal */
> +                       if (sig == SIGCONT) {
> +                               sigset_t flush;
> +                               siginitset(&flush, SIG_KERNEL_STOP_MASK);
> +                               sigandnsets(signal, signal, &flush);

This looks odd and unnecessary.

Why isn't this just a

        sigdelsetmask(signal, SIG_KERNEL_STOP_MASK);

since all of the traditional stop bits should be in the low mask.

I see that we apparently have this stupid pattern elsewhere too, and
it looks like it's because we stupidly say "are the RT signals in the
non-legacy set", when that definitely cannot be the case for the (very
much legacy) tty flow control signals.

                 Linus
