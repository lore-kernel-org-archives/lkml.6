Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeCWHXk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:23:40 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34089 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeCWHXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:23:39 -0400
X-Google-Smtp-Source: AG47ELujUCrPS6urasxqWESgtlh8lHClnxyQ08zSe8wIEuYjJBp9CCGrQH7nLMeNmvpY2mXu6Fd4vUhr17g61zG2L3Q=
MIME-Version: 1.0
From: Lei Chen <chenl.lei@gmail.com>
Date: Fri, 23 Mar 2018 15:23:38 +0800
Message-ID: <CAB5AJuUr7qwp+WWLBVdZouJ+mnB6GWQu5AKjuWCY2N1dmsw30g@mail.gmail.com>
Subject: floating point computation error caused by eagerfpu
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to figure out the root cause of a floating point
calculation error on kernel 4.4.98. My coworker runs a SHA1 test tool.
The generated sha1 does not match the expected value. Strangely, this
test just goes well on one VM. After a lot of comparison between this
VM and the bare metal x86-64 environment, we find the suspicious point
-- the VM uses 'lazy' mode FPU context switch while bare metal server
uses 'eager' mode. Then I rebuilt the kernel with "eagerfpu=DISABLE"
by default. I'm happily to see the test passes across different
platforms(different VMs and different x86 servers).

We don't have any custom FPU setting or modification to the native
Linux 4.4.98 kernel code. Per my understanding, during boot, system
will choose eagerfpu mode automatically according  to the CPU's
capability. It should have just worked well if the CPU supports eager
mode. But the test result shows that there might be FPU context
corruption. Having googled around, I don't find similar report. Could
FPU experts shed some light on this issue?

Thanks,
Lei Chen
