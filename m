Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F3BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C131020892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O62q4oKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C131020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbeLFStA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:49:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40964 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLFStA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:49:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so1133152lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyCoiXyFqSeWhvxHcq15yWsstice4uxO0GdGy4qiNc8=;
        b=O62q4oKElVM4GzAl+jHnGYR50urN6G+g1OW54LQTMFT3eTwjycs4K8+bnOS79TpLFI
         eou+htBDD0QJRJR81FES1Hh5PZz48OGNuKEzsAnZICYm0xkoDCFm3F6pRjJh1IvQw0Uu
         q9XF5v2XJIMA4pZHq6OrVRU4BCr2ocXtcvx5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyCoiXyFqSeWhvxHcq15yWsstice4uxO0GdGy4qiNc8=;
        b=gX5GjF/Xbjuh2Gv26jYHdyAZ4bkWsoVdaoLERePcY9dk0goP5tyZNoBG58wnaoRlQr
         ENkbt3khmddy4iWZvQz125w0j6DEYSGywBs7ErYs5HPXdFMTppzRotkGzzwFtH9R8hLl
         MIcKskLFQ/oIjCjlzlMXojy2Qc8QGFeg66sudsVpli+mIwkxIvIbXv8S9n5GpoEZzqjo
         EcpaUyj9uIkTsC8sRMhI5LY/bfEKW0jnxYcipuwhWcuVwbjSKtF/8DjzARBbjCVkQxmw
         zchXciI7Viz/I3KxC8rjZZ+oVtM6t8L75JYanyPJmYN974yz7R90w80HPiJM24zCx5o2
         02PA==
X-Gm-Message-State: AA+aEWYghOejjNOww5YAPBLswy3rYqkGE4cP3PD22bqvq6vjBi5AsZvz
        S4qMrRsatwpZooCow10uqTl+lI95ZYc=
X-Google-Smtp-Source: AFSGD/WdxTS3cdUsNKlO9EOEAXbjRjTS5+Oof93CeuDsco21l0BbAFJcThFQ10M1w43J5PlNGfzaEg==
X-Received: by 2002:a19:a60c:: with SMTP id p12mr18687061lfe.63.1544122137472;
        Thu, 06 Dec 2018 10:48:57 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id x21sm208041lfe.6.2018.12.06.10.48.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:48:56 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id p6so1167664lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:48:56 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr17127780lfj.138.1544122135620;
 Thu, 06 Dec 2018 10:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20181112171144.GI3645@cisco> <87efbqi1xa.fsf@xmission.com>
 <20181112185538.GK3645@cisco> <20181112192443.GL3645@cisco>
 <20181127232126.GA23658@cisco> <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
 <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
 <87zhtthkuy.fsf@xmission.com> <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
 <87k1ktqoe5.fsf@xmission.com> <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
 <87r2euiuql.fsf@xmission.com>
In-Reply-To: <87r2euiuql.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Dec 2018 10:48:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
Message-ID: <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
Subject: Re: siginfo pid not populated from ptrace?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 6:40 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> We have in the past had ptrace users that weren't just about debugging
> so I don't know that it is fair to just dismiss it as debugging
> infrastructure.

Absolutely.

Some uses are more than just debug. People occasionally use ptrace
because it's the only way to do what they want, so you'll find people
who do it for sandboxing, for example. It's not necessarily designed
for that, or particularly fast or well-suited for it, but I've
definitely seen it used that way.

So I don't think the behavioral test breakage like this is necessarily
a huge deal, and until some "real use" actually shows that it cares it
might be something we dismiss as "just test", but it very much has the
potential to hit real uses.

The fact that a behavioral test broke is definitely interesting.

And maybe some of the siginfo allocations could depend on whether the
signal is actually ever caught or not.

For example, a terminal signal (or one that is ignored) might not need
siginfo. But if the process is ptraced, maybe that terminal signal
isn't actually terminal? So we might have situations where we want to
simply check "is the signal target being ptraced"..

              Linus
