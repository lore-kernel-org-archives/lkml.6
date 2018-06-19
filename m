Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03304C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AB520874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AB520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937663AbeFSLYE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:24:04 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58098 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937497AbeFSLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:24:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fVEjx-0007LC-8w; Tue, 19 Jun 2018 05:24:01 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fVEjw-0002lN-Nd; Tue, 19 Jun 2018 05:24:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alistair Strachan <astrachan@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Date:   Tue, 19 Jun 2018 06:23:47 -0500
Message-ID: <87muvr58ak.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fVEjw-0002lN-Nd;;;mid=<87muvr58ak.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+CfGcmYnZ6HBXY0pg76mjilrQP93Se0EU=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] userns fixes for 4.17-rc2
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the userns-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-linus

   HEAD: 04035aa33a1258ca3c30f58138897ca3e97485f1 proc: Don't change mount options on remount failure.

Mount options for proc have been something of a mess since they were
added in the beginnging of 2012.  I compounded that in 2016 by merging
a change that in practice ignored the proc mount options except on remount.

Ordinarily noticing that in 2018 that had been broken for 2 years
without complaint I would think hmm "Can we just get rid of these
things".  Unfortunately it was someone who uses the proc hidepid option
that noticed this problem.  So fixed it must be.

I stared at this code for quite a while and I finally concluded that the
best course forward is to simply things and remove the internal kernel
mount of proc.  The internal mount of proc is directly responsible for
this regression and it has been the source of pain over the years.

The cost of this simplification is that proc_flush_task gains two more
atomic operations.

The upside is that proc is no longer special.  So following the same
idioms as filesystems will no longer be a problem.


While I was looking at the mount options of proc I found two more issues
that date back to the original change that added them.  A remount of
proc that fails did not return the proper error code.  A remount of proc
that fails could wind up changing the proc mount options.

I have personally tested all of these changed and verified everything
works correctly.  Alistair Strachan has tested and verified that
Android's use of proc's hidepid option works with this change.

I had hoped to let this sit a little longer in linux-next just in case
some of the build bots might turn up something I had missed.  But with
the parallel fscontext changes to proc that testing won't happen.

With linux-next useless, I figure the better part of valor is a pull
request that explains the reasons for this change and highlights the
subtle issues with mount option handling.  Hopefully something we can
solve with the new fscontext userspace API before it gets merged.


This also looks like time to revisit killing off sysctl syscall support.
I don't believe anyone compiles it into their kernel any more and
keeping the support made this change more difficult than necessary.

Eric W. Biederman (3):
      proc: Simplify and fix proc by removing the kernel mount
      proc: Change proc_parse_options to return an errno value
      proc: Don't change mount options on remount failure.

 arch/um/drivers/mconsole_kern.c |  4 +--
 fs/proc/base.c                  | 36 ++++++++++++++++++++-----
 fs/proc/inode.c                 | 17 +++++++++---
 fs/proc/internal.h              |  7 ++++-
 fs/proc/root.c                  | 58 ++++++++++++++++++++++-------------------
 include/linux/pid_namespace.h   |  3 +--
 include/linux/proc_ns.h         |  7 ++---
 kernel/pid.c                    |  8 ------
 kernel/pid_namespace.c          |  7 -----
 kernel/sysctl_binary.c          |  5 ++--
 10 files changed, 87 insertions(+), 65 deletions(-)

Eric
