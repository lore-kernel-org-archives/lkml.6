Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeDMQlx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:41:53 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:33740 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeDMQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:41:49 -0400
X-Google-Smtp-Source: AIpwx4/u6nd3P8+MIrppNoC/9cwugbzLkGFp+OKe6jQ6MyEs69/pzy4rqf1f4FuyGrbCs0X0EcMjf65nax3JzGRPSBY=
MIME-Version: 1.0
In-Reply-To: <1523595999-27433-22-git-send-email-yamada.masahiro@socionext.com>
References: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com> <1523595999-27433-22-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 13 Apr 2018 09:41:48 -0700
X-Google-Sender-Auth: QCh7mlhHk-rlZ0hsNb74Go2mhus
Message-ID: <CAGXu5jLt4xoxXTw83-npD4WmumPzSC9WnbOkkDoR=VYa5R4rYw@mail.gmail.com>
Subject: Re: [PATCH 21/30] stack-protector: test compiler capability in
 Kconfig and drop AUTO mode
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Emese Revfy <re.emese@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:06 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> +stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> +stackp-flags-$(CONFIG_CC_STACKPROTECTOR)          := -fstack-protector
> +stackp-flags-$(CONFIG_CC_STACKPROTECTOR_STRONG)   := -fstack-protector-strong
> +
> +KBUILD_CFLAGS += $(stackp-flags-y)

So, technically, this works just fine. I wonder if it has an overly
confusing result, in that the compiler under normal situations will
see:

gcc ... -fno-stack-protector -fstack-protector -fstack-protector-strong ...

How about something like this instead:

ifdef CONFIG_CC_STACKPROTECTOR_STRONG
KBUILD_CFLAGS += -fstack-protector-strong
else
ifdef CONFIG_CC_STACKPROTECTOR
KBUILD_CFLAGS += -fstack-protector
else
KBUILD_CFLAGS += -fno-stack-protector
endif
endif

-Kees

-- 
Kees Cook
Pixel Security
