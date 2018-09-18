Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77758ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E17E214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E17E214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbeIRXPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:15:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42195 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeIRXPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:15:02 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2K00-0001Wd-Dy; Tue, 18 Sep 2018 11:41:20 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2Jzz-00087y-Ag; Tue, 18 Sep 2018 11:41:20 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Tue, 18 Sep 2018 19:41:09 +0200
Message-ID: <878t3yitze.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g2Jzz-00087y-Ag;;;mid=<878t3yitze.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19jzGgeTfH4WJC4sWTs9m1V31HoOdNn/7g=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 0/9] signal/powerpc: siginfo cleanups
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is the continuation of my work to sort out signaling of exceptions
with siginfo.  The old functions by passing siginfo resulted in many
cases of fields of siginfo that were not initialized and then passed to
userspace, and also resulted in callers getting confused and
initializing the wrong fields.  My remedy is to have specific functions
for sending each different kind of signal with siginfo.  Those functions
take the information needed to fill in siginfo and do the work
themselves.

This is my set of changes to update powerpc to use those functions.
Along with some refactoring so those functions can be cleanly used.

Folks please review and double check me.  I think I have kept these
changes simple and obviously correct but I am human and mess up
sometimes.

After these patches have had a chance to be reviewed I plan to merge
them by my siginfo tree.  If you would rather take them in the powerpc
tree let me know.   All of the prerequisites should have been merged
through Linus's tree several releases ago.

Eric W. Biederman (9):
      signal/powerpc: Use force_sig_mceerr as appropriate
      signal/powerpc: Remove pkey parameter from __bad_area
      signal/powerpc: Call _exception_pkey directly from bad_key_fault_exception
      signal/powerpc: Remove pkey parameter from __bad_area_nosemaphore
      signal/powerpc: Factor the common exception code into exception_common
      signal/powerpc: Call force_sig_fault from _exception
      signal/poewrpc: Specialize _exception_pkey for handling pkey exceptions
      signal/powerpc: Simplify _exception_pkey by using force_sig_pkuerr
      signal/powerpc: Use force_sig_fault where appropriate

 arch/powerpc/include/asm/bug.h            |  2 +-
 arch/powerpc/kernel/process.c             |  9 +----
 arch/powerpc/kernel/traps.c               | 27 ++++++++-------
 arch/powerpc/mm/fault.c                   | 55 +++++++++++++++++--------------
 arch/powerpc/platforms/cell/spu_base.c    |  4 +--
 arch/powerpc/platforms/cell/spufs/fault.c | 26 +++++----------
 6 files changed, 57 insertions(+), 66 deletions(-)

Eric
