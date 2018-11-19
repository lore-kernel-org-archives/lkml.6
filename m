Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AF6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC8B208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC8B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeKTCYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:24:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45632 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbeKTCYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:24:46 -0500
Received: by mail-qk1-f194.google.com with SMTP id d135so49337386qkc.12;
        Mon, 19 Nov 2018 08:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etJ06+iczpf28NRoBWJwPxdidTlkeRUxLcwzAMEwHB0=;
        b=kLsZFK3nOGUZwFMOWboM/hQeVzatfdsdVhHBs0zJL/h3GM4H3ASqFA2NnZqIJj+v87
         tXwLnLehVV+bbgzTJd9xaf2/WnXTLmSULIaiFw6+VB4kk73PwLJsUby8eGgBeAPOJLgV
         UcVU8XNmnA9w80/cpuu9xLf8Qqp6ukCefabVAUtWh51L6ZOWlgs3PXHA8e1HTwGB5vgG
         GqgyBiQxfUTQNHjXNVtpJiVc14vTcl10eEzfvTYIo0Fl2JzU2zwiUP/9FtsMHHWKG5yV
         u7ePOr4CkgObdYgFCZpm0eBT/Yp+k2fROS4TzRzM0CnHebZzjx1sLva+VJ/iOl9Jj1QG
         PuOg==
X-Gm-Message-State: AGRZ1gKgwGxteYivnf4aC/mPHzBNVCSAQtFdk4dw5T3Mm7URO5HF+kyH
        F8/yRgPIXPgskiOWMMNBRQVjcFuaUupsGsWl11A=
X-Google-Smtp-Source: AJdET5dw/dqcsuslp95hhoRhcw2RFHknXqo8sA0zV13CqDEv4OTFZfQgEkRmLA5biUs6ZJOABbNE2ZF/Kg1p6SyaV5U=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr21296810qte.212.1542643244719;
 Mon, 19 Nov 2018 08:00:44 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 17:00:28 +0100
Message-ID: <CAK8P3a1Ee-6unLimZ=0TH0PjdSjwu1naK=U6Jvoi_qvsf5+z7w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mips: add system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
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

On Thu, Nov 15, 2018 at 7:15 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The system call tables are in different format in all
> architecture and it will be difficult to manually add,
> modify or delete the syscall table entries in the res-
> pective files. To make it easy by keeping a script and
> which will generate the uapi header and syscall table
> file. This change will also help to unify the implemen-
> tation across all architectures.

This looks great to me, just one question:

> +# The <abi> is always "64" for this file.
> +#
> +0      64      read                            sys_read
> +1      64      write                           sys_write

What is the reason for using '64', 'n32', and 'o32' respectively in
the ABI field
but use 'common' in other architectures that have a table of entries that are
all for the same architecture?

       Arnd
