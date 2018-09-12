Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9091C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE8020854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE8020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeILTAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:00:55 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44937 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeILTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:00:55 -0400
Received: by mail-vk1-f195.google.com with SMTP id 125-v6so29197vke.11;
        Wed, 12 Sep 2018 06:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RnA06zGJD7iIz4HgLd9rGo3cOJwVe72+D3OtUFTL0o=;
        b=DsUsQj0EQPNtmkS9WJDWB+z3e2jmfLSBvvOO4HOzalpbnB/00R7R4BuzzX7R1bgklZ
         1Mcw7YPM3CqBAY2TXqIEqG0IzmyfSPEmFXBrShzNoCyGwVdm5XERHi5J2+TlF2aKINt+
         UhDJW+HmLqQKg67ZomlBixkZK2kUwtCiYQ15z8uFsP7B2Zw4HrU8sSjDI7T6rsu8S0x4
         DlPgh2tF10kNtIAdTSvzzKcnPPHC15s2OeC6CqzZ29VQoH0DWTuVEbaqwsv7wrAHdt9K
         2IUWYAFwoEV9GdKFFvSRcX7z4ptcV1vO9XzptbhpOTjn6RLPJ8ZHzPYV4PLIlN78R7gw
         /VIg==
X-Gm-Message-State: APzg51BxBbEFJbPMist8975LnwG+OlDUrSTYgfIjJiKXgs3DL0kU3Ia2
        i8IAZs+5SJo5NsHiXXhRHeqMmQY+JIsDna0bqjk=
X-Google-Smtp-Source: ANB0VdbiGS9xuA5KU0caYs2RpI3UCgR82pNov2aTp3pQhmi2QNWmycAx9C8cKK550uTAluj9HlVUQ75wjYtFRkiLC+Q=
X-Received: by 2002:a1f:d945:: with SMTP id q66-v6mr766352vkg.38.1536760576002;
 Wed, 12 Sep 2018 06:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1808301702450.1210@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808301702450.1210@nanos.tec.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Sep 2018 15:56:04 +0200
Message-ID: <CAMuHMdXASyzFpLp7RF36HWZcDdQcvdZ+JsmSn+Az8ZHcFLJ1zA@mail.gmail.com>
Subject: Re: [PATCH stable] tick/nohz: Prevent bogus softirq pending warning
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Crispin <john@phrozen.org>, frederic@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Aug 30, 2018 at 5:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Commit 0a0e0829f990 ("nohz: Fix missing tick reprogram when interrupting an
> inline softirq") got backported to stable trees and now causes the NOHZ
> softirq pending warning to trigger. It's not an upstream issue as the NOHZ
> update logic has been changed there.
>
> The problem is when a softirq disabled section gets interrupted and on
> return from interrupt the tick/nohz state is evaluated, which then can
> observe pending soft interrupts. These soft interrupts are legitimately
> pending because they cannot be processed as long as soft interrupts are
> disabled and the interrupted code will correctly process them when soft
> interrupts are reenabled.
>
> Add a check for softirqs disabled to the pending check to prevent the
> warning.
>
> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Reported-by: John Crispin <john@phrozen.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Tested-by: John Crispin <john@phrozen.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org

Fixes: 2d898915ccf4838c ("nohz: Fix missing tick reprogram when
interrupting an inline softirq")

Issue in v4.14.x bisected to the above commit, and fixed by your patch.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
