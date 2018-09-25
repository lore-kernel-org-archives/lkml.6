Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACE5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC9F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC9F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeIYX2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:28:24 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60785 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeIYX2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:28:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r07-0000Xd-3w; Tue, 25 Sep 2018 11:19:55 -0600
Received: from [105.184.227.67] (helo=x220.Home)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4r06-0001uD-0y; Tue, 25 Sep 2018 11:19:54 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 25 Sep 2018 19:19:02 +0200
Message-Id: <20180925171906.19683-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87h8idv6nw.fsf@xmission.com>
References: <87h8idv6nw.fsf@xmission.com>
X-XM-SPF: eid=1g4r06-0001uD-0y;;;mid=<20180925171906.19683-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Vj4CgC0WrCxvJmB02LgyOu8MWo/KdEDs=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 2/6] signal: Fail sigqueueinfo if si_signo != sig
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel needs to validate that the contents of struct siginfo make
sense as siginfo is copied into the kernel, so that the proper union
members can be put in the appropriate locations.  The field si_signo
is a fundamental part of that validation.  As such changing the
contents of si_signo after the validation make no sense and can result
in nonsense values in the kernel.

As such simply fail if someone is silly enough to set si_signo out of
sync with the signal number passed to sigqueueinfo.

I don't expect a problem as glibc's sigqueue implementation sets
"si_signo = sig" and CRIU just returns to the kernel what the kernel
gave to it.

If there is some application that calls sigqueueinfo directly that has
a problem with this added sanity check we can revisit this when we see
what kind of crazy that application is doing.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 7b49c31d3fdb..e445b0a63faa 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3306,7 +3306,8 @@ static int do_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t *info)
 	    (task_pid_vnr(current) != pid))
 		return -EPERM;
 
-	info->si_signo = sig;
+	if (info->si_signo != sig)
+		return -EINVAL;
 
 	/* POSIX.1b doesn't mention process groups.  */
 	return kill_proc_info(sig, info, pid);
@@ -3354,7 +3355,8 @@ static int do_rt_tgsigqueueinfo(pid_t tgid, pid_t pid, int sig, siginfo_t *info)
 	    (task_pid_vnr(current) != pid))
 		return -EPERM;
 
-	info->si_signo = sig;
+	if (info->si_signo != sig)
+		return -EINVAL;
 
 	return do_send_specific(tgid, pid, sig, info);
 }
-- 
2.17.1

