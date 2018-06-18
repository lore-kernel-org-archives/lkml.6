Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C984EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853DF208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4H9wsda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853DF208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933501AbeFRNGB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:06:01 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41150 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFRNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:06:00 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so24538927lfa.8;
        Mon, 18 Jun 2018 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6M+7FVl7UAWt995uN4YV/iXiVEMLJuYi9KC5rV4Xvhg=;
        b=j4H9wsdaYCqdHSP+6oWZ7o6zAEfdposVdzVWiLtf4hUB+vwh95AnoRrPLr6eK6ygds
         OV/3viYrpu5HY7JYKhTuJPaw67TX2oPrfbb+E+L4YXEGlfP3kq42z+GRQ3K1G5LtGmbi
         c1McID+r5PvL+UaLwBX+oTcOl+ByxTVjYCr3Ovly0EB2t2Lx9ifD1bAy2UU/UrAyDDje
         qzz2T6jiRHaXYM+IJoWpZe+FCWSslYSIG1M3ix8QAWlyy4Yn52+PgSiRkgw9t8GTevp8
         uzm86ksSjwTNmJh1Onb7M1mbo5W8woUNKcsJe+bIPw9PlB5JbYwmnNvxMQQzJWdKTZyN
         DjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6M+7FVl7UAWt995uN4YV/iXiVEMLJuYi9KC5rV4Xvhg=;
        b=LXbtQjm0nTHbM+B7DYszraxZXrsBBWTlZNnmer7HGF4whMnMXsEJz3a4IhHzVlBO3F
         sZhxHl3DOj/rA1ofBKie97wccqOzHmWa8ZxQeFAeuA0vmav3RYSREM6b/OKk2Uqp27Ua
         3jWU1+x+RGAf6zHXF7kDSWN54RJ/UeOqZLI4w8ZAJ+OYFI/KMYft2LlI5TvBG68Xejtk
         6r1B5+30whb+Y5oAKOcnpzbU4PpTAarihoSRzcowqY9hzz/EC3pa77YJLJHy1D2NlpzG
         heESE9yjWMJi8eC/lqH78b2j7rmTxSXCdDM3njUTQUNcqrXeREmUw8FYM6sW48sZBHhi
         KYHQ==
X-Gm-Message-State: APt69E2t7CdBbtM3NOo6fs5GGgCYwrSqCPutYAujzTyvdNRbdttKfV6W
        S1Vp82MiUuYed98Rnvms+6Us9sNz3iPreNzNkjc=
X-Google-Smtp-Source: ADUXVKKBH7gQ+x0RIza7Op3bS3fG4rHXF5OhBK61doYJog3K6k2s2IVUxioizgqr1XbI3ryDgB59urGQOm1g8QO8h6Q=
X-Received: by 2002:a19:141f:: with SMTP id k31-v6mr2833908lfi.23.1529327158393;
 Mon, 18 Jun 2018 06:05:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 06:05:57
 -0700 (PDT)
In-Reply-To: <20180616005323.7938-1-paul.burton@mips.com>
References: <20180616005323.7938-1-paul.burton@mips.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 15:05:57 +0200
X-Google-Sender-Auth: nQn1PvnOf7LVKkGPFKtvcJW8Yog
Message-ID: <CAK8P3a2Yz-02On2K2U0+8+tR8RQCQ+KWh7CrtqL9L+FweP+TPQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve -Wattribute-alias warnings from SYSCALL_DEFINEx()
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 2:53 AM, Paul Burton <paul.burton@mips.com> wrote:
> This series introduces infrastructure allowing compiler diagnostics to
> be disabled or their severity modified for specific pieces of code, with
> suitable abstractions to prevent that code from becoming tied to a
> specific compiler.
>
> This infrastructure is then used to disable the -Wattribute-alias
> warning around syscall definitions, which rely on type mismatches to
> sanitize arguments.
>
> Finally PowerPC-specific #pragma's are removed now that the generic code
> is handling this.
>
> The series takes Arnd's RFC patches & addresses the review comments they
> received. The most notable effect of this series to to avoid warnings &
> build failures caused by -Wattribute-alias when compiling the kernel
> with GCC 8.
>
> Applies cleanly atop master as of 9215310cf13b ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
>

Sorry I dropped the ball on this earlier, and thanks a lot for picking
it up again! From what I can tell, your version addresses all issues
I was aware of, so we should merge that.

      Arnd
