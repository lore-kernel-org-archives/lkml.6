Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE726ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBA1214FA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBA1214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeIRFdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:33:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45945 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIRFdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:33:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23UG-00042Y-RY; Mon, 17 Sep 2018 18:03:28 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g23U0-0002U9-Cj; Mon, 17 Sep 2018 18:03:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Date:   Tue, 18 Sep 2018 02:03:04 +0200
Message-ID: <87y3bzk6yv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g23U0-0002U9-Cj;;;mid=<87y3bzk6yv.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Z0IrVx9VkDUPWrN7K+HAfp7DFbIPHvmU=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 00/20] siginfo cleanups for x86
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have been slowly going thought and reworking the arch specific
functions that generate siginfo.  The problems I have been addressing
is that using siginfo directly is error prone.  Using siginfo directly
makes it easy to leave fields initialized, and get confused about
which fields need to be filled in.

To address this I have added a series of helper functions to
kernel/signal.c, that are specific to exactly one use of struct siginfo
and take the parameters they need.

To use these functions the x86 signal handling needs some cleanups but
the net result appears to be less code that is easier to follow.

If while looking over these patches you see anything please let me know.
I don't think I missed something but to err is human.

Likewise if you would like to merge these patches via the tip tree
let me know.  Otherwise after the review is complete I plan on merging
these into my siginfo tree.  At this point I believe all of the
prerequisite patches are merged so it should not make a difference.

Eric W. Biederman (20):
      signal: Simplify tracehook_report_syscall_exit
      signal/x86: Inline fill_sigtrap_info in it's only caller send_sigtrap
      signal/x86: Move MCE error reporting out of force_sig_info_fault
      signal/x86: Use send_sig_mceerr as apropriate
      signal/x86: In trace_mpx_bounds_register_exception add __user annotations
      signal/x86: Move mpx siginfo generation into do_bounds
      signal/x86/traps: Factor out show_signal
      signal/x86/traps: Move setting error_code and trap_nr into do_trap_no_signal
      signal/x86/traps: Use force_sig_bnderr
      signal/x86/traps: Use force_sig instead of open coding it.
      signal/x86/traps: Simplify trap generation
      signal/x86: Remove pkey parameter from bad_area_nosemaphore
      signal/x86: Remove the pkey parameter from do_sigbus
      signal/x86: Remove pkey parameter from mm_fault_error
      signal/x86: Don't compute pkey in __do_page_fault
      signal/x86: Pass pkey not vma into __bad_area
      signal/x86: Call force_sig_pkuerr from __bad_area_nosemaphore
      signal/x86: Replace force_sig_info_fault with force_sig_fault
      signal/x86: Pass pkey by value
      signal/x86: Use force_sig_fault where appropriate

 arch/powerpc/include/asm/ptrace.h     |   2 +-
 arch/powerpc/kernel/traps.c           |   7 +-
 arch/x86/entry/vsyscall/vsyscall_64.c |   9 +-
 arch/x86/include/asm/mpx.h            |  13 ++-
 arch/x86/include/asm/ptrace.h         |   2 +-
 arch/x86/include/asm/trace/mpx.h      |   4 +-
 arch/x86/kernel/ptrace.c              |  29 ++----
 arch/x86/kernel/traps.c               | 175 ++++++++++++++--------------------
 arch/x86/kernel/umip.c                |   8 +-
 arch/x86/kvm/mmu.c                    |  11 +--
 arch/x86/mm/fault.c                   | 161 +++++++++++--------------------
 arch/x86/mm/mpx.c                     |  30 ++----
 include/linux/ptrace.h                |  17 ++--
 include/linux/tracehook.h             |  13 +--
 14 files changed, 175 insertions(+), 306 deletions(-)

Eric
