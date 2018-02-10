Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752893AbeBJWTI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 17:19:08 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:55116 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbeBJWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 17:19:06 -0500
X-Google-Smtp-Source: AH8x225ioT9A4phVan9jog097spbZYnd18TWhOY8NamlHXIapOo4NBK8MlH6Z59aCq/J35rYA7wx1NEDDmLSyXH+FJk=
MIME-Version: 1.0
In-Reply-To: <20180210113842.7j62u7rxp4jscei2@gmail.com>
References: <56d0376c-dc1f-334b-d392-a8c5cd85f4aa@infradead.org>
 <CA+55aFymknkNH2mP1vX5ZLEqQwA3BgxQhZF-SUbbJMwTDL6hAA@mail.gmail.com>
 <0b833246-ed4b-e451-c426-c4464725be92@infradead.org> <20180210113629.jcv6su3r4suuno63@gmail.com>
 <20180210113842.7j62u7rxp4jscei2@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 10 Feb 2018 14:19:04 -0800
X-Google-Sender-Auth: kjFL45avXB-IBC5U6AX5V21ePHI
Message-ID: <CA+55aFzW=jVmcWGw6bPMwZsZiUFkWOzZYV7FzNFhG1WJ+qgzSw@mail.gmail.com>
Subject: Re: [PATCH] x86/Kconfig: Further simplify the NR_CPUS config
To: Ingo Molnar <mingo@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

At the risk of bike-shedding, we could remove all the

        default    1 if !SMP

from the BEGIN/END/DEFAULT things, and perhaps just keep that part in NR_CPUS.

I didn't check, but I *think* it would work to just do

 config NR_CPUS
        int "Maximum number of CPUs" if SMP && !MAXSMP
        range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
        default "1" if !SMP
        default NR_CPUS_DEFAULT

but maybe the "range" line would need an "if !SMP" on it too to avoid
the issue with "1" being out of range.,

That would still leave the NR_CPUS thing *much* easier to understand,
and it would mean that the other helper things wouldn't need to care
about the UP case.

But regardless, that least version looks perfectly fine to me even
without that random tweak.

              Linus
