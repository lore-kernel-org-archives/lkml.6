Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DECECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C1720883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C1720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeIPX3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:29:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51485 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeIPX3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:29:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bQF-0007ZC-Jl; Sun, 16 Sep 2018 12:05:27 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bQE-00027D-IF; Sun, 16 Sep 2018 12:05:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87musyl3fa.fsf@xmission.com> <87lg81pbe2.fsf@xmission.com>
Date:   Sun, 16 Sep 2018 20:05:18 +0200
In-Reply-To: <87lg81pbe2.fsf@xmission.com> (Eric W. Biederman's message of
        "Sun, 16 Sep 2018 20:04:05 +0200")
Message-ID: <87a7ohpbc1.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1bQE-00027D-IF;;;mid=<87a7ohpbc1.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HQUtu4hY230D4an2XKjCMG++2Jm7Xv0U=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 2/4] signal: Use group_send_sig_info to kill all processes in a pid namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Replace send_sig_info in zap_pid_ns_processes with
group_send_sig_info.  This makes more sense as the entire process
group is being killed.  More importantly this allows the kill of those
processes with PIDTYPE_MAX to indicate all of the process in the pid
namespace are being signaled.  This is needed for fork to detect when
signals are sent to a group of processes.

Admittedly fork has another case to catch SIGKILL but the principle remains
that it is desirable to know when a group of processes is being signaled.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/pid_namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index c8d53397bbdd..aa6e72fb7c08 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -216,7 +216,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	idr_for_each_entry_continue(&pid_ns->idr, pid, nr) {
 		task = pid_task(pid, PIDTYPE_PID);
 		if (task && !__fatal_signal_pending(task))
-			send_sig_info(SIGKILL, SEND_SIG_PRIV, task);
+			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
 	}
 	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
-- 
2.17.1

