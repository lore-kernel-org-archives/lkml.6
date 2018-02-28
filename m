Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933579AbeB1Tcw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:32:52 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:37752 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933330AbeB1Tcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:32:50 -0500
X-Google-Smtp-Source: AG47ELsEdJbE5oy8i9f48/JIH9lAOqC+dfx4aRhDZvlIfmHaoYg6uMvrsY0Glr+N0O0Z+s7fx0a6fd3hQmRaEh09830=
MIME-Version: 1.0
From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, 28 Feb 2018 20:32:48 +0100
Message-ID: <CAAeHK+wRcZ1o53CEpeOQ-J5AayVAd8nm-ASj8HsTy1vOzHQAqQ@mail.gmail.com>
Subject: Clang build of arm64 kernel fails
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
        ard.biesheuvel@linaro.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc!

I've tried to pull in new upstream commits and the kernel build
started failing for me with the following errors (see below).

It seems that the reason is your commit "arm64: Add
ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support". It seems that Clang
doesn't like 32 bits registers being used in 64 bits build.

Would you mind sending a fix?

Thanks!

arch/arm64/kernel/cpu_errata.c:156:2: error: unknown register name 'r0' in asm
        arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
        ^
./include/linux/arm-smccc.h:276:32: note: expanded from macro
'arm_smccc_1_1_smc'
#define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                ^
./include/linux/arm-smccc.h:255:3: note: expanded from macro '__arm_smccc_1_1'
                __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
                ^
./include/linux/arm-smccc.h:240:37: note: expanded from macro '__declare_args'
#define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
                                    ^
./include/linux/arm-smccc.h:239:37: note: expanded from macro '___declare_args'
#define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
                                    ^
<scratch space>:136:1: note: expanded from here
__declare_arg_0
^
./include/linux/arm-smccc.h:197:32: note: expanded from macro '__declare_arg_0'
        register u32           r0 asm("r0") = a0;
