Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A9AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB022084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hsB/gPZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB022084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeJ3C6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:58:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37353 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeJ3C6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:58:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so4436763pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSKKc5HMlh7M5vL937dP++TT6tmkeJeSmcqt5MVCOtY=;
        b=hsB/gPZ2gEczir8iQUAn0e9pABW4rct9ZAh6E2jhg77MsVjPTMBQfPhvBJR1BZm+6m
         +OqpVPHEG2Hkn5wbNSXGiP7vXlYiyracqL7uFW25m8vWND53ljm5X4RERvGv6xZKL7xn
         jpFaHwDjmEMbTLwB1YIDBXfdvPbYN5rgtzT3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QSKKc5HMlh7M5vL937dP++TT6tmkeJeSmcqt5MVCOtY=;
        b=roPYFvTYBL7F7CprFnJcKznm1F9/0BvpVg1PRKyXGljK5l7jl1a65ZetS+FutyFW2H
         bd6LarNMCpSP2So0Fx8W2tkrfjTPMrzZdKVed2Y/gvzED+/h27ukZZxev64Dv6D5J8Jz
         mWiwam9PZrh2S/I04RLxqTy9ZWBrSwbaOKzlNl5f4nMGSwtyO7emg14eQJiQiGGLVpy9
         F6SPfzn0gm57ZuWZIgE/aGfvBzL4nCYWRVFrx9lAzcel4rs7EH4euNoNK5RtpZDkcxDR
         WegfRttGstY64gti2zA9NsHAs5g+gm70Xs1Ps07dzh/AtFiOM4DHXe2adIhi2SUnPsij
         GRyA==
X-Gm-Message-State: AGRZ1gLqi2bKYohij1xfuNR8W6aCQcPGN/ozRwjD3wrT6jGNl0aqRMqr
        YNJ+To1B4yiay6M+t0kir948QQ==
X-Google-Smtp-Source: AJdET5dGhnncRm9iSJg05kgJBJDzyYpBIEP2cpS8BQk0o1rd7rDmc4oUGhklGtHfFiVvNn75kQ9R1w==
X-Received: by 2002:a63:ea07:: with SMTP id c7-v6mr14041434pgi.361.1540836502105;
        Mon, 29 Oct 2018 11:08:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:08:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>, nm@ti.com,
        linux-mips@linux-mips.org, dalias@libc.org,
        catalin.marinas@arm.com, vigneshr@ti.com,
        linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org,
        peterz@infradead.org, will.deacon@arm.com, mhocko@suse.com,
        paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
        marex@denx.de, sfr@canb.auug.org.au, ysato@users.sourceforge.jp,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        linux@armlinux.org.uk, pombredanne@nexb.com, tony@atomide.com,
        mingo@redhat.com, joel@jms.id.au, linux-serial@vger.kernel.org,
        rolf.evers.fischer@aptiv.com, jhogan@kernel.org,
        asierra@xes-inc.com, linux-snps-arc@lists.infradead.org,
        dan.carpenter@oracle.com, ying.huang@intel.com, riel@surriel.com,
        frederic@kernel.org, jslaby@suse.com, paul.burton@mips.com,
        rppt@linux.vnet.ibm.com, bp@alien8.de, luto@kernel.org,
        andriy.shevchenko@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
        andrew@aj.id.au, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        rkuo@codeaurora.org, Jisheng.Zhang@synaptics.com,
        vgupta@synopsys.com, benh@kernel.crashing.org, jk@ozlabs.org,
        mpe@ellerman.id.au, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
        kstewart@linuxfoundation.org
Subject: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep splats w/ kgdb
Date:   Mon, 29 Oct 2018 11:07:00 -0700
Message-Id: <20181029180707.207546-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I started out this series trying to make sysrq work over the serial
console on qcom_geni_serial, then fell into a rat's nest.

To solve the deadlock I faced when enabling sysrq I tried to borrow
code from '8250_port.c' which avoided grabbing the port lock in
console_write().  ...but since these days I try to run with lockdep on
all the time, I found it caused an annoying lockdep splat (which I
also reproduced on my rk3399 board).  ...so I instead changed my
qcom_geni_serial solution to borrow code from 'msm_serial.c'

I wasn't super happy with the solution in 'msm_serial.c' though.  I
don't like releasing the spinlock there.  Not only is it ugly but it
means we are unlocking / re-locking _all the time_ even though sysrq
characters are rare.  ...so I came up with what I think is a better
solution and then implemented it for qcom_geni_serial.

Since I had a good way to test 8250-based UARTs, I also fixed that
driver to use my new method.  When doing so, I ran into a missing
msm_serial.c at all, so I didn't switch that (or all other serial
drivers for that matter) to the new method.

After fixing all the above issues, I found the next lockdep splat in
kgdb and I think I've worked around it in a good-enough way, but I'm
much less confident about this.  Hopefully folks can take a look at
it.

In general, patches earlier in this series should be "less
controversial" and hopefully can land even if people don't like
patches later in the series.  ;-)

Looking back, this is pretty much two series squashed that could be
treated indepdently.  The first is a serial series and the second is a
kgdb series.

For all serial patches I'd expect them to go through the tty tree once
they've been reviewed.

If folks are OK w/ the 'smp' patch it probably should go in some core
kernel tree.  The kgdb patch won't work without it, though, so to land
that we'd need coordination between the folks landing that and the
folks landing the 'smp' patch.


Douglas Anderson (7):
  serial: qcom_geni_serial: Finish supporting sysrq
  serial: core: Allow processing sysrq at port unlock time
  serial: qcom_geni_serial: Process sysrq at port unlock time
  serial: core: Include console.h from serial_core.h
  serial: 8250: Process sysrq at port unlock time
  smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
  kgdb: Remove irq flags and local_irq_enable/disable from roundup

 arch/arc/kernel/kgdb.c                      |  4 +--
 arch/arm/kernel/kgdb.c                      |  4 +--
 arch/arm64/kernel/kgdb.c                    |  4 +--
 arch/hexagon/kernel/kgdb.c                  | 11 ++----
 arch/mips/kernel/kgdb.c                     |  4 +--
 arch/powerpc/kernel/kgdb.c                  |  2 +-
 arch/sh/kernel/kgdb.c                       |  4 +--
 arch/sparc/kernel/smp_64.c                  |  2 +-
 arch/x86/kernel/kgdb.c                      |  9 ++---
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  6 +++-
 drivers/tty/serial/8250/8250_fsl.c          |  6 +++-
 drivers/tty/serial/8250/8250_omap.c         |  6 +++-
 drivers/tty/serial/8250/8250_port.c         |  8 ++---
 drivers/tty/serial/qcom_geni_serial.c       | 10 ++++--
 include/linux/kgdb.h                        |  9 ++---
 include/linux/serial_core.h                 | 38 ++++++++++++++++++++-
 kernel/debug/debug_core.c                   |  2 +-
 kernel/smp.c                                |  4 ++-
 18 files changed, 80 insertions(+), 53 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog

