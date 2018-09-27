Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185EEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA7721570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA7721570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeI0OYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:24:51 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43607 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeI0OYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:24:51 -0400
Received: by mail-vk1-f193.google.com with SMTP id s17-v6so375356vke.10;
        Thu, 27 Sep 2018 01:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJNbFuJ0kV7hB7mHjfPlsU9KuN4o91nxVWuCudniyrI=;
        b=ru1RNQsj0CSLfQh7fPrbynnWV+czcN11W6SdFFHUkZCpnAylWBOLdfg6pAKuukED/8
         BtTolA2ky2/vllyOzCdEfby+TxE3Ba1JSMpk5x0LlOlcyyV9zY8m4Rb17YpydVzhp/H3
         W6zpoiXbshQqZbyTs4WsFUholxNEtTFbKhs7aW/zg7SXVNKzcNfOey9rWhynByLIed5a
         yk0mLLqR3yaSYrWkI1uWr6IIYvHyjOAaw0es8mwr5ST7i95DhFVChMKRErbBnoHpfgzA
         dB6M/l52DEY6EveY4/nbrgfJkm1jLuWrX+3sHutG56Lt9XSIny34mgfWqNievDearhTU
         JoMg==
X-Gm-Message-State: ABuFfogCE2qPbETZ3WzkbIOJl0VsN8ASFN+8CXpAAVKL33iQ72vjLNcZ
        UXIFYd9p9bzxGn9iK9abOR0kvQbw6MgFFR9brJQ=
X-Google-Smtp-Source: ACcGV618A8xposbRSHXhRSd9pgLLyB2T4BOA9kH8+SBXVxFbTN0yj9/jwjBO02q4B+QmmfzQhB9lRYOlUbwgG9yF1v4=
X-Received: by 2002:a1f:2d56:: with SMTP id t83-v6mr3119770vkt.65.1538035670676;
 Thu, 27 Sep 2018 01:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1808301702450.1210@nanos.tec.linutronix.de> <CAMuHMdXASyzFpLp7RF36HWZcDdQcvdZ+JsmSn+Az8ZHcFLJ1zA@mail.gmail.com>
In-Reply-To: <CAMuHMdXASyzFpLp7RF36HWZcDdQcvdZ+JsmSn+Az8ZHcFLJ1zA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Sep 2018 10:07:39 +0200
Message-ID: <CAMuHMdXyAQP_GYyHXJd7qq1ww25TbVs5QONDTqzLK_arGiLeMQ@mail.gmail.com>
Subject: Re: [PATCH stable] tick/nohz: Prevent bogus softirq pending warning
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Crispin <john@phrozen.org>, frederic@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Sep 12, 2018 at 3:56 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Aug 30, 2018 at 5:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > Commit 0a0e0829f990 ("nohz: Fix missing tick reprogram when interrupting an
> > inline softirq") got backported to stable trees and now causes the NOHZ
> > softirq pending warning to trigger. It's not an upstream issue as the NOHZ
> > update logic has been changed there.
> >
> > The problem is when a softirq disabled section gets interrupted and on
> > return from interrupt the tick/nohz state is evaluated, which then can
> > observe pending soft interrupts. These soft interrupts are legitimately
> > pending because they cannot be processed as long as soft interrupts are
> > disabled and the interrupted code will correctly process them when soft
> > interrupts are reenabled.
> >
> > Add a check for softirqs disabled to the pending check to prevent the
> > warning.
> >
> > Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > Reported-by: John Crispin <john@phrozen.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > Tested-by: John Crispin <john@phrozen.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: stable@vger.kernel.org
>
> Fixes: 2d898915ccf4838c ("nohz: Fix missing tick reprogram when
> interrupting an inline softirq")
>
> Issue in v4.14.x bisected to the above commit, and fixed by your patch.
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

This issue is still present in v4.14.72. Can you please apply Thomas' fix?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
