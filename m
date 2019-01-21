Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7FC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5334A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078903;
	bh=Zn15jCNdKS36PgQUdgBWv/F88tomBwup5MGXK0KCGic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rpWoKvhZeOPV80IwqsWp+kdgSjhNiTEIWStUfPv8e7pndBppsrnY/BQPbjS+owhDa
	 eQERgyqLeXvfNzKZSLfpczaW65eevo2mdOckYmcdXHh1WG2SXLcjiyRdY/lM5SYK+C
	 OwolT7We9TC0Y4X303OVnzAXkkzeAV9xPbGA6MhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfAUNzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:55:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbfAUNy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:54:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B4E20861;
        Mon, 21 Jan 2019 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078898;
        bh=Zn15jCNdKS36PgQUdgBWv/F88tomBwup5MGXK0KCGic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Is7e8i+qUeCfX3id7k97kO+yjCCiy+o15QTbpoeTYvy+gIQdteb+vfrzAyFqrwOZe
         9KY1qWdGKYYAx3nAWhCcJBi2/VPn6fqJi2QROe3pH4weE7ODVYvOWFZJg1jXt7O/PO
         xSyflYt5S8/C6EpsR5V0OnyyHVqmubo3sifxGPwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.9 22/51] Yama: Check for pid death before checking ancestry
Date:   Mon, 21 Jan 2019 14:44:18 +0100
Message-Id: <20190121122455.586108864@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -359,7 +359,9 @@ static int yama_ptrace_access_check(stru
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


