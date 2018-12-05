Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAE1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5698420989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RH8qHN55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5698420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeLESsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:48:08 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36519 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLESsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:48:08 -0500
Received: by mail-yb1-f193.google.com with SMTP id w203so5166365ybg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ha+30CfXR6OA1TXPF7n76doZ96fWpsm/eqhYl1bsGMs=;
        b=RH8qHN55Z6d5WPGNRQY1ALJUOt/E1QkcjsZZzHq953iOX4uLhOar7+sPH6Ov98AhmD
         n9krux3dwJzhpYTUwMof6HC1+sCqB9hW02RuayYc+b/qVSV/E8tHlME7ptaQxK5IqPFN
         UaD8GafqS6jPvPVw6AL6MXeslIstP7DduKEAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ha+30CfXR6OA1TXPF7n76doZ96fWpsm/eqhYl1bsGMs=;
        b=txWtA6Lth8uj8Jlx1TbJcSDkGE5rqobQA7mHOGBc+Ipm7fxxeB4ls2dMlda+fxDD7U
         NkWtk9ZFwFiEef553hlyc2D0QUDgb5U4wtZ23FmR3/gbnLFuc8YXr5rfMepjori6XH0d
         owz7+O3UkRNqFR2J63SneRGFOgWWcvYW9Je2KSMEcH3GY0imZAv9TmUYnRLQublvLSg6
         Z6AOxV8Voxy/HHrYo6uVHj3s9MJhBP0oQWd5wUGgTvD0vIgN/Z7YADLJCEeMKp4ApGpg
         MunXjdsmUGMy7dzvR5OVQeRlwkmB9qmy+bmjkz1OTmikAQrPWNi3ln8MCFWRrUcLsWeH
         rP8g==
X-Gm-Message-State: AA+aEWY95sULeGOzgL20e0invhS3J919GQ/SPPTeESPWisGvTxLEnooT
        xI8dgbwzk3C1M81oUK2gWchZ5y7o5ktP/FoESLw8Fw==
X-Google-Smtp-Source: AFSGD/UXhZYeY9L2Q8/xhsm2qJcLkvGFqVeF6Lw6Qyt1UDocGOdo+Dt7Relwvx9M8ujitUCW+0UuEFUTV1/iGdyWuzo=
X-Received: by 2002:a25:ff01:: with SMTP id c1-v6mr25241774ybe.325.1544035687437;
 Wed, 05 Dec 2018 10:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20181205174852.435233070@goodmis.org>
In-Reply-To: <20181205174852.435233070@goodmis.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 5 Dec 2018 19:47:56 +0100
Message-ID: <CADYN=9KcqcwVc+pzPPEUdFuMuPB9_Xo6FVUJ7tooyvH5aCVqCA@mail.gmail.com>
Subject: Re: [PATCH 0/2] tracing: arm64: Make ftrace_replace_code()
 schedulable for arm64
To:     rostedt@goodmis.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 19:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> This is a little more involved, and I would like to push this through my
> tree. Can I get a reviewed-by/ack for the second (arm64) patch?
>
> Anders, can you also test this to make sure that it fixes the issue you
> see?

Yes of course, I'll try them.

Cheers,
Anders

>
> Thanks!
>
> -- Steve
>
>
> Steven Rostedt (VMware) (2):
>       ftrace: Allow ftrace_replace_code() to be schedulable
>       arm64: ftrace: Set FTRACE_SCHEDULABLE before ftrace_modify_all_code()
>
> ----
>  arch/arm64/kernel/ftrace.c |  1 +
>  include/linux/ftrace.h     |  1 +
>  kernel/trace/ftrace.c      | 19 ++++++++++++++++---
>  3 files changed, 18 insertions(+), 3 deletions(-)
