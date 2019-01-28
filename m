Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A44C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E042082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693700;
	bh=jYmlpZDzwro/F6EmfSud0gR4DJHQLc7HMP53JSW4liU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XxS2u5tAjHg962XZM8bNjXhYh2N23nRCZM8hUMfnAK/x7PUHoPyX7RHN9gmAyxCSw
	 UzgGShxU2ADRo4ls9RP9j8KQ7qTF7zQOd+vbylNbxAlVsAR9LJwAszFV9vML8Vb1zH
	 vk7V+6kbaiUM7yKd+M27e28eAibKFsu2CsT+w/p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbfA1Qli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389553AbfA1QXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E97942147A;
        Mon, 28 Jan 2019 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692633;
        bh=jYmlpZDzwro/F6EmfSud0gR4DJHQLc7HMP53JSW4liU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vlCxMpCDDOsvqbDTbhY8FU+xNV8WIrx7mKFYp4bwMvtycaA0dYExRaojAonmCXsCs
         1WJZjZOpbhiCkYvi61V8T8KIltleobrKyzKpEV4zAYwgPgqx5yBi5e2Qz6LJex1piK
         V3YwWxP6R3VXNadsX8twvRapPVwmEytCDbhlPJnY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Gordon <bmgordon@google.com>,
        John Stultz <john.stultz@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Oren Laadan <orenl@cellrox.com>,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Rom Lemarchand <romlem@android.com>,
        Todd Kjos <tkjos@google.com>, Colin Cross <ccross@android.com>,
        Nick Kralevich <nnk@google.com>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Elliott Hughes <enh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 103/107] fs/proc/base.c: use ns_capable instead of capable for timerslack_ns
Date:   Mon, 28 Jan 2019 11:19:43 -0500
Message-Id: <20190128161947.57405-103-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gordon <bmgordon@google.com>

[ Upstream commit 8da0b4f692c6d90b09c91f271517db746a22ff67 ]

Access to timerslack_ns is controlled by a process having CAP_SYS_NICE
in its effective capability set, but the current check looks in the root
namespace instead of the process' user namespace.  Since a process is
allowed to do other activities controlled by CAP_SYS_NICE inside a
namespace, it should also be able to adjust timerslack_ns.

Link: http://lkml.kernel.org/r/20181030180012.232896-1-bmgordon@google.com
Signed-off-by: Benjamin Gordon <bmgordon@google.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Oren Laadan <orenl@cellrox.com>
Cc: Ruchi Kandoi <kandoiruchi@google.com>
Cc: Rom Lemarchand <romlem@android.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Colin Cross <ccross@android.com>
Cc: Nick Kralevich <nnk@google.com>
Cc: Dmitry Shmidt <dimitrysh@google.com>
Cc: Elliott Hughes <enh@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/base.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 79702d405ba7..f73de326c630 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2337,10 +2337,13 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
 		return -ESRCH;
 
 	if (p != current) {
-		if (!capable(CAP_SYS_NICE)) {
+		rcu_read_lock();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
+			rcu_read_unlock();
 			count = -EPERM;
 			goto out;
 		}
+		rcu_read_unlock();
 
 		err = security_task_setscheduler(p);
 		if (err) {
@@ -2373,11 +2376,14 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
 		return -ESRCH;
 
 	if (p != current) {
-
-		if (!capable(CAP_SYS_NICE)) {
+		rcu_read_lock();
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
+			rcu_read_unlock();
 			err = -EPERM;
 			goto out;
 		}
+		rcu_read_unlock();
+
 		err = security_task_getscheduler(p);
 		if (err)
 			goto out;
-- 
2.19.1

