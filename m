Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39E6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0B821480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 04:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0B821480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbeHPG7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:59:45 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51899 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeHPG7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:59:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fq9W9-0000Bi-S9; Wed, 15 Aug 2018 22:04:13 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fq9W8-0007qt-Ni; Wed, 15 Aug 2018 22:04:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        syzkaller-bugs@googlegroups.com
References: <87efft5ncd.fsf_-_@xmission.com>
        <20180724032419.20231-7-ebiederm@xmission.com>
Date:   Wed, 15 Aug 2018 23:04:07 -0500
In-Reply-To: <20180724032419.20231-7-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Mon, 23 Jul 2018 22:24:06 -0500")
Message-ID: <87k1orgdoo.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fq9W8-0007qt-Ni;;;mid=<87k1orgdoo.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19TnmHwQUgw4yG/xm+8Y/6VKDs2RH+VveM=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH] signal: Don't send signals to tasks that don't exist
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently syzbot reported crashes in send_sigio_to_task and
send_sigurg_to_task in linux-next.  Despite finding a reproducer
syzbot apparently did not bisected this or otherwise track down the
offending commit in linux-next.

I happened to see this report and examined the code because I had
recently changed these functions as part of making PIDTYPE_TGID a real
pid type so that fork would does not need to restart when receiving a
signal.  By examination I see that I spotted a bug in the code
that could explain the reported crashes.

When I took Oleg's suggestion and optimized send_sigurg and send_sigio
to only send to a single task when type is PIDTYPE_PID or PIDTYPE_TGID
I failed to handle pids that no longer point to tasks.  The macro
do_each_pid_task simply iterates for zero iterations.  With pid_task
an explicit NULL test is needed.

Update the code to include the missing NULL test.

Fixes: 019191342fec ("signal: Use PIDTYPE_TGID to clearly store where file signals will be sent")
Reported-by: syzkaller-bugs@googlegroups.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fcntl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index a04accf6847f..4137d96534a6 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -791,7 +791,8 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 	if (type <= PIDTYPE_TGID) {
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
-		send_sigio_to_task(p, fown, fd, band, type);
+		if (p)
+			send_sigio_to_task(p, fown, fd, band, type);
 		rcu_read_unlock();
 	} else {
 		read_lock(&tasklist_lock);
@@ -830,7 +831,8 @@ int send_sigurg(struct fown_struct *fown)
 	if (type <= PIDTYPE_TGID) {
 		rcu_read_lock();
 		p = pid_task(pid, PIDTYPE_PID);
-		send_sigurg_to_task(p, fown, type);
+		if (p)
+			send_sigurg_to_task(p, fown, type);
 		rcu_read_unlock();
 	} else {
 		read_lock(&tasklist_lock);
-- 
2.17.1

