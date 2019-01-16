Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A32C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959C720866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oc+Zg9qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfAPSbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:31:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42277 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbfAPSbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:31:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so3182615pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dHSazQ7qGm2UKIzzWog2IYg+72OPhXPfMJM+TsIBw6g=;
        b=oc+Zg9qcwExCefgBVQow/0OPvZrOxpfIcZvPTxksMyF90W8LF+6GOyjKGCdvgmJ12Q
         jzKxp/kb7S4ZMWNM62beUsxiJfgkAm45XtHaen6iTR4nsvRCWwMMzEDRj4gjL0YGobPw
         hX9u4qUWL0PLptWpT8icrFMYvigBZfY+qLs3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dHSazQ7qGm2UKIzzWog2IYg+72OPhXPfMJM+TsIBw6g=;
        b=VjSDWy9pG0tw8Tq/iGkgaZxkOiLxW/9KN9n1dQxlD5MVrYZH6xSThK7Uo+wwg/1hyt
         jTly3IeNn1ZM2YpNZjeWEmHxyecbcMovdc882AGepaMCQnbgEWTWt3B5HoswJjAmHVcd
         Ir8cxRINIkbkKAqaeKXlnOcyTkOp9M9GOOR8YGO76LRUnnPpvGZRieKaQLxow0IuFVhp
         cJa7WumclQVka+kuQ3g3oDg4VNxYMyTk7GSyfR13gQc6XeuiS8IPbNLG0fUcRT6oQyhD
         4CrvRJ1pwZxykWAo0R/ILM9g5nAeZf/QD041lVk9BQfd2GC6LPdWDv1iBdEyJQjPzpAb
         XVFQ==
X-Gm-Message-State: AJcUukfRrQYuh4yFyg4l/2G4keRcrFpvlsc5tBLOQEUns8AT9gr9J0hR
        dvzA8YHvBPILAdtyuvhU75HODw==
X-Google-Smtp-Source: ALg8bN6+uVFaQoD6XHZsdht80UFBlRjUJK3eIohahgUokfNwQYcjryhsNsFyFJut7DcwqlRhK8Fo5A==
X-Received: by 2002:a63:2784:: with SMTP id n126mr10315231pgn.48.1547663471587;
        Wed, 16 Jan 2019 10:31:11 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 184sm9071194pfe.106.2019.01.16.10.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 10:31:10 -0800 (PST)
Date:   Wed, 16 Jan 2019 10:31:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] Yama: Check for pid death before checking ancestry
Message-ID: <20190116183109.GA21722@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that a pid has died before we take the rcu lock, in which
case we can't walk the ancestry list as it may be detached. Instead, check
for death first before doing the walk.

Reported-by: syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com
Fixes: 2d514487faf1 ("security: Yama LSM")
Cc: stable@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
James, can you please send this to Linus in your -fixes tree?
---
 security/yama/yama_lsm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..02514fe558b4 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -368,7 +368,9 @@ static int yama_ptrace_access_check(struct task_struct *child,
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
-- 
2.17.1


-- 
Kees Cook
