Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4714CC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEDA2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DZAzOot4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEDA2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeHDTdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 15:33:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53034 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHDTdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 15:33:03 -0400
Received: by mail-it0-f68.google.com with SMTP id d9-v6so12412691itf.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7Ob1cLoEtjq7DYdAqJAxtBr3hEFML40mOJW39D48EI=;
        b=DZAzOot4MJSP+QoaRU7Bg+hJZR0AyqCPZjF0/Yelo3nMPmc7Eh5EUy7LLG9Xzg4d2q
         ywG2jj+Br7285iSExPOaUlF9QI87F6MjLKxVofP2Ebmfw76hY2nKVsx7M+AE0M3UhtUj
         BUQlmh5GUFk8e8ZzDAe4JzNsHxQh0K3IqmtoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7Ob1cLoEtjq7DYdAqJAxtBr3hEFML40mOJW39D48EI=;
        b=CGu1B2YE5s8LhvQfqtS1gTZ9GOLquDWz+YUjVdixRfeIqZrKsAk9YggzPA00lbO41z
         +vihpLTbc+qg6iKh2t9ZJuhtUyWI/Ckkxzo8tfWksVa+HjsUBc3xVhuaAvDrS2qLiRg6
         OahXTXygCsVl5NLQcDp/WGmayMyd+eEGMPy/1mPzS/TvJXFy/NWQwiehZlIxvTCSpI2w
         d2xTpw4jWIky3jLWFI+zqfNspyokFmFJsBUZ4JmjrvS7oRnH2jArYzl6e+9pX8ZctKnY
         EzR6UtwH9xL6wEvDc+4DFOu5riFx1TPOGnBecpo9xsofb4t08Tx1C1i+TLoAACDQU+36
         e2dw==
X-Gm-Message-State: AOUpUlEyakrek+PpMmQmc9GEdPKdTK72KjjLP/fveVCNFnnwv/hIvoVL
        Z5FNTfH+wDnvuJz4OOZp/8Qb9m7TwhHyVyARZIY=
X-Google-Smtp-Source: AAOMgpdpvIByIFaGLTNka/ZbEJUfxNqFBnhcCAhH7iGvXfwG5epcJqXOFEULC8+yTYHxHrtX6TFNzY3wChqxZqxupzw=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr10041461ite.1.1533403900946;
 Sat, 04 Aug 2018 10:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180802225823.4711C55B@viggo.jf.intel.com> <20180802225828.89B2D0E2@viggo.jf.intel.com>
 <alpine.LSU.2.11.1808031650050.4436@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1808031650050.4436@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Aug 2018 10:31:29 -0700
Message-ID: <CA+55aFzd-F65GVBq8a-vTaU4G5UwddDcOdcd3SV9YVdB6qDGdg@mail.gmail.com>
Subject: Re: [PATCH 3/7] x86/mm/init: pass unconverted symbol addresses to free_init_pages()
To:     Hugh Dickins <hughd@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 5:19 PM Hugh Dickins <hughd@google.com> wrote:
>
> I thought that virt_to_page() only works on virtual addresses
> in the direct map

You're right that virt_to_page() does not work on any _actual_ virtual
mappings (ie no user pages, and no vmalloc() pages etc). It does not
follow page tables at all.

And on 32-bit, it literally ends up doing (see __phys_addr_nodebug()) a simple

    #define __phys_addr_nodebug(x)  ((x) - PAGE_OFFSET)

However, on x86-64, we have *two* cases of direct mappings: we have
the one at __START_KERNEL_map, and we have the one at PAGE_OFFSET.

And virt_to_page() handles both of those direct mappings.

Annoying? Yes. And it has caused bugs in the past. And I entirely
forget why we needed it on x86-64.

[ Goes around and rummages ]

Oh, never mind, looking around reminded me why: we want to map the
kernel text in the top 31 bits, so that we can use the faster
-mcmodel=kernel because all symbols fit in sign-extended 32 bits.

Maybe there was some other reason too, but I think that's it.

                   Linus
