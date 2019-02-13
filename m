Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692DAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEDC222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083498;
	bh=xVJBuDf6p754DYRJtacnpKR/3TIEEvUQtRdhtVGejdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zbBbSw9255WG0rFv2tv/OlbfsV/fIoTAefmahoSMuDVp2Yz16wbQ0la8H1Q4C/Hf1
	 FPdh100niikgVRtj1BPNhjBbh77X/ISeeWbi/OZq3ysWIgZX0440x8NNlobq4r6NA/
	 E0TexXy0avIVXR8gSSEdfJ1w17yG/PrrQaouPG98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394026AbfBMSo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388313AbfBMSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431A4222D3;
        Wed, 13 Feb 2019 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083493;
        bh=xVJBuDf6p754DYRJtacnpKR/3TIEEvUQtRdhtVGejdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IlLUpUFtI8iMYHF8/LhQnyTJHQHWPwpHTMGQNCk24SnDrwPwfP5DgceD8q622nPWU
         OKmW5qzWGwOWR5MHvudIP3l8Alb2FVMS2uMIVnvS200kQxEIo5DQ9OK7VWF/5tnypr
         nYJAkKamIejP3yS7Vr0cuXdKiVa8w4auhbRWk/VQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.20 11/50] signal: Always notice exiting tasks
Date:   Wed, 13 Feb 2019 19:38:16 +0100
Message-Id: <20190213183656.733725215@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 35634ffa1751b6efd8cf75010b509dcb0263e29b upstream.

Recently syzkaller was able to create unkillablle processes by
creating a timer that is delivered as a thread local signal on SIGHUP,
and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop
failing to deliver SIGHUP but always trying.

Upon examination it turns out part of the problem is actually most of
the solution.  Since 2.5 signal delivery has found all fatal signals,
marked the signal group for death, and queued SIGKILL in every threads
thread queue relying on signal->group_exit_code to preserve the
information of which was the actual fatal signal.

The conversion of all fatal signals to SIGKILL results in the
synchronous signal heuristic in next_signal kicking in and preferring
SIGHUP to SIGKILL.  Which is especially problematic as all
fatal signals have already been transformed into SIGKILL.

Instead of dequeueing signals and depending upon SIGKILL to
be the first signal dequeued, first test if the signal group
has already been marked for death.  This guarantees that
nothing in the signal queue can prevent a process that needs
to exit from exiting.

Cc: stable@vger.kernel.org
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Ref: ebf5ebe31d2c ("[PATCH] signal-fixes-2.5.59-A4")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/signal.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2393,6 +2393,11 @@ relock:
 		goto relock;
 	}
 
+	/* Has this task already been marked for death? */
+	ksig->info.si_signo = signr = SIGKILL;
+	if (signal_group_exit(signal))
+		goto fatal;
+
 	for (;;) {
 		struct k_sigaction *ka;
 
@@ -2488,6 +2493,7 @@ relock:
 			continue;
 		}
 
+	fatal:
 		spin_unlock_irq(&sighand->siglock);
 
 		/*


