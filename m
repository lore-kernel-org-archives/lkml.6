Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED82C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742C520862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742C520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeGaIm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:42:59 -0400
Received: from nov-007-i652.relay.mailchannels.net ([46.232.183.206]:30605
        "EHLO nov-007-i652.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbeGaIm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:42:58 -0400
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 986A91B6027D;
        Tue, 31 Jul 2018 07:04:03 +0000 (UTC)
Received: from srv17.tophost.ch (swiss-ingress-2.mailchannels.ch [46.232.183.6])
        by relay.mailchannels.net (Postfix) with ESMTPA id 7F11E1B60282;
        Tue, 31 Jul 2018 07:04:00 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Tue, 31 Jul 2018 07:04:03 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Print-Stop: 6430aced53d64932_1533020643175_615042603
X-MC-Loop-Signature: 1533020643175:205961080
X-MC-Ingress-Time: 1533020643175
Received: from [80.219.231.201] (port=42542 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA256:128)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1fkOhK-009EZM-0v; Tue, 31 Jul 2018 09:03:58 +0200
From:   =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH v2] prctl: add PR_[GS]ET_KILLABLE
Date:   Tue, 31 Jul 2018 09:03:37 +0200
Message-Id: <20180731070337.61004-1-j@bitron.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180730075241.24002-1-j@bitron.ch>
References: <20180730075241.24002-1-j@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PR_SET_KILLABLE clears the SIGNAL_UNKILLABLE flag. This allows
CLONE_NEWPID tasks to restore normal signal behavior, opting out of the
special signal protection for init processes. This prctl does not allow
setting the SIGNAL_UNKILLABLE flag, only clearing.

The SIGNAL_UNKILLABLE flag, which is implicitly set for tasks cloned
with CLONE_NEWPID, has the effect of ignoring all signals (from
userspace) if the corresponding handler is set to SIG_DFL. The only
exceptions are SIGKILL and SIGSTOP and they are only accepted if raised
from an ancestor namespace.

SIGINT, SIGQUIT and SIGTSTP are used in job control for ^C, ^\, ^Z.
While a task with the SIGNAL_UNKILLABLE flag could install handlers for
these signals, this is not sufficient to implement a shell that uses
CLONE_NEWPID for child processes:

 * As SIGSTOP is ignored when raised from the SIGNAL_UNKILLABLE process
   itself, it's not possible to implement the stop action in a custom
   SIGTSTP handler.
 * Many applications do not install handlers for these signals and
   thus, job control won't work properly with unmodified applications.

There are other scenarios besides job control in a shell where
applications rely on the default actions as described in signal(7) and
PID isolation may be useful. This new prctl makes the signal protection
for "init" processes optional, without breaking backward compatibility.

Signed-off-by: Jürg Billeter <j@bitron.ch>
---
 v2: Hold siglock for PR_SET_KILLABLE, expand commit message.

 include/uapi/linux/prctl.h |  4 ++++
 kernel/sys.c               | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c0d7ea0bf5b6..92afb63da727 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -219,4 +219,8 @@ struct prctl_mm_map {
 # define PR_SPEC_DISABLE		(1UL << 2)
 # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
 
+/* Control SIGNAL_UNKILLABLE */
+#define PR_GET_KILLABLE			54
+#define PR_SET_KILLABLE			55
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 38509dc1f77b..92c9322cfb98 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2484,6 +2484,19 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
 		break;
+	case PR_GET_KILLABLE:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = put_user(!(me->signal->flags & SIGNAL_UNKILLABLE),
+				 (int __user *)arg2);
+		break;
+	case PR_SET_KILLABLE:
+		if (arg2 != 1 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		spin_lock_irq(&me->sighand->siglock);
+		me->signal->flags &= ~SIGNAL_UNKILLABLE;
+		spin_unlock_irq(&me->sighand->siglock);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.18.0

