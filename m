Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96265C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6341E2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440107AbfBNU4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:56:36 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:33353 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390238AbfBNU4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:56:35 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1guO3d-00073T-DU; Thu, 14 Feb 2019 13:56:34 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1guO3c-00086T-UM; Thu, 14 Feb 2019 13:56:33 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Ivan Delalande <colona@arista.com>
Date:   Thu, 14 Feb 2019 14:56:25 -0600
Message-ID: <87pnru2io6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1guO3c-00086T-UM;;;mid=<87pnru2io6.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+1zpZyurL9x/uPYNxozoToAjngiglKhoE=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] signal fixes for v5.0-rc7
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD:cf43a757fd49442bc38f76088b70c2299eed2c2f signal: Restore the stop PTRACE_EVENT_EXIT

This includes just a single patch that restores PTRACE_EVENT_EXIT
functionality that was accidentally broken by last weeks fixes.

diff --git a/kernel/signal.c b/kernel/signal.c
index 99fa8ff06fd9..57b7771e20d7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2436,9 +2436,12 @@ relock:
        }
 
        /* Has this task already been marked for death? */
-       ksig->info.si_signo = signr = SIGKILL;
-       if (signal_group_exit(signal))
+       if (signal_group_exit(signal)) {
+               ksig->info.si_signo = signr = SIGKILL;
+               sigdelset(&current->pending.signal, SIGKILL);
+               recalc_sigpending();
                goto fatal;
+       }
 
        for (;;) {
                struct k_sigaction *ka;
