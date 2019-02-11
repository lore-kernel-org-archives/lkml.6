Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF3EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC6B20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896611;
	bh=n6S1hpzcezJSRZDPSXdItOB3/W4X91OZZ8V/hck5Sq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MeALzYusjkDjPR7PD8YRf1ebgSNxG1nUGPAY9fdUGJTBGE5xPwg5asX9G05cmyAwl
	 fwYwEz29vEpK4DFCk9IwQ3J2XhRwePgpFRmHhWuvv79aAFFtRvIimzFO3FKo8Kjm8R
	 2dL0vW7HLw8fUkdSvUbXFGFCynO3Nh6eYLVOBaFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfBKOuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733283AbfBKOuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785B82081B;
        Mon, 11 Feb 2019 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896607;
        bh=n6S1hpzcezJSRZDPSXdItOB3/W4X91OZZ8V/hck5Sq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lbbd6Lb17cIzTBDICDAhrRSFCvEd/YusJypgcmEK+iO+j1fFBjutnQCShjC6sGlEo
         Rizd9PfAQo8PjINuc/XW1J/FNHtiOAiz+BfF5vDhv2CTQmsJ0Vtj38pzR2YcLj7Woq
         MkZJgnzX8FXcOrFT8lvfbMS6j7SWyMkAJPBE4Eio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Gordon <bmgordon@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Stultz <john.stultz@linaro.org>,
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
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 240/313] fs/proc/base.c: use ns_capable instead of capable for timerslack_ns
Date:   Mon, 11 Feb 2019 15:18:40 +0100
Message-Id: <20190211141909.457022324@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 7e9f07bf260d..5bdcf2159ff0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2356,10 +2356,13 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
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
@@ -2392,11 +2395,14 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
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



