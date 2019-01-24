Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD008C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A020218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357961;
	bh=jVn0Q5RodvRQmDLJgakOPbwwNp4Rl4FFNWLh6z/3LQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FEmCzyS5xi6CZm5a0AAujub3Ggw0JwhMvmQZR4BvC5+ugJpwB8/sibheO6m93Jsgq
	 k0S7sewamG1V+UxeM1p3tk87fW6pidk5zfW8R5F3IM8dDTONQK1HytOhqfLzGMCpE7
	 mg+8iSM6/a/J6XrKkP+D39Bgc1QCxaH0hlx2DPhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfAXT0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:26:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbfAXTZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706FF217D7;
        Thu, 24 Jan 2019 19:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357955;
        bh=jVn0Q5RodvRQmDLJgakOPbwwNp4Rl4FFNWLh6z/3LQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8li1EO8OO/QdEgXXkMmK7E2ksJN4BTbdy5eRM5zxNnkzNXU9ZEtBbu0MUKaovza8
         rahpngH//J0IpuAWqwY8tFf5Shag7JXUQdl/etYg4Bb8QP6LwW0TuLDQ2Kilh1apzL
         lT/4kH6IJMeohuc7AZVgb0DVypN+OjP1lt3LuNqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.4 049/104] Yama: Check for pid death before checking ancestry
Date:   Thu, 24 Jan 2019 20:19:38 +0100
Message-Id: <20190124190201.140687919@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 9474f4e7cd71a633fa1ef93b7daefd44bbdfd482 upstream.

It's possible that a pid has died before we take the rcu lock, in which
case we can't walk the ancestry list as it may be detached. Instead, check
for death first before doing the walk.

Reported-by: syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com
Fixes: 2d514487faf1 ("security: Yama LSM")
Cc: stable@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/yama/yama_lsm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -288,7 +288,9 @@ static int yama_ptrace_access_check(stru
 			break;
 		case YAMA_SCOPE_RELATIONAL:
 			rcu_read_lock();
-			if (!task_is_descendant(current, child) &&
+			if (!pid_alive(child))
+				rc = -EPERM;
+			if (!rc && !task_is_descendant(current, child) &&
 			    !ptracer_exception_found(current, child) &&
 			    !ns_capable(__task_cred(child)->user_ns, CAP_SYS_PTRACE))
 				rc = -EPERM;


