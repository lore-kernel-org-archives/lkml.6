Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeBBTtO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:49:14 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32928 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753967AbeBBTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:49:07 -0500
X-Google-Smtp-Source: AH8x227xJdl2IhqeWGCjaoVoi/jBKvlDU7k6ORUS5uO1O7ZJQl+G0oAOePGTp+/8dnDKpxIfPuJV3Q==
Date: Fri, 2 Feb 2018 14:49:05 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 3/7] [HACK] x86: crypto: fix link error with LTO
In-Reply-To: <20180202162104.2300532-3-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1802021414270.1842@knanqh.ubzr>
References: <20180202161550.2106846-1-arnd@arndb.de> <20180202162104.2300532-3-arnd@arndb.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2018, Arnd Bergmann wrote:

> crypto_it_tab and the other symbols like it are defined in
> crypto/aes_generic.c and exported for loadable modules. When
> building with LTO and CONFIG_TRIM_UNUSED_KSYMS, the exports
> are eliminated, since kbuild fails to take the users in
> the arch/x86/crypto/aes-i586-asm_32.S assembler file into
> account.
> 
> This adds an ugly workaround by adding a reference to each symbol
> into aes_glue.c, which gets linked together with the assembler
> file.
> 
> We obviously want to fix the CONFIG_TRIM_UNUSED_KSYMS logic
> to do the right thing here instead, but I couldn't come up
> with a good fix, so I use this instead to get a clean build
> for testing.

Could you give me the .config you used for this? So far I can't 
reproduce, and guessing with LTO takes lots of time.

> This fix only works most of the time, but I still ran into
> some cases where combining an .S with a .c file did not
> produce the correct .ko file, as the lto linker apparently
> did not expect that kind of input. 'nm' on the file after
> 'ld -r' showed only the contents of the assembler file, and
> after the lto-ld stage, only the contents of the .c file
> are there.

'ld -r' does not support mixed (LTO and non-LTO) objects.


Nicolas
