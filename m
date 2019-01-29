Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A95E20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763636;
	bh=FGjDR4H0eK+SYPvN6fBSECxcBrr27RMRHaE7x039krY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w95KkUnXYBzSPoLmHaj0PWBN6sbjTlDGKHjqJBggUFgub7kgRQOna6BDbBlc2hnco
	 ytlbi9dq/gTMMuk8mgCT+xnPHjtdKFD58UQRpN63mxGrk6c0XQvKvDlN5b43WQwEWF
	 2gcy8i6W0cTd+GKfAOIyB1kLawxlOvXHIKL9YbIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfA2MHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbfA2Lka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 989692183F;
        Tue, 29 Jan 2019 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762030;
        bh=FGjDR4H0eK+SYPvN6fBSECxcBrr27RMRHaE7x039krY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQ/SSjqfbshsgU6cGEiYCeMO44aJfKqJd71WvxzUU1iW+F7NO9gLmRkwTJ8aX7MiV
         p7f1zrPGxJSdp3YE87NlucwnLd7pTQDULU/ZW/4S2FT6HRBN4YrIFsNvcZen/1yGV1
         9Q94XOy/TltcN5r/HOvbhda5luUoL5p9k7neyxbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.20 084/117] posix-cpu-timers: Unbreak timer rearming
Date:   Tue, 29 Jan 2019 12:35:35 +0100
Message-Id: <20190129113211.626933928@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 93ad0fc088c5b4631f796c995bdd27a082ef33a6 upstream.

The recent commit which prevented a division by 0 issue in the alarm timer
code broke posix CPU timers as an unwanted side effect.

The reason is that the common rearm code checks for timer->it_interval
being 0 now. What went unnoticed is that the posix cpu timer setup does not
initialize timer->it_interval as it stores the interval in CPU timer
specific storage. The reason for the separate storage is historical as the
posix CPU timers always had a 64bit nanoseconds representation internally
while timer->it_interval is type ktime_t which used to be a modified
timespec representation on 32bit machines.

Instead of reverting the offending commit and fixing the alarmtimer issue
in the alarmtimer code, store the interval in timer->it_interval at CPU
timer setup time so the common code check works. This also repairs the
existing inconistency of the posix CPU timer code which kept a single shot
timer armed despite of the interval being 0.

The separate storage can be removed in mainline, but that needs to be a
separate commit as the current one has to be backported to stable kernels.

Fixes: 0e334db6bb4b ("posix-timers: Fix division by zero bug")
Reported-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190111133500.840117406@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/posix-cpu-timers.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -685,6 +685,7 @@ static int posix_cpu_timer_set(struct k_
 	 * set up the signal and overrun bookkeeping.
 	 */
 	timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
+	timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
 
 	/*
 	 * This acts as a modification timestamp for the timer,


