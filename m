Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeCORKK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:10:10 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45729 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbeCORKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:10:06 -0400
X-Google-Smtp-Source: AG47ELsR7M5iPcFaz8CRnMlJjuamkTHwEnCtCFmWJE5B7zJeKyFHmLwfG5/PO3cfHvjOEkgAjFz2S08MafPxvyedPBw=
MIME-Version: 1.0
In-Reply-To: <20180315153433.3724071-1-arnd@arndb.de>
References: <20180315153433.3724071-1-arnd@arndb.de>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Mar 2018 10:10:03 -0700
X-Google-Sender-Auth: Ln5pTohalKuD2Grdfjdp5GlpmNY
Message-ID: <CAGXu5jLRx4LuD2Vx2ygoGw6u1t6=CEGtJ6E05HM0J5ZW-cp3WA@mail.gmail.com>
Subject: Re: [PATCH] pstore: fix crypto dependencies
To: Arnd Bergmann <arnd@arndb.de>
Cc: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, Geliang Tang <geliangtang@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hirofumi Nakagawa <nklabs@gmail.com>,
        Yang Shi <yang.s@alibaba-inc.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 8:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The new crypto API use causes some problems with Kconfig dependencies,
> including this link error:
>
> fs/pstore/platform.o: In function `pstore_register':
> platform.c:(.text+0x248): undefined reference to `crypto_has_alg'
> platform.c:(.text+0x2a0): undefined reference to `crypto_alloc_base'
> fs/pstore/platform.o: In function `pstore_unregister':
> platform.c:(.text+0x498): undefined reference to `crypto_destroy_tfm'
> crypto/lz4hc.o: In function `lz4hc_sdecompress':
> lz4hc.c:(.text+0x1a): undefined reference to `LZ4_decompress_safe'
> crypto/lz4hc.o: In function `lz4hc_decompress_crypto':
> lz4hc.c:(.text+0x5a): undefined reference to `LZ4_decompress_safe'
> crypto/lz4hc.o: In function `lz4hc_scompress':
> lz4hc.c:(.text+0xaa): undefined reference to `LZ4_compress_HC'
> crypto/lz4hc.o: In function `lz4hc_mod_init':
> lz4hc.c:(.init.text+0xf): undefined reference to `crypto_register_alg'
> lz4hc.c:(.init.text+0x1f): undefined reference to `crypto_register_scomp'
> lz4hc.c:(.init.text+0x2f): undefined reference to `crypto_unregister_alg'
>
> The problem is that with CONFIG_CRYPTO=m, we must not 'select CRYPTO_LZ4'
> from a bool symbol, or call crypto API functions from a built-in
> module.
>
> This turns the sub-options into 'tristate' ones so the dependencies
> are honored, and makes the pstore itself select the crypto core
> if necessary.
>
> Fixes: cb3bee0369bc ("pstore: Use crypto compress API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ah, thanks for this! I'm running it through tests now and should be in
-next shortly.

-Kees

-- 
Kees Cook
Pixel Security
