Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeCIKd6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:33:58 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:37214 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeCIKd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:33:57 -0500
X-Google-Smtp-Source: AG47ELuCTTfN16FETGQt3yXnVwH17YpYONcGeeCahMlc51UfI6pgXmcSlBPRNjgrzZyBB6N5sBwyUmwiEYb9T6cWkCA=
MIME-Version: 1.0
In-Reply-To: <9a709b76-1b45-8250-9d8e-adbad59a43cc@arm.com>
References: <1519837260-30662-1-git-send-email-jaz@semihalf.com>
 <20180228171647.6t4dabntujcb5kon@lakrids.cambridge.arm.com>
 <ba0c6804-51a3-f36e-a67e-20ce84961451@arm.com> <CAH76GKO8oYVN+H4pvd6NTGc0u8AD7JMSJCYEJzNtdsAJm5L_9w@mail.gmail.com>
 <9a709b76-1b45-8250-9d8e-adbad59a43cc@arm.com>
From: Grzegorz Jaszczyk <jaz@semihalf.com>
Date: Fri, 9 Mar 2018 11:33:55 +0100
Message-ID: <CAH76GKPOX6J=mKV89pjp+f_K7=1aS_SaGfy_nCN5jLDNM4r9aA@mail.gmail.com>
Subject: Re: [PATCH] arm64: kdump: fix interrupt handling done during machine_crash_shutdown
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Hoeun Ryu <hoeun.ryu@gmail.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Not using EOImode==1 is definitely an oddity (at least on the host), but
> that doesn't mean it shouldn't work.
>
> The reason the thing is hanging is that although we correctly deactivate
> the interrupt, nothing performs the priority drop. Your write to EOI
> helps in the sense that it guarantees that both priority drop and
> deactivate are done with the same operation, but that's not something
> we'd want to expose.
>
> My preferred approach would be to nuke the active priority registers at
> boot time, as the CPUs come up. I'll try to write something this week.

I've made a PoC which performs priority drop at boot time as you
suggested and it works with both GICv2 and GICv3 but I see some
problem:
It seems that the only way to drop the priority is to perform write to
EOI register (the GIC_RPR is RO). According to GIC documentation a
write to EOI register must correspond to the most recent valid read
from IAR. The problem is that the interrupt was already acked in the
'original' kernel, so reading GICC_IAR in crashdump kernel returns
spurious interrupt and it seems that there is no way to figure out
appropriate irqnr for EOI write. Nevertheless I've observed that
choosing random irqnr for EOI write works fine (maybe because all
interrupts in Linux uses the same priority?).

Here is the PoC (not ready for submission only for further
discussion): https://pastebin.com/gLYNuRiZ

Looking forward to your feedback.

Thank you in advance,
Grzegorz
