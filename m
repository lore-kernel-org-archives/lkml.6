Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0E5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77532145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77532145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeIXNDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:03:24 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36689 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeIXNDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:03:24 -0400
Received: by mail-vk1-f196.google.com with SMTP id i2-v6so3807173vkg.3;
        Mon, 24 Sep 2018 00:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVaj5ipFB4taBFqVy1g9MH1AMLK8HQ2qwy9Kx9UUBmQ=;
        b=kkC2+I+BAkE6kk4HlOM4HEkC01iAflm6e/7IghpmGoYgQIi2Cjr6aCEdSsTK1UixFs
         COgMgEoV6G6phw+MGokWXUjvkiUVf2z004vgj9+gS7dP/Hrqjc0j2wRBn0BC13nwfpUo
         jglxyfxSY1jo1KqSN6AyIPWhQmBSXraqfDgjMslOGxLbEf4E86Vl7+y+gcDM2YrEJYvn
         pcpJVimei2cKKt7gQtDVRSwDXvntC4pFT9Sg2IoAnHYb7Li1/OE96TS/3OM/ZXdrvlRD
         MnzkR3vfAag+ZhYpo5/8daTYh3wEWUdjV3MNNLLsJjNDBbcWqKFAjZNeTN9ynZyj7V++
         Whgg==
X-Gm-Message-State: ABuFfogC5b93w5byUBbHPJLwa+DJD2HbcEPtJPp50UXuFM5JG6TWdYsl
        8b7GSsZDlLVzj+jAX9S/3CTeFLMgpaLxJEp0tBc=
X-Google-Smtp-Source: ACcGV61CO7kaKk5y5nTdDNqmXPq0aSm0lpyrO5uWkbp4DKaoLir7QKuljTX7BMf7GXsd0pRurSOZ70lyENJETp5w9C0=
X-Received: by 2002:a1f:d507:: with SMTP id m7-v6mr2111262vkg.40.1537772565117;
 Mon, 24 Sep 2018 00:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-3-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 09:02:33 +0200
Message-ID: <CAMuHMdW3pdx13sdDv3=7WbTt5Hse4MrGDHoCwhA3w7iJ29eAcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] m68k: Replace NR_syscalls macro from asm/unistd.h
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 5:06 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> 1. Update NR_syscalls in asm/unistd.h manually by counting the
>    no.of system calls. No need to update NR_syscalls untill

until

(scripts/checkpatch.pl would have told you)


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
