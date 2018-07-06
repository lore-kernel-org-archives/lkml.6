Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E5B23FBE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ill90uJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E5B23FBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbeGFQMI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:12:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46906 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754058AbeGFQMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:12:07 -0400
Received: by mail-io0-f194.google.com with SMTP id p7-v6so11288770ioh.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDaUleu2O0fmuxL9b/nw44tWBERFKcXnH2GYg7PIybQ=;
        b=Ill90uJK2h+vxUfdSY58S1qKpyZM8V2uC5EzUzDJ9XpQwWxCzGrTpLE5YKwntQfbDS
         BH/kPsoTsxh3X2LENrHwEyQmtFJZPiN6pbaGAupDnuVcikR/1VwK0xmGyJ5fJKsbREU8
         l2bLZ++Tl+tdulqaGcsCCPQ20c5J/vRUL+0X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDaUleu2O0fmuxL9b/nw44tWBERFKcXnH2GYg7PIybQ=;
        b=cjkkK/j8sZCcTmOakAOdc3UaF1CmMHBobJoG83jVApD7ltD9w3KuG58a3h/k6SgvqO
         cXqgxREriGQzCyTi4c30olrCBLBML77mIzEvx8HhPHRoYaMqJJwBJMSiZcI0jtpPUFyl
         LxwioN6NAXEpmppFlJSJwtWD07jKHrDeM1LSgj5aG5W83RSNwEYPmZmZduAxCt+ry1UR
         TX/BRIe8xp3pkrzr9QFNyh5qma9gm7USUWE5Tb2Us/7hiQg9pJ26E4R34RiOvmKiEILS
         p/4KWCxc7PuvhIt3HaA7AL/fTcoj12Fb6JvXE0JKt/iVza5PFSoOJM902lEb9/Xzy37f
         Bk+A==
X-Gm-Message-State: APt69E1Af7ulsxo3m9ffF3JPJO1o81Vzngwpt9+Z1AfjjiAyzCGe4YI1
        YgJYBNY4774R9v/Ar4KneU6GmntWRZzIwee3J2ySw6Mr
X-Google-Smtp-Source: AAOMgpckkAuOGhOnYWZg04T7CTBXzlepiZebV2D0GD0oKvu4HtYdY7QZL4S/B+uRn304iUVhSuW78BYzkuI8vAyEoi8=
X-Received: by 2002:a6b:980e:: with SMTP id a14-v6mr9380161ioe.238.1530893526608;
 Fri, 06 Jul 2018 09:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <1530871650-3582-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1530871650-3582-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jul 2018 09:11:55 -0700
Message-ID: <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
Subject: Re: [PATCH] uts: Don't randomize "struct uts_namespace".
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 3:07 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> I noticed that makedumpfile utility is failing to check kernel version, for
> it depends on offset of "struct uts_namespace"->name being sizeof(int).

For something like this, we fix makedumpfile instead. This is not a
"user program" using system calls etc, this is something that delves
into the kernel dump and tries to make sense of it.

Where is the makedumpfile source code? What is it trying to do, and why?

One option is to just say "hey, you can't make much sense of a
randomized kernel dump anyway, so don't even try".

                 Linus
