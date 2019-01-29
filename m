Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B2AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C67F20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfA2Kb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:31:57 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:3261 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2Kb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:31:57 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 05:31:57 EST
Received: from [77.22.253.72] (helo=calia.hitronhub.home)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jan@schnhrr.de>)
        id 1goQXN-0003Gk-67; Tue, 29 Jan 2019 11:22:37 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jan@schnhrr.de>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jan@schnhrr.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix TSC issues on (some) AMD Ryzen based systems
Date:   Tue, 29 Jan 2019 11:23:27 +0100
Message-Id: <20190129102329.27610-1-jan@schnhrr.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: am5Ac2Nobmhyci5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My newly acquired AMD Ryzen Threadripper based system seems to have
some TSC quirks, which go away once the system is up.

Given the discussion in https://lkml.org/lkml/2019/1/28/1356 
I don't seem to be the only one, and it does not seem to be
Threadripper specific.

The first patch addresses presumably SMI interruptions, that occur
on my system at a 60 Hz frequency. They take too long, making the
existing code fail. The patch makes that code more resilient.
(These interruptions go away at some point during boot; also proven
by the fact, that I don't have any TSC issues, when kexecing into
a new kernel.)

The second patch prevents TSC going unstable when resuming from S3.
This may have a similar source, but is certainly more weird: the
TSC is observed to go backwards on CPU0 by about 200 to 500 cycles
compared to other CPUs every once in a while, as long as its sibling
(CPU16 in my case) hasn't been resumed yet. (I did some experiments
with CPU hotplug before and after suspend, but apart from reproducing
the issue and verifying the "fix", I got nowhere.)

The patches are against v4.20.

Jan H. Schönherr (2):
  x86/tsc: Allow quick PIT calibration despite interruptions
  cpu/hotplug: Unfreeze sibling CPU first on resume from S3

 arch/x86/kernel/tsc.c | 80 +++++++++++++++++++++++++------------------
 kernel/cpu.c          | 34 ++++++++++++------
 2 files changed, 70 insertions(+), 44 deletions(-)

-- 
2.19.2

