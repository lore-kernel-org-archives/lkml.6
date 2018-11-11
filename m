Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA9C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F7920839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgCvcHsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F7920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbeKLJtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:49:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732407AbeKLISG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:06 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2732154B;
        Sun, 11 Nov 2018 22:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975290;
        bh=rL5qz7AD4gpCm6ohzUEYMAmxoVqqdrE6uI4vGYwGUlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgCvcHsWZvb8TGnLoUdzj6HtbI/ZkiYow2GlHrzNeOmvnjx1Ub9R6NBfX9NDJxwrL
         syOwaIZljF9GZ8MVjSnwwPfYG3tyDA662jtY3Vixwar9smQ9VSz3kxR1x+ZEwyMA8w
         XtmceX346wZ37mc5VYTzkOXB9YcVBsukeHo3CaCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Waiman Long <longman@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.19 231/361] selinux: fix mounting of cgroup2 under older policies
Date:   Sun, 11 Nov 2018 14:19:38 -0800
Message-Id: <20181111221651.548385501@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Smalley <sds@tycho.nsa.gov>

commit 7bb185edb0306bb90029a5fa6b9cff900ffdbf4b upstream.

commit 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
broke mounting of cgroup2 under older SELinux policies which lacked
a genfscon rule for cgroup2.  This prevents mounting of cgroup2 even
when SELinux is permissive.

Change the handling when there is no genfscon rule in policy to
just mark the inode unlabeled and not return an error to the caller.
This permits mounting and access if allowed by policy, e.g. to
unconfined domains.

I also considered changing the behavior of security_genfs_sid() to
never return -ENOENT, but the current behavior is relied upon by
other callers to perform caller-specific handling.

Fixes: 901ef845fa2469c ("selinux: allow per-file labeling for cgroupfs")
CC: <stable@vger.kernel.org>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Waiman Long <longman@redhat.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Tested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/hooks.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1508,6 +1508,11 @@ static int selinux_genfs_get_sid(struct
 		}
 		rc = security_genfs_sid(&selinux_state, sb->s_type->name,
 					path, tclass, sid);
+		if (rc == -ENOENT) {
+			/* No match in policy, mark as unlabeled. */
+			*sid = SECINITSID_UNLABELED;
+			rc = 0;
+		}
 	}
 	free_page((unsigned long)buffer);
 	return rc;


