Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F880C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF50420874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcqPXBJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbeLQKmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:42:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42259 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeLQKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:42:49 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so9599128ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 02:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Da/nKj92LiTLzN6gmOjFat553E3Faps1ywC2IU+ZEuY=;
        b=hcqPXBJNPp0cw3G3qIdDYDrTqI5e33m0PsPlNlh59Rx4G5v3B9zffIJDNXtYgMWKgd
         eCDWB8nm1GIsRU61ArryN3fk4V59JXAu8GxEmscEG9ziLpJfFL9Qah3SmQNBNdeqIP7p
         Si4mF0GCHe+ME8cg9bIrF0tDWc4wmOFvlS34w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Da/nKj92LiTLzN6gmOjFat553E3Faps1ywC2IU+ZEuY=;
        b=TOOVZFjQgRoxTvxzP7HwvVuD/w+Eghpe/w7/xBGHcjd6PtX4QoxBsHMUnedAmqIq1S
         5ZaHnRt5LLs9p5axnBU6k728B5RlQbwNWOdr0O2RcnhL5oaw4aKVPZ1egLpk78yb/DGm
         tpikcnmO9onlEpcHU/HNz/q5ff9ojFrnxOvcq8JwTv6VaL19Ny0bPcCmCKdHwYJCO38f
         OcOKw6ltfzx6KReQl855r48icHvnD4Enh9bX3NwBibBsAlW9+XX9NGt8w1yWyKe10V1a
         50fQcDN+9jIZm176JlcGB1jwiFB236VSMt83q67lKufLcrzkR1+hS4Lxl0tnZR8KktMD
         OEzA==
X-Gm-Message-State: AA+aEWYRGz7vN72PsBsxsQels+JCUdHlrKC6neJtii6WlL6p2Z8UCzzj
        C9f8gFBm8Uy6b+05lin5A5avlAPG+LPlGLjoIgJcdw==
X-Google-Smtp-Source: AFSGD/W/CyGsIm3JnHJ8Dm/5ZX0mKF10fQWtRwEhQJPJkvan2c0DCuxa2C9sboIoz9FjOr9wQ2SB4txgIsaZYRbvjNA=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr10270672ioc.119.1545043368209;
 Mon, 17 Dec 2018 02:42:48 -0800 (PST)
MIME-Version: 1.0
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org>
 <20181217080846.GA28424@sathnaga86.in.ibm.com> <877eg8v40t.fsf@concordia.ellerman.id.au>
In-Reply-To: <877eg8v40t.fsf@concordia.ellerman.id.au>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 17 Dec 2018 16:12:37 +0530
Message-ID: <CALxhOnh5a86pBi4rD1YzhVGq7KPs56du9+G8vkt7zVAqbGkLEw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Mon, 17 Dec 2018 at 16:01, Michael Ellerman <mpe@ellerman.id.au> wrote:
> No it's fine if it applies on next.
>
> I can also fix up minor merge conflicts if there are any.

Ohh. I already rebased and sent v6.

Thanks
Firoz
