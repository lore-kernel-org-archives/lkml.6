Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeBEP7m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:59:42 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36676 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbeBEP7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:59:33 -0500
X-Google-Smtp-Source: AH8x224AEYOO+4VwHqtfpN7Wt/Z4hg68qK+2hlTvHrhwbTYbX8lig61X6vREV7w4M5Fn8jSw0nbNEWA6j7+K2rAtbF8=
MIME-Version: 1.0
In-Reply-To: <20180205155001.GI30338@tassilo.jf.intel.com>
References: <20180205151300.539874-1-arnd@arndb.de> <20180205151300.539874-2-arnd@arndb.de>
 <20180205155001.GI30338@tassilo.jf.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 5 Feb 2018 16:59:32 +0100
X-Google-Sender-Auth: vbr2dXNstxX6lBqD4hBb0V0WIZA
Message-ID: <CAK8P3a3gNstYGm5KqAZ5T7kQL0raUC0OOrcLwYD3wc+thwmEkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] modpost: don't add warnings for LTO-generated symbols
To: Andi Kleen <ak@linux.intel.com>
Cc: Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nico@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wanlong Gao <wanlong.gao@gmail.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 4:50 PM, Andi Kleen <ak@linux.intel.com> wrote:
> On Mon, Feb 05, 2018 at 04:12:52PM +0100, Arnd Bergmann wrote:
>> WARNING: vmlinux.o(.data+0x12e0): Section mismatch in reference from the variable pfkey_net_ops.lto_priv.2992 to the function .init.text:pfkey_net_init.lto_priv.2977()
>> The variable pfkey_net_ops.lto_priv.2992 references
>> the function __init pfkey_net_init.lto_priv.2977()
>> If the reference is valid then annotate the
>> variable with __init* or __refdata (see linux/init.h) or name the variable:
>> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>
> A better fix would be to ensure modpost always runs on already LD_FINALed
> objects, so it never sees LTO.
>
> Otherwise you would need to teach modpost about the LTO symbol table
> and some other magic. I did that once, but it turned out to be very
> ugly.

I'm not sure I understand what that means. Do you mean that with LD_FINAL,
those symbol references are completely eliminated so we don't need to worry
about them any more?

I got about a dozen section mismatch errors with LTO in cases where the
calling function gets a specialized version of a structure, and my oneline
patch above addresses them all.

        Arnd
