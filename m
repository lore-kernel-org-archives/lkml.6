Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A46C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5877820866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E77K85Fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5877820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeIJReH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:34:07 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34075 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:34:07 -0400
Received: by mail-io0-f196.google.com with SMTP id c22-v6so492042iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/SVEyUIqd7c+mR/SMjGT+7jSViUYdBXOKQNPpyg1mc=;
        b=E77K85FgHRuL0rtkDBLQNnftKXo4lsYXK72g2ZRDgD+tXFYyEGJ5z7KpYyjJq/mOxn
         lD+n6uGc74ZIvQ2XkkLJt38w7TMZwGw+MEmwpkzuvV8dmOY9pEQs9VgOWelnaUbeAdu9
         eHuDF1UKK6Q9Opvnhd+p6J8jfzq8IDM+zV2CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/SVEyUIqd7c+mR/SMjGT+7jSViUYdBXOKQNPpyg1mc=;
        b=Q/v3XwDB5UGpfen4Uhx6uFG6lLT/jKJ1Svfg+FCB7j/Zzg7GLbBQ0QqO1XHFnLqH61
         27ncQau/oFu+hp69GeKJUC2DsHxEoEa+9iXgP8DGbjh2kRXlyDgGQeEdVwviTPGAVflc
         rRNEWVTueyQi3uh5OeITpHRL4hTXIgtkeMPgD088ZD9nd4GqNU2hqY725JjPTpwhBuMD
         11i58oITS0BQLGY1cvZmwqroMKIEhQClWhsJgocrZ8cCYM6BLBCKAD0XECTRZWCXxm5u
         hTRHRqSj+3ss+w1Zr25fh0ZWbZMWPEJba3talemaSpSN0isPNaBHrdhT13jQCqhcPSWS
         dtuA==
X-Gm-Message-State: APzg51Cq4/yciz6nTmP983QtHlzQx/ErW4fJHSTrL+Z1CUFrA49Q9DHN
        P9+seB9zfGvImdPbgMb3I3Mfnpmz+KXDsqEthoDomg==
X-Google-Smtp-Source: ANB0VdYVxI+IyjhAdrIX8hJYt5/rysnlQXLIBnoduz4R7u+XM6ZiIqZWvEEwt4MM+hda/fpSACXM+8vK+E+ZTLEXQZw=
X-Received: by 2002:a5e:8a0a:: with SMTP id d10-v6mr15402927iok.183.1536583213265;
 Mon, 10 Sep 2018 05:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 Sep 2018 14:40:02 +0200
Message-ID: <CAKfTPtAt4Lmyi6Cx6FGwBJEF8+V14L+N3HeiQRvnStQwmWjygA@mail.gmail.com>
Subject: Re: [PATCH 0/3] sched/fair: some fixes for asym_packing
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 Aug 2018 at 17:56, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> During the review of misfit task patchset, Morten and Valentin raised some
> problems with the use of SD_ASYM_PACKING flag on asymetric system like
> hikey960 arm64 big/LITTLE platform. The study of the use cases has shown
> some problems that can happen for every systems that use the flag.
>
> The 3 patches fixes the problems raised for lmbench and the rt-app UC that
> creates 2 tasks that start as small tasks and then become suddenly always
> running tasks. (I can provide the rt-app json isf needed)

Gentle ping on this patchset

>
> Vincent Guittot (3):
>   sched/fair: fix rounding issue for asym packing
>   sched/fair: trigger asym_packing during idle load balance
>   sched/fair: fix unnecessary increase of balance interval
>
>  kernel/sched/fair.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> --
> 2.7.4
>
