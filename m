Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeB0QtC convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:49:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46684 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeB0QtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:49:01 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        Julia Cartwright <juliac@eso.teric.us>
Subject: [PATCH v3 00/02] Consolidate tasklet + tasklet-hi code
Date: Tue, 27 Feb 2018 17:48:06 +0100
Message-Id: <20180227164808.10093-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo made a RT patch a few years back called "tasklet: Prevent tasklets
from going into infinite spin in RT" [0]. I ripped the non-RT pieces out
of it and here they are. I kept him as the original Author.

v1…v3: in v1 I had this_cpu_ptr(&tasklet_hi_vec) without disabling
       interrupts and was objected by Steven. There are (indeed) some
       users which use this outside if of the interrupt.
       So in v2 I moved this but then Julia suggested pass just the
       __percpu pointer and use this_cpu_ptr() once interrupts are
       disabled.
       This is all 1/2. 2/2 is unchanged because tasklet_action() /
       tasklet_hi_action() run always in BH and can't migrate to another
       CPU between this_cpu_() access and disabling interrupts.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/tasklet-rt-prevent-tasklets-from-going-into-infinite-spin-in-rt.patch?h=linux-4.14.y-rt-patches

Sebastian
