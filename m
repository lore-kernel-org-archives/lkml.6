Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09300C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE851218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357735;
	bh=V3s5zsfz4RYDhik5aXErqGk+rcFZOP45EhvkrH2p8+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xXYZrNMh9M4/1L/HyCzNed8otTdGafdcXaZxG8QfiiNcu5J9zi4E2VzSkmV5fhfFR
	 v0h4cP1ggwInOfwGUBlzaoOxHWaDdJLrWh4Qm49j4RlvYuxvmQswxc7mMaucRvCtp5
	 8RAiiusc82OqWYTSmu5qyouL2WfLHqxMZqDrsJ5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfAXTWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:22:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbfAXTWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F5F7218D2;
        Thu, 24 Jan 2019 19:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357732;
        bh=V3s5zsfz4RYDhik5aXErqGk+rcFZOP45EhvkrH2p8+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7ePvaZrPc2978mmut5FLxxyB5G//1dI/anRBhY7FwAY5I3zAz3yBjZPztByIx6k/
         42gA8ogxfaz+905CuZnUln6/vI98tqLH2HibuN2DxGUKACCsWXOKMCLfwca8hBbWri
         1YTC2eeWKUOeUIInZtv000XGCZnaVX94Qgtw0+/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 3.18 20/52] Yama: Check for pid death before checking ancestry
Date:   Thu, 24 Jan 2019 20:19:44 +0100
Message-Id: <20190124190144.432295565@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -299,7 +299,9 @@ int yama_ptrace_access_check(struct task
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


