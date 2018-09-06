Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF247C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610B520652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610B520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbeIFUKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:10:31 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33693 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeIFUKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:10:31 -0400
Received: by mail-qt0-f195.google.com with SMTP id r37-v6so12763499qtc.0;
        Thu, 06 Sep 2018 08:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNGokkwUhey0RkEa5BHYg24UDPn/fvsP9pEoBGNlQho=;
        b=i0pz5XWn3adRZQYQbZfedxoYBLUio+WYdHOHL5oRZqNcXvu7J6hN7vD1sMEla7jfKr
         6A7GsnmTl1fzuA9uL53P2/UEXUdSo1Atir7BeVEEq12hS79313VPzTAOO4MreAINb4rg
         uDGGndKG4/RgfAavkK6ARM7daVXmatIvKLS4ECI4LqE6NdqtuEYd/a+EU8mnvRCT8SmE
         bGxEvQtWQ76HVxJGXScFUUmeslpwpc+4wvylqWwGVZ8dOiMxggxhZcmv3laqeyhfoTEE
         Mvx5FYtGreNlxl/vhwKsp5cbOZz82U+heOFVG8inc5BNW95fAoMZzW6c8ZTpijNRCGbV
         JHvQ==
X-Gm-Message-State: APzg51BelESyAprqfwYW83CYH/3oEh+r4e6JXRLTBZkCu17wND4HuH8g
        lQNNw3RRgxla88/ZQl5cYKkq+HzVl8WsSJ//P7g=
X-Google-Smtp-Source: ANB0VdanPcPCJdCWkpi6FFPhwIKiRorvTEKq7alt5qxSRt/P+PhADUIHbcgAdJ+gjGYCaXAbGctE7Vi88nY4ZN0C6zM=
X-Received: by 2002:aed:2b47:: with SMTP id p65-v6mr2586905qtd.132.1536248067485;
 Thu, 06 Sep 2018 08:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org> <1536036087-15260-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-5-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 17:34:11 +0200
Message-ID: <CAK8P3a2qFoCOzM6x-_mv0Um2E-WHDeOU-fuuZ65TtDKKcPxNrQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] sparc: uapi header and system call table file generation
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> System call table generation script must be run to generate
> unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> will have changes which will invokes the script.
>
> This patch will generate unistd_32/64.h and syscall_table_
> 32/64/c32.h files by the syscall table generation script
> invoked by arch/sparc/Makefile and the generated files against
> the removed files will be identical.
>
> The generated uapi header file will be included in uapi/asm/
> unistd_32/64.h and generated system call table support file will
> be included by arch/sparc/kernel/syscall_table_32/64.S file.

These changes all look good to me.

       Arnd
