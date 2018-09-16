Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F6DECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2C020883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2C020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeIPX16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:27:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52563 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeIPX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:27:58 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bP4-0005bS-UT; Sun, 16 Sep 2018 12:04:14 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bP3-0001zy-QT; Sun, 16 Sep 2018 12:04:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87musyl3fa.fsf@xmission.com>
Date:   Sun, 16 Sep 2018 20:04:05 +0200
In-Reply-To: <87musyl3fa.fsf@xmission.com> (Eric W. Biederman's message of
        "Mon, 03 Sep 2018 22:41:13 +0200")
Message-ID: <87lg81pbe2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1bP3-0001zy-QT;;;mid=<87lg81pbe2.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19miy0OPcJ863e1x92Rofo7AoZUajx5bB8=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 0/4] signal: Cleanups
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


What follows are some small cleanups to signal handling functions that
arose from my previous work on sorting out signals during fork.

There are two cases where I did not previously mark functions
that sent signals to a group of processes.  It was safe because
they sent SIGKILL but it is still a good idea to mark that they send
signals to a group of processes to be consistent.

After that I just have the trivial cleanups of removing
specific_send_sig_info which confuses more than helps when I read the
code, and moving the exports of signal functions next to their
callers so that future cleanups are easier.

On my wish list is to continue this work and ensure all of the signal
sending functions are being used correctly and to reduce the set of
signal sending functions so that there is less confusion in how to use
them.

I took a quick look at limiting force_sig to only the callers
that use it to transmit a synchronous exception.  Unfortunately I
discovered that where there is one small bug there are others so those
use cases need something more than a brainless mass conversion to fix.

So I am first going to focus on finishing on cleaning up the signal
sending functions for exceptions that send siginfo.  I have just a few
architectures left and I just need to double check that I didn't do
anything stupid and post those changes for review.

If anyone sees any issues with these patches let me know.  Otherwise I
am going to merge them into my siginfo tree.

Eric W. Biederman (4):
      tty_io: Use group_send_sig_info in __do_SACK to note it is a session being killed
      signal: Use group_send_sig_info to kill all processes in a pid namespace
      signal: Remove specific_send_sig_info
      signal: Pair exports with their functions

 drivers/tty/tty_io.c   |  6 +++---
 kernel/pid_namespace.c |  2 +-
 kernel/signal.c        | 25 +++++++++----------------
 3 files changed, 13 insertions(+), 20 deletions(-)

Eric
