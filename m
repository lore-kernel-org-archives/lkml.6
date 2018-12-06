Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1454C20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nUEtgp4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1454C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeLFRHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:07:00 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43960 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeLFRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:07:00 -0500
Received: by mail-yb1-f195.google.com with SMTP id x144so959823ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=St5x4BajvjzpktTvJ9fGLPnVf1FbO6rxvCZkxwXohoc=;
        b=nUEtgp4XO8Oi5L3FZYbrD5Gmy8ugvfSOxMLYU/EmcLtO3rPGlfOVeMu3t40Es9ORMv
         /4C2LTxdM3hPTGglD2wLoxNyaZ0fZ3i0jdtGiv/L1ddRojVlWnJI7wU6io1t3lxBbrfF
         hVLd1nZFPZEaYHq3dB1Xcc6XYWNLPJuBqzNKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=St5x4BajvjzpktTvJ9fGLPnVf1FbO6rxvCZkxwXohoc=;
        b=PRBRKcgX0khZuQII6cUQHXINLNy6I/3+HZmzz/HvWDw9aRQ3IwgPt31suzSEAWFpNX
         UF9UsG1BxBuQt2X9Qv3VJ3mji0GuBMXgbgl3ovOtlYSlp+NLQGrl/XmcVHcoe/ko0GTp
         p3tyzSttqj0Rdk1sHtQuMchqgb57A7oQ04OYVShko8SMdLiCbFDb/ZuIGbdhGgHacTwU
         5Y1mDAiATqyu/GDL96bpOq/AiTmnUZSRU8cFM3RH2BILT8++WQBK33qj/wedmYSnBOnr
         IYso6HY/juWxVJIHjAJzgHqoHolX+lF4P6x/Bzu6hzgwSg27zgZoOHCrvFcl3q64qZvY
         Z4Zg==
X-Gm-Message-State: AA+aEWbUDkc2VtROP2n9Hzy8m6NfFlq4ty3fWXvc4df7qPjWfJuHQD8A
        3lx3I3VvJL60FOWFSqdpzS7bTui2uVg=
X-Google-Smtp-Source: AFSGD/WgSS+chW97IMgzKsxhEoxwp/fYVXhz+FItcD0ovo/ehYK5c0TfLB8WDVm6YJyLyVQSFoILBw==
X-Received: by 2002:a0d:db97:: with SMTP id d145mr29387133ywe.487.1544116019082;
        Thu, 06 Dec 2018 09:06:59 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id j65sm345053ywf.21.2018.12.06.09.06.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:06:57 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id j145so955995ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:06:57 -0800 (PST)
X-Received: by 2002:a81:c446:: with SMTP id s6mr30380855ywj.237.1544116017182;
 Thu, 06 Dec 2018 09:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20181206150156.28210-1-david.abdurachmanov@gmail.com> <20181206150156.28210-2-david.abdurachmanov@gmail.com>
In-Reply-To: <20181206150156.28210-2-david.abdurachmanov@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 09:06:45 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKevZHDW8hRAAh_muFUXsg-WOVCYh3HczjY5qKtR=wYNg@mail.gmail.com>
Message-ID: <CAGXu5jKevZHDW8hRAAh_muFUXsg-WOVCYh3HczjY5qKtR=wYNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: add support for SECCOMP incl. filters
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, green.hu@gmail.com,
        deanbo422@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 7:02 AM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:
> The patch adds support for SECCOMP and SECCOMP_FILTER (BPF).

I built this against linux-next but it's missing seccomp.h. Was that
accidentally left out of the commit?


  CC      arch/riscv/kernel/asm-offsets.s
In file included from ./include/linux/sched.h:21:0,
                 from arch/riscv/kernel/asm-offsets.c:18:
./include/linux/seccomp.h:14:10: fatal error: asm/seccomp.h: No such
file or directory
 #include <asm/seccomp.h>
          ^~~~~~~~~~~~~~~

-- 
Kees Cook
