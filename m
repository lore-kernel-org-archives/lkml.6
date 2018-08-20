Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA09EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76A320852
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XAhNwujT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76A320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeHTVvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:51:25 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:36969 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeHTVvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:51:24 -0400
Received: by mail-it0-f50.google.com with SMTP id h20-v6so720659itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OuI2MCG4GlNh3e4e88xgDpaUNeV06i824ZpgrNURf3I=;
        b=XAhNwujTvE4hg34XrOCuZ8oGCqwnI4DuYWo9OPLwqRT0JSDE1EWggJ+jqXJwdwgL2o
         KCvEPg7w+HJfEm8L5n+7fIzrj9ebRPFx4lmh3iAYZQ51rqZCOo5iFRlqy9F8qTaPngxT
         zvoSs2JJiQJoWV+9BAYZDboqwYyfuAdl0LQTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuI2MCG4GlNh3e4e88xgDpaUNeV06i824ZpgrNURf3I=;
        b=dmLS9ONh26cDYc/Nts2SCZFLd/ezd3UYixcYkUPIm+OApyuiuTLVzpB7RIwnlZzxXb
         pKruA8V1TfKks9HaDnXP7w44A+W+NIKWNyh+4Sak4/KCwGm7KtpXzZCtnE4LxsSnWe2v
         o2MHJIcJ/d/5IglkPNMHcliQhbVFbR6IUr3R97KqUHDMoD//lXBOm5uNqhj1KNAH6KhL
         Kb0lhTvP4/cL0mSQzlwJYMDgJN45N9i/VnwApEqKrUKdZCM1xz6R9cHWHkJSNFt+yMTP
         hT1f+bj4AAgeInwVlgM+GO84UqY7Ltv4WR+TvbzmGFlCrYdWBgQe+gxshKQrh8AfA8wT
         umEQ==
X-Gm-Message-State: APzg51Ai9FiRQTbhoZQaYTHCn/+Ht2n6BOzsjEVz0z92fA5fwSiSoZGZ
        6FGwVyP2Fxn9SP+Hf3cNwxea5JIb9rwztsstLXc=
X-Google-Smtp-Source: AA+uWPyXIEV+OAQXdYgN1Wb4qIEFETG5hPz5se0awXxJMp7MxoJzZ69NlKF3ED5FJ+1zgLDoR532Q0ajl8BvamDa4cI=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr1105959itc.22.1534790079859;
 Mon, 20 Aug 2018 11:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <4cdd4ab9ddd16f1fb168266643264595782fd890.camel@perches.com> <20180820174655.75739-1-ndesaulniers@google.com>
In-Reply-To: <20180820174655.75739-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Aug 2018 11:34:28 -0700
Message-ID: <CA+55aFzTPCoarqD7=2NFFvZjmZQjr=FhTWMFfLm+UfaF+M_ixg@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 10:46 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I think we should take Joe's patch.

I'll happily take Joe's patch and get the whole "ancient gcc versions"
issue behind us.

We'll come back to it in a few years when 4.6 is ancient too, but for
now we have no pressing need not to support it.

Joe - proper commit message and sign-off?

                  Linus
