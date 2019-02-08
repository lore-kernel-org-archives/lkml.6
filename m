Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798B6C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530822086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfBHPwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:52:15 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:47516 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfBHPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:52:15 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gs8Rp-0005oy-Fh; Fri, 08 Feb 2019 08:52:13 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gs8Ro-0005xw-Ph; Fri, 08 Feb 2019 08:52:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jack Andersen <jackoalan@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 08 Feb 2019 09:52:02 -0600
Message-ID: <87mun6nuql.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gs8Ro-0005xw-Ph;;;mid=<87mun6nuql.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18I5WzSLM41dBqsahEDzZTFsYFUFoprah4=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] signal fixes for v5.0-rc6
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD:7146db3317c67b517258cb5e1b08af387da0618b signal: Better detection of synchronous signals

This contains 4 small fixes for signal handling.  A missing range check,
a regression fix, prioritizing signals we have already started a signal
group exit for, and better detection of synchronous signals.

The confused decision of which signals to handle failed spectacularly
when a timer was pointed at SIGBUS and the stack overflowed.  Resulting
in an unkillable process in an infinite loop instead of a SIGSEGV and
core dump.

Eric W. Biederman (4):
      signal: Make siginmask safe when passed a signal of 0
      signal: Always attempt to allocate siginfo for SIGSTOP
      signal: Always notice exiting tasks
      signal: Better detection of synchronous signals

 include/linux/signal.h |  2 +-
 kernel/signal.c        | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 60 insertions(+), 5 deletions(-)

Eric
