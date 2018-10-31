Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB2ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06722081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DeMFGwUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06722081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbeKADgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:36:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35057 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbeKADgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:36:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so11574107ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16CVxsOgfz0grQILIkOZC0Qh1Zp1fZa6NDppYa+02RU=;
        b=DeMFGwUfE7dgieUkBbf+RB+qi0q8JnDH/C6sWHLhMi81if0wbxVnwA4w8HBoYz300a
         lwP15nFPuXozUdTWcISUcjuzyJa+WKDRj5mXZ6Sh+2nFiNHKNeJdX6QLhq6PlDh9Iac/
         bGD4/yAz7CxX0WGvhzRie4+YBME6O4fU34H4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16CVxsOgfz0grQILIkOZC0Qh1Zp1fZa6NDppYa+02RU=;
        b=nN0Rf20WnPH9qWyek6tAD7xThYBlJFU4avS9EEe+co+0V6HumY1U7oCNpR60q3vUdY
         08Lvt1vnYe/nhf+VncDjSuVciiST9I+4Eu4rsU2/fYYPVMU7HPta+JEzJwBeTuDuzPPX
         9ohrTt4O8mpBCxacqvL+a7z44PGMggFzE2AUUzpOhjdseFcFXPK7IyC0ncVVtZCpIeHK
         25QeA4duxFH4VyjunJP+n62uKPkUCABbnL4Wl2zLfCKK/Dv7lG9/U998ErkX3V2/8/1u
         MTQr3GJgukrygySvpDnuo7/i7NfvL+lHUninwdObAqR9tRPWQfUG8vGsmRJLpi3ER05r
         t9Mw==
X-Gm-Message-State: AGRZ1gLDwmZ4nGmhN3hsvXtO3UcJPOyxyGwwMUpa7dw9BDaYrfEG0q4+
        YFDCGblO99+uZyRcxI1dq57d+HE3fhjMbQ==
X-Google-Smtp-Source: AJdET5fLHb1pC/5v00csw6t4E5cYTFROV1yAENvcuci3gT6MqaPxf8hPu5OgdP2zYTMLdZo/PaUJEA==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr2752707ljf.96.1541011018774;
        Wed, 31 Oct 2018 11:36:58 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h79-v6sm2822972ljf.67.2018.10.31.11.36.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:36:57 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id n26-v6so12460703lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:36:57 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr2520842lfa.106.1541011016948;
 Wed, 31 Oct 2018 11:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181031182909.169342-1-ndesaulniers@google.com>
In-Reply-To: <20181031182909.169342-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 11:36:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-17w3-m9EGVZGeWYpuYM8V=x8py2s5EcAHeinF24TQg@mail.gmail.com>
Message-ID: <CAHk-=wj-17w3-m9EGVZGeWYpuYM8V=x8py2s5EcAHeinF24TQg@mail.gmail.com>
Subject: Re: [PATCH v2] include/linux/compiler*.h: add version detection to asm_volatile_goto
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        miguel.ojeda.sandonis@gmail.com, yamada.masahiro@socionext.com,
        paul.burton@mips.com, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:29 AM <ndesaulniers@google.com> wrote:
>
> V1 -> V2: drop changes to include/linux/compiler-gcc.h.

Now the subject line of the patch doesn't match the patch any more..

                Linus
