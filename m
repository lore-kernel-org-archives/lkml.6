Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754304AbeDWIcw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:32:52 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:44228 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbeDWIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:32:49 -0400
X-Google-Smtp-Source: AB8JxZrPH73q99R42sy7eoaf+6M444XkSz/4f6ALtQSQaM761urnTYGgLUesCyWbmhIORI5a9nVnzhtsNiLAffEX3Oo=
MIME-Version: 1.0
In-Reply-To: <20180423081114.1813726-2-arnd@arndb.de>
References: <20180423081114.1813726-1-arnd@arndb.de> <20180423081114.1813726-2-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Apr 2018 10:32:47 +0200
X-Google-Sender-Auth: rcx-itWsidQRaETcThO0ErF5uPc
Message-ID: <CAK8P3a1V6QfUE8rZKyUUOmBfNC181mHJF8KiQi1GD=JJ4JfEOA@mail.gmail.com>
Subject: Re: [PATCH 2/5] powerpc: rtas: clean up time handling
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> @@ -307,17 +307,17 @@ static ssize_t ppc_rtas_poweron_write(struct file *file,
>                 const char __user *buf, size_t count, loff_t *ppos)
>  {
>         struct rtc_time tm;
> -       unsigned long nowtime;
> +       time64_t nowtime;
>         int error = parse_number(buf, count, &nowtime);
>         if (error)
>                 return error;
>
>         power_on_time = nowtime; /* save the time */
>
> -       to_tm(nowtime, &tm);
> +       rtc_time64_to_tm(nowtime, 0, &tm);
>

Here was the other obvious typo: I had originally changed this to
'time64_to_tm()', which has slightly different calling conventions to
'rtc_time64_to_tm()', and messed it up when I changed it back
after it turned out I needed to select RTC_LIB anyway.

v2 coming.

        Arnd
