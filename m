Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176ADC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01232082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LS0hobQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01232082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeJ3Oty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:49:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40472 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeJ3Oty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:49:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id m15so9978777otl.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9659gKsENjzFZdj4LaH+/Gc5K4RvOlSdxJoFlwmH2sM=;
        b=LS0hobQxARlID8NxmCxyatZFtxIS5dc+nShjf8N7k/7QmvFAmQIjB7fgUlk4gP1r9O
         K+wSnFx3y43uryCcEbtVVGJk9R+paYhoIsF9pA1+fr74xGTw2HcvYVeZNNxRVNATqUUR
         9LtrL/3kSpJgApPFTspcq6We5wiy+P6/wnrDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9659gKsENjzFZdj4LaH+/Gc5K4RvOlSdxJoFlwmH2sM=;
        b=WrGKURJTSseAEtZwU8HHzKHxddR3jBPw26iDWDgzYcuYEJQ29V5bFdi0v1VSD+JNyP
         WQ0dI/LHu+j6BLk/XDK8p/paWvQiJ8DWs0ZWJRz2GrSkjWdD282fqKdPKifSEW98vKF8
         1faHSw+5o1wNQgOtmA6rMeGKtSU20LJ3c8F64xrz4XF7rtGoxdMG5HfHloot1v++JWSX
         au8DyfnK5v60dFLz8h+TmWEeE/OlNjqZrv9oTNvAB+Hy5CpdliFFDmMWFc3sGllBVpqm
         OGbAOep0wA+tsj9qt12mI3Pm0sA3ex+JUoRt34iN7DKzaKJpG6rPJB5tf0oQ/rZ2zlxC
         /ZDQ==
X-Gm-Message-State: AGRZ1gKMO2IGfqQNUOv+0KpNDjR85KrCB/FyM76wYj3x+m3xncUGKY9k
        EFi3ChsYKNT4HgSqHFtQhomORAMg2F1mR/I+qaw=
X-Google-Smtp-Source: AJdET5c7+9VH9y2n8M/inWMOMavo9UgQX6kYtkXbWZmdZLR3uIFSAH7n8TnUdiaHUvfYL110TmdBiPCOuTbZTFCH798=
X-Received: by 2002:a9d:4492:: with SMTP id v18mr11497718ote.282.1540879069524;
 Mon, 29 Oct 2018 22:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org> <1540830201-2947-2-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1540830201-2947-2-git-send-email-daniel.lezcano@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 30 Oct 2018 11:27:38 +0530
Message-ID: <CAOh2x=my6pusOOgKNhk4O3iE3TaTLjeZ6q86MdH4q10BB6dnEg@mail.gmail.com>
Subject: Re: [PATCH 2/4] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kstewart@linuxfoundation.org, Juri Lelli <juri.lelli@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 9:54 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The mutex protects a per_cpu variable access. The potential race can
> happen only when the cpufreq governor module is loaded and at the same
> time the cpu capacity is changed in the sysfs.
>
> There is no real interest of using a mutex to protect a variable
> assignation when there is no situation where a task can take the lock
> and block.
>
> Replace the mutex by READ_ONCE / WRITE_ONCE.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/base/arch_topology.c  | 7 +------
>  include/linux/arch_topology.h | 2 +-
>  2 files changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
