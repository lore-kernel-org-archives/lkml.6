Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5777EC0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74292081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 01:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HZ1S0+KU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74292081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeKDK2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 05:28:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41088 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKDK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 05:28:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so3728674lfj.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 18:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uPrrmVUOVf5JvFN+qREv8kPxySiEZiBEfJQwqwybis=;
        b=HZ1S0+KUf1b4yJBQh0n8Njxv3xnZl9cvhsC17Tci13dRSRaLi59XdoiuMS7+XkT9MC
         /3yY+VokQayUyd5MoT8iCFoFs9h4L3YCaAg9nw4qJNNAT/qKJdtRtVo5ObfRO7YRgF0V
         7rQ7Tl+8L0/y5AapLRKd+IVI+jC+QTJOJxf+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uPrrmVUOVf5JvFN+qREv8kPxySiEZiBEfJQwqwybis=;
        b=iBJxr+1MFSzIaXCLZO/oBZa3i19gSkOs0PCZxRO7UjL8BXuC8jYTZ5DR9CT4RtXLY2
         4Tz8XA1mx/Bw07xZupGR5S21ImFGozcBNx9ThAOBXJXqXOOBlzsoluVd+DimM11xWocn
         eY+wa+3mhI1N1WkHUnG5/vFwn+EhArY3moSZNXB/tLxYW8PXoyZXc1Y4Gt5zcQO7VM/O
         kfSSlxNhsNwsonFr6srntFoWXcoTVboOlHe7vjIr8m05uIqqQLASbDA4nigmS1UEbL0a
         dLvOiWEFoQ3VRF0h6nX/JUloKt5j6tIOTQN5Gj0QbaRdkgHAZZZwBU4BSHlG5VJ8sRVa
         rqag==
X-Gm-Message-State: AGRZ1gIeKLXNEufKPTPRs6wRFi6qMaggMyNfEe/1hmGzFOBm1ycRv+XM
        PX/ghj/B+EFWdRbewHZzYnkVbpi7VTs=
X-Google-Smtp-Source: AJdET5e51uEaQAXBVnbGHXR89JgekM/vSSoKUdjwKVZu6mNbmOVAFCB58SBjzbzu0d2Yg6jyOL294w==
X-Received: by 2002:a19:4e9a:: with SMTP id u26-v6mr9401469lfk.91.1541294138706;
        Sat, 03 Nov 2018 18:15:38 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v17-v6sm134581ljg.32.2018.11.03.18.15.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 18:15:37 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id w10-v6so2268971ljh.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 18:15:37 -0700 (PDT)
X-Received: by 2002:a2e:3e06:: with SMTP id l6-v6mr7584344lja.148.1541294136906;
 Sat, 03 Nov 2018 18:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181103230322.GA62400@gmail.com>
In-Reply-To: <20181103230322.GA62400@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 18:15:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiC_4gixZiquvZGpDu6rhCE0dWyk4O440jZ3jt7dffGuQ@mail.gmail.com>
Message-ID: <CAHk-=wiC_4gixZiquvZGpDu6rhCE0dWyk4O440jZ3jt7dffGuQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf updates/fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        acme@infradead.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 4:03 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> These are almost all tooling updates: 'perf top', 'perf trace' and 'perf
> script' fixes and updates, an UAPI header sync with the merge window
> versions, license marker updates, much improved Sparc support from David
> Miller, and a number of fixes.

Pulled,

                       Linus
