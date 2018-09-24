Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E72C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEA620C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEA620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeIXUXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:23:07 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33259 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeIXUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:23:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4RjA-0005oT-Vo; Mon, 24 Sep 2018 08:20:45 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4Rj9-0004mX-J9; Mon, 24 Sep 2018 08:20:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, linux-ia64@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Date:   Mon, 24 Sep 2018 16:20:32 +0200
Message-ID: <87bm8n2czz.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g4Rj9-0004mX-J9;;;mid=<87bm8n2czz.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19m0iMnff8AhqdBvLu3QZDRZElg/J8m/M4=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 0/3] signal/ia64: siginfo fixes and cleanups
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have been slowly cleaning up the architectues ever since I discovered
that the pattern of passing in struct siginfo is error prone, and
occassionally results in borken siginfo being sent to userspace.

It turns out that ia64 is one of the noticable offenders.  Ever since
ia64 was merged in 2.3.43 it has been generating incorrect siginfo for
SIGSEGV assocaited with the inability to setup a signal stack frame
or cleanup a signal stack frame.

This is pretty esoteric case and the problem was only some values that
should be 0 being something else so I am not surpised it was missed.

The following series fixes the two buggy cases I have found and then
cleans up replaces force_sig_info with force_sig_fault to avoid errors
of this kind in the future.

I don't think I have made made any mistakes in this coversion but if
people can look the code over and see if they can spot anything I would
appreciate it.

My intention is to merge this through my siginfo tree.  If you feel it
should go through your arch tree let me know.   All of the prerequisites
should have been merged several releases ago.

Eric W. Biederman (3):
      signal/ia64: Use the generic force_sigsegv in setup_frame
      signal/ia64: Use the force_sig(SIGSEGV,...) in ia64_rt_sigreturn
      signal/ia64: Use force_sig_fault where appropriate

 arch/ia64/kernel/brl_emu.c   |  31 ++--------
 arch/ia64/kernel/signal.c    |  60 ++++--------------
 arch/ia64/kernel/traps.c     | 144 ++++++++++++-------------------------------
 arch/ia64/kernel/unaligned.c |  12 +---
 arch/ia64/mm/fault.c         |  12 +---
 5 files changed, 62 insertions(+), 197 deletions(-)

Eric
